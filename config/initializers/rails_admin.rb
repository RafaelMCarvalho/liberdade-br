# -*- encoding : utf-8 -*-

RailsAdmin.config do |config|

  config.main_app_name = ["Liberdade.br", "Administração"]

  config.current_user_method { current_user } #auto-generated

    config.excluded_models = ['AuthorPost', 'CategoryPost']

  config.authorize_with :cancan

  config.model Author do
    list do
      field :name
    end

    edit do
      field :name
      field(:description) { ckeditor true }
    end
  end

  config.model Blog do
    list do
      field :name
      field :link
    end

    edit do
      field :name
      field :link
      field :rss
      field(:description) { ckeditor true }
    end
  end

  config.model Category do
    list do
      field :name
    end

    edit do
      field :name
    end
  end

  # CKeditor models (begin)
  config.model Ckeditor::Asset do
    visible false
  end

 config.model Ckeditor::Picture do
   label "Imagem"
   label_plural "Imagens"
   navigation_label 'Arquivos adicionados através do editor'
   weight 1

   edit do
     field(:data) { label 'Imagem' }
   end

   list do
     field(:data) { label 'Imagem' }
     field(:created_at) { label 'Criado em' }
     field(:updated_at) { label 'Atualizado em' }
   end
 end

 config.model Ckeditor::AttachmentFile do
   label 'Arquivo'
   navigation_label 'Arquivos adicionados através do editor'
   weight 1

   edit do
     field(:data) { label 'Arquivo' }
   end

   list do
     field(:data) do
       label 'Arquivo'
        pretty_value do # used in list view columns and show views, defaults to formatted_value for non-association fields
         "<a href='#{value.url}' target='_blank'>#{value.original_filename}</a>".html_safe
       end
     end

     field(:created_at) { label 'Criado em' }
     field(:updated_at) { label 'Atualizado em' }
   end
 end
 # CKeditor models (end)

  config.model Configuration do

    edit do
      group :email do
        label 'Configurações de email'
        field :email
      end

      group :info_search do
        label 'Informações para buscadores'

        field :keywords do
           help 'Separadas por vírgula. Recomendável no máximo 10 palavras chave.'
        end
        field :description do
          help 'Descrição utilizada pelos buscadores. Recomendável até 160 caracteres.'
        end

        field :google_analytics
      end
    end
 end

  config.model Page do
    list do
      field :title
      field :published
    end

    edit do
      field :title
      field(:content) { ckeditor true }
      field :published
    end
  end

  config.model Post do
    list do
      field :title
      field :blog
      field :published_at
    end

    edit do
      field :title
      field :blog
      field(:content) { ckeditor true }
      field :published_at
      field :authors
      field :categories
    end
  end

  config.model User do
    object_label_method { :email }

    list do
      field :email
    end

    create do
      field :email
      field(:password) do
        label 'Senha'
        help 'Digite a senha do novo usuário'
      end

      field :password_confirmation do
        label 'Confirme a senha'
        help 'Confirme a senha do novo usuário'
      end
      field :role
    end

    edit do
      field :email
      field(:password) do
        label 'Senha'
        help 'Digite uma nova senha caso deseje modificar a atual'
      end

      field :password_confirmation do
        label 'Confirme a senha'
        help 'Confirme a senha caso deseje mudar a senha atual'
      end
    end
  end
end

