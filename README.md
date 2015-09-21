# fluent-plugin-loadaverage

## Overview
Fluentd input plugin to collect loadaverage via uptime command.

## Installation
```
$ gem install fluent-plugin-loadaverage
```

## Configuration
```
<source>
  type loadaverage
  tag loadaverage
  interval 10
</source>
```

### Parameters
- tag(Required)
    - record output destination
- interval
    - execute interval time
    - [default] 60s

## OutputFormat
```
{"past_1min":"0.00","past_5min":"0.01","past_15min":"0.05"}
```
