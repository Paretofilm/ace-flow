---
title: Conversation and Message types
topics: ['AI & Machine Learning']
primary_topic: AI & Machine Learning
source: pages/ai/conversation/connect-your-frontend/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, ai-&-machine-learning]
---


## 🧭 Navigation
**Topics**: [[AI & Machine Learning/]]
**Primary**: [[AI & Machine Learning/]]

---


# Conversation and Message types

In this guide, you will learn how to create, update, and delete conversations, as well as send messages and subscribe to assistant responses.

Conversations and their associated messages are persisted in Amazon DynamoDB. This means the previous messages for a conversation are automatically included in the history sent to the LLM. Access to conversations and messages are scoped to individual users through the [owner based authorization strategy](/react/build-a-backend/data/customize-authz/per-user-per-owner-data-access/).

## Conversation and Message types

### Conversation

There are two main types within the conversation flow, `Conversation` and `Message`.

A `Conversation` is an instance of a chat session between an application user and an LLM. It contains data and methods for interacting with the conversation. A conversation has a one-to-many relationship with its messages.

The `Conversation` type is accessible via `Schema['myChat']['type']` type definition, where `'myChat'` is the name of the conversation route in your data schema.

| Property/Method  | Type   | Description  |
|------------------|:-------|:-------------|
| `id`             | `string` | The unique identifier for the conversation |
| `name`           | `string \| undefined` | The name of the conversation.<br/>You can specify a name when creating or updating a conversation. |
| `metadata`       | `Record<string, string> \| undefined` | Metadata associated with the conversation.<br/>You can specify arbitrary metadata when creating or updating a conversation. |
| `createdAt`      | `string` | The date and time when the conversation was created |w
| `updatedAt`      | `string` | The date and time when the last user message was sent |
| `sendMessage()`  | `(content: MessageContent) => ` | Send a message to the AI assistant |
| `listMessages()` | `() => ` | List all messages for the conversation |
| `onStreamEvent()`| `(options: ) => void` | Subscribe to assistant responses |

### Message

A `Message` is a single chat message between an application user and an LLM. Each message has a `role` property that indicates whether the message is from the user or the assistant. User and assistant messages have a one-to-one relationship. Assistant messages contain an `associatedUserMessageId` property that points to the `id` of the user message that triggered the assistant response.

The `Message` type is accessible via `Schema['myChat']['messageType']`, where `'myChat'` is the name of the conversation route in your data schema.

| Property  | Type   | Description  |
|-----------|:-------|:-------------|
| `id` | `string` | The unique identifier for the message |
| `conversationId` | `string` | The ID of the conversation this message belongs to |
| `associatedUserMessageId` | `string \| undefined` | For assistant messages, the ID of the user message that triggered the response |
| `content` | `MessageContent[]` | The content of the message |
| `role` | `'user' \| 'assistant'` | Whether the message is from the user or assistant |
| `createdAt` | `string` | The date and time when the message was created |

## Request response flow

1. Create a new conversation with `.create()` or get an existing one with `.get()`.
2. Subscribe to assistant responses for a conversation with `.onStreamEvent()`.
3. Send messages to the conversation with `.sendMessage()`.

```ts

const client = generateClient();

// 1. Create a conversation
const  = await client.conversations.chat.create();

// 2. Subscribe to assistant responses
const subscription = chat.onStreamEvent(,
  error: (error) => ,
});

// 3. Send a message to the conversation
const  = await chat.sendMessage('Hello, world!');
```

## Managing conversations

### Create a conversation

Create a new conversation by calling the `.create()` method on your conversation route. In the examples below, we're using a conversation route named `chat`.

```ts
const  = await client.conversations.chat.create();

/**
Example conversation data

*/
```

You can optionally attach a `name` and `metadata` to a conversation by passing them as arguments to the `.create()` method. There are no uniqueness constraints on conversation `name` or `metadata` values. You can use `metadata` as a way to organize chats and group them into certain topics.

```ts
const  = await client.conversations.chat.create(,
});

/**
Example conversation data
,
  createdAt: '2024-01-01T00:00:00.000Z',
  updatedAt: '2024-01-01T00:00:00.000Z',
}
*/
```

### Get an existing conversation

You can get an existing conversation by calling the `.get()` method on your conversation route with the conversation's `id`.

```ts
const id = '123e4567-e89b-12d3-a456-426614174000';
const  = await client.conversations.chat.get();

/**
Example conversation data

*/
```

### List conversations

You can list all conversations for a user with the `.list()` method. Retrieved conversations are sorted by `updatedAt` in descending order. This means the most recently used conversations are returned first.

```ts
const  = await client.conversations.chat.list();

/**
Example conversations data
,
    ...
  ],
  nextToken: '...',
}
*/
```

Use the `nextToken` value to paginate through conversations and optionally specify a `limit` to limit the number of conversations returned.

```ts
const  = await client.conversations.chat.list();
```

### Update a conversation

You can update a conversation's `name` and `metadata` with the `.update()` method.

This is useful if you want to update the conversation name based on the messages sent or attach arbitrary metadata at a later time.

```ts
const id = '123e4567-e89b-12d3-a456-426614174000';
const  = await client.conversations.chat.update();

/**
Example conversation data

*/
```

### Delete a conversation

> **Note**: 
  Deleting a conversation makes it unusable in the future. However it does not delete its associated messages.

```ts
const id = '123e4567-e89b-12d3-a456-426614174000';
const  = await client.conversations.chat.delete();
```

## Using a conversation instance

Once you have a conversation instance, you can interact with it by calling methods on the instance. These methods are documented in the [Conversation and Message types](#conversation-and-message-types) section.

### Send a message

Once you have a conversation instance, you can send a message to the AI assistant by calling the `.sendMessage()` method. In its simplest form you just pass the message content as text.

> **Note**: 
  The message returned is the user message sent. Assistant messages are streamed back to the client and can be subscribed to with the `.onStreamEvent()` method. See [Subscribe to assistant responses](#subscribe-to-assistant-responses) for more information.

```ts
const  = await chat.sendMessage('Hello, world!');

/**
Example message data

*/
```

There are other arguments you can pass to `.sendMessage()` to customize the message according to your application's needs.

#### Customizing the message content

`sendMessage()` accepts a object type with a `content` property that provides a flexible way to send different types of content to the AI assistant.

##### Image Content
Use `image` to send an image to the AI assistant.
Supported image formats are `png`, `gif`, `jpeg`, and `webp`.

```ts
const  = await chat.sendMessage(,
      },
    },
  ],
});
```

Mixing `text` and `image` in a single message is supported.

```ts
const  = await chat.sendMessage(,
    ,
      },
    },
  ],
});
```

#### AI context

The `aiContext` argument allows you to optionally attach arbitrary data to the message. This is useful for passing additional information, like user information or current state of your application, in a user message to the AI assistant.

```ts
const  = await chat.sendMessage(],
  aiContext: 
  },
});
```

#### Tool Configuration

The `toolConfiguration` argument allows you to optionally pass a client tool configuration to the AI assistant with a user message. See the [Tools concept page](/[platform]/ai/concepts/tools) and [Tools guide](/[platform]/ai/conversation/tools/) for more information on how tools works.

> **Note**: 
  Client tools are conceptually the same as data tools and lambda executable tools. They are API definitions provided to an LLM alongside a user message. The LLM can use the provided tool configuration to decide which tool (if any) to call in order to better respond to the user. However, there's an important distinction with client tools -- you are responsible for implementing the tool execution logic and responding to the AI assistant with the tool's response.

The `json` property is simply a JSON Schema definition of the tool's input. The AI assistant will use this schema to provide the expected input to your tool.
```ts
const  = await conversation.sendMessage(,
  ],
  toolConfiguration: ,
              },
            },
          },
        },
      },
    },
  },
});
```

The response from the AI assistant will be a JSON object that matches the `inputSchema` definition. See [Subscribe to assistant responses](#subscribe-to-assistant-responses) for more information on how to handle the response.

### Subscribe to assistant responses

Assistant responses are streamed back to the client as they are generated. This allows for a more natural conversation flow where the user doesn't have to wait for a complete response from the AI assistant to see progress and begin reading the response. To subscribe to assistant responses, call the `.onStreamEvent()` method on your conversation instance.

```ts
const subscription = conversation.onStreamEvent(,
  error: (error) => ,
});

// later...
subscription.unsubscribe();
```

`onStreamEvent()` takes two callback functions as arguments: `next` and `error`. The `next` callback is invoked with each assistant response.

The `error` callback is invoked if there's an error while processing messages.

The `next` callback is invoked with a `ConversationStreamEvent` object. This type is accessible via `Schema['myChat']['streamEventType']` and is a union of the following types:

#### ConversationStreamTextEvent

As text is streamed back to the client, the `next` callback is invoked with a `ConversationStreamTextEvent` object.

| Property | Type | Description |
|----------|:-----|:------------|
| `id` | `string` | The unique identifier for the stream event |
| `conversationId` | `string` | The ID of the conversation this event belongs to |
| `associatedUserMessageId` | `string` | The ID of the user message that triggered this response |
| `contentBlockIndex` | `number` | The index of the content block being streamed |
| `contentBlockDeltaIndex` | `number` | The index of the delta within the content block |
| `text` | `string` | The text content being streamed |

#### ConversationStreamDoneAtIndexEvent

When the AI assistant completes a content block, the `next` callback is invoked with a `ConversationStreamDoneAtIndexEvent` object.

| Property | Type | Description |
|----------|:-----|:------------|
| `id` | `string` | The unique identifier for the stream event |
| `conversationId` | `string` | The ID of the conversation this event belongs to |
| `associatedUserMessageId` | `string` | The ID of the user message that triggered this response |
| `contentBlockIndex` | `number` | The index of the content block that is complete |
| `contentBlockDoneAtIndex` | `number` | The index at which the content block is complete |

#### ConversationStreamTurnDoneEvent

When the AI assistant completes a turn, the `next` callback is invoked with a `ConversationStreamTurnDoneEvent` object. This event indicates that the assistant has completed a turn and is waiting for the next user message.

| Property | Type | Description |
|----------|:-----|:------------|
| `id` | `string` | The unique identifier for the stream event |
| `conversationId` | `string` | The ID of the conversation this event belongs to |
| `associatedUserMessageId` | `string` | The ID of the user message that triggered this response |
| `contentBlockIndex` | `number` | The index of the final content block for the turn |
| `stopReason` | `string` | The reason why the assistant stopped generating the response |

#### ConversationStreamToolUseEvent

When the AI assistant uses a client tool, the `next` callback is invoked with a `ConversationStreamToolUseEvent` object. Tool use events are accumulated in your cloud resources and sent to the client as a single event.

| Property | Type | Description |
|----------|:-----|:------------|
| `id` | `string` | The unique identifier for the stream event |
| `conversationId` | `string` | The ID of the conversation this event belongs to |
| `associatedUserMessageId` | `string` | The ID of the user message that triggered this response |
| `contentBlockIndex` | `number` | The index of the content block being streamed |
| `toolUse` | `ToolUseBlock` | The tool use block containing function call information |

> **Note**: 
  **A note on ordering**

  There are no guarantees that events will be received by the client in order. For example, a `ConversationStreamTextEvent` with `contentBlockDeltaIndex` of `1` may be received before the preceding text with `contentBlockDeltaIndex` of `0`. Assume that events may be received out of order and use the `contentBlockIndex` and `contentBlockDeltaIndex` properties to order the events as needed.

### List messages for a conversation

Retrieve all messages for a conversation by calling the `.listMessages()` method on your conversation instance. Recall that messages are automatically persisted, so you can retrieve them at any time to display the conversation history.

```ts
const  = await conversation.listMessages();
```

Similar to the `client.conversations.chat.list()` method, retrieved messages are paginated. Use the `nextToken` value to paginate through messages and optionally specify a `limit` to limit the number of messages returned.

```ts
const  = await conversation.listMessages();
```


---

## 📚 Related Topics
- [[AI & Machine Learning/]]

## 📖 Source
Original: `pages/ai/conversation/connect-your-frontend/index.mdx`