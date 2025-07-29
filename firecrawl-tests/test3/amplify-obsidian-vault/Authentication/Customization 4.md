---
title: Customization
topics: ['Authentication']
primary_topic: Authentication
source: fragments/sdk/auth/android/drop-in-auth.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Customization

The `AWSMobileClient` client supports a simple "drop-in" UI for your application. You can add drop-in Auth UI like so:

```java
// 'this' refers the current active activity
AWSMobileClient.getInstance().showSignIn(this, new Callback() 

    @Override
    public void onError(Exception e) 
});
```

In the above code you would have created an Android Activity called `NextActivity` which would automatically be navigated to upon successful sign-up and sign-in. For testing, you can alternatively just use `MainActivity.class` after initializing:

```java
AWSMobileClient.getInstance().showSignIn(
        this,
        SignInUIOptions.builder()
                .nextActivity(NextActivity.class)
                .build(),
        new Callback() 
            }

            @Override
            public void onError(Exception e) 
        }
);
```

The above code also shows an additional Auth API, `signOut()`. For more advanced scenarios, you can call the `AWSMobileClient` APIs, such as for building your own UI or using functionality in different UX of your application lifecycle.

## Customization

Currently, you can change the following properties of the drop-in UI with the `AWSMobileClient`:
- Logo: Any Drawable resource supported by ImageView
- Background Color: Any color Android supported

```java
AWSMobileClient.getInstance().showSignIn(
        this,
        SignInUIOptions.builder()
                .nextActivity(NextActivity.class)
                .logo(R.id.logo)
                .backgroundColor(R.color.black)
                .canCancel(false)
                .build(),
        new Callback() 

            @Override
            public void onError(Exception e) 
        }
);
```

You can allow the sign in process to be dismissed by setting the `canCancel` property.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/sdk/auth/android/drop-in-auth.mdx`