# -*- encoding : utf-8 -*-

def file_to_string file_name
  lines = File.open(file_name).collect { |line| line }

  return lines.empty? ? '' : lines * ''
end

# User

#User.delete_all

# User.create!(
#  :email => 'admin@base.com',
#  :password => '123456',
#  :role => :coordinator
# )

# User.create!(
#  :email => 'moderator@base.com',
#  :password => '123456',
#  :role => :moderator
# )

# Configuration

Configuration.delete_all

Configuration.create!(
  :email => 'base@project.com.br',
  :donation_text => 'Liberdade.br é um projeto sem fins lucrativos
    que se mantem graças as doações de pessoas que compartilham de seus
    ideais. Faça sua contribuição e nos ajude também.',
  :site_url => 'http://liberdade.cc',
  :site_title => 'Liberdade.br',
  :donation_link => 'http://google.com',
  :donation_goal => '10000.00',
  :donation_collected => '4000.00',
  :facebook => 'http://www.facebook.com/liberdadebr',
  :facebook_like_goal => 500,
  :sponsor_title => 'Libertários',
  :sponsor_url => 'http://www.pliber.org.br',
  :sponsor_image => File.open("public/seeds/libertarios.jpg"),
  :sponsor_new_tab => true,
  :sponsor_published => true,
  :realization_title => 'Instituto para o Desenvolvimento Econômico, Institucional e Social',
  :realization_url => 'http://www.ideias.org/',
  :realization_image => File.open("public/seeds/ideias.png"),
)

# Pages

Page.delete_all

page = Page.create!(
  :title => 'Contato',
  :content => file_to_string('public/seeds/contact_page.part.html'),
  :published => true
)
page.indicator = Page::PAGES[:contact]
page.save

page = Page.create!(
  :title => 'Sobre o Liberdade.BR',
  :content => file_to_string('public/seeds/about_page.part.html'),
  :published => true
)
page.indicator = Page::PAGES[:about]
page.save

page = Page.create!(
  :title => 'Financiadores do Liberdade.br',
  :content => file_to_string('public/seeds/financers_page.part.html'),
  :published => true
)
page.indicator = Page::PAGES[:financers]
page.save

page = Page.create!(
  :title => 'Perguntas frequentes',
  :content => file_to_string('public/seeds/faq_page.part.html'),
  :published => true
)
page.indicator = Page::PAGES[:faq]
page.save

page = Page.create!(
  :title => 'Enviar atigo',
  :content => file_to_string('public/seeds/send_post_page.part.html'),
  :published => true
)
page.indicator = Page::PAGES[:send_post]
page.save

# Banner

Banner.delete_all

Banner.create!(
  :title => 'Lorem ipsum dolor sit amet',
  :link => 'http://www.algorich.com.br',
  :open_in_new_tab => true,
  :published => true,
  :image => File.open('public/seeds/banner1.png')
)

Banner.create!(
  :title => 'Quisque ultricies dapibus suscipit',
  :link => 'http://www.algorich.com.br',
  :open_in_new_tab => true,
  :published => true,
  :image => File.open('public/seeds/banner2.png')
)

Banner.create!(
  :title => 'Praesent urna est molestie in hendrerit eu vestibulum',
  :link => 'http://www.algorich.com.br',
  :open_in_new_tab => true,
  :published => true,
  :image => File.open('public/seeds/banner3.png')
)

# Blog

Blog.delete_all

Blog.create!(
  :name => 'Ad Hominen',
  :link => 'http://www.adhominem.com.br/',
  :rss => 'http://www.adhominem.com.br/feeds/posts/default',
  :description => 'Humanidades e outras Falácias.'
)

Blog.create!(
  :name => 'Direitas Já!',
  :link => 'http://direitasja.wordpress.com/',
  :rss => 'http://direitasja.wordpress.com/feed/',
  :description => 'O Brasil na direção certa.'
)

Blog.create!(
  :name => 'Panfleto Liberal',
  :link => 'http://www.panfletoliberal.blogspot.com.br/',
  :rss => 'http://panfletoliberal.blogspot.com/feeds/posts/default',
  :description => 'Blog panfletário de caráter
    político-filosófico-literário-econômico-jurídico-lúdico.'
)

Blog.create!(
  :name => 'Perspectiva Austríaca',
  :link => 'http://perspectivaaustriaca.blogspot.com.br/',
  :rss => 'http://perspectivaaustriaca.blogspot.com/feeds/posts/default'
)

Blog.create!(
  :name => 'Mano Ferreira',
  :link => 'http://manoferreira.com/',
  :rss => 'http://manoferreira.com/feed/',
  :description => 'jornalismo com poesia: crônicas e críticas de um libertário.'
)

Blog.create!(
  :name => 'inimigo do Estado',
  :link => 'http://www.inimigodoestado.com/',
  :rss => 'http://www.inimigodoestado.com/feeds/posts/default',
  :description => 'Inimigo do Estado é uma iniciativa particular a fim de
    promover a defesa da liberdade individual contra a agressão estatal.'
)

Blog.create!(
  :name => 'O que se vê e o que não se vê',
  :link => 'http://www.guiomarinho.blogspot.com.br/',
  :rss => 'http://guiomarinho.blogspot.com/feeds/posts/default'
)

Blog.create!(
  :name => 'Política Reformada',
  :link => 'http://politica.reformada.org/',
  :rss => 'http://politicareformada.wordpress.com/feed/'
)

Blog.create!(
  :name => 'Rodrigo Constantino',
  :link => 'http://rodrigoconstantino.blogspot.com.br/',
  :rss => 'http://rodrigoconstantino.blogspot.com/feeds/posts/default'
)

Blog.create!(
  :name => 'Cristiano M. Costa',
  :link => 'http://www.cristianomcosta.com/',
  :rss => 'http://feeds.feedburner.com/BlogDoCristianoMCosta'
)

Blog.create!(
  :name => 'Direito e Liberalismo',
  :link => 'http://www.direitoeliberalismo.org/',
  :rss => 'http://www.direitoeliberalismo.org/feed/'
)

Blog.create!(
  :name => 'Adolfo Sachsida',
  :link => 'http://bdadolfo.blogspot.com.br/',
  :rss => 'http://bdadolfo.blogspot.com/feeds/posts/default'
)

Blog.create!(
  :name => 'Raciocínios Espúrios',
  :link => 'http://bdadolfo.blogspot.com.br/',
  :rss => 'http://raciocioniosespurios.blogspot.com.br/feeds/posts/default'
)

Blog.create!(
  :name => 'O Coyote',
  :link => 'http://coyoteonline.wordpress.com/',
  :rss => 'http://coyoteonline.wordpress.com/feed/'
)

# Sponsors

Sponsor.delete_all

Sponsor.create!(
  :name => 'Instituto Mises Brasil',
  :link => 'http://www.mises.org.br/',
  :image => File.open('public/seeds/sponsor.png')
)

Sponsor.create!(
  :name => 'Ordem Livre',
  :link => 'http://www.ordemlivre.com/',
  :image => File.open('public/seeds/sponsor.png')
)

Sponsor.create!(
  :name => 'IDEAS',
  :link => 'http://www.ideas.org.br/'
)

# Events

Event.delete_all

names = [
  'Lorem ipsum dolor sit amet',
  'Sed quam elit',
  'Curabitur venenatis',
  'Nullam at felis eu neque tempor sed'
]

10.times do |i|
  Event.create!(
    :name => names[i % names.length],
    :link => 'http://www.algorich.com.br/',
    :date => Date.today + i.days,
    :published => true,
    :image => File.open('public/seeds/event_image.jpg'),
    :description => '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      Proin ipsum dui, bibendum non dignissim ac, auctor in mauris. Integer
      condimentum rutrum mauris et mattis. Nullam suscipit mollis mi vitae
      semper. Nam commodo, erat vel bibendum pharetra, velit nisl lacinia diam,
      in consectetur quam augue luctus velit. Etiam nec nisl dui, ut scelerisque
      dui. In fringilla, nunc in consectetur feugiat, ipsum mauris dignissim
      eros, in bibendum ipsum risus quis turpis. Fusce placerat suscipit
      placerat. Pellentesque elementum fermentum mi, vitae mollis mauris
      laoreet ut. Donec varius lobortis vehicula. Donec id elementum mauris.
      Duis id nulla a est volutpat semper. Donec vitae porta est. Proin velit
      mi, facilisis a placerat ac, adipiscing sed nibh. Sed eu sapien est. Sed
      aliquam leo quis eros varius vitae accumsan ligula consectetur.</p>'
  )
end

# Opportunities

names = [
  'Lorem ipsum dolor sit amet',
  'Sed quam elit',
  'Curabitur venenatis',
  'Nullam at felis eu neque tempor sed'
]

10.times do |i|
  Opportunity.create!(
    :title => names[i % names.length],
    :published => true,
    :content => '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      Proin ipsum dui, bibendum non dignissim ac, auctor in mauris. Integer
      condimentum rutrum mauris et mattis. Nullam suscipit mollis mi vitae
      semper. Nam commodo, erat vel bibendum pharetra, velit nisl lacinia diam,
      in consectetur quam augue luctus velit. Etiam nec nisl dui, ut scelerisque
      dui. In fringilla, nunc in consectetur feugiat, ipsum mauris dignissim
      eros, in bibendum ipsum risus quis turpis. Fusce placerat suscipit
      placerat. Pellentesque elementum fermentum mi, vitae mollis mauris
      laoreet ut. Donec varius lobortis vehicula. Donec id elementum mauris.
      Duis id nulla a est volutpat semper. Donec vitae porta est. Proin velit
      mi, facilisis a placerat ac, adipiscing sed nibh. Sed eu sapien est. Sed
      aliquam leo quis eros varius vitae accumsan ligula consectetur.</p>'
  )
end

# # Posts

# Post.delete_all
# Blog.all.each do |blog|
#  feed = Feedzirra::Feed.fetch_and_parse(blog.rss)
#  feed.entries.select do |entry|
#    Post.create_from_feed_entry(entry, blog)
#  end
# end
