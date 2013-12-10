# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :directory do
    name "MyString"
    ancestry "MyString"
    site_id 1
  end
end
