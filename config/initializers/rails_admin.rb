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

  config.model Post do
    navigation_label 'Postagens'
    weight 3

    list do
      field :title
      field :blog
      field :evaluations_count do
        pretty_value do
          "#{value}/#{User.count}"
        end
      end
      field :evaluations_pretty do
        column_width 150;
        pretty_value do
          approval = bindings[:object].approval_rate.round(1)
          reproval = bindings[:object].reproval_rate.round(1)
          if approval == 0 and reproval == 0
            html = "<span class=\"label\" style=\"width: 100%;\">Sem avaliações</span>".html_safe
          else
            html = "
            <div class=\"progress\" style=\"margin: 0;\" title=\"Não avaliaram\">
              <div class=\"bar bar-success\" style=\"width: #{approval.to_i}%;overflow: hidden;\" title=\"Aprovação\">#{approval}%</div>
              <div class=\"bar bar-danger\" style=\"width: #{reproval.to_i}%;overflow: hidden;\" title=\"Reprovação\">#{reproval}%</div>
              <div style=\"text-align: center;overflow: hidden;\">#{(100.0 - approval - reproval).round(1)}%</div>
            </div>".html_safe
          end
          html
        end
      end
      field :published do
        label 'Status'
        pretty_value do
          if value == true
            html = "<span class=\"label label-success\">Aprovado</span>".html_safe
          else
            html = "<span class=\"label label-important\">Reprovado</span>".html_safe
          end
          html
        end
      end
      field :user_evaluation do
        label ' '
        pretty_value do
          evaluation = PostEvaluation.where('user_id = ? and post_id = ?', bindings[:view].current_user.id, bindings[:object].id).first
          if evaluation.nil?
            html = ""
          elsif evaluation.approve == true
            html = "<i class=\"icon-thumbs-up\" title=\"Você aprovou\"></i>".html_safe
          else
            html = "<i class=\"icon-thumbs-down\" title=\"Você reprovou\"></i>".html_safe
          end
          html
        end
      end
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

  config.model Blog do
    navigation_label 'Postagens'
    weight 4

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

  config.model Author do
    navigation_label 'Postagens'
    weight 4

    list do
      field :name
    end

    edit do
      field :name
    end
  end


  config.model Category do
    navigation_label 'Postagens'
    weight 5

    list { field :name }
    edit { field :name }
  end


# CONTENTS =====================================================================

  config.model Banner do
    navigation_label 'Conteúdos'
    weight 6

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

  config.model Page do
    navigation_label 'Conteúdos'
    weight 7

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

  config.model Event do
    navigation_label 'Conteúdos'
    weight 8

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
    weight 9

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
    weight 10

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
    weight 11

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
    weight 12

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
