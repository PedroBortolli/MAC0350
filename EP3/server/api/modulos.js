const router = require('express').Router()

const client = require('../database')
const authorize = require('./common/authorize')

router.get('/', (req, res) => {
    client.mod_cur.query({
        text: 'SELECT * FROM modulo;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', authorize('criação'), (req, res) => {
    if (!req.body.modulo) {
        return res.sendStatus(400)
    }
    const { id_trilha, nome, descricao, quant_disc } = req.body.modulo;
    if ([id_trilha, nome, descricao, quant_disc].includes(undefined)) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT cria_modulo ($1, $2, $3, $4);',
        values: [id_trilha, nome, descricao, quant_disc],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.patch('/', (req, res) => {
    if (!req.body.modulo) {
        return res.sendStatus(400)
    }
    const { nome, descricao, quant_disc } = req.body.modulo;
    if (nome === undefined) {
        return res.sendStatus(400)
    }
    const promises = []
    if (descricao !== undefined) {
        promises.push(client.mod_cur.query({
            text: 'SELECT atualiza_descricao_modulo ($1, $2);',
            values: [nome, descricao],
        }))
    }
    if (quant_disc !== undefined) {
        promises.push(client.mod_cur.query({
            text: 'SELECT atualiza_disc_modulo ($1, $2);',
            values: [nome, quant_disc],
        }))
    }
    Promise.all(promises).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.delete('/', (req, res) => {
    if (!req.body.modulo) {
        res.sendStatus(400)
    }
    const { nome } = req.body.modulo
    if (nome === undefined) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT remove_modulo ($1);',
        values: [nome],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
