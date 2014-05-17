source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.5'
gem 'validates_email_format_of'
gem 'validates_existence'
gem 'figaro'
gem 'newrelic_rpm'

gem 'rails_email_preview', '~> 0.2.16'
gem 'premailer-rails'

gem 'axlsx'

gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-sass'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-timepicker-addon-rails'
gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
gem 'jquery-turbolinks'
gem 'turbolinks'

gem 'factory_girl_rails'

gem 'sidekiq', '~> 2.17.7'
gem 'sidetiq'
gem 'sinatra', '>= 1.3.0', :require => nil

# Using SQLLite for database because PG is overkill
gem 'sqlite3'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'rspec-tag_matchers'
  # database in development/test is sqlite
end

group :development do
  gem 'rails_layout'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

ruby '2.1.1'
