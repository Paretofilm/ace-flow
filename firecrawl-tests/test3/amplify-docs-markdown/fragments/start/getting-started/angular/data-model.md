---
title: Creating the API with database
source: fragments/start/getting-started/angular/data-model.mdx
---

# Creating the API with database

Add a [GraphQL API](https://docs.aws.amazon.com/appsync/latest/devguide/designing-a-graphql-api.html) to your app and automatically provision a database by running the following command from the root of your application directory:

```bash
amplify add api
```

Accept the **default values** which are highlighted below:

```console
? Select from one of the below mentioned services: GraphQL
? Here is the GraphQL API that we will create. Select a setting to edit or continue: Continue
? Choose a schema template: Single object with fields (e.g., “Todo” with ID, name, description)
? Do you want to edit the schema now? (Y/n): yes
```

The generated schema is for a Todo app. Replace the GraphQL schema at `amplify/backend/api/RestaurantAPI/schema.graphql` with the following:

```graphql
type Restaurant @model @auth(rules: []) 
```

The GraphQL Transform Library provides custom directives you can use in your schema that allow you to do things like define data models, set up authentication and authorization rules, configure serverless functions as resolvers, and more. In the example schema above, the `@model` directive is part of Amplify's [GraphQL transformer](/gen1/[platform]/build-a-backend/graphqlapi/data-modeling/) functionality and the `@auth` directive determines what [authorization rules](/gen1/[platform]/build-a-backend/graphqlapi/customize-authorization-rules/) to apply.

A type decorated with the `@model` directive will scaffold out the database table for the type (Restaurant table), the schema for CRUD (create, read, update, delete) and list operations, and the GraphQL resolvers needed to make everything work together.

From the command line, press **enter** to accept the schema and continue to the next steps.

## Creating the API with database

Create required backend resources for your configured api with the following command:

```bash
amplify push

? Are you sure you want to continue? Y

? Do you want to generate code for your newly created GraphQL API: Yes
? Choose the code generation language target: typescript
? Enter the file name pattern of graphql queries, mutations and subscriptions: src/graphql/**/*.ts
? Do you want to generate/update all possible GraphQL operations - queries, mutations and subscriptions: Yes
? Enter maximum statement depth [increase from default if your schema is deeply nested]: 2
? Enter the file name for the generated code: src/API.ts
```

### Code generation

Once the deployment is complete, the CLI will create a new directory in `src/graphql` with all of the GraphQL operations you will need for your API. The CLI also created an `API.ts` file in the `src` directory that you will be using shortly.

Next, run the following command to check Amplify's status:

```bash
amplify status
```

This will give us the current status of the Amplify project, including the current environment, any categories that have been created, and what state those categories are in. It should look similar to this:

```console
Current Environment: dev

| Category | Resource name | Operation | Provider plugin   |
| -------- | ------------- | --------- | ----------------- |
| Api      | RestaurantAPI | No Change | awscloudformation |
```

### Testing your API

You can open the AWS console to run Queries, Mutation, or Subscription against your new API at any time directly by running the following command:

```bash
amplify console api
```

When prompted, select **GraphQL**. This will open the AWS AppSync console for you to run Queries, Mutations, or Subscriptions at the server and see the changes in your client app.

## Connect frontend to API

Open `src/main.ts` and add the following code to configure the Angular project with Amplify:

```typescript

Amplify.configure(amplifyconfig);
```

In order to import `amplifyconfiguration.json` files in Typescript, you may need to modify your tsconfig.json and enable `resolveJsonModule` and `allowSyntheticDefaultImports` in the case that `strict` mode is enabled.

```json

}
```

First, enable the Angular forms modules in `src/app/app.module.ts`:

```js

/* new form imports */

@NgModule()

Next, create an `restaurants` Angular component:

```
npx ng generate component restaurants
```

Open `src/app/app.component.html`, and replace the default content with the Angular component you created:

```html
<app-restaurants></app-restaurants>
```

In your `src/app/restaurants/restaurants.component.ts` file, add data to your database with a mutation by using the `API.ts` file which was generated when you ran `amplify add api`:

```typescript

@Component()

  constructor(private fb: FormBuilder) );

    this.client = generateClient();
  }

  public async onCreate(restaurant: Restaurant) 
      });
      console.log('item created!', response);
      this.createForm.reset();
    } catch (e) 
  }
}
```

Next, add a form that will be used for creating restaurants. Add the following to your `src/app/restaurants/restaurants.component.html`:

```html
<div class="form-body">
  <form
    autocomplete="off"
    [formGroup]="createForm"
    (ngSubmit)="onCreate(createForm.value)"
  >
    <div>
      <label>Name: </label>
      <input type="text" formControlName="name" autocomplete="off" />
    </div>
    <div>
      <label>Description: </label>
      <input type="text" formControlName="description" autocomplete="off" />
    </div>
    <div>
      <label>City: </label>
      <input type="text" formControlName="city" autocomplete="off" />
    </div>
    <button type="submit">Submit</button>
  </form>
</div>
```

Next, update your `RestaurantsComponent` class so that it will list all restaurants in the database when the app starts. To do so, implement [OnInit](https://angular.io/api/core/OnInit) and add a `ListRestaurants` query in `src/app/restaurants/restaurants.component.ts`. Store the query results in an array.

```typescript

@Component()

  /* declare restaurants variable */
  public restaurants: ListRestaurantsQuery['listRestaurants'];

  constructor(private fb: FormBuilder) );

    this.client = generateClient();
  }

  async ngOnInit() );
      this.restaurants = response.data.listTodos;
    } catch (e) 
  }

  public async onCreate(restaurant: Restaurant) 
      });
      console.log('item created!', response);
      this.createForm.reset();
    } catch (e) 
  }
}
```

Add the following to your `src/app/restaurants/restaurants.component.html` to display any of the restaurants you have added:

```html
<div *ngFor="let restaurant of restaurants?.items">
  <div>}</div>
  <div>}</div>
  <div>}</div>
</div>
```

To subscribe to realtime data, declare a subscription class variable and update `ngOnInit` in `src/app/restaurants.component.ts`. When the app starts, this code will set up a subscription. The subscription will update the `restaurants` array when new events are received (when a new restaurant is created):

```typescript
...

private subscription: any = null;

async ngOnInit() )
    console.log(res)

    this.restaurants = res.data.listRestaurants;
  } catch(e) ;

  /* subscribe to new restaurants being created */
  this.subscription = this.client.graphql().subscribe((event: any) => );
}
```

Finally, unsubscribe from the subscription when the component is destroyed. Import and add `OnDestroy` in `src/app/restaurants.component.ts`:

```typescript

...

  ...

  ngOnDestroy() 
    this.subscription = null;
  }
}
```

The final `restaurants.component.ts` file should look like the following:

```typescript

@Component()

  constructor(private fb: FormBuilder) );

    this.client = generateClient();
  }

  async ngOnInit() );
      console.log(res);
      this.restaurants = res.data.listRestaurants;
    } catch (e) 

    this.subscription = this.client
      .graphql()
      .subscribe((event: any) => );
  }

  ngOnDestroy() 
    this.subscription = null;
  }

  public async onCreate(restaurant: Restaurant) 
      });
      console.log('item created!', res);
      this.createForm.reset();
    } catch (e) 
  }
}
```

Next, run the app:

```bash
npm start
```

Now, open the app in 2 browser windows (both at http://localhost:4200) so that you have your app running side by side. When creating a new item in one window, you should see it come through in the other window in real-time.
