const router = require('express').Router()

const client = require('../database')

router.get('/', (req, res) => {
    client.query({
        text: 'SELECT * FROM servico;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

module.exports = router
