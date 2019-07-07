const router = require('express').Router()

const client = require('../database')

router.get('/', (req, res) => {
    client.mod_cur.query({
        text: 'SELECT * FROM disciplina;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

module.exports = router
