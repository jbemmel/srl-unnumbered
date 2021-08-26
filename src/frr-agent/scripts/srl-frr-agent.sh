#!/bin/bash
###########################################################################
# Description:
#     This script will launch the python script of srl-frr-agent
#     (forwarding any arguments passed to this script).
#
# Copyright (c) 2018-2021 Nokia, generated by srl-agent-builder
###########################################################################


_term (){
    echo "Caugth signal SIGTERM !! "
    kill -TERM "$child" 2>/dev/null
}

function main()
{
    trap _term SIGTERM
    local virtual_env="/opt/srlinux/python/virtual-env/bin/activate"
    local main_module="/opt/srlinux/agents/frr-agent/srl-frr-agent.py"

    # source the virtual-environment, which is used to ensure the correct python packages are installed,
    # and the correct python version is used
    source "${virtual_env}"

    # Include local paths where custom packages are installed
    P1="/usr/local/lib/python3.6/site-packages"
    P2="/usr/local/lib64/python3.6/site-packages"
    P3="/usr/lib/python3.6/site-packages/"
    P4="/usr/lib64/python3.6/site-packages/"
    NDK="/opt/rh/rh-python36/root/usr/lib/python3.6/site-packages/sdk_protos"
    # since 21.6
    SDK2="/usr/lib/python3.6/site-packages/sdk_protos"
    export PYTHONPATH="$P1:$P2:$P3:$P4:$NDK:$SDK2:$PYTHONPATH"

    export http_proxy=""
    export https_proxy=""
    export no_proxy=""
    python3 ${main_module} &

    child=$!
    wait "$child"
}

main "$@"
