init: init-folders git-clone-services up-test-db init-services drop-test-db build up

init-folders:
	mkdir services

git-clone-services:
	sh ./scripts/git-clone-services.sh

init-services:
	cd services/hwStoreVue2/src && npm i
	cd services/systems_engineering_spring && mvn clean install

build:
	cd services/systems_engineering_spring && docker build -t systems_engineering_spring .
	cd services/hwStoreVue2 && docker build -t hw_store_vue2 .

up-test-db:
	docker run --name postgres_db -e POSTGRES_PASSWORD=1234 -e POSTGRES_DB=secret1 -p 5432:5432 -d postgres:latest

drop-test-db:
	docker stop postgres_db
	docker rm postgres_db

up:
	docker-compose up

stop:
	docker-compose down --volumes


