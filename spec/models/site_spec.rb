require 'spec_helper'

describe Site do
  it "should create new site, check path with user_name and site name" do
    my_site = FactoryGirl.create :site 
    File.directory?(my_site.path_for_site).should be_true
  end

  it "should build site" do
    my_site = FactoryGirl.create :site 
    File.directory?(my_site.path_for_site).should be_true
    File.directory?(File.join(my_site.path_for_site, "_site")).should be_true
  end

  it "copy into public" do
    my_site = FactoryGirl.create :site 
    File.directory?(my_site.path_for_site).should be_true
    File.directory?(File.join(my_site.path_public_site, "css")).should be_true
  end

  it "has written config for test public " do
    my_site = FactoryGirl.create :site 
    my_site.config["safe"].should be_true
  end

  it "public site has baseurl for view" do
    my_site = FactoryGirl.create :site 
    File.directory?(File.join(my_site.path_for_site, "_site")).should be_true
    File.directory?(File.join(my_site.path_public_site, "css")).should be_true
    my_site.config['baseurl'].should be_eql(my_site.url_for_site)
  end
end
