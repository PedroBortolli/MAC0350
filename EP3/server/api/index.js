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
const curriculos = require('./curriculos')
const trilhas = require('./trilhas')
const disciplinas = require('./disciplinas')
router.use('/curriculos', curriculos)
router.use('/trilhas', trilhas)
router.use('/disciplinas', disciplinas)

// MOD_PEO
const pessoas = require('./pessoas')
const alunos = require('./alunos')
const professores = require('./professores')
const administradores = require('./administradores')
router.use('/pessoas', pessoas)
router.use('/alunos', alunos)
router.use('/professores', professores)
router.use('/administradores', administradores)

module.exports = router