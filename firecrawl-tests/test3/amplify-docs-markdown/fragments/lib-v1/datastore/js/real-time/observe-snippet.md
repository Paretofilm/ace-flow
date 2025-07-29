---
title: Documentation
source: fragments/lib-v1/datastore/js/real-time/observe-snippet.mdx
---

# Documentation

```js
const subscription = DataStore.observe(Post).subscribe(msg => );
```

Observing changes of a single item by ID.

```js
const id = '69ddcb63-7e4a-4325-b84d-8592e6dac07b';

const subscription = DataStore.observe(Post, id).subscribe(msg => );
```

Closing a subscription:

```js
const subscription = DataStore.observe(Post, id).subscribe(msg => );

// Call unsubscribe to close the subscription
subscription.unsubscribe();
```

> **Note**: 

The `observe` function is asynchronous; however, you should not use `await` like the other DataStore API methods since it is a long running task and you should make it non-blocking (i.e. code after the `DataStore.observe()` call should not wait for its execution to finish).

> **Note**: 

`DataStore.clear()` will remove any active subscriptions. You'll need to re-establish them manually by calling `DataStore.observe()` again after you clear.
