---
title: Sample React app
topics: ['General']
primary_topic: General
source: fragments/lib/predictions/js/sample.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Sample React app

## Sample React app

A sample React application with all of the Predictions features is provided below. It shows how to use all scenarios above by calling the appropriate `convert`, `identify`, and `interpret` API calls in the Amplify library.

> **Note**: 

This example uses the package `microphone-stream`, which you will need to install along with the necessary polyfills if you would like to use the sample directly.

```bash
npm install microphone-stream
```

If you are using Vite, [this package](https://www.npmjs.com/package/vite-plugin-node-polyfills) provides straightforward instructions on installing the necessary polyfills.

The components in the app code below are rendered according to the scenarios above like so:

```javascript
return (
  <div>

  </div>
);
```

React app code

```javascript
import './App.css';

Amplify.configure(amplifyconfig);

function TextIdentification()  } = event;
    const [file,] = files || [];

    if (!file) 
    try  = await Predictions.identify(,
          format: 'PLAIN', // Available options 'PLAIN', 'FORM', 'TABLE', 'ALL'
        }
      })
      setResponse(text.fullText);
    } catch (err) 
  }

  return (
    <div>
      <div>
        <h3>Text identification</h3>
        <input type="file" onChange=></input>
        <p></p>
      </div>
    </div>
  );
}

function EntityIdentification()  } = event;
    const [file,] = files || [];

    if (!file) 
    try ,
          /*
          * For using the Identify Entities advanced features, enable collection:true and comment out celebrityDetection
          * Then after you upload an image to your S3 bucket (protected/predictions/index-faces/) you'll be able to run this again
          * and it will tell you if the photo you're testing is in that Collection or not
          */
          // collection: true
          celebrityDetection: true
        }
      });
      setResponse(JSON.stringify(result, null, 2))
    } catch (err) 
  }

  return (
    <div>
      <div>
        <h3>Entity identification</h3>
        <input type="file" onChange=></input>
        <p></p>
      </div>
    </div>
  );
}

function LabelsIdentification()  } = event;
    const [file,] = files || [];

    if (!file) 
    try ,
          type: 'ALL' // 'LABELS' will detect objects , 'UNSAFE' will detect if content is not safe, 'ALL' will do both default on amplifyconfiguration.json
        }
      });
      console.log(result);
      setResponse(JSON.stringify(result, null, 2));
    } catch (err) 
  }

  return (
    <div>
      <div>
        <h3>Labels identification</h3>
        <input type="file" onChange=></input>
        <p></p>
      </div>
    </div>
  );
}

function SpeechToText() ) 
        function newBuffer() 
 
        return ,
          addData: function(raw) ,
          getData: function() 
        };
      })()
    );

    const startRecording = async () => ));
      
      startMic.on('data', (chunk) => 
          audioBuffer.addData(raw);

        });

      setRecording(true);
      setMicStream(startMic);
    }

    async function stopRecording() 

    return (
      <div>
        <div>
          >Stop recording</button>}
          >Start recording</button>}
        </div>
      </div>
    );
  }

  const convertFromBuffer = async (bytes) =>  = await Predictions.convert(,
          language: 'en-US', // other options include 'en-GB', 'fr-FR', 'fr-CA', 'es-US'
        },
      });
      setResponse(transcription.fullText);
    } catch (err) 
  }

  return (
    <div>
      <div>
        <h3>Speech to text</h3>
        
        <p></p>
      </div>
    </div>
  );
}

function TextToSpeech() ,
          voiceId: 'Amy' // default configured on amplifyconfiguration.json
          // list of different options are here https://docs.aws.amazon.com/polly/latest/dg/voicelist.html
        }
      });
      
      let AudioContext = window.AudioContext || window.webkitAudioContext;
      const audioCtx = new AudioContext();
      const source = audioCtx.createBufferSource();
      audioCtx.decodeAudioData(result.audioStream, (buffer) => , (err) => console.log());
      
      setResponse('Generation completed');
    } catch(err: unknown) 
  }

  const setText = (event) => 

  return (
    <div>
      <div>
        <h3>Text To Speech</h3>
        <input type="text" value= onChange=></input>
        <button onClick=>Text to Speech</button>
        <h3></h3>
      </div>
    </div>
  );
}

function TextTranslation() ,
          // targetLanguage: "en"
        }
      })
      setResponse(JSON.stringify(result, null, 2));
    } catch(err: unknown) 
  }

  function setText(event) 

  return (
    <div>
      <div>
        <h3>Text Translation</h3>
        <input type="text" value= onChange=></input>
        <button onClick=>Translate</button>
        <p></p>
      </div>
    </div>
  );
}

function TextInterpretation() ,
          type: 'all'
        }
      })
      setResponse(JSON.stringify(result, null, 2));
    } catch (err) 
  }

  function setText(event) 

  return (
    <div>
      <div>
        <h3>Text interpretation</h3>
        <input value= onChange=></input>
        <button onClick=>test</button>
        <p></p>
      </div>
    </div>
  );
}

function App() 

Now run `npm start` and press the buttons to demo the app.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/predictions/js/sample.mdx`