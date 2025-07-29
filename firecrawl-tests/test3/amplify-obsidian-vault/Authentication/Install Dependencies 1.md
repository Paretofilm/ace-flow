---
title: Install Dependencies
topics: ['Authentication', 'Getting Started']
primary_topic: Authentication
source: fragments/sdk/auth/android/getting-started.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, getting-started]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[Getting Started/]]
**Primary**: [[Authentication/]]

---


# Install Dependencies

## Install Dependencies

After initialization in your project directory with `amplify init`, update your **App** `build.gradle` with the below:

```groovy
//For AWSMobileClient only:
implementation 'com.amazonaws:aws-android-sdk-mobile-client:ANDROID_SDK_VERSION'

//For the drop-in UI also:
implementation 'com.amazonaws:aws-android-sdk-auth-userpools:ANDROID_SDK_VERSION'
implementation 'com.amazonaws:aws-android-sdk-auth-ui:ANDROID_SDK_VERSION'

//For hosted UI also:
implementation 'com.amazonaws:aws-android-sdk-cognitoauth:ANDROID_SDK_VERSION'
```

For the `AWSMobileClient` alone you can have a minimum SDK version of **15**, but for the drop-in UI you will need a minimum of **23** set in your `build.gradle`:

```
minSdkVersion 15
```

Add the following permissions to the `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

Build your Android Studio project.

## Automated Setup

Run the following command in your project's root folder:

```bash
amplify add auth
```

If you have previously enabled an Amplify category that uses Auth behind the scenes, e.g. API category, you may already have an Auth configuration. In such a case, run `amplify auth update` command to edit your configuration.

The CLI prompts will help you to customize your auth flow for your app. With the provided options, you can:

- Customize sign-in/registration flow
- Customize email and SMS messages for Multi-Factor Authentication
- Customize attributes for your users, e.g. name, email
- Enable 3rd party authentication providers, e.g. Facebook, Twitter, Google and Amazon

After configuring your Authentication options, update your backend:

```bash
amplify push
```

A configuration file called `awsconfiguration.json` will be copied to your project `./app/src/main/res/raw` directory. The `AWSMobileClient` will leverage this for communicating with backend services.

### Lambda Triggers

The CLI allows you to configure [Lambda Triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html) for your Amazon Cognito User Pool. These enable you to add custom functionality to your registration and authentication flows.

## Manual Setup

For manual configuration without the CLI, you must have an `awsconfiguration.json` file with the following:

- Cognito User Pools: `CognitoUserPool : `
- Cognito Identity Pools: `IdentityManager` and `CredentialsProvider: `

```xml
    
        },
        "CredentialsProvider": 
            }
        },
        "CognitoUserPool": 
        }
    }
```

If you are using both Cognito User Pools and Identity Pools, such as in Federated scenarios, you will need all of the keys mentioned above.

### Initialization

Go to your MainActivity and inside the `onCreate()` run the `initialize()` routine:

```java
AWSMobileClient.getInstance().initialize(getApplicationContext(), new Callback() 

        @Override
        public void onError(Exception e) 
    }
);
```

Build and run your program to see the initialized client in LOGCAT messages. Since you haven't logged in yet it will print a state of `SIGNED_OUT`. The `getUserState()` function returns an ENUM which you can perform different actions in your workflow. For example:

```java
AWSMobileClient.getInstance().initialize(getApplicationContext(), new Callback() 
                });
                break;
            case SIGNED_OUT:
                runOnUiThread(new Runnable() 
                });
                break;
            default:
                AWSMobileClient.getInstance().signOut();
                break;
        }
    }

    @Override
    public void onError(Exception e) 
});
```

You might leverage the above workflow to perform other actions in the `SIGNED_IN` case, such as calling [GraphQL or REST APIs with AWS AppSync or Amazon API Gateway](/gen1/[platform]/sdk/api/graphql/) or uploading content with [Amazon S3](/gen1/[platform]/sdk/storage/getting-started/).


---

## 📚 Related Topics
- [[Authentication/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/sdk/auth/android/getting-started.mdx`