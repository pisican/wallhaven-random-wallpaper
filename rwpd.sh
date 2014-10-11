#!/bin/bash
# Downloading random wallpapers from /wallhaven/ random page and setting 'em up

#Dirs, vars, etc declartion
pdir="$HOME/.ws"
bdir="$pdir/bin"
cdir="$pdir/pics"
# Check for the program's data dir and create it if its missing:
if [ -d $pdir ]
  then
			:
else
	mkdir $pdir
fi

#check for bin dir and bla bla bla
if [ -d $bdir ] 
	then
	 :
	else
   mkdir $bdir
fi

#BLA BLA BLA
if [ -d $cdir ]
	then
			:
	else
			mkdir $cdir
fi

# index.html check
if [ -f $pdir/index.html ]
 then
		rm $pdir/index.html
fi

#Download the /wallhaven/ page *FOR NOW, NSFW WALLPAPERS CAN APPLY*.
wget -q  --directory-prefix=$bdir alpha.wallhaven.cc/wallpaper/random/

#Getting wallpaper's page link
	func1(){
		rand1=$[ ( $RANDOM % 10 ) +1 ] #random in recursive function
		grep "wallpaper/$rand1" "$bdir/index.html" > $bdir/output.txt
		awk '{ print $3 }' $bdir/output.txt > $bdir/awk_output.txt; #THX AWK
		cat $bdir/awk_output.txt | head -1 > $bdir/awk2.txt;
		sed 's/href="//g' $bdir/awk2.txt > $bdir/awk3.txt;
		sed 's/"//g' $bdir/awk3.txt > $bdir/awk4.txt;
		link=$(cat $bdir/awk4.txt);

		if [ -s $bdir/output.txt ]
	 	then
			 	:
	 	else
				echo "Retrying..."
				sleep 2
			  func1
		fi	
}
func1

#Get the wallpaper link into var
wget -q "$link" -O $bdir/index.html
grep "full" "$bdir/index.html" > $bdir/output.txt
sed 's/src="//g' $bdir/output.txt > $bdir/output1.txt
sed 's/"//g' $bdir/output1.txt > $bdir/output2.txt
sed 's/http//g' $bdir/output2.txt > $bdir/output3.txt
sed 's/ //g' $bdir/output3.txt > $bdir/output4.txt
dos2unix -q $bdir/output4.txt #For this fucking %0D thing, thanks DOS.
link2="http$(cat $bdir/output4.txt)"


#Download the wallpaper (finally)
wget -q "$link2" -P $cdir -A jpg

#Cleanup
rm -r $bdir

#gg
sleep 1 && echo "Done, check for ~/.ws/pics/ to see your wallpapers"
exit 0
