# -*- encoding : utf-8 -*-

# User

User.delete_all

User.create!(
  :email => 'admin@base.com',
  :password => '123456',
  :role => :coordinator
)

User.create!(
  :email => 'moderator@base.com',
  :password => '123456',
  :role => :moderator
)

# Configuration

Configuration.delete_all

Configuration.create!(
  :email => 'base@project.com.br'
)

# Pages

Page.delete_all

Page.create!(
  :indicator => Page::PAGES[:contact],
  :title => 'Contato',
  :content => 'Conteúdo da página de contato',
  :published => true
)

# Banner

Banner.delete_all

Banner.create!(
  :title => 'Lorem ipsum dolor sit amet',
  :link => 'http://www.algorich.com.br',
  :open_in_new_tab => true,
  :published => true,
  :image => File.open('public/seeds/banner1.png')
)

Banner.create!(
  :title => 'Quisque ultricies dapibus suscipit',
  :link => 'http://www.algorich.com.br',
  :open_in_new_tab => true,
  :published => true,
  :image => File.open('public/seeds/banner2.png')
)

Banner.create!(
  :title => 'Praesent urna est molestie in hendrerit eu vestibulum',
  :link => 'http://www.algorich.com.br',
  :open_in_new_tab => true,
  :published => true,
  :image => File.open('public/seeds/banner3.png')
)
