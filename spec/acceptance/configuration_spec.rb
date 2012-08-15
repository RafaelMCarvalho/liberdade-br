# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'Manupulate configurations' do
  background do
    @user = Factory.create :user, :email => 'user@user.com', :password => '123456'
    @configuration = Factory.create :configuration
    login(@user.email,'123456')
    visit "/admin/configuration/#{@configuration.id}/edit"
  end

  context 'edit' do
    scenario 'successfully' do
      fill_in 'E-mail', :with => 'email@qualquer.com'
      fill_in 'Facebook', :with => 'qualquer.com'
      fill_in 'Twitter', :with => 'qualquer.com'
      fill_in 'Palavras-chave', :with => 'project, base'
      fill_in 'Descrição', :with => 'This is the project base'
      fill_in 'Google Analytics', :with => '<script>my_script_here</script>'
      fill_in 'URL do site', :with => 'http://foo.com'
      fill_in 'Título do site', :with => 'Liberdade.br'
      fill_in 'Texto', :with => 'Footer'
      fill_in 'Link', :with => 'http://foo.com'
      fill_in 'Objetivo (R$)', :with => '1000.00'
      fill_in 'Angariado (R$)', :with => '600.00'
      click_button 'Salvar'
      page.should have_content 'Configuração atualizado(a) com sucesso.'

      visit '/'
      page.should have_xpath('.//meta[@name="keywords"]', :content => 'project, base')
      page.should have_xpath('.//meta[@name="description"]', :content => 'This is the project base')
    end

    context 'unsuccessfully' do
      scenario 'invalid email' do
        fill_in 'E-mail', :with => 'email@qualquer'
        click_button 'Salvar'
        page.should have_content 'E-mail não é válido.'
      end

      scenario 'empty fields' do
        fill_in 'E-mail', :with => ''
        click_button 'Salvar'
        page.should have_content 'E-mail não pode ser vazio.'
      end
    end
  end

  scenario 'cannot add a new' do
    lambda { visit '/admin/configuration/new' }.should raise_error CanCan::AccessDenied
  end

  scenario 'cannot delete' do
    lambda {
      visit "/admin/configuration/#{@configuration.id}/delete"
    }.should raise_error CanCan::AccessDenied
  end
end

