const Pool = require('pg').Pool

const client = new Pool({
    user: 'postgres',
    password: 'postgres',
    host: 'localhost',
    port: 5432,
    database: 'postgres'
})
client.connect()

module.exports = client