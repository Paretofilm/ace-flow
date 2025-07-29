---
title: Building your data backend
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/set-up-data/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Building your data backend

}

In this guide, you will learn how to set up Amplify Data. This includes building a real-time API and database using TypeScript to define your data model, and securing your API with authorization rules. We will also explore using AWS Lambda to scale to custom use cases.

Before you begin, you will need:

- [Node.js](https://nodejs.org/) v18.16.0 or later
- [npm](https://www.npmjs.com/) v6.14.4 or later
- [git](https://git-scm.com/) v2.14.1 or later

With Amplify Data, you can build a secure, real-time API backed by a database in minutes. After you define your data model using TypeScript, Amplify will deploy a real-time API for you. This API is powered by AWS AppSync and connected to an Amazon DynamoDB database. You can secure your API with authorization rules and scale to custom use cases with AWS Lambda.

## Building your data backend

If you've run `npm create amplify@latest` already, you should see an `amplify/data/resource.ts` file, which is the central location to configure your data backend. The most important element is the `schema` object, which defines your backend data models (`a.model()`) and custom queries (`a.query()`), mutations (`a.mutation()`), and subscriptions (`a.subscription()`).

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .authorization(allow => [allow.publicApiKey()])
});

// Used for code completion / highlighting when making requests from frontend

// defines the data resource to be deployed

Every `a.model()` automatically creates the following resources in the cloud:

- a DynamoDB database table to store records
- query and mutation APIs to create, read (list/get), update, and delete records
- `createdAt` and `updatedAt` fields that help you keep track of when each record was initially created or when it was last updated
- real-time APIs to subscribe for create, update, and delete events of records

The `allow.publicApiKey()` rule designates that anyone authenticated using an API key can create, read, update, and delete todos.

To deploy these resources to your cloud sandbox, run the following CLI command in your terminal:

```bash title="Terminal" showLineNumbers=
npx ampx sandbox
```

</InlineFilter>

```bash title="Terminal" showLineNumbers=
npx ampx sandbox --outputs-out-dir <path_to_app/src/main/res/raw/>
```

</InlineFilter>

```bash title="Terminal" showLineNumbers=
npx ampx sandbox --outputs-out-dir <path_to_swift_project>
```

</InlineFilter>

```bash title="Terminal" showLineNumbers=
npx ampx sandbox --outputs-format dart --outputs-out-dir lib
```

</InlineFilter>

## Connect your application code to the data backend

Once the cloud sandbox is up and running, it will also create an `amplify_outputs.json` file, which includes the relevant connection information to your data backend, like your API endpoint URL and API key.

To connect your frontend code to your backend, you need to:

1. Configure the Amplify library with the Amplify client configuration file (`amplify_outputs.json`)
2. Generate a new API client from the Amplify library
3. Make an API request with end-to-end type-safety

First, install the Amplify client library to your project:

```bash title="Terminal" showLineNumbers=
npm add aws-amplify
```
</InlineFilter>

In your app's entry point, typically **main.tsx** for React apps created using Vite, make the following edits:

```tsx title="src/main.tsx"

Amplify.configure(outputs);
```

</InlineFilter>

In your app's entry point, typically **main.ts** for Vue apps created using Vite, make the following edits:

```tsx title="src/main.ts"

Amplify.configure(outputs);
```

</InlineFilter>

Under Gradle Scripts, open build.gradle (Module :app), add the following lines:

```kotlin title="app/build.gradle.kts"
android 
}

dependencies 
```

Click **Sync Now** in the notification bar above the file editor to sync these dependencies.

Next, configure the Amplify client library with the generated `amplify_outputs.json` file to make it aware of the backend API endpoint. *Note: verify that the **amplify_outputs.json** file is present in your **res/raw/** folder.

Create a new `MyAmplifyApp` class that inherits from `Application` with the following code:

> **Note**: 
Before calling the `Amplify.configure` function, make sure to either download the `amplify_outputs.json` file from the console, or generate it with the following command: 

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <app-id> --branch main --out-dir app/src/main/res/raw
```

Next, be sure the file you generated or downloaded is in the appropriate resource directory for your application (for example, `app/src/main/res/raw`) in your Android project. Otherwise, you will not be able to compile your application.

```kt
package com.example.myapplication

import android.app.Application
import android.util.Log
import com.amplifyframework.AmplifyException
import com.amplifyframework.api.aws.AWSApiPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.core.configuration.AmplifyOutputs

class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

This overrides the `onCreate()` to initialize Amplify when your application is launched.

Next, configure your application to use your new custom Application class. Open **manifests** > **AndroidManifest.xml**, and add an `android:name` attribute with the value of your new class name:

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <application
        // highlight-next-line
        android:name=".MyAmplifyApp"
        ...
    >
      <!-- ... -->
    </application>
</manifest>
```

Build and run the application. In Logcat, you'll see a log line indicating success:

```console title="Logcat" showLineNumbers=
com.example.MyAmplifyApp I/MyAmplifyApp: Initialized Amplify
```

Finally, let's generate the GraphQL client code for your Android application. Amplify Data uses GraphQL under the hood to make query, mutation, and subscription requests. The generated GraphQL client code helps you to author fully-typed API requests without needing to hand-author GraphQL requests and manually map them to Kotlin or Java code.

```bash title="Terminal" showLineNumbers=
npx ampx generate graphql-client-code --format modelgen --model-target java --out <path_to_app/src/main/java/>
```

</InlineFilter>

Drag and drop the **amplify_outputs.json** file from the Finder into Xcode.

Next, add Amplify Library for Swift through Swift Package Manager. In Xcode, select **File** > **Add Packages...**.

Then, enter the Amplify Library for Swift GitHub repo URL (https://github.com/aws-amplify/amplify-swift) into the search bar and hit **Enter**.

Once the result is loaded, choose Up to **Next Major Version** as the **Dependency Rule**, then click **Add Package**.

Choose which of the libraries you want added to your project. For this tutorial, select **AWSAPIPlugin** and **Amplify**, then click **Add Package**.

Now let's add the necessary plugins into the Swift application by customizing the `init()` function of your app:

```swift title="MyAmplifyApp"
import SwiftUI
// highlight-start
import Amplify
import AWSAPIPlugin
// highlight-end

@main
struct MyAmplifyApp: App  catch 
    }
    // highlight-end

    var body: some Scene 
    }
}
```

Finally, let's generate the GraphQL client code for your Swift application. Amplify Data uses GraphQL under the hood to make query, mutation, and subscription requests. The generated GraphQL client code helps you to author fully-typed API requests without needing to hand-author GraphQL requests and manually map them to Swift code.

```bash title="Terminal" showLineNumbers=
npx ampx generate graphql-client-code --format modelgen --model-target swift --out <path_to_swift_project>/AmplifyModels
```

Drag and drop the **AmplifyModels** folder into your Xcode project to add the generated files.

</InlineFilter>

From your project root directory, find and modify your **pubspec.yaml** and add the Amplify plugins to the project dependencies.

```yaml title="pubspec.yaml"
dependencies:
  // highlight-start
  amplify_api: ^2.0.0
  amplify_flutter: ^2.0.0
  // highlight-end
  flutter:
    sdk: flutter
```

Install the dependencies by running the following command. Depending on your development environment, you may perform this step via your IDE (or it may even be performed for you automatically).

```bash title="Terminal" showLineNumbers=
flutter pub get
```

Now, let's generate the GraphQL client code for your Flutter application. Amplify Data uses GraphQL under the hood to make query, mutation, and subscription requests. The generated GraphQL client code helps you to author fully-typed API requests without needing to hand-author GraphQL requests and manually map them to Dart code.

```bash title="Terminal" showLineNumbers=
npx ampx generate graphql-client-code --format modelgen --model-target dart --out <path_to_flutter_project>/lib/models
```

Finally, let's add the necessary plugins into the Flutter application by customizing the `main()` function of the **lib/main.dart** file:

```dart title="lib/main.dart"
// highlight-start
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
// highlight-end
import 'package:flutter/material.dart';

// highlight-start
import 'amplify_outputs.dart';
import 'models/ModelProvider.dart';
// highlight-end

Future<void> main() async  on Exception catch (e) 
  // highlight-end

  runApp(const MyApp());
}
```

</InlineFilter>
## Write data to your backend

Let's first add a button to create a new todo item. To make a "create Todo" API request, generate the data client using `generateClient()` in your frontend code, and then call `.create()` operation for the Todo model. The Data client is a fully typed client that gives you in-IDE code completion. To enable this in-IDE code completion capability, pass in the `Schema` type to the `generateClient` function.

</InlineFilter>

```tsx title="src/TodoList.tsx"

const client = generateClient()

  return <div>
    <button onClick=>Add new todo</button>
  </div>
}
```
</InlineFilter>

```html title="src/TodoList.vue"
<script setup lang="ts">

const client = generateClient()

async function createTodo() )
}
</script>

<template>
  <div>
    <button @click="createTodo">Add new todo</button>
  </div>
</template>
```
</InlineFilter>

Run the application in local development mode with `npm run dev` and check your network tab after creating a todo. You should see a successful request to a `/graphql` endpoint.

> **Note**: 

Try playing around with the code completion of `.update(...)` and `.delete(...)` to get a sense of other mutation operations.

</InlineFilter>

```ts title="todo-list.component.ts"

const client = generateClient();

@Component()

Run the application in local development mode and check your network tab after creating a todo. You should see a successful request to a `/graphql` endpoint.

> **Note**: 

Try playing around with the code completion of `.update(...)` and `.delete(...)` to get a sense of other mutation operations.

</InlineFilter>

In your MainActivity, add a button to create a new todo.

```kt title="MainActivity.kt"
// imports

class MainActivity : ComponentActivity() ")},
                                ,
                            )
                        }) 
                    }
                    // highlight-end
                }
            }
        }
    }
}
```

Build and run your app. Then, click on "Create Todo" on the app. Your Logcat should show you that a todo was successfully added:

```console title="Logcat" showLineNumbers=
com.example.MyAmplifyApp I/MyAmplifyApp: Added Todo with id: SOME_TODO_ID
```

</InlineFilter>

Create a new file called `TodoViewModel.swift` and the `createTodo` function with the following code:

```swift title="TodoViewModel.swift"
import Foundation
import Amplify

@MainActor
class TodoViewModel: ObservableObject 
            } catch let error as APIError  catch 
        }
    }
}

```

Update `ContentView.swift` with the following code:

```swift title="ContentView.swift"
struct ContentView: View ) 
            }
            .accessibilityLabel("New Todo")
        }
        // highlight-end
    }
}
```

Now if you run the application, and click on the "Add a New Todo" button, you should see a log indicating a todo was created:

```console title="Logs" showLineNumbers=
Successfully created todo: Todo(id: XYZ ...)
```

</InlineFilter>

In your page, let's add a floating action button that creates a new todo.

```dart title="lib/main.dart"
// ... main()
class MyApp extends StatelessWidget );

  @override
  Widget build(BuildContext context) 
}

class MyHomePage extends StatefulWidget );

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State  else 
        },
        tooltip: 'Add todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

Now if you run the application, and click on the floating action button, you should see a log indicating a todo was created:

```console showLineNumbers=
Creating Todo successful.
```

</InlineFilter>

## Read data from your backend

Next, list all your todos and then refetch the todos after a todo has been added:

```tsx title="src/TodoList.tsx"

const client = generateClient();

  const fetchTodos = async () =>  = await client.models.Todo.list();
    setTodos(items);
  };

  useEffect(() => , []);

  const createTodo = async () => );

    fetchTodos();
  }

  return (
    <div>
      <button onClick=>Add new todo</button>
      <ul>
        ) => (
          <li key=></li>
        ))}
      </ul>
    </div>
  );
}
```

</InlineFilter>

```html title="src/TodoList.vue"
<script setup lang="ts">

const client = generateClient()

// create a reactive reference to the array of todos
const todos = ref>([]);

function fetchTodos()  = await client.models.Todo.list();
  todos.value = items; 
}

async function createTodo() )
  fetchTodos();
}

 onMounted(() => );

</script>

<template>
  <div>
    <button @click="createTodo">Add new todo</button>
    <ul>
     <li 
       v-for="todo in todos" 
       :key="todo.id">
       }
     </li>
    </ul>
  </div>
</template>
```

</InlineFilter>

```ts title="todo-list.component.ts"

const client = generateClient();

@Component(}</li>
      </ul>
    </div>
  `
})

  async ngOnInit() 

  async fetchTodos()  = await client.models.Todo.list();
    this.todos = items;
  }

  async createTodo() );
    await this.fetchTodos();
  }
}
```
</InlineFilter>

Start by creating a new `TodoList` @Composable that fetches the data on the initial display of the TodoList:

```kt title="MainActivity.kt"
@Composable
fun TodoList() 

    LaunchedEffect(Unit) ,
            )
    }

    LazyColumn 
        }
    }
}
```

If you build and rerun the application, you should see the todo that was created in the previous build. But notice how when you click on the "create Todo" button, it doesn't add any new todos to the list below until the next time your app relaunches. To solve this, let's add real-time updates to the todo list.

</InlineFilter>

Update the `listTodos` function in the `TodoViewModel.swift` for listing to-do items:

```swift title="TodoViewModel.swift"
@MainActor
class TodoViewModel: ObservableObject 

    // highlight-start
    func listTodos() 
            } catch let error as APIError  catch 
        }
    }
    // highlight-end
}
```

Now let's update the UI code to observe the todos. 

```swift title="ContentView.swift"
import SwiftUI
import Amplify

struct ContentView: View 
            // highlight-end
            // .. Add a new Todo button
        }
        // highlight-start
        .task 
        // highlight-end
    }
}

```

</InlineFilter>

Start by adding a new list to track the todos and the ability to fetch the todo list when it first renders:

```dart title="lib/main.dart"
// ...main()

class MyApp extends StatelessWidget );

  @override
  Widget build(BuildContext context) 
}

class MyHomePage extends StatefulWidget );

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State 

  Future<void> _refreshTodos() async ');
        return;
      }
      setState(() );
    } on ApiException catch (e) 
  }

  @override
  Widget build(BuildContext context) ,
                      );
                    }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async  else 
        },
        tooltip: 'Add todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```

</InlineFilter>

## Subscribe to real-time updates

You can also use `observeQuery` to subscribe to a live feed of your backend data. Let's refactor the code to use a real-time observeQuery instead.

```tsx title="src/App.tsx"

const client = generateClient();

  useEffect(() => ) => ,
    });

    return () => sub.unsubscribe();
  }, []);

  const createTodo = async () => );
    // no more manual refetchTodos required!
    // - fetchTodos()
  };

  return (
    <div>
      <button onClick=>Add new todo</button>
      <ul>
        ) => (
          <li key=></li>
        ))}
      </ul>
    </div>
  );
}
```
</InlineFilter>

You can also use `observeQuery` to subscribe to a live feed of your backend data. Let's refactor the code to use a real-time observeQuery instead.

```html title="src/TodoList.vue"
<script setup lang="ts">

const client = generateClient()

// create a reactive reference to the array of todos
const todos = ref>([]);

function fetchTodos() ) => ,
  }); 
}

async function createTodo() )
  // no more manual refetchTodos required!
  // - fetchTodos()
}

 onMounted(() => );

</script>

<template>
  <div>
    <button @click="createTodo">Add new todo</button>
    <ul>
     <li 
       v-for="todo in todos" 
       :key="todo.id">
       }
     </li>
    </ul>
  </div>
</template>
```
</InlineFilter>

You can also use `observeQuery` to subscribe to a live feed of your backend data. Let's refactor the code to use a real-time observeQuery instead.

```ts title="todo-list.component.ts"

const client = generateClient();

@Component(}
        </li>
      </ul>
      <div>
        🥳 App successfully hosted. Try creating a new todo.
        <br />
        <a href="https://docs.amplify.aws/gen2/start/quickstart/">
          Review next steps of this tutorial.
        </a>
      </div>
    </main>
  `,
})

  ngOnInit(): void 

  ngOnDestroy(): void 

  listTodos() ) => ,
      });
    } catch (error) 
  }

  createTodo() );
      this.listTodos();
    } catch (error) 
  }
}
```

Now try to open your app in two browser windows and see how creating a todo in one window automatically adds the todo in the second window as well.

> **Note**: 

You can also use `.onCreate`, `.onUpdate`, or `.onDelete` to subscribe to specific events. Review [Subscribe to real-time events](/[platform]/build-a-backend/data/subscribe-data) to learn more about subscribing to specific mutation events.

</InlineFilter>

To add real-time updates, you can use the subscription feature of Amplify Data. It allows to subscribe to `onCreate`, `onUpdate`, and `onDelete` events of the application. In our example, let's append the list every time a new todo is added.

```kt title="MainActivity.kt"
@Composable
fun TodoList() 

    LaunchedEffect(Unit) ,
            )
        // highlight-start
        Amplify.API.subscribe(ModelSubscription.onCreate(Todo::class.java),
            ,
            ")
                todoList = todoList + it.data
            },
            ,

        )
        // highlight-end
    }

    LazyColumn 
        }
    }
}
```
Now call `TodoList()` from the `onCreate()` function:

```kt title="MainActivity.kt"
setContent !",
                    )
                    ....
                    //highlight-next-line
                    TodoList()
```

</InlineFilter>

To add real-time updates, you can use the subscription feature of Amplify Data. It allows to subscribe to `onCreate`, `onUpdate`, and `onDelete` events of the application. In our example, let's append the list every time a new todo is added.

First, add a private variable to store the subscription. Then create the subscription on the `init()` initializer, and add the `subscribe()` and `cancel()` functions.

```swift title="TodoViewModel.swift"
@MainActor
class TodoViewModel: ObservableObject 

    func subscribe() 
            } catch 
        }
    }

    private func handleSubscriptionEvent(_ subscriptionEvent: GraphQLSubscriptionEvent) 
        }
    }

    func cancel() 
    // highlight-end

    func createTodo() 

    func listTodos() 
}
```

Then in `ContentView.swift`, when the view appears, call `vm.subscribe()`. On disappear, cancel the subscription.

```swift title="ContentView.swift"
struct ContentView: View 
        // highlight-start
        .onDisappear 
        .task 
        // highlight-end
    }
}
```

Now if you rerun your app, a new todo should be appended to the list every time you create a new todo.

</InlineFilter>

To add real-time updates, you can use the subscription feature of Amplify Data. It allows to subscribe to `onCreate`, `onUpdate`, and `onDelete` events of the application. In our example, let's append the list every time a new todo is added.

When the page renders, subscribe to `onCreate` events and then unsubscribe when the Widget is disposed.

```dart title="lib/main.dart"
// ...main()
// ...MyApp
// ...MyHomePage

class _MyHomePageState extends State 

  // highlight-start
  @override
  void dispose() 
  // highlight-end

  // highlight-start
  void _subscribe() ');
        setState(() );
      },
      onError: (Object e) => safePrint('Error in subscription stream: $e'),
    );
  }
  // highlight-end

  // highlight-start
  void _unsubscribe() 
  // highlight-end

  // ..._refreshTodos()
  // ...build()
}
```

</InlineFilter>

## Conclusion

Success! You've learned how to create your first real-time API and database with Amplify Data.

### Next steps

There's so much more to discover with Amplify Data. Learn more about:

- [How to model your database table and their access patterns](/[platform]/build-a-backend/data/data-modeling)
- [Secure your API with fine-grained authorization rules](/[platform]/build-a-backend/data/customize-authz)
- [Create relationships between different database model](/[platform]/build-a-backend/data/data-modeling/relationships)
- [Add custom business logic](/[platform]/build-a-backend/data/custom-business-logic)


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/set-up-data/index.mdx`