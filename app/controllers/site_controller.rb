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
