RAILS_ENV = "production"
RUBY = "/home/ubuntu/.rubies/2.7.5/bin/ruby"

app_name = 'errbit'
rails_root = "/var/www/errbit/current"
rails_env = RAILS_ENV

Eye.application(app_name) do
  env 'RAILS_ENV' => RAILS_ENV

  # unicorn requires to be `ruby` in path (for soft restart)
  env 'PATH' => "#{File.dirname(RUBY)}:#{ENV['PATH']}"
  env 'BUNDLE_GEMFILE' => "#{rails_root}/Gemfile"
  working_dir rails_root

  process('errbit') do
    pid_file File.join(rails_root, 'tmp', 'pids', 'unicorn.pid')
    start_command 'bundle exec unicorn -Dc config/unicorn.rb'
    stdall 'log/unicorn.log'
    stop_signals [:TERM, 10.seconds]
    restart_command "kill -USR2 {{PID}}"

    start_timeout 30.seconds
    restart_grace 13.seconds


    check :cpu, every: 30, below: 80, times: 3
    check :memory, every: 30, below: 150.megabytes, times: [3, 5]

    monitor_children do
      stop_command "kill -QUIT {{PID}}"
      check :cpu, every: 30, below: 80, times: 3
      check :memory, every: 30, below: 150.megabytes, times: [3, 5]
    end
  end
end

