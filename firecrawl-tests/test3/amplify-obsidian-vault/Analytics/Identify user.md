---
title: Identify user
topics: ['Analytics']
primary_topic: Analytics
source: pages/build-a-backend/add-aws-services/analytics/identify-user/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Identify user

This call sends information that you have specified about the user to Amazon Pinpoint. This could be for an unauthenticated or an authenticated user.

In addition, `customProperties` and `userAttributes` can also be provided when invoking `identifyUser`. The Amazon Pinpoint console makes that data available as part of the criteria for segment creation. Attributes passed in via `customProperties` will appear under **Custom Endpoint Attributes**, while `userAttributes` will appear under **Custom User Attributes**. See the [Amazon Pinpoint documentation](https://docs.aws.amazon.com/pinpoint/latest/userguide/segments-building.html#choosecriteria) for more information on segment creation.

You can get the current user's ID from the Amplify Auth category as shown below. Be sure you have it added and setup per the [Auth category documentation](/[platform]/build-a-backend/auth/set-up-auth/).

If you have asked for location access and received permission, you can also provide that in `UserProfile.Location`.

```java
UserProfile.Location location = UserProfile.Location.builder()
    .latitude(47.606209)
    .longitude(-122.332069)
    .postalCode("98122")
    .city("Seattle")
    .region("WA")
    .country("USA")
    .build();

AnalyticsProperties customProperties = AnalyticsProperties.builder()
    .add("property1", "Property value")
    .build();

AnalyticsProperties userAttributes = AnalyticsProperties.builder()
    .add("someUserAttribute", "User attribute value")
    .build();

AWSPinpointUserProfile profile = AWSPinpointUserProfile.builder()
    .name("test-user")
    .email("user@test.com")
    .plan("test-plan")
    .location(location)
    .customProperties(customProperties)
    .userAttributes(userAttributes)
    .build();

Amplify.Auth.getCurrentUser(authUser -> , exception -> );

```

</Block>

```kotlin
val location = UserProfile.Location.builder()
    .latitude(47.606209)
    .longitude(-122.332069)
    .postalCode("98122")
    .city("Seattle")
    .region("WA")
    .country("USA")
    .build();

val customProperties = AnalyticsProperties.builder()
    .add("property1", "Property value")
    .build();

val userAttributes = AnalyticsProperties.builder()
    .add("someUserAttribute", "User attribute value")
    .build();

val profile = AWSPinpointUserProfile.builder()
    .name("test-user")
    .email("user@test.com")
    .plan("test-plan")
    .location(location)
    .customProperties(customProperties)
    .userAttributes(userAttributes)
    .build();

Amplify.Auth.getCurrentUser(, )
```

</Block>

```java
UserProfile.Location location = UserProfile.Location.builder()
    .latitude(47.606209)
    .longitude(-122.332069)
    .postalCode("98122")
    .city("Seattle")
    .region("WA")
    .country("USA")
    .build();

AnalyticsProperties customProperties = AnalyticsProperties.builder()
    .add("property1", "Property value")
    .build();

AnalyticsProperties userAttributes = AnalyticsProperties.builder()
    .add("someUserAttribute", "User attribute value")
    .build();

AWSPinpointUserProfile profile = AWSPinpointUserProfile.builder()
    .name("test-user")
    .email("user@test.com")
    .plan("test-plan")
    .location(location)
    .customProperties(customProperties)
    .userAttributes(userAttributes)
    .build();

RxAmplify.Auth.getCurrentUser()
    .subscribe(
        result -> ,
        error -> Log.e("AuthQuickStart", error.toString())
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>

This call sends information about the current user (which could be unauthenticated or authenticated) to Amazon Pinpoint.

You can provide `name`, `email` and `plan`, as well as location information with `AnalyticsUserProfile.Location`. You can also send additional custom attributes using `AnalyticsProperties`.

If the user is signed in through [Amplify.Auth.signIn](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/), then you can retrieve the current user's ID as shown below:

```swift

let user = try await Amplify.Auth.getCurrentUser()

let location = AnalyticsUserProfile.Location(
    latitude: 47.606209,
    longitude: -122.332069,
    postalCode: "98122",
    city: "Seattle",
    region: "WA",
    country: "USA"
)

let properties: AnalyticsProperties = [
    "phoneNumber": "+11234567890",
    "age": 25
]

let userProfile = AnalyticsUserProfile(
    name: "username",
    email: "name@example.com",
    plan: "plan",
    location: location,
    properties: properties
)

Amplify.Analytics.identifyUser(
    userId: user.userId,
    userProfile: userProfile
)
```
</InlineFilter>

This call sends information that you have specified about a user to Amazon Pinpoint. This could be for an unauthenticated (guest) or an authenticated user.

You can get the current user's ID from the Amplify Auth category as shown per the Auth category documentation. Be sure to have it ready before you set it as shown below (Check out the [Authentication Getting Started](/[platform]/build-a-backend/auth/set-up-auth/) guide for detailed explanation).

If you have asked for location access and received permission, you can also provide that in `UserProfileLocation`

> **Note**: 

Breaking changes from v0 to v1:  

The Analytics- prefix of the original `AnalyticsUserProfile` and `AnalyticsUserProfileLocation` classes is removed.  Furthermore, `AnalyticsProperties` is renamed to `CustomProperties`. 

```dart
Future<void> addAnalyticsWithLocation() async 
```
</InlineFilter>

This API sends information about the current user to Amazon Pinpoint.

Additional information such as the user's name, email, location, and device can be included by specifying the `UserProfile`. Custom attributes can also be included by setting `UserProfile.customProperties`.

If the user was signed in through [signIn](/[platform]/build-a-backend/auth/connect-your-frontend/sign-up/) you can retrieve the current user's ID as shown below:

```js title="src/index.js"

const location = ;

const customProperties = ;

const userProfile = ;

async function sendUserData() );
}
```

</InlineFilter>

Sending user information allows you to associate a user to their user profile and activities or actions in your app.  The user's actions and attributes can also tracked across devices and platforms by using the same `userId`.  

Some scenarios for identifying a user and their associated app activities are:
* When a user completes app sign up
* When a user completes sign in process
* When a user launches your app
* When a user modifies or updates their user profile


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/analytics/identify-user/index.mdx`