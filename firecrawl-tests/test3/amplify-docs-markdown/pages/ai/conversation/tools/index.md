---
title: Model tools
source: pages/ai/conversation/tools/index.mdx
---

# Model tools

Tools allow LLMs to query information to respond with current and relevant information. They are invoked only if the LLM requests to use one based on the user's message and the tool's description.

There are a few different ways to define LLM tools in the Amplify AI kit.

1. Model tools
2. Query tools
3. Lambda tools

The easiest way to define tools for your conversation route is with `a.ai.dataTool()` for data models and custom queries in your data schema. When you define a tool for a conversation route, Amplify takes care of the heavy lifting:

* **Describing the tools to the LLM:** Each tool definition is an Amplify model query or custom query that is defined in the schema. Amplify knows the input parameters needed for that tool and describes them to the LLM.
* **Invoking the tool with the right parameters:** After the LLM requests to use a tool with necessary input parameters, the conversation handler Lambda function invokes the tool, returns the result to the LLM, and continues the conversation.
* **Maintaining the caller identity and authorization:** Through tools, the LLM can only access data that the application user has access to. When the LLM requests to invoke a tool, we will call it with the user's identity. For example, if the LLM wanted to invoke a query to list Todos, it would only return the todos that user has access to.

## Model tools

You can give the LLM access to your data models by referencing them in an `a.ai.dataTool()` with a reference to a model in your data schema. This requires that the model uses at least one of the following authorization strategies:

**[Per user data access](https://docs.amplify.aws/react/build-a-backend/data/customize-authz/per-user-per-owner-data-access/)**
- `owner()`
- `ownerDefinedIn()`
- `ownersDefinedIn()`

**[Any signed-in user data access](https://docs.amplify.aws/react/build-a-backend/data/customize-authz/signed-in-user-data-access/)**
- `authenticated()`

**[Per user group data access](https://docs.amplify.aws/react/build-a-backend/data/customize-authz/user-group-based-data-access/)**
- `group()`
- `groupsDefinedIn()`
- `groups()`
- `groupsDefinedIn()`

```ts title="amplify/data/resource.ts"

const schema = a.schema()
  .authorization(allow => allow.owner()),

  chat: a.conversation(),
    ],
  }),
})
```

This will let the LLM list and filter `Post` records. Because the data schema has all the information about the shape of a `Post` record, the data tool will provide that information to the LLM so you don't have to. Also, the Amplify AI kit handles authorizing the tool use requests based on the caller's identity. This means if you have an owner-based model, the LLM will only be able to query the user's records.

> **Note**: 

The only supported model operation is `'list'`.

## Query tools

You can also give the LLM access to custom queries defined in your data schema. To do so, define a custom query with a [function or custom handler](https://docs.amplify.aws/react/build-a-backend/data/custom-business-logic/) and then reference that custom query as a tool. This requires that the custom query uses the `allow.authenticated()` authorization strategy.

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .returns(a.customType())
    .handler(a.handler.function(getWeather))
    .authorization((allow) => allow.authenticated()),

  chat: a.conversation(),
    ]
  })
    .authorization((allow) => allow.owner()),
});
```

The Amplify data tool takes care of specifying the necessary input parameters to the LLM based on the query definition.

Below is an illustrative example of a Lambda function handler for the `getWeather` query.

```ts title="amplify/data/getWeather.ts"

  const url = `$?city=$`;
  const request = new Request(url, `
    }
  });

  const response = await fetch(request);
  const weather = await response.json();
  return weather;
}
```

Lastly, you will need to update your **`amplify/backend.ts`** file to include the newly defined `getWeather` function.

```ts title="amplify/backend.ts"

const backend = defineBackend();
```

### Connect to any AWS Service

You can connect to any AWS service by defining a custom query and calling that service in the function handler. To properly authorize the custom query function to call the AWS service, you will need to provide the Lambda with the proper permissions.

```ts title="amplify/backend.ts"

const backend = defineBackend();

backend.getWeather.resources.lambda.addToRolePolicy(
  new PolicyStatement(),
)
```

## Custom Lambda Tools

You can also define a tool that executes in the conversation handler AWS Lambda function. This is useful if you want to define a tool that is not related to your data schema or that does simple tasks within the Lambda function runtime.

First install the `@aws-amplify/backend-ai` package.

```bash title="Terminal"
npm install @aws-amplify/backend-ai
```

Define a custom conversation handler function in your data schema and reference the function in the `handler` property of the `a.conversation()` definition.

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .authorization((allow) => allow.owner()),
})
```

Define the executable tool(s) and handler. Below is an illustrative example of a custom conversation handler function that defines a `calculator` tool.

```ts title="amplify/data/chatHandler.ts"
import  from '@aws-amplify/backend-ai/conversation/runtime';

const jsonSchema = ,
      'operands': ,
        'minItems': 2,
        'maxItems': 2,
        'description': 'Two numbers to perform the operation on'
      }
    },
    required: ['operator', 'operands']
  }
} as const;
// declare as const to allow the input type to be derived from the JSON schema in the tool handler definition.

const calculator = createExecutableTool(
  'calculator',
  'Returns the result of a simple calculation',
  jsonSchema,
  // input type is derived from the JSON schema
  (input) => );
      case '-': return Promise.resolve();
      case '*': return Promise.resolve();
      case '/':
        if (b === 0) throw new Error('Division by zero');
        return Promise.resolve();
      default:
        throw new Error('Invalid operator');
    }
  },
);

Note that we throw an error in the `calculator` tool example above if the input is invalid. This error is surfaced to the LLM by the conversation handler function. Depending on the error message, the LLM may try to use the tool again with different input or completing its response with test for the user.

Lastly, update your backend definition to include the newly defined `chatHandler` function.

```ts title="amplify/backend.ts"

defineBackend();
```

### Best Practices

- Validate and sanitize any input from the LLM before using it in your application, e.g. don't use it directly in a database query or use `eval()` to execute it.
- Handle errors gracefully and provide meaningful error messages.
- Log and monitor tool usage to detect potential misuse or issues.
