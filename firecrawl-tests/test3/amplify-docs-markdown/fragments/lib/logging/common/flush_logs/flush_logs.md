---
title: Change automatic log flush interval
source: fragments/lib/logging/common/flush_logs/flush_logs.mdx
---

# Change automatic log flush interval

When using the Amplify Logger, all logged messages are saved locally on the user's device first and then flushed at a set interval that you can [customize](#change-automatic-log-flush-interval). You can also choose to flush events manually if needed by following the steps outlined in this section.

## Change automatic log flush interval

You can customize the time interval for when logs are automatically flushed and sent to CloudWatch.

Below is an example of setting the time interval to 120 seconds:

  </Block>

  </Block>
</BlockSwitcher>

## Manually flush logs

You can choose at anytime to flush the log messages that are saved locally on the user's device, to then send them immediately to Amazon CloudWatch.
