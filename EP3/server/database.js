const Pool = require('pg').Pool

const client = new Pool({
    connectionString: 'postgres://ujfnmbijvmtsja:287a9ec92486cf03e55140f88792d1d4062777bbe17baace3377d3f488495b3a@ec2-23-21-160-38.compute-1.amazonaws.com:5432/d28drvnsoe5apn',
    ssl: true,
})
client.connect()

module.exports = client