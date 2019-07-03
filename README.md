#  Introduction

Office of Accessibility Resources application for Shippensburg University which replaces an all paper test submission form with a web based solution.

## Installation

Clone this with git and then run the following command in the project. Follow the installation instructions to install Ruby first: http://ruby.railstutorial.org/ruby-on-rails-tutorial-book#sec-rubygems

    bundle install

This will install all of the gem dependencies, and the application is ready to run.

Ensure that you're running the older version of Ruby, `2.1.1`. You may have success with `rbenv` or `rvm` for installation.

## ENV

Create a local `.env` file (in root) with these contents:

```
SMTP_ADDRESS=test
HTTP_AUTH_NAME=test
HTTP_AUTH_PASSWORD=test
```

## Run Tests

RSpec is used to test most functionality. All tests can be run via "rspec" on the command line. Before doing this, you may need to update your migrations with "rake db:migrate test"

```
$ rake db:migrate test
$ rspec
```

## Run Server

Run "rake db:migrate" to get the latest db version. Then run "rail s" to begin a server.

```
$ rake db:migrate
$ rails s
```
