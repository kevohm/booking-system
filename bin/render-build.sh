#!/usr/bin/env bash
# Exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Ensure the database directory exists
mkdir -p storage

# Check if the database exists; if not, create it
if [ ! -f storage/production.sqlite3 ]; then
  echo "Database not found. Creating a new one..."
  bundle exec rails db:create
fi

# Run database migrations
echo "Running database migrations..."
bundle exec rails db:migrate || (echo "Migrations failed. Resetting database..." && bundle exec rails db:reset)

# Run database seed data (if necessary)
echo "Seeding database..."
bundle exec rails db:seed
