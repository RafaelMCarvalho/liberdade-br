# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  MODELS = [Configuration, Page, User]

  def initialize(user)
    if user
      can :access, :rails_admin
      if user.role? :moderator
        can :dashboard
        can :read, Post
        can :update, User, :id => user.id #moderator can update own user details
      elsif user.role? :coordinator
        can :access, :rails_admin
        can :manage, :all
        cannot [:destroy, :create], Page
        cannot [:destroy, :create], Configuration

        MODELS.each { |model| cannot :show, model }
      end
    end
  end
end
