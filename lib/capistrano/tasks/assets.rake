# frozen_string_literal: true

after 'deploy:published', :compile_assest do
  on roles(:app) do
    execute "cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile"
  end
end
