#!/bin/bash
# 23-08-2012
# billy
# orgMusica.sh

for i in "$@" ; do
    if [ -f "$i" ] ; then
	case "$i" in
	    *mp3 | *MP3 | *.ogg | *OGG | *.m4a | *M4A)
		GRU=$(mediainfo "$i" | grep "Performer   " | tail -n1 | cut -d':' -f2 | cut -d' ' -f2-)
		ANY=$(mediainfo "$i" | grep date | cut -d':' -f2 | cut -d' ' -f2-)
		if [ -z "$ANY" ] ; then
		    ANY="0000"
		fi
		ALB=$(mediainfo "$i" | grep "Album   "| head -n1 | cut -d':' -f2 | cut -d' ' -f2-)
		NUM=$(mediainfo "$i" | grep "Track name/Position" | cut -d':' -f2 | cut -d' ' -f2-)
		if [ -z $NUM ] ; then
		    NUM="0"
		fi
		if  [ $NUM -le 9 ] ; then
		    NUM="0"$NUM
		fi
		NOM=$(mediainfo "$i" | grep "Track name" | head -n1 | cut -d':' -f2 | cut -d' ' -f2-)
		NOM=$(basename "$NOM" .mp3)
		NOM=$(basename "$NOM" .MP3)
		NOM=$(basename "$NOM" .ogg)
		NOM=$(basename "$NOM" .OGG)
		NOM=$(basename "$NOM" .flac)
		NOM=$(basename "$NOM" .FLAC)
		NOM=$(basename "$NOM" .m4a)
		NOM=$(basename "$NOM" .M4A)
		EXT=$(mediainfo "$i" | grep "Complete name" | head -n1 | cut -d':' -f2 | cut -d' ' -f2-)
		EXT=$(basename "$EXT")
		case "$EXT" in
		    *mp3 | *MP3)
			EXT=".mp3"
			;;
		    *.ogg | *OGG)
			EXT=".ogg"
			;;
		    *.flac | *FLAC)
			EXT=".flac"
			;;
		    *.m4a | *M4A)
			EXT=".m4a"
			;;
		    *)
			EXT=""
			;;
		esac
		DIR="$ANY - $ALB"
		DIR=$(echo "$DIR" | sed -e 's/[áàäâ]/a/g' | sed -e 's/[éèëê]/e/g' | sed -e 's/[íìïî]/i/g' | sed -e 's/[óòöô]/o/g' | sed -e 's/[úùüû]/u/g' | sed -e 's/[ñ]/ny/g' | sed -e 's/[ç]/c/g' | sed -e 's/[¿?]/_/g')
		FIT="$NUM - $NOM$EXT"
		FIT=$(echo "$FIT" | sed -e 's/[áàäâ]/a/g' | sed -e 's/[éèëê]/e/g' | sed -e 's/[íìïî]/i/g' | sed -e 's/[óòöô]/o/g' | sed -e 's/[úùüû]/u/g' | sed -e 's/[ñ]/ny/g' | sed -e 's/[ç]/c/g' | sed -e 's/[¿?]/_/g')
		GRU=$(echo "$GRU" | sed -e 's/[áàäâ]/a/g' | sed -e 's/[éèëê]/e/g' | sed -e 's/[íìïî]/i/g' | sed -e 's/[óòöô]/o/g' | sed -e 's/[úùüû]/u/g' | sed -e 's/[ñ]/ny/g' | sed -e 's/[ç]/c/g' | sed -e 's/[¿?]/_/g')
		echo -e "\033[33m$i\033[0m \033[31m->\033[0m \033[32m$GRU\033[0m/\033[35m$DIR\033[0m/\033[36m$FIT\033[0m"
		if [ -f "$GRU/$DIR/$FIT" ] ; then
		    echo "El fitxer $GRU/$DIR/$FIT ja existeix, no es fa cap acció."
		else
		    mkdir -p "$GRU" > /dev/null
		    mkdir -p "$GRU/$DIR" > /dev/null
		    mv "$i" "$GRU/$DIR/$FIT" > /dev/null
		fi
		;;
	    *)
		;;
	esac
    fi
done