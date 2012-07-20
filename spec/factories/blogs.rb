# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog do
      name "MyString"
      link "blog.com.br"
      rss "MyString"
      description "MyText"
    end
end