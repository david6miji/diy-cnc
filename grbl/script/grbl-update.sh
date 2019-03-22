#!/bin/bash
echo "grbl update to uno"

test -e ../firmware/grbl_v1.1f.20170801.hex || wget https://github.com/gnea/grbl/releases/download/v1.1f.20170801/grbl_v1.1f.20170801.hex -o ../firmware/grbl_v1.1f.20170801.hex
test -e /usr/bin/avrdude || sudo apt-get install -y avrdude
sudo avrdude -v -patmega328p -Uflash:w:../firmware/grbl_v1.1f.20170801.hex:i -carduino -b 57600 -P /dev/ttyUSB1
