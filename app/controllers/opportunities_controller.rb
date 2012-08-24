# -*- encoding : utf-8 -*-

class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.where('published = ?', true).
      page(params[:page]).per(6)
  end

  def show
    @opportunity = Opportunity.find(params[:id])
  end
end
