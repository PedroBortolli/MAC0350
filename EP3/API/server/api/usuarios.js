const router = require('express').Router()

const client = require('../database')
const { authorize_middleware, TYPE } = require('./common/authorize')

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

router.get('/:login/perfis', (req, res) => {
    if (!req.params) {
        return res.sendStatus(400)
    }
    const { login } = req.params;
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

router.get('/:login/servicos', (req, res) => {
    if (!req.params) {
        return res.sendStatus(400)
    }
    const { login } = req.params;
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

router.post('/', authorize_middleware(TYPE.CREATE), (req, res) => {
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

router.patch('/', authorize_middleware(TYPE.UPDATE, true), (req, res) => {
    if (!req.body.usuario) {
        return res.sendStatus(400)
    }
    const { login, email, senha } = req.body.usuario;
    if (login === undefined) {
        return res.sendStatus(400)
    }
    const promises = []
    if (email !== undefined) {
        promises.push(client.mod_acc.query({
            text: 'SELECT atualiza_usuario_email ($1, $2);',
            values: [login, email],
        }))
    }
    if (senha !== undefined) {
        promises.push(client.mod_acc.query({
            text: 'SELECT atualiza_usuario_senha ($1, $2);',
            values: [login, senha],
        }))
    }
    Promise.all(promises).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/perfil', authorize_middleware(TYPE.CREATE), (req, res) => {
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

router.delete('/', authorize_middleware(TYPE.DELETE), (req, res) => {
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
