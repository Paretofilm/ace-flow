---
title: Authorization permissions
source: pages/build-a-backend/add-aws-services/geo/existing-resources/index.mdx
---

# Authorization permissions

To use existing Amazon Location Services resources with your Amplify backend or frontend application, use the `addOutput` method to surface backend resource outputs to the `amplify_outputs.json` file:

```ts title="amplify/backend.ts"

const backend = defineBackend()

backend.addOutput(,
      },
      default: "<your-friendly-map-name>",
    },
  },
})
```

## Authorization permissions

To use your existing Amazon Location Service resources (i.e. maps and place indices) with Amplify Geo, you need to ensure your role has the right authorization permissions through Cognito.

**Note:** Here is a guide on [Creating an Amazon Cognito identity pool for use with Amazon Location Service](https://docs.aws.amazon.com/location/latest/developerguide/authenticating-using-cognito.html)

There are two roles created by Cognito: an "authenticated role" that grants signed-in-user-level access and an "unauthenticated role" that allows unauthenticated access to resources. Attach the following policies for the appropriate resources and roles (Auth and/or Unauth). Replace ``, ``, and `` with the correct items. Note that certain actions cannot be performed with unauthenticated access. The list of actions allowed for the Unauth role is in the [Granting access to Amazon Location Service guide](https://docs.aws.amazon.com/location/latest/developerguide/how-to-access.html).

```json
,
    ,
    
  ]
}
```

## Configure client library directly

You can first import and parse the generated `amplify_outputs.json`. You can then manually configure Amplify Geo like this:

```js

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(
        },
        default: '<your-preferred-default-map>' // REQUIRED - Amazon Location Service Map resource name to set as default
      },
      search_indices: ,
      geofenceCollections: ,
      region: '<your-geo-region>' // REQUIRED - Amazon Location Service Region
    }
  }
});
```

Now you can proceed to [displaying a map](/[platform]/build-a-backend/add-aws-services/geo/maps/) or [adding location search](/[platform]/build-a-backend/add-aws-services/geo/location-search/) to your app.
</InlineFilter>
