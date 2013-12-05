# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    name_file "1/2/3/4/5"
    layout "MyString"
    permalink "MyString"
    published false
    categories "MyText"
    tags "MyText"
    title "MyString"
    content "MyText"
    date "MyString"
    site_id 1
  end
end
