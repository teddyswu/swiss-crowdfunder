# -*- encoding : utf-8 -*-

# 用rvm必加require "rvm/capistrano"
# 不加會bundle找不到
# 當然local必須安裝rvm-capistrano
# gem install rvm-capistrano
# 參考 -> http://rayshih.github.io/blog/2012/11/03/the-first-time-setup-server-on-linode/
require 'rails/all'
require "bundler/capistrano"
require "rvm/capistrano"

current_deploy = YAML.load_file("config/deploy.yml")[:current]
current_config = YAML.load_file("config/deploy.yml")[current_deploy.to_sym]

ready_to_upload_files = "tmp/conf/#{current_config[:tmp_dir]}/*" #"config/conf_example/*"

# set :use_sudo 不可以用["false"]或者[:false], 要用[false], 要留意一下
# 參考 -> http://stackoverflow.com/questions/10761534/capistrano-using-sudo-even-with-set-use-sudo-false
set :application, "sogi"
set :user, "apps"
set :domain, current_config[:ip]

# RVM設定
# 參考 -> http://ruby-china.org/topics/6424
# 參考 -> http://rvm.io/integration/capistrano#environment
# set :rvm_ruby_string, '2.0.0-p247'
set :rvm_ruby_string, '2.1.2'
set :rvm_type, :user

# git & depoly路徑設定
set :scm, :git
set :branch, "develop" #可以設定master/develop
set :repository, "git@github.com:200ok-ungleich/swiss-crowdfunder.git"
set :deploy_to, "/home/apps/#{current_config[:project]}/#{application}" # 可以放指定目錄

# options
set :deploy_via, :copy
set :git_shallow_clone, 1
set :rails_env, "production"
set :use_sudo, false

# HTTP server設定
role :web, domain
role :app, domain
role :db, domain, :primary => true

# 解決no tty present and no askpass program specified....的問題
# :shell是用來設定執行指令時，預設的shell是哪一種。
# 當設定成false時，表示capistrano會直執行指令，而不使用shell來執行指令。
# :pty設成true時，將使用pseudo-tty來執行指令。
# 有些指令必須要用pseudo-tty才能執行，
# 但使用pseudo-tty預設不會載入使用者的bashrc。
# 參考 -> https://sites.google.com/site/wangsnotes/ruby/ror/deployment
default_run_options[:pty] = true





# 若想要蓋掉預設的deploy task就寫在這邊
namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "站台重啟"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  # 覆寫及觀念
  # 參考 -> http://gogojimmy.net/2012/07/03/understand-assets-pipline/
  # 參考 -> http://stackoverflow.com/questions/9016002/speed-up-assetsprecompile-with-rails-3-1-3-2-capistrano-deployment
  namespace :assets do
    desc "Precompile assets on local machine and upload them to the server."
    task :precompile, :roles => :web, :except => {:no_release => true} do
      # from這個變數在指派的時候, 只有在server在第一次佈署的時候會出錯, 出錯的話就給 nil
      from = source.next_revision(current_revision) rescue nil
      # from是nil表示該server第一次佈署就一定要執行assets:precompile,
      # 後面的判斷是最後一個版本跟現在本機的assets有差異的話就執行assets:precompile
      if from.nil? || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run_locally "bundle exec rake assets:precompile"
        run_locally "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{domain}:#{shared_path}/"
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end

end

namespace :staging do
  desc "Run a task on a remote server."
  # cap staging:invoke COMMAND=data_conversion:tw_remove_garbage_data
  task :invoke do
    if ENV['COMMAND'].to_s.strip == ''
      puts "USAGE: cap rake_task:invoke COMMAND='db:migrate'"
    else
      run "cd #{current_path} && RAILS_ENV=production rake #{ENV['COMMAND']}"
    end
  end
end

# 這邊可以寫自定義的task
namespace :custom do

  # 可以把本機的conf_example的範例設定檔複製到server上
  # scp是linux指令, 可以把本機的東西上傳至server
  # 參考 -> http://linux.vbird.org/linux_server/0310telnetssh.php
  desc <<-DESC
    把本機的檔案上傳到deploy的server上
  DESC
  task :config_setup, :role => [:web] do
    run "rm -rf #{shared_path}/config"
    run "mkdir -p #{shared_path}/config"
    run_locally "scp #{ready_to_upload_files} #{user}@#{domain}:#{shared_path}/config/"
  end

  desc "更新完程式之後連結conifg檔"
  task :symlink_config, :roles => [:web] do
    run "mkdir -p #{deploy_to}/shared/log"
    run "mkdir -p #{deploy_to}/shared/pids"

    symlink_hash = {
      "#{shared_path}/config/customization.yml" => "#{release_path}/config/customization.yml",
      "#{shared_path}/config/database.yml" => "#{release_path}/config/database.yml",
      "#{shared_path}/config/aws.yml" => "#{release_path}/config/aws.yml",
      "#{shared_path}/config/authorization_key.yml" => "#{release_path}/config/authorization_key.yml",
      "#{shared_path}/config/newrelic.yml" => "#{release_path}/config/newrelic.yml",
      "#{shared_path}/config/schedule_timer.yml" => "#{release_path}/config/schedule_timer.yml",
      "#{shared_path}/config/external_api.yml" => "#{release_path}/config/external_api.yml",
      "#{shared_path}/config/secrets.yml" => "#{release_path}/config/secrets.yml",
      "#{shared_path}/config/spree.yml" => "#{release_path}/config/spree.yml",
      "#{shared_path}/config/appsignal.yml" => "#{release_path}/config/appsignal.yml",
      "#{shared_path}/config/skylight.yml" => "#{release_path}/config/skylight.yml",
      "#{shared_path}/config/Translate_API_Project-797b2ce618ab.p12" => "#{release_path}/config/Translate_API_Project-797b2ce618ab.p12"
    }

    # 將檔案複製捷徑到current的目錄
    # ln 指令是連結目標檔的意思, 類似windows的複製捷徑
    # 參考 -> http://linux.vbird.org/linux_basic/redhat6.1/linux_06command.php#ln
    symlink_hash.each do |source, target|
      run "ln -sf #{source} #{target}"
    end
  end

  desc <<-DESC
    佈署完重啟, 若沒有人去request, 那台server就不會初始化, 所以寫這個task來request server
  DESC
  task :tell_the_server do
    # run_locally "wget http://#{}"
  end
end

# 執行完deploy:setup就把local端的config檔印到server上的某個目錄
after "deploy:setup", "custom:config_setup"

# 同步完程式碼, 要連結config目標檔
after "deploy:finalize_update", "custom:symlink_config"

# 同步完程式、跑完bundle之後就執行rake db:migrate
after "deploy:finalize_update", "deploy:migrate"
