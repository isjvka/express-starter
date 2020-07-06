import express from 'express'


const app = express()
const port = process.env.PORT || 3000


app.get('/', (_, res) => {
  res.json({ hello: 'world' })
})


app.listen(port)
