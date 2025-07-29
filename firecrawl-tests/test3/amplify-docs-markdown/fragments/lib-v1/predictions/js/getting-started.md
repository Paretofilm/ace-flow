---
title: Create new backend
source: fragments/lib-v1/predictions/js/getting-started.mdx
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

A configuration file called `aws-exports.js` will be copied to your configured source directory, for example `./src`.

## Configure the frontend

```javascript
import  from '@aws-amplify/predictions';

Amplify.configure(awsconfig);
Predictions.addPluggable(new AmazonAIPredictionsProvider());
```

## Import existing backend

The manual setup enables you to use your existing Amazon AI and ML resources in your app.

```javascript

Amplify.configure(,
  predictions: 
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
