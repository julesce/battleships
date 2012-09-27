source 'https://rubygems.org'

gem 'rails', '3.2.8'

group :development, :test do
  gem 'rspec-rails', '~> 2.11.0'
  gem 'shoulda-matchers', '~> 1.2.0'
  gem 'factory_girl_rails', '~> 4.0.0'
  gem 'quiet_assets', '~> 1.0.0'
  gem 'sqlite3', '~> 1.3.6'
end

group :test do
  gem 'guard-rspec', '~> 1.2.1'
  gem 'spork', '~> 0.9.0'
  gem 'guard-spork', '~> 0.3.2'
  gem 'capybara', '~> 1.1.2'
end

group :production do
  gem 'pg'
  gem 'thin'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.0.4.0'
end

gem 'jquery-rails', '~> 2.0.2'
gem 'newrelic_rpm'

# Lets build some pretty forms
gem 'simple_form', '~> 2.0.2'

# Seed our data smartly
gem 'seed-fu', '~> 2.2.0'