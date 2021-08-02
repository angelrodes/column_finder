#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
printf "${RED}Input file:${NC}\n$1\n"
printf "${RED}Input:${NC}\n"
echo "$(cat $1 | head -n 3)"
printf "${BLUE}...${NC}\n"
echo "$(cat $1 | tail -n 3)"
DATA=$(cat $1)

ZEROSANDONES=$(cat $1| sed 's|[^\ ]|1,|g' | sed 's|[\ ]|0,|g')

printf "${RED}Output:${NC}\n"

echo "$ZEROSANDONES">output.txt
echo "$(numsum -c -s ","  output.txt | sed 's/ /\n/g')" > output.txt
MINVALUE=$(cat output.txt | sort -n | head -1)
echo "MINVALUE: $MINVALUE"
COLUMNNUMBERS=$(grep -n -e "^$MINVALUE$" output.txt | cut -d":" -f1)
#echo "COLUMNS:"
#echo "$COLUMNNUMBERS"

cat $1 > output.txt

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
cat output.txt > $1.for_xls.txt
rm output.txt


