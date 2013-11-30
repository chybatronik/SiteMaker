require 'fileutils'
require 'haml'

class Site < ActiveRecord::Base
  belongs_to :user

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
    end
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
  end

  def dir_name_site
    self.name.split.join("_")
  end

  def path_for_site
    File.join(File.join(ENV['PATH_SITES'], self.user_id.to_s), self.dir_name_site)
  end

  def build
    Dir.chdir(self.path_for_site) do
      %x[jekyll build]
    end
  end
end
