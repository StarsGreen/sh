#!/bin/sh
cur_dir=$(pwd)
filecount=0
echo $cur_dir
num=0
sleeptime=30
cur_time=$(date -u)
if [ ! -d "test.log" ];then
	touch test.log
fi
echo "###################################################">>$cur_dir/test.log
echo "-----------------this is a new test----------------">>$cur_dir/test.log
echo "-------time is $cur_time-------">>$cur_dir/test.log
echo "###################################################">>$cur_dir/test.log
while [ $num -lt "1000" ]
do
	echo "the first step"
	timeout -t $sleeptime 4camera -e "0 1 2 3,0 1 3" 
	#sleep $sleeptime
	#pkill 4camera
        timeout -t $sleeptime 4camera -e "0 1,2,3" 
	#sleep $sleeptime
	#pkill 4camera
        timeout -t $sleeptime 4camera -c 4 -n "0 1 10 11" -e "0 1 2 3" 
	#sleep $slepptime
	#pkill 4camera
        timeout -t $sleeptime 4camera -c 6 -n "0 1 10 11 12 13" -e "0 1 2,0 1 2 3" 
	#sleep $slepptime
	#pkill 4camera
	filecount=$(ls *.jpg|wc -w)
	if [ $filecount -eq "1" ];then
	       	echo "usb_camera_decode_error">>$cur_dir/test.log
          	echo "this is $num in 1000,bug error happens">>$cur_dir/test.log
	  	exit
	elif [ $filecount -eq "0" ];then
		echo "no bug here this time">>$cur_dir/test.log
	else
		echo "this is should not be printed">>$cur_dir/test.log
	fi
        echo "this is NO.$num test in 1000,the jpg file num is $filecount">>$cur_dir/test.log
  	let num+=1
 	rm $cur_dir/rawstream* -rf
done

exit

