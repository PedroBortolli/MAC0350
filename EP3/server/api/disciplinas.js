const router = require('express').Router()

const disciplinas = require('./mocks').disciplinas

router.get('/', (req, res) => {
    res.send({ data: disciplinas }).status(200)
})

module.exports = router
