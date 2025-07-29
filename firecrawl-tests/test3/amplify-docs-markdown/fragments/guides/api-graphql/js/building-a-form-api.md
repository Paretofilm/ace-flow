---
title: Interacting with the API from a client-side application
source: fragments/guides/api-graphql/js/building-a-form-api.mdx
---

# Interacting with the API from a client-side application

### Interacting with the API from a client-side application

Now that the API has been deployed, you can interact with it from a client-side application.

#### Creating a new contact

```javascript
/* First import the API category from Amplify */

/* Next, import the createContact mutation */

/* Create a function that will create a new contact */
async function submitNewContact() 
      }
    })
    console.log('New contact created!');
  } catch (err) );
  }
}
```

#### Creating a form for dynamic user input

```javascript
/* First import the API category from Amplify */

/* Next, import the createContact mutation */

/* For a dynamic form, create some local state to hold form input. This is pseudocode and will differ based on your JavaScript framework. */
const formState = ;

/* Create a function to update the form state. This is pseudocode and will differ based on your JavaScript framework.  */
function updateFormState(key, value) 

/* Create a function that will create a new contact */
async function submitNewContact() 
      }
    })
    console.log('New contact created!');
  } catch (err) );
  }
}

/* Create the form inputs and button in the UI */
<input placeholder="phone" onChange= />
<input placeholder="name" onChange= />
<button onClick=>Create New Contact</button>
```

#### Querying for a list of contacts

```javascript
/* First import the API category from Amplify */

/* Next, import the listContacts query */

/* Create a function that will fetch the contacts */
async function getContacts() )
    console.log('contacts: ', contactData);
  } catch (err) );
  }
}
```
