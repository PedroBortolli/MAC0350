const router = require('express').Router()

const client = require('../database')

router.get('/', (req, res) => {
    client.mod_peo.query({
        text: 'SELECT * FROM administrador;',
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.post('/', (req, res) => {
    if (!req.body.administrador) {
        return res.sendStatus(400)
    }
    const { cpf, inicio, fim } = req.body.administrador;
    if (!cpf || !inicio || !fim) {
        return res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT cria_administrador ($1, $2, $3);',
        values: [cpf, inicio, fim],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

// you dont need to provide all fields,
// (in this case, you can provide either 'inicio' or 'fim' and it will update only the ones that you provide)
router.patch('/', (req, res) => {
    if (!req.body.administrador) {
        return res.sendStatus(400)
    }
    const { cpf, inicio, fim } = req.body.administrador
    if (!cpf) {
        return res.sendStatus(400)
    }
    const promises = []
    if (inicio !== null) {
        promises.push(client.mod_peo.query({
            text: 'SELECT atualiza_administrador_inicio ($1, $2);',
            values: [cpf, inicio],
        }))
    }
    if (fim !== null) {
        promises.push(client.mod_peo.query({
            text: 'SELECT atualiza_administrador_fim ($1, $2);',
            values: [cpf, fim],
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
    if (!req.body.administrador) {
        return res.sendStatus(400)
    }
    const { cpf } = req.body.administrador
    if (!cpf) {
        return res.sendStatus(400)
    }
    client.mod_peo.query({
        text: 'SELECT remove_administrador ($1);',
        values: [cpf],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
