---
title: Get
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/js/download.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Get

## Get

Get a presigned URL of a stored file. You can specify some options: mainly [file access `level`](/gen1/[platform]/build-a-backend/storage/configure-access/) and whether to `download` the file:

```typescript
await Storage.get(key: string, config: );
```

`Storage.get` returns a signed URL `string` to your file if `download` is false, which is the default. You can use this to create a download link for users to click on. Note that this function **does not check if the file exists by default**. You can enable this check by setting `validateObjectExistence` to `true`.

> Note: Currently, the expiration time of the presigned url is dependent on the session and will max out at 1 hour.

```js
// get the signed URL string
const signedURL = await Storage.get(key); // get key from Storage.list

// inside your template or JSX code. Note <a download> doesn't work here because it is not same origin
<a href= target="_blank" rel="noreferrer">
  
</a>;
```

### Check for existence of a file

You can check for the existence of a file in the storage category's `get` API using the `validateObjectExistence` option. When this flag is enabled a `get` call will return a pre-signed URL if the file exists and raise a `404` error if it does not. This allows you to check if an object exists during generating the presigned URL, which you can then use to download that object.

```javascript
// To check for existence of a file
await Storage.get('filename.txt', );
```

If `download` is true, `Storage.get` returns an object with a `Body` field of type [`Blob`](https://developer.mozilla.org/en-US/docs/Web/API/Blob). It is up to you to programmatically save it to disk (we suggest a method below) or do whatever else you need with it.

### File download option

The `download` option send you the object data for download or programmatic manipulation:

```javascript
const result = await Storage.get(`filename.txt`, );

// data.Body is a Blob
result.Body.text().then((string) => );
```

You can programmatically download Blobs using JavaScript:

```js

// usage
async function download() );
  downloadBlob(result.Body, 'filename');
}
```
</InlineFilter>

The full return signature of `Storage.get(key, )` looks like this:

```js

    httpStatusCode: 200
    requestId: undefined
    totalRetryDelay: 0
  },
  Body: Blob , // this will vary
  ContentLength: 388187,
  ContentType: "audio/x-m4a",
  ETag: ""c05e324f61613c2472d47a8ee6fbb628"",
  LastModified: Fri Oct 09 2020 22:29:13 GMT+0800 (Singapore Standard Time) ,
  Metadata: ,
  __type: "GetObjectOutput",
}
```

### Monitor progress of download

To track the progress of your download, you can use `progressCallback`:

```javascript
Storage.get('filename.txt', /$`);
  }
});
```

### File Access Levels

You can choose to configure access level ahead of time, or at the point of calling `Storage.get`:

```javascript
// Option 1: configure access ahead of time
Storage.configure();
const result = await Storage.get('welcome.png'); // Gets the welcome.png belonging to current user

// Option 2: configure access inside the call
const result = await Storage.get('welcome.png', ); // same effect
```

Here is a quick guide to the access levels - [see the docs](/gen1/[platform]/build-a-backend/storage/configure-access/) for more detail:

- `public`: Accessible by all users of your app. Files are stored under the `public/` path in your S3 bucket.
- `protected`: Readable by all users, but writable only by the creating user. Files are stored under `protected//` where the `user_identity_id` corresponds to the unique Amazon Cognito Identity ID for that user.

```javascript
// To get current user's objects
const result = await Storage.get('filename.txt', );

// To get other users' objects
const result = await Storage.get('filename.txt', );
```

- `private`: **Only accessible for the signed in user**. Files are stored under `private//` where the `user_identity_id` corresponds to the unique Amazon Cognito Identity ID for that user.

### Download expiry

You can use `expires` option to limit the availability of your URLs. This configuration returns the pre-signed URL that expires in 60 seconds:

```javascript
await Storage.get('filename.txt', );
```

### Frequently Asked Questions

Users can run into unexpected issues, so we are giving you advance notice in documentation with links to open issues - please vote for what you need, to help the team prioritize.

- `Storage.get` is cached; if you have recently modified a file you may not get the latest version right away. You can pass in `cacheControl: 'no-cache'` to get the latest version.
- `Storage.get` only returns the latest cached version of the file; there is [not yet an API to view prior versions](https://github.com/aws-amplify/amplify-js/issues/2131).
- [Image compression](https://github.com/aws-amplify/amplify-js/issues/6081) or CloudFront CDN caching for your S3 buckets is not yet possible.
- There is no API for [Cognito Group-based access to files](https://github.com/aws-amplify/amplify-js/issues/3388).
- There is currently [no API for getting the identityId of other users](https://github.com/aws-amplify/amplify-js/issues/5177); you have to retrieve this from elsewhere before calling `Storage.get`.


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/js/download.mdx`