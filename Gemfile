source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Agregar la gema 'pg
gem 'pg'

gem 'bootstrap', '~> 4.5.2'
gem 'jquery-rails'

gem 'devise'

gem 'kaminari'

gem "roo", "~> 2.8.0"

gem "chartkick"
gem 'groupdate'

gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"

gem 'carrierwave', '~> 2.0'

gem "mini_magick"

gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '~> 5.2.4', '>= 5.2.4.4'
gem 'rails', '~> 7.1.3'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

# Use Puma as the app server
# Lo saque por recomendación de la instalación de Passenger
#gem 'puma', '~> 3.11'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer', platforms: :ruby
#gem 'mini_racer', '>=0.2.1'


# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
#  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'listen' , '~> 3.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
#  gem 'spring-watcher-listen', '~> 2.0.0'
end

#group :development, :test do
#  gem 'capistrano', '~> 3.0'
#  gem 'capistrano-rvm'
#  gem 'capistrano-bundler', '1.1.1'
#  gem 'capistrano-rails', '1.1.3'
##  gem ‘capistrano-sidekiq’, github: ‘seuros/capistrano-sidekiq’ # No es necesaria
#end

## TUTORIAL
# Saque todo lo de abajo por instalación de Passenger
#gem 'figaro'
#gem 'puma' #Should already be in your Gemfile

#group :development do
#  gem 'capistrano'
#  gem 'capistrano3-puma'
  #Should already be in your Gemfile
#  gem 'capistrano-rails'
#  gem 'capistrano-bundler'
#  gem 'capistrano-rvm'
#end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
