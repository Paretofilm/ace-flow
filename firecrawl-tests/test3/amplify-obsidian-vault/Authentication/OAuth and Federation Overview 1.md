---
title: OAuth and Federation Overview
topics: ['Authentication', 'React']
primary_topic: Authentication
source: fragments/lib/auth/js/react-native-social.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, react]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[React/]]
**Primary**: [[Authentication/]]

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

Choose the following options:

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
    `myapp://`
? Do you want to add another redirect signin URI 
    `No`
? Enter your redirect signout URI: 
    `myapp://`
? Do you want to add another redirect signout URI 
    `No`
? Select the social providers you want to configure for your user pool: 
    `<choose your provider and follow the prompts to input the proper tokens>`
```

> **Note**: 

You can configure you application to use more than one redirect URL. For more information, refer to the [Redirect URLs](#redirect-urls) section.

## Setup frontend

After configuring the OAuth endpoints (Cognito Hosted UI), you can integrate your App by invoking `Auth.federatedSignIn()` function. Passing `LoginWithAmazon`, `Facebook`, `Google`, or `SignInWithApple` on the `provider` argument (e.g `Auth.federatedSignIn()`) will bypass the Hosted UI and federate immediately with the social provider as shown in the below React Native example. If you are looking to add a custom state, you are able to do so by passing a string (e.g. `Auth.federatedSignIn()`) value and listening for the custom state via Hub.

```ts

Amplify.configure(amplifyconfig);

  useEffect(() => }) => 
    });

    getUser();

    return unsubscribe;
  }, []);

  const getUser = async (): Promise<void> =>  catch(error) 
  };
  
  return (

          Auth.federatedSignIn()
        }
      />
       Auth.federatedSignIn()} />
       Auth.signOut()} />
      </Text>
    </View>
  );
}
```
</Block>

```javascript

Amplify.configure(awsconfig);

  useEffect(() =>  }) => 
    });

    Auth.currentAuthenticatedUser()
      .then(currentUser => setUser(currentUser))
      .catch(() => console.log("Not signed in"));

    return unsubscribe;
  }, []);

  return (

          Auth.federatedSignIn()
        }
      />
       Auth.federatedSignIn()} />
       Auth.signOut()} />
      </Text>
    </View>
  );
}
```
</Block>
</BlockSwitcher>

### Deploying to Amplify Console

To deploy your app to Amplify Console with continuous deployment of the frontend and backend, please follow [these instructions](https://docs.aws.amazon.com/amplify/latest/userguide/environment-variables.html#creating-a-new-backend-environment-with-authentication-parameters).

### Redirect URLs

For *Sign in Redirect URI(s)* inputs, you can put one URI for local development and one for production. For example, in Expo: `exp://127.0.0.1:19000/--/` in dev and `myapp://` in production. The same is true for *Sign out redirect URI(s)*.

**Note:** if you have multiple redirect URI inputs, you'll need to handle both of them where you configure your Amplify project. For example:

```javascript

const isLocalhost = Boolean(__DEV__);

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

For React Native applications, you need to define a custom URL scheme for your application before testing locally or publishing to the app store. This is different for Expo or vanilla React Native. For Expo, follow the steps in [Expo Linking Guide](https://docs.expo.io/guides/linking/). For vanilla React Native, follow the steps in [React Native Linking Guide](https://reactnative.dev/docs/linking). After completing those steps, assuming you are using `myapp` as the name of your URL Scheme (or whatever friendly name you have chosen), you will use these URLs as *Sign in Redirect URI(s)* and/or *Sign out redirect URI(s)* inputs. Your URIs could look like any of these:

- `myapp://`
- `exp://127.0.0.1:19000/--/` (Local development if your app is running [in the Expo client](https://docs.expo.dev/guides/linking/#linking-to-your-app)).

*React Native - iOS - Info.plist*

```xml

 <plist version="1.0">

  <dict>
  <!-- YOUR OTHER PLIST ENTRIES HERE -->

  <!-- ADD AN ENTRY TO CFBundleURLTypes for Cognito Auth -->
  <!-- IF YOU DO NOT HAVE CFBundleURLTypes, YOU CAN COPY THE WHOLE BLOCK BELOW -->
  <key>CFBundleURLTypes</key>
  <array>
    <dict>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>myapp</string>
      </array>
    </dict>
  </array>

  <!-- ... -->
  </dict>
```

*React Native - Android - AndroidManifest.xml*

- Set the `launchMode` of MainActivity to `singleTask`
- Add new intent filter (below) with `scheme="myapp"`

```xml
<application>
  <activity
    android:name=".MainActivity"
    android:launchMode="singleTask">

    <intent-filter>
      <action android:name="android.intent.action.VIEW" />
      <category android:name="android.intent.category.DEFAULT" />
      <category android:name="android.intent.category.BROWSABLE" />
      <data android:scheme="myapp" />
    </intent-filter>

  </activity>
</application>
```

### Full Samples

> **Note**: 

**Note for iOS Apps**

In order for Amplify to listen for data from Cognito when linking back to your app, you will need to setup the `Linking` module in `AppDelegate.m` (see [React Native docs](https://reactnative.dev/docs/linking#enabling-deep-links) for more information):

```objectivec
#import 

- (BOOL)application:(UIApplication *)application
   openURL:(NSURL *)url
   options:(NSDictionary *)options

```

**In-App Browser Setup (optional, but recommended)**

By default, Amplify will open the Cognito Hosted UI in Safari/Chrome, but you can override that behavior by providing a custom `urlOpener`. The sample below uses [react-native-inappbrowser-reborn](https://github.com/proyecto26/react-native-inappbrowser), but you can use any other in-app browser available.

**Sample**

```ts

async function urlOpener(url: string, redirectUrl: string): Promise<void> );

  if (authSessionResult.type === 'success') 
}

Amplify.configure(,
});

function App()  }) => 
    });

    getUser()
  }, []);

  const getUser = async (): Promise<void> =>  catch(error) 
  };

  return (
    
      User: </Text>
       />
      ) : (
        <>
          
           Auth.federatedSignIn()} />

           Auth.federatedSignIn()} />
           Auth.federatedSignIn()}  />
           Auth.federatedSignIn()} />
        </>
      )}
    </View>
  );
}

```js

async function urlOpener(url, redirectUrl)  = await InAppBrowser.openAuth(url, redirectUrl, );

  if (type === 'success') 
}

Amplify.configure(,
});

function App()  }) => 
    });

    getUser().then(userData => setUser(userData));
  }, []);

  function getUser() 

  return (
    
      User: </Text>
       />
      ) : (
        <>
          
           Auth.federatedSignIn()} />

           Auth.federatedSignIn()} />
           Auth.federatedSignIn()}  />
           Auth.federatedSignIn()} />
        </>
      )}
    </View>
  );
}

</Block>

**In-App Browser Setup (optional, but recommended)**

By default, Amplify will open the Cognito Hosted UI in Safari/Chrome, but you can override that behavior by providing a custom `urlOpener`. The sample below uses Expo's [WebBrowser.openAuthSessionAsync](https://docs.expo.io/versions/v37.0.0/sdk/webbrowser/).

**Sample**

```ts

const isLocalHost = Boolean(__DEV__);

const [localRedirectSignIn, productionRedirectSignIn] =
  amplifyconfig.oauth.redirectSignIn.split(",");

const [localRedirectSignOut, productionRedirectSignOut] =
  amplifyconfig.oauth.redirectSignOut.split(",");

async function urlOpener(url: string, redirectUrl: string): Promise<void> 
}

const updatedConfig = ,
};
Amplify.configure(updatedConfig);

  useEffect(() => }) => 
    });

    getUser();

    return unsubscribe;
  }, []);

  const getUser = async (): Promise<void> =>  catch(error) 
  };

  return (
    
       Auth.federatedSignIn()} />
      
          Auth.federatedSignIn()
        }
      />
      
          Auth.federatedSignIn()
        }
      />
      
          Auth.federatedSignIn()
        }
      />
      
          Auth.federatedSignIn()
        }
      />
       Auth.signOut()} />
      </Text>
      
    </View>
  );
}

const styles = StyleSheet.create(,
});
```
</Block>

```js

const isLocalHost = Boolean(__DEV__);

const [localRedirectSignIn, productionRedirectSignIn] =
  amplifyconfig.oauth.redirectSignIn.split(",");

const [localRedirectSignOut, productionRedirectSignOut] =
  amplifyconfig.oauth.redirectSignOut.split(",");

async function urlOpener(url, redirectUrl)  = await WebBrowser.openAuthSessionAsync(
    url,
    redirectUrl
  );

  if (type === "success" && Platform.OS === "ios") 
}

const updatedConfig = ,
};
Amplify.configure(updatedConfig);

  useEffect(() =>  }) => 
    });

    Auth.currentAuthenticatedUser()
      .then((currentUser) => setUser(currentUser))
      .catch(() => console.log("Not signed in"));

    return unsubscribe;
  }, []);

  return (
    
       Auth.federatedSignIn()} />
      
          Auth.federatedSignIn()
        }
      />
      
          Auth.federatedSignIn()
        }
      />
      
          Auth.federatedSignIn()
        }
      />
      
          Auth.federatedSignIn()
        }
      />
       Auth.signOut()} />
      </Text>
      
    </View>
  );
}

const styles = StyleSheet.create(,
});

```
</Block>
</BlockSwitcher>

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib/auth/js/react-native-social.mdx`