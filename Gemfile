source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '3.0.0'

gem 'rails', '~> 6.1.2', '>= 6.1.2.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.4', '>= 5.4.3'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'docker-api', '~> 2.0'
gem 'redis', '~> 4.2', '>= 4.2.5'
gem 'capistrano', '~> 3.11'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
gem 'rexml', '~> 3.2', '>= 3.2.4'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'guard-rspec', '~> 4.7'
end
