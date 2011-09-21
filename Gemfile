source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

gem 'kaminari'
gem 'devise'
gem "friendly_id", "~> 4.0.0.beta8"
gem 'haml'
gem "ckeditor"
gem "paperclip", "~> 2.3"
gem 'aws-s3'
gem 'transloadit'

gem "cancan"
gem "delayed_job", "~> 2.1"


# Use unicorn as the web server
# gem 'unicorn'
gem 'thin'
# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# group :test do
#   # Pretty printed test output
#   gem 'turn', :require => false
# end


group :production do
  gem 'pg'
end
group :development, :test do
  gem 'mysql2'
end

