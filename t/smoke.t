#!/bin/sh

# Copyright © 2022 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u

pdir="${0%/*}/.."
prog="$pdir/ttyszfury"
echo 1..3
t()
{
    # shellcheck disable=SC2016
    prog="$prog" \
        script -e -q -c 'stty cols 80 rows 24 && "$prog" -- '"$*" /dev/null < /dev/null
}
t 'sleep 1'
echo ok 1
xc=0
out=$(t 'perl -MPOSIX -e "raise(SIGUSR1)"') || xc=$?
if [ $xc -eq 255 ]
then
    echo ok 2
else
    echo not ok 2
fi
cr=$(printf '\r')
if [ "$out" = 'ttyszfury: target program terminated by SIGUSR1'"$cr" ]
then
    echo ok 3
else
    sed -e 's/^/# /' <<EOF
$out
EOF
    echo not ok 3
fi

# vim:ts=4 sts=4 sw=4 et ft=sh
