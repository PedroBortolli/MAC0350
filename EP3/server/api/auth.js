const router = require('express').Router()

const client = require('../database')

router.post('/login', (req, res) => {
    client.query({
        name: 'get user',
        text: 'SELECT * FROM test WHERE username=$1 AND password=$2;',
        values: [req.body.login.username, req.body.login.password],
    }).then(({ rows }) => {
        if (rows.length === 0) {
            res.sendStatus(403)
        } else {
            res.sendStatus(200)
        }
    })
})

module.exports = router
