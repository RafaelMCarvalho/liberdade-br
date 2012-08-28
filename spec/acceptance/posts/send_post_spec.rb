# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'manage posts' do
  background do
    FactoryGirl.create :page, :indicator => Page::PAGES[:send_post], :published => true
    FactoryGirl.create :configuration
  end

  context 'send' do
    background do
      visit new_post_path
    end

    it 'successfully' do
      fill_in 'Título', :with => 'Foo post'
      fill_in 'Conteúdo', :with => 'Foo content'
      fill_in 'Categorias', :with => 'foo, bar'
      fill_in 'Nomes dos autores', :with => 'Foo author, Bar author'
      click_button 'Enviar'
      page.should have_content 'Post enviado com sucesso. Ele será avaliado pelos moderadores antes de ser publicado no site.'
      post = Post.last
      author1 = Author.find_by_name('Foo author')
      author2 = Author.find_by_name('Bar author')
      category1 = Category.find_by_name('foo')
      category2 = Category.find_by_name('bar')
      post.authors.should include(author1, author2)
      post.categories.should include(category1, category2)
    end

    it 'with errors' do
      click_button 'Enviar'
      page.should have_content 'Títulonão pode ser vazio'
      page.should have_content 'Conteúdonão pode ser vazio'
    end

    it 'without authors' do
      fill_in 'Título', :with => 'Foo post'
      fill_in 'Conteúdo', :with => 'Foo content'
      fill_in 'Nomes dos autores', :with => ''
      click_button 'Enviar'
      page.should have_content 'não pode ser vazio'
    end
  end
end
