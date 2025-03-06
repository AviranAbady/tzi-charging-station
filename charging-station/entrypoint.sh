#!/usr/bin/env bash

FLOW_DIR=/everest/everest-workspace/everest-core/config/nodered

if [ -z "$SCRIPT_TO_RUN" ]; then
    echo "Error: SCRIPT_TO_RUN environment variable is not set or empty"
    exit 1
fi

if [ -z "$FLOW_FILE" ]; then
    echo "Error: FLOW_FILE environment variable is not set or empty"
    exit 1
fi

if [ ! -s "${FLOW_DIR}/${FLOW_FILE}" ]; then
    echo "$FLOW_FILE does not exist or is empty in $FLOW_DIR"

    ls -l $FLOW_DIR
    exit 1
fi

cp ${FLOW_DIR}/${FLOW_FILE} ${FLOW_DIR}/flows.json
sed -i 's/"broker": "localhost"/"broker": "${MQTT_SERVER_ADDRESS}"/g' ${FLOW_DIR}/flows.json
chmod -R 777 $FLOW_DIR

/everest/everest-workspace/everest-core/build/run-scripts/${SCRIPT_TO_RUN}