---
title: Create authentication service
source: fragments/start/getting-started/react/auth.mdx
---

# Create authentication service

The next feature you will be adding is authentication. Amplify uses [Amazon Cognito](https://aws.amazon.com/cognito/) as the main authentication provider. Amazon Cognito is a robust user directory service that handles user registration, authentication, account recovery & other operations. In this tutorial, you'll learn how to add authentication to your application using Amazon Cognito and username/password login.

## Create authentication service

To add authentication to your app, run this command:

```bash
amplify add auth
```

Select the defaults for the following prompts:

```console
? Do you want to use the default authentication and security configuration? Default configuration
Warning: you will not be able to edit these selections.
? How do you want users to be able to sign in? Username
? Do you want to configure advanced settings? No, I am done.
```

To deploy the service, run the `push` command:

```bash
amplify push
```

Now, the authentication service has been deployed and you can start using it. To view the deployed services in your project at any time, go to Amplify Console by running the following command:

```bash
amplify console
```

## Create login UI

Creating a login flow can be quite difficult and time consuming to get right. Luckily, Amplify UI has an [authentication](https://ui.docs.amplify.aws/react/components/authenticator) component that provides an entire authentication flow for you, using the configuration you specified in **amplifyconfiguration.json**.

### Install Amplify UI

The `@aws-amplify/ui-react` package includes React specific UI components you'll use to build your app. Install it with this:

```bash
npm install @aws-amplify/ui-react
```

### Add the Amplify UI Authenticator component

Open **src/App.jsx** and make the following changes:

1. Import the `withAuthenticator` component:

```javascript
import '@aws-amplify/ui-react/styles.css';
```

2. Pass `` to the `App` component. (For Vite's default React configuration, you'll also need to add "PropTypes" to validate the `signOut` and `user` props):

```javascript
/* src/App.jsx */
// ... other imports

const App = () => 

App.propTypes = 
```

3. Add this heading and button block to the top of your `App` component:

```javascript
return (
  <div style=>
    Hello </Heading>
    Sign out</Button>
    <h2>Amplify Todos</h2>
    ...
  </div>
);
```

4. Lastly, wrap your `App` export with the `withAuthenticator` Amplify UI component:

```javascript

Run the app to see the new authentication flow protecting the app:

```bash
npm run dev
```

Now you should see the app load with an authentication flow allowing users to sign up and sign in.

Here's all the code below:

```javascript
/* src/App.js */
import '@aws-amplify/ui-react/styles.css';

Amplify.configure(awsExports);

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
      Hello </Heading>
      
        Sign out
      </Button>
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

App.propTypes = 

</Accordion>

You used two Amplify UI components, `Heading` and `Button`. You could also convert the rest of the app to Amplify UI components by replacing the `p` tags with `Text`, the `input`s with `TextField`s and the `div`s with `View`s.

1. Add the `Text`, `TextField`, `View` components to the imported components from Amplify UI:

```javascript
import  from '@aws-amplify/ui-react';
```

2. Replace the `p` tags with `Text`, the `input`s with `TextField`s and the `div`s with `View`s in your `App` component:

```javascript

  Hello </Heading>
  
    Sign out
  </Button>
  Amplify Todos</Heading>
   setInput('name', event.target.value)}
    style=
    defaultValue=
  />
   setInput('description', event.target.value)}
    style=
    defaultValue=
  />
  
    Create Todo
  </Button>
  </Text>
      </Text>
    </View>
  ))}
</View>
```

</Accordion>

Using Amplify UI components together makes it easier to manage styling across your entire app.

In this example, you used the Amplify React UI library and the `withAuthenticator` component to quickly get up and running with a real-world authentication flow.

You can also [customize this component](https://ui.docs.amplify.aws/react/components/authenticator/customization) to add or remove fields, update styling, or other configurations. You can even [override function calls](https://ui.docs.amplify.aws/react/components/authenticator/customization#override-function-calls) if needed.

If you would like to build your own authentication flow instead, you can use the [Auth category in Amplify Libraries for JS](/gen1/[platform]/build-a-backend/auth/set-up-auth/). Amplify's Auth category over 30 APIs including `signUp`, `signIn`, `forgotPassword`, and `signOut` that allow you full control over all aspects of the user authentication flow. Check out the complete API [here](https://aws-amplify.github.io/amplify-js/api/modules/aws_amplify.auth.html).

In the next section, you'll host your app on the Amplify Console, a hosting service complete with a globally available CDN, automatic deployments, easy custom domains, and CI / CD.
