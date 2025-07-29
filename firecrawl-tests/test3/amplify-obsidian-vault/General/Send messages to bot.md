---
title: Send messages to bot
topics: ['General']
primary_topic: General
source: fragments/lib-v1/interactions/js/chatbot.mdx
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

```javascript

let userInput = "I want to reserve a hotel for tonight";

// Provide a bot name and user input
const response = await Interactions.send("BookTrip", userInput);

// Log chatbot response
console.log(response.message);
```

## Display end of chat message

You can use `onComplete()` method to register a function to catch errors or chatbot confirmations when the session successfully ends.

```javascript

const handleComplete = function (err, confirmation) 
    alert('done: ' + JSON.stringify(confirmation, null, 2));

    return 'Trip booked. Thank you! What would you like to do next?';
}

Interactions.onComplete(botName, handleComplete );
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/interactions/js/chatbot.mdx`