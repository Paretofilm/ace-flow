---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/js/create-custom-plugin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

You can create your custom pluggable for Storage. This may be helpful if you want to integrate your app with a custom storage backend.

To create a plugin implement the `StorageProvider` interface:

```typescript

    // you need to implement these seven methods
    // configure your provider
    configure(config: object): object;

    // copy object, optional
    copy?(
	    src: ,
	    dest: ,
	    options?
    ): Promise<any>

    // get object/pre-signed url from storage
    get(key: string, options?): Promise

    // upload storage object
    put(key: string, object, options?): Promise

    // remove object
    remove(key: string, options?): Promise<any>

    // list objects for the path
    list(path, options?): Promise<any>

    // return 'Storage';
    getCategory(): string;

    // return the name of you provider
    getProviderName(): string;
```

You can now register your pluggable:

```javascript
// add the plugin
Storage.addPluggable(new MyStorageProvider());

// get the plugin
Storage.getPluggable(MyStorageProvider.providerName);

// remove the plugin
Storage.removePluggable(MyStorageProvider.providerName);

// send configuration into Amplify
Storage.configure(
});
```

You can pass in your custom provider class to the Storage function to get Typescript support:

```javascript
class MyStorageProvider implements StorageProvider ): Promise<>;
}

// will automatically use the return type from the provider's function signature
const getResult: Promise<> = Storage.get('key', );
```

The default provider (Amazon S3) is in use when you call `Storage.put( )` unless you specify a different provider: `Storage.put(key, object, )`.


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/js/create-custom-plugin.mdx`