---
title: DELETE data
topics: ['General']
primary_topic: General
source: fragments/lib-v1/restapi/js/delete.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# DELETE data

## DELETE data

```javascript
const apiName = 'MyApiName'; // replace this with your api name.
const path = '/path'; //replace this with the path you have configured on your API
const myInit =  // OPTIONAL
};

API.del(apiName, path, myInit)
  .then((response) => )
  .catch((error) => );
```

Example with async/await

```javascript
async function deleteData()  // OPTIONAL
  };
  return await API.del(apiName, path, myInit);
}

deleteData();
```

Access body in the Lambda function

```javascript
// using a basic lambda handler
exports.handler = (event, context) => ;

// using serverless express
app.delete('/myendpoint', function (req, res) );
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/js/delete.mdx`