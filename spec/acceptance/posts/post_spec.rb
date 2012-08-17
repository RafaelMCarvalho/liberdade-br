# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'manage posts' do
  background do
    FactoryGirl.create :configuration
    @user = FactoryGirl.create :user
    login(@user.email, '123456')
  end

  context 'add a post' do
    background do
      @category = FactoryGirl.create :category
      @author = FactoryGirl.create :author
      @blog = FactoryGirl.create :blog

      visit '/admin/post/new'
    end

    it 'successfully' do
      fill_in 'Título', :with => 'Foo post'
      fill_in 'Conteúdo', :with => 'Foo content'
      select @blog.name, :from => 'Blog'
      select @category.name, :from => 'Categorias'
      select @author.name, :from => 'Autores'
      click_button 'Salvar'
      page.should have_content 'Post criado(a) com sucesso'
      post = Post.last
      post.blog.should == @blog
      post.authors.should include(@author)
      post.categories.should include(@category)
    end

    it 'with errors' do
      click_button 'Salvar'
      page.should have_content 'Título não pode ser vazio'
    end
  end

  context 'edit a post' do
    background do
      @category = FactoryGirl.create :category
      @author = FactoryGirl.create :author
      @blog = FactoryGirl.create :blog, :name => 'Foo random blog'
      @post = FactoryGirl.create :post

      visit '/admin/post'
      click_link 'Editar'
    end

    it 'successfully' do
      fill_in 'Título', :with => 'Foo post'
      fill_in 'Conteúdo', :with => 'Foo content'
      select @blog.name, :from => 'Blog'
      select @category.name, :from => 'Categorias'
      select @author.name, :from => 'Autores'
      click_button 'Salvar'
      page.should have_content 'Post atualizado(a) com sucesso'
      @post.reload
      @post.title.should == 'Foo post'
      @post.content.should == 'Foo content'
      @post.blog.should == @blog
      @post.authors.should include(@author)
      @post.categories.should include(@category)
    end

    it 'with errors' do
      fill_in 'Título', :with => ''
      click_button 'Salvar'
      page.should have_content 'Título não pode ser vazio'
    end
  end

  context 'delete a post' do
    background do
      @post = FactoryGirl.create :post
      visit '/admin/post'
      click_link 'Excluir'
    end

    it 'successfully' do
      click_button 'Sim, eu tenho certeza'
      page.should have_content 'Post excluído(a) com sucesso'
    end
  end
end
