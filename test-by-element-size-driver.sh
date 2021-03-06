#!/bin/zsh

set -e

REPO_PATH=`git rev-parse --show-toplevel`
TEST_FILE=${REPO_PATH}/array-append-test.php

echo "append_type,num_elements,element_size,time"

# array_prepend is too slow!
# for APPEND_TYPE in "array_merge" "builtin_append" "safe_array_merge" "array_prepend"; do
for APPEND_TYPE in "array_merge" "builtin_append" "safe_array_merge"; do
    for LIST_SIZE in "100" "200" "400" "800" "1600" "3200" "6400"; do
        for TRIAL_COUNT in `seq 1 10`; do
            php $TEST_FILE --element-size $LIST_SIZE --append-type $APPEND_TYPE
        done
    done
done
