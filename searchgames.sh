#!/bin/bash

TITLE='Search game(s) in collection'

GAMECOLLECTION='/home/pi/gamecollection.dat'
GAMETOSEARCH=""
SEARCHRESULTFILE='/tmp/__searchresult.ttt'

function refreshCache() {
	dialog --backtitle "$TITLE" --infobox "Loading game collection..." 8 40
	echo -n >$GAMECOLLECTION
	rm -f /tmp/__*.ttt
	for f in `find -L /home/pi/RetroPie/roms/ -iname "gamelist.xml" | sort -t '\0' -n`; do
		EMULATOR=$(echo $f | sed 's/\/home\/pi\/RetroPie\/roms\///g' | sed 's/\/gamelist.xml//g' )
		xmlstarlet sel -t -m "//name" -v . -n $f >/tmp/__$EMULATOR.ttt
		PREFIX=$(printf "%-20s--> " $EMULATOR)
		sed -i "s|^|$PREFIX|" /tmp/__$EMULATOR.ttt
		cat /tmp/__$EMULATOR.ttt >>$GAMECOLLECTION
	done
	rm -f /tmp/__*.ttt
}

function searchGame() {
	exec 3>&1
	GAMETOSEARCH=$(dialog --backtitle "Search game(s) in collection" --cancel-label "Exit" --inputbox "Search game (min. 2 chars):" 8 40 2>&1 1>&3);
	YESNO=$?;
	while [  $YESNO -eq 0 ]  && [ ${#GAMETOSEARCH} -lt 2 ] ; do
		GAMETOSEARCH=$(dialog --backtitle "Search game(s) in collection" --cancel-label "Exit" --inputbox "Search game (min. 2 chars):" 8 40 2>&1 1>&3);
		YESNO=$?;
	done
	exec 3>&-;

	if [ $YESNO -eq 1 ] ; then
		exit 1
	fi
}

function showResult() {
	COLLECTIONCOUNT=$(grep -c "" $GAMECOLLECTION)
	GAMECOUNT=$(grep -ic "$GAMETOSEARCH" $GAMECOLLECTION)

	grep -i "$GAMETOSEARCH" $GAMECOLLECTION >$SEARCHRESULTFILE

	if [ -s $SEARCHRESULTFILE ] ; then
		dialog --backtitle "$TITLE" --title " Results [ $GAMECOUNT / $COLLECTIONCOUNT ]" --exit-label "Ok" --textbox $SEARCHRESULTFILE 50 80
	else
		dialog --backtitle "$TITLE" --msgbox "No results found for '$GAMETOSEARCH'." 8 40
	fi
}

#=============================================================================
# MAIN
#==============================================================================
if  [ ! -f $GAMECOLLECTION ] ; then
	refreshCache
else
   dialog --backtitle "$TITLE" --default-button "No" --yesno "\nRefresh game collection cache?" 7 60
   REFRESH=$?
   if [ $REFRESH -eq 0 ] ; then
      refreshCache
   fi
fi

while true; do
	searchGame
	showResult
done

