---
title: Upload Files
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/js/upload.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Upload Files

## Upload Files

The `Put` method uploads files into Amazon S3.

It returns a `` object on success:

```javascript
const result = await Storage.put('test.txt', 'Hello');
```

When a networking error happens during the upload, Storage module retries upload for a maximum of 4 attempts. If the upload fails after all retries, you will get an error.

### Public level

```javascript
const result = await Storage.put('test.txt', 'Hello');
```

### Protected level

```javascript
const result = await Storage.put('test.txt', 'Protected Content', );
```

### Private level

```javascript
const result = await Storage.put('test.txt', 'Private Content', );
```

### Monitor progress of upload

To track the progress of your upload, you can use the `progressCallback`:

```javascript
Storage.put('test.txt', 'File content', /$`);
  }
});
```

### Encrypted uploads

To utilize Server-Side Encryption with AWS KMS, the following options can be passed in with the Put API like so:

```javascript
const serverSideEncryption = AES256 | aws:kms;
const SSECustomerAlgorithm = 'string';
const SSECustomerKey = new Buffer('...') || 'string';
const SSECustomerKeyMD5 = 'string';
const SSEKMSKeyId = 'string';

const result = await Storage.put('test.txt', 'File content', );
```

Other options available are:

```javascript
Storage.put('test.txt', 'My Content', , // (map) A map of metadata to store with the object in S3.
  resumable: true, // (Boolean) Allows uploads to be paused and resumed
  useAccelerateEndpoint: true // If enabled on the bucket, use accelerated S3 endpoint
});
```

## Pause and resume uploads

Passing the `resumable: true` option to the Put API returns an object with the following methods: `pause` , `resume`. The `Storage.cancel` API is also available if you are looking to cancel the upload at any point of the upload.

```javascript
const upload = Storage.put(file.name, file, );

upload.pause();

upload.resume();

Storage.cancel(upload);
```

When a page refresh occurs during the upload, re-initializing the upload with the same file will continue from previous progress point.

```javascript
const upload = Storage.put(file.name, file, );

// This duplicate uploads will resume the original upload.
const duplicateUpload = Storage.put(file.name, file, );
```

> **Note**: 

Uploads that were initiated over one hour ago will be cancelled automatically. There are instances (e.g device went offline, user logs out) where the incomplete file remains in your S3 account. It is recommended to [setup a s3 lifecycle rule](https://aws.amazon.com/blogs/aws-cloud-financial-management/discovering-and-deleting-incomplete-multipart-uploads-to-lower-amazon-s3-costs/) to automatically cleanup incomplete upload requests.

### Event handlers

With the `resumable: true` flag, there are 3 callback functions available: `completeCallback`, `progressCallback` and `errorCallback`.

```javascript
const upload = Storage.put(file.name, file, `);
  },
  progressCallback: (progress) => /$`);
  },
  errorCallback: (err) => 
});
```

> **Note**: 

Currently, the `progressCallback` event is dependent and based on the number of parts that are sent to S3. Currently, the library uploads at about 5 MB per part. If you upload a file smaller than this, the event will not be fired.


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/js/upload.mdx`