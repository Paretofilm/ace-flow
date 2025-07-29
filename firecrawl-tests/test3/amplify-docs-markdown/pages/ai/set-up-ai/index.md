---
title: Prerequisites
source: pages/ai/set-up-ai/index.mdx
---

# Prerequisites

In this guide, you will learn how to get stared with the Amplify AI kit. This includes defining your AI backend with Conversation and Generation routes, and securely connecting to them from your frontend application.

> **Note**: 

[An easy way to get started is with one of our samples](https://github.com/aws-samples/amplify-ai-examples)

## Prerequisites

Before you begin, you will need:

- [Node.js](https://nodejs.org/) v18.16.0 or later
- [npm](https://www.npmjs.com/) v6.14.4 or later
- [git](https://git-scm.com/) v2.14.1 or later

You will also need an AWS account that is [setup for local development](/[platform]/start/account-setup) and has access to the Bedrock Foundation Model(s) you want to use. You can request access to Bedrock models by going in to the [Bedrock console and requesting access](https://console.aws.amazon.com/bedrock/home#/modelaccess).

> **Note**: 

Running inference on large language models (LLMs) can be costly. Amazon Bedrock is a serverless service so you only pay for what you use, but be mindful of the costs associated with building generative AI applications. [See Bedrock pricing for more information](https://aws.amazon.com/bedrock/pricing/).

## Create an Amplify backend

Run the create amplify script in your project directory:

```bash title="Terminal"
npm create amplify@latest
```

Then run the [Amplify sandbox](/[platform]/deploy-and-host/sandbox-environments/setup/) to start your local cloud sandbox:

```bash title="Terminal"
npx ampx sandbox
```

This will provision the cloud resources you define in your amplify folder and watch for updates and redeploy them.

## Build your AI backend

To build an AI backend, you define AI 'routes' in your Amplify Data schema. An AI route is like an API endpoint for interacting with backend AI functionality. There are currently 2 types of routes:

* **Conversation:** A conversation route is a streaming, multi-turn API. Conversations and messages are automatically stored in DynamoDB so users can resume conversations. Examples of this are any chat-based AI experience or conversational UI.
* **Generation:** A single synchronous request-response API. A generation route is just an AppSync Query. Examples of this are: generating alt text for an image, generating structured data from unstructured input, summarization, etc.

> **Note**: 
See [Supported Providers and Models](/[platform]/ai/concepts/models/#supported-providers-and-models) for a list of supported AI models.

To define AI routes, open your **amplify/data/resource.ts** file and use `a.generation()` and `a.conversation()` in your schema.

```ts title="amplify/data/resources.ts"

const schema = a.schema()
  .authorization((allow) => allow.owner()),
  // highlight-end

  // This adds a new generation route to your Amplify Data backend.
  // highlight-start
  generateRecipe: a.generation()
  .arguments()
  .returns(
    a.customType()
  )
  .authorization((allow) => allow.authenticated()),
  // highlight-end
});
```

> **Note**: 

Conversation routes currently ONLY support owner-based authorization and generation routes ONLY support non-owner-based authorization (`authenticated`, `guest`, `group`, `publicApiKey`).

If you have the Amplify sandbox running, when you save this file it will pick up the changes and redeploy the necessary resources for you.

## Connect your frontend

Once the cloud sandbox is up and running, it will also create an `amplify_outputs.json` file, which includes relevant connection information to your AI routes and other Amplify configuration.

To connect your frontend code to your backend, you need to:

1. Configure the Amplify library with the Amplify client configuration file (`amplify_outputs.json`).
2. Generate a new API client from the Amplify library.
3. Make an API request with end-to-end type-safety.

### Install the client libraries

Install the Amplify client library to your project:

```bash title="Terminal"
npm add aws-amplify @aws-amplify/ui-react @aws-amplify/ui-react-ai
```

</InlineFilter>

```bash title="Terminal"
npm add aws-amplify
```

</InlineFilter>

### Configure the libraries

Call `Amplify.configure()` with the **amplify_outputs.json** file in your **main.ts** file.

```ts title="src/main.ts"
import "./assets/main.css";

Amplify.configure(outputs);

createApp(App).mount("#app");
```

</InlineFilter>

Call `Amplify.configure()` with the **amplify_outputs.json** file in your main app component:

```ts

Amplify.configure(outputs);
```

</InlineFilter>

Call `Amplify.configure()` with the **amplify_outputs.json** file where the React application is mounted.

```tsx title="src/main.tsx"
import '@aws-amplify/ui-react/styles.css';

Amplify.configure(outputs);
```

</InlineFilter>

```tsx title="pages/_app.tsx"
import "@/styles/app.css";
import "@aws-amplify/ui-react/styles.css";

Amplify.configure(outputs);

</Block>

Create a client component that will configure Amplify:

```tsx title="app/ConfigureAmplify.tsx"
"use client";

import "@aws-amplify/ui-react/styles.css";

Amplify.configure(config);

Then render that component in the root layout:

```tsx title="app/layout.tsx"

```

</Block>
</BlockSwitcher>

</InlineFilter>

### Generate the data client

Next, generate a type-safe frontend client to talk to our backend using our backend data schema and the `generateClient()` function provided by the Amplify libraries.

```ts

</InlineFilter>

It can be helpful to create a `client.ts/js` file that exports the generated Amplify data client as well as the generated React hooks.

```ts title="src/client.ts"

</Block>

```ts title="src/client.js"

/**
 * @type 
 */

</Block>
</BlockSwitcher>

</InlineFilter>

### Use a generation

```tsx title="src/App.tsx"

  const handleClick = async () => );
  };

  return (

         setDescription(e.target.value)}
          label="Description"
        />
        Generate recipe</Button>
      </Flex>
      </Text>

              </View>
            ))}
          </View>
          </Text>
        </>
      )}
    </Flex>
  );
}
```

</InlineFilter>

```tsx title="pages/index.tsx"
import  from "@aws-amplify/ui-react";

  const handleClick = async () => );
  };

  return (

         setDescription(e.target.value)}
          label="Description"
        />
        Generate recipe</Button>
      </Flex>
      </Text>

              </View>
            ))}
          </View>
          </Text>
        </>
      )}
    </Flex>
  );
}
```

</Block>

```tsx title="app/page.tsx"
"use client";
import  from "@aws-amplify/ui-react";

  const handleClick = () => );
  };

  return (

         setDescription(e.target.value)}
          label="Description"
        />
        Generate recipe</Button>
      </Flex>
      </Heading>

              </Text>
            ))}
          </View>
          </Text>
        </>
      )}
    </Flex>
  );
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

```tsx
import  from "react-native";

  const handleClick = () => );
  };

  return (
    
         setDescription(e.target.value)}
          label="Description"
        />
        Generate recipe</Button>
      </Heading>

              </Text>
            ))}
          </View>
          </Text>
        </>
      )}
    </Flex>
  );
}
```

</InlineFilter>

```ts

const  = await client.generations.generateRecipe();
```

</InlineFilter>

### Use a conversation

AI conversations are scoped to a user, so your users will need to be logged in with Amplify auth. The easiest way to do this is with the Authenticator component.

```tsx title="src/App.tsx"

  return (

    </Authenticator>
  );
}
```

</InlineFilter>

```tsx title="pages/index.tsx"

  return (

    </Authenticator>
  );
}
```
</Block>

```tsx title="app/page.tsx"
'use client'

  return (

    </Authenticator>
  );
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

```ts
const  = await client.conversations.chat.create();

// Assistant messages come back as websocket events
// over a subscription
conversation.onStreamEvent(,
  error: (error) => 
});

// When sending user messages you only need to send
// the latest message, the conversation history
// is stored in DynamoDB and retrieved in Lambda
conversation.sendMessage(],
})
```

</InlineFilter>
