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

router.post('/create', (req, res) => {
    try {
        const { tipo, descricao } = req.body.servico;
        if (!tipo || !descricao) {
            res.sendStatus(400)
        }
        client.query({
            text: 'INSERT INTO servico (tipo, descricao) VALUES ($1, $2);',
            values: [tipo, descricao],
        }).then(() => {
            res.sendStatus(200)
        }).catch(err => {
            console.error(err)
            res.sendStatus(500)
        })
    } catch (err) {
        res.sendStatus(400)
    }
})

module.exports = router
