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
end