#!/bin/bash

data_dir=./LaCie/08242020

for fileName in $data_dir/*.sac
do
echo $fileName
if [ -f $fileName ];
then

sac << sacend
SETBB RESP "./instrumentRESPONSES"

r $fileName
chnhdr NVHDR 7 
w over

r $fileName
printf $fileName
printf "___V7_____"
rmean
rtrend
taper

# if transfer function is unsuccessful, dont write new .VEL.SAC file
TRANSFER FROM EVALRESP FNAME %resp TO VEL freqlim 0.1 0.2 40 60
w change .sac .VEL.SAC

quit
sacend
fi
done


mkdir -p ./instrumentRESPONSES/done
mv $data_dir/*.VEL.SAC ./instrumentRESPONSES/done


