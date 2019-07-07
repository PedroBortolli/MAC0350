const router = require('express').Router()

const auth = require('./auth')
router.use('/auth', auth)

// MOD_ACC
const usuarios = require('./usuarios')
const perfis = require('./perfis')
const servicos = require('./servicos')
router.use('/usuarios', usuarios)
router.use('/perfis', perfis)
router.use('/servicos', servicos)

// MOD_CUR
const disciplinas = require('./disciplinas')
router.use('/disciplinas', disciplinas)

// MOD_PEO
const pessoa = require('./pessoas')
router.use('/pessoas', pessoa)

module.exports = router