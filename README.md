### A trial of https://github.com/stripe/mosql using docker

It does the following

* sets up a docker postgres container, 
* sets up a mongodb container
* injects some dummy data in the mongodb container
* imports that data across (and tails oplog) to postgresql using mosql

#### Usage
```
make setup
make import
make connect
SELECT * FROM contributions;
``` 

You should see contribution data

### Details

`make setup` - sets up default postgresql and mongodb instances
`make import` - uses mosql to migrate data from mongodb instance ot postgresql instance based on config in `data/classical.yml`

You can specify optional `CONFIG` `POSTGRES` and `MONGO` vars to point to different config, postgresql/mongodb conn strings accordingly

`make connect`
Connects to the postgresql container with the `postgres` user

`make kill-all`
Kills the running postgresql and mongodb containers
