---
title: Documentation
source: fragments/lib/datastore/android/getting-started/70_saveSnippet.mdx
---

# Documentation

```java
import android.util.Log;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.datastore.generated.model.Post;
```

```java
Post post = Post.builder()
    .title("Create an Amplify DataStore app")
    .status(PostStatus.ACTIVE)
    .build();

Amplify.DataStore.save(post,
    result -> Log.i("MyAmplifyApp", "Created a new post successfully"),
    error -> Log.e("MyAmplifyApp",  "Error creating post", error)
);
```

</Block>

```kotlin
import android.util.Log
import com.amplifyframework.core.Amplify
import com.amplifyframework.datastore.generated.model.Post
```

```kotlin
val post = Post.builder()
    .title("Create an Amplify DataStore app")
    .status(PostStatus.ACTIVE)
    .build()

Amplify.DataStore.save(post,
    ,
    
)
```

</Block>

```kotlin
import android.util.Log
import com.amplifyframework.datastore.generated.model.Post
import com.amplifyframework.kotlin.core.Amplify
```

```kotlin
val post = Post.builder()
    .title("Create an Amplify DataStore app")
    .status(PostStatus.ACTIVE)
    .build()

try  catch (error: DataStoreException) 
```

</Block>

 ```java
import android.util.Log;
import com.amplifyframework.datastore.generated.model.Post;
import com.amplifyframework.rx.RxAmplify;
```   

```java
Post post = Post.builder()
    .title("Create an Amplify DataStore app")
    .status(PostStatus.ACTIVE)
    .build();

RxAmplify.DataStore.save(post).subscribe(
    () -> Log.i("MyAmplifyApp", "Created a new post successfully"),
    error -> Log.e("MyAmplifyApp",  "Error creating post", error)
);
```

</Block>
</BlockSwitcher>
