# -*- encoding : utf-8 -*-

class SiteController < ApplicationController

  def index
    @banners = Banner.where('published = ?', true)
    @search = Post.published.order('published_at DESC').
      search(params[:q])
    @posts = @search.result
    @posts = @posts.uniq.limit(6)
  end

  def events_and_opportunities
    @events = Event.where('published = ? AND date >= ?', true, Date.today).
      order('date')
    @opportunities = Opportunity.where('published = ?', true).
      order('created_at')
  end

  # CONTACT BEGIN

  def contact
    @contact = Page.where('indicator = ?', Page::PAGES[:contact]).first
    @contact_form = Contact.new

    raise ActionController::RoutingError.new('Not Found') unless @contact.published
  end

  def send_contact
    @contact = Page.where('indicator = ?', Page::PAGES[:contact]).first
    @contact_form = Contact.new(params[:contact])

    if @contact_form.save
      redirect_to(contact_path, :notice => 'Mensagem enviada com sucesso.')
    else
      render :action => :contact
    end
  end

  # CONTACT END

  def about
    @about = Page.where("indicator = ?", Page::PAGES[:about]).first

    raise ActionController::RoutingError.new('Not Found') unless @about.published
  end

  def faq
    @faq = Page.where("indicator = ?", Page::PAGES[:faq]).first

    raise ActionController::RoutingError.new('Not Found') unless @faq.published
  end

  def financers
    @financers = Page.where("indicator = ?", Page::PAGES[:financers]).first

    raise ActionController::RoutingError.new('Not Found') unless @financers.published
  end
end
