#!/bin/bash

RAR_DATA=$1
TMP_FILE=`mktemp -q /tmp/rar.XXXXXX`


echo "Validating $RAR_DATA data.."
./unrar -inul x $RAR_DATA >> $TMP_FILE

echo "Printing result.."
cat $TMP_FILE

echo "Checking if one of the symlink was considered suspicious..."
if grep -q False "$TMP_FILE"; then
        echo "Dangerous symlink was founded, this rar will be dropped"
        exit 0
fi

echo "No dangerous symlink was founded, this rar will be accepted"
exit 1
