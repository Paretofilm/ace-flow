---
title: Key Components
topics: ['AI & Machine Learning']
primary_topic: AI & Machine Learning
source: pages/ai/conversation/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, ai-&-machine-learning]
---


## 🧭 Navigation
**Topics**: [[AI & Machine Learning/]]
**Primary**: [[AI & Machine Learning/]]

---


# Key Components

The conversation route simplifies the creation of AI-powered conversation interfaces in your application. It automatically sets up the necessary AppSync API components and Lambda functions to handle streaming multi-turn interactions with Amazon Bedrock foundation models.

> **Note**: 
See [Supported Providers and Models](/[platform]/ai/concepts/models/#supported-providers-and-models) for a list of supported AI models.

## Key Components

1. **AppSync API**: Gateway to the conversation route.
    - Create new conversation route instance.
    - Send messages to conversation route instance.
    - Subscribe to real-time updates for assistant responses.

2. **Lambda Function**: Bridge between AppSync and Amazon Bedrock.
    - Retrieve conversation instance history.
    - Invokes Bedrock's /converse endpoint.
    - Handles tool use responses by invoking AppSync queries.

3. **DynamoDB**: Stores conversation and message data
    - Conversations are scoped to a specific application user.

## Authentication Flow

1. The user's OIDC access token is passed from the client to AppSync
2. AppSync forwards this token to the Lambda function
3. The Lambda function uses the token to authenticate requests back to AppSync

## Usage Scenarios

Each of the following scenarios have safeguards in place to mitigate risks associated with invoking tools on behalf of the user, including:

- Amazon CloudWatch log group redacting OIDC access tokens for logs from the Lambda function.
- IAM policies that limit the Lambda function's ability to access other resources.

## Data Flow

1. User sends a message via the AppSync mutation
2. AppSync triggers the Lambda function (default or custom)
3. Lambda processes the message and invokes Bedrock's /converse endpoint
  a. If response is a tool use, Lambda function invokes applicable AppSync query.
4. Lambda sends assistant response back to AppSync
5. AppSync sends the response to subscribed clients

This design allows for real-time, scalable conversations while ensuring that the Lambda function's data access matches that of the application user.

## Next Steps


---

## 📚 Related Topics
- [[AI & Machine Learning/]]

## 📖 Source
Original: `pages/ai/conversation/index.mdx`