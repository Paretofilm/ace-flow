---
title: How to use TanStack Query query keys with the GraphQL API
source: fragments/lib-v1/graphqlapi/js/optimistic-ui.mdx
---

# How to use TanStack Query query keys with the GraphQL API

The GraphQL API category can be used with [TanStack Query](https://tanstack.com/query/latest/docs/react/overview) to implement optimistic UI, allowing CRUD operations to be rendered immediately on the UI before the request roundtrip has completed. Using the GraphQL API with TanStack additionally makes it easy to render loading and error states, and allows you to rollback changes on the UI when API calls are unsuccessful.

In the following examples we'll create a list view that optimistically renders newly created items, and a detail view that optimistically renders updates and deletes.

> **Note**: 

For more details on TanStack Query, including requirements, supported browsers, and advanced usage, see the [TanStack Query documentation](https://tanstack.com/query/latest/docs/react/overview). 
For complete guidance on how to implement optimistic updates with TanStack Query, see the [TanStack Query Optimistic UI Documentation](https://tanstack.com/query/latest/docs/react/guides/optimistic-updates).
For more on the Amplify GraphQL API, see the [API documentation](/gen1/[platform]/prev/build-a-backend/graphqlapi/set-up-graphql-api/).

To get started, run the following command in an existing Amplify project with a React frontend:

```bash
# Install TanStack Query
npm i @tanstack/react-query

# Select default configuration
amplify add api              
```

When prompted, use the following schema:

```graphql
type RealEstateProperty @model @auth(rules: []) 
```
The schema file can also be found under `amplify/backend/api/[name of project]/schema.graphql`.
Save the schema and run `amplify push` to deploy the changes. For the purposes of this guide, we'll build a Real Estate Property listing application.

Next, at the root of your project, add the required TanStack Query imports, and create a client:

```ts

// Create a client
const queryClient = new QueryClient()
```

Next, wrap your app in the client provider:

```ts

</QueryClientProvider>
```

> **Note**: 

TanStack Query Devtools are not required, but are a useful resource for debugging and understanding how TanStack works under the hood. By default, React Query Devtools are only included in bundles when `process.env.NODE_ENV === 'development'`, meaning that no additional configuration is required to exclude them from a production build. 
For more information on the TanStack Query Devtools, visit the [TanStack Query Devtools docs](https://tanstack.com/query/latest/docs/react/devtools)

> **Note**: 

For the complete working example, including required imports and React component state management, see the [Complete Example](#complete-example) below.

## How to use TanStack Query query keys with the GraphQL API

TanStack Query manages query caching based on the query keys you specify. A query key must be an array. The array can contain a single string or multiple strings and nested objects. The query key must be serializable, and unique to the query's data. 

When using TanStack to render optimistic UI with the GraphQL API, it is important to note that different query keys must be used depending on the API operation. When retrieving a list of items, a single string is used (e.g. `queryKey: ["realEstateProperties"]`). This query key is also used to optimistically render a newly created item. When updating or deleting an item, the query key must also include the unique identifier for the record being deleted or updated (e.g. `queryKey: ["realEstateProperties", newRealEstateProperty.id]`).

For more detailed information on query keys, see the [TanStack Query documentation](https://tanstack.com/query/v4/docs/react/guides/query-keys).

## Optimistically rendering a list of records

To optimistically render a list of items returned from the GraphQL API, use the TanStack `useQuery` hook, passing in the GraphQL API query as the `queryFn` parameter. The following example creates a query to retrieve all records from the API. We'll use `realEstateProperties` as the query key, which will be the same key we use to optimistically render a newly created item.

```ts
const  = useQuery();

    const allRealEstateProperties =
      response?.data?.listRealEstateProperties?.items;

    if (!allRealEstateProperties) return null;

    return allRealEstateProperties;
  },
});
``` 

</Block>

```js
const  = useQuery();

    const allRealEstateProperties =
      response?.data?.listRealEstateProperties?.items;

    if (!allRealEstateProperties) return null;

    return allRealEstateProperties;
  },
});
```

</Block>

</BlockSwitcher>

## Optimistically rendering a newly created record

To optimistically render a newly created record returned from the GraphQL API, use the TanStack `useMutation` hook, passing in the GraphQL API mutation as the `mutationFn` parameter. We'll use the same query key used by the `useQuery` hook (`realEstateProperties`) as the query key to optimistically render a newly created item.
We'll use the `onMutate` function to update the cache directly, as well as the `onError` function to rollback changes when a request fails.

```ts
const createMutation = useMutation(,
    });

    const newRealEstateProperty = response?.data?.createRealEstateProperty;
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
``` 

</Block>

```js
const createMutation = useMutation(,
    });

    const newRealEstateProperty = response?.data?.createRealEstateProperty;
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
```

</Block>

</BlockSwitcher>

## Querying a single item with TanStack Query

To optimistically render updates on a single item, we'll first retrieve the item from the API. We'll use the `useQuery` hook, passing in the GraphQL API query as the `queryFn` parameter. For the query key, we'll use a combination of `realEstateProperties` and the record's unique identifier.

```ts
const  = useQuery(,
    });

    return response.data?.getRealEstateProperty;
  },
});
``` 

</Block>

```js
const  = useQuery(,
    });

    return response.data?.getRealEstateProperty;
  },
});
```

</Block>

</BlockSwitcher>

## Optimistically render updates for a record

To optimistically render GraphQL API updates for a single record, use the TanStack `useMutation` hook, passing in the GraphQL API update mutation as the `mutationFn` parameter. We'll use the same query key combination used by the single record `useQuery` hook (`realEstateProperties` and the record's `id`) as the query key to optimistically render the updates.
We'll use the `onMutate` function to update the cache directly, as well as the `onError` function to rollback changes when a request fails.

> **Note**: 

When directly interacting with the cache via the `onMutate` function, it should be noted that the `newRealEstateProperty` parameter only includes the fields that are being updated, until the final return from the GraphQL API returns all fields for the record. When calling `setQueryData`, include the previous values for all fields in addition to the newly updated fields to avoid only rendering optimistic values for updated fields on the UI.

```ts
const updateMutation = useMutation(,
    });

    return response?.data?.updateRealEstateProperty;
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
``` 

</Block>

```js
const updateMutation = useMutation(,
    });

    return response?.data?.updateRealEstateProperty;
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
```

</Block>

</BlockSwitcher>

## Optimistically render deleting a record

To optimistically render a GraphQL API delete of a single record, use the TanStack `useMutation` hook, passing in the GraphQL API delete mutation as the `mutationFn` parameter. We'll use the same query key combination used by the single record `useQuery` hook (`realEstateProperties` and the record's `id`) as the query key to optimistically render the updates.
We'll use the `onMutate` function to update the cache directly, as well as the `onError` function to rollback changes when a delete fails.

```ts
const deleteMutation = useMutation(,
    });

    return response?.data?.deleteRealEstateProperty;
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
``` 

</Block>

```js
const deleteMutation = useMutation(,
    });

    return response?.data?.deleteRealEstateProperty;
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
```

</Block>

</BlockSwitcher>

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

</Block>

```js
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

</Block>

</BlockSwitcher>

## Complete example

```ts
// index.tsx:
import "./index.css";
import "@aws-amplify/ui-react/styles.css";

Amplify.configure(awsExports);

// Create a client
const queryClient = new QueryClient();

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

// Provide the client to your App
root.render(

    </QueryClientProvider>
  </React.StrictMode>
);

// App.tsx:
import  from "./API";

/**
 * https://www.tanstack.com/query/v4/docs/react/guides/background-fetching-indicators#displaying-global-background-fetching-loading-state
 * For the purposes of this demo, we show a global loading indicator when *any*
 * queries are fetching (including in the background) in order to help visualize
 * what TanStack is doing in the background. This example also displays
 * indicators for individual query and mutation loading states.
 */
function GlobalLoadingIndicator() ></div> : null;
}

function App()  = useQuery();

      const allRealEstateProperties =
        response?.data?.listRealEstateProperties?.items;

      if (!allRealEstateProperties) return null;

      return allRealEstateProperties;
    },
  });

  // TanStack create mutation with optimistic updates
  const createMutation = useMutation(,
      });

      const newRealEstateProperty = response?.data?.createRealEstateProperty;
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

  /**
   * Note: this example does not return to the list view on delete in order
   * to demonstrate the optimistic update.
   */
  function RealEstatePropertyDetailView()  = useQuery(,
        });

        return response.data?.getRealEstateProperty;
      },
    });

    // TanStack update mutation with optimistic updates
    const updateMutation = useMutation(,
        });

        return response?.data?.updateRealEstateProperty;
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

    // TanStack delete mutation with optimistic updates
    const deleteMutation = useMutation(,
        });

        return response?.data?.deleteRealEstateProperty;
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

const styles: any = ,
  detailViewButton: ,
  detailViewContainer: ,
  globalLoadingIndicator: ,
  listItem: ,
  loadingIndicator: ,
  propertiesList: ,
};
``` 

</Block>

```js
// index.jsx
import "./index.css";
import "@aws-amplify/ui-react/styles.css";

Amplify.configure(awsExports);

// Create a client
const queryClient = new QueryClient();

const root = ReactDOM.createRoot(document.getElementById("root"));

// Provide the client to your App
root.render(

    </QueryClientProvider>
  </React.StrictMode>
);

// App.jsx

/**
 * https://www.tanstack.com/query/v4/docs/react/guides/background-fetching-indicators#displaying-global-background-fetching-loading-state
 * For the purposes of this demo, we show a global loading indicator when *any*
 * queries are fetching (including in the background) in order to help visualize
 * what TanStack is doing in the background. This example also displays
 * indicators for individual query and mutation loading states.
 */
function GlobalLoadingIndicator() ></div> : null;
}

function App()  = useQuery();

      const allRealEstateProperties =
        response?.data?.listRealEstateProperties?.items;

      if (!allRealEstateProperties) return null;

      return allRealEstateProperties;
    },
  });

  // TanStack create mutation with optimistic updates
  const createMutation = useMutation(,
      });

      const newRealEstateProperty = response?.data?.createRealEstateProperty;
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

  /**
   * Note: this example does not return to the list view on delete in order
   * to demonstrate the optimistic update.
   */
  function RealEstatePropertyDetailView()  = useQuery(,
        });

        return response.data?.getRealEstateProperty;
      },
    });

    // TanStack update mutation with optimistic updates
    const updateMutation = useMutation(,
        });

        return response?.data?.updateRealEstateProperty;
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

    // TanStack delete mutation with optimistic updates
    const deleteMutation = useMutation(,
        });

        return response?.data?.deleteRealEstateProperty;
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
};
```

</Block>

</BlockSwitcher>
