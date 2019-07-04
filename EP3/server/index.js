const app = require('express')()
const bodyParser = require('body-parser')
const cors = require('cors')

const apiRoutes = require('./api')

const port = 5000

app.use(bodyParser.urlencoded())
app.use(bodyParser.json())
app.use(cors())
app.use('/api', apiRoutes)

app.listen(port, () => {
    console.log(`Server listening on port ${port}`)
})
