# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog do
    name "MyString"
    link "blog.com.br"
    rss "blog.com.br/rss"
    description "MyText"
    image_file_name 'spec/acceptance/data/image.jpg'
  end
end
