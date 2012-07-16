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
			click_button 'Salvar'
			page.should have_content 'Blog criado(a) com sucesso'
		end

		it 'with errors' do
			click_button 'Salvar'
			page.should have_content 'Nome não pode ser vazio'
			page.should have_content 'Link não pode ser vazio'
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
			click_button 'Salvar'
			page.should have_content 'Blog atualizado(a) com sucesso'
			@blog.reload
			@blog.name.should == 'Outro nome'
			@blog.link.should == 'http://blog.meuevento.com'
			@blog.rss.should == 'http://blog.meuevento.com/rss.xml'
			@blog.description.should == 'MeuEvento.com é um sistema de gerenciamento de evento'
		end

		it 'with errors' do
			fill_in 'Nome', :with => ''
			fill_in 'Link', :with => ''
			click_button 'Salvar'
			page.should have_content 'Nome não pode ser vazio'
			page.should have_content 'Link não pode ser vazio'
		end
	end

	context 'delete a blog' do
		background do
			@blog = FactoryGirl.create :blog
			click_link 'Blog'
			click_link 'Excluir'
		end

		it 'successfully' do
			click_button 'Sim, eu tenho certeza'
			page.should have_content 'Blog excluído(a) com sucesso'
		end
	end
end