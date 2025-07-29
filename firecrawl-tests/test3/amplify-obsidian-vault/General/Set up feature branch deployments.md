---
title: Set up feature branch deployments
topics: ['General']
primary_topic: General
source: pages/deploy-and-host/fullstack-branching/branch-deployments/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Set up feature branch deployments

}

Amplify code-first DX (Gen 2) offers fullstack branch deployments that allow you to automatically deploy infrastructure and application code changes from feature branches. This enables testing changes in an isolated environment before merging to the main branch.

## Set up feature branch deployments

After you've deployed your [first branch](/[platform]/start/quickstart/), you can manually connect more, but the recommended workflow is to use the **branch auto-detection** feature.

1. Log in to the [Amplify console](https://console.aws.amazon.com/amplify/home) and choose your app.

2. Navigate to **App settings > Branch settings**, select **Edit** and enable **Branch auto-detection** and **Branch auto-disconnection**. The following video uses the default settings, which will connect any branch in your repo automatically. Branch auto-disconnection will ensure that if you delete a branch from your repository, the branch will also be deleted.

> **Note**: 
You can also define a pattern to connect only certain branches. For example, setting `dev`, `staging`, and `feature/*` will automatically connect all three branch types. Your `dev` and `staging` branches, as well as any branch that begins with `feature/`, will be connected.

3. Push a commit to your `feature/A` and `staging` branches that match the pattern. You should start seeing deployments on the console page. You will now have three fullstack branches deployed.

![Production, feature/A, and staging branches listed on app overview page in Amplify console.](/images/gen2/fullstack-branching/branches.png)

## Promote changes to production

In Gen 2, promoting changes to production follows the normal Git-based workflow.

![Workflow for merging changes from feature/A branch to main, or production, branch.](/images/gen2/fullstack-branching/gitflow.png)

1. Make a change in your `feature/A` branch.

```bash title="Terminal" showLineNumbers=
git checkout -b feature/A

## make some edits to your code

git commit --am "New data model to track comments for todos added"

git push origin feature/A
```

2. Submit a pull request to your `main` branch. Once your team has validated the changes, merge the pull request to `main`. This will initiate a build on your `main` branch and update any frontend or backend resources that you changed.

### Generate client config

You can generate the config for a branch environment by running:

For Web and React Native, generating the config with the default format and output directory.

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <your-amplify-app-id> --branch <your-git-branch-name> --out-dir <path/to/config>
```
</InlineFilter>

> **Note**: 
  Be sure to add a "raw" folder under app/src/main/res directory if it doesn't
  exist.

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <your-amplify-app-id> --branch <your-git-branch-name> --out-dir app/src/main/res/raw
```
</InlineFilter>

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <your-amplify-app-id> --branch <your-git-branch-name> --format dart --out-dir lib
```
</InlineFilter>

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <your-amplify-app-id> --branch <your-git-branch-name>
```

Once the sandbox environment is running, you would also generate the configuration file for your application. However, Xcode won't recognize the file by default. To recognize the files, you need to drag and drop the generated configuration file to your project.

</InlineFilter>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/deploy-and-host/fullstack-branching/branch-deployments/index.mdx`