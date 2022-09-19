#!/bin/bash

set -eu -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

KUBECONFIG=".kubeconfig"

kind create cluster \
    --name ext-res-test \
    --image kindest/node:v1.21.14 \
    --kubeconfig $KUBECONFIG
