---
title: Configure Amplify
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/start/getting-started/flutter/integrate.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Configure Amplify

In this section you'll integrate Amplify API with your app, and use the generated data model to create, update, query, and delete BudgetEntry items in your app.

First, replace the contents of your *main.dart* file with the following UI boilerplate code. Typically, you would break this file up into smaller modules but we've kept it as a single file here just for the tutorial.

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/ModelProvider.dart';

Future<void> main() async 

Future<void> _configureAmplify() async 

class MyApp extends StatelessWidget );

  // GoRouter configuration
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) 
}

class LoadingScreen extends StatelessWidget );

  @override
  Widget build(BuildContext context) 
}

class HomeScreen extends StatefulWidget );

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State 

  Future<void> _refreshBudgetEntries() async 

  Future<void> _deleteBudgetEntry(BudgetEntry budgetEntry) async 

  Future<void> _navigateToBudgetEntry() async 

  double _calculateTotalBudget(List items) 
    return totalAmount;
  }

  Widget _buildRow() 

  @override
  Widget build(BuildContext context) ',
                        style: const TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                const SizedBox(height: 30),
                _buildRow(
                  title: 'Title',
                  description: 'Description',
                  amount: 'Amount',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _budgetEntries.length,
                    itemBuilder: (context, index) ',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

Go ahead and run your code now on any mobile, web, or desktop device and you should see an app with some titles
and a floating action button but not much else.

```bash
flutter run
```

![Budget Tracker home screen](/images/lib/getting-started/flutter/budget-tracker-home.png)

## Configure Amplify

Let's start by configuring Amplify when the application loads. At the top of the file, find the `_configureAmplify`
method and replace it with the following code.

```diff
+ import 'package:amplify_api/amplify_api.dart';
+ import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
+ import 'package:amplify_authenticator/amplify_authenticator.dart';
+ import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

+ import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

Future<void> main() async 

Future<void> _configureAmplify() async  on Exception catch (e) 
}
```

Here, we're adding the API and Authentication plugins to our app and configuring Amplify with the
generated `amplifyconfiguration.dart` file.

There's one more step to complete the configuration of Auth and that is to wrap our application
in the Amplify Authenticator, which will provide a pre-built authentication flow with less than 
5 lines of code.

> You can learn more about the Authenticator and how to customize it [here](https://ui.docs.amplify.aws/flutter/connected-components/authenticator).

In the `MyApp` class, make the following change to add the Authenticator.

```diff
  @override
  Widget build(BuildContext context) 
```

If you try running your app again, you should now see a sign-in screen instead of the home screen.
The Authenticator guards your application so that only signed-in users can access it.

![Budget Tracker with Authenticator](/images/lib/getting-started/flutter/budget-tracker-authenticator.png)

Try creating a user with the `Sign Up` form before continuing on to the next step!

## Manipulating data

### Creating a Budget Entry

Currently, the `+` button doesn't do anything. Let's hook that up to a budget entry screen where we can create
and update budget items.

First, add the following below the `_HomeScreenState` class.

```dart
class ManageBudgetEntryScreen extends StatefulWidget );

  final BudgetEntry? budgetEntry;

  @override
  State createState() =>
      _ManageBudgetEntryScreenState();
}

class _ManageBudgetEntryScreenState extends State  else 
  }

  @override
  void dispose() 

  Future<void> submitForm() async 

    // If the form is valid, submit the data
    final title = _titleController.text;
    final description = _descriptionController.text;
    final amount = double.parse(_amountController.text);

    if (_isCreate)  else 

    // Navigate back to homepage after create/update executes
    if (mounted) 
  }

  @override
  Widget build(BuildContext context) 
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Amount (required)',
                      ),
                      validator: (value) 
                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) 
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitForm,
                      child: Text(_titleText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

Then, add the route to the global `GoRouter`.

```diff
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
+     GoRoute(
+       path: '/manage-budget-entry',
+       name: 'manage',
+       builder: (context, state) => ManageBudgetEntryScreen(
+         budgetEntry: state.extra as BudgetEntry?,
+       ),
+     ),
    ],
  );
```

Finally, hook up the `+` button to navigate to this route when it's pressed.

```diff
  Future<void> _navigateToBudgetEntry() async 
```

Now, if you click the `+` button you should be sent to the new screen.

![Budget Tracker create screen](/images/lib/getting-started/flutter/budget-tracker-create-screen.png)

Try creating a budget entry at this point! You should be able to enter values in the fields,
and get errors if a value entered does not match the schema.

When returning to the home screen, though, our budget entry is nowhere to be found! Let's fix that.

### Loading remote budget entries

In the `_HomeScreenState` class, we have a method called `_refreshBudgetEntries`. Let's populate
that to update the state class's `_budgetEntries` variable every time we call it.

To that, we'll use Amplify's model helpers which provide a quick way to create CRUD requests for 
your data. Here we're using the `ModelQueries.list` helper to retrieve all the budget entries 
and then passing the GraphQL request to the API category which will automatically transform 
the response into a list of `BudgetEntry` types.

```diff
  Future<void> _refreshBudgetEntries() async ');
+        return;
+      }
+      setState(() );
+    } on ApiException catch (e) 
  }
```

Now we can modify `initState` so that the entries are refreshed every time the homepage loads.

```diff
  @override
  void initState() 
```

And finally, we also want to refresh the entries anytime we return from the create/update screen
so that any changes are reflected in the list.

```diff
  Future<void> _navigateToBudgetEntry() async 
```

### Deleting budget entries

If you notice, right now you can swipe right on a budget entry to dismiss it. Let's modify the code
so that it properly deletes the entry when dismissed.

Modify the `_deleteBudgetEntry` function as follows. Again, we'll use Amplify model helpers to simplify
the creation of the GraphQL request.

```diff
  Future<void> _deleteBudgetEntry(BudgetEntry budgetEntry) async 
```

If you've made it this far, congratulations! You've built a fully working budget management application 🥳

![Completed budget tracker](/images/lib/getting-started/flutter/budget-tracker-complete.png)


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/start/getting-started/flutter/integrate.mdx`