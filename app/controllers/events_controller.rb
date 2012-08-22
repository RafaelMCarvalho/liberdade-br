# -*- encoding : utf-8 -*-
class EventsController < ApplicationController
  def index
    @events = Event.where('published = ?', true).page(params[:page]).per(6)
  end

  def show
    @event = Event.find(params[:id])
  end
end

