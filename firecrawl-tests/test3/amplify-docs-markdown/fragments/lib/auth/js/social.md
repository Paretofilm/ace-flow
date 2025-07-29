---
title: OAuth and Federation Overview
source: fragments/lib/auth/js/social.mdx
---

# OAuth and Federation Overview

## OAuth and Federation Overview

[OAuth 2.0](https://en.wikipedia.org/wiki/OAuth) is the common Authorization framework used by web and mobile applications for getting access to user information ("scopes") in a limited manner. Common analogies you will hear in OAuth is that of boarding a plane or staying in a hotel - showing your identification is the Authentication piece (signing into an app) and using the boarding pass/hotel key is what you are Authorized to access.

OAuth support in Amplify uses Cognito User Pools and supports federation with social providers, which will automatically create a corresponding user in the User Pool after a login. [OIDC](https://en.wikipedia.org/wiki/OpenID_Connect) tokens are available in the app after the application has completed this process.

> **Note**: 
 When configuring social sign-in through the Amplify CLI, it's important to exercise caution when designating attributes as "required." Different social identity providers have varied scopes in terms of the information they respond back to Cognito with.  User pool attributes that are initially set up as "required" cannot be changed later, and may require you to migrate the users or create a new user pool.  

## Configure Auth Category
Once you have the social provider configured, run the following in your project’s root folder:

```bash
amplify add auth     ## "amplify update auth" if already configured
```

Choose the following options (the last steps are specific to Facebook here but are similar for other providers):

```console
? Do you want to use the default authentication and security configuration? 
    `Default configuration with Social Provider (Federation)`
? How do you want users to be able to sign in? 
    `Username`
? Do you want to configure advanced settings? 
    `No, I am done.`
? What domain name prefix you want us to create for you? 
    `(default)`
? Enter your redirect signin URI: 
    `http://localhost:3000/`
? Do you want to add another redirect signin URI 
    `No`
? Enter your redirect signout URI: 
    `http://localhost:3000/`
? Do you want to add another redirect signout URI 
    `No`
? Select the social providers you want to configure for your user pool: 
    `<choose your provider and follow the prompts to input the proper tokens>`
```

> **Note**: 

You can configure you application to use more than one redirect URL. For more information, refer to the [Redirect URLs](#redirect-urls) section.

## Setup frontend

After configuring the OAuth endpoints (Cognito Hosted UI), you can integrate your App by invoking `Auth.federatedSignIn()` function. Passing `LoginWithAmazon`, `Facebook`, `Google`, or `SignInWithApple` on the `provider` argument (e.g `Auth.federatedSignIn()`) will bypass the Hosted UI and federate immediately with the social provider as shown in the below React example. If you are looking to add a custom state, you are able to do so by passing a string (e.g. `Auth.federatedSignIn()`) value and listening for the custom state via Hub.

```ts

Amplify.configure(amplifyconfig);

function App() }) => 
    });

    getUser();

    return unsubscribe;
  }, []);

  const getUser = async (): Promise<void> =>  catch(error) 
  };
  
  return (
    <div className="App">
      <button onClick=>Open Hosted UI</button>
      <button onClick=)}>Open Facebook</button>
      <button onClick=)}>Open Google</button>
      <button onClick=)}>Open Amazon</button>
      <button onClick=)}>Open Apple</button>
      <button onClick=>Sign Out</button>
      <div></div>
    </div>
  );
}
```
</Block>

```javascript

Amplify.configure(amplifyconfig);

function App()  }) => 
    });

    Auth.currentAuthenticatedUser()
      .then(currentUser => setUser(currentUser))
      .catch(() => console.log("Not signed in"));

    return unsubscribe;
  }, []);

	return (
    <div className="App">
      <button onClick=>Open Hosted UI</button>
      <button onClick=)}>Open Facebook</button>
      <button onClick=)}>Open Google</button>
      <button onClick=)}>Open Amazon</button>
      <button onClick=)}>Open Apple</button>
      <button onClick=>Sign Out</button>
      <div></div>
    </div>
  );
}
```
</Block>
</BlockSwitcher>

> **Note**: 

You can also use the [Authenticator UI component](https://ui.docs.amplify.aws/react/components/authenticator) to add social sign in flow to your application. Visit [Social Provider](https://ui.docs.amplify.aws/react/components/authenticator/configuration#social-providers) section to learn more.

### Deploying to Amplify Console

To deploy your app to Amplify Console with continuous deployment of the frontend and backend, please follow [these instructions](https://docs.aws.amazon.com/amplify/latest/userguide/environment-variables.html#creating-a-new-backend-environment-with-authentication-parameters).

### Redirect URLs

For *Sign in Redirect URI(s)* inputs, you can put one URI for local development and one for production. Example: `http://localhost:3000/` in dev and `https://www.example.com/` in production. The same is true for *Sign out redirect URI(s)*.

**Note:** if you have multiple redirect URI inputs, you'll need to handle both of them where you configure your Amplify project. For example:

```javascript

const isLocalhost = Boolean(
  window.location.hostname === "localhost" ||
    // [::1] is the IPv6 localhost address.
    window.location.hostname === "[::1]" ||
    // 127.0.0.1/8 is considered localhost for IPv4.
    window.location.hostname.match(
      /^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))$/
    )
);

// Assuming you have two redirect URIs, and the first is for localhost and second is for production
const [
  localRedirectSignIn,
  productionRedirectSignIn,
] = amplifyconfig.oauth.redirectSignIn.split(",");

const [
  localRedirectSignOut,
  productionRedirectSignOut,
] = amplifyconfig.oauth.redirectSignOut.split(",");

const updatedAwsConfig = 
}

Amplify.configure(updatedAwsConfig);
```

### Full Sample

```ts

const isLocalhost = Boolean(
  window.location.hostname === 'localhost' ||
    // [::1] is the IPv6 localhost address.
    window.location.hostname === '[::1]' ||
    // 127.0.0.1/8 is considered localhost for IPv4.
    window.location.hostname.match(
      /^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))$/
    )
);

// Assuming you have two redirect URIs, and the first is for localhost and second is for production
const [
  localRedirectSignIn,
  productionRedirectSignIn,
] = amplifyconfig.oauth.redirectSignIn.split(',');

const [
  localRedirectSignOut,
  productionRedirectSignOut,
] = amplifyconfig.oauth.redirectSignOut.split(',');

const updatedAwsConfig = 
}

Amplify.configure(updatedAwsConfig);

function App() }) => 
    });

    getUser();
  }, []);

  const getUser = async (): Promise<void> =>  catch(error) 
  };

  return (
    <div>
      <p>User: </p>
      >Sign Out</button>
      ) : (
        <button onClick=>Federated Sign In</button>
      )}
    </div>
  );
}

```js

const isLocalhost = Boolean(
  window.location.hostname === 'localhost' ||
    // [::1] is the IPv6 localhost address.
    window.location.hostname === '[::1]' ||
    // 127.0.0.1/8 is considered localhost for IPv4.
    window.location.hostname.match(
      /^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))$/
    )
);

// Assuming you have two redirect URIs, and the first is for localhost and second is for production
const [
  localRedirectSignIn,
  productionRedirectSignIn,
] = amplifyconfig.oauth.redirectSignIn.split(',');

const [
  localRedirectSignOut,
  productionRedirectSignOut,
] = amplifyconfig.oauth.redirectSignOut.split(',');

const updatedAwsConfig = 
}

Amplify.configure(updatedAwsConfig);

function App()  }) => 
    });

    getUser().then(userData => setUser(userData));
  }, []);

  function getUser() 

  return (
    <div>
      <p>User: </p>
      >Sign Out</button>
      ) : (
        <button onClick=>Federated Sign In</button>
      )}
    </div>
  );
}

### Catching Errors

In order to catch errors when using `Auth.federatedSignIn()` you can use the [Hub](/gen1/[platform]/build-a-backend/utilities/hub/) eventing system provided by Amplify to listen for the `signIn_failure` event.

```ts

Hub.listen('auth', (data) => 
})
```
</Block>

```js

Hub.listen('auth', (data) => 
})
```
</Block>
</BlockSwitcher>
