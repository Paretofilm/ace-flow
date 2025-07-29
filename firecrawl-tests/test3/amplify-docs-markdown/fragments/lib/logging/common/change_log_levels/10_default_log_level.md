---
title: Documentation
source: fragments/lib/logging/common/change_log_levels/10_default_log_level.mdx
---

# Documentation

Update the `defaultLogLevel` field under `loggingConstraints`.

```json

    }
}
```

The following are supported log levels:
* `ERROR`
* `WARN`
* `INFO`
* `DEBUG`
* `VERBOSE`
* `NONE`

Setting the log level to `NONE` effectively disables logging.
