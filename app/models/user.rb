# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_many :post_evaluations
  has_many :posts, :through => :post_evaluations, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  def role_enum
    %w[admin common]
  end

  def role?(role)
    self.role == role.to_s
  end
end
