# add a new logo

to add new skill logos do the following:

- get logo for the skill, i.e. from https://www.svgrepo.com - as an example we use NewLogo.svg and
  put it into the newlogo directory.

- convert to eps with imagemagick
  ```
  convert newlogo/NewLogo.svg -resize 92x92 skill-icons/skillicons_NewLogo.eps
  ```
  
- create intermediate files and test logo
  ```
  pdflatex -shell-escape newlogo/newlogo
  gs newlogo.pdf
  ```

Note: when latex complains about a missing skillicons_NewLogo-eps-converted-to.pdf, then there was a problem
to create the intermediate pdf format. If this happens, make sure that the skill-icons folder contains the
respective eps, is not a link. To make sure all newly generated logos are setup correctly, add them to either 
the skilltable.tex or the skillicons.tex file and compile them once.
See tools/selcip.sh for more info
