---
title: Create a knowledge base
source: pages/ai/conversation/knowledge-base/index.mdx
---

# Create a knowledge base

[Amazon Bedrock knowledge bases](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base.html) are a great way to implement Retrieval Augmented Generation, or RAG for short. RAG is a common pattern in building generative AI applications that involves storing a lot of content, like documentation, in a vector database like Postgres with pg_vector or OpenSearch.

> **Note**: 

The default setup for an Amazon Bedrock knowledge base is OpenSearch Serverless which has a default cost whether or not you use it. You can get a large AWS bill if you are not careful. If you are just testing this out make sure to turn off the OpenSearch Serverless instance when you are done. 

## Create a knowledge base

To integrate Bedrock knowledge base with your conversation route, first [create an Amazon Bedrock knowledge base](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-create.html) in the console, CLI, or with CDK. 

## Create a custom query and tool

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .handler(
      a.handler.custom(),
    )
    .returns(a.string())
    .authorization((allow) => allow.authenticated()),
  // highlight-end

  chat: a.conversation(),
    ]
    // highlight-end
  })
})
```

## Write an AWS AppSync resolver

Then you'll need to create a JavaScript AWS AppSync resolver to connect the query to the knowledge base. You'll need to know the ID of the knowledge base you want to use, which you can find in the Amazon Bedrock console or with the AWS CLI.

```javascript title="amplify/data/resolvers/kbResolver.js"

```

## Define the data source

Then in the amplify backend file you will need to create the data source for the knowledge base query and give it permission to call the knowledge base. 

```ts title="amplify/backend.ts"

const backend = defineBackend();

const KnowledgeBaseDataSource =
  backend.data.resources.graphqlApi.addHttpDataSource(
    "KnowledgeBaseDataSource",
    `https://bedrock-agent-runtime.$.amazonaws.com`,
    ,
    },
  );

KnowledgeBaseDataSource.grantPrincipal.addToPrincipalPolicy(
  new PolicyStatement(:[account ID]:knowledge-base/[knowledge base ID]`
    ],
    actions: ["bedrock:Retrieve"],
  }),
);
```

That's it!
