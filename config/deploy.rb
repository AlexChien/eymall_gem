set :application, "eymall"
set :deploy_to, "/usr/local/webservice/htdocs/#{application}"
#set :use_sudo, true
set :use_sudo, false

# Whatever you set here will be taken set as the default RAILS_ENV value
# on the server. Your app and your hourly/daily/weekly/monthly scripts
# will run with RAILS_ENV set to this value.
set :rails_env, "production"

# NOTE: for some reason Capistrano requires you to have both the public and
# the private key in the same folder, the public key should have the 
# extension ".pub".
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/id_rsa"]

set :scm, :git
set :scm_verbose, true
set :branch, "master"
#set :scm_user, 'alexchien'
#set :scm_passphrase, "alexgem"
set :repository,  "git@github.com:AlexChien/eymall.git"
set :deploy_via, :remote_cache


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :user, "mongrel"
set :runner, "mongrel"

set :rails_env, "production"

# Your EC2 instances. Use the ec2-xxx....amazonaws.com hostname, not
# any other name (in case you have your own DNS alias) or it won't
# be able to resolve to the internal IP address.
set :domain, "202.109.80.180"
role :app, domain
role :web, domain
#role :product, "192.168.1.1"
#role :pre_product, "192.168.1.2"
role :db,  domain, :primary => true

## Add mongrel cluster support ##
require 'mongrel_cluster/recipes'
set :mongrel_conf, "#{shared_path}/config/mongrel_cluster.yml"
set :mongrel_user, "mongrel"


# add misc task here
namespace :deploy do
  desc "Generate database.yml and Create asset packages for production, minify and compress js and css files" 
  task :after_update_code, :roles => [:web] do
    database_yml
    # app_config
    # asset_packager
  end
  
  # add soft link script for deploy
  desc "Symlink the upload directories"
  task :after_symlink, :roles => [:web] do
    ## create link for shared assets
    # run "#{release_path}/script/relink.sh #{shared_path}/assets #{release_path}/public/images/assets #{previous_release} #{release_name} assets"
    ## create link for mongrel cluster 
    
    backup_db
    migrate
  end
  
  # customized tasks
  desc "Backup Mysql"
  task :backup_db, :roles => [:web] do
  run "#{shared_path}/script/mysql_backup.pl eymall_production:utf8 #{releases.last} "
  end
 
  desc "Generate Production database.yml"
  task :database_yml, :roles => [:web] do
    db_config = "#{shared_path}/config/database.yml.production" 
    run "cp #{db_config} #{release_path}/config/database.yml"
  end 
  
  desc "Generate app_config.yml"
  task :app_config, :roles => [:web] do
    app_config = "#{shared_path}/config/app_config.yml.production" 
    run "cp #{app_config} #{release_path}/config/app_config.yml"
  end 
  
  # desc "Create asset packages for production, minify and compress js and css files"
  # task :asset_packager, :roles => [:web] do
  #   run <<-EOF
  #   cd #{release_path} && rake RAILS_ENV=production asset:packager:build_all
  #   EOF
  # end 
  
  # more info about automatially update and incoporate REASON and UNTIL variable
  # check this out: http://www.letrails.cn/archives/customize-capistrano-maintenance-page
  namespace :web do
    task :disable do
      on_rollback { delete "#{shared_path}/system/maintenance.html" }
      maintenance = File.read("./public/maintenance.html")
      put maintenance, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end

end

##For testing##

#namespace :develop do
#  desc "Set pre_product ENV"
#  task :settings, :roles => [:pre_product] do
#    set :rails_env,   "development" 
#  end
#  desc "Test say hellp"
#  task :hello, :roles => [:pre_product] do
#    run "echo hello" 
#  end
  ##run task##
  #########
#end
