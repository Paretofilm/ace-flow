---
title: Schema Setup
source: fragments/sdk/storage/android/graphql-api.mdx
---

# Schema Setup

Note: Please review the documentation for [API](/gen1/[platform]/sdk/api/graphql/) before you proceed with the rest of this section. 

You can also upload and download Amazon S3 Objects using AWS AppSync, a GraphQL based solution to build data-driven apps with real-time and offline capabilities. Sometimes you might want to create logical objects that have more complex data, such as images or videos, as part of their structure.  _For example, you might create a Person type with a profile picture or a Post type that has an associated image_. You can use AWS AppSync to model these as GraphQL types. If any of your mutations have a variable with bucket, key, region, mimeType, and localUri fields, the SDK uploads the file to Amazon S3 for you.

Attach the following policy to your IAM role to grant it programmatic read-write access to your bucket:

```
,
    
  ]
}
```

## Schema Setup
If any mutations have an input type `S3ObjectInput` with fields `bucket`, `key`, `region`, `mimeType` and `localUri` fields, the SDK will upload the file to S3.
```
  input S3ObjectInput 
```
For example, to add a photo field in the ``Post`` type. Update ``Post`` type, add the new ``S3ObjectInput`` type and add a new mutation, ``putPostWithPhoto``.
```
  type Mutation 
  type S3Object 
  input S3ObjectInput 
  type Post 
```
Next, update the putPostWithPhoto mutation resolver to use ``PutItemWithS3Object`` template for request mapping
and ``Return single item`` for response mapping from the AppSync console.
Next, update the response mapping template for the ``photo`` field.
```
$util.toJson($util.dynamodb.fromS3ObjectJson($context.source.file))
```
## Client Code
To use complex objects, you need AWS Identity and Access Management credentials for reading and writing to Amazon S3.
These can be separate from the other authentication credentials used in the AWS AppSync client.
Credentials for complex objects are set in the `S3ObjectManagerImplementation` builder parameter, which you can use like the following:
```java
public class ClientFactory 
      return client;
    }
    // Copy the below two methods and add the .s3ObjectManager builder parameter
    // initialize and fetch the S3 Client
    public static final S3ObjectManagerImplementation getS3ObjectManager(final Context context) 
      return s3ObjectManager;
    }
    // initialize and fetch cognito credentials provider for S3 Object Manager
    public static final AWSCredentialsProvider getCredentialsProvider(final Context context)
}
```
The SDK uploads the file found at the ``localUri`` when the bucket, key, region, localUri, and mimeType are all provided.
Now, the SDK uploads any field which has ``S3ObjectInput`` type in the mutation. The only requirement from a developer is to provide the correct bucket, key, region, localUri, and mimeType.
Example:
Add the following permissions to ``AndroidManifest.xml``:
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```
Then, in your activity where you are adding a post, update the code as follows:
```java
public class AddPostActivity extends AppCompatActivity 
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) ;
            Cursor cursor = getContentResolver().query(selectedImage,
                    filePathColumn, null, null, null);
            cursor.moveToFirst();
            int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
            String picturePath = cursor.getString(columnIndex);
            cursor.close();
            // String picturePath contains the path of selected Image
            photoPath = picturePath;
        }
    }
    // Actual mutation code
    private void save() 
    // Mutation callback code
    private GraphQLCall.Callback postsCallback = new GraphQLCall.Callback() 
            });
        }
        @Override
        public void onFailure(@Nonnull final ApolloException e) 
            });
        }
    };
}
```
