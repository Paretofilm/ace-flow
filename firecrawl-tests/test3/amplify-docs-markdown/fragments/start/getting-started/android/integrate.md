---
title: Configure Amplify and DataStore
source: fragments/start/getting-started/android/integrate.mdx
---

# Configure Amplify and DataStore

Next you'll use the generated model to read and write data. In this section you'll initialize DataStore, and create and query for Todo items.

## Configure Amplify and DataStore

First, you'll add the DataStore plugin and configure Amplify.

Right-click on your namespace (`com.example.Todo`), click **New**, and click **Java Class** or **Kotlin Class/File** depending on which language you chose.

Configure the new class in **New Java Class**:

- Enter *MyAmplifyApp* in the **Name** field

- Press **OK**

- Extend *MyAmplifyApp* from *android.app.Application* by adding `extends Application` to your class

Add the following import statements at the top of the file:

```java
import android.app.Application;
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.datastore.AWSDataStorePlugin;
```

Initialize Amplify by adding an `onCreate` method with the following code:

```java
public void onCreate()  catch (AmplifyException error) 
}
```

</Block>

Configure the new class in **New Kotlin Class/File**:

- Enter *MyAmplifyApp* in the **Name** field

- Press enter

- Extend *MyAmplifyApp* from *android.app.Application* by adding `: Application()` to your class

Add the following import statements at the top of the file:

```kotlin
import android.app.Application
import android.util.Log
import com.amplifyframework.AmplifyException
import com.amplifyframework.core.Amplify
import com.amplifyframework.datastore.AWSDataStorePlugin
```

Initialize Amplify by adding an `onCreate` method with the following code:

```kotlin
override fun onCreate()  catch (error: AmplifyException) 
}
```

</Block>
</BlockSwitcher>

This overrides the `onCreate()` to initialize Amplify when your application is launched.

Next, configure your application to use your new custom `Application` class. Open **manifests** > **AndroidManifest.xml**, and add an `android:name` attribute with the value of your new class name:

  ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <manifest xmlns:android="http://schemas.android.com/apk/res/android"
      xmlns:tools="http://schemas.android.com/tools">

      <!-- Add the android:name attribute to the application node -->
      <application
          android:name=".MyAmplifyApp"
          <!-- ... -->
      </application>
  </manifest>
  ```

**Build and run** the application. In logcat, you'll see a log line indicating success:

```console
com.example.MyAmplifyApp I/MyAmplifyApp: Initialized Amplify
```

To make this easier to find, enter the string **MyAmplifyApp** into the search field

## Manipulating data

### Create a Todo

Next, you'll create a Todo and save it to DataStore.

1. Open `MainActivity` and **add the following** import statements at the top of the file:

  ```java
  import android.util.Log;
  import com.amplifyframework.AmplifyException;
  import com.amplifyframework.core.Amplify;
  import com.amplifyframework.core.model.temporal.Temporal;
  import com.amplifyframework.datastore.AWSDataStorePlugin;
  import com.amplifyframework.datastore.generated.model.Priority;
  import com.amplifyframework.datastore.generated.model.Todo;
  import java.util.*;
  import java.util.concurrent.TimeUnit;
  ```

  </Block>

  ```kotlin
  import android.util.Log
  import com.amplifyframework.AmplifyException
  import com.amplifyframework.core.Amplify
  import com.amplifyframework.core.model.temporal.Temporal
  import com.amplifyframework.datastore.AWSDataStorePlugin
  import com.amplifyframework.datastore.generated.model.Priority
  import com.amplifyframework.datastore.generated.model.Todo
  import java.util.*
  import java.util.concurrent.TimeUnit
  ```

  </Block>
  </BlockSwitcher>

2. In the same file (<code> MainActivity </code>), add the following code to the bottom of the <code> onCreate() </code> method:

  ```java
  Todo item = Todo.builder()
      .name("Build Android application")
      .priority(Priority.NORMAL)
      .build();

  Amplify.DataStore.save(item,
      success -> Log.i("Tutorial", "Saved item: " + success.item().getName()),
      error -> Log.e("Tutorial", "Could not save item to DataStore", error)
  );
  ```

  </Block>

  ```kotlin
  val item = Todo.builder()
      .name("Build Android application")
      .priority(Priority.NORMAL)
      .build()

  Amplify.DataStore.save(item,
      ") },
      
  )
  ```

  </Block>
  </BlockSwitcher>

  This code creates a Todo item with two properties: a name, and a priority, and then calls <code> Amplify.DataStore.save() </code> in order to store it on DataStore.

3. After making the preceding updates to the <code> MainActivity </code> file, your code should look like the following:

  ```java
  package com.example.todo;

  import androidx.appcompat.app.AppCompatActivity;
  import android.os.Bundle;
  import android.util.Log;
  import com.amplifyframework.core.Amplify;
  import com.amplifyframework.core.model.query.Where;
  import com.amplifyframework.core.model.temporal.Temporal;
  import com.amplifyframework.datastore.AWSDataStorePlugin;
  import com.amplifyframework.datastore.generated.model.Priority;
  import com.amplifyframework.datastore.generated.model.Todo;
  import java.util.*;
  import java.util.concurrent.TimeUnit;

  public class MainActivity extends AppCompatActivity 
  }
  ```

  </Block>

  ```kotlin
  package com.example.todo

  import androidx.appcompat.app.AppCompatActivity
  import android.os.Bundle
  import android.util.Log
  import com.amplifyframework.core.Amplify
  import com.amplifyframework.core.model.query.Where
  import com.amplifyframework.core.model.temporal.Temporal
  import com.amplifyframework.datastore.AWSDataStorePlugin
  import com.amplifyframework.datastore.generated.model.Priority
  import com.amplifyframework.datastore.generated.model.Todo
  import java.util.*
  import java.util.concurrent.TimeUnit

  class MainActivity : AppCompatActivity() ") },
              
          )
      }
  }
  ```

  </Block>
  </BlockSwitcher>

4. **Build and run** the application. In logcat, you'll see an indication that the item was saved successfully:

  ```console
  com.example.todo I/Tutorial: Initialized Amplify
  com.example.todo I/Tutorial: Saved item: Build Android application
  ```

1. **Replace the item** with a new Todo to save an additional item. Let's change the name and priority, and add a completedAt:

  ```java
  Date date = new Date();
  int offsetMillis = TimeZone.getDefault().getOffset(date.getTime());
  int offsetSeconds = (int) TimeUnit.MILLISECONDS.toSeconds(offsetMillis);
  Temporal.DateTime temporalDateTime = new Temporal.DateTime(date, offsetSeconds);
  Todo item = Todo.builder()
      .name("Finish quarterly taxes")
      .priority(Priority.HIGH)
      .completedAt(temporalDateTime)
      .build();
  ```

  </Block>

  ```kotlin
  val date = Date()
  val offsetMillis = TimeZone.getDefault().getOffset(date.time).toLong()
  val offsetSeconds = TimeUnit.MILLISECONDS.toSeconds(offsetMillis).toInt()
  val temporalDateTime = Temporal.DateTime(date, offsetSeconds)
  val item = Todo.builder()
      .name("Finish quarterly taxes")
      .priority(Priority.HIGH)
      .completedAt(temporalDateTime)
      .build()
  ```

  </Block>
  </BlockSwitcher>

5. **Build and run** the application. In logcat, you'll see an indication that the item was saved successfully:

  ```console
  com.example.todo I/Tutorial: Initialized Amplify
  com.example.todo I/Tutorial: Saved item: Finish quarterly taxes
  ```

### Query Todos

Now that you have some data in DataStore, you can run queries to retrieve those records.

1. Edit your `onCreate` method to remove anything related to DataStore and replace it with the following code:

  ```java
  Amplify.DataStore.query(Todo.class,
      todos -> 

              if (todo.getCompletedAt() != null) 
          }
      },
      failure -> Log.e("Tutorial", "Could not query DataStore", failure)
  );
  ```

  </Block>

  ```kotlin
  Amplify.DataStore.query(Todo::class.java,
      ")
              todo.priority?.let 
              todo.completedAt?.let 
          }
      },
      
  )
  ```

  </Block>
  </BlockSwitcher>

1. Run the application. In logcat, you'll see both items returned:

  ```console
  com.example.todo I/Tutorial: Initialized Amplify
  com.example.todo I/Tutorial: ==== Todo ====
  com.example.todo I/Tutorial: Name: Build Android application
  com.example.todo I/Tutorial: Priority: NORMAL
  com.example.todo I/Tutorial: ==== Todo ====
  com.example.todo I/Tutorial: Name: Finish quarterly taxes
  com.example.todo I/Tutorial: Priority: HIGH
  com.example.todo I/Tutorial: CompletedAt: 
  ```

1. Queries can also contain predicate filters. These will query for specific objects matching a certain condition.

  The following predicates are supported:

  **Strings**

  `eq` `ne` `le` `lt` `ge` `gt` `contains` `notContains` `beginsWith` `between`

  **Numbers**

  `eq` `ne` `le` `lt` `ge` `gt` `between`

  **Lists**

  `contains` `notContains`

  To use a predicate, pass an additional argument into your query. For example, the following code queries for all high priority items:

  ```java
  Amplify.DataStore.query(Todo.class,
      Where.matches(Todo.PRIORITY.eq(Priority.HIGH)),
      todos -> 

              if (todo.getCompletedAt() != null) 
          }
      },
      failure -> Log.e("Tutorial", "Could not query DataStore", failure)
  );
  ```

  </Block>

  ```kotlin
  Amplify.DataStore.query(
      Todo::class.java, Where.matches(Todo.PRIORITY.eq(Priority.HIGH)),
      ")
              todo.priority?.let 
              todo.completedAt?.let 
          }
      },
      
  )
  ```

  </Block>
  </BlockSwitcher>

  In the above code, notice the addition of the predicate parameter as the second argument.

1. Run the application. In logcat, you'll see only the high priority item returned:

  ```console
  com.example.todo I/Tutorial: Initialized Amplify
  com.example.todo I/Tutorial: ==== Todo ====
  com.example.todo I/Tutorial: Name: Finish quarterly taxes
  com.example.todo I/Tutorial: Priority: HIGH
  com.example.todo I/Tutorial: CompletedAt: 
  ```

### Update a Todo

You may want to change the contents of a record. Below, we'll query for a record, create a copy of it, modify it, and save it back to DataStore.

1. Edit your `onCreate` method to remove anything related to DataStore and replace it with the following code:

   ```java
    Amplify.DataStore.query(Todo.class, Where.matches(Todo.NAME.eq("Finish quarterly taxes")),
        matches -> 
        },
        failure -> Log.e("Tutorial", "Query failed.", failure)
    );
   ```

   </Block>

   ```kotlin
  Amplify.DataStore.query(Todo::class.java, Where.matches(Todo.NAME.eq("Finish quarterly taxes")),
      ") },
                  
              )
          }
      },
      
  )
   ```

  </Block>
  </BlockSwitcher>

1. **Build and run** the application. In your logcat, you'll see an indication that the item was updated successfully:

    ```console
    Initialized Amplify
    Updated item: File quarterly taxes
    ```

### Delete a Todo

To round out CRUD operations, we'll query for a record and then delete it from DataStore.

1. Edit your `onCreate()` method to remove anything related to DataStore and replace it with the following code:

   ```java
   Amplify.DataStore.query(Todo.class, Where.matches(Todo.NAME.eq("File quarterly taxes")),
       matches -> 
       },
       failure -> Log.e("Tutorial", "Query failed.", failure)
   );

   ```

   </Block>

   ```kotlin
    Amplify.DataStore.query(Todo::class.java, Where.matches(Todo.NAME.eq("File quarterly taxes")),
        ") },
                    
                )
            }
        },
        
    )
   ```

   </Block>
   </BlockSwitcher>

1. **Build and run** the application. In the console output, you'll see an indication that the item was deleted successfully:
  ```console
  Initialized Amplify
  Deleted item: File quarterly taxes
  ```

## Almost done

We just reached a *very cool* checkpoint. We have a fully featured CRUD application that saves and retrieves data in the local device, which means the app **works without an AWS account and even without internet connection**.

Next, let's connect it to AWS and make sure the data available in the cloud.
