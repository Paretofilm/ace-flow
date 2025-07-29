---
title: Documentation
topics: ['Authentication', 'Getting Started']
primary_topic: Authentication
source: fragments/lib/auth/ios/getting_started/15_preReq_web_ui.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, getting-started]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[Getting Started/]]
**Primary**: [[Authentication/]]

---


# Documentation

> **Note**: 

**Note:** Social sign-in (OAuth) functionality is only available in **iOS** and **macOS**.

 When configuring social sign-in through the Amplify CLI, it's important to exercise caution when designating attributes as "required." Different social identity providers have varied scopes in terms of the information they respond back to Cognito with.  User pool attributes that are initially set up as "required" cannot be changed later, and may require you to migrate the users or create a new user pool.  

An application with a minimum target of **iOS 13.0** and/or **macOS 10.15** with Amplify libraries integrated, using **Xcode 14.1** or later.

For a full example, please follow the [project setup walkthrough](/gen1/[platform]/start/project-setup/prerequisites/).

> **Note**: 

To use Auth in a macOS project, you'll need to enable the Keychain Sharing capability. In Xcode, navigate to **your application target** > **Signing & Capabilities** > **+ Capability**, then select **Keychain Sharing.**

This capability is required because Auth uses the Data Protection Keychain on macOS as a platform best practice.
See [TN3137: macOS keychain APIs and implementations](https://developer.apple.com/documentation/technotes/tn3137-on-mac-keychains) for more information on how Keychain works on macOS and the Keychain Sharing entitlement.

For more information on adding capabilities to your application, see [Xcode Capabilities](https://developer.apple.com/documentation/xcode/capabilities).


---

## 📚 Related Topics
- [[Authentication/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/auth/ios/getting_started/15_preReq_web_ui.mdx`