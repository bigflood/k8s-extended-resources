#!/bin/bash

set -eu -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR"

NODE_NAME="ext-res-test-control-plane"

CUR_VAL=$(./kubectl.sh get no $NODE_NAME -o json | jq '.status.capacity["example.com/dongle"]' -r)

if [[ "$CUR_VAL" == "null" ]]; then
    ./kubectl.sh proxy &

    sleep 1

    curl --header "Content-Type: application/json-patch+json" \
        --request PATCH \
        --data '[{"op": "add", "path": "/status/capacity/example.com~1dongle", "value": "4"}]' \
        "http://localhost:8001/api/v1/nodes/$NODE_NAME/status"

    kill %1
else
    echo "skip"
fi
