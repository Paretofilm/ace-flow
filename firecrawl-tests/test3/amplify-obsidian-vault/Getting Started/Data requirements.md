---
title: Data requirements
topics: ['Getting Started', 'Data & APIs']
primary_topic: Getting Started
source: fragments/start/getting-started/vue/data-model.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]] • [[Data & APIs/]]
**Primary**: [[Getting Started/]]

---


# Data requirements

### Data requirements

For this app, you have the following requirements:

1. A list of todos
2. Ability to create/update/delete a todo

## Create GraphQL API and database

Given these requirements, you'll need to be able to query the API for a list of todos and also provide a way to send updates to the API to create, update, and delete todos.

It's time to create the GraphQL API. From the root of the project, run the following:

```bash
amplify add api
```

Select the default values which are highlighted below:

```console
? Please select from one of the below mentioned services:
# GraphQL
? Provide API name:
# myapi
? Choose the default authorization type for the API:
# API Key
? Enter a description for the API key:
# demo
? After how many days from now the API key should expire:
# 7 (or your preferred expiration)
? Do you want to configure advanced settings for the GraphQL API:
# No
? Do you have an annotated GraphQL schema?
# No
? Choose a schema template:
# Single object with fields (e.g., “Todo” with ID, name, description)
? Do you want to edit the schema now?
# Yes
```

The CLI should open this GraphQL schema in your text editor.

**amplify/backend/api/myapi/schema.graphql**

```graphql
# This "input" configures a global authorization rule to enable public access to
# all models in this schema. Learn more about authorization rules here: https://docs.amplify.aws/react/build-a-backend/graphqlapi/customize-authorization-rules/
input AMPLIFY 
} # FOR TESTING ONLY!
type Todo @model 
```

The schema generated is for a Todo app. You'll notice a directive on the `Todo` type of `@model`. This directive is part of the [GraphQL transform](/gen1/[platform]/build-a-backend/graphqlapi/data-modeling/) library of Amplify.

The GraphQL Transform Library provides custom directives you can use in your schema that allow you to do things like define data models, set up authentication and authorization rules, configure serverless functions as resolvers, and more.

A type decorated with the `@model` directive will scaffold out the database table for the type (Todo table), the schema for CRUD (create, read, update, delete) and list operations, and the GraphQL resolvers needed to make everything work together.

From the command line, press **enter** to accept the schema and continue to the next steps.

## Deploy your GraphQL API

Now that the API has been successfully created. You need to push your updated configuration to the cloud so your API can be deployed:

```bash
amplify push
```

## Generate frontend code for the GraphQL API

When you run `amplify push`, you will be have the option to have all the GraphQL operations found in your schema generated for you in code. Choose the following options:

```console
Do you want to generate code for your newly created GraphQL API (Yes)
Choose the code generation language target (javascript)
Enter the file name pattern of graphql queries, mutations and subscriptions (src/graphql/**/*.js)
Do you want to generate/update all possible GraphQL operations - queries, mutations and subscriptions (Yes)
Enter maximum statement depth [increase from default if your schema is deeply nested] (2)
```

Next, run the following command to check Amplify's status:

```bash
amplify status
```

This will give us the current status of the Amplify project, including the current environment, any categories that have been created, and what state those categories are in. It should look similar to this:

```console
Current Environment: dev

| Category | Resource name | Operation | Provider plugin   |
| -------- | ------------- | --------- | ----------------- |
| Api      | myapi         | No Change | awscloudformation |
```

### Testing your API

To view services deployed in your project at any time in the AWS Amplify Console, run the following command.

```bash
amplify console
```

This will open your Amplify project in the AWS service console. Choose the **API** tab to view your AppSync API. Clicking on the API, will open the AWS AppSync console where you can run Queries, Mutations, or Subscriptions at the server and see the changes in your client app.

## Connect frontend to API

Next, open **App.vue**.

### Writing data with GraphQL mutations

To create a new todo in the database, create a `client` by using the `generateClient()` operation, then pass the `createTodo` mutation into `client.graphql()` along with the data you'd like to write.

```html
<template>
  <div id="app">
    <h1>Todo App</h1>
    <input type="text" v-model="name" placeholder="Todo name" />
    <input type="text" v-model="description" placeholder="Todo description" />
    <button v-on:click="createTodo">Create Todo</button>
  </div>
</template>

<script>
  import  from 'aws-amplify/api';
  import  from './graphql/mutations';

  const client = generateClient();

  export default ;
    },
    methods:  = this;
        if (!name || !description) return;
        const todo = ;
        await client.graphql(
        });
        this.name = '';
        this.description = '';
      }
    }
  };
</script>
```

### Reading data with GraphQL queries

To display the data, update `App.vue` to list all the items in the database by importing `listTodos` and then using the `created()` Vue lifecycle method to update the page when a query runs on page load:

```html
<template>
  <div id="app">
    <h1>Todo App</h1>
    <input type="text" v-model="name" placeholder="Todo name" />
    <input type="text" v-model="description" placeholder="Todo description" />
    <button v-on:click="createTodo">Create Todo</button>
    <div v-for="item in todos" :key="item.id">
      <h3>}</h3>
      <p>}</p>
    </div>
  </div>
</template>

<script>
  import  from 'aws-amplify/api';
  import  from './graphql/mutations';
  import  from './graphql/queries';

  const client = generateClient();

  export default ,
    data() ;
    },
    methods:  = this;
        if (!name || !description) return;
        const todo = ;
        await client.graphql(
        });
        this.name = '';
        this.description = '';
      },
      async getTodos() );
        this.todos = todos.data.listTodos.items;
      }
    }
  };
</script>
```

### Real-time data with GraphQL subscriptions

Now if you wish to subscribe to data, import the `onCreateTodo` subscription and create a new subscription by adding subscription with `API.graphql()` like so:

```html
<script>
  // other imports
  import  from './graphql/subscriptions';

  export default ,
    methods: ).subscribe() => 
        });
      }
    }
  };
</script>
```


---

## 📚 Related Topics
- [[Getting Started/]]
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/start/getting-started/vue/data-model.mdx`