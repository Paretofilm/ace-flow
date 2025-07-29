---
title: Context
topics: ['AI & Machine Learning']
primary_topic: AI & Machine Learning
source: pages/ai/conversation/context/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, ai-&-machine-learning]
---


## 🧭 Navigation
**Topics**: [[AI & Machine Learning/]]
**Primary**: [[AI & Machine Learning/]]

---


# Context

For LLMs to provide high-quality answers to users' questions, they need to have the right information. Sometimes this information is contextual, based on the user or the state of the application. To allow for this, you can send `aiContext` with any user message to the LLM, which can be any unstructured or structured data that might be useful.

> Note: `aiContext` is available during the chat and is passed to the LLM, however `metadata` is not available to the chat or passed to the LLM.

```ts

const client = generateClient();

const  = await client.conversations.chat.create();

conversation.sendMessage(],
  // aiContext can be any shape
  aiContext: 
})
```

</InlineFilter>

```tsx

  function handleSendMessage(message) 
    })
  }

  return (
    //...
  )
}
```

</InlineFilter>

```tsx
function Chat() ,
      isLoading,
    },
    sendMessage,
  ] = useAIConversation('chat');

  return (
     ;
      }}
    />
  );
}
```

The function passed to the `aiContext` prop will be run immediately before the request is sent in order to get the most up to date information. 

You can use React context or other state management systems to update the data passed to `aiContext`. Using React context we can provide more information about the current state of the application:

```tsx
// Create a context to share state across components
const DataContext = React.createContext<>(, setData: () =>  });

// Create a component that updates the shared state
function Counter()  = React.useContext(AIContext);
  const count = data.count ?? 0;
  return (
     setData()}>
      
    </Button>
  );
}

// reference shared data in aiContext
function Chat()  = React.useContext(DataContext);
  const [
    ,
      isLoading,
    },
    sendMessage,
  ] = useAIConversation('pirateChat');

  return (
     ;
      }}
    />
  );
}

</InlineFilter>


---

## 📚 Related Topics
- [[AI & Machine Learning/]]

## 📖 Source
Original: `pages/ai/conversation/context/index.mdx`