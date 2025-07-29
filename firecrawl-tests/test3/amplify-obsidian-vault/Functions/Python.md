---
title: Python
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/custom-functions/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# Python

AWS Amplify Gen 2 functions are AWS Lambda functions that can be used to perform tasks and customize workflows in your Amplify app. Functions can be written in Node.js, Python, Go, or any [other language supported by AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html).

> **Note**: 

**Note:** [Fullstack Git-based environments](https://docs.amplify.aws/react/how-amplify-works/concepts/#fullstack-git-based-environments) do not support Docker for functions bundling out of the box. To learn more [skip to the Docker section](#docker).

> **Note**: 

**Note:** The following options in `defineFunction` are not supported for Custom Functions:
- [Environment variables and secrets](/[platform]/build-a-backend/functions/environment-variables-and-secrets/)
- [Scheduling configuration](/[platform]/build-a-backend/functions/scheduling-functions/) 
- [Lambda layers](/[platform]/build-a-backend/functions/add-lambda-layers/)
- [Function options](/[platform]/build-a-backend/functions/configure-functions/)

You'll need to configure these options directly in your CDK Function definition instead. However, `resourceGroupName` property is supported and can be used to group related resources together in your `defineFunction` definition.

In this guide, you will learn how to create Python and Go functions with Amplify functions. The examples shown in this guide do not use Docker to build functions. Instead, the examples use commands that run on your host system to build, and as such require the necessary tooling for the language you are using for your functions.

## Python

To get started, create a new directory and a resource file, `amplify/functions/say-hello/resource.ts`. Then, define the function with `defineFunction`:
```ts title="amplify/functions/say-hello/resource.ts"

const functionDir = path.dirname(fileURLToPath(import.meta.url));

Next, create the corresponding handler file at `amplify/functions/say-hello/index.py`. This is where your function code will go.

```ts title="amplify/functions/say-hello/index.py"
import json

def handler(event, context):
  return ),
  }
```

The handler file _must_ export a function named "handler". This is the entry point to your function. For more information on writing functions, refer to the [AWS documentation for Lambda function handlers using Python](https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html).

If you need Python packages, you can add them to a `requirements.txt` file in the same directory as your handler file. The `bundling` option in the `Code.fromAsset` method will install these packages for you.
Create a `requirements.txt` file in the same directory as your handler file. This file should contain the names of the packages you want to install. For example:

```txt title="amplify/functions/say-hello/requirements.txt"
request==2.25.1
some-other-package>=1.0.0
```

You're now ready to deploy your python function. Next is the same process as the Node.js/TypeScript function. Go to [Common steps for all languages](#common-steps-for-all-languages) to continue.

## Go
To get started, Create a new directory and a resource file, `amplify/functions/say-hello/resource.ts`. Then, define the function with `defineFunction`:

```ts title="amplify/functions/say-hello/resource.ts"

const functionDir = path.dirname(fileURLToPath(import.meta.url));

Next, create the corresponding handler file at `amplify/functions/say-hello/main.go`. This is where your function code will go.

```go title="amplify/functions/say-hello/main.go"
package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

type Event struct 

type Arguments struct 

func HandleRequest(ctx context.Context, event Event) (string, error) 

func main() 
```

Then you should run the following command to build the go function:
```bash title="terminal" showLineNumbers=
go mod init lambda
```
then run to install the dependencies.

```bash title="terminal" showLineNumbers=
go mod tidy
```

You're now ready to deploy your golang function. Next is the same process as the Node.js/TypeScript function.

## Common steps for all languages

Regardless of the language used, your function needs to be added to your backend.
```ts title="amplify/backend.ts"
// highlight-next-line

defineBackend();
```

Now when you run `npx ampx sandbox` or deploy your app on Amplify, it will include your function.

To invoke your function, we recommend adding your [function as a handler for a custom query with your Amplify Data resource](/[platform]/build-a-backend/data/custom-business-logic/). To get started, open your `amplify/data/resource.ts` file and specify a new query in your schema:

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .returns(a.string())
    .handler(a.handler.function(sayHelloFunctionHandler)),
  // highlight-end
})

## Docker

Custom function may require [Docker](https://www.docker.com/) in order to build and bundle function's code. A deployment failing with `CustomFunctionProviderDockerError` error indicates that a custom function requires Docker but the Docker daemon was not found. In that case you need to provide a working Docker installation at runtime.

### Personal sandboxes

Ensure that Docker is installed on your computer and that Docker daemon is running. You can check if Docker daemon is running using the following command:
```bash title="terminal" showLineNumbers=
docker info
```

### Fullstack Git-based environments

Amplify does not provide Docker daemon out of the box in branch deployments. However, you have an option to provide [your own image that meets Amplify requirements](https://docs.aws.amazon.com/amplify/latest/userguide/custom-build-image.html) and includes a Docker installation.

For example, the `aws/codebuild/amazonlinux-x86_64-standard:5.0` image ([see definition](https://github.com/aws/aws-codebuild-docker-images)) meets Amplify requirements and includes Docker installation.


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/custom-functions/index.mdx`