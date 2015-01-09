#!/bin/bash

echo "[MAIN] Checking dependencies..."

notfound=""
for i in wget tar quilt gunzip xz
do
  if ! which $i >/dev/null 2>&1
  then
    notfound="$notfound $i"
  fi
done
if test "$notfound"
then
  if which yum >/dev/null 2>&1
  then
    /bin/echo -en 1>&2 "Please run\n  yum install"
  elif which apt-get >/dev/null 2>&1
  then
    /bin/echo -en 1>&2 "Please run\n  apt-get install"
  else
    /bin/echo -en 1>&2 "Please install\n "
  fi
  echo 1>&2 "$notfound"
  echo 1>&2 before executing this script.
  exit 1
fi

if [ ! -f  "./linux-3.12.31.tar.xz" ]; then
  echo "[MAIN] Downloading Linux-3.12.31..."
  wget http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.31.tar.xz
fi
tar -Jxvf linux-3.12.31.tar.xz
mv linux-3.12.31 linux-3.12.31-rt45

if [ ! -f  bone-debian-7.5-2014-05-14-2gb.img ]; then
  echo "[MAIN] Downloading Debian 7.5 image"
  wget http://debian.beagleboard.org/images/bone-debian-7.5-2014-05-14-2gb.img.xz
  echo "[MAIN] Extracting Debian image"
  xz -d bone-debian-7.5-2014-05-14-2gb.img.xz
fi

echo "#####################################################################"