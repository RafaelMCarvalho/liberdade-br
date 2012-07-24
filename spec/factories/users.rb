# -*- encoding : utf-8 -*-
Factory.define :user do |c|
  c.sequence(:email) { |n| "user#{n}@user.com" }
  c.password "123456"
  c.password_confirmation "123456"
  c.role :coordinator
end

