---
title: Generate Todo Model class
source: fragments/lib-v1/graphqlapi/android/getting-started/40_codegen.mdx
---

# Generate Todo Model class

## Generate Todo Model class

To generate the `Todo` model, change directories to your project folder and **execute the command**:

```bash
amplify codegen models
```

The generated files will be under the `app/src/main/java/com/amplifyframework.datastore.generated.model` directory. It is strongly advised not to put any hand written code in `app/src/main/java/com/amplifyframework.datastore.generated` directory as it gets re-generated each time codegen is run.
