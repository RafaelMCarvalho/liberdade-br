# -*- encoding : utf-8 -*-

require 'spec_helper'

feature 'manage banner' do
	background do
		FactoryGirl.create :configuration
		@user = FactoryGirl.create :user
		login(@user.email, '123456')
	end

	context 'success' do
		it 'create a banner' do
			visit('/admin/banner/new')
			fill_in 'Título', :with => 'Banner'
			fill_in 'Link', :with => 'http://www.algorich.com.br'
			check 'Abrir em uma nova aba'
			attach_file 'Imagem', IMAGE
			click_button 'Salvar'
			page.should have_content 'Banner criado(a) com sucesso.'
		end

		it 'edit a news' do
			banner = FactoryGirl.create :banner

			visit("/admin/banner/#{banner.id}/edit")
			fill_in 'Título', :with => 'Meu Banner'
			fill_in 'Link', :with => 'http://www.algorich.com.br'
			check 'Abrir em uma nova aba'
			attach_file 'Imagem', IMAGE
			click_button 'Salvar'
			page.should have_content 'Banner atualizado(a) com sucesso.'
			banner.reload.title.should == 'Meu Banner'
		end
	end

	context 'invalid' do
		it 'invalid values' do
			visit('/admin/banner/new')
			fill_in 'Título', :with => ''
			fill_in 'Link', :with => 'link'
			click_button 'Salvar'
			page.should have_content 'Banner criado(a) com falha.'
			page.should have_content 'Título não pode ser vazio.'
			page.should have_content 'Link não é válido.'
			Banner.all.length.should == 0
		end
	end

  context 'delete' do
    background do
      @banner = Factory.create :banner
      visit '/admin/banner'
    end

    scenario 'successfully', :js => true do
      previous_lenght = Banner.all.length
      click_link 'Excluir'
      click_button 'Sim, eu tenho certeza'
      page.should have_content 'Banner excluído(a) com sucesso.'
      Banner.all.length.should == previous_lenght - 1
    end
  end
end
