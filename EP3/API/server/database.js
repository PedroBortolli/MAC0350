const Pool = require('pg').Pool

// mudem esse objeto com as configurações de vcs
// (n fiquem comitando essa porra se mudarem só isso, vai virar uma putaria, coloquem num .env da vida)
const postgres_setup = {
    user: 'postgres',
    password: 'postgres',
    host: 'localhost',
    port: 5432,
}

const mod_acc = new Pool({
    ...postgres_setup,
    database: 'mod_acc'
})
mod_acc.connect()

const mod_cur = new Pool({
    ...postgres_setup,
    database: 'mod_cur',
})
mod_cur.connect()

const mod_peo = new Pool({
    ...postgres_setup,
    database: 'mod_peo',
})
mod_peo.connect()

const mod_acc_peo = new Pool({
    ...postgres_setup,
    database: 'mod_acc_peo',
})
mod_acc_peo.connect()

const mod_peo_cur = new Pool({
    ...postgres_setup,
    database: 'mod_peo_cur',
})
mod_peo_cur.connect()

const client = {
    mod_acc,
    mod_cur,
    mod_peo,
    mod_acc_peo,
    mod_peo_cur,
}

module.exports = client
