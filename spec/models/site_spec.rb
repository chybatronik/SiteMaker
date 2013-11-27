require 'spec_helper'

describe Site do
  it "should create new site, check path with user_name and site name" do
    my_site = FactoryGirl.create :site 
    File.directory?(my_site.path_for_site).should be_true
  end

  it "should build site" do
    my_site = FactoryGirl.create :site 
    File.directory?(my_site.path_for_site).should be_true
    my_site.build
    File.directory?(File.join(my_site.path_for_site, "_site")).should be_true

  end
end
