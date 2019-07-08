const router = require('express').Router()

const client = require('../database')
const { authorize_middleware, TYPE } = require('./common/authorize')

router.get('/', (req, res) => {
    client.mod_acc.query({
        text: 'SELECT * FROM servico;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', authorize_middleware(TYPE.CREATE), (req, res) => {
    if (!req.body.servico) {
        return res.sendStatus(400)
    }
    const { tipo, descricao } = req.body.servico;
    if (!tipo || !descricao) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT cria_servico ($1, $2);',
        values: [tipo, descricao],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.delete('/', authorize_middleware(TYPE.DELETE), (req, res) => {
    if (!req.body.servico) {
        return res.sendStatus(400)
    }
    const { tipo } = req.body.servico
    if (!tipo) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT remove_servico ($1);',
        values: [tipo],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
