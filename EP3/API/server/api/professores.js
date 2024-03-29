const router = require('express').Router()

const client = require('../database')
const { authorize_middleware, TYPE } = require('./common/authorize')

router.get('/', (req, res) => {
    client.mod_peo.query({
        text: 'SELECT * FROM professor;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', authorize_middleware(TYPE.CREATE), (req, res) => {
    if (!req.body.professor) {
        return res.sendStatus(400)
    }
    const { cpf, area_formacao } = req.body.professor;
    if (!cpf || !area_formacao) {
        return res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT cria_professor ($1, $2);',
        values: [cpf, area_formacao],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.patch('/', authorize_middleware(TYPE.UPDATE), (req, res) => {
    if (!req.body.professor) {
        return res.sendStatus(400)
    }
    const { cpf, area_formacao } = req.body.professor
    if (!cpf) {
        return res.sendStatus(400)
    }
    if (area_formacao !== undefined) {
        client.mod_peo.query({
            text: 'SELECT atualiza_professor_area_formacao ($1, $2);',
            values: [cpf, area_formacao],
        }).then(() => {
            res.sendStatus(200)
        }).catch(err => {
            console.error(err)
            return res.sendStatus(500)
        })
    }
})

router.delete('/', authorize_middleware(TYPE.DELETE), (req, res) => {
    if (!req.body.professor) {
        return res.sendStatus(400)
    }
    const { cpf } = req.body.professor
    if (!cpf) {
        return res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT remove_professor ($1);',
        values: [cpf],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
