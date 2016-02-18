POSTGRES=postgres://postgres@pg-mosql
MONGO=mongodb://mongo/classical
CONFIG=classical.yml

launch-pg:
	docker run -d \
	  --name pg-mosql \
	  postgres

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
	  --link mongo:mongo \
	  mosql \
	  mosql --collections $(CONFIG) \
	  --sql $(POSTGRES) \
	  --mongo $(MONGO)
	 	
kill-pg:
	docker rm -f pg-mosql
