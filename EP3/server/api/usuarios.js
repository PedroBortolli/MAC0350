const router = require('express').Router()

const client = require('../database')

// lembrar de ver se o cara pode fazer isso
router.get('/', (req, res) => {
    client.query({
        text: 'SELECT * FROM usuario;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

// lembrar de ver se o cara pode fazer isso
router.post('/create', (req, res) => {
    if (!req.body.usuario) {
        return res.sendStatus(400)
    }
    const { login, email, senha } = req.body.usuario;
    if (!login || !email || !senha) {
        return res.sendStatus(400)
    }
    client.query({
        text: 'SELECT cria_usuario ($1, $2, $3);',
        values: [login, email, senha],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

// lembrar de ver se o cara pode fazer isso
router.delete('/', (req, res) => {
    if (!req.body.usuario) {
        return res.sendStatus(400)
    }
    const { login } = req.body.usuario
    if (!login) {
        return res.sendStatus(400);
    }
    client.query({
        text: 'SELECT remove_usuario ($1);',
        values: [login],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
