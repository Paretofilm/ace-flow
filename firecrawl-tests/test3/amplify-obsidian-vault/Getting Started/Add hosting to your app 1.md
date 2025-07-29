---
title: Add hosting to your app
topics: ['Getting Started', 'Hosting & Deployment']
primary_topic: Getting Started
source: fragments/start/getting-started/angular/hosting.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started, hosting-&-deployment]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]] • [[Hosting & Deployment/]]
**Primary**: [[Getting Started/]]

---


# Add hosting to your app

You've successfully built your first app with Amplify! Now that you've built something, it's time to deploy it to the web with Amplify Hosting!

## Add hosting to your app
You can manually deploy your web app or setup automatic continuous deployment. In this guide we'll cover how to manually deploy and host your static web app to quickly share with others. If you want to learn about continuous deployment instead, please follow [this guide](https://docs.aws.amazon.com/amplify/latest/userguide/multi-environments.html#standard).

From the root of your project, run the following command and select the **bolded options**. 
```bash
amplify add hosting
```

```console
? Select the plugin module to execute: # Hosting with Amplify Console (Managed hosting with custom domains, Continuous deployment)
? Choose a type: # Manual Deployment
```

## Publish your app

Run the following command to publish your app.

```bash
amplify publish
```

> **Note**: 
  If you get "Error: bundle initial exceeded maximum budget" error based on bundle size, you need to bump the maximum bundle size budget for your Angular application. Find the `budgets` keyword in `angular.json`, and bump `maximumError`:

```json
,
    // ...
  ]
}
```

Congratulations, your app is online!

![image](/images/browser-published-updated.png)

After publishing, your terminal will display your app URL hosted on a `amplifyapp.com` domain. Whenever you have additional changes to publish, just re-run the `amplify publish` command.

> You may get an "AccessDenied" error if your app's distribution directory is not set properly. To fix this, change the distribution directory via `amplify configure project` and then re-run `amplify publish`. Distribution directory should match `dist/amplify-app`.

To view your app and hosting configuration in the Amplify Console, run the `amplify console` command.

Note: To delete all the environments of the project from the cloud and wipe out all the local files created by Amplify CLI, run `amplify delete` command.


---

## 📚 Related Topics
- [[Getting Started/]]
- [[Hosting & Deployment/]]

## 📖 Source
Original: `fragments/start/getting-started/angular/hosting.mdx`