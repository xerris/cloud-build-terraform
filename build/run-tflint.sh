#!/bin/sh

# run-tflint.sh -- run Tflint on all Terraform files
#
set -euo pipefail # strict mode

# CI: switch to Cloud Build directory (from tflint's default workdir)
if [ -d /workspace ] ; then
    cd /workspace
fi

tf_directories=$(find . -type f -name '*.tf' | xargs -n1 dirname | uniq)
echo $tf_directories
echo $tf_directories | xargs -n1 tflint

echo "tflint: done"