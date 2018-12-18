#! /usr/bin/env bash

DIR=$(who am i | awk '{print $1}')/.i2pbrowser/

"$DIR/install.sh" install
"$DIR/install.sh" private
