const router = require('express').Router()

const client = require('../database')

router.get('/', (req, res) => {
    client.mod_peo.query({
        text: 'SELECT * FROM pessoa;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', (req, res) => {
    if (!req.body.pessoa) {
        return res.sendStatus(400)
    }
    const { nome } = req.body.pessoa;
    if (!nome) {
        res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT cria_pessoa ($1);',
        values: [nome],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

module.exports = router
