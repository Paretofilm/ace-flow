---
title: Documentation
topics: ['Data & APIs', 'React']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/js/examples-react-native.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, react]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[React/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/js/examples-react-native.mdx`