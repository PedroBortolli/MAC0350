const router = require('express').Router()

const client = require('../database')

router.get('/', (req, res) => {
    client.mod_cur.query({
        text: 'SELECT * FROM curriculo;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', (req, res) => {
    if (!req.body.curriculo) {
        return res.sendStatus(400)
    }
    const { codigo, nome } = req.body.curriculo;
    if (codigo === undefined || nome === undefined) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT cria_curriculo ($1, $2);',
        values: [codigo, nome],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.patch('/', (req, res) => {
    if (!req.body.curriculo) {
        return res.sendStatus(400)
    }
    const { codigo, nome } = req.body.curriculo
    if (codigo === undefined) {
        return res.sendStatus(400)
    }
    if (nome !== undefined) {
        client.mod_cur.query({
            text: 'SELECT atualiza_curriculo ($1, $2);',
            values: [codigo, nome],
        }).then(() => {
            res.sendStatus(200)
        }).catch(err => {
            console.error(err)
            return res.sendStatus(500)
        })
    }
})

router.delete('/', (req, res) => {
    if (!req.body.curriculo) {
        return res.sendStatus(400)
    }
    const { codigo } = req.body.curriculo
    if (codigo === undefined) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT remove_curriculo ($1);',
        values: [codigo],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
