---
title: Initialize a new backend
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/start/getting-started/vanillajs/setup.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Initialize a new backend

Create a new ‘plain’ JavaScript [ES2015](https://babeljs.io/docs/en/learn/) app with webpack. With the following commands, create the directory (`amplify-js-app`) and files for the app.

```bash
mkdir -p amplify-js-app/src && cd amplify-js-app
touch index.html src/app.js webpack.config.js
```

Initialize npm and install dependencies and dev dependencies.

```bash
npm init
npm install aws-amplify
npm install webpack webpack-cli webpack-dev-server copy-webpack-plugin --save-dev
```

The app directory structure should be:

```console
amplify-js-app
├── node_modules/
├── src/
│   └── app.js
├── index.html
├── package-lock.json
├── package.json
└── webpack.config.js
```

Add the following scripts to the `package.json` file:

```json
"scripts": 
```

Add the following to the `index.html` file:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Amplify</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
      html,
      body 
      a 
      h1 
      hr 
      .app 
      .app-header 
      .app-body 
      .app-body button 
      .app-body button:hover 
    </style>
  </head>

  <body>
    <div class="app">
      <div class="app-header">
        <h1>Welcome to Amplify</h1>
      </div>
      <div class="app-body">
        <h1>Mutation Results</h1>
        <button id="MutationEventButton">Add data</button>
        <div id="MutationResult"></div>
        <hr />

        <h1>Query Results</h1>
        <div id="QueryResult"></div>
        <hr />

        <h1>Subscription Results</h1>
        <div id="SubscriptionResult"></div>
      </div>
    </div>
    <script src="main.bundle.js"></script>
  </body>
</html>
```

Add the following to the `webpack.config.js` file:

```js
const CopyWebpackPlugin = require('copy-webpack-plugin');
const webpack = require('webpack');
const path = require('path');

module.exports = ,
  module: 
    ]
  },
  devServer: ,
    hot: true,
    watchFiles: ['src/*', 'index.html']
  },
  plugins: [
    new CopyWebpackPlugin(),
    new webpack.HotModuleReplacementPlugin()
  ]
};
```

Run the app:

```bash
npm start
```

Open a browser and navigate to \http://localhost:8080>.

_(The `Add data` button does not work yet. You'll work on that next!)_

## Initialize a new backend

Now that you have a running app, it's time to set up Amplify so that you can create the necessary backend services needed to support the app.

Open a new terminal. From the root of the project, run:

```bash
amplify init
```

When you initialize Amplify you'll be prompted for some information about the app:

```console
? Enter a name for the project: amplifyjsapp
The following configuration will be applied:

Project information
| Name: amplifyjsapp
| Environment: dev
| Default editor: Visual Studio Code
| App type: javascript
| Javascript framework: none
| Source Directory Path: src
| Distribution Directory Path: dist
| Build Command: npm run-script build
| Start Command: npm run-script start

? Initialize the project with the above configuration? Yes
Using default provider  awscloudformation
? Select the authentication method you want to use: AWS profile

For more information on AWS Profiles, see:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

? Please choose the profile you want to use: default
```

When you initialize a new Amplify project, a few things happen:

- It creates a top level directory called `amplify` that stores your backend definition. During the tutorial you'll add cloud capabilities, such as GraphQL API and web hosting. As you add these features, the `amplify` folder will grow with infrastructure-as-code templates that define your backend stack. Infrastructure-as-code is a best practice way to create a replicable backend stack.
- It creates a file called `aws-exports.js` in the `src` directory that holds all the configuration for the services you create with Amplify. This is how the Amplify JavaScript client library is able to get the necessary information to connect to your backend services.
- It modifies the `.gitignore` file, adding some generated files to the ignore list
- An Amplify project is created for you that can be accessed within the AWS Console by running `amplify console`. The AWS Amplify console provides a list of backend environments, deep links to provisioned resources per Amplify category, deployment statuses, and instructions on how to promote, clone, pull, and delete backend resources.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/start/getting-started/vanillajs/setup.mdx`