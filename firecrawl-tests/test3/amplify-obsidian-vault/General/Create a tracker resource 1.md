---
title: Create a tracker resource
topics: ['General']
primary_topic: General
source: fragments/guides/location-service/tracking-device-location-android.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Create a tracker resource

## Create a tracker resource

In order to start tracking, you create an Amazon Location Tracking resource to capture and store positions of your users. 

1. Open the [Amazon Location Service console](https://console.aws.amazon.com/location/tracking/home#/create) to create a tracker.
1. Enter **MyTracker** in **Name**.
1. Press **Create tracker**.

      ![Amazon Location Service - Create tracker](/images/als/create-tracker.png)

1. Note the Amazon Resource Name (ARN) of your tracker. This will start with **arn:aws:geo** as in the below screenshot.

      ![Amazon Location Service - Tracker](/images/als/my-tracker.png)

## Allow Guest users access to the tracker

Now that you have created a tracker resource, you must create an inline policy to give users of your application access to the resource:

1. Navigate to the root of your project and run the following command:

    ```bash
    amplify console auth
    ```

1. Select **Identity Pool** from **Which console?** when prompted.
1. You will be navigated to the Amazon Cognito console. Click on **Edit identity pool** in the top right corner of the page.
1. Open the drop down for **Unauthenticated identities**, choose **Enable access to unauthenticated identities**, and then press **Save Changes**.
1. Click on **Edit identity pool** once more. Make a note of the name of the Unauthenticated role. For example, `amplify-<project_name>-<env_name>-<id>-unauthRole`.
1. Open the [AWS Identity and Access Management (IAM) console](https://console.aws.amazon.com/iam/home#/roles) to manage roles.
1. In the **Search** field, enter the name of your unauthRole noted above and click on it.
1. Click **+Add inline policy**, then click on the **JSON** tab.
1. Fill in the **[ARN]** placeholder with the ARN of your tracker which you noted above and replace the contents of the policy with the below.

   ```json
   
       ]
   }
   ```

1. Click on the **Review policy** button.
1. In the **Name** field, enter **LocationTracker**.
1. Click on the **Create policy** button.  

You have now successfully added authentication to your Android app.

## Sending device location data to Amazon Location Service

The below steps describe how you can retrieve a device location and pass it to the tracker resource you have created with Amazon Location Service. You can see a full sample app in the [aws-samples/amazon-location-samples](https://github.com/aws-samples/amazon-location-samples/blob/main/tracking-android/) repository.

1. In Android Studio, expand **manifests** in the project viewer and open **AndroidManifest.xml**.

1. Add the following permissions after the opening **manifest** tag. This grants your application access to location services and network connectivity. To learn more, refer to [Request location permissions](https://developer.android.com/training/location/permissions) in the Android Developers documentation.

    ```xml
    <manifest ...>
        ...
        
        <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
        <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.INTERNET" />
    </manifest>
    ```

1. First, add a new `AWSLocationTracker` to the Activity:

    ```java
    private AWSLocationTracker tracker;
    ```

    </Block>

    ```kotlin
    private lateinit var tracker: AWSLocationTracker
    ```

    </Block>
    </BlockSwitcher>

1. Add helper methods to the class that will request location permission from the application user and start tracking.

    ```java
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) 
    }

    void startTracking() 

            @Override
            public void onDataPublished(TrackingPublishedEvent trackingPublishedEvent) 

            @Override
            public void onDataPublicationError(TrackingError trackingError) 
        };

        TrackingOptions options = TrackingOptions.builder()
                .customDeviceId("MyTracker")
                .retrieveLocationFrequency(1_000L) // Retrieve the current location every 30 seconds
                .emitLocationFrequency(5_000L)    // Emit a batch of locations to Amazon Location every 5 minutes
                .build();

        tracker.startTracking(this, options, listener);
    }
    ```

    </Block>

    ```kotlin
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array, grantResults: IntArray) 
    }

    fun startTracking() 

            override fun onDataPublished(trackingPublishedEvent: TrackingPublishedEvent) 

            override fun onDataPublicationError(trackingError: TrackingError) 
        }
        val options = TrackingOptions.builder()
                .customDeviceId("MyTracker")
                .retrieveLocationFrequency(1000L) // Retrieve the current location every 30 seconds
                .emitLocationFrequency(5000L) // Emit a batch of locations to Amazon Location every 5 minutes
                .build()

        tracker.startTracking(this, options, listener)
    }
    ```

    </Block>
    </BlockSwitcher>

1. Initialize `AWSMobileClient` in your `onCreate` method. This code will get credentials from Amazon Cognito, check to see if the application has location permissions, request them if necessary, and start the tracker.

    ```java
    AWSMobileClient.getInstance().initialize(getApplicationContext(), new Callback()  else , 0);
                }
            } else 
        }

        @Override
        public void onError(Exception error) 
    });
    ```

    </Block>

    ```kotlin
    AWSMobileClient.getInstance().initialize(applicationContext, object : Callback()  else 
            } else 
        }

        override fun onError(error: Exception?) 
    })
    ```

    </Block>
    </BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/guides/location-service/tracking-device-location-android.mdx`