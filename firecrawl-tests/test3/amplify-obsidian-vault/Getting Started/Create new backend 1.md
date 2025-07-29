---
title: Create new backend
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/predictions/js/getting-started.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Create new backend

> Prerequisite: [Install and configure the Amplify CLI](/gen1/[platform]/tools/cli/start/set-up-cli/)

## Create new backend

Run the following command in your project's root folder:

```bash
amplify add predictions
```

The CLI will prompt configuration options for the Predictions category such as what type of use case you have (identifying objects from an image, translating text, etc) and default or advanced settings.

The Predictions category utilizes the Auth category behind the scenes to authorize your app to perform AI/ML actions.

The `add` command automatically creates the backend configuration. Once all your configuration is complete run the following:

```bash
amplify push
```

A configuration file called `amplifyconfiguration.json` will be copied to your configured source directory, for example `./src`.

**NOTE:** if using Identify Labels or Identify Text, you will need to manually add configuration items to your amplify backend folder due to [this known issue in identifyText](https://github.com/aws-amplify/amplify-cli/issues/12159) and [this known issue in identifyLabels](https://github.com/aws-amplify/amplify-cli/issues/12208).

#### Identify Text

**amplify/backend/identify-text-resource/parameters.json**

```json
"identifyDoc": true,
"access": "auth | authAndGuest",
"format": "PLAIN | FORM | TABLE | ALL"
```

#### Identify Labels

**amplify/backend/identify-labels-resource/parameters.json**

```json
"access": "auth | authAndGuest",
"type": "LABELS | UNSAFE | ALL"
```

## Install Amplify Libraries

To install the Amplify library to use predictions features, run the following commands in your project’s root folder:

```bash
npm install aws-amplify @aws-amplify/predictions
```

> **Note**: 

Make sure that the `@aws-amplify/predictions` package has the same version number as the `aws-amplify` package in your `package.json` file.

## Configure the frontend

```javascript

Amplify.configure(amplifyconfig);
```

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/gen1/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

## Import existing backend

The manual setup enables you to use your existing Amazon AI and ML resources in your app.

```javascript

Amplify.configure(,
  Predictions: 
      },
      speechGenerator: 
      },
      transcription: 
      }
    },
    identify: 
      },
      identifyEntities: 
      },
      identifyLabels: 
      }
    },
    interpret: 
      }
    }
  }
});
```

### IAM Policy

The Amplify CLI will set appropriate IAM policy for Roles in your Cognito Identity Pool in order to use an appropriate feature. If you are using the library manually you will need to configure this yourself. The below policy demonstrates setting policy for all services in the Predictions category:

```json

  ]
}
```

For `rekognition:SearchFacesByImage` you can scope the Resource down to an individual collection such as `arn:aws:rekognition:::collection/`. Amplify CLI automatically does this.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/predictions/js/getting-started.mdx`