import cors from 'cors'
import express from 'express'
// commented out parts are to enable you to run your React App side by side with GraphQL
// import webpack from 'webpack'
// import webpackDevMiddleware from 'webpack-dev-middleware'
// import configFactory from './client/webpack.config.babel.js'
import schema from './schema'
import { json } from 'body-parser'
import { graphql } from 'graphql'

const PORT = process.env.PORT || 3001

const app = express()

// const config = configFactory()
// const compiler = webpack(config)
// const middleware = webpackDevMiddleware(compiler)

app.use(cors())
// app.use(middleware)

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
