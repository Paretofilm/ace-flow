---
title: Step 1 - Setup the project
source: pages/build-a-backend/data/custom-business-logic/connect-amazon-polly/index.mdx
---

# Step 1 - Setup the project

Amazon Polly is a text-to-speech (TTS) service offered by Amazon Web Services (AWS). It uses advanced deep learning technologies to convert written text into lifelike speech, enabling you to create applications with speech capabilities in various languages and voices.

With Amazon Polly, you can easily add voice interactions and accessibility features to your applications. The service supports a wide range of use cases, such as providing audio content for the visually impaired, enhancing e-learning experiences, creating interactive voice response (IVR) systems, and more.

Key features of Amazon Polly include:

- **Multiple Voices and Languages**: Amazon Polly supports dozens of voices across various languages and dialects, giving you the flexibility to choose the most appropriate voice for your use case.

- **High-Quality Speech**: Amazon Polly's neural and standard voices offer natural and realistic speech quality.

- **Speech Marks and Speech Synthesis Markup Language**: Customize your speech output with Speech Synthesis Markup Language tags and obtain speech timing information with speech marks.

- **Scalable and Cost-Effective**: Amazon Polly's pay-as-you-go pricing model makes it a cost-effective solution for adding speech capabilities to your applications.

In this section, you'll learn how to integrate Amazon Polly into your application using AWS Amplify, enabling you to leverage its powerful text-to-speech capabilities seamlessly.

## Step 1 - Setup the project

Set up your project by following the instructions in the [Quickstart guide](/[platform]/start/quickstart/).

## Step 2 - Install Polly Libraries
We'll create a new API endpoint that'll use the the AWS SDK to call the Amazon Polly service. To install the Amazon Polly SDK, run the following command in your project's root folder:

```bash title="Terminal" showLineNumbers=
npm add @aws-sdk/client-polly
```

## Step 3 - Setup Storage

Create a file named `amplify/storage/resource.ts` and add the following content to configure a storage resource:

```ts title="amplify/storage/resource.ts"

```

## Step 4 - Configure IAM Roles

 To access Amazon Polly service, you need to configure the proper IAM policy for Lambda to utilize the desired feature effectively. Update the `amplify/backend.ts` file with the following code to add the necessary permissions to a lambda's Role policy.

 ```ts title= "amplify/backend.ts"

const backend = defineBackend();

backend.convertTextToSpeech.resources.lambda.addToRolePolicy(
  new PolicyStatement()
);
```
## Step 5 - Configure the function handler

Define the function handler by creating a new file, `amplify/data/convertTextToSpeech.ts`. This function converts text into speech using Amazon Polly and stores the synthesized speech as an MP3 file in an S3 bucket.

```ts title="amplify/data/convertTextToSpeech.ts"
import  from "@aws-sdk/client-polly";

  return (
    result.SynthesisTask?.OutputUri?.replace(
      "https://s3.us-east-1.amazonaws.com/" +
        env.PREDICTIONS_GEN_2_BUCKET_NAME +
        "/public/",
      ""
    ) ?? ""
  );
};
```

## Step 6 - Define the custom mutation and function

In your `amplify/data/resource.ts` file, define the function using defineFunction and then reference the function with your mutation using a.handler.function() as a handler.

```ts title="amplify/data/resource.ts"
import  from "@aws-amplify/backend";

const schema = a.schema()
    .authorization(allow => [allow.publicApiKey()]),
  convertTextToSpeech: a
    .mutation()
    .arguments()
    .returns(a.string().required())
    .authorization(allow => [allow.publicApiKey()])
    .handler(a.handler.function(convertTextToSpeech)),
});

> **Note**: 
**NOTE:** At least one query is required for a schema to be valid. Otherwise, deployments will fail a schema error. The Amplify Data schema is auto-generated with a `Todo` model and corresponding queries under the hood. You can leave the `Todo` model in the schema until you add the first custom query to the schema in the next steps.

## Step 7 - Update Storage permissions

Customize your storage settings to manage access to various paths within your storage bucket. It's necessary to update the Storage resource to provide access to the `convertTextToSpeech` resource. Modify the file `amplify/storage/resource.ts` as shown below.

```ts title="amplify/storage/resource.ts"

## Step 8 - Configure the frontend

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point.
``` ts title="main.tsx"

Amplify.configure(outputs);
```
### Invoke the API

Example frontend code to create an audio buffer for playback using a text input.

```ts title="App.tsx"
import "./App.css";

const client = generateClient();

type PollyReturnType = Schema["convertTextToSpeech"]["returnType"];

function App()  = await client.mutations.convertTextToSpeech();

          if (!errors && data)  else 
        }}
      >
        Synth
      </button>
      <button
        onClick=);

          setSrc(res.url.toString());
        }}
      >
        Fetch audio
      </button>
      <a href=>Get audio file</a>
    </div>
  );
}

```ts title="app.component.ts"

const client = generateClient();

type PollyReturnType = Schema['convertTextToSpeech']['returnType'];

@Component()

  async synthesize()  = await client.mutations.convertTextToSpeech();

    if (!errors && data)  else 
  }

  async fetchAudio() );

    this.src = res.url.toString();
  }
}
```
</InlineFilter>
