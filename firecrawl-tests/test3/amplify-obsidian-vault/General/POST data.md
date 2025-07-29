---
title: POST data
topics: ['General']
primary_topic: General
source: fragments/lib-v1/restapi/js/update.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# POST data

## POST data

Posts data to the API endpoint:

```javascript
const apiName = 'MyApiName'; // replace this with your api name.
const path = '/path'; //replace this with the path you have configured on your API
const myInit = , // replace this with attributes you need
  headers:  // OPTIONAL
};

API.post(apiName, path, myInit)
  .then((response) => )
  .catch((error) => );
```

Example with async/await

```javascript
async function postData() , // replace this with attributes you need
    headers:  // OPTIONAL
  };

  return await API.post(apiName, path, myInit);
}

postData();
```

## PUT data

When used together with a REST API, `put()` method can be used to create or update records. It updates the record if a matching record is found. Otherwise, a new record is created.

```javascript
const apiName = 'MyApiName'; // replace this with your api name.
const path = '/path'; // replace this with the path you have configured on your API
const myInit = , // replace this with attributes you need
  headers:  // OPTIONAL
};

API.put(apiName, path, myInit)
  .then((response) => )
  .catch((error) => );
```

Example with async/await:

```javascript
async function putData() , // replace this with attributes you need
    headers:  // OPTIONAL
  };

  return await API.put(apiName, path, myInit);
}

putData();
```

Access body in the Lambda function

```javascript
// using a basic lambda handler
exports.handler = (event, context) => ;

// using serverless express
app.put('/myendpoint', function (req, res) );
```

Update a record:

```javascript
const params = 
};

const apiResponse = await API.put('MyTableCRUD', '/manage-items', params);
```

## Access body in Lambda proxy function

```javascript
// using a basic lambda handler
exports.handler = (event, context) => ;

// using serverless express
app.post('/myendpoint', function (req, res) );
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/js/update.mdx`