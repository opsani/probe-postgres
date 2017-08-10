# probe-postgres
The postgres probe connects to postgres component instances and lists their databases.  This probe can be used to verify a deployed service provides access to the postgres API on the component's service network (the same network which is used to consume that service).

The postgres probe supports the following actions:

* `service_up` (default) - connect to postgres and list databases, retrying until success or the action times out.  Succeed if the postgres service is up, even if the connect response is authentication failure or invalid database.
* `check_access` - connect to postgres and list databases, retrying until success or the action times out.  Succeed if the connect and database list operations succeed.  This action can be used to verify access to a user/password protected postgres service.

These actions support the following arguments:

* `port` - port number (default `5432`)
* `user` - user (default `postgres`)
* `password` - password (default `None`)
* `database` - database (default `postgres`)
* `timeout` - operation timeout *per service instance*, in seconds (default `30`).  This is how long to keep retrying if the postgres service does not respond.

Docker Hub repository:  <https://hub.docker.com/r/opsani/probe-postgres/>

## examples

Here are a few examples in the form of quality gates specified in a Skopos TED file (target environment descriptor).  Quality gates associate probe executions to one or more component images.  During application deployment Skopos executes the specified probes to assess components deployed with matching images.

```yaml
quality_gates:
    postgres_test:
        images:
            - postgres:*
        steps:

            # verify postgres service is up (default action service_up)
            - probe: opsani/probe-postgres

            # verify postgres access
            - probe:
                image: opsani/probe-postgres
                action: check_access
                label: "check postgres access on alternate port with timeout"
                arguments: { port: 10000, timeout: 15 }
            - probe:
                image: opsani/probe-postgres
                action: check_access
                label: "check postgres access with user/password/database"
                arguments:
                    user: "my_user"
                    password: "my_password"
                    database: "my_database"
```
