# App Contact · Rails contact manager

This app manages contact details and exports them as PDF. It contains personal data and is not confirmed to have a live deployment.

## Local development

- Ruby 3.4.2, Bundler, and SQLite
- Rails 8.1.4, Propshaft, and Importmap
- `bundle install`
- `RAILS_ENV=test bin/rails db:prepare && bin/rails test`
- `bin/rails db:prepare && bin/rails server`

The obsolete unused `mysql2`, Bootstrap gem and Sass compiler dependencies were removed. The app's local CSS remains. GitHub Actions checks tests, asset compilation, and Ruby advisories.

## Production access and deployment review

Production requires `CONTACT_HTTP_USER` and `CONTACT_HTTP_PASSWORD`. All contact endpoints deny access when either value is absent; protect these values in the hosting provider and never commit them. Production forces HTTPS and responses set `Cache-Control: no-store`. HTTP Basic is a single-operator gate, not per-user authorization; review the access model before exposing real contact data.

The production database remains SQLite on local disk, and uploaded files also use local disk. Both are lost on ephemeral hosting. **Do not deploy this app with real data to a free ephemeral service.** Choose and verify durable storage, backup and migration before deployment. No live database or provider was changed here. Keep a backup and rollback plan before any version switch. A clean gem advisory check does not prove the app is fully secure.
