const router = require('express').Router()

const client = require('../database')

router.post('/login', (req, res) => {
    client.query({
        name: 'get user',
        text: 'SELECT * FROM usuario WHERE login=$1 AND senha=$2;',
        values: [req.body.auth.login, req.body.auth.senha],
    }).then(({ rows }) => {
        if (rows.length === 0) {
            res.sendStatus(403)
        } else {
            res.sendStatus(200)
        }
    })
})

module.exports = router
