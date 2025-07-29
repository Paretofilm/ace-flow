---
title: How it works
source: pages/ai/conversation/response-components/index.mdx
---

# How it works

Response components are custom UI components you can define that the AI assistant can respond with. Response components allow you to build conversational interfaces that are more than just text in and text out. 

## How it works

The `AIConversation` component takes the response components and turns them into [tool](/[platform]/ai/concepts/tools) configurations to send to the LLM. The tool configurations get sent when a user message is sent to the backend, then the backend Lambda merges the tools coming from the client and any [schema tools](/[platform]/ai/conversation/tools). The LLM sees that it can invoke UI component "tool", with certain input/props. If the LLM chooses to use a response component tool, a message gets sent to the client with the response component name and props. The `AIConversation` component will then try to render the React component provided with the props the LLM sends. 

It is important to know that the LLM is NOT writing raw code that sent to the browser and evaluated.

## Structure

The `responseComponents` prop on the `AIConversation` component takes a named object where the keys are the component names and the value is the component definition. 

A response component has:

* `description`: A description of the component. The more descriptive, the easier it is 
* `component`: The React component to render. The props of the component should match the props
* `props`: The props for the React component in [JSONSchema format](https://json-schema.org/understanding-json-schema/reference).

```tsx
 </div>
        )
      },
      props: ,
      },
    },
  }}
  // highlight-end
/>
```

## Passing context back to the assistant

When a user sends a message to the AI assistant from the client, you can optionally send `aiContext` with the message. `aiContext` is any information about the current state of the client application that might be useful for the AI assistant to know to help it respond better. `aiContext` could be things like the user's name, or the current state of the application like what page they are currently on. AI context is a plain object that will get stringified and sent to the AI assistant with the next user message.

You can use the `aiContext` to let the AI assistant know what was rendered in the response component so it can have more context to respond with.

It can be helpful to continue the conversation to add some context to the next message in the conversation to let the AI know what was displayed to the user. Because a UI component can have state and also data not included in a prop,

```tsx
// Create a context to share state across components
// highlight-start
const DataContext = React.createContext<>(, setData: () =>  });

function WeatherCard(: )  = React.useContext(DataContext);

  React.useEffect(() => )
  },[city])

  return (
    <div></div>
  )
}
// highlight-start

function Chat()  = React.useContext(DataContext);
  const [
    ,
      isLoading,
    },
    sendMessage,
  ] = useAIConversation('chat');

  return (
     ;
      }}
      // highlight-end
    />
  );
}

## Fallback

Because response components are defined at runtime in your React code, but conversation history is stored in a database, there can be times when there is a message in the conversation history that has a response component you no longer have. To handle these situations there is a `FallbackResponseComponent` prop you can use.

```tsx
 </>
  }}
  // highlight-end
/>
```
