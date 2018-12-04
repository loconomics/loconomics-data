# @loconomics/data

This package may ultimately contain a data model for use in the new Loconomics backend. For now, it contains a recent dump of our schema, with modifications to make it work with [typeorm-model-generator](https://github.com/Kononnable/typeorm-model-generator).

## How to Help

1. Clone this repository.
2. Run `yarn install` or `npm install` from within the clone.
3. Launch an instance of SQLServer somehow. This guide assumes you're using the Dockerized [new backend](https://github.com/loconomics/loconomics-backend) but any instance will do.
4. Load in the schema with `sqlcmd -U sa -S localhost -i schema.sql`, updating for your own SQLServer instance of course.
5. Generate models with `yarn typeorm-model-generator -d Dev -u sa -x "Password!!11" -e mssql --ce=pascal --cp=camel --lazy=true`. Optionally just run `yarn generate` if your database is created with the default values provided by the backend setup docker-compose.yml.
6. Set a _DATABASE_URL_ environment variable to something like `mssql://sa:Password!!11@localhost:1433/Dev`.
7. Run `yarn start` or `npm start`.
8. Fail, edit _schema.sql_, reload, regenerate, repeat.
