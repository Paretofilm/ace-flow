---
title: Establish Connection
source: fragments/sdk/pubsub/android/working-api.mdx
---

# Establish Connection

## Establish Connection

### Certificate based mutual authentication

To connect with the AWS IoT Core service on the standard MQTT port 8883, you can use the `connect` API as shown below.

```java
mqttManager.connect(, new AWSIotMqttClientStatusCallback() 
});
```

The AWS IoT Core service also allows you to connect devices using MQTT with certificate based mutual authentication on port 443. You can do this using the `connectUsingALPN` API as shown below. See [MQTT with TLS client authentication on port 443](https://aws.amazon.com/blogs/iot/mqtt-with-tls-client-authentication-on-port-443-why-it-is-useful-and-how-it-works/) for more information.

```java
mqttManager.connectUsingALPN(, new AWSIotMqttClientStatusCallback() 
});
```

You can take a look at the [API Reference](https://aws-amplify.github.io/aws-sdk-android/docs/reference/com/amazonaws/mobileconnectors/iot/AWSIotMqttManager.html#connectUsingALPN-java.security.KeyStore-com.amazonaws.mobileconnectors.iot.AWSIotMqttClientStatusCallback-) to get more information.

### AWS Credentials based Authentication

This method uses AWS Signature Version 4 Credentials to sign the request to connect to the AWS IoT endpoint.

```java
try 
    });
} catch (final Exception e) 
```

### Custom Authentication

AWS IoT allows you to define custom authorizers that allow you to manage your own authentication and authorization strategy using a custom authentication service and a Lambda function. Custom authorizers allow AWS IoT to authenticate your devices and authorize operations using bearer token authentication and authorization strategies. See [AWS IoT Custom Authentication](https://docs.aws.amazon.com/iot/latest/developerguide/custom-authentication.html) for more details.

Please follow the steps outlined in [Setting up Custom Authentication](https://aws.amazon.com/blogs/security/how-to-use-your-own-identity-and-access-management-systems-to-control-access-to-aws-iot-resources/) to create the custom authorizer and configure the workflow with AWS IoT.

Once the custom authorizer workflow is configured, you can establish a connection as follows:

```java
try 
                        }
                    });
                }
            });
} catch (final Exception e) 
```

This feature is available in the AWS SDK for Android starting from version `2.16.8`.

## Subscribe to a topic

In order to start receiving messages from your provider, you need to subscribe to a topic as follows;

```java
try  catch (UnsupportedEncodingException e) 
	        }
	    });
} catch (Exception e) 
```

## Subscribe to multiple topics

To subscribe for multiple topics, just call `subscribeToTopic()` for each topic you wish to subscribe. 

## Publish to a topic

To send a message to a topic, use `publishString()` method with your topic name and the message:

```java
try  catch (Exception e) 
```

## Unsubscribe from a topic

To stop receiving messages from a topic, you can use `unsubscribeTopic()` method:

```java
try  catch (Exception e) 

// You will no longer get messages for "myTopic"
```

## Close Connection

In order to disconnect, you need to close the connection as follows:

```java
try  catch (Exception e) 
```

## API Reference

For the complete API documentation for AWS IoT, visit our [API reference](https://aws-amplify.github.io/aws-sdk-android/docs/reference/com/amazonaws/mobileconnectors/iot/package-summary.html).
