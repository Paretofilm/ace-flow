---
title: Documentation
source: fragments/guides/api-graphql/android/subscriptions-by-id.mdx
---

# Documentation

```java
private GraphQLRequest onCreateCommentByPostId(String id) "
    + "}";
    return new SimpleGraphQLRequest<>(
        document,
        Collections.singletonMap("id", id),
        Comment.class,
        new GsonVariablesSerializer()
    );
}
```

</Block>

```kotlin
private fun onCreateCommentByPostId(id: String): GraphQLRequest id: ID!) id) 
         }
    """.trimIndent()
    return SimpleGraphQLRequest(
        document,
        mapOf("id" to id),
        Comment::class.java,
        GsonVariablesSerializer()
    )
}
```

</Block>
</BlockSwitcher>

To listen to creation updates with the specific post using the post id, you can use the following code sample:

```java
private void createSubscription()  else if(!response.hasData())  else 
        },
        failure -> Log.e("MyAmplifyApp", "Subscription terminated with error.", failure),
        () -> Log.d("MyAmplifyApp", "Subscription has been closed successfully.")
    );
}
```

</Block>

```kotlin
private suspend fun createSubscription() 
            .collect ")
                } else if (!response.hasData())  else ")
                }
            }
    } catch (error: ApiException) 
}
```

</Block>

```java
private void createSubscription()  else if (!response.hasData())  else 
            },
            failure -> Log.e("MyAmplifyApp", "Subscription failed", failure),
            () -> Log.i("MyAmplifyApp", "Subscription completed.")
        );
    // Cancel the subscription listener when you're finished with it
    subscription.cancel();
}
}
```

</Block>
</BlockSwitcher>
