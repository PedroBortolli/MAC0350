const router = require('express').Router()

const client = require('../database')
const { authorize_middleware, TYPE } = require('./common/authorize')

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

router.get('/:codigo_disc/requisitos/:codigo_cur', (req, res) => {
    if (!req.params) {
        return res.sendStatus(400)
    }
    const { codigo_disc, codigo_cur } = req.body.params
    if ([codigo_disc, codigo_cur].includes(undefined)) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT * FROM seleciona_requisito ($1, $2);',
        values: [codigo_disc, codigo_cur],
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', authorize_middleware(TYPE.CREATE), (req, res) => {
    if (!req.body.disciplina) {
        return res.sendStatus(400)
    }
    const { codigo, nome, creditos_aula, creditos_trabalho, instituto } = req.body.disciplina
    if ([codigo, nome, creditos_aula, creditos_trabalho, instituto].includes(undefined)) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT cria_disciplina ($1, $2, $3, $4, $5);',
        values: [codigo, nome, creditos_aula, creditos_trabalho, instituto],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.patch('/', authorize_middleware(TYPE.UPDATE), (req, res) => {
    if (!req.body.disciplina) {
        return res.sendStatus(400)
    }
    const { codigo, nome, creditos_aula, creditos_trabalho, instituto } = req.body.disciplina;
    if (!codigo) {
        return res.sendStatus(400)
    }
    const promises = []
    if (nome !== undefined) {
        promises.push(client.mod_cur.query({
            text: 'SELECT atualiza_nome_disciplina ($1, $2);',
            values: [codigo, nome],
        }))
    }
    if (creditos_aula !== undefined) {
        promises.push(client.mod_cur.query({
            text: 'SELECT atualiza_creditos_aula_disciplina ($1, $2);',
            values: [codigo, creditos_aula],
        }))
    }
    if (creditos_trabalho !== undefined) {
        promises.push(client.mod_cur.query({
            text: 'SELECT atualiza_creditos_trabalho_disciplina ($1, $2);',
            values: [codigo, creditos_trabalho],
        }))
    }
    if (instituto !== undefined) {
        promises.push(client.mod_cur.query({
            text: 'SELECT atualiza_instituto_disciplina ($1, $2);',
            values: [codigo, instituto],
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
    if (!req.body.disciplina) {
        res.sendStatus(400)
    }
    const { codigo } = req.body.disciplina
    if (!codigo) {
        return res.sendStatus(400)
    }
    client.mod_cur.query({
        text: 'SELECT remove_disciplina ($1);',
        values: [codigo],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
