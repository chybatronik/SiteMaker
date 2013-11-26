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
end
