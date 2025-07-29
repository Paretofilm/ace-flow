---
title: Listing conversations
source: pages/ai/conversation/history/index.mdx
---

# Listing conversations

The Amplify AI kit automatically and securely stores conversation history per user so you can easily resume past conversations. 

> **Note**: 

If you are looking for a quick way to get stared with conversation history, [this example project](https://github.com/aws-samples/amplify-ai-examples/tree/main/claude-ai) has a similar interface to ChatGPT or Claude where users see past conversations in a sidebar they can manage. 

When you define a conversation route in your Amplify data schema, the Amplify AI kit turns that into 2 data models: `Conversation` and `Message`. The `Conversation` model functions mostly the same way as other data models defined in your schema. You can list and filter them (because they use owner-based authorization users will only see their conversations) and you can get a specific conversation by ID. Then once you have a conversation instance you can load the messages in it if there are any, send messages to it, and subscribe to the stream events being sent back. 

## Listing conversations

To list all the conversations a user has you can use the `.list()` method. It works the same way as any other Amplify data model would. You can optionally pass a `limit` or `nextToken`.

```ts
const  = await client.conversations.chat.list()
```

The `updatedAt` field gets updated when new messages are sent, so you can use that to see which conversation had the most recent message. Conversations retrieved via `.list()` are sorted in descending order by `updatedAt`.

### Pagination
The result of `.list()` contains a `nextToken` property. This can be used to retrieve subsequent pages of conversations.

```ts
const  = await client.conversations.chat.list();

// retrieve next page
if (nextToken)  = await client.conversations.chat.list();
}
```

Conversations also have `name` and `metadata` fields you can use to more easily find and resume past conversations. `name` is a string and `metadata` is a JSON object so you can store any extra information you need. 

## Resuming conversations

You can resume a conversation by calling the `.get()` method with a conversation ID. Both `.create()` and `.get()` return the a conversation instance. 

```ts
// list all conversations a user has
// make sure the user has been authenticated with Amplify Auth
const conversationList = await client.conversations.conversation.list();

// Retrieve a specific conversation
const  = await client.conversations.chat.get();

// list the existing messages in the conversation
const  = await conversation.listMessages();

// You can now send a message to the conversation
conversation.sendMessage(
  ]
})
```

</InlineFilter>

```tsx

</InlineFilter>
