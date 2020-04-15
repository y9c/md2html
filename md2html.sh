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

if [ -f "${INPUT}" ]; then
    #echo $(realpath ${INPUT})
    WORKDIR="$(
        cd "$(dirname "$INPUT")"
        pwd -P
    )"
    OUTPUT="${WORKDIR}/$(basename "${INPUT}" ".md").html"
else
    echo "${INPUT} not exist"
    exit 1
fi

HTML_TEMPLATE="${DIR}/template.html"
CSS_TEMPLATE="${DIR}/github.css"
REPORT_FILTER="${DIR}/head2title_filter.py"

pandoc ${INPUT} -o ${OUTPUT} \
    --filter=${REPORT_FILTER} --template=${HTML_TEMPLATE} --css=${CSS_TEMPLATE} --resource-path=${WORKDIR} \
    --toc --standalone --self-contained
