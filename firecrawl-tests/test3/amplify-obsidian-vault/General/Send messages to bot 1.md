---
title: Send messages to bot
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/interactions/chatbot/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Send messages to bot

## Send messages to bot
You can send a text message to chatbot backend with `send()` command. The method returns a promise that includes the chatbot response.

```javascript title="src/App.tsx"

const userInput = "I want to reserve a hotel for tonight";

// Provide a bot name and user input
const response = await Interactions.send();

// Log chatbot response
console.log(response.message);
```

## Display end of chat message

You can use `onComplete()` method to register a function to catch errors or chatbot confirmations when the session successfully ends.

```typescript title="src/App.tsx"

Interactions.onComplete() =>  else if (completion) 
  }
});
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/interactions/chatbot/index.mdx`