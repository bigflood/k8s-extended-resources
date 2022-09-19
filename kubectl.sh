#!/bin/bash

set -eu -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR"

mkdir -p .bin

K8S_VERSION="v1.21.14"
KUBECONFIG="$(pwd)/.kubeconfig"
KUBECTL_FILE="$(pwd)/.bin/kubectl"
KUBECTL="$KUBECTL_FILE --kubeconfig $KUBECONFIG"

if [[ ! -f $KUBECTL_FILE ]] ; then
    echo "download $KUBECTL_FILE .."
    curl -sL -o $KUBECTL_FILE "https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl"
    chmod 700 $KUBECTL_FILE
fi

cd -

$KUBECTL --kubeconfig $KUBECONFIG $*
