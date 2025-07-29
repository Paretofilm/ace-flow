---
title: Documentation
source: fragments/lib-v1/datastore/react-native/data-access/observe-update-snippet.mdx
---

# Documentation

```js
// Example showing how to observe the model and keep state updated before
// performing a save. This uses the useEffect React hook, but you can
// substitute for a similar mechanism in your application lifecycle with
// other frameworks.

const App = () => ) => );

    return () => ;
  }, []);

  /**
   * Create a new Post
   */
  async function onCreate() `,
        rating: Math.floor(Math.random() * (8 - 1) + 1),
        status: PostStatus.ACTIVE
      })
    );

    setPost(_post);
  }

  return (

          </Text>
          
           )
              );
            }}
          />
           
              const savedPost = await DataStore.save(post);
              console.log('Post saved: ', savedPost);
            }}
          />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};
```
