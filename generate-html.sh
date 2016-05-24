#!/usr/bin/env bash

function generate {
    generate_markdown
    generate_html
}

function generate_markdown {
    ./slides.sh
}

function generate_html {
    for f in $(ls *.md); do
        pandoc ${f} -o ${f%.*}.html -H header.html
    done
}

once=$1

until [[ -n ${once} ]]; do
    generate
    inotifywait -q `pwd`/slides.sh 2>&1 1> /dev/null
    sleep 0.1 # or we get file not ready errors
done
