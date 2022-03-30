# frozen_string_literal: true

DEPLOY_PATH = '/var/www/errbit'
pid_path = 'tmp/pids/unicorn.pid'
socket_file = "#{DEPLOY_PATH}/shared/.dashboard_unicorn.sock"
worker_processes 2
timeout 30
preload_app true
pid pid_path
listen socket_file, backlog: 1024
stderr_path 'log/unicorn-err.log'
stdout_path 'log/unicorn-out.log'

before_fork do |server, _worker|
  old_pid_path = "#{pid_path}.oldbin"
  if File.exist?(old_pid_path) && server.pid != old_pid_path
    begin
      Process.kill('QUIT', File.read(old_pid_path).to_i)
    rescue Errno::ENOENT, Errno::ESRCH # rubocop:disable Lint/HandleExceptions
    end
  end
end

after_fork do |_server, _worker|
end
