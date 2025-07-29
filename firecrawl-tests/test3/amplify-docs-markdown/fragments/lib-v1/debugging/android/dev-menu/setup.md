---
title: Documentation
source: fragments/lib-v1/debugging/android/dev-menu/setup.mdx
---

# Documentation

To enable the developer menu, pass a custom configuration when configuring Amplify:

```java
AmplifyConfiguration config = AmplifyConfiguration.builder(getApplicationContext())
    .devMenuEnabled(true)
    .build();
Amplify.configure(config, getApplicationContext());
```

</Block>

```kotlin
val config = AmplifyConfiguration.builder(applicationContext)
    .devMenuEnabled(true)
    .build()
Amplify.configure(config, applicationContext)
```

</Block>
</BlockSwitcher>

Next, run the following commands from the Android project directory to add a copy of the file `./amplify/.config/local-env-info.json` to the `./app/src/main/res/raw/` directory in your Android project and rename the copy to `localenvinfo.json`:

```bash
cp amplify/.config/local-env-info.json app/src/main/res/raw
mv app/src/main/res/raw/local-env-info.json app/src/main/res/raw/localenvinfo.json
```

> **Note**: 

If the `amplify` directory is not in your Android project folder, please follow the [project setup instructions](/gen1/[platform]/prev/start/project-setup/prerequisites/). The file `local-env-info.json` contains environment information that will be displayed on the developer menu.
