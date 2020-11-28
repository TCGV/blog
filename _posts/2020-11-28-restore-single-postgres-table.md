---
layout: post
title: "Restoring individual postgres table"
date: 2020-11-28 15:30:00 -0300
tags: database system-administration
---

In a scenario where a production database backup becomes too large to be handled nimbly selective database restoration becomes quite useful for recovering pre-determined sets of data.

PostgreSQL allows restoration of individual tables from dump files which can be used, for instance, to query a particular table for retrieving data from a previous state in time, say, for investigating a bug, or recovering accidentally deleted data.

Generating the Backup File
============

Naturally the first step here is to generate your database backups. Ideally you should set up an automation that recurrently generates backups and stores them in a safe place.

The `pg_dump` utility is used for generating the entire PostgreSQL database backup:

```bash
pg_dump.exe --host localhost --port 5432 --username "postgres" --schema "public" --format custom --blobs --verbose --file "my_database.dump" "my_database"
```

In my case I have a recurring task scheduled to run daily (at dawn) for generating the backup file and uploading it to AWS S3 for storage.

Restoring a Single Table
============

Now whenever I need to restore a specific table for data recovery or bug investigating purposes here's my go to recipe:

<b>1)</b> Download daily backup file of interest from S3

<b>2)</b> Create an empty local database `my_database_restored`

<b>3)</b> Create the table that needs to be restored `my_table` in the empty database

Some tips:
* The table name, column names and column types should match those of the original database
* It's not necessary to recreate any of the table's indexes, so use this to intelligently reduce restoration time and database disk usage 🤓

<b>4)</b> Finally run `pg_restore` to selectively import desired table's data:

```bash
pg_restore.exe -U postgres --data-only -d "my_database_restored" -t "my_table" "my_database.dump"
```

That's it, this after the command completes all table data will be available in your single table database for querying.

---

<b>Further Reference</b>

* [pg_dump documentation](https://www.postgresql.org/docs/13/app-pgdump.html)
* [pg_restore documentation](https://www.postgresql.org/docs/13/app-pgrestore.html)