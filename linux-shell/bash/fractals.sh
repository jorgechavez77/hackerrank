#!/bin/bash

row=63
col=100
dash="_"
val="1"

calculate() {
   for ((i=$row; i > 0; i--))
   do
      if ((i > $row - $1))
      then
         matrix[$i,$t1]=$val
      elif ((i > $row - $2))
      then
         t2=$(($t2 - 1))
         t3=$(($t3 + 1))
         matrix[$i,$t2]=$val
         matrix[$i,$t3]=$val
      fi
   done
}

trunk() {
   min=$1
   max=$2
   pos=$3
   for ((i=$max; i > $min; i--))
      do
         matrix[$i,$pos]=$val
      done
}

branch() {
   min=$1
   max=$2
   pos=$3
   le=$pos
   ri=$pos
   for ((i=$max; i > $min; i--))
      do
         le=$(($le - 1))
         ri=$(($ri + 1))
         matrix[$i,$le]=$val
         matrix[$i,$ri]=$val
   done
}

read N

declare -A matrix

# Initialize
for ((i=0; i < $row; i++))
do
   for ((j=0; j<$col; j++))
   do
      matrix[$i,$j]=$dash
   done
done

# Calculate
for ((n=1; n <= $N; n++))
do
   for ((i=0; i< $n; i++))
   do
      a=$(($row - 2**(5-$n)))
      b=$(($row + 2**($n-1)))
      c=$(($col/($n*2) - 1))
      trunk $a $b $c
      b=$a
      c=$a+2
      a=$(($row - 2*2**(5-$n)))
      branch $a $b $c
   done
done

# Print
for ((i=0; i < $row; i++))
do
   for ((j=0; j<$col; j++))
   do
      printf ${matrix[$i,$j]}
   done
   echo ""
done

