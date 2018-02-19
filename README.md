# Deploy your own GraphQL Resolvers

Note that I use maxrozen.com as an example wildly throughout this repo.

Please note:

* _The GraphQL Endpoint has NO AUTHENTICATION_
* We are intentionally splitting out the `/api` folder into its own project requiring `npm install`ing - you can also move the `package.json` into the root directory, copy `local.js` into the root directory and name it `index.js` - and you'll be able to serve your React components with GraphQL Resolvers locally
* The cloudfront.tf file will serve the `index.html` file in your S3 bucket as a website at `YOUR_DOMAIN_URL`, and the GraphQL endpoint will be the value defined in `graphql_endpoint` in vars.tf

Pre-requisites:

* Set up Terraform: [Guide for macOS](https://maxrozen.com/2018-02-07-getting-started-with-terraform)
* Some knowledge of AWS/GraphQL
* Your site must already be set-up in Route53 with a hosted zone - in my case it is "maxrozen.com"
* You must have an S3 bucket with your url already set-up - in my case it is "maxrozen.com", also enable `Static website hosting` in S3, ticking `Use this bucket to host a website` and set your index document to `index.html`

* Your webpack config must output the build of your GraphQL Resolver to `/build`

Setup steps:

1. Edit `infrastructure/vars.tf`, set up all of your variables
2. Edit `infrastructure/backend.tf`, copy your Domain name to bucket, and key, and copy your aws_region to region (variables don't work in this one file)
3. Run `npm install` or `yarn` in `/api`, then `npm run build`
4. Change directory to `/infrastructure`, then run `terraform init` and `terraform plan` to see the new infrastructure to be created. If you're happy with the changes, run `terraform apply`
5. _OPTIONAL_: To tear down the infrastructure terraform has created, run `terraform destroy`
