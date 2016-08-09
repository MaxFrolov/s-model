role :web, %w{s-model@10.10.10.10}
role :app, %w{s-model@10.10.10.10}

set :rvm_ruby_version, '2.2.3@s-model'
set :rvm_type, :user
set :branch, :master
set :rails_env, 'production'

server '10.10.10.10', user: 's-model', roles: %w{web app}
