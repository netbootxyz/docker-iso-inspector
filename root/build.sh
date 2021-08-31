#! /bin/bash
set -e

URL=${URL}
TYPE=${TYPE}

if [[ "${TYPE}" == "file" ]]; then
  curl -o \
  /root/Downloads/temp.iso -L \
  "${URL}"
elif [[ "${TYPE}" == "torrent" ]]; then
  tmpfile=$(mktemp)
  chmod a+x $tmpfile
  echo "killall transmission-cli" > $tmpfile
  transmission-cli -f $tmpfile ${URL} || :
fi

# dump filesystem structure to screen
cd /root/Downloads
find . -name "*.iso" -exec 7z x {} -y \;

echo "Listing filesystem from iso..."

find .

exit 0
