# frozen_string_literal: true

after 'deploy:finished', :restart_eye do
  on roles(:app) do
    release_path = fetch(:release_path)
    execute "cd #{release_path} && mkdir -p tmp/pids && chmod 777 tmp/pids"
    execute "cd #{release_path} && mkdir -p log && chmod 777 log"
    execute "cd #{release_path} && #{shared_path}/bin/eye load config/unicorn.eye"
    execute "cd #{release_path} && #{shared_path}/bin/eye stop errbit"
    execute "cd #{release_path} && #{shared_path}/bin/eye start errbit"
  end
end
