#!/bin/bash

# if [[ "$OSTYPE" == "darwin"* ]]; then
#     alias sed="gsed"
# fi

# Loop through all of the passed filenames
for filename in "$@"
do
    # If the file exists
    if [ -f "$filename" ]
    then
        # Change all occurrences of 'interface' to 'struct'
        sed -i '' -e 's/^interface/struct/g' "$filename"
        # Change all occurrences of 'function' to 'transition'
        sed -i '' -e 's/^function/transition/g' "$filename"
        # Change all occurrences of 'closure' to 'function'
        sed -i '' -e 's/^closure/function/g' "$filename"
    fi
done