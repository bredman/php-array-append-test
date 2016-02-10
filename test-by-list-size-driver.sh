#!/bin/zsh

set -e

REPO_PATH=`git rev-parse --show-toplevel`
TEST_FILE=${REPO_PATH}/array-append-test.php

echo "append_type,num_elements,element_size,time"

for APPEND_TYPE in "array_merge" "builtin_append" "array_prepend"; do
    for LIST_SIZE in "1000" "2000" "4000" "8000" "16000" "32000"; do
        for TRIAL_COUNT in `seq 1 100`; do
            php $TEST_FILE --num-elements $LIST_SIZE --append-type $APPEND_TYPE
        done
    done
done
