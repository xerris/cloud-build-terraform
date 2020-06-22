#!/bin/sh

# run-tflint.sh -- run Tflint on all Terraform files
#
set -euo pipefail # strict mode

set -o verbose

# switch to Cloud Build directory (from tflint's default workdir)
cd /workspace

tf_directories=$(find . -type f -name '*.tf' | xargs -n1 dirname | uniq)
echo $tf_directories
echo $tf_directories | xargs -n1 tflint
