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

router.get('/curriculo', (req, res) => {
    if (!req.body.aluno) {
        return res.sendStatus(400)
    }
    const { nusp } = req.body.aluno
    if (!nusp) {
        return res.sendStatus(400)
    }
    client.mod_peo_cur.query({
        text: 'SELECT * FROM seleciona_cursa_curriculo ($1);',
        values: [nusp],
    }).then(({ rows }) => {
        res.send(rows || []).status(200)
    }).catch(err => {
        console.error(err)
        res.sendStatus(500)
    })
})

router.get('/planeja', (req, res) => {
    if (!req.body.aluno) {
        return res.sendStatus(400)
    }
    const { nusp } = req.body.aluno
    if (!nusp) {
        return res.sendStatus(400)
    }
    client.mod_peo_cur.query({
        text: 'SELECT * FROM seleciona_planeja_aluno ($1);',
        values: [nusp],
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

router.post('/planeja', (req, res) => {
    if (!req.body.aluno || !req.body.disciplina || !req.body.planeja) {
        return res.sendStatus(400)
    }
    const { nusp } = req.body.aluno
    const { codigo } = req.body.disciplina
    const { semestre } = req.body.planeja
    if ([nusp, codigo, semestre].includes(undefined)) {
        return res.sendStatus(400)
    }
    client.mod_peo_cur.query({
        text: 'SELECT cria_planeja ($1, $2, $3);',
        values: [nusp, codigo, semestre],
    }).then(() => {
        res.sendStatus(201)
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
    if (ano_ingresso !== undefined) {
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

router.delete('/planeja', (req, res) => {
    if (!req.body.aluno || !req.body.disciplina) {
        return res.sendStatus(400)
    }
    const { nusp } = req.body.aluno
    const { codigo } = req.body.disciplina
    if ([nusp, codigo].includes(undefined)) {
        return res.sendStatus(400)
    }
    client.mod_peo_cur.query({
        text: 'SELECT deleta_planeja ($1, $2);',
        values: [nusp, codigo],
    }).then(() => {
        res.sendStatus(200)
    }).catch(err => {
        console.error(err)
        return res.sendStatus(500)
    })
})

module.exports = router
