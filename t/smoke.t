#!/bin/sh

# Copyright © 2022 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u

pdir="${0%/*}/.."
prog="$pdir/ttyszfury"
echo 1..1
t()
{
    # shellcheck disable=SC2016
    prog="$prog" \
        script -e -q -c 'stty cols 80 rows 24 && "$prog" -- '"$*" /dev/null < /dev/null
}
t 'sleep 1'
echo ok 1

# vim:ts=4 sts=4 sw=4 et ft=sh
