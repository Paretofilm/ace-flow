---
title: Example application
source: fragments/lib/datastore/js/examples.mdx
---

# Example application

## Example application

```jsx
import "./App.css";

// Use next two lines only if syncing with the cloud
Amplify.configure(amplifyconfig);

async function onCreate() `,
      rating: Math.floor(Math.random() * (8 - 1) + 1),
      status: PostStatus.ACTIVE,
    })
  );
}

async function onDeleteAll() 

async function onQuery() 

function App() );

    return () => subscription.unsubscribe();
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src= className="App-logo" alt="logo" />
        <div>
          <input type="button" value="NEW" onClick= />
          <input type="button" value="DELETE ALL" onClick= />
          <input type="button" value="QUERY rating > 4" onClick= />
        </div>
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

```ts

@Component()

  ngOnInit() );
  }

  ngOnDestroy() 

  public async loadPosts() 
  
  public onCreate() `,
        rating: Math.floor(Math.random() * (8 - 1) + 1),
        status: PostStatus.ACTIVE,
      })
    );
  }

  public onDeleteAll() 
}
```
</Block>

```javascript 
<template>
  <div id="app">
    <div class="app-body">
      <button type="button" @click="onCreate" >NEW</button>
      <button type="button" @click="onDeleteAll" >DELETE ALL</button>
      <button type="button" @click="onQuery" >QUERY rating > 4</button>
    </div>
  </div>
</template>

<script>

</BlockSwitcher>

## API Reference   

For the complete API documentation for DataStore, visit our [API Reference](https://aws-amplify.github.io/amplify-js/api/modules/aws_amplify.datastore.html)
