# To use Gemfiles see bundler.io
# To install: sudo gem install bundler
# To use: bundler install or bundler update
# To remove all gems not required in this file:
#   sudo bundle clean --force # Note: normally sudo isn't good for bundle but this is an exception
# To remove all gems in the system completely:
#   sudo gem list | cut -d" " -f1 | sudo xargs gem uninstall -aIx
# This helps ensure that you aren't depending on a gem that isn't installed from this list
# To update your gems after changing a version requirement below run:
#   bundle update
# To bundle gems for production or staging, recommend:
#   bundle install --without dev_test
source 'https://rubygems.org'
gem 'rake'
# core gems (need to be careful about version updating)
gem 'activerecord', '~> 4.2.0'
gem 'actionview', '~> 4.2.0'
gem 'sinatra', '~> 1.4.5'
gem 'sinatra-contrib', '~> 1.4.2'
gem 'warden', '~>1.2.3'

gem 'lt-core',
    git: 'https://792de6a69ea9f5e82e17ca9d46d920b19462cfe4@github.com/learningtapestry/core',
    ref: '1508c2acd1c429dc811648c07596826f8ab93ed6'

# additional gems (probably can accept new major versions without breaking)
gem 'edge', :git => 'git://github.com/JackC/edge'
gem 'deep_merge', :git => 'git://github.com/science/deep_merge'
gem 'sinatra-param', ">= 1.2.2"
gem 'redis', '>= 3.2.0'
gem 'log4r', '>= 1.1.10'
gem 'pg', '>= 0.17.1'
gem 'pg_search', '>= 1.0.5'
gem 'htmlentities', '>= 4.3.2'
gem 'nokogiri', '>= 1.6.3.1'
gem 'bcrypt', '>= 3.1.7'
gem 'chronic', '>= 0.10.2'
gem 'chronic_duration', '>= 0.10.6'
# allows printing with colors to terminal
# squasher - used in development to compress migration files
gem 'to_xls', '>= 1.5.3'
gem 'sinatra-flash'
gem 'sinatra-redirect-with-flash'
gem 'pony', '~> 1.11'
gem 'activemerchant', '~> 1.47'
gem 'algoliasearch', '~> 1.6'
gem 'hiredis'
gem 'readthis'
gem 'sinatra-asset-pipeline', '~> 0.7.0'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'font-awesome-sass'
gem 'truncate_html'
gem 'uglifier'
gem 'therubyracer'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'simple-rss'

# gems for use only in non-production environments
group :debugger do
  gem 'pry-byebug'
  gem 'pry-stack_explorer', '>=0.4.9.1'
  gem 'bullet', '>= 4.14'
end

group :test do
  gem "factory_girl", "~> 4.0"
end

group :profile do
  gem 'ruby-prof'
  gem 'rack-mini-profiler'
end
