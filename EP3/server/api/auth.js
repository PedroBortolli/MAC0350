const router = require('express').Router()

const client = require('../database')

router.post('/login', (req, res) => {
    client.query({
        text: 'SELECT * FROM seleciona_usuario ($1);',
        values: [req.body.auth.login],
    }).then(({ rows }) => {
        if (rows.length === 1 && rows[0].senha !== req.body.auth.senha) {
            res.sendStatus(403)
        } else {
            res.send(rows[0]).status(200)
        }
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

module.exports = router
