# -*- encoding : utf-8 -*-

User.create!(
  :email => 'admin@base.com',
  :password => '123456',
  :role => :admin
)

Configuration.create!(
  :email => 'base@project.com.br'
)

Page.create!(
  :indicator => Page::PAGES[:contact],
  :title => 'Contato',
  :content => 'Conteúdo da página de contato',
  :published => true
)

