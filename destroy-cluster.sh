#!/bin/bash

set -eu -o pipefail

kind delete cluster \
    --name ext-res-test
