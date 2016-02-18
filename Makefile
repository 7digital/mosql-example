POSTGRES=postgres://postgres@pg-mosql
MONGO=mongodb://mongo-mosql/classical
CONFIG=classical.yml
USER=postgres

build:
	docker build -t mosql .

launch-pg:
	docker run -d \
	  --name pg-mosql \
	  postgres

launch-mongo:
	docker run -d \
	  -v `pwd`/mongodata:/import \
	  -v $(HOME)/mongo-mosqldata:/data \
	  --name mongo-mosql \
	  mongo --smallfiles

setup-mongo:
	docker exec mongo-mosql mongoimport --db classical --collection products --drop --file /import/product.json --jsonArray
	docker exec mongo-mosql mongoimport --db classical --collection artists --drop --file /import/artists.json --jsonArray
	docker exec mongo-mosql mongoimport --db classical --collection contributions --drop --file /import/contributions.json --jsonArray
	docker exec mongo-mosql mongo localhost/classical /import/indexes.js

setup: build launch-pg launch-mongo setup-mongo

connect:
	docker run -it --rm \
	  --link pg-mosql:postgres \
	  postgres \
	  psql -h pg-mosql -U $(USER)

import:
	docker run --rm \
	  -v `pwd`/data:/data \
	  -w /data \
	  --link pg-mosql:postgres \
	  --link mongo-mosql:mongo \
	  mosql \
	  mosql --collections $(CONFIG) \
	  --sql $(POSTGRES) \
	  --mongo $(MONGO)
	 	
kill-all:
	-docker rm -f pg-mosql
	-docker rm -f mongo-mosql
