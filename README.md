# App Contact · Rails contact manager

Ruby on Rails application for managing contacts and their associated gender, country, department and city records. The `ContactsController` contains HTML CRUD actions, JSON responses for the contact list and create/update actions, and a PDF export action backed by Prawn. The root route points to the contact list.

## Stack

The Gemfile declares Ruby 3.0.0, Rails 7.0.5, SQLite and MySQL dependencies, Prawn and Bootstrap. Check `config/database.yml` for the database configuration in your environment. This repository is an older project; no production deployment is claimed.

## Run locally

1. Install the Ruby version declared in the Gemfile, Bundler and the database required by your configuration.
2. Run `bundle install` and `bin/rails db:prepare`.
3. Start the app with `bin/rails server` and visit `http://localhost:3000`.

The routes include `GET /contacts` and `GET /contacts/export_to_pdf`. The setup and tests have not been revalidated on current systems.
