source 'https://rubygems.org'
ruby "2.4.2"

gem 'pg'
gem 'rails', '~> 4.2.0'
gem 'sass-rails', '~> 4.0.3'
gem 'autoprefixer-rails', '~> 5.1.11'
gem 'uglifier', '>= 1.3.0'
gem 'haml-rails'
gem 'paper_trail', '~> 4.0.0.rc'
gem 'by_star', '~> 2.2.1'
gem 'dateslices'
gem 'redcarpet'

group :test do
  gem 'factory_bot_rails'
  gem 'vcr'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'timecop'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.7'
  gem 'dotenv-rails'
  gem 'pry'
end

group :development do
  gem 'wirble'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'growl'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'rubocop', require: false
  gem 'rack-mini-profiler'
end

group :production do
  gem 'rails_12factor'
end

