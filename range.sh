#!/bin/bash

for Size in $(eval echo {$1..$2..$3})
do
    for Runs in $(eval echo {$4..$5..$6})
    do
	_build/default/bin/ets_matrix all all $Size $Size $Runs
    done
done
echo All done
