#!/bin/bash
echo "Список файлов во входной директории (не во вложенных):"
ls -p $1 | grep -v /

echo ""
echo "Список директорий:"
dirs_list=$(find $1 -type d -mindepth 1)
for directory in $dirs_list
do
out=$(echo $directory | sed 's|'$1'/|./|')
echo $out
done

echo ""
echo "Список всех файлов:"
file_list=$(find $1 -mindepth 1)
for file in $file_list
do
out=$(echo $file | sed 's|'$1'/|./|')
echo $out
done

echo ""
echo "Копирование всех файлов:"
file_list=$(find $1 -mindepth 1)
for file in $file_list
do
out=$(basename $file)
out2="$2/$out"
if [ -e $out2 ]
then
while [ -e $out2 ]
do
out="new_${out}"
out2="$2/$out"
done
fi

if [ -d $file ]
then
echo " "
else
cp $file $out2
echo "$out скопирован под названием $out2"
fi
done
