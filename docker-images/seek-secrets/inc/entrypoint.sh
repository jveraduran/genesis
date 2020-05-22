#!/bin/sh

echo "----Ejecutando trufflehog en $(pwd)-----"

OUTPUT=$(trufflehog --entropy=False --regex --rules /rules/regexes.json file://$(pwd) | tee /dev/stderr)

echo "----Resultados-----"
if [ ! $OUTPUT ]; then
    echo "No se han encontrado hallazgos."
else
    echo $OUTPUT
fi

