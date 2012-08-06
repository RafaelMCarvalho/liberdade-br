require 'spec_helper'

feature 'manager authors' do
	background do
		FactoryGirl.create :configuration
		@user = FactoryGirl.create :user
		login(@user.email, '123456')
	end

	context 'add an author' do
		background do
			click_link 'Autor'
			click_link 'Adicionar'
		end

		it 'successfully' do
			fill_in 'Nome', :with => 'Blog da Algorich'
			fill_in 'Descrição', :with => 'Blog da empresa'
			click_button 'Salvar'
			page.should have_content 'Autor criado(a) com sucesso'
		end

		it 'with errors' do
			click_button 'Salvar'
			page.should have_content 'Nome não pode ser vazio'
		end
	end

	context 'edit an author' do
		background do
			@author = FactoryGirl.create :author
			click_link 'Autor'
			click_link 'Editar'
		end

		it 'successfully' do
			fill_in 'Nome', :with => 'Outro nome'
			fill_in 'Descrição', :with => 'MeuEvento.com é um sistema de gerenciamento de evento'
			click_button 'Salvar'
			page.should have_content 'Autor atualizado(a) com sucesso'
			@author.reload
			@author.name.should == 'Outro nome'
			@author.description.should == 'MeuEvento.com é um sistema de gerenciamento de evento'
		end

		it 'with errors' do
			fill_in 'Nome', :with => ''
			click_button 'Salvar'
			page.should have_content 'Nome não pode ser vazio'
		end
	end

	context 'delete an author' do
		background do
			@author = FactoryGirl.create :author
			click_link 'Autor'
			click_link 'Excluir'
		end

		it 'successfully' do
			click_button 'Sim, eu tenho certeza'
			page.should have_content 'Autor excluído(a) com sucesso'
		end
	end
end
