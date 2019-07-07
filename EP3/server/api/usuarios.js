const router = require('express').Router()

const client = require('../database')

router.get('/', (req, res) => {
    client.mod_acc.query({
        text: 'SELECT * FROM usuario;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.get('/perfis', (req, res) => {
    if (!req.body.usuario) {
        return res.sendStatus(400)
    }
    const { login } = req.body.usuario;
    if (!login) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT * FROM seleciona_perfis ($1);',
        values: [login],
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.get('/servicos', (req, res) => {
    if (!req.body.usuario) {
        return res.sendStatus(400)
    }
    const { login } = req.body.usuario;
    if (!login) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT * FROM seleciona_servicos_usuario ($1);',
        values: [login],
    }).then(({ rows }) => {
        console.log(rows)
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
    client.mod_acc.query({
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
// essa rota associa um usuario a um perfil
router.post('/perfil', (req, res) => {
    if (!req.body.usuario || !req.body.perfil) {
        return res.sendStatus(400)
    }
    const { login } = req.body.usuario
    const { papel } = req.body.perfil
    if (!login || !papel) {
        return res.sendStatus(400)
    }
    client.mod_acc.query({
        text: 'SELECT associa_perfil ($1, $2);',
        values: [login, papel],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
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
    client.mod_acc.query({
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
