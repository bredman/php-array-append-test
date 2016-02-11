#!/bin/zsh

set -e

REPO_PATH=`git rev-parse --show-toplevel`
TEST_FILE=${REPO_PATH}/array-append-test.php

echo "append_type,num_elements,element_size,time"

# array_prepend is too slow!
# for APPEND_TYPE in "array_merge" "builtin_append" "safe_array_merge" "array_prepend"; do
for APPEND_TYPE in "array_merge" "builtin_append" "safe_array_merge"; do
    for LIST_SIZE in "1000" "2000" "4000" "8000" "16000" "32000"; do
        for TRIAL_COUNT in `seq 1 10`; do
            php $TEST_FILE --num-elements $LIST_SIZE --append-type $APPEND_TYPE
        done
    done
done
