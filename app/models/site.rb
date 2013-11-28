require 'fileutils'

class Site < ActiveRecord::Base
  belongs_to :user

  after_create do
    site_dir_user_path = File.join(ENV['PATH_SITES'], self.user_id.to_s)
    FileUtils.mkdir_p site_dir_user_path
    Dir.chdir(site_dir_user_path) do
      %x[jekyll new #{self.dir_name_site}]
    end

    #template
  end
  def generate_template
    path_to_template = ENV['PATH_TEMPLATE']
    erb_string = File.open(file_name).read
        
    #Converts erb to haml
    haml_string = Haml::HTML.new(erb_string, :erb => true).render

    #Writes the haml
    f = File.new(haml_file_name, "w") 
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
