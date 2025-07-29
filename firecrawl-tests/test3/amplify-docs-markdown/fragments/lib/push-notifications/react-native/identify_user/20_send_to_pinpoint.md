---
title: Documentation
source: fragments/lib/push-notifications/react-native/identify_user/20_send_to_pinpoint.mdx
---

# Documentation

```ts
import  from 'aws-amplify/push-notifications';

const identifyUserInput: IdentifyUserInput = ,
    demographic: ,
    location: ,
    metrics: ,
  },
};

await identifyUser(identifyUserInput);
```

</Block>

```js

const identifyUserInput = ,
    demographic: ,
    location: ,
    metrics: ,
  },
};

await identifyUser(identifyUserInput);
```

</Block>
</BlockSwitcher>

When using `identifyUser` with Amazon Pinpoint, in addition to the other user info properties you can configure the `address`, `optOut` and `userAttributes` properties under `options`.

```ts
import  from 'aws-amplify/push-notifications';

const identifyUserInput: IdentifyUserInput = 
  }
};

await identifyUser(identifyUserInput);
```

</Block>

```js

const identifyUserInput = 
  },

};

await identifyUser(identifyUserInput);
```

</Block>
</BlockSwitcher>
