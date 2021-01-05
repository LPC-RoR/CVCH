# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

# Es el stage de la aplicación, obviamente producción
set :stage, 'production'

set :application, "cvch"
set :repo_url, "git@github.com:LPC-RoR/CVCH.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# Indica el directorio donde se dejará la aplicación
set :deploy_to, "/var/www/html/cvch"

# Variables de entorno necesarias para el despliegue con RVM    
set :rvm_type, :user
set :rvm_ruby_version, '2.7.1p83'
set :rvm_binary, '~/.rvm/bin/rvm'
set :rvm_bin_path, "$HOME/bin"
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :user, "ec2-user"
set :use_sudo, true
set :deploy_via, :copy
#############################################################

### HCH lo agregue tratando de arreglar el PROBLEMA
set :rvm_map_bins, %w{gem rake ruby rails bundle}

# Default value for :format is :airbrussh.
# set :format, :airbrussh
set :format, :pretty
set :rails_env, fetch(:stage)

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
# Indica directorios de la aplicación que se deberán conservar con cada deploy nuevo
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# Número de releases de la aplicación que capistrano guardará como respaldo
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# Variables de entorno para passenger
set :passenger_environment_variables, { :path => '/usr/lib/ruby/vendor_ruby/phusion_passenger/bin:$PATH' }
set :passenger_restart_command, '/usr/lib/ruby/vendor_ruby/phusion_passenger/bin/passenger-config restart-app'

namespace :deploy do 
  ## Tarea que pregunta por la rama desde la cúal se hará el despliegue 
  desc "Make sure local git is in sync with remote." 
  task :check_revision do 
  on roles(:app) do 
  unless `git rev-parse HEAD` == `git rev-parse origin/master` 
  puts "WARNING: HEAD is not the same as origin/master" 
  puts "Run `git push` to sync changes." 
  exit 
  end 
  end 
  end 
  # Tarea que se ejecuta luego de el despliegue, para: 
  # – Instalar gemas 
  # – Dar permisos de directorios 
  # – Crear bases de datos y correr migraciones 
  # – Compilar los assets en producción 
  # – Reiniciar el servidor 
  # Toma en cuenta que aqui puedes correr practicamente cuaquier comando que se te ocurra 
  desc 'Restart application' 
  task :restart do 
  on roles(:app), in: :sequence, wait: 5 do 
  within release_path do 
  execute :bundle, 'install' 
  execute :chmod, '777 '+release_path.join('tmp/cache/').to_s 
  execute :chmod, '777 '+release_path.join('log/').to_s 
  execute :rake, 'db:create RAILS_ENV=production' 
  execute :rake, 'db:migrate RAILS_ENV=production' 
  execute :rake, 'assets:precompile RAILS_ENV=production' 
  execute 'sudo service apache2 restart' 
  end 
  end 
  end 
  
  ## Callbacks de las tareas definidas anteriormente 
  before :starting, :check_revision 
  after :finishing, :restart
end