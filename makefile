.PHONY: build up down exec docker set unpause login

build: 
	docker-compose up -d --build

up:	
	docker-compose up -d

down: 
	docker-compose down -v

exec:
	docker-compose exec concourse /bin/bash

docker:
	sudo service docker start

login:
	fly -t main login -c http://127.0.0.1:8080 -n main -u test -p test

set:
	fly -t main set-pipeline -p booklit -c ./pipeline.yml

unpause:
	fly -t main unpause-pipeline -p booklit