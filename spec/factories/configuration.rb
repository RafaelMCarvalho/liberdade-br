# -*- encoding : utf-8 -*-
Factory.define :configuration do |c|
  c.email 'projeto@base.com.br'
  c.donation_text 'Foo'
  c.site_url 'http://foo.com'
  c.site_title 'Liberdade.br'
  c.donation_link 'http://foo.com'
  c.donation_goal '1000.00'
  c.donation_collected '800.00'
  c.realization_title 'Foo'
  c.realization_url 'http://foo.com'
  c.realization_image File.new("spec/data/image.jpg")
end

