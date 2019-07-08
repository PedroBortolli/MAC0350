const router = require('express').Router()

const client = require('../database')
const { authorize_middleware, TYPE } = require('./common/authorize')

router.post('/login', (req, res) => {
    client.mod_acc.query({
        text: 'SELECT * FROM seleciona_usuario ($1);',
        values: [req.body.auth.login],
    }).then(({ rows }) => {
        const usuario = rows[0]
        if (usuario.senha !== req.body.auth.senha) {
            res.sendStatus(403)
        } else {
            client.mod_acc_peo.query({
                text: 'SELECT * FROM seleciona_pessoa ($1);',
                values: [req.body.auth.login]
            }).then((result) => {
                const pessoa = result.rows[0]
                if (pessoa === undefined) {
                    return res.send(usuario).status(200)
                }
                const promises = []
                promises.push(client.mod_peo.query({
                    text: 'SELECT * FROM seleciona_aluno_cpf ($1);',
                    values: [pessoa.cpf],
                }))
                promises.push(client.mod_peo.query({
                    text: 'SELECT * FROM seleciona_professor ($1);',
                    values: [pessoa.cpf],
                }))
                promises.push(client.mod_peo.query({
                    text: 'SELECT * FROM seleciona_administrador ($1);',
                    values: [pessoa.cpf],
                }))
                Promise.all(promises).then(([aluno_res, prof_res, admin_res]) => {
                    const rows = [...aluno_res.rows, ...prof_res.rows, ...admin_res.rows]
                    const info = rows[0]
                    if (info == undefined) {
                        res.send({
                            ...usuario,
                            ...pessoa,
                        }).status(200)
                    } else {
                        res.send({
                            ...usuario,
                            ...pessoa,
                            ...info,
                        }).status(200)
                    }
                }).catch(err => {
                    console.error(err)
                    res.sendStatus(500)
                })
            }).catch(err => {
                console.error(err)
                res.sendStatus(500)
            })
        }
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

module.exports = router
