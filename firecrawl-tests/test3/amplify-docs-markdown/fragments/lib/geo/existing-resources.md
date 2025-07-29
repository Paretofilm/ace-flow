---
title: Authorization permissions
source: fragments/lib/geo/existing-resources.mdx
---

# Authorization permissions

You can also use Amplify Geo with your existing Amazon Location Service resources if you'd like, there are some manual setup that you need to do.

## Authorization permissions

To use your existing Amazon Location Service resources, i.e. maps and place indices, with Amplify Geo, you need to ensure your role has the right authorization permissions through Cognito. If you set up your Cognito resources in any way other than the Amplify CLI or Amplify Studio, the roles will need to be given permission to access the map and place indices.

**Note:** Here is a guide on [Creating an Amazon Cognito identity pool for use with Amazon Location Service](https://docs.aws.amazon.com/location/latest/developerguide/authenticating-using-cognito.html)

There are two roles created by Cognito: an `Auth_Role` that grants signed-in-user-level access and an `Unauth_Role` that allows unauthenticated access to resources. Attach the following policies for the appropriate resources and roles (Auth and/or Unauth). Replace ``, ``, and `` with the correct items. Note that certain actions cannot be performed with unauthenticated access. The list of actions allowed for the Unauth role is in the [Granting access to Amazon Location Service guide](https://docs.aws.amazon.com/location/latest/developerguide/how-to-access.html).

```json
::map/"
    },
    ::place-index/"
    }
  ]
}
```
