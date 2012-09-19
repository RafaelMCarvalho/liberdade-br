# -*- encoding : utf-8 -*-
default_run_options[:pty] = true

set :env, "production"

## Whenever options
set :whenever_environment, defer { env }
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :user, 'web'

set :user_path, "/home/#{user}" #apenas uma variavel auxiliar
set :deploy_to, "#{user_path}/liberdade.br/" # aqui ficaram as pastas shared, repos

set :application, "liberdade.br"
set :repository,  "git@bitbucket.org:algorich/liberdade.br.git"
set :keep_releases, 0
set :branch,          "origin/master"

set :use_sudo, false

set :scm, :git
set :scm_verbose, true
set :ssh_options, { :forward_agent => true }


# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :domain, 'liberdade.cc'
role :web, domain
role :app, domain
role :db,  domain, :primary => true # This is where Rails migrations will run

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

# Default variable
default_environment["RAILS_ENV"]    = 'production'
default_environment["PATH"]         = "/home/web/.rvm/gems/ruby-1.9.3-p194@liberdade.br/bin:/home/web/.rvm/gems/ruby-1.9.3-p194@global/bin:/home/web/.rvm/rubies/ruby-1.9.3-p194/bin:/home/web/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
default_environment["GEM_HOME"]     = "/home/web/.rvm/gems/ruby-1.9.3-p194@liberdade.br"
default_environment["GEM_PATH"]     = "/home/web/.rvm/gems/ruby-1.9.3-p194@liberdade.br:/home/web/.rvm/gems/ruby-1.9.3-p194@global"
default_environment["RUBY_VERSION"] = "1.9.3"

namespace :deploy do
 desc "Deploy your application"
 task :default do
   update
   restart
 end

 desc "Setup your git-based deployment app"
 task :setup, :except => { :no_release => true } do
   dirs = [deploy_to, shared_path]
   dirs += shared_children.map { |d| File.join(shared_path, d) }
   run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
   run "git clone #{repository} #{current_path}"
 end

 task :cold do
   update
   migrate
 end

 task :update do
   transaction do
     update_code
   end
 end

 desc "Update the deployed code."
 task :update_code, :except => { :no_release => true } do
   run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
   finalize_update
 end

 desc "Update the database (overwritten to avoid symlink)"
 task :migrations do
   transaction do
     update_code
   end
   migrate
   restart
 end

 task :finalize_update do
   run <<-CMD
     rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids &&
     mkdir -p #{latest_release}/public &&
     mkdir -p #{latest_release}/tmp &&
     cp #{shared_path}/mailer.rb #{latest_release}/config/initializers &&
     ln -s #{shared_path}/log #{latest_release}/log &&
     ln -s #{shared_path}/system #{latest_release}/public/system &&
     ln -s #{shared_path}/pids #{latest_release}/tmp/pids &&
     ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml &&
     ln -sf #{shared_path}/setup_load_paths.rb #{latest_release}/config/
   CMD
 end

 desc "Zero-downtime restart of Unicorn"
 task :restart, :except => { :no_release => true } do
   run "touch #{latest_release}/tmp/restart.txt"
   run "chmod +x #{latest_release}/script/rails"
 end

 namespace :rollback do
   desc "Moves the repo back to the previous version of HEAD"
   task :repo, :except => { :no_release => true } do
     set :branch, "HEAD@{1}"
     deploy.default
   end

   desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
   task :cleanup, :except => { :no_release => true } do
     run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
   end

   desc "Rolls back to the previously deployed version."
   task :default do
     rollback.repo
     rollback.cleanup
   end
 end
end

namespace :database do
 task :migrate   do
  run 'sed -i s/^/\#/ ' + latest_release + '/config/initializers/rails_admin.rb'
  run "cd #{latest_release}; bundle exec rake db:migrate RAILS_ENV=production"
  run 'sed -i s/^\#// '+ latest_release + '/config/initializers/rails_admin.rb'
 end
end

namespace :bundle do
 task :install do
   run "cd #{latest_release} && bundle install --without development test"
 end

 task :update do
   run "cd #{latest_release} && bundle update"
 end
end

namespace :utils do
 task :compile_assets do
   run "rm -Rf #{latest_release}/public/assets"
   run "cd #{latest_release}; rake assets:precompile"
   run "rm -Rf #{deploy_to}/shared/assets"
   run "mv #{latest_release}/public/assets #{deploy_to}/shared"
   run "ln -s #{deploy_to}/shared/assets #{latest_release}/public/assets"
 end

 task :not_compile_assets do
   run "rm -Rf #{latest_release}/public/assets"
   run "ln -s #{deploy_to}/shared/assets #{latest_release}/public/assets"
 end
end

tasks = ['deploy:finalize_update', 'bundle:install', 'database:migrate']

if ENV["assets"]
 tasks << 'utils:compile_assets'
else
 tasks << 'utils:not_compile_assets'
end

ENV['bundle'] == 'update' ? (tasks << 'bundle:update') : ''

after *tasks
