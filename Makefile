specs:
	@echo ""
	@echo "======================"
	@echo "Rodando todas as specs"
	@echo "======================"
	@echo ""
	@rspec spec --format progress

install:
	@echo ""
	@echo "=================================="
	@echo "Instalando dependencias do sistema"
	@echo "=================================="
	@echo ""
	@sudo apt-get install imagemagick libmagickcore-dev libmagickwand-dev
	@echo "Dependencias da gem curb que por sua vez é dependencia da gem feedzirra"
	@sudo $ sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev


banco:
	@echo "================================"
	@echo "Recriando banco de dados do zero"
	@echo "================================"
	@sed -i s/^/\#/ config/initializers/rails_admin.rb
	@rake db:drop:all
	@rake db:create:all
	@rake db:migrate
	@sed -i '1 i \# -*- encoding : utf-8 -*-' db/schema.rb
	@rake db:test:prepare
	@rake db:seed
	@sed -i s/^\#// config/initializers/rails_admin.rb
