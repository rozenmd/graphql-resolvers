# Deploy your own GraphQL Resolvers

Note that I use maxrozen.com as an example wildly throughout this repo.

Please note: _The GraphQL Endpoint has NO AUTHENTICATION_

Also note: We are intentionally splitting out the `/api` folder into its own project requiring `npm install`ing - you can also move the `package.json` into the root directory, copy `local.js` into the root directory and name it `index.js` - and you'll be able to serve your React components with GraphQL Resolvers locally

Pre-requisites:

* Set up Terraform: [Guide for macOS](https://maxrozen.com/2018-02-07-getting-started-with-terraform)
* Some knowledge of AWS/GraphQL
* Your site must already be set-up in Route53 with a hosted zone - in my case it is "maxrozen.com"
* You must have an S3 bucket with your url already set-up - in my case it is "maxrozen.com"

* Your webpack config must output the build of your GraphQL Resolver to `/build`
