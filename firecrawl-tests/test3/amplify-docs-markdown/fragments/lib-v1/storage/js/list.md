---
title: Public level list
source: fragments/lib-v1/storage/js/list.mdx
---

# Public level list

List keys under a specified path, as well as `lastModified` timestamp.

## Public level list

```javascript
Storage.list('photos/') // for listing ALL files without prefix, pass '' instead
  .then(() => console.log(results))
  .catch((err) => console.log(err));
```

Note the trailing slash `/` - if you had requested `Storage.list('photos')` it would also match against files like `photos123.jpg` alongside `photos/123.jpg`.

The format of the response will look similar to the below example

```js
,
    // ...
  ],
  hasNextToken: false
}
```

Manually created folders will show up as files with a `size` of 0, but you can also match keys against a regex like `file.key.match(/\.[0-9a-z]+$/i)` to distinguish files vs folders. Since "folders" are a virtual concept in S3, any file may declare any depth of folder just by having a `/` in its name. If you need to list all the folders, you'll have to parse them accordingly to get an authoritative list of files and folders:

```js
function processStorageList(response)  else 
  });
  return ;
}
```

If you need the files and folders in terms of a nested object instead (for example, to build an explorer UI), you could parse it recursively:

```js
function processStorageList(response) ;
  // https://stackoverflow.com/questions/44759750/how-can-i-create-a-nested-object-representation-of-a-folder-structure
  const add = (source, target, item) => ; // element;
    if (elements.length) ;
      add(elements.join('/'), target[element], item);
    }
  };
  response.results.forEach((item) => add(item.key, filesystem, item));
  return filesystem;
}
```

This places each item's data inside a special `__data` key.

## Protected level list

To list current user's objects:

```javascript
Storage.list('photos/', )
  .then(() => console.log(results))
  .catch((err) => console.log(err));
```

To get other users' objects:

```javascript
Storage.list('photos/', )
  .then(() => console.log(results))
  .catch((err) => console.log(err));
```

## Private level list

```javascript
Storage.list('photos/', )
  .then(() => console.log(results))
  .catch((err) => console.log(err));
```

## Access all files

To get a list of all files in your S3 bucket under a specific prefix, you can set pageSize to ALL. The default value of pageSize is 1000.

```javascript
Storage.list('photos/', )
  .then(() => console.log(result))
  .catch((err) => console.log(err));
```

## Paginated file access

If the pageSize is set lower than the total file size, a single `Storage.list` call only returns a subset of all the files. To list all the files with multiple calls, users can use the `hasNextToken` and `nextToken` keys:

```javascript
const PAGE_SIZE = 20;
let nextToken = undefined;
let hasNextPage = true;
//...
const loadNextPage = async () => );
    if (response.hasNextToken)  else 
    // render list items from response.results
  }
};
```

> **Note**: Note: The range of pageSize can be from 0 - 1000 or 'ALL'.
