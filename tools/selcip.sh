#!/bin/bash
#
# this is selcip.sh - shell escaping latex commands is PAIN
#
# the script will read all eps logo filenames from skill-icons, randomly assign 1-4 
# points to each skill and generate the appropriate latex code for the table
# it must be run from the main directory of the repository
# (where skill-icons/ is located)
#
# this is meant to be run as "bash tools/selcip.sh > skilltable.inc"
# which  will update skilltable.inc  with all images from skill-icons/ 
# skilltable.inc is included by skilltable.tex 
#

echo "%"
if [ ! -d skill-icons ] ; then
  echo "ERROR: must be run in main directory on the repository (where skill-icons is located)"
  echo
  exit 1
fi
maxcount=0
count=0
b_off='\textcolor{lightgray}{$\bullet$}'
b_on='$\bullet$'
b_end='\\'

for fn in skill-icons/*eps ; do 
  fname=`basename "$fn"`
  image_name=`echo "$fn" | sed -r -e 's/(.*skillicons_)(.*)(.eps)$/\2/'`
  skill_name=`echo "$image_name" | sed -r -e 's/[-_]/ /g'`
  points=$(( 1 + $RANDOM  % 4 )) 
  printf "\photosymbol{%s} & %s & %s & " "${image_name}" "${skill_name}" "${points}"
  case $points in
    1) printf "%s & %s & %s & %s %s \n"  ${b_on} ${b_off} ${b_off} ${b_off} ${b_end} ;;
    2) printf "%s & %s & %s & %s %s \n"  ${b_off} ${b_on} ${b_off} ${b_off} ${b_end} ;;
    3) printf "%s & %s & %s & %s %s \n"  ${b_off} ${b_off} ${b_on} ${b_off} ${b_end} ;;
    4) printf "%s & %s & %s & %s %s \n"  ${b_off} ${b_off} ${b_off} ${b_on} ${b_end} ;;
  esac 
  count=$(( ${count} + 1 ))
  if [ ${maxcount} -gt 0 ] && [ ${count} -ge ${maxcount} ] ; then
    break
  fi
done
echo "%"
echo "% found #${count} images"
echo
