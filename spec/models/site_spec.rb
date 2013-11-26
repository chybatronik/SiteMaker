require 'spec_helper'

describe Site do
  it "should create new path with user_name and site name" do
    my_site = FactoryGirl.create :site 
    path = File.join(File.join(ENV['PATH_SITES'], '1'), my_site.name)
    File.directory?(path).should be_true
    p ENV["PATH_SITES"]
  end
end
