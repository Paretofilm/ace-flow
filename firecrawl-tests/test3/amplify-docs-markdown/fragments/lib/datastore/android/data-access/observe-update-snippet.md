---
title: Documentation
source: fragments/lib/datastore/android/data-access/observe-update-snippet.mdx
---

# Documentation

```java
public class ObserveExample 
        };
        Consumer observationStarted = value ->;
        Consumer onObservationError = value ->;
        Action onObservationComplete = () ->;

        ObserveQueryOptions options = new ObserveQueryOptions();

        Amplify.DataStore.observeQuery(
                Post.class,
                options,
                observationStarted,
                onQuerySnapshot,
                onObservationError,
                onObservationComplete
        );
    }

    public void save() 
}
```

</Block>

```kotlin
class ObserveExampleKt 
        val observationStarted =
            Consumer 
        val onObservationError =
            Consumer 
        val onObservationComplete = Action 

        val options = ObserveQueryOptions()
        Amplify.DataStore.observeQuery(
            Post::class.java,
            options,
            observationStarted,
            onQuerySnapshot,
            onObservationError,
            onObservationComplete
        )
    }

    fun save() ,
                
            )
        }
    }
}
```

</Block>

```kotlin
// For coroutines, remember to `import com.amplifyframework.kotlin.core.Amplify`
// instead of `import com.amplifyframework.core.Amplify`
// and add "implementation 'com.amplifyframework:core-kotlin:0.20.0'"  to gradle dependencies

class ObserveExampleCoroutines 
                .catch 
                .onCompletion 
                .collect 
        }
    }

    fun save(lifecycleScope: LifecycleCoroutineScope) 
        }
    }
}
```

</Block>

```java
// Remember to import import com.amplifyframework.rx.RxAmplify;
// and add "implementation 'com.amplifyframework:rxbindings:1.36.1'" to gradle dependencies

public class ObserveExampleRx ,
                failure -> Log.d("MyAmplifyApp", "Observe failed"),
                () -> Log.d("", "Observe complete")
            );
    }

    public void save() 
}
```

</Block>
</BlockSwitcher>
