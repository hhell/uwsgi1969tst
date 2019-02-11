#!/bin/sh

set -e
set -x

./_run_prepare.sh
./_run_v1.sh "$@"
