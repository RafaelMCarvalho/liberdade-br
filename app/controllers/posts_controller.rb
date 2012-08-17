# -*- encoding : utf-8 -*-
class PostsController < ApplicationController

  before_filter :check_user, :only => [:approve, :reprove]

  def index
    @search = Post.where('published = ?', true).order('published_at DESC').search(params[:q])
    @posts = @search.result
    @posts = @posts.uniq.page(params[:page]).per(6)
  end

  def new
    @post = Post.new
  end

  def send_post
    @post = Post.build_from_new_post_page(params[:post])
    @authors_input_value = @post.authors.map(&:name).join(', ')
    @categories_input_value = @post.categories.map(&:name).join(', ')
    if @post.save
      flash[:notice] = 'Post enviado com sucesso. Ele será avaliado pelos moderadores antes de ser exibido no site.'
      redirect_to :action => 'new'
    else
      render :action => 'new'
    end
  end

  def show
    @post = Post.find(params[:id])

    if !@post.published
      if current_user
        flash[:info] = 'Este post não está publicado. Isto é apenas uma pré-visualização.'
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end

  def per_author
    @author = Author.find(params[:id])
    @posts = @author.published_posts.page(params[:page])
    @search = @posts.search(params[:q])
    render :index
  end

  def per_blog
    @blog = Blog.find(params[:id])
    @posts = @blog.published_posts.page(params[:page])
    @search = @posts.search(params[:q])
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
  end

  protected

  def check_user
    if current_user.id.to_s != params[:user_id]
      render :nothing => true and return
    end
  end
end

