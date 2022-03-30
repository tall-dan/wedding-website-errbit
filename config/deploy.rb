# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "errbit"
set :repo_url, 'https://github.com/tall-dan/wedding-website-errbit'
ask :branch, :main

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/secrets.yml'

set :conditionally_migrate, true
set :chruby_ruby, `cat .ruby-version`.chomp

# Default value for linked_dirs is []
append :linked_dirs, '.bundle'
set :bundle_binstubs, -> { shared_path.join('bin') }            # default: nil
set :bundle_env_variables, { RAILS_ENV: 'production' }
set :bundle_jobs, 2 # default: 4, only available for Bundler >= 1.4

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
