const router = require('express').Router()

const authRoutes = require('./auth')
const disciplinasRoutes = require('./disciplinas')

router.use('/auth', authRoutes)
router.use('/disciplinas', disciplinasRoutes)

module.exports = router