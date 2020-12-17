# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* How to run the test suite

## Prerequisites

You need to install all of this before moving to next step.

* [Git](http://git-scm.com/)
* [Ruby](https://www.ruby-lang.org/en/downloads/) version >= 2.6.6
* [Rails](https://rubyonrails.org/) version >= 6.0.0
* [MySQL](https://dev.mysql.com/downloads/)

## Installation

1. Clone repo: `git clone https://github.com/thuc-pt/rails-base-api.git`
2. Move to project: `cd rails-base-api`
3. Install gem: `bundle install`
4. Make sure you are able to access MySQL: `mysql -u root -p`
5. Setup database: `rails db:create && rails db:migrate`
6. Start server: `rails server`

Now, API server should be running on [http://localhost:3000/docs](http://localhost:3000/docs)

**IMPORTANT**

Setup local environment variable. This is MUST, because the project need these variable to config & run properly.
You can also keep any sensitive information here.
 - Move to project root folder `cd rails-base-api`
 - Create local database file using sample file `cp config/database.yml.sample config/database.yml`
 - Create local environment file using sample file `cp config/application.yml.sample config/application.yml`
 - Modify it to fit with you `nano config/appliation.yml`

  ```bash
    DATABASE_HOSTNAME: <Hostname mysql>
    DATABASE_USERNAME: <Username mysql>
    DATABASE_PASSWORD: <Password mysql>
  ```
