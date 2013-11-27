require 'fileutils'

class Site < ActiveRecord::Base
  belongs_to :user

  after_create do
    site_dir_path = File.join(ENV['PATH_SITES'], self.user_id.to_s)
    FileUtils.mkdir_p site_dir_path
    Dir.chdir(site_dir_path) do
      %x[jekyll new #{self.name}]
    end

  end

  def path_for_site
    File.join(File.join(ENV['PATH_SITES'], self.user_id.to_s), self.name)
  end

  def build
    Dir.chdir(self.path_for_site) do
      %x[jekyll build]
    end
  end
end
