#! /usr/bin/env bash
#
# Copyright (C) 2020 Ye Chang <yech1990@gmail.com>
# Distributed under terms of the MIT license.
#
# Created: 2020-04-15 23:30
# Discription: run

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)"

# INPUT="report.md"
INPUT=$1

if [ " $#" -eq "0" ]; then
    echo -e "USAGE: ./md2html.sh inputfile"
    exit 0
else
    if [ -f "${INPUT}" ]; then
        #echo $(realpath ${INPUT})
        WORKDIR="$(
            cd "$(dirname "$INPUT")" || exit
            pwd -P
        )"
        OUTPUT="${WORKDIR}/$(basename "${INPUT}" ".md").html"
    else
        echo "Input File (${INPUT}) is not exist"
        exit 1
    fi
fi

HTML_TEMPLATE="${DIR}/templates/default.html"
CSS_TEMPLATE="${DIR}/templates/github.css"
JS_TEMPLATE="${DIR}/templates/floating-toc.html"
REPORT_FILTER="${DIR}/filters/head2title_filter.lua"

pandoc "${INPUT}" -o "${OUTPUT}" \
    --lua-filter="${REPORT_FILTER}" \
    --resource-path="${WORKDIR}" \
    --template="${HTML_TEMPLATE}" --css="${CSS_TEMPLATE}" --include-in-header "${JS_TEMPLATE}" --toc \
    --standalone --self-contained
