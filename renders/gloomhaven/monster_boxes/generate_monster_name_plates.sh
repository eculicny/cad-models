#!/bin/bash

set -e

mkdir -p ./name_plates

VERSION=1
NAMES=(
    'Ancient Artillery'
	'Archer'
	'Guard'
	'Imps '
	'Cave Bear'
	'Cultist'
	'Tentacle'
	'Earth Demon'
	'Fire Demon'
	'Frost Demon'
	'Giant Viper'
	'Harrower'
	'Hound'
	'Shaman'
	'Living Bones'
	'Living Corpse'
	'Living Shadow(?)'
	'Mirelurk (def not the name)'
	'Night Demon'
	'Ooze'
	'Rending Drake'
	'Savaas Frost'
	'Savaas Fire'
	'Spitting Drake'
	'Stone Golem'
	'Sun Demon'
	'Scout'
	'Wind Demon'
	'Bosses(?)'
	'FC Monster 1'
	'FC Monster 2'
	'FC Monster 3'
)

for input_name in "${NAMES[@]}"
do
    OUTPUT_NAME=$(echo $input_name | tr '[:upper:]' '[:lower:]')
    OUTPUT_NAME=${OUTPUT_NAME// /_}
    echo $OUTPUT_NAME
    openscad -o ./name_plates/monster_name_plate_${OUTPUT_NAME}.stl --export-format binstl -D monster_name="\"${input_name}\"" ./monster_box_name_plate_v${VERSION}.scad
done
