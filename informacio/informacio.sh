#!/bin/bash
# 29-08-2012
# billy
# informacio.sh

SIOP=$(uname -o)
DIST=$(lsb_release -i | sed -e 's/Distributor ID://' -e 's/\t//g')
VERS=$(lsb_release -c | sed -e 's/Codename://' -e 's/\t//g')
MAQU=$(uname -m)
SIOP=$(echo "$SIOP $DIST $VERS $MAQU")
NUCL=$(uname -r)
UPTI=$(awk -F. '{print $1}' /proc/uptime)
let SEGS=$UPTI%60
let MINS=($UPTI/60)%60
let HORS=($UPTI/3600)%24
let DIES=$UPTI/86400
UPTI="${MINS}m"
if [ "${HORS}" -ne "0" ]; then
    UPTI="${HORS}h ${UPTI}"
fi
if [ "${DIES}" -ne "0" ]; then
    UPTI="${DIES}d ${UPTI}"
fi
PAQU=$(dpkg --get-selections | wc -l)
CPUI=$(awk -F':' '/model name/{ print $2 }' /proc/cpuinfo | head -n 1 | tr -s " " | sed 's/^ //')
VGAI=$(lspci | grep VGA | cut -d":" -f3- | cut -d"(" -f1 | cut -d"[" -f1 | cut -d"," -f1 | sed 's/^ //')
echo -e "\033[1;32mSistema Operatiu\033[0m: $SIOP"
echo -e "\033[1;32mNucli\033[0m: $NUCL"
echo -e "\033[1;32mTemps encès\033[0m: $UPTI"
echo -e "\033[1;32mPaquets instalats\033[0m: $PAQU"
echo -e "\033[1;32mCPU\033[0m: $CPUI"
echo -e "\033[1;32mVGA\033[0m: $VGAI"

if [ -f /sys/class/power_supply/BAT?/uevent ] ; then
    if [ -f /sys/class/power_supply/BAT?/energy_now ] ; then
	BATV=$(cat /sys/class/power_supply/BAT?/energy_full_design)
	BAT0=$(cat /sys/class/power_supply/BAT?/energy_full)
	BAT1=$(cat /sys/class/power_supply/BAT?/energy_now)
    fi
    
    if [ -f /sys/class/power_supply/BAT?/charge_now ] ; then
	BATV=$(cat /sys/class/power_supply/BAT?/charge_full_design)
	BAT0=$(cat /sys/class/power_supply/BAT?/charge_full)
	BAT1=$(cat /sys/class/power_supply/BAT?/charge_now)
    fi
	BATV=$(echo "scale=3;($BAT0 / $BATV) * 100" | bc -l)
	BATV=$(basename $BATV 00)
	BATC=$(echo "scale=3;($BAT1 / $BAT0) * 100" | bc -l)
	BATC=$(basename $BATC 00)
	echo -ne "\033[1;32mVida bateria\033[0m: $BATV%\t\t"
	ALM=$(echo "$BATV / 100" | bc -l)
	ALM=$(echo "scale=0;$ALM * 30" | bc -l)
	ALM=$(echo "$ALM" | cut -d"." -f1)
	if [ -z $ALM ] ; then
	    ALM=0
	fi
	if [ $ALM -gt 30 ] ; then
	    ALM=30
	fi
	if [ $ALM -lt 1 ] ; then
	    echo -ne "\033[31m["
	else
	    if [ $ALM -gt 29 ] ; then
		echo -ne "\033[32m["
	    else
		echo -ne "["
	    fi
	fi
	for i in $(seq 1 $ALM) ; do
	    echo -ne "#"
	done
	let ALM=$ALM+1
	for i in $(seq $ALM 30) ; do
	    echo -ne ".";
	done
	echo -ne "]\033[0m"
	echo ""
	echo -ne "\033[1;32mCàrrega bateria\033[0m: $BATC%\t\t"
	ALM=$(echo "$BATC / 100" | bc -l)
	ALM=$(echo "scale=0;$ALM * 30" | bc -l)
	ALM=$(echo "$ALM" | cut -d"." -f1)
	if [ -z $ALM ] ; then
	    ALM=0
	fi
	if [ $ALM -gt 30 ] ; then
	    ALM=30
	fi
	if [ $ALM -lt 1 ] ; then
	    echo -ne "\033[31m["
	else
	    if [ $ALM -gt 29 ] ; then
		echo -ne "\033[36m["
	    else
		echo -ne "["
	    fi
	fi
	for i in $(seq 1 $ALM) ; do
	    echo -ne "#"
	done
	let ALM=$ALM+1
	for i in $(seq $ALM 30) ; do
	    echo -ne ".";
	done
	echo -ne "]\033[0m"
	echo ""
fi
MEMT=$(awk '/MemTotal/ { print $2 }' /proc/meminfo)
MEMT=$(echo "scale=1;$MEMT / 1024" | bc -l)
MEMU=$(awk '/MemFree/ { print $2 }' /proc/meminfo)
MEMU=$(echo "scale=1;$MEMU / 1024" | bc -l)
MEMU=$(echo "$MEMT - $MEMU" | bc -l)
MEMB=$(free | grep "Mem" | awk '{print $6}')
MEMB=$(echo "scale=1;$MEMB / 1024" | bc -l)
MEMA=$(echo "$MEMT" | cut -d"." -f1)
if [ $MEMA -gt 1024 ] ; then
    MEMT=$(echo "scale=2;$MEMT / 1024" | bc -l)
    MEMU=$(echo "scale=2;$MEMU / 1024" | bc -l)
    MEMB=$(echo "scale=2;$MEMB / 1024" | bc -l)
    MEMA=$(echo "$MEMB" | cut -d"." -f1)
    if [ -z "$MEMA" ] ; then
	MEMB=$(echo "0$MEMB")
    fi
    MEMA=$(echo "$MEMU" | cut -d"." -f1)
    if [ -z "$MEMA" ] ; then
	MEMU=$(echo "0$MEMU")
    fi    
    MEMO=$(echo "$MEMB ($MEMU) / $MEMT GiB")
else
    MEMO=$(echo "$MEMB ($MEMU) / $MEMT MiB")
fi
echo -ne "\033[1;32mRAM\033[0m: $MEMO\t"
ALM1=$(echo "$MEMB / $MEMT" | bc -l)
ALM1=$(echo "scale=0;$ALM1 * 30" | bc -l)
ALM1=$(echo "$ALM1" | cut -d"." -f1)
ALM2=$(echo "$MEMU / $MEMT" | bc -l)
ALM2=$(echo "scale=0;$ALM2 * 30" | bc -l)
ALM2=$(echo "$ALM2" | cut -d"." -f1)

if [ -z $ALM1 ] ; then
    ALM1=0
fi
if [ $ALM1 -gt 30 ] ; then
    ALM1=30
fi
if [ -z $ALM2 ] ; then
    ALM2=0
fi
if [ $ALM2 -gt 30 ] ; then
    ALM2=30
fi
if [ $ALM1 -gt $ALM2 ] ; then
    ALM2=$ALM1
fi
echo -ne "["
for i in $(seq 1 $ALM1) ; do
    echo -ne "\033[32m#"
done
echo -ne "\033[0m"
let ALM1=$ALM1+1
echo -ne "\033[33m"
for i in $(seq $ALM1 $ALM2) ; do
    echo -ne "#"
done
echo -ne "\033[0m"
let ALM2=$ALM2+1
for i in $(seq $ALM2 30) ; do
    echo -ne ".";
done
echo -ne "]"
echo ""  

SWAT=$(awk '/SwapTotal/ { print $2 }' /proc/meminfo)
SWAT=$(echo "scale=2;$SWAT / 1024" | bc -l)
SWAU=$(awk '/SwapFree/ { print $2 }' /proc/meminfo)
SWAU=$(echo "scale=2;$SWAU / 1024" | bc -l)
SWAU=$(echo "$SWAT - $SWAU" | bc -l)
SWAA=$(echo "$SWAT" | cut -d"." -f1)
if [ $SWAA -gt 1024 ] ; then
    SWAT=$(echo "scale=2;$SWAT / 1024" | bc -l)
    SWAU=$(echo "scale=2;$SWAU / 1024" | bc -l)
    SWAA=$(echo "$SWAU" | cut -d"." -f1)
    if [ -z "$SWAA" ] ; then
	SWAU=$(echo "0$SWAU")
    fi
    SWAO=$(echo "$SWAU / $SWAT GiB")
else
    SWAO=$(echo "$SWAU / $SWAT MiB")
fi
echo -ne "\033[1;32mSwap\033[0m: $SWAO\t\t"
ALM=$(echo "$SWAU / $SWAT" | bc -l)
ALM=$(echo "scale=0;$ALM * 30" | bc -l)
ALM=$(echo "$ALM" | cut -d"." -f1)
if [ -z $ALM ] ; then
    ALM=0
fi
if [ $ALM -gt 30 ] ; then
    ALM=30
fi
if [ $ALM -gt 29 ] ; then
    echo -ne "\033[32m["
else
    echo -ne "["
fi
for i in $(seq 1 $ALM) ; do
    echo -ne "#"
done
let ALM=$ALM+1
for i in $(seq $ALM 30) ; do
    echo -ne ".";
done
echo -ne "]\033[0m"
echo ""  

NUMP=$(cat /proc/cpuinfo | grep "cpu MHz" | wc -l)
FREQ=$(awk -F':' '/model name/{ print $2 }' /proc/cpuinfo | head -n 1 | tr -s " " | cut -d"@" -f2 | sed 's/^ //')
for i in $(seq 1 $NUMP) ; do
    let AUX=$NUMP-$i+1
    MHZ=$(cat /proc/cpuinfo | grep "cpu MHz" | cut -d":" -f2 | sed 's/^ //' | tail -n$AUX | head -n1)
    GHZ=$(echo "scale=2;$MHZ / 1000" | bc -l)
    GHZA=$(echo "$GHZ" | cut -d"." -f1)
    if [ -z "$GHZA" ] ; then
        GHZ=$(echo "0$GHZ")
    fi
    echo -ne "\033[1;32mCPU $i\033[0m: $GHZ / $FREQ \t\t"
    FRE=$(echo "$FREQ" | cut -d"G" -f1)
    ALM=$(echo "$GHZ / $FRE" | bc -l)
    ALM=$(echo "scale=0;$ALM * 30" | bc -l)
    ALM=$(echo "$ALM" | cut -d"." -f1)
    if [ -z $ALM ] ; then
	ALM=0
    fi
    if [ $ALM -gt 30 ] ; then
	ALM=30
    fi
    if [ $ALM -gt 29 ] ; then
	echo -ne "\033[36m["
    else
	echo -ne "["
    fi
    for i in $(seq 1 $ALM) ; do
	echo -ne "#"
    done
    let ALM=$ALM+1
    for i in $(seq $ALM 30) ; do
	echo -ne ".";
    done
    echo -ne "]\033[0m"
    echo ""  
done

GREP="/dev/\|lan"
NUMD=$(/bin/df | grep $GREP | wc -l)
for i in $(seq 1 $NUMD) ; do
    let AUX=$NUMD-$i+1
    MON=$(/bin/df | grep $GREP | awk '{print $6}'| tail -n$AUX | head -n1)
    TMP=$(echo "$MON" | grep media)
    if [ ! -z $TMP ] ; then
	MON=${MON:7}
    fi
    if [ "$MON" != "/dev/shm" ] ; then
	PER=$(/bin/df | grep $GREP | awk '{print $5}'| tail -n$AUX | head -n1)
	TAM=$(/bin/df | grep $GREP | awk '{print $2}'| tail -n$AUX | head -n1)
	TAM=$(echo "scale=1;$TAM / 1048576" | bc -l)
	TOM=$(echo "$TAM" | cut -d"." -f1)
	if [ -z $TOM ] ; then
	    TOM=0
	    TAM=0$TAM
	fi
	if [ $TOM -gt 1024 ] ; then
	    TAM=$(echo "scale=1;$TAM / 1024" | bc -l)
	    TAM=$(echo "$TAM TiB")
	else
	    TAM=$(echo "$TAM GiB")
	fi
	echo -ne "\033[1;32m$MON\033[0m: $PER de $TAM \t"
	if [ ${#MON} -le 7 ] ; then
	    echo -ne "\t"
	fi
	PER=$(echo "$PER" | cut -d"%" -f1)
	ALM=$(echo "$PER / 100" | bc -l)
	ALM=$(echo "scale=0;$ALM * 30" | bc -l)
	ALM=$(echo "$ALM" | cut -d"." -f1)
	if [ -z $ALM ] ; then
	    ALM=0
	fi
	if [ $ALM -gt 30 ] ; then
	    ALM=30
	fi
	if [ $ALM -gt 29 ] ; then
	    echo -ne "\033[36m["
	else
	    echo -ne "["
	fi
	for i in $(seq 1 $ALM) ; do
	    echo -ne "#"
	done
	let ALM=$ALM+1
	for i in $(seq $ALM 30) ; do
	    echo -ne ".";
	done
	echo -ne "]\033[0m"
	echo ""
    fi
done
