# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'Manipulate opportunity' do
  background do
    @user = Factory.create :user, :email => 'user@user.com', :password => '123456'
    Factory.create :configuration
    login(@user.email,'123456')
  end

  context 'add a opportunity' do
    it 'successfully' do
      visit '/admin/opportunity/new'
      fill_in 'Título', :with => 'Novo título'
      fill_in 'Conteúdo', :with => ''
      check 'Publicado'
      click_button 'Salvar'
      page.should have_content 'Oportunidade criado(a) com sucesso.'
    end

    it 'with errors' do
      visit '/admin/opportunity/new'
      click_button 'Salvar'
      page.should have_content 'Título não pode ser vazio'
    end
  end

  context 'edit' do
    before :each do
      opportunity = Factory.create :opportunity
      visit "/admin/opportunity/#{opportunity.id}/edit"
    end

    scenario 'successfully' do
      fill_in 'Título', :with => 'Novo título'
      fill_in 'Conteúdo', :with => ''
      check 'Publicado'
      click_button 'Salvar'
      page.should have_content 'Oportunidade atualizado(a) com sucesso.'
    end

    scenario 'failure' do
      fill_in 'Título', :with => ''
      click_button 'Salvar'
      page.should have_content 'Título não pode ser vazio.'
    end
  end
end

