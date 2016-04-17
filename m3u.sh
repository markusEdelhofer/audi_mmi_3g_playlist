#!/bin/bash

# Bash script for creating m3u playlist for Audi MMI3G Plus and MMI3G High
# create: 2016-04-17

export IFS=$'\n'
for i in `ls -d -1 ../Musik/* |egrep -v ".mp3$|.m4a$"`; do

  #----------------------------------------------------------------------------
  # Genre Playlist

  folder=$(echo ${i} |sed 's/..\/Musik\/\(.*\)/\1/')
  file="${folder}.m3u"
  
  if [ -f "${file}" ]; then
    rm -rf "${file}"
  fi
  touch "${file}"

  find "${i}" -type f |sed 's/..\(.*\)/\1/' |sed 's/\//\\/g' >> "${file}"

  shuf ${file} > ${file}.tmp
  shuf ${file}.tmp > ${file}
  rm -rf ${file}.tmp

  #----------------------------------------------------------------------------
  # Artists Playlist

  for j in `ls -d -1 $i/* |egrep -v ".mp3$|.m4a$"`; do
    ufolder=${j##*/}

    ufile="${ufolder}.m3u"
    if [ -f "Artists/${ufile}" ]; then
      rm -rf "Artists/${ufile}"
    fi
    touch "${ufile}"

    find "${j}" -type f |sed 's/..\(.*\)/\1/' |sed 's/\//\\/g'  >> "${ufile}"

    shuf ${ufile} > ${ufile}.tmp
    shuf ${ufile}.tmp > ${ufile}
    rm -rf ${ufile}.tmp

  if [ ! -d Artists ]; then
    mkdir Artists
  fi
  mv "${ufile}" Artists/.

  done
done

