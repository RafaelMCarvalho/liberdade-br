# -*- encoding : utf-8 -*-
Factory.define :configuration do |c|
  c.email 'projeto@base.com.br'
  c.donation_text 'Foo'
  c.donation_link 'http://foo.com'
  c.donation_goal '1000.00'
  c.donation_collected '800.00'
end

