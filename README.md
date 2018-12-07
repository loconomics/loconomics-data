# @loconomics/data

This package may ultimately contain a data model for use in the new Loconomics backend. For now, it contains a recent dump of our schema, with modifications to make it work with [typeorm-model-generator](https://github.com/Kononnable/typeorm-model-generator).

## How to Help

1. Clone this repository.
2. Run `yarn install` or `npm install` from within the clone.
3. Launch an instance of SQLServer somehow. This guide assumes you're using the Dockerized [new backend](https://github.com/loconomics/loconomics-backend) but any instance will do.
4. Load in the schema with `sqlcmd -U sa -S localhost -i schema.sql`, updating for your own SQLServer instance of course.
5. Generate models with `yarn typeorm-model-generator -d loconomics -u sa -x "Password!!11" -e mssql --ce=pascal --cp=camel --lazy=true`. Optionally just run `yarn generate` if your database is created with the default values provided by the backend setup docker-compose.yml.
6. Set a _DATABASE_URL_ environment variable to something like `mssql://sa:Password!!11@localhost:1433/loconomics`.
7. Copy all files from _output/entities_ to _src/entity_.
8. Run `yarn start` or `npm start`.
9. Fail, edit _schema.sql_, reload, regenerate, repeat.

## Editing the database Schema

Only schema files under the `/schema` folders must be edited.
The root file `schema.sql` is autogenerated by a tool (a Nodejs script on this repo), by running `yarn build-schema-sql`.

### Tables DDLs

Tables DDLs are created following a set of important rules, so the full database schema created didn't fail:
- No batch separator (`GO`) before the `CREATE TABLE` statement
- The `CREATE TABLE` statement contains columns, primary keys and only constraints that don't depend on other objects (like default values)
- Foreign keys are defined as constraints with explicit name as part of an `ALTER TABLE` statement, that goes after the first batch separator (`GO`)

That ensure we can create a full `schema.sql` without dependency problems between tables.

## Troubleshooting

### Failed connections to database on Windows

Running the `typeorm-model-generator` or the `yarn start` using the correct connection settings and the SQLServer up, still connectivity errors may appear, which seems to be usual when using named instances rather than default instance, but still some steps may apply on this last case so keep reading.
 next errors may appear , `Port for SQLEXPRESS not found in localhost` (where *SQLEXPRESS* is the instance name). This problems happened using named instances, some steps may not apply when using a default instance.

#### Server not found or wrong port errors

Example error messages: `Error connecting to MSSQL Server`, `ESOCKET`, `EINSTLOOKUP / getaddrinfo ENOTFOUND`, `Port for _instanceName_ not found in localhost`
- **Named instances:** Put a double slash between server name and instance name, rather than a single one, at the host setting.
  - *Example:* if you have `localhost\SQLEXPRESS`, you should set-up `localhost\\SQLEXPRESS`
  - This applies when passing the value through the command line to `typeorm-model-generator`.
  - When setting the value at the environment variable or in a `.env` file for `yarn start`, is **not** needed, may even fail because of double slash there.
- Enable TCP connections to the server, following [official instructions at this link](https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2008/bb909712(v=vs.90)).

#### Failed connection with timeout

Example error message: `Failed to connect to _host_ in 15000ms`.
- Start the service `SQL Server Browser`.

#### Setting up DATABASE_URL didn't work
This applies to named instances and using **Git Bash** on Windows (it's a powerfull option since you get a Linux terminal experience, but there are edge bugs).

After set the environment variable, or including it in-line with the command `yarn install`, a connection error is throwed. The process sends to output the value of the env var, double check it's the correct one; you should check that the back slash was converted to forward slash without warning, that's the source of the problem. I don't know why to prevent that automatic conversion (the ideal step) but there is a workaround:
- TypeORM accepts a `.env` file at the root directory to set-up connection settings, that applies even if other set-up files exists like `ormconfig.js` so does not conflict with that.
- Create an `.env` file at the project root directory with your connection settings [using the recognized names](https://github.com/typeorm/typeorm/blob/7985e2e992842e8a501f315ef44c77b3d188fd64/docs/using-ormconfig.md#using-environment-variables).
  - File should be automatically excluded by `.gitignore` but double check is not committed.
  - Use a single slash between server and instance name on this case.
- **Unset** from your environment, or do **not** specify at command line, the DATABASE_URL env var.
- Run `yarn start` again to test it.
