import "reflect-metadata"
import {createConnection} from "typeorm"

const main = async () => {
  try {
    await createConnection()
    console.log("Connected")
  } catch(e) {
    console.error(e)
  }
}

main()
