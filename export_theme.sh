#!/usr/bin/env bash

set -ue

GTK3_GENERATE_DARK='false'
OUTPUT_THEME_NAME='nord'
DEST_PATH_ROOT="${HOME}/.themes"
MAKE_OPTS='all'

SRC_PATH=$(readlink -f "$(dirname "$0")")

PATHLIST=(
  './src/assets'
  './src/gtk-3.20'
  'Makefile'
  './src/index.theme'
)

DEST_PATH="${DEST_PATH_ROOT}/${OUTPUT_THEME_NAME}"

rm -fr ${DEST_PATH}
mkdir -p ${DEST_PATH}
echo -e "\nBuilding theme at ${DEST_PATH}\n"
cp -r "${SRC_PATH}/src/index.theme" ${DEST_PATH}

for FILEPATH in "${PATHLIST[@]}"; do
  cp -r "${SRC_PATH}/${FILEPATH}" ${DEST_PATH}
done

cd ${DEST_PATH}

if [[ ${GTK3_GENERATE_DARK} != 'true' ]] ; then
  if [[ -f ./gtk-3.20/scss/gtk-dark.scss ]] ; then
    rm ./gtk-3.20/scss/gtk-dark.scss
  fi
fi

env MAKEFLAGS= make --jobs="$(nproc)" ${MAKE_OPTS}

rm -fr ./Makefile gtk-3.*/scss
mv -f ./gtk-3.20 ./gtk-3.0

exit 0