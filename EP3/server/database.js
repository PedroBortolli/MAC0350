const Pool = require('pg').Pool

const mod_acc = new Pool({
    user: 'postgres',
    password: 'postgres',
    host: 'localhost',
    port: 5432,
    database: 'mod_acc'
})
mod_acc.connect()

const client = {
    mod_acc,
}

module.exports = client