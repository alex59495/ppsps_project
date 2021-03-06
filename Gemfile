source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "actionview", ">= 6.0.3.3"
# Be able to redirect with a post method
gem 'repost'
# bootstrap
gem 'bootstrap', '~> 5.0.0.alpha1'
# Handle nested form
gem "cocoon"

# Cloudinary
gem 'cloudinary'

# Internationalization gem
gem 'i18n'
gem 'rails-i18n'
gem 'devise-i18n'

# Autocomplete geocoding
gem "geocoder"
gem "figaro"

# Kaminari : allow pagination in my controller API for PPSP
gem 'kaminari'

# React
gem 'react-rails'
gem 'turbolinks_render'

# Text Editor in rails
gem 'tinymce-rails', '~> 5.6.2.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'devise'

# Authorization
gem 'pundit'

# Analyze the images
# gem "mini_magick"

# Gérer les validation d'active storage
gem 'active_storage_validations'

# Advanced search
gem 'pg_search'

# Faker
gem 'faker'

# Handle PDF
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# Tokens for API
gem 'simple_token_authentication'

gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'wicked'
group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'travis'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-json_expectations'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  # Handle N+1
  gem 'bullet'
  # Verify speed
  gem 'rack-mini-profiler'
end

group :test do
  gem 'database_cleaner-active_record'
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '>= 2.15'
  # gem 'selenium-webdriver'
  # # Easy installation and use of web drivers to run system tests with browsers
  # gem 'webdrivers'
  # gem 'launchy'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
