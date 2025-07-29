---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/predictions/android/getting-started/50_translate.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

Open `MainActivity.java` and add the following to the bottom of `onCreate()`:

```java
import android.util.Log;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.predictions.models.LanguageType;
```

```java
Amplify.Predictions.translateText(
  "I like to eat spaghetti",
  LanguageType.ENGLISH,
  LanguageType.SPANISH,
  result -> Log.i("MyAmplifyApp", result.getTranslatedText()),
  error -> Log.e("MyAmplifyApp", "Translation failed", error)
);
```

</Block>

Open `MainActivity.kt` and add the following to the bottom of `onCreate()`:

```kotlin
import android.util.Log
import com.amplifyframework.core.Amplify
import com.amplifyframework.predictions.models.LanguageType
```

```kotlin
Amplify.Predictions.translateText(
  "I like to eat spaghetti", LanguageType.ENGLISH, LanguageType.SPANISH,
  ,
  
)
```

</Block>

Open `MainActivity.kt` and add the following to the bottom of `onCreate()`:

```kotlin
import android.util.Log
import com.amplifyframework.kotlin.core.Amplify
import com.amplifyframework.predictions.models.LanguageType
```

```kotlin
val text = "I like to eat spaghetti"
try  catch (error: PredictionsException) 
```

</Block>

Open `MainActivity.java` and add the following to the bottom of `onCreate()`:

```java
import android.util.Log;
import com.amplifyframework.predictions.models.LanguageType;
import com.amplifyframework.rx.RxAmplify;
```

```java
RxAmplify.Predictions.translateText(
  "I like to eat spaghetti",
  LanguageType.ENGLISH,
  LanguageType.SPANISH)
  .subscribe(
    result -> Log.i("MyAmplifyApp", result.getTranslatedText()),
    error -> Log.e("MyAmplifyApp", "Translation failed", error)
  );
```

</Block>
</BlockSwitcher>

Next, build and run the application.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/predictions/android/getting-started/50_translate.mdx`