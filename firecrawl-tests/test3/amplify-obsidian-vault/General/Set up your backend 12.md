---
title: Set up your backend
topics: ['General']
primary_topic: General
source: fragments/lib/predictions/android/identify-text.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Set up your backend

The following APIs will allow you to identify text (words, tables, pages from a book) from an image.

## Set up your backend

Run `amplify add predictions`, then use the following answers:

```console
? Please select from one of the categories below (Use arrow keys)
  `Identify`
? What would you like to identify? (Use arrow keys)
  `Identify Text`
? Provide a friendly name for your resource
  `identifyText`
? Would you also like to identify documents? (y/N)
  `Y`
? Who should have access? (Use arrow keys)
  `Auth and Guest users`
```

Run `amplify push` to create the resources in the cloud.

## Working with the API

### Detect text in an image

Amplify will make calls to both Amazon Textract and Amazon Rekognition depending on the type of text you are looking to identify (i.e. image or document).

Passing in `TextFormatType.PLAIN` as the identify action will yield `IdentifyResult`, which must be cast into `IdentifyTextResult`. See below for an example of plain text detection from an image.

```java
public void detectText(Bitmap image) ,
    error -> Log.e("MyAmplifyApp", "Identify text failed", error)
  );
}
```

</Block>

```kotlin
fun detectText(image: Bitmap) ,
    
  )
}
```

</Block>

```kotlin
suspend fun detectText(image: Bitmap)  catch (error: PredictionsResult) 
}
```

</Block>

```java
public void detectText(Bitmap image) ,
      error -> Log.e("MyAmplifyApp", "Identify text failed", error)
    );
}
```

</Block>
</BlockSwitcher>

### Detect text in a document

Passing in any other format of `TextFormatType` (i.e. `FORM`, `TABLE` or `ALL`) will yield `IdentifyResult`, which must be cast into `IdentifyDocumentTextResult`. See below for an example with `TextFormatType.FORM` for detecting forms from a document.

```java
public void detectText(Bitmap image) ,
    error -> Log.e("MyAmplifyApp", "Identify failed", error)
  );
}
```

</Block>

```kotlin
fun detectText(image: Bitmap) ,
    
  )
}
```

</Block>

```kotlin
suspend fun detectText(image: Bitmap)  catch (error: PredictionsException) 
}
```

</Block>

```java
public void detectText(Bitmap image) ,
      error -> Log.e("MyAmplifyApp", "Identify failed", error)
    );
}
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/predictions/android/identify-text.mdx`