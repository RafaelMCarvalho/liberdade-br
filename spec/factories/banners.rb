FactoryGirl.define do
  factory :banner do
    title 'Title'
    link 'http://www.algrich.com.br'
    open_in_new_tab true
    image_file_name 'spec/acceptance/data/image.jpg'
  end
end
