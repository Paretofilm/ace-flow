---
title: Specify a bucket or copy across buckets / regions
source: pages/build-a-backend/storage/copy-files/index.mdx
---

# Specify a bucket or copy across buckets / regions

> **Note**: 

**Note:** You can only copy files up to 5GB in a single operation

You can copy an existing file to a different path within the storage bucket using the copy API.

The `copy` method duplicates an existing file to a designated path and returns an object `` upon successful completion.

```javascript

const copyFile = async () => `,
        // Alternatively, path: () => `album/$/$,
      destination: ) => `shared/$/#1.jpg`
      },
    });
  } catch (error) 
};
```
> **Note**: 

The operation can fail if there's a special character in the `source` path. You should URI encode the source
path with special character. You **don't** need to encode the `destination` path.

> **Note**: 

Cross identity ID copying is only allowed if the destination path has the the right access rules to allow other authenticated users writing to it.

## Specify a bucket or copy across buckets / regions

You can also perform an `copy` operation to a specific bucket by providing the `bucket` option. This option can either be a string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.

```javascript

const copyFile = async () => ,
      destination: ,
        expectedBucketOwner: '123456789013'
      }
    });
  } catch (error) 
};
```

> **Note**: 
In order to copy to or from a bucket other than your default, both source and destination must have `bucket` explicitly defined.

## Copy `source` and `destination` options

Option | Type | Default | Description |
| -- | :--: | :--: | ----------- |
| path | string \| <br/>(\) => string | Required | A string or callback that represents the path in source and destination bucket to copy the object to or from. <br /> **Each segment of the path in `source` must by URI encoded.** |
| bucket | string \| <br />\ | Default bucket and region from Amplify configuration | A string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets). |
| eTag | string | Optional | The copy **source object** entity tag (ETag) value. Only Copies the object if its ETag matches the specified tag. |
| notModifiedSince | Date | Optional | Copies the **source object** if it hasn't been modified since the specified time.  <br /><br/> **This is evaluated only when `eTag` is NOT supplied**|
| expectedBucketOwner | string | Optional | `source.expectedBucketOwner`: The account ID that owns the source bucket. <br /><br /> `destination.expectedBucketOwner`: The account ID that owns the destination bucket. |

</InlineFilter>

User who initiates a copy operation should have read permission on the copy source file.

```dart
Future<void> copy() async ');
  } on StorageException catch (e) 
}
```
## Specify a bucket or copy across buckets / regions

You can also perform a `copy` operation to a specific bucket by providing the `CopyBuckets` option. 
This option is an object that takes two `StorageBucket` parameters, which can be constructed by the specified name in the Amplify Backend, or the bucket name and region from the console.

```dart
final mainBucket = StorageBucket.fromOutputs(
  'mainBucket',
);
final bucket2 = StorageBucket.fromBucketInfo(
  BucketInfo(
    bucketName: 'second-bucket-name-from-console',
    region: 'us-east-2',
  ),
),
try ');
} on StorageException catch (e) 
```

> **Note**: 
In order to copy to or from a bucket other than your default, the source and/or destination paths must exist in that bucket

## `copy` options

Option | Type | Description |
| -- | -- | ----------- |
| getProperties | boolean | Whether to retrieve properties for the copied object using theAmplify.Storage.getProperties() after the operation completes. When set to true the returned item will contain additional info such as metadata and content type. |
| buckets | CopyBuckets | An object that accepts two `StorageBucket` parameters. To copy to and from the same bucket, use the `CopyBuckets.sameBucket(targetBucket)` method, where `targetBucket` is a `StorageBucket`. Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets)|

Example of `copy` with options:

```dart
final result = Amplify.Storage.copy(
  source: const StoragePath.fromString('album/2024/1.jpg'),
  destination: const StoragePath.fromString('shared/2024/1.jpg'),
  options: const StorageCopyOptions(
    pluginOptions: S3CopyPluginOptions(
      getProperties: true,
    ),
    buckets: CopyBuckets.sameBucket(
      StorageBucket.fromOutputs('secondBucket'),
    ),
  ),
);
```

</InlineFilter>
