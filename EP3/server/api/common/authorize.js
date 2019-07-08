const client = require('../../database')

const authorize_middleware = (tipo, userRelated = false) => (req, res, next) => {
    if (!req.body.auth) {
        return res.sendStatus(401)
    }
    const { login, senha } = req.body.auth;
    if (login === undefined || senha === undefined) {
        return res.sendStatus(401)
    }
    client.mod_acc.query({
        text: 'SELECT * FROM seleciona_usuario ($1)',
        values: [login],
    }).then((result) => {
        const user = result.rows[0]
        if (user.senha !== senha) {
            return res.sendStatus(401)
        }
        client.mod_acc.query({
            text: 'SELECT * FROM seleciona_servicos_usuario ($1);',
            values: [login],
        }).then(({ rows }) => {
            const permissions = rows.map(row => row.tipo)
            if (permissions.includes(tipo)) {
                next()
            } else {
                if (userRelated && req.body.usuario.login === req.body.auth.login) {
                    next()
                } else {
                    return res.sendStatus(403)
                }
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

module.exports = {
    authorize_middleware,
    TYPE: {
        GET: 'visualização',
        CREATE: 'criação',
        UPDATE: 'atualização',
        DELETE: 'remoção',
    },
}