---
title: Create a GraphQL API and database
topics: ['Getting Started', 'React']
primary_topic: Getting Started
source: fragments/start/getting-started/react/api.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started, react]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]] • [[React/]]
**Primary**: [[Getting Started/]]

---


# Create a GraphQL API and database

Now that you’ve created and configured a React app and initialized a new Amplify project, you can add a feature. The first feature you will add is an API.

The Amplify CLI supports creating and interacting with two types of API categories: REST and GraphQL.

The API you will be creating in this step is a GraphQL API using AWS AppSync (a managed GraphQL service) and the database will be Amazon DynamoDB (a NoSQL database).

## Create a GraphQL API and database

Add a [GraphQL API](https://docs.aws.amazon.com/appsync/latest/devguide/designing-a-graphql-api.html) to your app and automatically provision a database by running the following command from the root of your application directory:

```bash
amplify add api
```

Accept the **default values** which are highlighted below:

```console
? Select from one of the below mentioned services: GraphQL
? Here is the GraphQL API that we will create. Select a setting to edit or continue Continue
? Choose a schema template: Single object with fields (e.g., “Todo” with ID, name, description)
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

### Deploying the API

To deploy this backend, run the `push` command:

```bash
amplify push

? Are you sure you want to continue? Yes
? Do you want to generate code for your newly created GraphQL API: Yes
? Choose the code generation language target: javascript
? Enter the file name pattern of graphql queries, mutations and subscriptions: src/graphql/**/*.js
? Do you want to generate/update all possible GraphQL operations - queries, mutations and subscriptions: Yes
? Enter maximum statement depth [increase from default if your schema is deeply nested]: 2
```

Now the API is live and you can start interacting with it!

The API you have deployed is for a Todo app, including operations for creating, reading, updating, deleting, and listing todos.

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

To view the GraphQL API in the AppSync console at any time, run the following command:

```bash
amplify console api
```

To view your entire app in the Amplify console at any time, run the following command:

```bash
amplify console
```

### (Optional) Test your API

To test this out locally, you can run the `mock` command.

> If you'd like to go ahead and connect the front end, you can [jump to the next step](#connect-frontend-to-api).

```bash
amplify mock api
```

_Note:_ `amplify mock api` requires Java. If you have not already deployed your API with `amplify push`, you will be walked through the following steps for GraphQL code generation.

```console
? Do you want to generate code for your newly created GraphQL API: Yes
? Choose the code generation language target: javascript
? Enter the file name pattern of graphql queries, mutations and subscriptions: src/graphql/**/*.js
? Do you want to generate/update all possible GraphQL operations - queries, mutations and subscriptions: Yes
? Enter maximum statement depth [increase from default if your schema is deeply nested]: 2
```

This will open the GraphiQL explorer on a local port. From the test environment you can try out different operations locally, like queries and mutations.

Try running a couple of mutations locally and then querying for the todos:

```graphql
mutation createTodo 
  ) 
}

query listTodos 
  }
}
```

## Connect frontend to API

In this section you will create a way to list and create todos from the React application. To do this, you will create a form with a button to create todos as well as a way to fetch and render the list of todos.

Open **src/App.jsx** and replace it with the following code:

```javascript

Amplify.configure(amplifyconfig);

const initialState = ;
const client = generateClient();

const App = () => , []);

  function setInput(key, value) );
  }

  async function fetchTodos() );
      const todos = todoData.data.listTodos.items;
      setTodos(todos);
    } catch (err) 
  }

  async function addTodo() ;
      setTodos([...todos, todo]);
      setFormState(initialState);
      await client.graphql(
      });
    } catch (err) 
  }

  return (
    <div style=>
      <h2>Amplify Todos</h2>
      <input
        onChange=
        style=
        value=
        placeholder="Name"
      />
      <input
        onChange=
        style=
        value=
        placeholder="Description"
      />
      <button style= onClick=>
        Create Todo
      </button>
       style=>
          <p style=></p>
          <p style=></p>
        </div>
      ))}
    </div>
  );
};

const styles = ,
  todo: ,
  input: ,
  todoName: ,
  todoDescription: ,
  button: 
};

Let's walk through some of the functions:

**useEffect** - After the component renders, the `useEffect` hook is called and it invokes the `fetchTodos` function.

**fetchTodos** - Uses the Amplify API `client` created by `generateClient()` to call the AppSync GraphQL API with the `listTodos` query. Once the data is returned, the items array is passed in to the `setTodos` function to update the local state.

**addTodo** - Uses the Amplify API `client` created by `generateClient()` to call the AppSync GraphQL API with the `createTodo` mutation. A difference between the `listTodos` query and the `createTodo` mutation is that `createTodo` accepts an argument containing the variables needed for the mutation.

## Run locally

Next, run the app and you should see the form rendered to the screen and be able to create and view the list of todos:

```bash
npm run dev
```


---

## 📚 Related Topics
- [[Getting Started/]]
- [[React/]]

## 📖 Source
Original: `fragments/start/getting-started/react/api.mdx`