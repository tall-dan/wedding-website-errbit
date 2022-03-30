# frozen_string_literal: true

after 'deploy:finished', :restart_eye do
  on roles(:app) do
    release_path = fetch(:release_path)
    execute "cd #{release_path} && mkdir -p tmp/pids && chmod 777 tmp/pids"
    execute "cd #{release_path} && RAILS_ENV=production eye load config/unicorn.eye"
    execute "cd #{release_path} && RAILS_ENV=production eye stop errbit"
    execute "cd #{release_path} && RAILS_ENV=production eye start errbit"
  end
end
