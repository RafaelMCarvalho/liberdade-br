# -*- encoding : utf-8 -*-
class PostController < ApplicationController

  before_filter :check_user

  def accept
    params[:accept] = true
    @evaluation = PostEvaluation.where('user_id = ? and post_id = ?', params[:user_id], params[:post_id]).first
    if @evaluation.nil?
      @evaluation = PostEvaluation.new(params)
      @evaluation.save
    else
      @evaluation.update_attributes(params)
    end
  end

  def reject
    params[:accept] = false
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

