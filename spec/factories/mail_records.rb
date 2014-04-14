# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mail_record do
    date "2014-04-14"
    to "MyString"
  end
end
