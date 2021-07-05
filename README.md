# postgres-s3-backup

Backup PostgresSQL:13 to S3 (supports periodic backups)

## Usage

Docker Compose:
```yaml
version: '3.5'
services:   
    postgres:
        hostname: postgres
        image: postgres:13.1
        ports:
            - "5432:5432"
        volumes:
            - "postgres-storage:/var/lib/postgresql/data/pgdata"
        environment:
            TZ: Europe/Istanbul
            POSTGRES_USER: ${POSTGRES_USER}
            POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
            POSTGRES_DB: ${POSTGRES_DB}
            PGDATA: "/var/lib/postgresql/data/pgdata" 
        deploy:
            mode: replicated
            replicas: 1
            restart_policy:
                condition: on-failure
     
    pgbackup:
        hostname: pgbackup
        image: buraketmen/postgres-s3-backup:latest
        depends_on:
            - postgres
        environment:
            TZ: Europe/Istanbul
            POSTGRES_HOST: postgres
            S3_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
            S3_SECRET_ACCESS_KEY: ${AWS_SECRET_KEY}
            S3_BUCKET: ${S3_BUCKET_NAME}
            S3_PREFIX: 'postgres_backup'
            POSTGRES_DB: ${POSTGRES_DB}
            POSTGRES_USER: ${POSTGRES_USER}
            POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
            SCHEDULE: "@weekly"
        deploy:
            mode: replicated
            replicas: 1
            restart_policy:
                condition: on-failure
            
    pgadmin:
        hostname: pgadmin
        image: dpage/pgadmin4:4.29
        volumes:
            - "pgadmin-storage:/var/lib/pgadmin"
        environment:
            TZ: Europe/Istanbul
            PGADMIN_DEFAULT_EMAIL: ${PGADMIN_EMAIL}
            PGADMIN_DEFAULT_PASSWORD: ${PGADMIN_PASSWORD}
            PGADMIN_LISTEN_ADDRESS: "0.0.0.0"
            PGADMIN_LISTEN_PORT: "9002"
        ports:
            - "9002:9002"
        deploy:
            mode: replicated
            replicas: 1
            restart_policy:
                condition: on-failure

volumes:
    postgres-storage:
        name: postgres-storage
            
    pgadmin-storage:
        name: pgadmin-storage
          
```

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@weekly"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).

This repository has been created to store scripts from which @ledermann was created.
