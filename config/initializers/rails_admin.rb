# -*- encoding : utf-8 -*-
RailsAdmin.config do |config|

  config.main_app_name = ['Liberdade.br', 'Administração']
  config.current_user_method { current_user } #auto-generated
  config.excluded_models = ['AuthorPost', 'CategoryPost', 'PostEvaluation']
  config.authorize_with :cancan
  config.compact_show_view = false

# GENERAL ======================================================================

  config.model Configuration do
    navigation_label 'Geral'
    weight 0

    edit do
      group :email do
        label 'Geral'
        active false

        field :site_title
        field :site_url
        field :email

        field :keywords do
           help 'Opcional. Separadas por vírgula. Recomendável no máximo 10 palavras chave.'
        end

        field :description do
          help 'Opcional. Descrição utilizada pelos buscadores. Recomendável até 160 caracteres.'
        end

        field :google_analytics
      end

      group :social do
        label 'Redes sociais'
        active false

        field :twitter
        field :facebook
        field :facebook_like_goal
      end

      group :donation do
        label 'Quadro de doação'
        active false

        field(:donation_text) { ckeditor false }
        field :donation_link
        field :donation_goal
        field :donation_collected
      end

      group :ad do
        label 'Quandro de propaganda'
        active false

        field :ad_title
        field :ad_url
        field :ad_new_tab
        field :ad_published
        field :ad_image
      end

      group :realization do
        label 'Realização'
        active false

        field :realization_title
        field :realization_url
        field :realization_image
      end

      group :realization do
        label 'Rodapé'
        active false

        field(:footer) { ckeditor true }
      end
    end
  end

  config.model User do
    navigation_label 'Geral'
    weight 1

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

# POSTS ========================================================================

  config.model Author do
    navigation_label 'Postagens'

    list do
      field :name
    end

    edit do
      field :name
      field(:description) { ckeditor true }
    end
  end

  config.model Blog do
    navigation_label 'Postagens'

    list do
      field :image
      field :name
      field :link do
        formatted_value do
          "<a href='#{value}' target='_blank'>#{value}</a>".html_safe
        end
      end
    end

    edit do
      field :name
      field :link
      field :rss
      field(:description) { ckeditor true }
      field :image
    end

    show do
      field :image
      field :name
      field :link
      field :rss
      field :description do
        pretty_value do
          value.html_safe
        end
      end
    end
  end

  config.model Category do
    navigation_label 'Postagens'

    list { field :name }
    edit { field :name }
  end

  config.model Post do
    navigation_label 'Postagens'

    list do
      field :title
      field :blog
      field :evaluations_count do
        pretty_value do
          "#{value}/#{User.count}"
        end
      end
      field :reproval_rate do
        pretty_value do
          "#{value}%"
        end
      end
      field :approval_rate do
        pretty_value do
          "#{value}%"
        end
      end
      # field :both_rates do
      #   column_width 200;
      #   pretty_value do
      #     "Aprovação: #{self.approval_rate}% / Reprovação: #{self.reproval_rate}%"
      #     "<div class=\"progress\" style=\"margin: 0;\">
      #       <div class=\"bar bar-success\" style=\"width: #{value.first}%;\"></div>
      #       <div class=\"bar bar-danger\" style=\"width: #{value.last}%;\"></div>
      #     </div>".html_safe
      #   end
      # end
      field :published
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

    show do
      field :title
      field :content do
        pretty_value do
          value.html_safe
        end
      end
      field :published_at
      field :blog do
        pretty_value do
          if value
            "<a href='#{value.link}' title='#{value.name}' target='_blank'>#{value.name}</a>".html_safe
          end
        end
      end
      field :authors
      field :categories
    end
  end

# CONTENTS =====================================================================

  config.model Banner do
    navigation_label 'Conteúdos'

    list do
      field :image
      field :title
      field :link do
        formatted_value do
          "<a href='#{value}' target='_blank'>#{value}</a>".html_safe
        end
      end
      field :published
    end

    edit do
      field :title
      field :link
      field :open_in_new_tab
      field :published
      field :image
    end
  end

  config.model Event do
    navigation_label 'Conteúdos'

    list do
      field :image
      field :date
      field :name
      field :link do
        formatted_value do
          "<a href='#{value}' target='_blank'>#{value}</a>".html_safe
        end
      end
      field :published
    end

   edit do
      field :image
      field :date
      field :name
      field :link
      field :published
      field :local
      field(:description) { ckeditor true }
    end
  end

  config.model Opportunity do
    navigation_label 'Conteúdos'

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


  config.model Page do
    navigation_label 'Conteúdos'

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

  config.model Sponsor do
    navigation_label 'Conteúdos'

    list do
      field :image
      field :name
      field :link do
        formatted_value do
          "<a href='#{value}' target='_blank'>#{value}</a>".html_safe
        end
      end
    end

    edit do
      field :name
      field :link
      field :image
    end
  end

# MENU =========================================================================



  # CKeditor models (begin)
  config.model Ckeditor::Asset do
    visible false
  end

  config.model Ckeditor::Picture do
    label 'Imagem'
    label_plural 'Imagens'
    navigation_label 'Arquivos'
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
    navigation_label 'Arquivos'
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
end
