---
title: Install Dependencies
topics: ['Authentication', 'Getting Started']
primary_topic: Authentication
source: fragments/sdk/auth/ios/getting-started.mdx
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

After initialization in your project directory with `amplify init`, edit your `Podfile` with the following:

```ruby
target 'MyApp' do            ##Replace MyApp with your application name
  use_frameworks!
  pod 'AWSMobileClient'      # Required dependency
  pod 'AWSAuthUI'            # Optional dependency required to use drop-in UI
  pod 'AWSUserPoolsSignIn'   # Optional dependency required to use drop-in UI
end
```

Next run the following command:

```bash
pod install --repo-update
```

Open the **.xcworkspace** file for your project (close the **.xcodeproj** file if you already have it open). The CLI will create the `awsconfiguration.json` file in your project directory. In the Finder, drag `awsconfiguration.json` into Xcode under the top Project Navigator folder (the folder name should match your Xcode project name). When the `Options` dialog box appears, do the following:

- Clear the `Copy items if needed` check box.
- Choose `Create groups`, and then choose `Finish`.

Build your project once to ensure all frameworks are pulled in and compile.

## Automated Setup

Run the following command in your project's root folder:

```bash
amplify add auth
```

> If you have previously enabled an Amplify category that uses Auth behind the scenes, e.g. Storage category, you may already have an Auth configuration. In such a case, run `amplify auth update` command to edit your configuration.

The Amplify CLI prompts will help you to customize your auth configuration:

- Customize sign-in/registration flow
- Customize email and SMS messages for Multi-Factor Authentication
- Customize attributes for your users, e.g. name, email
- Enable 3rd party authentication providers like Facebook, Twitter, Google and Amazon

After configuring your Authentication options, update your backend:

```bash
amplify push
```

### Lambda Triggers

The CLI allows you to configure [Lambda Triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html) for your Amazon Cognito User Pool. These enable you to add custom functionality to your registration and authentication flows.

## Manual Setup

For manual configuration without the CLI, you must have an `awsconfiguration.json` file with the following:

```json

  },
  "CredentialsProvider": 
    }
  },
  "CognitoUserPool": 
  }
}
```

If you are using both Cognito User and Identity Pools you will need all of the keys mentioned above.

### Initialization

Open the `AppDelegate.swift` file in your Xcode project, import `AWSMobileClient` and add to the `application` function:

```swift
import AWSMobileClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  else if let error = error 
            }

        return true
    }
    ...
}
```

Build and run your program to see the initialized client in Xcode messages. Since you haven't logged in yet it will print a state of `signedOut`. The `userState` returns an ENUM which you can perform different actions in your workflow. For example, now add to the `viewDidLoad()` function of your `ViewController.swift`:

```swift
import AWSMobileClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate 
            case .signedOut:
                DispatchQueue.main.async 
            default:
                AWSMobileClient.default().signOut()
            }
    }
}
```

You might leverage the above workflow to perform other actions in the `signedIn` case, such as calling [GraphQL APIs with AWS AppSync](/gen1/[platform]/sdk/api/graphql/) or uploading content with [Amazon S3](/gen1/[platform]/sdk/storage/getting-started/).


---

## 📚 Related Topics
- [[Authentication/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/sdk/auth/ios/getting-started.mdx`