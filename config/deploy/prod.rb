role :web, %w{s-model@128.199.81.40}
role :app, %w{s-model@128.199.81.40}

set :rvm_ruby_version, '2.2.3@s-model'
set :rvm_type, :user
set :branch, :master
set :rails_env, 'production'

server '128.199.81.40', user: 's-model', roles: %w{web app}
