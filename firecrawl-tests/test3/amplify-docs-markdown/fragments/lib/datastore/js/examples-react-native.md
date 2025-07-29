---
title: API Reference
source: fragments/lib/datastore/js/examples-react-native.mdx
---

# API Reference

```jsx
/**
 * React Native DataStore Sample App
 */

Amplify.configure(amplifyconfig);
let subscription;

class App extends Component ;
  }

  componentDidMount() );
  }

  componentWillUnmount() 

  onCreatePost() `,
        rating: Math.floor(Math.random() * (8 - 1) + 1),
        status: PostStatus.ACTIVE
      })
    );
  }

  async onCreatePostAndComments() `,
      rating: 5,
      status: PostStatus.ACTIVE
    });

    await DataStore.save(post);

    for (let i = 0; i < 2; i++) `,
          post
        })
      );
    }
  }

  onQuery = async () => );
    console.log('QUERY_COMMENTS_RESULT', comments);
  };

  onDelete = async () => ;

  render()  $`}</Text>
        ))}
      </ScrollView>
    );
  }
}

const styles = StyleSheet.create(,
  container: ,
  text: 
});

## API Reference

For the complete API documentation for DataStore, visit our [API Reference](https://aws-amplify.github.io/amplify-js/api/modules/aws_amplify.datastore.html)
