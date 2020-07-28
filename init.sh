#!/bin/bash


docker-compose down;
docker-compose build;

sleep 10
docker-compose up -d;

docker-compose exec web rake db:setup RAILS_ENV=production;

sleep 10
docker-compose stop;

sleep 10
docker-compose up;

