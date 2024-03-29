# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'manager blogs' do
	background do
		FactoryGirl.create :configuration
		@user = FactoryGirl.create :user
		login(@user.email, '123456')
	end

	context 'add a blog' do
		background do
			click_link 'Blog'
			click_link 'Adicionar'
		end

		it 'successfully' do
			fill_in 'Nome', :with => 'Blog da Algorich'
			fill_in 'Descrição', :with => 'Blog da empresa'
			fill_in 'Link', :with => 'http://blog.algorich.com.br'
			fill_in 'RSS', :with => 'http://blog.algorich.com.br/rss.xml'
			attach_file 'Imagem', IMAGE
			click_button 'Salvar'
			page.should have_content 'Blog criado(a) com sucesso'
		end

		it 'with errors' do
			fill_in 'Nome', :with => ''
			fill_in 'Link', :with => ''
			fill_in 'RSS', :with => ''
			click_button 'Salvar'
			page.should have_content 'Nome não pode ser vazio'
			page.should have_content 'Link não pode ser vazio'
			page.should have_content 'RSS não pode ser vazio'
		end
	end

	context 'edit a blog' do
		background do
			@blog = FactoryGirl.create :blog
			click_link 'Blog'
			click_link 'Editar'
		end

		it 'successfully' do
			fill_in 'Nome', :with => 'Outro nome'
			fill_in 'Link', :with => 'http://blog.meuevento.com'
			fill_in 'RSS', :with => 'http://blog.meuevento.com/rss.xml'
			fill_in 'Descrição', :with => 'MeuEvento.com é um sistema de gerenciamento de evento'
			attach_file 'Imagem', IMAGE
			click_button 'Salvar'
			page.should have_content 'Blog atualizado(a) com sucesso'
			@blog.reload
			@blog.name.should == 'Outro nome'
			@blog.link.should == 'http://blog.meuevento.com'
			@blog.rss.should == 'http://blog.meuevento.com/rss.xml'
			@blog.description.should == 'MeuEvento.com é um sistema de gerenciamento de evento'
		end

		context 'with errors' do
			it 'blank' do
				fill_in 'Nome', :with => ''
				fill_in 'Link', :with => ''
				fill_in 'RSS', :with => ''
				click_button 'Salvar'
				page.should have_content 'Nome não pode ser vazio'
				page.should have_content 'Link não pode ser vazio'
				page.should have_content 'RSS não pode ser vazio'
			end

			it 'invalid' do
				fill_in 'Link', :with => 'foo'
				fill_in 'RSS', :with => 'bar'
				click_button 'Salvar'
				page.should have_content 'Link não é válido'
				page.should have_content 'RSS não é válido'
			end
		end
	end

	it 'delete a blog successfully' do
		FactoryGirl.create :blog
		click_link 'Blog'
		click_link 'Excluir'
		sleep 2
		click_button 'Sim, eu tenho certeza'
		page.should have_content 'Blog excluído(a) com sucesso'
		Blog.all.should be_empty
	end
end
