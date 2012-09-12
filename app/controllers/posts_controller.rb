# -*- encoding : utf-8 -*-
class PostsController < ApplicationController

  before_filter :check_user, :only => [:approve, :reprove]

  def rss
    @posts = Post.published.order('approved_at DESC')

    respond_to do |format|
       format.rss { render :layout => false }
    end
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "Liberdade.br"

    # the news items
    @posts = Post.published.order('approved_at DESC')

    # this will be our Feed's update timestamp
    @updated = @posts.first.approved_at unless @posts.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end


  def index
    @search = Post.published.order('approved_at DESC').search(params[:q])
    @posts = @search.result
    @posts = @posts.uniq.page(params[:page]).per(6)
    @posts.reload
  end

  def new
    @page = Page.where('indicator = ?', Page::PAGES[:send_post]).first
    @post = Post.new

    raise ActionController::RoutingError.new('Not Found') unless @page.published
  end

  def send_post
    @page = Page.where('indicator = ?', Page::PAGES[:send_post]).first

    @post = Post.build_from_new_post_page(params[:post])
    @authors_input_value = @post.authors.map(&:name).join(', ')
    @categories_input_value = @post.categories.map(&:name).join(', ')

    if @post.save
      flash[:notice] = 'Post enviado com sucesso. Ele será avaliado pelos moderadores antes de ser publicado no site.'
      redirect_to :action => 'new'
    else
      render :action => 'new'
    end

  end

  def show
    @post = Post.find(params[:id])

    if current_user
      @evaluation = PostEvaluation.where('user_id = ? AND post_id = ?', current_user, @post.id).first
      @voted_approve = @evaluation.try(:approve)
    end

    unless @post.able_to_publish? or current_user
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def per_author
    @search = Post.published.order('approved_at DESC').search(params[:q])
    @author = Author.find(params[:id])
    @posts = @author.published_posts.uniq.page(params[:page]).per(6)
    @posts.reload
    render :index
  end

  def per_blog
    @search = Post.published.order('approved_at DESC').search(params[:q])
    @blog = Blog.find(params[:id])
    @posts = @blog.published_posts.uniq.page(params[:page]).per(6)
    @posts.reload
    render :index
  end

  def per_category
    @search = Post.published.order('approved_at DESC').search(params[:q])
    @category = Category.find(params[:id])
    @posts = @category.published_posts.uniq.page(params[:page]).per(6)
    @posts.reload
    render :index
  end

  def approve
    params[:approve] = true
    @evaluation = PostEvaluation.where('user_id = ? and post_id = ?', params[:user_id], params[:post_id]).first
    if @evaluation.nil?
      @evaluation = PostEvaluation.new(params)
      @evaluation.save
    else
      @evaluation.update_attributes(params)
    end
    redirect_to post_path(params[:post_id]), :notice => 'Você aprovou o post com sucesso.'
  end

  def reprove
    params[:approve] = false
    @evaluation = PostEvaluation.where('user_id = ? and post_id = ?', params[:user_id], params[:post_id]).first
    if @evaluation.nil?
      @evaluation = PostEvaluation.new(params)
      @evaluation.save
    else
      @evaluation.update_attributes(params)
    end
    redirect_to post_path(params[:post_id]), :notice => 'Você reprovou o post com sucesso.'
  end

  protected

  def check_user
    if current_user.id.to_s != params[:user_id]
      render :nothing => true and return
    end
  end
end
