const router = require('express').Router()

const authRoutes = require('./auth')
const disciplinasRoutes = require('./disciplinas')
const servicosRoutes = require('./servicos')

router.use('/auth', authRoutes)
router.use('/disciplinas', disciplinasRoutes)
router.use('/servicos', servicosRoutes)

module.exports = router