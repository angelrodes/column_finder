#!/bin/bash


zenity --entry --text "Enter text table" > /tmp/inputbox.tmp.$$

retval=$?

INPUT=`cat /tmp/inputbox.tmp.$$`


echo "$(cat input.txt)"

echo "$INPUT" >input.txt


clear
echo "INPUT:"
echo "$(cat input.txt)"
echo " "
echo "---"
echo " "



ZEROSANDONES=$(cat input.txt| sed 's|[^\ ]|1,|g' | sed 's|[\ ]|0,|g')


echo "$ZEROSANDONES">output.txt
echo "$(numsum -c -s ","  output.txt | sed 's/ /\n/g')" > output.txt
MINVALUE=$(cat output.txt | sort -n | head -1)
#echo "MINVALUE: $MINVALUE"
COLUMNNUMBERS=$(grep -n -e "^$MINVALUE$" output.txt | cut -d":" -f1)
#echo "COLUMNS:"
#echo "$COLUMNNUMBERS"


cat input.txt > output.txt

for COLUMN in $COLUMNNUMBERS
do
#echo $COLUMN
cat output.txt | sed "s/./\t/$COLUMN" > output2.txt
cat output2.txt > output.txt
done

for i in {1..100}
do
cat output.txt | sed 's/\n /\n/g' | sed 's/\t /\t/g' | sed 's/ \t/\t/g' > output2.txt
cat output2.txt > output.txt
done
rm output2.txt
echo "OUTPUT:"
cat output.txt
cat output.txt  | zenity --text-info


