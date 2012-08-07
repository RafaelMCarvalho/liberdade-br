# -*- encoding : utf-8 -*-

# User

User.delete_all

User.create!(
  :email => 'admin@base.com',
  :password => '123456',
  :role => :coordinator
)

User.create!(
  :email => 'moderator@base.com',
  :password => '123456',
  :role => :moderator
)

# Configuration

Configuration.delete_all

Configuration.create!(
  :email => 'base@project.com.br'
)

# Pages

Page.delete_all

Page.create!(
  :indicator => Page::PAGES[:contact],
  :title => 'Contato',
  :content => 'Conteúdo da página de contato',
  :published => true
)

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
  :rss => 'http://www.adhominem.com.br/',
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
