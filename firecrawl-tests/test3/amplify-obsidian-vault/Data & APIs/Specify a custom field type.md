---
title: Specify a custom field type
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/data-modeling/add-fields/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Specify a custom field type

}

Amplify Data supports all AWS AppSync scalar types as field types. The following scalar types are available:

|Field type|Description|TypeScript validation|GraphQL Scalar Type|
|-|-|-|-|
|`a.id()`|A unique identifier for an object. This scalar is serialized like a String but isn't meant to be human-readable. If not specified on create operations, a UUID will be generated.|`string`|ID|
|`a.string()`|A UTF-8 character sequence.|`string`|String|
|`a.integer()`|An integer value between -(2^31) and 2^31-1.|`number` but rounded to closest integer value upon query/mutation|Int|
|`a.float()`|An IEEE 754 floating point value.|`number`|Float|
|`a.boolean()`|A Boolean value, either true or false.|`boolean`|Boolean|
|`a.date()`|An extended ISO 8601 date string in the format `YYYY-MM-DD`.|`string`|AWSDate|
|`a.time()`|An extended ISO 8601 time string in the format `hh:mm:ss.sss`.|`string`|AWSTime|
|`a.datetime()`|An extended ISO 8601 date and time string in the format `YYYY-MM-DDThh:mm:ss.sssZ`.|`string`|AWSDateTime|
|`a.timestamp()`|An integer value representing the number of seconds before or after 1970-01-01-T00:00Z.|`number`|AWSTimestamp|
|`a.email()`|An email address in the format local-part@domain-part as defined by RFC 822.|`string` with local-part and domain-part type enforcement|AWSEmail|
|`a.json()`|A JSON string. Any valid JSON construct is automatically parsed and loaded in the resolver code as maps, lists, or scalar values, rather than as the literal input strings. Unquoted strings or otherwise invalid JSON result in a validation error.|`any`|AWSJSON|
|`a.phone()`|A phone number. This value is stored as a string. Phone numbers can contain either spaces or hyphens to separate digit groups. Phone numbers without a country code are assumed to be US/North American numbers adhering to the North American Numbering Plan.|`string` validation only happening service-side|AWSPhone|
|`a.url()`|A URL as defined by RFC 1738. For example, https://www.amazon.com/dp/B000NZW3KC/ or mailto:example@example.com. URLs must contain a schema (http, mailto) and can't contain two forward slashes (//) in the path part.|`string` but with type enforcement on the schema part|AWSURL|
|`a.ipAddress()`|A valid IPv4 or IPv6 address. IPv4 addresses are expected in quad-dotted notation (123.12.34.56). IPv6 addresses are expected in non-bracketed, colon-separated format (1a2b:3c4b:1234:4567). You can include an optional CIDR suffix (123.45.67.89/16) to indicate subnet mask.|`string` with type enforcement for IPv4 and IPv6 pattern|AWSIPAddress|

## Specify a custom field type

Sometimes, the built-in types do not meet the needs of your application. In those cases, you can specify custom types. You can either define the custom types inline or explicitly define the custom type in the schema.

**Inline definition:** The "location" field will become a new non-model type that uses PascalCase, a naming convention in which the first letter of each word in a compound word is capitalized. If there are conflicts with another schema-level definition (model, custom type, enum), you will receive a Type error with a warning that you need to sift the value out as a separate item and use a "ref".

```ts
a.schema(),
    content: a.string(),
  }),
}).authorization((allow) => allow.publicApiKey());
```

**Explicit definition:** Specify the "Location" as `a.customType()` in your schema. To use the custom type, reference it through `a.ref()` in the respective field definitions.

```ts
a.schema(),

  Post: a.model(),

  User: a.model(),
}).authorization((allow) => allow.publicApiKey());
```

To set or read the location field on the client side, you can expand a nested object and the type system will auto-infer the allowed values.

```ts
const  = await client.models.Post.create(,
});

console.log(newPost?.location?.lat, newPost?.location?.long);
```

</InlineFilter>

To set or read the location field on the client side, you can create a Post object with the location values.

```swift
let post = Post(
    location: .init(
        lat: 48.837006,
        long: 8.28245))
let createdPost = try await Amplify.API.mutate(request: .create(post)).get()
print("\(createdPost)")
```

</InlineFilter>

## Specify an enum field type

Enum has a similar developer experience as custom types: short-hand and long-form approaches. 

Short-hand approach

```ts
a.schema(),
}).authorization((allow) => allow.publicApiKey());
```

Long-form approach

```ts
a.schema(),

  Video: a.model(),
}).authorization((allow) => allow.publicApiKey());
```

When creating a new item client-side, the enums are also type-enforced:
```ts
client.models.Post.create();
```

</InlineFilter>

Creating a new item client-side with the enum value:

```swift
let post = Post(
    content: "hello",
    privacySetting: .private)
let createdPost = try await Amplify.API.mutate(request: .create(post)).get()
```

</InlineFilter>

### List enum values client-side

You can list available enum values client-side using the `client.enums..values()` API. For example, this allows you to display the available enum values within a dropdown UI.

```ts
const availableSettings = client.enums.PrivacySetting.values()
// availableSettings returns ["PRIVATE", "FRIENDS_ONLY", "PUBLIC"]
```

</InlineFilter>

## Mark fields as required

By default, fields are optional. To mark a field as required, use the `.required()` modifier.

```ts
const schema = a.schema(),
}).authorization((allow) => allow.publicApiKey());
```

## Mark fields as arrays

Any field can be modified to be an array using the `.array()` modifier.

```ts
const schema = a.schema(),
}).authorization((allow) => allow.publicApiKey());
```

## Assign default values for fields

You can use the `.default(...)` modifier to specify a default value for optional [scalar type fields](https://docs.aws.amazon.com/appsync/latest/devguide/scalars.html). The `.default(...)` modifier is not available for custom types, arrays, or relationships.

```ts
const schema = a.schema(),
}).authorization((allow) => allow.publicApiKey());
```
> **Note**: 
**Note:** The `.default(...)` modifier can't be applied to required fields.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/data-modeling/add-fields/index.mdx`