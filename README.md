##### MYSQL DOWNLOAD, UP AND RUNNING #####
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

== FOR MAC EL Captain ==

-- Download mysql
1. brew install mysql

-- Start mysql server (keep the default configs)
   default configs: (username: root, <just press Enter for password>)
1. sudo mysql.server start

NOTE: In case of issues starting the server - run the following
1. sudo chown -R _mysql:_mysql /usr/local/var/mysql

reference: https://gorails.com/setup/osx/10.11-el-capitan
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

== FOR LINUX BASED SYSTEMS ==

-- Download mysql
1. sudo apt-get update
2. sudo apt-get install mysql-server mysql-client libmysqlclient-dev
   (Press Enter for the password)
3. sudo mysql_install_db
4. sudo mysql_secure_installation
   (Press Enter when asked for password. Press 'n' in the next prompt)

reference: https://www.digitalocean.com/community/tutorials/how-to-use-mysql-with-your-ruby-on-rails-application-on-ubuntu-14-04
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





##### REDIS DOWNLOAD, UP AND RUNNING #####
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

== FOR MAC EL Captain ==

-- Download redis
1. curl -O http://download.redis.io/redis-stable.tar.gz
2. tar -xvzf redis-stable.tar.gz
3. rm redis-stable.tar.gz
4. cd redis-stable
5. make
6. sudo make install

reference: http://lifesforlearning.com/install-redis-mac-osx/
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

== FOR LINUX BASED SYSTEMS ==

-- Download reids
1. sudo apt-get update
2. sudo apt-get install build-essential
3. sudo apt-get install tcl8.5
4. wget http://download.redis.io/releases/redis-stable.tar.gz
5. tar xzf redis-stable.tar.gz
6. cd redis-stable
7. make
8. make test
9. sudo make install
10. cd utils
11. sudo ./install_server.sh

reference: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





###### PREPARE SOURCE CODE ######
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ASSUMPTIONS:
1. Ruby 2.2.0 is present on your machine
2. Redis is running on localhost:6379
3. mysql service is running in background


-- Install Rails
1. gem install rails -v 4.2.0

-- Run the following commands under the '/task_scheduler' directory
1. bundle
2. rake db:setup

-- Running test suit
   (run the following command under the '/task_scheduler' directory)
1. rspec --format documentation
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





###### RUNNING DEMO TASKS ######
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ASSUMPTIONS:
1. Redis is running on localhost:6379

-- Setting up dummy data (under '/task_scheduler' directory)
1. rake db:drop
2. rake db:setup && rails s

-- Running the agent with seed key
   (run the following command under the main directory)
1. sh agent/init_agent.sh development first

-- Running angular application
   (run the following command under the '/ui' directory)
1. gulp

NOTE: 3 out of 4 tasks will execute within 60 seconds of starting the rails server
      provided agent is running.

-- View agent logs @ runtime
   (run the following command under the '/agent/log' directory)
1. tail -f agent.log






###### RUNNING THE PROJECT ######
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ASSUMPTIONS:
1. All servers are running on localhost, else change config files
  - server-configs:
  1. '/task_scheduler/config/redis.yml'
  2. '/task_scheduler/config/database.yml'

  - agent-configs:
  1. '/agent/config.yml'


-- Running rails server
   (run the following command under the '/task_scheduler' directory)
1. rails s

-- Running angular application
   (run the following command under the '/ui' directory)
1. gulp

-- Running the agent
   (run the following command under the main directory)
1. sh agent/init_agent.sh development

-- View agent logs @ runtime
   (run the following command under the '/agent/log' directory)
1. tail -f agent.log

-- View dummy tasks - under the '/dummy_tasks' directory
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
