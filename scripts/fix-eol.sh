#!/bin/sh
set -e

dir="${1:-.}"
cr=$(printf '\r')

find "$dir" -type f -name '*.md' | while read -r file; do
    if grep -q "$cr" "$file"; then
        sed -i 's/\r$//' "$file"
        echo "fixed: $file"
    fi
done
