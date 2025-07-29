---
title: How to use a Swift Actor to perform optimistic UI updates
source: fragments/lib/graphqlapi/ios/optimistic-ui.mdx
---

# How to use a Swift Actor to perform optimistic UI updates

Implementing optimistic UI with GraphQL API category allows CRUD operations to be rendered immediately on the UI before the request roundtrip has completed, and allows you to rollback changes on the UI when API calls are unsuccessful.

In the following example, we'll create a list view that optimistically renders newly created items, updates and deletes.

> **Note**: 

For more on the Amplify GraphQL API, see the [API documentation](/gen1/[platform]/build-a-backend/graphqlapi/set-up-graphql-api/).

To get started, go to your project directory and run the command:

```bash
amplify add api
```

Choose the following when prompted: 

```bash
? Select from one of the below mentioned services: `GraphQL`
? Here is the GraphQL API that we will create. Select a setting to edit or continue Authorization modes: `API key (default, expiration time: 7 days from now)`
? Choose the default authorization type for the API `API key`
✔ Enter a description for the API key: · 
✔ After how many days from now the API key should expire (1-365): · `365`
? Configure additional auth types? `No`
? Here is the GraphQL API that we will create. Select a setting to edit or continue `Continue`
? Choose a schema template: `Blank Schema`
```

The schema file can also be found under `amplify/backend/api/[name of project]/schema.graphql`. Replace it with the following contents:

```graphql
type RealEstateProperty @model @auth(rules: []) 
```

Save the schema and run `amplify push` to deploy the changes. For the purposes of this guide, we'll build a Real Estate Property listing application.

Once the backend has been provisioned, run `amplify codegen models` to generate the Swift model types for the app.

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

Calling the `listProperties()` method will perform a query with GraphQL API and store the results in the `properties` property. When this property is set, the list is sent back to the subscribers. In your UI, create a view model and subscribe to updates:

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

To optimistically render a newly created record returned from the GraphQL API, add a method to the `actor RealEstatePropertyList`:

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

To optimistically render a GraphQL API delete, use the code snippet like below:

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
