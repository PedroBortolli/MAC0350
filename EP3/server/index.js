const app = require('express')()

const apiRoutes = require('./api')

const port = 5000

app.use('/api', apiRoutes)

app.listen(port, () => {
    console.log(`Server listening on port ${port}`)
})
