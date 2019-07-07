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
    const { cpf, nome } = req.body.pessoa;
    if (!cpf || !nome) {
        return res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT cria_pessoa ($1, $2);',
        values: [cpf, nome],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.patch('/', (req, res) => {
    if (!req.body.pessoa) {
        return res.sendStatus(400)
    }
    const { cpf, nome } = req.body.pessoa
    if (!cpf) {
        return res.sendStatus(400)
    }
    if (nome !== null) {
        client.mod_peo.query({
            text: 'SELECT atualiza_pessoa_nome ($1, $2);',
            values: [cpf, nome],
        }).then(() => {
            res.sendStatus(200)
        }).catch(err => {
            console.error(err)
            return res.sendStatus(500)
        })
    }
})

router.delete('/', (req, res) => {
    if (!req.body.pessoa) {
        return res.sendStatus(400)
    }
    const { cpf } = req.body.pessoa
    if (!cpf) {
        return res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT remove_pessoa ($1);',
        values: [cpf],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
