const router = require('express').Router()

const client = require('../database')
const { authorize_middleware, TYPE } = require('./common/authorize')

router.get('/', (req, res) => {
    client.mod_acc.query({
        text: 'SELECT * FROM perfil;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.get('/:papel/servicos', (req, res) => {
    if (!req.params) {
        return res.sendStatus(400)
    }
    const { papel } = req.params;
    if (!papel) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT * FROM seleciona_servicos ($1);',
        values: [papel],
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', authorize_middleware(TYPE.CREATE), (req, res) => {
    if (!req.body.perfil) {
        return res.sendStatus(400)
    }
    const { papel, descricao } = req.body.perfil;
    if (!papel || !descricao) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT cria_perfil ($1, $2);',
        values: [papel, descricao],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/servico', authorize_middleware(TYPE.CREATE), (req, res) => {
    if (!req.body.perfil || !req.body.servico) {
        return res.sendStatus(400)
    }
    const { papel } = req.body.perfil;
    const { tipo } = req.body.servico;
    if (!papel || !tipo) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT associa_servico ($1, $2);',
        values: [papel, tipo],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.delete('/', authorize_middleware(TYPE.DELETE), (req, res) => {
    if (!req.body.perfil) {
        return res.sendStatus(400)
    }
    const { papel } = req.body.perfil
    if (!papel) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT remove_perfil ($1);',
        values: [papel],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
