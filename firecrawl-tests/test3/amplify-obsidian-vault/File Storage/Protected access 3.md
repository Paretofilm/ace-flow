---
title: Protected access
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/native_common/configureaccess/common.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Protected access

> **Note**: 
    The latest version of Amplify Storage supports specifying S3 objects as a paths.
    We recommend using the new [StoragePath](/gen1/[platform]/build-a-backend/storage/storagepath/) when defining file access permissions as it offers a more flexible approach to customize access to files.
    
    A summary of Amplify-generated resources with associated IAM policy and path structure can be referenced [here](/gen1/[platform]/build-a-backend/storage/modify-amplify-generated-resources/#customize-amplify-generated-s3-resources).
    
    Note: `accessLevel` parameter is deprecated and may be removed in next major version.
    
</InlineFilter>
When adding the Storage category, you configure the level of access users have to your S3 bucket. You can configure separate rules for authenticated vs. guest users. When using the Storage category to upload files, you can also specify an access level for each individual file: guest, protected, or private.

- **Guest** Accessible by all users of your application
- **Protected** Readable by all users (you need to specify the identityID of the user who uploaded the file). Writable only by the creating user
- **Private** Readable and writable only by the creating user

Guest access does **not** mean that your files are totally public. A "guest" is a user of your application who has not yet signed in. To enable access at this level, you will still be required to configured [Authentication](/gen1/[platform]/build-a-backend/auth/set-up-auth/) in your app. The user must be able to assume an unauthenticated role from your Cognito Identity Pool.

For protected and private access, the `[IDENTITY_ID]` below corresponds to the unique ID of the user. Once the user has signed in, the `[IDENTITY_ID]` can be retrieved from the session by accessing the identity id. See [Accessing credentials](/gen1/[platform]/build-a-backend/auth/accessing-credentials/) to retrieve the identity id, and use this as the unique ID of the authenticated user.

> **Note**: 

The default access level for the Storage category is **guest**. Unless you specify otherwise, all uploaded files will be available to all users of your application. This means that a user who is using your application but has not signed in will have access. Anyone else who is not using your application will _not_ be able to access your files.

## Protected access

After the user has signed in, create an options object specifying the `protected` access level to allow other users to read the object:

This will upload with the prefix `/protected/[IDENTITY_ID]/` followed by the `key`.

For other users to read the file, you must specify the access level as `protected` and the identity ID of the user who uploaded it in the options.

## Private Access

Create an options object specifying the private access level to only allow an object to be accessed by the uploading user

This will upload with the prefix `/private/[IDENTITY_ID]/`, followed by the `key`.

For the uploading user to read the file, specify the same access level (`private`) and key you used to upload:


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib/storage/native_common/configureaccess/common.mdx`