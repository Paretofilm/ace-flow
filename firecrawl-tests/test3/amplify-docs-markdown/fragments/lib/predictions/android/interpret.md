---
title: Set up your backend
source: fragments/lib/predictions/android/interpret.mdx
---

# Set up your backend

The following API allows you to analyze text for language, entities (places, people), key phrases, sentiment (positive, neutral, negative), and syntax (pronouns, verbs, adjectives).

## Set up your backend

Run `amplify add predictions`, then use the following answers:

```console
? Please select from one of the categories below (Use arrow keys)
  `Interpret`
? What would you like to interpret? (Use arrow keys)
  `Interpret Text`
? Provide a friendly name for your resource
  `interpretText`
? What kind of interpretation would you like? (Use arrow keys)
  `All`
? Who should have access? (Use arrow keys)
  `Auth and Guest users`
```

Run `amplify push` to create the resources in the cloud.

## Working with the API

Here is an example of sending text for interpretation such as sentiment analysis or natural language characteristics.

```java
Amplify.Predictions.interpret(
  "I like to eat spaghetti",
  result -> Log.i("MyAmplifyApp", result.getSentiment().getValue().toString()),
  error -> Log.e("MyAmplifyApp", "Interpret failed", error)
);
```

</Block>

```kotlin
Amplify.Predictions.interpret("I like to eat spaghetti",
  ") },
  
)
```

</Block>

```kotlin
val text = "I like to eat spaghetti"
try ")
} catch (error: PredictionsException) 
```

</Block>

```java
RxAmplify.Predictions.interpret("I like to eat spaghetti")
  .subscribe(
    result -> Log.i("MyAmplifyApp", result.getSentiment().getValue().toString()),
    error -> Log.e("MyAmplifyApp", "Interpret failed", error)
  );
```

</Block>
</BlockSwitcher>

As a result of running this code, you will see the sentiment of the text printed to the console.

```console
I/MyAmplifyApp: POSITIVE
```
