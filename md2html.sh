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
# REPORT_FILTER="${DIR}/filters/head2title_filter.lua"
# REPORT_FILTER="${DIR}/filters/tikz2iamge_filter.lua"
DIAGRAM_FILTER="${DIR}/filters/diagram_filter.lua"

# KATEX_DIR="https://cdn.bootcss.com/KaTeX/0.11.1/"
KATEX_DIR="${DIR}/katex/"

pandoc ${INPUT} -o ${OUTPUT} \
    --template=${HTML_TEMPLATE} --css=${CSS_TEMPLATE} --resource-path=${WORKDIR} \
    --default-image-extension=jpg \
    --lua-filter=${DIAGRAM_FILTER} \
    --katex=${KATEX_DIR} --toc --number-sections --number-offset=0 \
    --standalone --self-contained

# --lua-filter=${REPORT_FILTER} \
