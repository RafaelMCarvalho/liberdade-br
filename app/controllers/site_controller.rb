# -*- encoding : utf-8 -*-
class SiteController < ApplicationController

  def index
    @banners = Banner.where('published = ?', true)
    @events = Event.where('published = ? AND date >= ?', true, Date.today).
      order('date').limit(6)


    @search = Post.where('published = ?', true).order('published_at DESC').search(params[:q])
    @posts = @search.result
    @posts = @posts.uniq
  end

  # POST BEGIN

  def post
    @post = Post.find(params[:id])

    if !@post.published
      if current_user
        flash[:info] = 'Este post não está publicado. Isto é apenas uma pré-visualização.'
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end

  def posts
    @search = Post.where('published = ?', true).order('published_at DESC').search(params[:q])
    @posts = @search.result
    @posts = @posts.uniq.page(params[:page]).per(6)
  end

  # POST END

  # CONTACT BEGIN

  def contact
    @contact = Page.where('indicator = ?', Page::PAGES[:contact]).first
    @contact_form = Contact.new

    raise ActionController::RoutingError unless @contact.published
  end

  def send_contact
    @contact = Page.where('indicator = ?', Page::PAGES[:contact]).first
    @contact_form = Contact.new(params[:contact])

    if @contact_form.save
      redirect_to(contact_path, :notice => "Mensagem enviada com sucesso.")
    else
      render :action => :contact
    end
  end

  # CONTACT END
end
