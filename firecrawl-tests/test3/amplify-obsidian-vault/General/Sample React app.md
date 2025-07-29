---
title: Sample React app
topics: ['General']
primary_topic: General
source: fragments/lib-v1/predictions/js/sample.mdx
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

To use `Predictions.convert()` with Amazon Transcribe you will need to install the following dependency in your app first:

```bash
npm install microphone-stream
```

The components in the app code below are rendered according to the scenarios above like so:

```javascript
return (
  <div className="App">

  </div>
);
```

React app code

```javascript

import './App.css';

Amplify.configure(awsconfig);
Amplify.addPluggable(new AmazonAIPredictionsProvider());

function TextIdentification()  } = event;
    const [file,] = files || [];

    if (!file) 
    Predictions.identify(,
        format: "PLAIN", // Available options "PLAIN", "FORM", "TABLE", "ALL"
      }
    }).then((}) => )
      .catch(err => setResponse(JSON.stringify(err, null, 2)))
  }

  return (
    <div className="Text">
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
    Predictions.identify(,
        /**For using the Identify Entities advanced features, enable collection:true and comment out celebrityDetection
         * Then after you upload a face with PredictionsUpload you'll be able to run this again
         * and it will tell you if the photo you're testing is in that Collection or not and display it*/
        //collection: true
        celebrityDetection: true
      }
    }).then(result =>  }) =>  = boundingBox;
        imageId = externalImageId;
        if (name) 
        console.log();
      })
      if (imageId) ,
          level: "public",
        }).then(setSrc); // this should be better but it works
      }
      console.log();
      setResponse(names);
    })
      .catch(err => console.log(err))
  }

  return (
    <div className="Text">
      <div>
        <h3>Entity identification</h3>
        <input type="file" onChange=></input>
        <p></p>
        "></img>}
      </div>
    </div>
  );
}

function PredictionsUpload()  } = event;
    const [file,] = files || [];
    Storage.put(file.name, file, 
    });
  }

  return (
    <div className="Text">
      <div>
        <h3>Upload to predictions s3</h3>
        <input type="file" onChange=></input>
      </div>
    </div>
  );
}

function LabelsIdentification()  } = event;
    const [file,] = files || [];

    if (!file) 
    Predictions.identify(,
        type: "ALL" // "LABELS" will detect objects , "UNSAFE" will detect if content is not safe, "ALL" will do both default on aws-exports.js
      }
    }).then(result => setResponse(JSON.stringify(result, null, 2)))
      .catch(err => setResponse(JSON.stringify(err, null, 2)))
  }

  return (
    <div className="Text">
      <div>
        <h3>Labels identification</h3>
        <input type="file" onChange=></input>
        <p></p>
      </div>
    </div>
  );
}

function SpeechToText(props) 
        function newBuffer() 
 
        return ,
          addData: function(raw) ,
          getData: function() 
        };
      })()
    );

    async function startRecording() ).then((stream) => 
          audioBuffer.addData(raw);

        });

        setRecording(true);
        setMicStream(startMic);
      });
    }

    async function stopRecording()  = props;

      micStream.stop();
      setMicStream(null);
      setRecording(false);

      const resultBuffer = audioBuffer.getData();

      if (typeof finishRecording === "function") 

    }

    return (
      <div className="audioRecorder">
        <div>
          >Stop recording</button>}
          >Start recording</button>}
        </div>
      </div>
    );
  }

  function convertFromBuffer(bytes) ,
        // language: "en-US", // other options are "en-GB", "fr-FR", "fr-CA", "es-US"
      },
    }).then(( }) => setResponse(fullText))
      .catch(err => setResponse(JSON.stringify(err, null, 2)))
  }

  return (
    <div className="Text">
      <div>
        <h3>Speech to text</h3>
        
        <p></p>
      </div>
    </div>
  );
}

function TextToSpeech() ,
        voiceId: "Amy" // default configured on aws-exports.js 
        // list of different options are here https://docs.aws.amazon.com/polly/latest/dg/voicelist.html
      }
    }).then(result => );
      const audioCtx = new AudioContext(); 
      const source = audioCtx.createBufferSource();
      audioCtx.decodeAudioData(result.audioStream, (buffer) => , (err) => console.log());
      
      setResponse(`Generation completed, press play`);
    })
      .catch(err => setResponse(err))
  }

  function setText(event) 

  return (
    <div className="Text">
      <div>
        <h3>Text To Speech</h3>
        <input value= onChange=></input>
        <button onClick=>Text to Speech</button>
        <h3></h3>
      </div>
    </div>
  );
}

function TextTranslation() ,
        // targetLanguage: "en"
      }
    }).then(result => setResponse(JSON.stringify(result, null, 2)))
      .catch(err => setResponse(JSON.stringify(err, null, 2)))
  }

  function setText(event) 

  return (
    <div className="Text">
      <div>
        <h3>Text Translation</h3>
        <input value= onChange=></input>
        <button onClick=>Translate</button>
        <p></p>
      </div>
    </div>
  );
}

function TextInterpretation() ,
        type: "ALL"
      }
    }).then(result => setResponse(JSON.stringify(result, null, 2)))
      .catch(err => setResponse(JSON.stringify(err, null, 2)))
  }

  function setText(event) 

  return (
    <div className="Text">
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
Original: `fragments/lib-v1/predictions/js/sample.mdx`