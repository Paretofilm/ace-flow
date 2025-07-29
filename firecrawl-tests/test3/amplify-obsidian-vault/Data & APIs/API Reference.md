---
title: API Reference
topics: ['Data & APIs', 'React']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/examples-react-native.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, react]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[React/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib/datastore/js/examples-react-native.mdx`