---
title: Set up the backend
topics: ['General']
primary_topic: General
source: fragments/lib-v1/predictions/ios/text-speech.mdx
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

If you haven't already done so, run `amplify init` inside your project and then `amplify add auth` (we recommend selecting the *default configuration*).

Run `amplify add predictions`, then use the following answers:

```console
? Please select from one of the categories below
  Identify
❯ Convert
  Interpret
  Infer
  Learn More
  
? What would you like to convert?
  Translate text into a different language
❯ Generate speech audio from text
  Transcribe text from audio

? Provide a friendly name for your resource

? What is the source language? (Use arrow keys)

? Select a speaker (Use arrow keys)

? Who should have access?
  Auth users only
❯ Auth and Guest users
```

Run `amplify push` to create the resources in the cloud

## Working with the API

Here is an example of converting text to speech. In order to override any choices you made while adding this resource using the Amplify CLI, you can pass in a voice in the options object as shown below.

```swift
import Amplify
import AWSPredictionsPlugin
import AVFoundation

//...

var player: AVAudioPlayer?

//...

func textToSpeech(text: String) 
        case let .failure(error):
            print(error)
        }
    }
}
```

</Block>

```swift
import Amplify
import AWSPredictionsPlugin
import AVFoundation

//...

var player: AVAudioPlayer?
var textToSpeechSink: AnyCancellable?

//...

func textToSpeech(text: String) 
        }
        receiveValue: 
        }
}
```

</Block>

</BlockSwitcher>

As a result of running this code, you will hear audio of the text being emitted from your device.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/predictions/ios/text-speech.mdx`