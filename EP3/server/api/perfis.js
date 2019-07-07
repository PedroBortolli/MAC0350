const router = require('express').Router()

const client = require('../database')

// lembrar de ver se o cara pode fazer isso
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

// lembrar de ver se o cara pode fazer isso
router.post('/create', (req, res) => {
    if (!req.body.perfil) {
        return res.sendStatus(400)
    }
    const { papel, descricao } = req.body.servico;
    if (!papel || !descricao) {
        res.sendStatus(400)
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

// lembrar de ver se o cara pode fazer isso
router.delete('/', (req, res) => {
    if (!req.body.perfil) {
        res.sendStatus(400)
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
