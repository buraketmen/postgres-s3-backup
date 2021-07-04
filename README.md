# postgres-s3-backup

Backup PostgresSQL:13 to S3 (supports periodic backups)

## Usage

Docker:

```sh
docker run --network=your-proxy -e S3_ACCESS_KEY_ID=key -e S3_SECRET_ACCESS_KEY=secret -e S3_BUCKET=your_bucket -e S3_PREFIX=postgres_backup -e POSTGRES_DATABASE=database_name -e POSTGRES_USER=postgres-e POSTGRES_PASSWORD=postgres -e POSTGRES_HOST=localhost buraketmen/postgres-s3-backup:latest
```

Docker Compose:
```yaml
postgres:
  image: postgres
  environment:
    POSTGRES_USER: postgres
    POSTGRES_PASSWORD: postgres

pgbackups3:
  image: buraketmen/postgres-s3-backup
  links:
    - postgres
  environment:
    SCHEDULE: '@daily'
    S3_REGION: region
    S3_ACCESS_KEY_ID: key
    S3_SECRET_ACCESS_KEY: secret
    S3_BUCKET: bucket_name
    S3_PREFIX: folder_name
    POSTGRES_DATABASE: database_name
    POSTGRES_USER: postgres
    POSTGRES_PASSWORD: postgres
    POSTGRES_EXTRA_OPTS: '--schema=public --blobs'
```

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@weekly"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).

This repository has been created to store scripts from which @ledermann was created.