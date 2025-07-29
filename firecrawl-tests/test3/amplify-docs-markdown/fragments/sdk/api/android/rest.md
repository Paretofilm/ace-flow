---
title: Overview
source: fragments/sdk/api/android/rest.mdx
---

# Overview

## Overview

The Amplify CLI deploys REST APIs and handlers using [Amazon API Gateway](http://docs.aws.amazon.com/apigateway/latest/developerguide/) and [AWS Lambda](http://docs.aws.amazon.com/lambda/latest/dg/).

The API category will perform SDK code generation which, when used with the `AWSMobileClient` can be used for creating signed requests for Amazon API Gateway when the service Authorization is set to `AWS_IAM` or when using a [Cognito User Pools Authorizer](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-integrate-with-cognito.html).

See [the authentication section for more details](/gen1/[platform]/sdk/auth/getting-started/) for using the `AWSMobileClient` in your application.

## Set Up Your Backend

In a terminal window, navigate to your project folder (the folder that typically contains your project level `build.gradle`), and add the SDK to your app.

```bash
cd YOUR_PROJECT_FOLDER
amplify add api
```

When prompted select the following options:

```console
> REST
> Create a new Lambda function
> Serverless express function
> Restrict API access? Yes
> Who should have access? Authenticated and Guest users
```

When configuration of your API is complete, the CLI displays a message confirming that you have configured local CLI metadata for this category. You can confirm this by running `amplify status`. Finally deploy your changes to the cloud:

```bash
amplify push
```

Once the deployment completes a folder with the name of your API's resource name will be created in `./src/main/java`. This is the client SDK with the models you will import and use in the `ApiClientFactory()` builder from your code in the following sections.

## Connect to Your Backend

Add the following to your `app/build.gradle`:

```groovy
dependencies 
```

Build your project. Next, you will need to import the client that was generated in `./src/main/java` when you ran `amplify push`. For example, an app named `useamplify` with an API resource named `xyz123`, the path of the code file will be `./src/main/java/xyz123/useamplifyabcdClient.java`. The API client name will be `useamplifyabcdClient`. You would have the following entries in your code:

```java
import YOUR_API_RESOURCE_NAME.YOUR_APP_NAME_XXXXClient;

private YOUR_APP_NAME_XXXXClient apiClient = new ApiClientFactory()
    .credentialsProvider(AWSMobileClient.getInstance())
    .build(YOUR_API_CLIENT_NAME.class);
```

Find the resource name of your API by running `amplify status`. Copy your API client name to use when invoking the API in the following sections.

### IAM authorization

To invoke an API Gateway endpoint from your application, import the generated client as outlined in the last section and use the generated client class, model, and resource paths as in the below example with `YOUR_API_RESOURCE_NAME.YOUR_APP_NAME_XXXXClient`, `YOUR_APP_NAME_XXXXClient`, and `YOUR_API_CLIENT_NAME` replaced appropriately. For AWS IAM authorization use the `AWSMobileClient` as outlined in [the authentication section](/gen1/[platform]/sdk/auth/getting-started/).

```java
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.amazonaws.http.HttpMethodName;
import com.amazonaws.mobile.client.AWSMobileClient;
import com.amazonaws.mobile.client.AWSStartupHandler;
import com.amazonaws.mobile.client.AWSStartupResult;
import com.amazonaws.mobileconnectors.apigateway.ApiClientFactory;
import com.amazonaws.mobileconnectors.apigateway.ApiRequest;
import com.amazonaws.mobileconnectors.apigateway.ApiResponse;
import com.amazonaws.util.IOUtils;
import com.amazonaws.util.StringUtils;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

// TODO Replace this with your api friendly name and client class name
import YOUR_API_RESOURCE_NAME.YOUR_APP_NAME_XXXXClient;

public class MainActivity extends AppCompatActivity 
        }).execute();

        // Create the client
        apiClient = new ApiClientFactory()
                .credentialsProvider(AWSMobileClient.getInstance())
                .build(YOUR_API_CLIENT_NAME.class);

        doInvokeAPI();
    }

    public void doInvokeAPI() 

        final ApiRequest request = localRequest;

        // Make network call on background thread
        new Thread(new Runnable() 

                    Log.d(TAG, response.getStatusCode() + " " + response.getStatusText());

                } catch (final Exception exception) 
            }
        }).start();
    }
}
```

### Cognito User Pools authorization

When invoking an API Gateway endpoint with Cognito User Pools authorizer, you can leverage the `AWSMobileClient` to dynamically refresh and pass tokens to your endpoint. Using the example from the previous section, update the `doInvokeAPI()` so that it takes a "token" string argument like `doInvokeAPI(String token)`. Next, add a header for the token to be passed with `.addHeader("Authorization", token)` and set the service configuration to have `credentialsProvider(null)`. Finally, overload the `doInvokeAPI()` with a new definition that gets the Cognito User Pools token from the `AWSMobileClient` as below:

```java
//Pass in null for credentialsProvider
apiClient = new ApiClientFactory()
    .credentialsProvider(null)
    .build(YOUR_API_CLIENT_NAME.class);

//New overloaded function that gets Cognito User Pools tokens
public void doInvokeAPI()

        @Override
        public void onError(Exception e) 
    });
}

//Updated function with arguments and code updates
public void doInvokeAPI(String token) 
```

You can then invoke this method with `doInvokeAPI()` from your application code and it will pass the IdToken from Cognito User Pools as an `Authorization` header.
