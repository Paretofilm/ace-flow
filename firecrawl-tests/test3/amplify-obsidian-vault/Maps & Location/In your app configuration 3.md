---
title: In your app configuration
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib/geo/android/existing-resources.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# In your app configuration

## In your app configuration

Amplify Geo is dependent on your Amplify Auth category. If it is not already configured, then you will have to manually configure it as well. In order to manually configure Amplify Geo category, you must edit `amplifyconfiguration.json` in your project's `src/main/res/raw` directory with your information from existing Amazon Cognito and Amazon Location Service resources.

```json

                    },
                    "default": 
                },
                "searchIndices": 
            }
        }
    },
    "auth": 
                },
                "CredentialsProvider": 
                    }
                }
            }
        }
    }
}
```

Now you can proceed to [displaying a map](/gen1/[platform]/build-a-backend/more-features/geo/maps/) or [adding location search](/gen1/[platform]/build-a-backend/more-features/geo/location-search/) to your app.


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib/geo/android/existing-resources.mdx`