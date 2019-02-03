#!/bin/bash

sort_records() {
    local text="$1"
    local pattern="$2"

    echo "Every records begins with $pattern. Test input:"
    echo -e "$text"

    echo -e "\nSorted records:"
    echo -e "$text" |
    sed -e "/^$pattern/i"'\\n' |
    #sed -ne "/^$pattern/{ =;:a;N;/^$pattern/!ba;s/\n/, /p }" |
    #sed -re '/^[[:digit:]]+$/ { N;s/\n/, / }' |
    #sort -nr -t',' -k1 |
    #sed -re 's/^[[:digit:]]+, (.*)/\1/;$s/, //;$!s/, /\n/'

    sed -re ':r;/(^|\n)$/!{$!{N;br}};s/\n/, /g;/^'$pattern'/=' |
    sed -re '/^[[:digit:]]+$/ { N;s/\n/, / }; /^$/d' |
    sort -nr -t',' -k1 |
    sed -re 's/^[[:digit:]]+, (.*)/\1/;s/, /\n/g' |
    sed -re '/^$/d'
}

sort_records 'AAA10\nAAA20\nBAA30\nAAA40\nBAA50\nAAA60\nBAA70\nAAA80\nBAA90' "AAA"
echo -e '\n\n'
sort_records 'BAA10\nAAA20\nBAA30\nAAA40\nBAA50\nAAA60\nBAA70\nAAA80\nBAA90' "AAA"
echo -e '\n\n'
sort_records 'AAA10\nBAA20\nBAA30\nAAA40\nBAA50\nAAA60\nBAA70\nAAA80\nBAA90' "AAA"

