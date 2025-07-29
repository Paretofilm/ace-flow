---
title: Query by Id
source: fragments/lib/graphqlapi/ios/query-data.mdx
---

# Query by Id

## Query by Id

Now that you were able to make a mutation, take the `Id` that was printed out and use it in your query to retrieve data.

```swift
func getTodo() async 
            print("Successfully retrieved todo: \(todo)")
        case .failure(let error):
            print("Got failed result with \(error.errorDescription)")
        }
    } catch let error as APIError  catch 
}
```

</Block>

```swift
func getTodo() -> AnyCancellable 
    .sink 
    }
    receiveValue: 
            print("Successfully retrieved todo: \(todo)")
        case .failure(let error):
            print("Got failed result with \(error.errorDescription)")
        }
    }
    return sink
}
```

</Block>

</BlockSwitcher>

## List Query

You can get the list of items using `.list` with optional parameters `limit` and `where` to specify the page size and condition. By default, the page size is 1000.

```swift
func listTodos() async 
    } catch let error as APIError  catch 
}
```

</Block>

```swift
func listTodos() -> AnyCancellable 
    .sink 
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

func listFirstPage() async 
    } catch let error as APIError  catch 
}

func listNextPage() async  catch 
    }
}
```

## List all pages

If you want to get all pages, retrieve the subsequent page when you have successfully retrieved the first or next page.

1. Update the above method `listFirstPage()` to `listAllPages()`
2. Call `listNextPageRecursively()` in the success block of the query in `listAllPages()`
2. Update the `listNextPage()` to `listNextPageRecursively()`
3. Call `listNextPageRecursively()` in the success block of the query in `listNextPageRecursively()`

The completed changes should look like this:

```swift
var todos: [Todo] = []
var currentPage: List?

func listAllPages() async 
    } catch let error as APIError  catch 
}

func listNextPageRecursively() async  catch 
    }
}
```
