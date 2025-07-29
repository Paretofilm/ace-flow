---
title: Model one-to-many relationships
source: pages/build-a-backend/data/data-modeling/relationships/index.mdx
---

# Model one-to-many relationships

meta
    }
  };
}

When modeling application data, you often need to establish relationships between different data models. In Amplify Data, you can create one-to-many, one-to-one, and many-to-many relationships in your Data schema. On the client-side, Amplify Data allows you to lazy or eager load of related data.

 ## Types of relationships

|Relationship|Code|Description|Example|
|-|-|-|-|
|one to many|`a.hasMany(...)` & `a.belongsTo(...)`|Creates a one-to-many relationship between two models.|A **Team** has many **Members**. A **Member** belongs to a **Team**.|
|one to one|`a.hasOne(...)` & `a.belongsTo(...)`|Creates a one-to-one relationship between two models.|A **Customer** has one **Cart**. A **Cart** belongs to one **Customer**.|
|many to many| Two `a.hasMany(...)` & `a.belongsTo(...)` on join tables|Create two one-to-many relationships between the related models in a join table.|A **Post** has many **Tags**. A **Tag** has many **Posts**.|

## Model one-to-many relationships

Create a one-to-many relationship between two models using the `hasMany()` and `belongsTo()` method. In the example below, a Team has many Members and a Member belongs to exactly one Team.

1. Create a **reference field** called `teamId` on the **Member** model. This reference field's type **MUST** match the type of **Team**'s identifier. In this case, it's an auto-generated `id: a.id().required()` field.
2. Add a **relationship field** called `team` that references the `teamId` field. This allows you to query for the team information from the **Member** model.
3. Add a **relationship field** called `members` that references the `teamId` field on the **Member** model.

```typescript
const schema = a.schema(),

  Team: a.model(),
}).authorization((allow) => allow.publicApiKey());
```

### Create a "Has Many" relationship between records

```ts
const  = await client.models.Team.create();

const  = await client.models.Member.create();
```

</InlineFilter>

```kt
val team = Team.builder()
    .mantra("Go Frontend!")
    .build()

Amplify.API.mutate(ModelMutation.create(team),
    ")
        val member = Member.builder()
            .name("Tim")
            .team(it.data)
            .build()

        Amplify.API.mutate(ModelMutation.create(member),
            ")},
            ,
        )
    }, )
```

</InlineFilter>

```swift
do  catch 
```

</InlineFilter>

```dart
final team = Team(mantra: "Go Frontend!");
final teamRequest = ModelMutations.create(team);
final teamResponse = await Amplify.API.mutate(request: teamRequest).response;

final member = Member(name: "Tim", team: teamResponse.data);
final memberRequest = ModelMutations.create(member);
final memberResponse = await Amplify.API.mutate(request: memberRequest).response;
```

</InlineFilter>

### Update a "Has Many" relationship between records

```ts
const  = await client.models.Team.create();

await client.models.Member.update();
```

</InlineFilter>

```kt
val newTeam = Team.builder()
    .mantra("Go Fullstack!")
    .build()

Amplify.API.mutate(ModelMutation.create(newTeam),
    ")

        val updatingMember = existingMember.copyOfBuilder().team(it.data).build()

        Amplify.API.mutate(ModelMutation.update(updatingMember),
            ")},
            ,
        )
    }, )
```

</InlineFilter>

```swift
do  catch 
```

</InlineFilter>

```dart
final newTeam = Team(mantra: "Go Fullstack!");
final newTeamRequest = ModelMutations.create(team);
final newTeamResponse = await Amplify.API.mutate(request: teamRequest).response;

final memberWithUpdatedTeam = existingMember.copyWith(team: newTeamResponse.data);
final memberUpdateRequest = ModelMutations.update(memberWithUpdatedTeam);
final memberUpdateResponse = await Amplify.API.mutate(request: memberUpdateRequest).response;
```

</InlineFilter>

### Delete a "Has Many" relationship between records

If your reference field is not required, then you can "delete" a one-to-many relationship by setting the relationship value to `null`.

```ts
await client.models.Member.update();
```

</InlineFilter>

```kt
val memberWithRemovedTeam = existingMember.copyOfBuilder().team(null).build()

Amplify.API.mutate(ModelMutation.update(memberWithRemovedTeam),
    ")},
    ,
)
```

</InlineFilter>

```swift
do  catch 
```

</InlineFilter>

```dart
final memberWithRemovedTeam = existingMember.copyWith(team: null);
final memberRemoveRequest = ModelMutations.update(memberWithRemovedTeam);
final memberRemoveResponse = await Amplify.API.mutate(request: memberRemoveRequest).response;
```

</InlineFilter>

### Load related data in a "Has Many" relationship

```dart
// Fetch the team with the team id.
final teamRequest = ModelQueries.get(
    Team.classType, TeamModelIdentifier(id: "YOUR_TEAM_ID"));
final teamResult = await Amplify.API.query(request: teamRequest).response;
final team = teamResult.data!;

// Define a limit for your pagination
const limit = 100;

// Do the initial call to get the initial items
final firstRequest = ModelQueries.list(Member.classType,
    limit: limit, where: Member.TEAMID.eq(team.id));
final firstResult = await Amplify.API.query(request: firstRequest).response;
final firstPageData = firstResult.data;

// If there are more than 100 items you can reiterate the following code to get next pages.
if (firstPageData?.hasNextResult ?? false)  else 
```

</InlineFilter>

### Lazy load a "Has Many" relationship

```ts
const  = await client.models.Team.get();

const  = await team.members();

members.forEach(member => console.log(member.id));
```

</InlineFilter>

```kt
Amplify.API.query(
    ModelQuery.get(Team::class.java, Team.TeamIdentifier("YOUR_TEAM_ID")),

                        is LazyModelList -> 
                            loadedMembers
                        }
                    }
                Log.i("MyAmplifyApp", "members: $members")
            } catch (error: ApiException) 
        }
    },
    )
```

</InlineFilter>

```swift
do 
    try await members.fetch()
    print("Number of members: \(members.count)")
} catch 
```

</InlineFilter>

### Eagerly load a "Has Many" relationship

```ts
const  = await client.models.Team.get(
  ,
  ,
);

teamWithMembers.members.forEach(member => console.log(member.id));
```

</InlineFilter>

```kt
Amplify.API.query(
    ModelQuery.get(
        Team::class.java,
        Team.TeamIdentifier("YOUR_TEAM_ID")
    ) ,
    ,
    
)
```

</InlineFilter>

```swift
do ))
        .get()
    guard let queriedTeamWithMembers, let members = queriedTeamWithMembers.members else 
    print("Number of members: \(members.count)")
} catch 
```

</InlineFilter>

</InlineFilter>

### Handling orphaned foreign keys on parent record deletion in "Has Many" relationship

```ts
// Get the IDs of the related members.
const  = await client.models.Team.get(
  ,
  ,
);

// Delete Team
await client.models.Team.delete();

// Delete all members in parallel
await Promise.all(
  teamWithMembers.members.map(member => 
  client.models.Member.delete() 
));
```

</InlineFilter>

## Model a "one-to-one" relationship

Create a one-to-one relationship between two models using the `hasOne()` and `belongsTo()` methods. In the example below, a **Customer** has a **Cart** and a *Cart* belongs to a **Customer**.

1. Create a **reference field** called `customerId` on the **Cart** model. This reference field's type **MUST** match the type of **Customer**'s identifier. In this case, it's an auto-generated `id: a.id().required()` field.
2. Add a **relationship field** called `customer` that references the `customerId` field. This allows you to query for the customer information from the **Cart** model.
3. Add a **relationship field** called `activeCart` that references the `customerId` field on the **Cart** model.

```typescript
const schema = a.schema(),
  Customer: a.model(),
}).authorization((allow) => allow.publicApiKey());
```

### Create a "Has One" relationship between records

To create a "has one" relationship between records, first create the parent item and then create the child item and assign the parent.

```ts
const  = await client.models.Customer.create();

const  = await client.models.Cart.create();
```

</InlineFilter>

```kt
val customer = Customer.builder()
    .name("Rene")
    .build()

Amplify.API.mutate(ModelMutation.create(customer),
    ")
        val cart = Cart.builder()
            .items(listOf("Tomato", "Ice", "Mint"))
            .customer(customer)
            .build()

        Amplify.API.mutate(ModelMutation.create(cart),
            ")},
            ,
        )
    }, )
```

</InlineFilter>

```swift
do  catch 
```

</InlineFilter>

```dart
final customer = Customer(name: "Rene");
final customerRequest = ModelMutations.create(customer);
final customerResponse = await Amplify.API.mutate(request: customerRequest).response;

final cart = Cart(items: ["Tomato", "Ice", "Mint"], customer: teamResponse.customer);
final cartRequest = ModelMutations.create(cart);
final cartResponse = await Amplify.API.mutate(request: cartRequest).response;
```

</InlineFilter>

### Update a "Has One" relationship between records

To update a "Has One" relationship between records, you first retrieve the child item and then update the reference to the parent to another parent. For example, to reassign a Cart to another Customer:

```ts
const  = await client.models.Customer.create();

await client.models.Cart.update();
```

</InlineFilter>

```kt
val newCustomer = Customer.builder()
    .mantra("Ian")
    .build()

Amplify.API.mutate(ModelMutation.create(newCustomer),
    ")

        val updatingCart = existingCart.copyOfBuilder().customer(it.data).build()

        Amplify.API.mutate(ModelMutation.update(updatingCart),
            ")},
            ,
        )
    }, )
```

</InlineFilter>

```swift
do  catch 
```

</InlineFilter>

```dart
final newCustomer = Customer(name: "Ian");
final newCustomerRequest = ModelMutations.create(newCustomer);
final newCustomerResponse = await Amplify.API.mutate(request: newCustomerRequest).response;

final cartWithUpdatedCustomer = existingCart.copyWith(customer: newCustomerResponse.data);
final cartUpdateRequest = ModelMutations.update(cartWithUpdatedCustomer);
final cartUpdateResponse = await Amplify.API.mutate(request: cartUpdateRequest).response;
```

</InlineFilter>

### Delete a "Has One" relationship between records

You can set the relationship field to `null` to delete a "Has One" relationship between records.

```ts
await client.models.Cart.update();
```

</InlineFilter>

You can set the relationship field to `null` to delete a "Has One" relationship between records.

```kt
val cartWithRemovedCustomer = existingCart.copyOfBuilder().customer(null).build()

Amplify.API.mutate(ModelMutation.update(cartWithRemovedCustomer),
    ")},
    ,
)
```

</InlineFilter>

You can set the relationship field to `nil` to delete a "Has One" relationship between records.

```swift
do  catch 
```

</InlineFilter>

```dart
final cartWithRemovedCustomer = existingCart.copyWith(customer: null);
final cartRemoveRequest = ModelMutations.update(cartWithRemovedCustomer);
final cartRemoveResponse = await Amplify.API.mutate(request: cartRemoveRequest).response;
```

</InlineFilter>

### Load related data in "Has One" relationships

```swift
do 

    let customer = try await queriedCart.customer
} catch 
```

</InlineFilter>

```dart
// Fetch the cart with the cart id.
final cartRequest = ModelQueries.get(
    Cart.classType, CartModelIdentifier(id: "MY_CART_ID"));
final cartResult = await Amplify.API.query(request: cartRequest).response;
final cart = cartResult.data!;

// Do the customer call to with the id from cart
if (cart.customerId != null) 
```

</InlineFilter>

</InlineFilter>

### Lazy load a "Has One" relationship

```ts
const  = await client.models.Cart.get();
const  = await cart.customer();
```

</InlineFilter>

```kt
Amplify.API.query(
  ModelQuery.get(Team::class.java, Team.TeamIdentifier("YOUR_TEAM_ID")),

                      is LazyModelReference -> 
                  }
                  Log.i("MyAmplifyApp", "customer: $customer")
              } catch (error: ApiException) 
          }
      },
      
)
```

</InlineFilter>

### Eagerly load a "Has One" relationship

```ts
const  = await client.models.Cart.get(
  ,
  ,
);

console.log(cart.customer.id)
```

</InlineFilter>

```kt
val cart = Amplify.API.query(
    ModelQuery.get(
        Cart::class.java,
        Cart.CartIdentifier("YOUR_CART_ID")
    ) ,
,
)
```

</InlineFilter>

</InlineFilter>

### Handling orphaned foreign keys on parent record deletion in "Has One" relationship

```ts
// Get the customer with their associated cart
const  = await client.models.Customer.get(
  ,
  ,
);

// Delete Cart if exists
await client.models.Cart.delete();

// Delete the customer
await client.models.Customer.delete();
```

</InlineFilter>

## Model a "many-to-many" relationship
In order to create a many-to-many relationship between two models, you have to create a model that serves as a "join table". This "join table" should contain two one-to-many relationships between the two related entities. For example, to model a **Post** that has many **Tags** and a **Tag** has many **Posts**, you'll need to create a new **PostTag** model that represents the relationship between these two entities.

```typescript
const schema = a.schema(),
  Post: a.model(),
  Tag: a.model(),
}).authorization((allow) => allow.publicApiKey());
```

## Model multiple relationships between two models

Relationships are defined uniquely by their reference fields. For example, a Post can have separate relationships with a Person model for `author` and `editor`.

```typescript
const schema = a.schema(),
  Person: a.model(),
}).authorization((allow) => allow.publicApiKey());
```

On the client-side, you can fetch the related data with the following code:

```ts
const client = generateClient();

const  = await client.models.Post.get();

const  = await post?.author();
const  = await post?.editor();
```

</InlineFilter>

```swift
 do 

    let loadedAuthor = try await queriedPost.author
    let loadedEditor = try await queriedPost.editor
} catch 
```
</InlineFilter>

## Model relationships for models with sort keys in their identifier

In cases where your data model uses sort keys in the identifier, you need to also add reference fields and store the sort key fields in the related data model:

```ts
const schema = a.schema(),
  Person: a.model().identifier(['name', 'dateOfBirth']),
}).authorization((allow) => allow.publicApiKey());
```

## Make relationships required or optional

Amplify Data's relationships use reference fields to determine if a relationship is required or not. If you mark a reference field as required, then you can't "delete" a relationship between two models. You'd have to delete the related record as a whole.

```ts
const schema = a.schema(),
  Person: a.model(),
}).authorization((allow) => allow.publicApiKey());
```
