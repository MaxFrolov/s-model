# S-model web service back-end

SaaS for displaying popups on sites.

## Installation

It's preferable that you'll use RVM for managing gems and ruby versions.

Clone this repo with `git clone` and then `cd` into the project's directory.
Install appropriate version of ruby if you haven't installed it yet and create gemset for the project (according to **.ruby-version** and **.ruby-gemset**).

Install gems by running

    bundle install

Copy **.env.example** as **.env** and configure project settings inside this file.
Also copy **config/database.example.yml** as **config/database.yml** and configure your database connection.


Create database and run migrations (you need PostgreSQL up and running):

    rake db:create
    rake db:migrate

Seed database with test data:

    rake db:seed

Start your server:

    rails server
