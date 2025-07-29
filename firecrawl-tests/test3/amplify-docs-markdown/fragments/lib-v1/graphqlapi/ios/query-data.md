---
title: Query by Id
source: fragments/lib-v1/graphqlapi/ios/query-data.mdx
---

# Query by Id

## Query by Id

Now that you were able to make a mutation, take the `Id` that was printed out and use it in your query to retrieve data.

```swift
func getTodo() 
                print("Successfully retrieved todo: \(todo)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        case .failure(let error):
            print("Got failed event with error \(error)")
        }
    }
}
```

</Block>

```swift
func getTodo() -> AnyCancellable 
        }
        receiveValue: 
                print("Successfully retrieved todo: \(todo)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        }
}
```

</Block>

</BlockSwitcher>

## List Query

You can get the list of items using `.paginatedList` with optional parameters `limit` and `where` to specify the page size and condition. By default, the page size is 1000.

```swift
func listTodos() 
        case .failure(let error):
            print("Got failed event with error \(error)")
        }
    }
}
```

</Block>

```swift
func listTodos() -> AnyCancellable 
        }
        receiveValue: 
        }
    return sink
}
```

</Block>

</BlockSwitcher>

### List subsequent pages of items

If you are using SwiftUI and have SwiftUI imported in the same code file, you will need to import the class `Amplify.List` to resolve name collision with `SwiftUI.List`:

```swift 
import SwiftUI
import Amplify
import class Amplify.List
```

For large data sets, you'll need to paginate through the results. After receiving the first page of results, you can check if there is a subsequent page and obtain the next page.

```swift
var todos: [Todo] = []
var currentPage: List?

func listFirstPage() 
        case .failure(let error):
            print("Got failed event with error \(error)")
        }
    }
}

func listNextPage() 
        }
    }
}
```

## List all pages

If you want to get all pages, retrieve the subsequent page when you have successfully retrieved the first or next page. 

1. Update the above method `listFirstPage()` to `listAllPages()` 
2. Call `listNextPageRecursively()` in the success block of the query in `listAllPages()`
2. Update the `listNextPage()` to `listNextPageRecursively()`
3. Call `listNextPageRecursively()` in the success block of the query in `listNextPageRecursively()`

The completed changes should look like this

```swift
var todos: [Todo] = []
var currentPage: List?

func listAllPages() 
        case .failure(let error):
            print("Got failed event with error \(error)")
        }
    }
}

func listNextPageRecursively() 
        }
    }
}
```
