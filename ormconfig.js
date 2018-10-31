console.log(process.env.DATABASE_URL)
module.exports = {
  type: "mssql",
  url: process.env.DATABASE_URL,
  schema: "dbo",
  synchronize: false,
  entities: [
    "src/entity/**/*.ts"
  ],
  migrations: [
    "src/migration/**/*.ts"
  ],
  subscribers: [
    "src/subscriber/**/*.ts"
  ],
  cli: {
    entitiesDir: "src/entity",
    migrationsDir: "src/migration",
    subscribersDir: "src/subscriber"
  }
}
