require 'spec_helper'

describe Page do
  it "return dirs" do
    my_page = FactoryGirl.create :page
    my_page.dir_name.should be_eql("1/2/3/4")
  end
  it "return basename" do
    my_page = FactoryGirl.create :page
    my_page.basename.should be_eql("5")
  end
end
