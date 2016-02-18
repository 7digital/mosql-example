launch-pg:
	docker run -d \
	  --name pg-mosql \
	  postgres

connect:
	docker run -it --rm \
	  --link pg-mosql:postgres \
	  postgres \
	  psql -h pg-mosql -U $(USER)

kill-pg:
	docker rm -f pg-mosql
