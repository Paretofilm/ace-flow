---
title: Set up the backend
source: fragments/lib/predictions/ios/transcribe.mdx
---

# Set up the backend

## Set up the backend

If you haven't already done so, run `amplify init` inside your project and then `amplify add auth` (we recommend selecting the *default configuration*).

Run `amplify add predictions` and select **Convert**. Then use the following answers:

```console
? What would you like to convert?
  Translate text into a different language
  Generate speech audio from text
❯ Transcribe text from audio

? Provide a friendly name for your resource

? What is the source language? (Use arrow keys)

? Who should have access?
  Auth users only
❯ Auth and Guest users
```

## Working with the API

Here is an example of converting speech to text. In order to override any choices you made while adding this resource using the Amplify CLI, you can pass in a language in the options object as shown below.

```swift
func speechToText(url: URL) async throws 
}
```
