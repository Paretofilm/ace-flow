---
title: Protected access
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/native_common/configureaccess/common.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Protected access

When adding the Storage category, you configure the level of access users have to your S3 bucket. You can configure separate rules for authenticated vs. guest users. When using the Storage category to upload files, you can also specify an access level for each individual file: guest, protected, or private.

- **Guest** Accessible by all users of your application
- **Protected** Readable by all users, but only writable by the creating user
- **Private** Readable and writable only by the creating user

Guest access does **not** mean that your files are totally public. A "guest" is a user of your application who has not yet signed in. To enable access at this level, you will still be required to configured [Authentication](/gen1/[platform]/prev/build-a-backend/auth/set-up-auth/) in your app. The user must be able to assume an unauthenticated role from your Cognito Identity Pool.

For protected and private access, the `[IDENTITY_ID]` below corresponds to the unique ID of the user. Once the user has signed in, the `[IDENTITY_ID]` can be retrieved from the session by accessing the identity id. See [Accessing credentials](/gen1/[platform]/prev/build-a-backend/auth/accessing-credentials/) to retrieve the identity id, and use this as the unique ID of the authenticated user.

> **Note**: 

The default access level for the Storage category is **guest**. Unless you specify otherwise, all uploaded files will be available to all users of your application. This means that a user who is using your application but has not signed in will have access. Anyone else who is not using your application will _not_ be able to access your files.

## Protected access

After the user has signed in, create an options object specifying the `protected` access level to allow other users to read the object:

This will upload with the prefix `/protected/[IDENTITY_ID]/` followed by the `key`.

For other users to read the file, you must specify the access level as `protected` and the identity ID of the user who uploaded it in the options.

## Private Access

Create an options object specifying the private access level to only allow an object to be accessed by the creating user

This will upload with the prefix `/private/[IDENTITY_ID]/`, followed by the `key`.

For the user to read the file, specify the same access level (`private`) and key you used to upload:

## Customization

### Customize Object Key Path

You can customize your key path by defining a prefix resolver:

```dart
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

// Define your own prefix resolver, which implements the `S3PrefixResolver`.
class MyPrefixResolver implements S3PrefixResolver ) async 

    final String accessLevelPrefix;

    if (accessLevel == StorageAccessLevel.protected)  else 

    final targetIdentityId = identityId ?? await getCurrentUserIdentityId();

    return '$accessLevelPrefix$targetIdentityId/';
  }

  Future getCurrentUserIdentityId() async 
}
```

Then, configure the Storage plugin with your custom prefix resolver:

```dart
final storagePlugin = AmplifyStorageS3(
  prefixResolver: const MyPrefixResolver(),
);
...
await Amplify.addPlugin(storagePlugin);
```

Add the IAM policy that corresponds with the prefixes defined above to enable read, write and delete operation for all the objects under path _myPublicPrefix/_:

```json

  ]
}
```

If you want to have custom _private_ path prefix like `myPrivatePrefix/`, you need to add it into your IAM policy:

```json
/*"
      ]
    }
  ]
}
```

## Passthrough PrefixResolver

If you would like no prefix resolution logic, such as performing S3 requests at the root of the bucket, you can use the `PassThroughPrefixResolver` provided by the `amplify_storage_s3` package.

```dart
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

final storagePlugin = AmplifyStorageS3(
  prefixResolver: const PassThroughPrefixResolver(),
);

await Amplify.addPlugin(storagePlugin);
```

</InlineFilter>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/native_common/configureaccess/common.mdx`