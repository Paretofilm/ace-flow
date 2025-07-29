---
title: Set up your backend
source: fragments/lib/predictions/android/label-image.mdx
---

# Set up your backend

The following APIs will enable you identify real world objects (chairs, desks, etc) in images.  These objects are referred to as "labels" from images.

## Set up your backend

Run `amplify add predictions`, then use the following answers:

```console
? Please select from one of the categories below (Use arrow keys)
  `Identify`
? What would you like to identify? (Use arrow keys)
  `Identify Labels`
? Provide a friendly name for your resource
  `labelObjects`
? Would you like use the default configuration? (Use arrow keys)
  `Default Configuration`
? Who should have access? (Use arrow keys)
  `Auth and Guest users`
```

The Advanced Configuration will allow you to select moderation for unsafe content or all of the identified labels. Default uses both.

Run `amplify push` to create the resources in the cloud.

## Working with the API

### Label objects in an image

You can identify real world objects such as chairs, desks, etc. which are referred to as “labels” by passing in `LabelType.LABELS` as the identify action. For example:

```java
public void detectLabels(Bitmap image) ,
    error -> Log.e("MyAmplifyApp", "Label detection failed", error)
  );
}
```

</Block>

```kotlin
fun detectLabels(image: Bitmap) ")
    },
    
  )
}
```

</Block>

```kotlin
suspend fun detectLabels(image: Bitmap) ")
  } catch (error: PredictionsException) 
}
```

</Block>

```java
public void detectLabels(Bitmap image) ,
      error -> Log.e("MyAmplifyApp", "Label detection failed", error)
    );
}
```

</Block>
</BlockSwitcher>

### Label moderation tag in an image

You can also detect whether identified content inside the image is safe by enabling moderation by passing in `LabelType.MODERATION_LABELS`.

```java
public void detectLabels(Bitmap image) ,
    error -> Log.e("MyAmplifyApp", "Identify failed", error)
  );
}
```

</Block>

```kotlin
fun detectLabels(image: Bitmap) ")
    },
    
  )
}
```

</Block>

```kotlin
suspend fun detectLabels(image: Bitmap)  catch (error: PredictionsException) 
}
```

</Block>
</BlockSwitcher>
