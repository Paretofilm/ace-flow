---
title: Boilerplate UI
source: fragments/start/getting-started/reactnative/integrate.mdx
---

# Boilerplate UI

In this section you’ll integrate Amplify DataStore with your app, and learn to use the generated data model to create, update, query, and delete Todo items by building an app. You can find the source code of the final Todo App [on our GitHub repository](https://github.com/chintannp/amplified_todo_rn).

## Boilerplate UI
First, you will create some files and place the boilerplate UI code in it. 

#### App.js
First, replace the contents of your **App.js** file with the following UI boilerplate code. Here, you are importing your Home component. 

> **Note**: 

NOTE: You have already configured Amplify using `Amplify.configure` in __index.js__ for React Native CLI. So, you don't need to configure Amplify in **App.js**.

```jsx

Amplify.configure(awsconfig);

const styles = StyleSheet.create(,
});
```

</Block>

```jsx

const styles = StyleSheet.create(,
});
```

</Block>
</BlockSwitcher>

#### Home.js
Next, you will create a Home component for your app which will implement most of the CRUD functionality for your app. Create a new file **Home.js** at location `src/Home.js`. Here, you have total four components defined :

1. **Header**: Simple Header component with Title.
2. **AddModal**: Used for displaying a Modal when a new Todo needs to be added.
3. **TodoList**: Used for displaying the list of Todos.
4. **Home**: Default component that wraps all the above component and a Button for adding a new Todo item.

Copy the below boilerplate UI code into the **Home.js** file.

```jsx
import  from 'react-native';

const Header = () => (
  
    My Todo List</Text>
  </View>
);

const AddTodoModal = () => 

  function closeModal() 

  return (

            X</Text>
          </Pressable>

            Save Todo</Text>
          </Pressable>
        </View>
      </View>
    </Modal>
  );
};

const TodoList = () => , []);

  async function deleteTodo(todo) 

  async function setComplete(updateValue, todo) 

  const renderItem = () => (
     }
      onPress=}
      style=
    >
      
        </Text>
        `}
      </Text>

      </Text>
    </Pressable>
  );

  return (
     id}
      renderItem=
    />
  );
};

const Home = () => }
        style=
      >
        + Add Todo</Text>
      </Pressable>
      
    </>
  );
};

const styles = StyleSheet.create(,
  headerTitle: ,
  todoContainer: ,
    shadowOpacity: 0.3,
    shadowRadius: 2,
  },
  todoHeading: ,
  checkbox: ,
  completedCheckbox: ,
  buttonText: ,
  buttonContainer: ,
  floatingButton: ,
    shadowOpacity: 0.3,
    shadowRadius: 4,
  },
  modalContainer: ,
  modalInnerContainer: ,
  modalInput: ,
  modalDismissButton: ,
  modalDismissText: ,
});

Go ahead and run your code now and you should see an app with empty todolist and a floating action button but not much else.

Let’s next manipulate the data and add more functionality to your app.

## Manipulating data

### Creating a Todo
The *Add Todo* floating action button opens up a Modal to add todos. But, right now, the form does nothing when the *Save* button is pressed. Let’s fix that by having it save a **Todo** to DataStore.

Open the **Home.js** file and update the `addTodo()` function in the **AddTodoModal** component.

```jsx
  async function addTodo() ));
    setModalVisible(false);
    setName('');
    setDescription('');
  }
```

If you try to add todos using the form now, it should successfully close the form when pressing the *Save* button. But your Todo list is still empty even if you restart the app! After initializing your todos as an empty list, you aren't currently updating it again. You will remedy that in the next step.

> **Note**: 

You will see a console error when you run your app "Datastore - Data won't synchronize", this is expected and will be fixed in a future step once you connect your app to the cloud.

### Querying for Todos and Observing Updates in Real-Time

Now that you have a way to add Todo items, you need a way to list them out. You also want to observe updates to those items as they are added, updated, or removed.

This can be achieved with `DataStore.observeQuery()`. `observeQuery()` will return a Stream of query snapshots. Each snapshot will contain the current list of items, as well as boolean value to indicate if DataStore's sync process has completed. You can find more info about `observeQuery()` [here](/gen1/[platform]/build-a-backend/more-features/datastore/real-time/#observe-query-results-in-real-time).

You will use the `useEffect()` hook of **TodoList** component to list the todo items. `useEffect()` can be used to perform side effects in function components. Add the below `useEffect()` in the **TodoList** component right after state initialization. You can find more about the useEffect hook [here](https://reactjs.org/docs/hooks-effect.html).

```jsx
  useEffect(() =>  = snapshot;
      setTodos(items);
    });

    //unsubscribe to data updates when component is destroyed so that you don’t introduce a memory leak.
    return function cleanup() 

  }, []);
```

If you restart your app now, you should see that newly added todos will start showing up on the list. The items look like they can be check off and marked as completed, but when pressed, they don’t seem to do anything right now. Let’s learn how to update existing data.

### Updating a Todo

Updating an existing data entry looks a lot like creating a new one. It’s important to note, however, that models in DataStore are *immutable*. So, to update a record you must use a model’s `copyOf` function rather than manipulating its properties directly.

Update the `setComplete` function in the `TodoList` component.

```jsx
  async function setComplete(updateValue, todo) )
    );
  }
```

That’s it! Restart your app and you should now be able to toggle a todo between completed and not completed states. You’re almost done here but what if you want to delete an item from your todo list? We’ll go over how to do that next.

### Deleting a Todo

Deleting an existing data entry is even easier than updating one since you don’t need to copy the instance to delete it. It may not be the best user experience to do this but, for this app, you will trigger deletion of a todo item to a long press of the item.

Update the `deleteTodo()` function in the `TodoList` component.

```jsx
  async function deleteTodo(todo)  catch (e) 
  }
```

Reload your app once more and you should now be able to long press an item to delete it. 

You can find the complete `Home.js` file [here](https://github.com/chintannp/amplified_todo_rn/blob/main/src/Home.js). Now you have a fully featured CRUD application that saves and retrieves data on the local device, which means this app **works without an AWS account or even an internet connection.** Next, you'll connect it to AWS and make sure the data is available in the cloud.
