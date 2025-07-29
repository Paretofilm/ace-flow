---
title: Documentation
source: fragments/lib-v1/utilities/android/hub/10_listen_start.mdx
---

# Documentation

`Hub.subscribe(HubChannel hubChannel, HubSubscriber hubSubscriber)` is used to listen for messages that have been dispatched. Additionally, you can pass a `HubEventFilter` in the overloaded `subscribe` method to further filter Hub events. You can add multiple listeners to your application for different combinations of channels/filters to listen for.
