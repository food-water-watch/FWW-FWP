#!/bin/sh
###
# VERSION 1.0 of the setregproptool Binary Package
###
## Fix Permissions
sleep 5
chown root:wheel /usr/sbin/setregproptool
chmod 755 /usr/sbin/setregproptool
# Logging
echo "The Binary is now set up!"
exit 0