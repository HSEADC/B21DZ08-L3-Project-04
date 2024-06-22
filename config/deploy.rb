# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"

set :rbenv_type, :user
set :rbenv_ruby, "3.2.4"

set :application, "lootok"
set :repo_url, "git@github.com:HSEADC/B21DZ08-L3-Project-04.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :branch, "main"
set :rails_env, "production"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/apps/#{fetch :application}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/master.key", "config/puma.rb", "config/credentials.yml.enc"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/uploads", "vendor/javascript", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :puma_init_active_record, true
set :puma_enable_socket_service, true
set :puma_conf, -> { File.join(shared_path, 'config', 'puma.rb') }

set :ssh_options, verify_host_key: :never

namespace :logs do
    desc "Tail application logs"
    task :tail do
      on roles(:app) do
        execute "tail -f #{shared_path}/log/production.log" # Adjust the log path as per your environment
      end
    end
  end

  namespace :deploy do
  desc 'Seed the database'
  task :seed do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end

after 'deploy:migrate', 'deploy:seed'
