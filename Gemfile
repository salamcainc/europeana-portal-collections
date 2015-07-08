source 'https://rubygems.org'

ruby '2.2.2'
gem 'rails', '4.2.3'

# Use the Europeana styleguide for UI components (templates)
gem 'europeana-styleguide',
  github: 'europeana/europeana-styleguide-ruby',
  ref: 'c5f5cecee9'

# Use a forked version of stache with a downstream fix, until merged upstream
# @see https://github.com/agoragames/stache/pull/53
gem 'stache', github: 'rwd/stache', ref: 'd1408f1'

# pending merge of https://github.com/projectblacklight/blacklight/pull/1210
gem 'blacklight', '~> 5.14.0'
gem 'bootstrap-sass', '3.3.5.1'
gem 'compass-rails'
gem 'europeana-api', '~> 0.3.3'
gem 'europeana-blacklight', '0.1.0'
gem 'eventmachine', '~> 1.0.6' # Ruby 2.2 compatible version
gem 'feedjira', '~> 2.0'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'mysql2'
gem 'puma', '~> 2.11.0'
gem 'redis-rails', '~> 4.0'
gem 'sass-rails'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :production do
  gem 'rails_12factor', '~> 0.0.3'
end

group :development, :test do
  gem 'brakeman', require: false # @todo add to CI suite
  gem 'dotenv-rails', '~> 1.0.2'
  gem 'rails_best_practices', require: false # @todo add to CI suite
  gem 'rspec-rails', '~> 3.0'
  gem 'rubocop', '0.29.1', require: false
end

group :development do
  gem 'spring', '~> 1.3.6'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara', '~> 2.4.0'
  gem 'coveralls', require: false
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'webmock', '~> 1.21.0'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :localeapp do
  gem 'localeapp', '~> 0.9.0'
end
