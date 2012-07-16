# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  MODELS = [Configuration, Page]

  def initialize(user)
    can :access, :rails_admin
    can :manage, :all
    cannot [:destroy, :create], Page
    cannot [:destroy, :create], Configuration

    MODELS.each { |model| cannot :show, model }
  end
end

