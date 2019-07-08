const router = require('express').Router()

const client = require('../database')
const { authorize_middleware, TYPE } = require('./common/authorize')

router.get('/', (req, res) => {
    client.mod_cur.query({
        text: 'SELECT * FROM trilha;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', authorize_middleware(TYPE.CREATE), (req, res) => {
    if (!req.body.trilha) {
        return res.sendStatus(400)
    }
    const { nome, descricao, quant_mod } = req.body.trilha;
    if ([nome, descricao, quant_mod].includes(undefined)) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT cria_trilha ($1, $2, $3);',
        values: [nome, descricao, quant_mod],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.patch('/', authorize_middleware(TYPE.UPDATE), (req, res) => {
    if (!req.body.trilha) {
        return res.sendStatus(400)
    }
    const { nome, descricao, quant_mod } = req.body.trilha;
    if (nome === undefined) {
        return res.sendStatus(400)
    }
    const promises = []
    if (descricao !== undefined) {
        promises.push(client.mod_cur.query({
            text: 'SELECT atualiza_descricao_trilha ($1, $2);',
            values: [nome, descricao],
        }))
    }
    if (quant_mod !== undefined) {
        promises.push(client.mod_cur.query({
            text: 'SELECT atualiza_disc_trilha ($1, $2);',
            values: [nome, quant_mod],
        }))
    }
    Promise.all(promises).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.delete('/', authorize_middleware(TYPE.DELETE), (req, res) => {
    if (!req.body.trilha) {
        res.sendStatus(400)
    }
    const { nome } = req.body.trilha
    if (nome === undefined) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT remove_trilha ($1);',
        values: [nome],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
