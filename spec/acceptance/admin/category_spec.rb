# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'manager categories' do
  background do
    FactoryGirl.create :configuration
    @user = FactoryGirl.create :user
    login(@user.email, '123456')
  end

  context 'add a category' do
    background do
      click_link 'Categoria'
      click_link 'Adicionar'
    end

    it 'successfully' do
      fill_in 'Nome', :with => 'Ficção'
      click_button 'Salvar'
      page.should have_content 'Categoria criado(a) com sucesso'
    end

    it 'with errors' do
      click_button 'Salvar'
      page.should have_content 'Nome não pode ser vazio'
    end
  end

  context 'edit a category' do
    background do
      @category = FactoryGirl.create :category
      click_link 'Categoria'
      click_link 'Editar'
    end

    it 'successfully' do
      fill_in 'Nome', :with => 'Desenvolvimento'
      click_button 'Salvar'
      page.should have_content 'Categoria atualizado(a) com sucesso'
      @category.reload
      @category.name.should == 'desenvolvimento'
    end

    it 'with errors' do
      fill_in 'Nome', :with => ''
      click_button 'Salvar'
      page.should have_content 'Nome não pode ser vazio'
    end
  end

  context 'delete a category' do
    background do
      @category = FactoryGirl.create :category
      click_link 'Categoria'
      click_link 'Excluir'
    end

    it 'successfully' do
      click_button 'Sim, eu tenho certeza'
      page.should have_content 'Categoria excluído(a) com sucesso'
    end
  end
end
