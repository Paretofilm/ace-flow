---
title: Set up the backend
topics: ['General']
primary_topic: General
source: fragments/lib-v1/predictions/android/text-speech.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Set up the backend

## Set up the backend

Run `amplify add predictions`, then use the following answers:

```console
? Please select from one of the categories below
  `Convert`
? What would you like to convert? (Use arrow keys)
  `Generate speech audio from text`
? Provide a friendly name for your resource
  `speechGenerator`
? What is the source language? (Use arrow keys)
  `US English`
? Select a speaker (Use arrow keys)
  `Joanna - Female`
? Who should have access? (Use arrow keys)
  `Auth and Guest users`
```

Run `amplify push` to create the resources in the cloud.

## Working with the API

Open `MainActivity.java` and add the following code:

```java
private final MediaPlayer mp = new MediaPlayer();

@Override
protected void onCreate(Bundle savedInstanceState) 

private void playAudio(InputStream data) 
        mp.reset();
        mp.setOnPreparedListener(MediaPlayer::start);
        mp.setDataSource(new FileInputStream(mp3File).getFD());
        mp.prepareAsync();
    } catch (IOException error) 
}
```

</Block>

Open `MainActivity.kt` and add the following code:

```kotlin
private val mp = MediaPlayer()

override fun onCreate(savedInstanceState: Bundle?) 

private fun convertTextToSpeech() ,
        
    )
}

private fun playAudio(data: InputStream)  != -1) 
            mp.reset()
            mp.setOnPreparedListener 
            mp.setDataSource(FileInputStream(mp3File).fd)
            mp.prepareAsync()
        }
    } catch (error: IOException) 
}
```

</Block>

Open `MainActivity.kt` and add the following code:

```kotlin
private val mp = MediaPlayer()

override fun onCreate(savedInstanceState: Bundle?) 

private fun convertTextToSpeech() = activityScope.launch  catch (error: PredictionsException) 
}

private fun playAudio(data: InputStream)  != -1) 
            mp.reset()
            mp.setOnPreparedListener 
            mp.setDataSource(FileInputStream(mp3File).fd)
            mp.prepareAsync()
        }
    } catch (error: IOException) 
}
```

</Block>

Open `MainActivity.java` and add the following code:

```java
private final MediaPlayer mp = new MediaPlayer();

@Override
protected void onCreate(Bundle savedInstanceState) 

private void playAudio(InputStream data) 
        mp.reset();
        mp.setOnPreparedListener(MediaPlayer::start);
        mp.setDataSource(new FileInputStream(mp3File).getFD());
        mp.prepareAsync();
    } catch (IOException error) 
}
```

</Block>
</BlockSwitcher>

This example works on all supported versions of Android. Android API 23 added support for [`MediaDataSource`](https://developer.android.com/reference/android/media/MediaDataSource), which allows for `InputStream` from Amplify to be read directly without writing to a file.

As a result of running this code, you will hear audio of the text being emitted from your device.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/predictions/android/text-speech.mdx`