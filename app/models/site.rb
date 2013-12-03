require 'fileutils'
require 'haml'
require 'yaml'

class Site < ActiveRecord::Base
  belongs_to :user
  has_many :pages, dependent: :destroy

  after_update do
    #template
    if self.type_site == "blog"
      self.generate_template "blog", "layout/default.html.haml", "_layouts/default.html"
      self.generate_template "blog", "layout/post.html.haml", "_layouts/post.html"
      self.generate_template "blog", "index.html.haml", "index.html"

      self.write_config_blog_for_test_public
    end
    self.browse_pages
    self.build
  end

  after_create do
    site_dir_user_path = File.join(ENV['PATH_SITES'], self.user_id.to_s)
    FileUtils.mkdir_p site_dir_user_path unless File.directory?(site_dir_user_path)

    unless File.directory?(self.path_for_site)
      Dir.chdir(site_dir_user_path) do
        %x[jekyll new #{self.dir_name_site}]
      end
    end

    #template
    if self.type_site == "blog"
      self.generate_template "blog", "layout/default.html.haml", "_layouts/default.html"
      self.generate_template "blog", "layout/post.html.haml", "_layouts/post.html"
      self.generate_template "blog", "index.html.haml", "index.html"

      self.write_config_blog_for_test_public
    end
    self.browse_pages
    self.build

  end

  after_destroy do
    FileUtils.rm_rf self.path_for_site 
  end

  def to_s
    "#{type_site}::#{name}"
  end

  def generate_template name_templates, source_file_name, file_name
    path_to_template = ENV['PATH_TEMPLATE']
    blog_path = File.join(path_to_template, name_templates)

    default_template_path = File.join(blog_path,  source_file_name)
    erb_string = File.open(default_template_path).read
    #
    #Converts erb to haml
    haml_string = Haml::Engine.new(erb_string, :erb => true).render

    #Writes the haml
    f = File.new(File.join(self.path_for_site, file_name), "w") 
    f.write(haml_string)
    f.close 
  end

  def config
    YAML.load_file(File.join(self.path_for_site, '_config.yml'))
  end

  def write_config_blog_for_test_public
    path_to_template = ENV['PATH_TEMPLATE']
    blog_path = File.join(path_to_template, "blog")
    default_config = YAML.load_file(File.join(blog_path, '_config.yml'))

    default_config['baseurl'] = self.url_for_site

    File.open(File.join(self.path_for_site, "_config.yml"), 'w') {|f| f.write default_config.to_yaml } #Store
  end

  def dir_name_site
    self.name.split.join("_")
  end

  def url_for_site
    "/sites/#{self.user_id.to_s}/#{self.dir_name_site}"
  end

  def path_for_site
    File.join(File.join(ENV['PATH_SITES'], self.user_id.to_s), self.dir_name_site)
  end

  def path_public_site
    File.join(ENV['PATH_PUBLIC_SITES'], "#{self.user_id.to_s}/#{self.dir_name_site}")
  end

  def build
    Dir.chdir(self.path_for_site) do
      %x[jekyll build]
      FileUtils.mkdir_p self.path_public_site
      FileUtils.cp_r(Dir["#{File.join(self.path_for_site, "_site")}/*"], self.path_public_site)
    end
  end

  def browse_pages
    Page.where(site_id: self.id).destroy_all 

    list_pages = []
    Dir.chdir(self.path_for_site) do
      librbfiles = File.join("**", "**", "**.{md,markdown,textile}")
      name_files = Dir.glob(librbfiles)
      name_files.each do |name_file|
        list_pages << Page.create_from_file(name_file, self)
      end
      list_pages
    end
  end
end
