---
title: AWS Lex V2
source: fragments/lib/interactions/js/chatbot.mdx
---

# AWS Lex V2

## AWS Lex V2
### Send messages to bot
You can send a text message to chatbot backend with `send()` command. The method returns a promise that includes the chatbot response.

```javascript

let userInput = "I want to reserve a hotel for tonight";

(async () => );

  // Log chatbot response
  console.log(response.message);
})()
```

### Display end of chat message

You can use `onComplete()` method to register a function to catch errors or chatbot confirmations when the session successfully ends.

```typescript

Interactions.onComplete() =>  else if (completion) 
  }
});
```

## AWS Lex V1
The Lex V1 module is located in a different path, and we strongly advise you to migrate to the Lex V2 bot ([migration guide](https://docs.aws.amazon.com/lexv2/latest/dg/migration.html)).

### Send messages to bot
The exposed APIs have same signatures. You can send a text message to chatbot backend with `send()` command. The method returns a promise that includes the chatbot response.

```javascript

let userInput = "I want to reserve a hotel for tonight";

(async () => );

  // Log chatbot response
  console.log(response.message);
})()
```

### Display end of chat message

You can use `onComplete()` method to register a function to catch errors or chatbot confirmations when the session successfully ends.

```typescript

InteractionsLexV1.onComplete() =>  else if (completion) 
  }
});
```
