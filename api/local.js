import cors from 'cors'
import express from 'express'

import schema from './schema'
import { json } from 'body-parser'
import { graphql } from 'graphql'

const PORT = process.env.PORT || 3001

const app = express()

app.use(cors())

app.post('/graphql', json(), (req, res) => {
  const { query, variables } = req.body
  const rootValue = {}
  const context = {}
  let operationName

  graphql(schema, query, rootValue, context, variables, operationName)
    .then(d => {
      res
        .status(200)
        .set('Content-Type', 'application/json')
        .send(JSON.stringify(d))
    })
    .catch(e => {
      res
        .status(500)
        .set('Content-Type', 'application/json')
        .send(JSON.stringify(e))
    })
})

// the following part is to be able to run your React App side by side with GraphQL
// app.get('*', (req, res) => {
//   res.set('Content-Type', 'text/html')
//   res.send(
//     middleware.fileSystem.readFileSync(config.output.path + '/index.html')
//   )
// })

app.listen(PORT, err => {
  if (err) {
    throw err
  }
  console.log(`Listening on http://localhost:${PORT}/`)
})
