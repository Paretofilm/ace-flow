---
title: Step 1 - Set up the project
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/custom-business-logic/connect-amazon-translate/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Step 1 - Set up the project

Amazon Translate is a neural machine translation service provided by Amazon Web Services (AWS). It uses advanced deep learning technologies to deliver fast and high-quality language translation. With Amazon Translate, you can easily add multilingual support to your applications and services, enabling users to communicate and interact in their preferred language.

Key features of Amazon Translate include:

- **Accurate and Fluent Translations**: Amazon Translate produces translations that are both accurate and natural-sounding, providing a seamless experience for users.

- **Support for Multiple Languages**: The service supports a broad range of languages, allowing you to expand your application’s reach to diverse audiences around the world.

- **Real-Time and Batch Translation**: Amazon Translate can handle real-time translation for dynamic content and batch translation for larger volumes of text, making it suitable for various use cases.

- **Cost-Effective and Scalable**: With its pay-as-you-go pricing model and automatic scaling, Amazon Translate is an economical and flexible solution for adding translation capabilities to your applications.

In this section, you will learn how to integrate Amazon Translate into your application using AWS Amplify, enabling you to leverage its powerful translation capabilities effortlessly.

## Step 1 - Set up the project

Set up your project by following the instructions in the [Quickstart guide](/[platform]/start/quickstart/).

## Step 2 - Install Amazon Translate libraries
To install the Amazon Translate SDK, run the following command in your project's root folder:

```bash title="Terminal" showLineNumbers=
npm add @aws-sdk/client-translate
```

## Step 3 - Add your Amazon Translate as Datasource

 To access Amazon Translate service, you need to add Amazon Translate as an HTTP Data Source and configure the proper IAM policy for AWS Lambda to utilize the desired feature effectively. Update `amplify/backend.ts` file as shown below.

 ```ts title="amplify/backend.ts"

const backend = defineBackend();

const translateDataSource = backend.data.addHttpDataSource(
  "TranslateDataSource",
  `https://translate.$.amazonaws.com`,
  ,
  }
);

translateDataSource.grantPrincipal.addToPrincipalPolicy(
  new PolicyStatement()
);
```
## Step 4 - Configure custom business logic handler

Next, create the following `translate.js` file in your `amplify/data` folder and use the code below to define custom resolvers.

```ts title="amplify/data/translate.js"

```

## Step 5 - Define the custom query

After adding Amazon Translate as a data source, you can reference it in a custom query using the `a.handler.custom()` modifier, which takes the name of the data source and an entry point for your resolvers. In your `amplify/data/resource.ts` file, specify `TranslateDataSource` as the data source and `translate.js` as the entry point, as shown below.

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .returns(a.string())
    .authorization(allow => [allow.publicApiKey()])
    .handler(a.handler.custom())
});

```

## Step 6 - Configure the frontend

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point.

``` ts title="main.tsx"

Amplify.configure(outputs);
```
### Invoke the API

Sample frontend code to translate text from one language to another.

```ts

const client = generateClient();

const  = await client.queries.translate();
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/custom-business-logic/connect-amazon-translate/index.mdx`