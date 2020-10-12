#!/bin/bash
if [ -z "$1" ] 
then
echo Pass a picture or a folder as an argument.
exit
else
echo Starting...
fi
multipleArguments(){
isDirectory=`file -b "$1"`
if [ "$isDirectory" = "directory" ] 
then
listOfImages=()
mapfile -t listOfImages < <(find "$1" -type f -iname "*.png" -maxdepth 1 2>/dev/null)
else
if [ ! -f "$1" ]
then
echo "File not found. Exitting..."
return
fi
fi
theScript(){
Image="$1" 
Width=$(identify -format '%w' "$Image")
Height=`identify -format '%h' "$Image"`
if [[ "$1" =~ '/' ]]
then
ctmDir="$(echo "$1" | sed -e 's/\/[^/]*$//')/FullCTM" 
thisName="`echo "$1" | sed -E -e 's/.*\/([^/]*)[.]png/\1/'`" 
else
ctmDir="./FullCTM"
thisName="`echo "$1" | sed -e 's/[.]png//'`"
fi
if [ ! -d "$ctmDir" ] 
then
mkdir "$ctmDir"
fi
if [ ! -d "$ctmDir/$thisName" ]
then
mkdir "$ctmDir/$thisName"
fi
ctmDir="$ctmDir/$thisName"
CopyWidth=`expr $Width - 1`
CopyHeight=`expr $Height - 1`
cp "$Image" "$ctmDir/0.png"
cp "$Image" "$ctmDir/1.png"
1.png(){ 
    if [ -z $2 ]
    then
    set -- "${@:1}" "${@:1}" 
    fi
    for i in $(seq 0 $CopyHeight) 
    do
    PixelColor=`convert "$ctmDir/$2.png" -format "%[pixel:p{$(expr $Width - 2),$i}]" info:-` 
    if [ $PixelColor = "none" ]
    then
    PixelColor="srgba(0,0,0,0)" 
    fi
    convert "$ctmDir/$1.png" -fill "$PixelColor" -draw "color $(expr $Width - 1),$i point" -define png:color-type=6 "$ctmDir/$1.png"
    done
}
1.png 1
cp "$ctmDir/1.png" "$ctmDir/2.png"
2.png(){
    if [ -z $2 ]
    then
    set -- "${@:1}" "${@:1}"
    fi
    for i in $(seq 0 $CopyHeight)
    do
    PixelColor=`convert "$ctmDir/$2.png" -format "%[pixel:p{1,$i}]" info:-`
    if [ $PixelColor = "none" ]
    then
    PixelColor="srgba(0,0,0,0)"
    fi
    convert "$ctmDir/$1.png" -fill "$PixelColor" -draw "color 0,$i point" -define png:color-type=6 "$ctmDir/$1.png"
    done
}
2.png 2
cp "$Image" "$ctmDir/3.png"
3.png(){
    if [ -z $2 ]
    then
    set -- "${@:1}" "${@:1}"
    fi
    for i in $(seq 0 $CopyHeight)
    do
    PixelColor=`convert "$ctmDir/$2.png" -format "%[pixel:p{1,$i}]" info:-`
    if [ $PixelColor = "none" ]
    then
    PixelColor="srgba(0,0,0,0)"
    fi
    convert "$ctmDir/$1.png" -fill "$PixelColor" -draw "color 0,$i point" -define png:color-type=6 "$ctmDir/$1.png"
    done
}
3.png 3
cp "$Image" "$ctmDir/12.png" 
12.png(){
    if [ -z $2 ]
    then
    set -- "${@:1}" "${@:1}"
    fi
    for i in $(seq 0 $CopyWidth) 
    do
    PixelColor=`convert "$ctmDir/$2.png" -format "%[pixel:p{$i,$(expr $Height - 2)}]" info:-` 
    if [ $PixelColor = "none" ]
    then
    PixelColor="srgba(0,0,0,0)"
    fi
    convert "$ctmDir/$1.png" -fill "$PixelColor" -draw "color $i,$(expr $Height - 1) point" -define png:color-type=6 "$ctmDir/$1.png" 
    done
}
12.png 12
cp "$ctmDir/12.png" "$ctmDir/24.png" 
24.png(){
    if [ -z $2 ]
    then
    set -- "${@:1}" "${@:1}"
    fi
    for i in $(seq 0 $CopyWidth) 
    do
    PixelColor=`convert "$ctmDir/$2.png" -format "%[pixel:p{$i,1}]" info:-` 
    if [ $PixelColor = "none" ]
    then
    PixelColor="srgba(0,0,0,0)"
    fi
    convert "$ctmDir/$1.png" -fill "$PixelColor" -draw "color $i,0 point" -define png:color-type=6 "$ctmDir/$1.png" 
    done
}
24.png 24
cp "$Image" "$ctmDir/36.png" 
36.png(){
    if [ -z $2 ]
    then
    set -- "${@:1}" "${@:1}"
    fi
    for i in $(seq 0 $CopyWidth) 
    do
    PixelColor=`convert "$ctmDir/$2.png" -format "%[pixel:p{$i,1}]" info:-` 
    if [ $PixelColor = "none" ]
    then
    PixelColor="srgba(0,0,0,0)"
    fi
    convert "$ctmDir/$1.png" -fill "$PixelColor" -draw "color $i,0 point" -define png:color-type=6 "$ctmDir/$1.png" 
    done
}
36.png 36
cp "$ctmDir/1.png" "$ctmDir/13.png" 
12.png 13 
cp "$ctmDir/2.png" "$ctmDir/14.png" 
12.png 14 
cp "$ctmDir/3.png" "$ctmDir/15.png" 
12.png 15 
cp "$ctmDir/24.png" "$ctmDir/25.png" 
1.png 25 
cp "$ctmDir/25.png" "$ctmDir/26.png" 
3.png 26 
cp "$ctmDir/24.png" "$ctmDir/27.png"
3.png 27
cp "$ctmDir/36.png" "$ctmDir/37.png"
1.png 37
cp "$ctmDir/2.png" "$ctmDir/38.png"
36.png 38
cp "$ctmDir/3.png" "$ctmDir/39.png"
36.png 39
PixelColorULC=`convert "$ctmDir/0.png" -format "%[pixel:p{0,0}]" info:-`
PixelColorURC=`convert "$ctmDir/0.png" -format "%[pixel:p{$CopyWidth,0}]" info:-`
PixelColorLLC=`convert "$ctmDir/0.png" -format "%[pixel:p{0,$CopyHeight}]" info:-`
PixelColorLRC=`convert "$ctmDir/0.png" -format "%[pixel:p{$CopyWidht,$CopyHeight}]" info:-`
if ([ "$PixelColorULC" = "none" ] || [ "$PixelColorURC" = "none" ] || [ "$PixelColorLLC" = "none" ] || [ "$PixelColorLRC" = "none" ])
then
echo "One or more corners appear to have no color, if you want to continue, type yes"
read $CornerColor
if [ "$ConerColor" != "yes" ]
then
exit
else
if [ "$PixelColorULC" = "none" ]
then
PixelColorULC="srgba(0,0,0,0)"
fi
if [ "$PixelColorURC" = "none" ]
then
PixelColorURC="srgba(0,0,0,0)"
fi
if [ "$PixelColorLLC" = "none" ]
then
PixelColorLLC="srgba(0,0,0,0)"
fi
if [ "$PixelColorLRC" = "none" ]
then
PixelColorLRC="srgba(0,0,0,0)"
fi
fi
fi
ulc(){ 
    convert "$ctmDir/$1.png" -fill "$PixelColorULC" -draw "color 0,0 point" -define png:color-type=6 "$ctmDir/$1.png"
}
urc(){ 
    convert "$ctmDir/$1.png" -fill "$PixelColorURC" -draw "color $CopyWidth,0 point" -define png:color-type=6 "$ctmDir/$1.png"
}
llc(){ 
    convert "$ctmDir/$1.png" -fill "$PixelColorLLC" -draw "color 0,$CopyHeight point" -define png:color-type=6 "$ctmDir/$1.png"
}
lrc(){ 
    convert "$ctmDir/$1.png" -fill "$PixelColorLRC" -draw "color $CopyWidth,$CopyHeight point" -define png:color-type=6 "$ctmDir/$1.png"
}
cp "$ctmDir/13.png" "$ctmDir/4.png"
lrc 4
cp "$ctmDir/15.png" "$ctmDir/5.png"
llc 5
cp "$ctmDir/37.png" "$ctmDir/16.png"
urc 16
cp "$ctmDir/39.png" "$ctmDir/17.png"
ulc 17
cp "$ctmDir/25.png" "$ctmDir/28.png"
urc 28
cp "$ctmDir/14.png" "$ctmDir/29.png"
lrc 29
cp "$ctmDir/38.png" "$ctmDir/40.png"
ulc 40
cp "$ctmDir/27.png" "$ctmDir/41.png"
llc 41
cp "$ctmDir/25.png" "$ctmDir/6.png"
urc 6
lrc 6
cp "$ctmDir/14.png" "$ctmDir/7.png"
llc 7
lrc 7
cp "$ctmDir/38.png" "$ctmDir/18.png"
ulc 18
urc 18
cp "$ctmDir/27.png" "$ctmDir/19.png"
ulc 19
llc 19
cp "$ctmDir/25.png" "$ctmDir/30.png"
lrc 30
cp "$ctmDir/14.png" "$ctmDir/31.png"
llc 31
cp "$ctmDir/38.png" "$ctmDir/42.png"
urc 42
cp "$ctmDir/27.png" "$ctmDir/43.png"
ulc 43
cp "$ctmDir/26.png" "$ctmDir/8.png"
ulc 8
llc 8
lrc 8
cp "$ctmDir/26.png" "$ctmDir/9.png"
ulc 9
urc 9
llc 9
cp "$ctmDir/26.png" "$ctmDir/10.png"
urc 10
lrc 10
cp "$ctmDir/26.png" "$ctmDir/11.png"
llc 11
lrc 11
cp "$ctmDir/26.png" "$ctmDir/20.png"
urc 20
llc 20
lrc 20
cp "$ctmDir/26.png" "$ctmDir/21.png"
ulc 21
urc 21
lrc 21
cp "$ctmDir/26.png" "$ctmDir/22.png"
ulc 22
urc 22
cp "$ctmDir/26.png" "$ctmDir/23.png"
ulc 23
llc 23
cp "$ctmDir/26.png" "$ctmDir/32.png"
lrc 32
cp "$ctmDir/26.png" "$ctmDir/33.png"
llc 33
cp "$ctmDir/26.png" "$ctmDir/34.png"
ulc 34
lrc 34
cp "$ctmDir/26.png" "$ctmDir/35.png"
urc 35
llc 35
cp "$ctmDir/26.png" "$ctmDir/44.png"
urc 44
cp "$ctmDir/26.png" "$ctmDir/45.png"
ulc 45
cp "$ctmDir/26.png" "$ctmDir/46.png"
ulc 46
urc 46
llc 46
lrc 46
}
if [ -v listOfImages ] 
then
    for m in "${listOfImages[@]}"
    do
        echo "$m"
        theScript "$m"
    done
else
theScript "$1"
fi
}
for k in "${@}" 
do
listOfImages=() 
echo "$k"
multipleArguments "$k"
done
