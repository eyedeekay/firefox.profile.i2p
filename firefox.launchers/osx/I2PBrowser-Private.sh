#! /usr/bin/env bash

if [ "$USER" = "root" ]; then
    exit "Browsers should definitely not run as root!"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

"$DIR/helper.sh" private
