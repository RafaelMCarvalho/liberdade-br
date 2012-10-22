# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_many :post_evaluations, :dependent => :destroy
  has_many :posts, :through => :post_evaluations
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role,
    :last_evaluation_date

  after_create :call_to_update_evaluation_rates
  after_destroy :call_to_update_evaluation_rates

  validates_presence_of :role

  def call_to_update_evaluation_rates
    Post.all.each do |p|
      p.update_evaluation_rates
    end
  end

  def role_enum
    {'Coordenador' => :coordinator, 'Moderador' => :moderator}
  end

  def role?(role)
    self.role == role.to_s
  end
end
