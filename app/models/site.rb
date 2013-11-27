require 'fileutils'

class Site < ActiveRecord::Base
  belongs_to :user

  after_create do
    site_dir_user_path = File.join(ENV['PATH_SITES'], self.user_id.to_s)
    FileUtils.mkdir_p site_dir_user_path
    Dir.chdir(site_dir_user_path) do
      %x[jekyll new #{self.dir_name_site}]
    end
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
