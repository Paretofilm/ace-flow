---
title: Track all the Storage events
source: fragments/lib-v1/storage/js/autotrack.mdx
---

# Track all the Storage events

You can enable automatic tracking of Storage Events such as uploads and downloads, by setting `` when calling the Storage API.

> **Note**: 
  This option is currently only supported in Amplify JavaScript. Enabling this
  will automatically send Storage Events to Amazon Pinpoint and you will be able
  to see them within the AWS Pinpoint Console under Custom Events. The event
  name will be 'Storage' and in *Event Attributes*, you can see details about
  the event, e.g. *Storage  Method  Put*.

## Track all the Storage events

```javascript
Storage.configure();
```

## Track a specific storage action

```javascript
Storage.get('welcome.png', );
```
