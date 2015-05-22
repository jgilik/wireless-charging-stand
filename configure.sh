#!/bin/bash
# Copyright 2014 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Strictest error handling I know of.
set -Eeo pipefail

# Script directory - used to determine where to put output.
# From: http://stackoverflow.com/a/246128
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Generate enums.scad, so that we have a single source of truth on what enum
# values are valid.
enums="$DIR/enums.scad"
echo -n '' > "$enums"
config="$DIR/config.scad"
echo -n '' > "$config"

# Converts a human-readable value name to a form usable as an OpenSCAD
# variable.
canonicalize_enum()
{
  echo "$@" | tr ' ' '_'
}

# Returns success if the arguments represent a number.
# From: http://stackoverflow.com/a/3951175
is_number()
{
  case "$@" in
    ''|*[!0-9]*) return 1 ;;
    *) return 0 ;;
  esac
}

phone_types=()
phone_types+=("Nexus 5 with Diztronic bumper")
phone_types+=("Nexus 5 with Nilkin Fruit series folio")
phone_types+=("Nexus 5 with no case")
echo "Select a phone type from the following list:"
index=1
declare -A phone_type_index_map
for phone_type in "${phone_types[@]}"
do
  var_name="phone_type_$(canonicalize_enum "$phone_type")"
  echo "$var_name = $index;" >> "$enums"
  echo "${index}. $phone_type"
  phone_type_index_map["$index"]="$phone_type"
  index="$(expr "$index" + 1)"
done
phone_type_id=""
while ! is_number "$phone_type_id" \
  || (( "$phone_type_id" < 1 || "$phone_type_id" > "${#phone_types[@]}" ))
do
  read -p 'Phone type number> ' -r phone_type_id
done
phone_type="${phone_type_index_map[$phone_type_id]}"
echo "phone_type = phone_type_$(canonicalize_enum "$phone_type");" >> "$config"

charger_types=()
charger_types+=("Aukey")
charger_types+=("beepy")
charger_types+=("official Nexus Charger")
echo "Select a charger type from the following list:"
index=1
declare -A charger_type_index_map
for charger_type in "${charger_types[@]}"
do
  var_name="charger_type_$(canonicalize_enum "$charger_type")"
  echo "$var_name = $index;" >> "$enums"
  echo "${index}. $charger_type"
  charger_type_index_map["$index"]="$charger_type"
  index="$(expr "$index" + 1)"
done
charger_type=""
while ! is_number "$charger_type_id" \
  || (( "$charger_type_id" < 1 || "$charger_type_id" > "${#charger_types[@]}" ))
do
  read -p 'Charger type number> ' -r charger_type_id
done
charger_type="${charger_type_index_map[$charger_type_id]}"
echo "charger_type = charger_type_$(canonicalize_enum "$charger_type");" >> "$config"

echo "Ready to build.  Run:"
echo "\$ openscad -o stand.stl main.scad"
echo "Once that's done, consider viewing the model in Meshlab:"
echo "\$ meshlab stand.stl"
