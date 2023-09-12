#!/bin/bash  

STRING="{\"Themes\": {"
for f in */*; do
	declare -a DOWNLOADS=()
	STRING=$STRING"\"$(basename $f)\":{"
	for i in $f/*; do
		N=$(basename $i)
		if [ "${N: -4}" == ".jpg" ]; 
		then
			DOWNLOADS+=($N)
			STRING=$STRING"\"img\":\"$N\"," #image
		elif [[ $N != *.* ]];  #weather icon
		then
			DOWNLOADS+=($N/weathericons)
		else
			DOWNLOADS+=($N)
		fi
	done
	STRING=$STRING"\"downloads\":\"["
	pos=$(( ${#DOWNLOADS[*]} - 1 ))
	last=${DOWNLOADS[$pos]}
	for d in "${DOWNLOADS[@]}"; do
		if [[ $d == $last ]]
		then
		     STRING=$STRING$d
		else 
			STRING=$STRING$d,
		fi
	done
	STRING=$STRING"]\"},"
done
STRING=$STRING"}}"
echo $STRING > themes.json

git add .
git commit -m "$*"
git branch -M main
git push -u origin main


