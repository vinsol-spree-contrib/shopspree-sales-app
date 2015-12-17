source 'https://rubygems.org'

gem 'rails',                                  '4.2.4'
gem 'mysql2',                                 '~> 0.3.18'
gem 'jquery-rails',                           '~> 4.0.3'
gem 'jquery-ui-rails',                        '~> 5.0.3'
gem 'paperclip',                              '~> 4.2.4'
gem 'spree',                                  github: 'spree/spree',                        branch: '3-0-stable'
gem 'spree_gateway',                          github: 'spree/spree_gateway',                branch: '3-0-stable'
gem 'spree_auth_devise',                      github: 'spree/spree_auth_devise',            branch: '3-0-stable'
gem 'spree_mail_settings',                    github: 'spree-contrib/spree_mail_settings',  branch: '3-0-stable'
gem 'spree_ams',                              github: 'hhff/spree_ams',                     branch: '3-0-alpha'
gem 'spree_reviews',                          github: 'spree-contrib/spree_reviews',        branch: '3-0-stable'
gem 'spree_address_book',                     github: 'romul/spree_address_book',           branch: '3-0-stable'
gem 'aws-sdk',                                '< 2.0'

group :assets do
  gem 'therubyracer',                         '~> 0.12.1', platforms: :ruby
  gem 'uglifier',                             '~> 2.7'
  gem 'sass-rails',                           '~> 5.0'
  gem 'coffee-rails',                         '~> 4.1.0'
end

group :production do
  gem 'rails_12factor',                       '~> 0.0.3'
  gem 'pg',                                   '~> 0.18.3'
end

group :development, :test do
  gem 'byebug',                               '~> 5.0.0'
  gem 'web-console',                          '~> 2.0'
  gem 'quiet_assets',                         '~> 1.1.0'
end

group :development do
  gem 'capistrano',                           '~> 3.2.1'
  gem 'capistrano-bundler',                   '~> 1.1.4'
  gem 'capistrano-rails',                     '~> 1.1.3'
  gem 'binding_of_caller',                    '~> 0.7.2'
  gem 'better_errors',                        '~> 2.0.0'
  gem 'bullet',                               '~> 4.14.7'
end

group :test do
  gem 'rspec-rails',                          '~> 3.1.0'
  gem 'rspec-activemodel-mocks',              '~> 1.0.1'
  gem 'factory_girl_rails',                   '~> 4.4.1'
  gem 'shoulda-matchers',                     '~> 2.8.0', require: false
  gem 'shoulda-callback-matchers',            '~> 1.1.3'
  gem 'simplecov',                            '~> 0.9.2', require: false
end
