---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/user_attributes/20_update_user_attribute.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

To update a single user attribute, call `updateUserAttribute`:

```dart
Future<void> updateUserEmail() async  on AuthException catch (e) ');
  }
}
```

User attribute updates may require additional verification before they're complete. Check the
`UpdateUserAttributeResult` returned from `Amplify.Auth.updateUserAttribute` to see which next
step, if any, is required. When the update is complete, the next step will be `done`.

```dart
void _handleUpdateUserAttributeResult(
  UpdateUserAttributeResult result,
) 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```

To update multiple user attributes at a time, call `updateUserAttributes`:

```dart
Future<void> updateUserAttributes() async 
    });
  } on AuthException catch (e) ');
  }
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/user_attributes/20_update_user_attribute.mdx`