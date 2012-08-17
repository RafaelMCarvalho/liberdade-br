# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
      title "MyString"
      content "MyText"
      blog
    end
end
