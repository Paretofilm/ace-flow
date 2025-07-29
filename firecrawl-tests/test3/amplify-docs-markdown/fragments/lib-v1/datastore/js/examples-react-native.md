---
title: Documentation
source: fragments/lib-v1/datastore/js/examples-react-native.mdx
---

# Documentation

```jsx
/**
 * React Native DataStore Sample App
 */

Amplify.configure(awsConfig);
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
