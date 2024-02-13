#!/usr/bin/env bash

bundle lock --add-platform x86_64-linux

# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
yarn build
bundle exec rake assets:clean
bundle exec rake db:migrate
