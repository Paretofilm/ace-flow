---
title: Copy files within the same access levels
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/js/copy.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Copy files within the same access levels

`Storage.copy` method copies an existing file to a different key and returns a `` object upon
success.

> **Note**: 

`Storage.copy` can copy an object up to 5 GB in a single operation.

To copy a file, you need to provide a source key `src` and a destination key `dest`

```typescript
await Storage.copy(
	src: ,
	dest: , 
	config?: 
)
```

In addition, you can configure advanced capabilities such as cache control, meta data, and more.

```typescript
await Storage.copy(, , )
```

## Copy files within the same access levels

You can copy a file from the specified key to another key within the same [File Access Level](/gen1/[platform]/build-a-backend/storage/configure-access/) (Defaults to 'public').

```typescript
console.log(await Storage.list('copied/')); // []

// Copies 'existing/srcKey' to 'copied/destKey' within the 'public' access level
const copied = await Storage.copy(, );

// There should now be a new file with key "copied/destKey"
console.log(await Storage.list('copied/')); // [  ]
console.log(copied); // 
```

## Copy files across access levels

To copy file across different access levels, you'll need to explicitly provide the source and destination access levels:

```typescript
console.log(await Storage.list('copied/', )); // []

// Copies 'existing/srcKey' to 'copied/destKey' from 'public' to 'private'
const copied = await Storage.copy(
	, 
	
);

// There should now be a new file with key "copied/destKey" in the 'private' level
console.log(await Storage.list('copied/', )); // [  ]
console.log(copied); // 
```

## Copy protected files from another user

You can also copy a protected file from another user by providing their identity id

```typescript
console.log(await Storage.list('copied/', )); // []

// Copies 'existing/srcKey' to 'copied/destKey' from 'protected' of another identity ID to 'private' of the current
// authenticated user

const copied = await Storage.copy(
	,
	,
)

// There should now be a new file with key "copied/destKey"
console.log(await Storage.list('copied/', )); // [..., key: 'copied/destKey']
console.log(copied); // 
```

> **Note**: 

Cross identity ID copying is only allowed if the source object's access level is set to 'protected'.

## How to enable encrypted file copy

To utilize Server-Side Encryption with AWS KMS, the following options can be passed in to `Storage.copy`:

```javascript
const serverSideEncryption = AES256 | aws:kms;
const SSECustomerAlgorithm = 'string';
const SSECustomerKey = new Buffer('...') || 'string';
const SSECustomerKeyMD5 = 'string';
const SSEKMSKeyId = 'string';

const result = await Storage.copy(, , );
```


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/js/copy.mdx`