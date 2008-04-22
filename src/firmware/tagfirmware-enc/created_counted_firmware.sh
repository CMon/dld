#!/bin/bash
if [ ! -e firmware_counter ]; then echo 1 > firmware_counter; fi

# bugfix for crappy compiler
export LC_ALL="C"

i=`cat firmware_counter`

while true; do

    sed -e "s/:TAG_ID:/$i/" < src/config_generated.h.in > src/config_generated.h
        
    make clean publish
    echo "
****************************************
* Prepared tag   $i
****************************************
Press [ENTER] to continue"

    i=$((i+1));
    echo $i > firmware_counter;    
    read;
done

