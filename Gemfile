source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Use devise for user authentication, authorization, management, etc.
gem 'devise'

# Use HAML instead of ERB for templates
gem 'haml-rails'

# Use Resque for notification job queue
gem 'resque'

gem 'mysql2', '~> 0.3'

# Use redis for GCM registration tokens. Use hiredis for high performance redis
# (non-portable!)
gem 'redis',   '~> 3.0.2'
gem 'hiredis', '~> 0.4.5'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'


# Used in development and test environments
group :development, :test do
  # Generates fake names, descriptions, etc.
  gem 'faker'

  # Factory for model objects
  gem 'factory_girl_rails', '~> 4.1'
end
