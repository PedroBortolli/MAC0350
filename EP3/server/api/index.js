const router = require('express').Router()

const authRoutes = require('./auth')
const disciplinasRoutes = require('./disciplinas')
const servicosRoutes = require('./servicos')
const usuariosRoutes = require('./usuarios')
const perfisRoutes = require('./perfis')

router.use('/auth', authRoutes)
router.use('/disciplinas', disciplinasRoutes)
router.use('/servicos', servicosRoutes)
router.use('/usuarios', usuariosRoutes)
router.use('/perfis', perfisRoutes)

module.exports = router