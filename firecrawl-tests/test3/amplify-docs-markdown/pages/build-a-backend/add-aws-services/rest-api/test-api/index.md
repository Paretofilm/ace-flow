---
title: Test the API from the terminal
source: pages/build-a-backend/add-aws-services/rest-api/test-api/index.mdx
---

# Test the API from the terminal

## Test the API from the terminal

If unauthenticated guest users have access to your REST API you can test it from the terminal using [curl](https://github.com/curl/curl). curl is a command-line tool that lets you transfer data to and from a server using various protocols.

> Curl is available in many distributions including Mac, Windows and Linux. Follow the install instructions in the [docs](https://curl.haxx.se/docs/install.html).

### GET method example

```bash title="Terminal" showLineNumbers= 
curl <your-api-endpoint>/<your-api-stage>/items
```

### POST method example

```bash title="Terminal" showLineNumbers= 
curl -H "Content-Type: application/json" -d '' <your-api-endpoint>/<your-api-stage>/items
```

</Block>

### GET method example

```bash title="Terminal" showLineNumbers= 
curl <your-api-endpoint>/<your-api-stage>/items
```

### POST method example

```bash title="Terminal" showLineNumbers= 
curl -H "Content-Type: application/json" -d  <your-api-endpoint>/<your-api-stage>/items
```

</Block>
</BlockSwitcher>

## Test the API with API Gateway console

Let's test your new REST API using the route below with HTTP Method `GET` and path `/items?limit=10` which includes a `limit` query string parameter.

```console title="Terminal" showLineNumbers=
GET /items?limit=10
```

1. Sign in to the [API Gateway console](https://console.aws.amazon.com/apigateway)  
2. Choose the `myRestApi` REST API  
3. In the Resources pane, choose the method you want to test. Select `GET` right under `/items`.  

  ```console title="Terminal" showLineNumbers=
  /                        
  |_ /items               Main resource. Eg: /items  
    GET                   Methods  
    DELETE  
    PUT  
    POST  
    OPTIONS               Allow pre-flight requests in CORS by browser  
      |_ /         Proxy resource. Eg: /items/, /items/id, items/object/  
      ANY                  Includes methods: DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT  
      OPTIONS              Allow pre-flight requests in CORS by browser  
  ```
4. In the Method Execution pane, select **TEST**. Choose the `GET` method and add `limit=10` to the query string `` field.
5. Choose **Test** to run the test for `GET /items?limit=10`. The following information will be displayed: request, status, latency, response body, response headers and logs.

```console title="Terminal" showLineNumbers= /* cSpell:disable */
Request
/items
Latency
111
Status
200
Response body
"Hello from myFunction!"
Response headers

Log
Execution log for request 9bd9d8dc-95e2-494b-be1b-716393f83c49
Tue Apr 16 21:31:55 UTC 2024 : Starting execution for request: 9bd9d8dc-95e2-494b-be1b-716393f83c49
Tue Apr 16 21:31:55 UTC 2024 : HTTP Method: GET, Resource Path: /items
Tue Apr 16 21:31:55 UTC 2024 : Method request path: 
Tue Apr 16 21:31:55 UTC 2024 : Method request query string: 
Tue Apr 16 21:31:55 UTC 2024 : Method request headers: 
Tue Apr 16 21:31:55 UTC 2024 : Method request body before transformations: 
Tue Apr 16 21:31:55 UTC 2024 : Endpoint request URI: https://lambda.us-east-1.amazonaws.com/2015-03-31/functions/arn:aws:lambda:us-east-1:[TRUNCATED:function:amplify-nextamplifygen2-y-testfunctionlambdaC407E8-zttuHxtL6x0V/invocations
Tue Apr 16 21:31:55 UTC 2024 : Endpoint request headers: 
Tue Apr 16 21:31:55 UTC 2024 : Endpoint response body before transformations: ,"body":"\"Hello from myFunction!\""}
Tue Apr 16 21:31:55 UTC 2024 : Method response body after transformations: "Hello from myFunction!"
Tue Apr 16 21:31:55 UTC 2024 : Method response headers: 
Tue Apr 16 21:31:55 UTC 2024 : Successfully completed execution
Tue Apr 16 21:31:55 UTC 2024 : Method completed with status: 200
```
