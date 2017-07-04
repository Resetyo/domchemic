source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'sqlite3', group: :development
gem 'mysql2', '~> 0.3.18', group: :production
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-sass',  '~> 4.3'
gem 'devise'
gem 'cancancan', '~> 1.10'
gem "rolify"
gem 'rails_admin', '~> 1.2'
gem 'rails_admin_rollincode', '~> 1.0'
gem 'roo-xls'
gem 'datagrid', '1.5.4'

gem "capistrano", '3.6.1'
gem 'capistrano-bundler', '1.1.4'
gem 'capistrano-rails', '1.1.7'
gem 'capistrano-rvm', '0.1.2', github: "capistrano/rvm"

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
