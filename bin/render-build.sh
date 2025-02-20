#!/usr/bin/env bash
# Exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Ensure the database directory exists on the persistent disk
mkdir -p /var/data/db

# Check if the database already exists; if not, create it
if [ ! -f /var/data/db/production.sqlite3 ]; then
  echo "Database not found. Creating a new one..."
  bundle exec rails db:create
fi

# Symlink the database to the Rails app's default location
ln -sf /var/data/db/production.sqlite3 db/production.sqlite3

# Run database migrations
bundle exec rails db:migrate:status
bundle exec rails db:migrate
bundle exec rails db:migrate:status

# Seed the database if necessary
bundle exec rails db:seed
