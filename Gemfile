source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
gem "mysql2", '0.3.18'

gem "seo_helper"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer'
gem "rufus-scheduler", "2.0.24"

gem 'will_paginate', '~> 3.1.0'
gem 'money'
gem 'active_merchant_allpay', github: 'imgarylai/active_merchant_allpay'

gem 'delayed_job_active_record'
gem "daemons"

gem 'jquery-rails'
gem 'bootstrap', '~> 4.0.0.beta.2'
gem "fog"
gem "omniauth-oauth"
gem "omniauth-facebook", '4.0.0'
gem 'devise', '4.5.0'
gem 'activeadmin'
gem 'redcarpet'
gem 'simple_form'
gem 'country_select'
gem 'rails-i18n', '~> 5.0.0'
gem 'factory_bot_rails', '~> 4.0'
# gem 'friendly_id'
gem 'exception_notification'
gem 'httparty'
gem 'timecop'
gem 'carrierwave', '0.10.0' 
gem 'mini_magick', "3.6.0"
gem 'config'
gem "aws-ses", "~> 0.5.0", :require => 'aws/ses'

# gem 'aws-sdk', '~> 1.66' # 連線 AWS 的 gem, 目前 paperclip 會使用
#gem 'cancancan', '~> 2.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'rspec-rails', '~> 3.6'
  gem 'guard-rspec', require: false
  # gem "rack-livereload"
  # gem 'guard-livereload', '~> 2.5', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry'
  gem 'pry-doc'
  # gem 'capistrano', '~> 3.6'
  gem "rvm-capistrano"
  # gem "capistrano" ,:git => "https://github.com/capistrano/capistrano.git" # 站台部屬
  gem "capistrano" , '2.15.4' # 站台部屬 升級 rails 4 加上版本號
  # gem 'capistrano-rails', '~> 1.3'
  # gem 'capistrano-rbenv', '~> 2.1'
  gem 'letter_opener'
end

group :production, :test do
  # Postgres
  # gem 'pg'
end

group :test do
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Alain uses PG also for dev and testing to mimic the live server
if `hostname` == "debzen"
  gem 'pg'
end
