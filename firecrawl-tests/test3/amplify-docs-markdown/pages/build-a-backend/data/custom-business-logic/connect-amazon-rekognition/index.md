---
title: Step 1 - Set up the project
source: pages/build-a-backend/data/custom-business-logic/connect-amazon-rekognition/index.mdx
---

# Step 1 - Set up the project

**Amazon Rekognition** is an advanced machine learning service provided by Amazon Web Services (AWS), allowing developers to incorporate image and video analysis into their applications. It uses state-of-the-art machine learning models to analyze images and videos, providing valuable insights such as object and scene detection, text recognition, face analysis, and more.

Key features of Amazon Rekognition include:

- **Object and Scene Detection**: Amazon Rekognition can identify thousands of objects and scenes in images and videos, providing valuable context for your media content.

- **Text Detection and Recognition**: The service can detect and recognize text within images and videos, making it an invaluable tool for applications requiring text extraction.

- **Facial Analysis**: Amazon Rekognition offers accurate facial analysis, enabling you to detect, analyze, and compare faces in images and videos.

- **Facial Recognition**: You can build applications with the capability to recognize and verify individuals using facial recognition.

- **Content Moderation**: Amazon Rekognition can analyze images and videos to identify inappropriate or objectionable content, helping you maintain safe and compliant content.

In this section, you will learn how to integrate Amazon Rekognition into your application using AWS Amplify, leveraging its powerful image analysis capabilities seamlessly.

## Step 1 - Set up the project

Set up your project by following the instructions in the [Quickstart guide](/[platform]/start/quickstart/).

## Step 2 - Install Rekognition Libraries
Create a new API endpoint that'll use the the AWS SDK to call the Amazon Rekognition service. To install the Amazon Rekognition SDK, run the following command in your project's root folder:

```bash title="Terminal" showLineNumbers=
npm add @aws-sdk/client-rekognition
```

## Step 3 - Setup Storage

Create a file named `amplify/storage/resource.ts` and add the following content to configure a storage resource:

```ts title="amplify/storage/resource.ts"

```

## Step 4 - Add your Amazon Rekognition as Datasource

To use the Amazon Rekognition service, you need to add Amazon Rekognition as an HTTP Data Source and configure the proper IAM policy for Lambda to effectively utilize the desired feature and grant permission to access the storage. In this case, you can add the `rekognition:DetectText` and `rekognition:DetectLabels` actions to the policy. Update the `amplify/backend.ts` file as shown below.

 ```ts title= "amplify/backend.ts"

const backend = defineBackend();

// Set environment variables for the S3 Bucket name
backend.data.resources.cfnResources.cfnGraphqlApi.environmentVariables = ;

const rekognitionDataSource = backend.data.addHttpDataSource(
  "RekognitionDataSource",
  `https://rekognition.$.amazonaws.com`,
  ,
  }
);

rekognitionDataSource.grantPrincipal.addToPrincipalPolicy(
  new PolicyStatement()
);

backend.storage.resources.bucket.grantReadWrite(
  rekognitionDataSource.grantPrincipal
);

```
## Step 5 - Configure the function handler

Define the function handler by creating a new file, `amplify/data/identifyText.js`. This function analyzes the image and extracts text using the Amazon Rekognition DetectText service.

```ts title="amplify/data/identifyText.js"

```

## Step 6 - Define the custom query

After adding Amazon Rekognition as a data source, you can reference it in custom query using the `a.handler.custom()` modifier, which takes the name of the data source and an entry point for your resolvers. In your `amplify/data/resource.ts` file, specify `RekognitionDataSource` as the data source and `identifyText.js` as the entry point, as shown below.

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .returns(a.string())
    .authorization((allow) => [allow.publicApiKey()])
    .handler(
      a.handler.custom()
    ),
});

## Step 7 - Update Storage permissions

Customize your storage settings to manage access to various paths within your storage bucket. Modify the file `amplify/storage/resource.ts` as shown below.

```ts title="amplify/storage/resource.ts"

## Step 8 - Configure the frontend

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point.

``` ts title="main.tsx"

Amplify.configure(outputs);

```
### Invoke the Text Recognition API

This code sets up a React app to upload an image to an S3 bucket and then use Amazon Rekognition to recognize the text in the uploaded image.

```ts title="App.tsx"
import "./App.css";

// Generating the client
const client = generateClient();

type IdentifyTextReturnType = Schema["identifyText"]["returnType"];

function App() );

        setPath(s3Path);
      } catch (error) 
    }
  };

  // Function to recognize text from the uploaded image
  const recognizeText = async () =>  = await client.queries.identifyText();
    setTextData(data);
  };

  return (
    <div>
      <h1>Amazon Rekognition Text Recognition</h1>
      <div>
        <input type="file" onChange= />
        <button onClick=>Recognize Text</button>
        <div>
          <h3>Recognized Text:</h3>
          
        </div>
      </div>
    </div>
  );
}

// Generating the client
const client = generateClient();

type IdentifyTextReturnType = Schema['identifyText']['returnType'];

@Component(}
        </div>
      </div>
    </div>
  `,
})

  // Function to handle file upload to S3 bucket
  async handleTranslate(event: Event) );

        this.path = s3Path;
      } catch (error) 
    }
  }

  // Function to recognize text from the uploaded image
  async recognizeText()  = await client.queries.identifyText();
    this.textData = data;
  }
}
```
</InlineFilter>
