---
title: Authentication with Amplify
source: fragments/start/getting-started/reactnative/auth.mdx
---

# Authentication with Amplify

The next feature you will be adding is authentication.

## Authentication with Amplify

Amplify uses [Amazon Cognito](https://aws.amazon.com/cognito/) as its authentication provider. Amazon Cognito is a robust user directory service that handles user registration, authentication, account recovery & other operations. In this tutorial, you'll learn how to add authentication to your application using Amazon Cognito and username/password login.

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

Creating a login flow can be quite difficult and time consuming to get right. Luckily, Amplify UI has an [`Authenticator`](https://ui.docs.amplify.aws/react-native/connected-components/authenticator) component that provides an entire authentication flow for you, using the configuration you specified in **amplifyconfiguration.json.**

### Install Amplify UI

The `@aws-amplify/ui-react-native` package includes React Native specific UI components you'll use to build your app. Install it with the following command:

```bash
npm install @aws-amplify/ui-react-native react-native-safe-area-context@^4.2.5 react-native-get-random-values react-native-url-polyfill
```

</Block>

```bash
npm install @aws-amplify/ui-react-native react-native-safe-area-context@^4.2.5 react-native-get-random-values react-native-url-polyfill
```

You will also need to install the pod dependencies for iOS:

```sh
npx pod-install
```

After installing pod dependencies, rebuild the app:

```sh
npm run ios
```

</Block>
</BlockSwitcher>

### Add the Amplify UI Authenticator component

Open **App.js** and make the following changes:

</Block>

Open **App.tsx** and make the following changes:

</Block>
</BlockSwitcher>

1. Import the `withAuthenticator` Higher-Order Component and `useAuthenticator` hook:

```javascript
````

2. Create a custom `SignOutButton` component that will be used within the App component and only re-render when its `user` context changes. Destructure the `user` and `signOut` properties returned from the hook. 

```javascript
// retrieves only the current value of 'user' from 'useAuthenticator'
const userSelector = (context) => [context.user]

const SignOutButton = () =>  = useAuthenticator(userSelector);
  return (
    
      Hello, ! Click here to sign out!</Text>
    </Pressable>
  )
};
```

3. Add the `SignOutButton` component to your `App` component inside of the containers you defined in the last section:

```javascript
// ...
return (

//...
```

4. Lastly, wrap your `App` export with the `withAuthenticator` Amplify UI component:

```javascript

Run the app to see the new authentication flow protecting the app:

```bash
npm start
```

Now you should see the app load with an authentication flow allowing users to sign up and sign in. Below you can find a full sample of the code:

```javascript
import  from 'react-native';
import  from '@aws-amplify/ui-react-native';

Amplify.configure(awsExports);

// retrieves only the current value of 'user' from 'useAuthenticator'
const userSelector = (context) => [context.user]

const SignOutButton = () =>  = useAuthenticator(userSelector);
  return (

        Hello, ! Click here to sign out!
      </Text>
    </Pressable>
  );
};

const initialFormState = ;
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
      setFormState(initialFormState);
      await client.graphql(
      });
    } catch (err) 
  }

  return (

         setInput('name', value)}
          style=
          value=
          placeholder="Name"
        />
         setInput('description', value)}
          style=
          value=
          placeholder="Description"
        />
        
          Create todo</Text>
        </Pressable>
        </Text>
            </Text>
          </View>
        ))}
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create(,
  todo: ,
  input: ,
  todoName: ,
  buttonContainer: ,
  buttonText: ,
});
```

</Block>

```javascript
import  from 'react-native';
import  from '@aws-amplify/ui-react-native';

// retrieves only the current value of 'user' from 'useAuthenticator'
const userSelector = (context) => [context.user]

const SignOutButton = () =>  = useAuthenticator(userSelector);
  return (

        Hello, ! Click here to sign out!
      </Text>
    </Pressable>
  );
};

const initialFormState = ;
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
      setFormState(initialFormState);
      await client.graphql(
      });
    } catch (err) 
  }

  return (

         setInput('name', value)}
          style=
          value=
          placeholder="Name"
        />
         setInput('description', value)}
          style=
          value=
          placeholder="Description"
        />
        
          Create todo</Text>
        </Pressable>
        </Text>
            </Text>
          </View>
        ))}
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create(,
  todo: ,
  input: ,
  todoName: ,
  buttonContainer: ,
  buttonText: ,
});
```

</Block>
</BlockSwitcher>

Using Amplify UI connected components makes it easier to manage styling across your entire app.

In this example, you used the Amplify React UI library and the `withAuthenticator` Higher-Order Component to quickly get up and running with a real-world authentication flow.

You can also [customize this component](https://ui.docs.amplify.aws/react-native/connected-components/authenticator/customization) to add or remove fields, update styling, or other configurations. You can even [override function calls](https://ui.docs.amplify.aws/react-native/connected-components/authenticator/customization#override-function-calls) if needed.

In addition to `withAuthenticator`, you can build [custom authentication flows with the Amplify Library for JS](/gen1/[platform]/build-a-backend/auth/set-up-auth/). Amplify's Auth category has over 30 APIs including `signUp`, `signIn`, `forgotPassword`, and `signOut` that allow you full control over all aspects of the user authentication flow. Check out the complete API [here](https://aws-amplify.github.io/amplify-js/api/modules/aws_amplify.auth.html).
