---
title: IAM Authorization
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/restapi/native_common/authz/common.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# IAM Authorization

When determining the authorization mode for your REST endpoint, there are a few built in options and customizations you can do.

## IAM Authorization

By default, the API will be using IAM authorization and the requests will be signed for you automatically. IAM authorization has two modes: one using an **unauthenticated** role, and one using an **authenticated** role. When the user has not signed in through `Amplify.Auth.signIn`, the unauthenticated role is used by default. Once the user has signed in, the authenticate role is used, instead.

When you created your REST API with the Amplify CLI, you were asked if you wanted to restrict access. If you selected **no**, then the unauthenticated role will have access to the API. If you selected **yes**, you would have configured more fine grain access to your API.

### Unauthenticated Requests

You can use the API category to access API Gateway endpoints that don't require authentication. In this case, you need to allow unauthenticated identities in your Amazon Cognito Identity Pool settings. For more information, please visit [Amazon Cognito Developer Documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/identity-pools.html#enable-or-disable-unauthenticated-identities).

When your API is configured to use IAM as the authorization type, your requests will automatically have IAM credentials added to the headers of outgoing requests. You can verify that IAM is being used as the authorization type by inspecting the `authorizationType` associated with your API in `amplifyconfiguration.json`:

```json

  }
}
```

## API Key

If you want to configure a public REST API, you can set an API key in Amazon API Gateway. Then, update your `amplifyconfiguration.json` to reference it. The value associated to the `"authorizationType"` key should be `"API_KEY"`. Also include a `"apiKey"` as a key, and set its value to whatever you configured in API Gateway.

```json

  }
}
```

## Cognito User pool authorization

If you set up the API Gateway with a custom authorization with a Cognito User pool, then you can set the `amplifyconfiguration.json` to use `AMAZON_COGNITO_USER_POOLS `.

```json

  }
}
```

Your `amplifyconfiguration.json` should contain Cognito configuration in the `awsCognitoAuthPlugin` block, including details about your Cognito user pool:

```json

  },
  "CredentialsProvider": 
    }
  }
}
```

With this configuration, your access token will automatically be included in outbound requests to your API, as an `Authorization` header. For more details on how to configure the API Gateway with the custom authorization, see [this](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-integrate-with-cognito.html)

## OIDC

If you are using a 3rd party OIDC provider you will need to configure it and manage the details of token refreshes yourself. Update the `amplifyconfiguration.json` file and code snippet as follows:

```json

    }
}
```

### Note related to use Access Token or ID Token

The Access Token contains scopes and groups and is used to grant access to authorized resources. [This is a tutorial for enabling custom scopes.](https://aws.amazon.com/premiumsupport/knowledge-center/cognito-custom-scopes-api-gateway/).

The ID Token contains claims about the identity of the authenticated user such as name, email, and phone_number. It could have custom claims as well, for example using [Amplify CLI](/gen1/[platform]/tools/cli/usage/lambda-triggers/#override-id-token-claims).

If you are using Cognito's user pool as the authorization type, this will by default retrieve and use the Access Token for your requests. If you would like to override this behavior and use the ID Token instead, you can treat Cognito user pool as your OIDC provider, set the authorization type to `OPENID_CONNECT` and use `Amplify.Auth` to retrieve the ID Token for your requests.

## NONE

You can also set authorization mode to `NONE` so that the library will not provide any request interception logic. You can use this when your API does not require any authorization or when you want to manipulate the request yourself, such as adding header values or authorization data.

```json

    }
}
```

You can register your own request interceptor to intercept the request and perform an action or inject something into your request before it is performed.

## Customizing HTTP request headers

To use custom headers on your HTTP request, you need to add these to Amazon API Gateway first. For more info about configuring headers, please visit [Amazon API Gateway Developer Guide](http://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-cors.html)

If you used the Amplify CLI to create your API, you can enable custom headers by following these steps:

1. Visit [Amazon API Gateway console](https://aws.amazon.com/api-gateway/).
2. On Amazon API Gateway console, click on the path you want to configure (e.g. /\)
3. Then click the _Actions_ dropdown menu and select **Enable CORS**
4. Add your custom header (e.g. my-custom-header) on the text field Access-Control-Allow-Headers, separated by commas, like: 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,my-custom-header'.
5. Click on 'Enable CORS and replace existing CORS headers' and confirm.
6. Finally, similar to step 3, click the Actions drop-down menu and then select **Deploy API**. Select **Development** on deployment stage and then **Deploy**. (Deployment could take a couple of minutes).


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/restapi/native_common/authz/common.mdx`