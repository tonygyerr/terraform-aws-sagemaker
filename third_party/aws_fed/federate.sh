#!/bin/bash

ENV=$1

cd "$(dirname "${0}")/third_party/aws_fed" || exit

# aaca -C ~/.aws/configs -D echo-dev -c ~/.aws/credentials -r us-east-1 -t 3600 -v vv
# --aws-credential-file, -C: file to save configuration to (default: *~/.aws/config*)
# --aws-config-file, -c: file to save credentials to (default: *~/.aws/credential*)
# --aws-output, -o: output format (default: *json*)
# --aws-region, -r: set sts region to connect to (default: *us-east-1*)
# --timer, -t, display token remaining time
# --verbose, -v: set verbosity level. Can be repeated `-vv` or `--verbose --verbose`
# --duration, -d: set the desired duration of token in seconds
# --default-profile-name, -D: set the profile as default