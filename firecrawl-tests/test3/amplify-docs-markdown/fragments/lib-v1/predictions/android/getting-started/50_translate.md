---
title: Documentation
source: fragments/lib-v1/predictions/android/getting-started/50_translate.mdx
---

# Documentation

Open `MainActivity.java` and add the following to the bottom of `onCreate()`:

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
Amplify.Predictions.translateText(
    "I like to eat spaghetti", LanguageType.ENGLISH, LanguageType.SPANISH,

)
```

</Block>

Open `MainActivity.kt` and add the following to the bottom of `onCreate()`:

```kotlin
val text = "I like to eat spaghetti"
try  catch (error: PredictionsException) 
```

</Block>

Open `MainActivity.java` and add the following to the bottom of `onCreate()`:

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
