const router = require('express').Router()

const client = require('../database')

// maybe this route should return a name, but since it returns a cpf,
// we can get all people and get the name that way
router.get('/', (req, res) => {
    client.mod_peo.query({
        text: 'SELECT * FROM aluno;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', (req, res) => {
    if (!req.body.aluno) {
        return res.sendStatus(400)
    }
    const { nusp, cpf, ano_ingresso } = req.body.aluno;
    if (!nusp || !cpf || !ano_ingresso) {
        return res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT cria_aluno ($1, $2, $3);',
        values: [nusp, cpf, ano_ingresso],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.patch('/', (req, res) => {
    if (!req.body.aluno) {
        return res.sendStatus(400)
    }
    const { nusp, ano_ingresso } = req.body.aluno
    if (!nusp) {
        return res.sendStatus(400)
    }
    if (ano_ingresso !== null) {
        client.mod_peo.query({
            text: 'SELECT atualiza_aluno_ano_ingresso ($1, $2);',
            values: [nusp, ano_ingresso],
        }).then(() => {
            res.sendStatus(200)
        }).catch(err => {
            console.error(err)
            return res.sendStatus(500)
        })
    }
})

router.delete('/', (req, res) => {
    if (!req.body.aluno) {
        return res.sendStatus(400)
    }
    const { nusp } = req.body.aluno
    if (!nusp) {
        return res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT remove_aluno ($1);',
        values: [nusp],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
