---
title: How to use TanStack Query query keys with the Amplify Data API
source: pages/build-a-backend/data/optimistic-ui/index.mdx
---

# How to use TanStack Query query keys with the Amplify Data API

Amplify Data can be used with [TanStack Query](https://tanstack.com/query/latest/docs/react/overview) to implement optimistic UI, allowing CRUD operations to be rendered immediately on the UI before the request roundtrip has completed. Using Amplify Data with TanStack additionally makes it easy to render loading and error states, and allows you to rollback changes on the UI when API calls are unsuccessful.

In the following examples we'll create a list view that optimistically renders newly created items, and a detail view that optimistically renders updates and deletes.

> **Note**: 

For more details on TanStack Query, including requirements, supported browsers, and advanced usage, see the [TanStack Query documentation](https://tanstack.com/query/latest/docs/react/overview).
For complete guidance on how to implement optimistic updates with TanStack Query, see the [TanStack Query Optimistic UI Documentation](https://tanstack.com/query/latest/docs/react/guides/optimistic-updates).
For more on Amplify Data, see the [API documentation](/[platform]/build-a-backend/data/set-up-data/).

To get started, run the following command in an existing Amplify project with a React frontend:

```bash title="Terminal" showLineNumbers=
npm add @tanstack/react-query && \
npm add --save-dev @tanstack/react-query-devtools
```

Modify your Data schema to use this "Real Estate Property" example:

```ts title="amplify/data/resource.ts"
const schema = a.schema().authorization(allow => [allow.guest()])
})

Save the file and run `npx ampx sandbox` to deploy the changes to your backend cloud sandbox. For the purposes of this guide, we'll build a Real Estate Property listing application.

Next, at the root of your project, add the required TanStack Query imports, and create a client:

```ts title="src/main.tsx"
import './index.css'
// highlight-start
// highlight-end

Amplify.configure(outputs)

const queryClient = new QueryClient()

ReactDOM.createRoot(document.getElementById('root')!).render(
  
    // highlight-start

    </QueryClientProvider>
    // highlight-end
  </React.StrictMode>,
)
```

> **Note**: 

TanStack Query Devtools are not required, but are a useful resource for debugging and understanding how TanStack works under the hood. By default, React Query Devtools are only included in bundles when `process.env.NODE_ENV === 'development'`, meaning that no additional configuration is required to exclude them from a production build.
For more information on the TanStack Query Devtools, visit the [TanStack Query Devtools docs](https://tanstack.com/query/latest/docs/react/devtools)

> **Note**: 

For the complete working example, including required imports and React component state management, see the [Complete Example](#complete-example) below.

## How to use TanStack Query query keys with the Amplify Data API

TanStack Query manages query caching based on the query keys you specify. A query key must be an array. The array can contain a single string or multiple strings and nested objects. The query key must be serializable, and unique to the query's data.

When using TanStack to render optimistic UI with Amplify Data, you must use different query keys depending on the API operation. When retrieving a list of items, a single string is used (e.g. `queryKey: ["realEstateProperties"]`). This query key is also used to optimistically render a newly created item. When updating or deleting an item, the query key must also include the unique identifier for the record being deleted or updated (e.g. `queryKey: ["realEstateProperties", newRealEstateProperty.id]`).

For more detailed information on query keys, see the [TanStack Query documentation](https://tanstack.com/query/v4/docs/react/guides/query-keys).

## Optimistically rendering a list of records

To optimistically render a list of items returned from the Amplify Data API, use the TanStack `useQuery` hook, passing in the Data API query as the `queryFn` parameter. The following example creates a query to retrieve all records from the API. We'll use `realEstateProperties` as the query key, which will be the same key we use to optimistically render a newly created item.

```ts title="src/App.tsx"
// highlight-start

const client = generateClient();
// highlight-end

function App()  = useQuery(,
  });
  // highlight-end
  // return ...
}
```

## Optimistically rendering a newly created record

To optimistically render a newly created record returned from the Amplify Data API, use the TanStack `useMutation` hook, passing in the Amplify Data API mutation as the `mutationFn` parameter. We'll use the same query key used by the `useQuery` hook (`realEstateProperties`) as the query key to optimistically render a newly created item.
We'll use the `onMutate` function to update the cache directly, as well as the `onError` function to rollback changes when a request fails.

```ts
// highlight-next-line

const client = generateClient()

function App() ) =>  = await client.models.RealEstateProperty.create(input)
      return newRealEstateProperty;
    },
    // When mutate is called:
    onMutate: async (newRealEstateProperty) => );

      // Snapshot the previous value
      const previousRealEstateProperties = queryClient.getQueryData([
        "realEstateProperties",
      ]);

      // Optimistically update to the new value
      if (previousRealEstateProperties) 

      // Return a context object with the snapshotted value
      return ;
    },
    // If the mutation fails,
    // use the context returned from onMutate to rollback
    onError: (err, newRealEstateProperty, context) => 
    },
    // Always refetch after error or success:
    onSettled: () => );
    },
  });
  // highlight-end
  // return ...
}
```

## Querying a single item with TanStack Query

To optimistically render updates on a single item, we'll first retrieve the item from the API. We'll use the `useQuery` hook, passing in the `get` query as the `queryFn` parameter. For the query key, we'll use a combination of `realEstateProperties` and the record's unique identifier.

```ts

const client = generateClient()

function App()  = useQuery(

      const  = await client.models.RealEstateProperty.get();
      return property;
    },
  });
  // highlight-end
}
```

## Optimistically render updates for a record

To optimistically render Amplify Data updates for a single record, use the TanStack `useMutation` hook, passing in the update mutation as the `mutationFn` parameter. We'll use the same query key combination used by the single record `useQuery` hook (`realEstateProperties` and the record's `id`) as the query key to optimistically render the updates.
We'll use the `onMutate` function to update the cache directly, as well as the `onError` function to rollback changes when a request fails.

> **Note**: 

When directly interacting with the cache via the `onMutate` function, the `newRealEstateProperty` parameter will only include fields that are being updated. When calling `setQueryData`, include the previous values for all fields in addition to the newly updated fields to avoid only rendering optimistic values for updated fields on the UI.

```ts title="src/App.tsx"

const client = generateClient()

function App() ) =>  = await client.models.RealEstateProperty.update(realEstatePropertyDetails);

      return updatedProperty;
    },
    // When mutate is called:
    onMutate: async (newRealEstateProperty: ) => );

      await queryClient.cancelQueries();

      // Snapshot the previous value
      const previousRealEstateProperty = queryClient.getQueryData([
        "realEstateProperties",
        newRealEstateProperty.id,
      ]);

      // Optimistically update to the new value
      if (previousRealEstateProperty) 
        );
      }

      // Return a context with the previous and new realEstateProperty
      return ;
    },
    // If the mutation fails, use the context we returned above
    onError: (err, newRealEstateProperty, context) => 
    },
    // Always refetch after error or success:
    onSettled: (newRealEstateProperty) => );
        queryClient.invalidateQueries();
      }
    },
  });
  // highlight-end
}
```

## Optimistically render deleting a record

To optimistically render a deletion of a single record, use the TanStack `useMutation` hook, passing in the delete mutation as the `mutationFn` parameter. We'll use the same query key combination used by the single record `useQuery` hook (`realEstateProperties` and the record's `id`) as the query key to optimistically render the updates.
We'll use the `onMutate` function to update the cache directly, as well as the `onError` function to rollback changes when a delete fails.

```ts title="src/App.tsx"

const client = generateClient()

function App() ) =>  = await client.models.RealEstateProperty.delete(realEstatePropertyDetails);
      return deletedProperty;
    },
    // When mutate is called:
    onMutate: async (newRealEstateProperty) => );

      await queryClient.cancelQueries();

      // Snapshot the previous value
      const previousRealEstateProperty = queryClient.getQueryData([
        "realEstateProperties",
        newRealEstateProperty.id,
      ]);

      // Optimistically update to the new value
      if (previousRealEstateProperty) 

      // Return a context with the previous and new realEstateProperty
      return ;
    },
    // If the mutation fails, use the context we returned above
    onError: (err, newRealEstateProperty, context) => 
    },
    // Always refetch after error or success:
    onSettled: (newRealEstateProperty) => );
        queryClient.invalidateQueries();
      }
    },
  });
  // highlight-end
}
```

## Loading and error states for optimistically rendered data

Both `useQuery` and `useMutation` return `isLoading` and `isError` states that indicate the current state of the query or mutation. You can use these states to render loading and error indicators.

In addition to operation-specific loading states, TanStack Query provides a [`useIsFetching` hook](https://www.tanstack.com/query/v4/docs/react/guides/background-fetching-indicators#displaying-global-background-fetching-loading-state). For the purposes of this demo, we show a global loading indicator in the [Complete Example](#complete-example) when *any* queries are fetching (including in the background) in order to help visualize what TanStack is doing in the background:

```js
function GlobalLoadingIndicator() ></div> : null;
}
```

For more details on advanced usage of TanStack Query hooks, see the [TanStack documentation](https://tanstack.com/query/latest/docs/react/guides/mutations).

The following example demonstrates how to use the state returned by TanStack to render a loading indicator while a mutation is in progress, and an error message if the mutation fails. For additional examples, see the [Complete Example](#complete-example) below.

```ts
<>
  </div>
  ) : null}

  <button
    onClick= Main St`,
      })
    }
  >
    Update Address
  </button>
</>
```

## Complete example

```tsx title="src/main.tsx"
import './index.css'

Amplify.configure(outputs)

ReactDOM.createRoot(document.getElementById('root')!).render(

    </QueryClientProvider>
  </React.StrictMode>,
)
```

```tsx title="src/App.tsx"
import './App.css'

const client = generateClient()

function GlobalLoadingIndicator() ></div> : null;
}

function App()  = useQuery(,
  });

  const createMutation = useMutation() =>  = await client.models.RealEstateProperty.create(input)
      return newRealEstateProperty;
    },
    // When mutate is called:
    onMutate: async (newRealEstateProperty) => );

      // Snapshot the previous value
      const previousRealEstateProperties = queryClient.getQueryData([
        "realEstateProperties",
      ]);

      // Optimistically update to the new value
      if (previousRealEstateProperties) 

      // Return a context object with the snapshotted value
      return ;
    },
    // If the mutation fails,
    // use the context returned from onMutate to rollback
    onError: (err, newRealEstateProperty, context) => 
    },
    // Always refetch after error or success:
    onSettled: () => );
    },
  });

  function RealEstatePropertyDetailView()  = useQuery(

        const  = await client.models.RealEstateProperty.get();
        return property
      },
    });

    const updateMutation = useMutation() =>  = await client.models.RealEstateProperty.update(realEstatePropertyDetails);

        return updatedProperty;
      },
      // When mutate is called:
      onMutate: async (newRealEstateProperty: ) => );

        await queryClient.cancelQueries();

        // Snapshot the previous value
        const previousRealEstateProperty = queryClient.getQueryData([
          "realEstateProperties",
          newRealEstateProperty.id,
        ]);

        // Optimistically update to the new value
        if (previousRealEstateProperty) 
          );
        }

        // Return a context with the previous and new realEstateProperty
        return ;
      },
      // If the mutation fails, use the context we returned above
      onError: (err, newRealEstateProperty, context) => 
      },
      // Always refetch after error or success:
      onSettled: (newRealEstateProperty) => );
          queryClient.invalidateQueries();
        }
      },
    });

    const deleteMutation = useMutation() =>  = await client.models.RealEstateProperty.delete(realEstatePropertyDetails);
        return deletedProperty;
      },
      // When mutate is called:
      onMutate: async (newRealEstateProperty) => );

        await queryClient.cancelQueries();

        // Snapshot the previous value
        const previousRealEstateProperty = queryClient.getQueryData([
          "realEstateProperties",
          newRealEstateProperty.id,
        ]);

        // Optimistically update to the new value
        if (previousRealEstateProperty) 

        // Return a context with the previous and new realEstateProperty
        return ;
      },
      // If the mutation fails, use the context we returned above
      onError: (err, newRealEstateProperty, context) => 
      },
      // Always refetch after error or success:
      onSettled: (newRealEstateProperty) => );
          queryClient.invalidateQueries();
        }
      },
    });

    return (
      <div style=>
        <h2>Real Estate Property Detail View</h2>
        </div>}
        >
            
          </div>
        )}
        `}</p>
            <p>`}</p>
          </div>
        )}
        </div>
                  ) : null}

                  <button
                    onClick=`,
                      })
                    }
                  >
                    Update Name
                  </button>
                  <button
                    onClick= Main St`,
                      })
                    }
                  >
                    Update Address
                  </button>
                </>
              )}
            </div>

            <div>
              </div>
                  ) : null}

                  <button
                    onClick=)
                    }
                  >
                    Delete
                  </button>
                </>
              )}
            </div>
          </div>
        )}
        <button onClick=>
          Back
        </button>
      </div>
    );

  }
  return (
    <div>
      >
          <h1>Real Estate Properties:</h1>
          <div>
            </div>
                ) : null}

                <button
                  onClick=`,
                      address: `$ Main St`,
                    });
                  }}
                >
                  Add RealEstateProperty
                </button>
              </>
            )}
          </div>
          <ul style=>
            >
                
              </div>
            )}
            </div>
            )}
            
                    key=-$`}
                  >
                    <p></p>
                    <button
                      style=
                      onClick=
                    >
                      Detail View
                    </button>
                  </li>
                );
              })}
          </ul>
        </div>
      )}

    </div>
  );

}

const styles = ,
  detailViewButton: ,
  detailViewContainer: ,
  globalLoadingIndicator: ,
  listItem: ,
  loadingIndicator: ,
  propertiesList: ,
} as const;
```

</InlineFilter>

Implementing optimistic UI with Amplify Data allows CRUD operations to be rendered immediately on the UI before the request roundtrip has completed, and allows you to rollback changes on the UI when API calls are unsuccessful.

In the following example, we'll create a list view that optimistically renders newly created items, updates and deletes.  Modify your Data schema to use this "Real Estate Property" example:

```ts title="amplify/data/resource.ts"
const schema = a.schema().authorization(allow => [allow.guest()])
})

Save the file and run `npx ampx sandbox` to deploy the changes to your backend cloud sandbox. For the purposes of this guide, we'll build a Real Estate Property listing application.

Once the backend has been provisioned, run `npx ampx generate graphql-client-code --format modelgen --model-target swift --out <path_to_swift_project>/AmplifyModels` to generate the Swift model types for the app.

Next, add the Amplify(`https://github.com/aws-amplify/amplify-swift.git`) package to your Xcode project and select the following modules to import when prompted:

- AWSAPIPlugin
- AWSCognitoAuthPlugin
- AWSS3StoragePlugin
- Amplify

> **Note**: 

For the complete working example see the [Complete Example](#complete-example) below.

## How to use a Swift Actor to perform optimistic UI updates

A Swift actor serializes access to its underlying properties. In this example, the actor will hold a list of items that will be published to the UI through a Combine publisher whenever the list is accessed. On a high level, the methods on the actor will perform the following:

- create a new model, add it to the list, remove the newly added item from the list if the API request is unsuccessful
- update the existing model in the list, revert the update on the list if the API request is unsuccessful
- delete the existing model from the list, add the item back into the list if the API request is unsuccessful

By providing these methods through an actor object, the underlying list will be accessed serially so that the entire operation can be rolled back if needed.

To create an actor object that allows optimistic UI updates, create a new file and add the following code.

```swift
import Amplify
import SwiftUI
import Combine

actor RealEstatePropertyList )
        }
    }

    private let subject = PassthroughSubject<[RealEstateProperty], Never>()
    var publisher: AnyPublisher<[RealEstateProperty], Never> 

    func listProperties() async throws 
        properties = propertyList.elements
    }
}
```

Calling the `listProperties()` method will perform a query with Amplify Data API and store the results in the `properties` property. When this property is set, the list is sent back to the subscribers. In your UI, create a view model and subscribe to updates:

```swift
class RealEstatePropertyContainerViewModel: ObservableObject 
        }
    }

    func loadList() 
    }
}

struct RealEstatePropertyContainerView: View 
}
```

## Optimistically rendering a newly created record

To optimistically render a newly created record returned from the Amplify Data API, add a method to the `actor RealEstatePropertyList`:

```swift
func createProperty(name: String, address: String? = nil) 
            print("Failed with error: ", graphQLResponse)
            // Remove the newly created property
            if let index = properties.firstIndex(where: ) 
        } catch ) 
        }
    }
}
```

## Optimistically rendering a record update

To optimistically render updates on a single item, use the code snippet like below:

```swift
func updateProperty(_ property: RealEstateProperty) async ) else 

    // Optimistically update the property, for the UI to render.
    let rollbackProperty = properties[index]
    properties[index] = property

    do 
        print("Failed with error: ", graphQLResponse)
        properties[index] = rollbackProperty
    } catch 
}
```

## Optimistically render deleting a record

To optimistically render a Amplify Data API delete, use the code snippet like below:

```swift
func deleteProperty(_ property: RealEstateProperty) async ) else 

  // Optimistically remove the property, for the UI to render.
  let rollbackProperty = properties[index]
  properties[index] = nil

  do 

  } catch 
}
```

## Complete example

```swift
import SwiftUI
import Amplify
import AWSAPIPlugin

@main
struct OptimisticUIApp: App  catch 
    }

    var body: some Scene 
    }
}

// Extend the model to Identifiable to make it compatible with SwiftUI's `ForEach`.
extension RealEstateProperty: Identifiable 

struct TappedButtonStyle: ButtonStyle 
}
```

</Block>

```swift
actor RealEstatePropertyList )
        }
    }

    private let subject = PassthroughSubject<[RealEstateProperty], Never>()
    var publisher: AnyPublisher<[RealEstateProperty], Never> 

    func listProperties() async throws 
        properties = propertyList.elements
    }

    func createProperty(name: String, address: String? = nil) 
                print("Failed with error: ", graphQLResponse)
                // Remove the newly created property
                if let index = properties.firstIndex(where: ) 
            } catch ) 
            }
        }
    }

    func updateProperty(_ property: RealEstateProperty) async ) else 

        // Optimistically update the property, for the UI to render.
        let rollbackProperty = properties[index]
        properties[index] = property

        do 
            print("Failed with error: ", graphQLResponse)
            properties[index] = rollbackProperty
        } catch 
    }

    func deleteProperty(_ property: RealEstateProperty) async ) else 

        // Optimistically remove the property, for the UI to render.
        let rollbackProperty = properties[index]
        properties[index] = nil

        do 

        } catch 
    }
}

```

</Block>

```swift
class RealEstatePropertyContainerViewModel: ObservableObject 
        }
    }

    func loadList() 
    }
    func createPropertyButtonTapped(name: String) 
    }

    func updatePropertyButtonTapped(_ property: RealEstateProperty) 
    }

    func deletePropertyButtonTapped(_ property: RealEstateProperty) 
    }
}

struct RealEstatePropertyContainerView: View 
                            Button  label: 

                        }.padding(.horizontal)
                    }
                }
            }.refreshable 
            TextField("New property name", text: $propertyName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)

            Button("Save") 
            .buttonStyle(TappedButtonStyle())
        }.task 
    }
}

struct RealEstatePropertyContainerView_Previews: PreviewProvider 
}
```

</Block>

</BlockSwitcher>

</InlineFilter>
