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

# KATEX_DIR="https://cdn.bootcss.com/KaTeX/0.11.1/"
KATEX_DIR="${DIR}/katex/"

HTML_TEMPLATE="${DIR}/templates/default.html"
CSS_TEMPLATE="${DIR}/templates/github.css"
TOC_TEMPLATE="${DIR}/templates/floating-toc.html"

REPORT_FILTER="${DIR}/filters/head2title_filter.lua"
SECNUM_FILTER="${DIR}/filters/numbering_sections.lua"
DIAGRAM_FILTER="${DIR}/filters/diagram_filter.lua"
# REPORT_FILTER="${DIR}/filters/head2title_filter.lua"
# REPORT_FILTER="${DIR}/filters/tikz2iamge_filter.lua"

pandoc "${INPUT}" -o "${OUTPUT}" \
    --lua-filter="${REPORT_FILTER}" \
    --lua-filter="${SECNUM_FILTER}" \
    --lua-filter="${DIAGRAM_FILTER}" \
    --resource-path="${WORKDIR}" \
    --template="${HTML_TEMPLATE}" --css="${CSS_TEMPLATE}" \
    --include-in-header "${TOC_TEMPLATE}" \
    --toc --number-sections --number-offset=0 \
    --katex=${KATEX_DIR}
    --default-image-extension=jpg \
    --standalone --self-contained

