require "yaml"

class Page < ActiveRecord::Base
  belongs_to :directory
  belongs_to :site

  def self.create_from_file name_file, site
    is_find = false
    str_yml = ""
    content = ""
    text = File.open(File.join(site.path_for_site, name_file)).read
    text.gsub!(/\r\n?/, "\n")
    text.each_line do |line|
      if not is_find and line.include?("---")
        is_find = true 
      else
        if is_find and line.include?("---")
          is_find = false
        end
      end
      if is_find
        str_yml << line 
      else
        content << line unless line.include?("---")
      end
    end
    config_page = YAML.load(str_yml)
    config_page['name_file'] = name_file
    config_page['content'] = content
    config_page['site_id'] = site.id
    self.create config_page
  end

  def dir_name
    File.dirname(self.name_file)
  end

  def basename
    File.basename(self.name_file)
  end
end
