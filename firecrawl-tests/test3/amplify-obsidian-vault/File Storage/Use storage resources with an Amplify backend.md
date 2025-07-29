---
title: Use storage resources with an Amplify backend
topics: ['File Storage']
primary_topic: File Storage
source: pages/build-a-backend/storage/use-with-custom-s3/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Use storage resources with an Amplify backend

With Amplify Storage APIs, you can use your own S3 buckets instead of the Amplify-created ones.

> **Note**: 
**Important:** To utilize the storage APIs with an S3 bucket outside of Amplify, you must have Amplify Auth configured in your project.

## Use storage resources with an Amplify backend

### Add necessary permissions to the S3 bucket

For the specific Amazon S3 bucket that you want to use with these APIs, you need to make sure that the associated IAM role has the necessary permissions to read and write data to that bucket.

To do this, go to **Amazon S3 console** > **Select the S3 bucket** > **Permissions** > **Edit** Bucket Policy.

![Showing Amplify console showing Storage tab selected](/images/gen2/storage/s3-console-permissions.png)

The policy will look something like this:

```json
,
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::<bucket-name>",
        "arn:aws:s3:::<bucket-name>/*"
      ]
    }
  ]
}
```
Replace `` with your AWS account ID and `<role-name>` with the IAM role associated with your Amplify Auth setup. Replace `<bucket-name>` with the S3 bucket name.

You can refer to [Amazon S3's Policies and Permissions documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-policy-language-overview.html) for more ways to customize access to the bucket.

> **Note**: 
In order to make calls to your manually configured S3 bucket from your application, you must also set up a [CORS Policy](/[platform]/build-a-backend/storage/extend-s3-resources/#for-manually-configured-s3-resources) for the bucket. 

### Specify the S3 bucket in Amplify's backend config

Next, use the `addOutput` method from the backend definition object to define a custom S3 bucket by specifying the name and region of the bucket in your `amplify/backend.ts` file. You must also set up the appropriate resources and IAM policies to be attached to the backend.

> **Note**: 
**Important:** You can use a storage backend configured through Amplify and a custom S3 bucket at the same time using this method. However, the Amplify-configured storage will be used as the **default bucket** and the custom S3 bucket will only be used as an additional bucket.

#### Configure the S3 bucket

Below are several examples of configuring the backend to define a custom S3 bucket:

Below is an example of expanding the original backend object to grant all guest (i.e. not signed in) users read access to files under `public/`:

```ts title="amplify/backend.ts"

const backend = defineBackend();
// highlight-start
const customBucketStack = backend.createStack("custom-bucket-stack");

// Import existing bucket
const customBucket = Bucket.fromBucketAttributes(customBucketStack, "MyCustomBucket", );

backend.addOutput(,
        },
      }
    ]
  },
});

/*
  Define an inline policy to attach to Amplify's unauth role
  This policy defines how unauthenticated/guest users can access your existing bucket
*/ 
const unauthPolicy = new Policy(backend.stack, "customBucketUnauthPolicy", /public/*`],
    }),
    new PolicyStatement(`,
        `$/*`
      ],
      conditions: ,
      },
    }),
  ],
});

// Add the policies to the unauthenticated user role
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(
  unauthPolicy,
);
// highlight-end
```
</Block>

Below is an example of expanding the original backend object to grant all authenticated (i.e. signed in) users with full access to files under `public/`:
```ts title="amplify/backend.ts"

const backend = defineBackend();

const customBucketStack = backend.createStack("custom-bucket-stack");

// Import existing bucket
const customBucket = Bucket.fromBucketAttributes(customBucketStack, "MyCustomBucket", );

backend.addOutput(,
        },
      }
    ]
  },
});

// ... Unauthenticated/guest user policies and role attachments go here ...
// highlight-start
/*
  Define an inline policy to attach to Amplify's auth role
  This policy defines how authenticated users can access your existing bucket
*/ 
const authPolicy = new Policy(backend.stack, "customBucketAuthPolicy", /public/*`,],
    }),
    new PolicyStatement(`,
        `$/*`
        ],
      conditions: ,
      },
    }),
  ],
});

// Add the policies to the authenticated user role
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(authPolicy);
// highlight-end
```
</Block>

Below is an example of expanding the original backend object with user group permissions. Here, any authenticated users can read from `admin/` and `public/` and authenticated users belonging to the "admin" user group can only manage `admin/`:

```ts title="amplify/backend.ts"

const backend = defineBackend();

const customBucketStack = backend.createStack("custom-bucket-stack");

// Import existing bucket
const customBucket = Bucket.fromBucketAttributes(customBucketStack, "MyCustomBucket", );

backend.addOutput(,
          // highlight-start
          "admin/*": ,
          // highlight-end
        },
      }
    ]
  },
});

// ... Authenticated user policy and role attachment goes here ...
// highlight-start
/*
  Define an inline policy to attach to "admin" user group role
  This policy defines how authenticated users with 
  "admin" user group role can access your existing bucket
*/ 
const adminPolicy = new Policy(backend.stack, "customBucketAdminPolicy", /admin/*`],
    }),
    new PolicyStatement(`
        `$/*`
      ],
      conditions: ,
      },
    }),
  ],
});

// Add the policies to the "admin" user group role
backend.auth.resources.groups["admin"].role.attachInlinePolicy(adminPolicy);
// highlight-end
```

</Block>

Amplify allows scoping file access to individual users via the user's identity ID. To specify the user's identity ID, you can use the token `$`.

Below is an example of expanding the original backend object to define read access for guests to the `public/` folder, as well as defining a `protected/` folder where anyone can view uploaded files, but only the file owner can modify/delete them: 

```ts title="amplify/backend.ts"

const backend = defineBackend();

const customBucketStack = backend.createStack("custom-bucket-stack");

// Import existing bucket
const customBucket = Bucket.fromBucketAttributes(customBucketStack, "MyCustomBucket", );

backend.addOutput(,
          // highlight-start
          // allow all users to view all folders/files within `protected/`
          "protected/*": ,
          // allow owners to read, write and delete their own files in assigned subfolder
          "protected/$/*": 
          // highlight-end
        },
      }
    ]
  },
});
// highlight-start
/*
  Define an inline policy to attach to Amplify's unauth role
  This policy defines how unauthenticated users/guests 
  can access your existing bucket
*/ 
const unauthPolicy = new Policy(backend.stack, "customBucketUnauthPolicy", /public/*`
        `$/protected/*`
      ],
    }),
    new PolicyStatement(`
        `$/*`
      ],
      conditions: ,
      },
    }),
  ],
});

/*
  Define an inline policy to attach to Amplify's auth role
  This policy defines how authenticated users can access your 
  existing bucket and customizes owner access to their individual folder
*/
const authPolicy = new Policy(backend.stack, "customBucketAuthPolicy", /public/*`
        `$/protected/*`
      ],
    }),
    new PolicyStatement(`
        `$/*`
      ],
      conditions: ,
      },
    }),
    new PolicyStatement(/public/*`
        `$/protected/$/*`
      ],
    }),
    new PolicyStatement(/protected/$/*`
      ],
    }),
  ],
});

// Add the policies to the unauthenticated user role
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(
  unauthPolicy,
);

// Add the policies to the authenticated user role
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(authPolicy);
// highlight-end
```

</Block>
</BlockSwitcher>

> **Note**: 
The custom authorization rules defined in the examples can be combined, and follow the same rules as Amplify-defined storage. Please refer to our documentation on [customizing authorization rules](/[platform]/build-a-backend/storage/authorization/) for more information.

### Import latest `amplify_outputs.json` file

To ensure the local `amplify_outputs.json` file is up-to-date, you can run [the `npx ampx generate outputs` command](/[platform]/reference/cli-commands/#npx-ampx-generate-outputs) or download the latest `amplify_outputs.json` from the Amplify console as shown below.

![](/images/gen2/getting-started/react/amplify-outputs-download.png)

</InlineFilter>

### Import latest `amplify_outputs.dart` file

To ensure the local `amplify_outputs.dart` file is up-to-date, you can run [the `npx ampx generate outputs` command](/[platform]/reference/cli-commands/#npx-ampx-generate-outputs).

</InlineFilter>

Now that you've configured the necessary permissions, you can start using the storage APIs with your chosen S3 bucket.

## Use storage resources without an Amplify backend

While using the Amplify backend is the easiest way to get started, existing storage resources can also be integrated with Amplify Storage. 

In addition to manually configuring your storage options, you will also need to ensure Amplify Auth is properly configured in your project and associated IAM roles have the necessary permissions to interact with your existing bucket. Read more about [using existing auth resources without an Amplify backend](/[platform]/build-a-backend/auth/use-existing-cognito-resources/#use-auth-resources-without-an-amplify-backend).

### Using `Amplify.configure`
Existing storage resource setup can be accomplished by passing the resource metadata to `Amplify.configure`. This will configure the Amplify Storage client library to interact with the additional resources. It's recommended to add the Amplify configuration step as early as possible in the application lifecycle, ideally at the root entry point.

```ts

Amplify.configure(,
  Storage: ,
            "protected/*": 
            "protected/$/*": ,
            "admin/*": ,
          }
        },
        "<your-additional-bucket-friendly-name>": 
        }
      }
    }
  }
});
```

### Using `amplify_outputs.json`

Alternatively, existing storage resources can be used by creating or modifying the `amplify_outputs.json` file directly.

```ts title="amplify_outputs.json"
,
  "storage": ,
          "protected/*": ,
          "protected/$/*": ,
          "admin/*": 
        }
      },
      
      }
    ]
  }
}
```

</InlineFilter>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `pages/build-a-backend/storage/use-with-custom-s3/index.mdx`