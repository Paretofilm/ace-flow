---
title: Installation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/utilities/logger.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Installation

AWS Amplify writes console logs through Logger. You can use Logger in your apps for the same purpose.

## Installation

Import Logger:
```javascript
```

## Working with the API

You can call logger for different console message modes:
```javascript
const logger = new Logger('foo');

logger.info('info bar');
logger.debug('debug bar');
logger.warn('warn bar');
logger.error('error bar');
```

When handling an error:
```javascript
try  catch(e) 
```

## Setting Logging Levels

You can set a log level when you create your logger instance:

```javascript
const logger = new Logger('foo', 'INFO');

logger.debug('callback data', data); // this will not write the message
```

Global logger configuration will override your logger instance's configuration:

```javascript
Amplify.Logger.LOG_LEVEL = 'DEBUG';

const logger = new Logger('foo', 'INFO');

logger.debug('callback data', data); //  this will write the message since the global log level is 'DEBUG'
```

During web development, you can set global log level in browser console log:
```javascript
window.LOG_LEVEL = 'DEBUG';
```

Supported log levels:

* `ERROR`
* `WARN`
* `INFO`
* `DEBUG`
* `VERBOSE`


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/utilities/logger.mdx`