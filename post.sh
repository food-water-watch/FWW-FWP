#!/bin/sh
###
# VERSION 1.0 of the password enabler. Use the same version to disable it.
###
## Fix Permissions

sleep 5
chown root:wheel /usr/sbin/setregproptool
chmod 755 /usr/sbin/setregproptool

# Deactivating the password if it was set. The script will fail or hang if the firmware password set does not match the one listed below.

/usr/sbin/setregproptool -d -o "veryoldpass"

sleep 5


# Setting the password and the mode. This will fail if the old password does not match exactly. 
# for 10.10 use sudo /usr/sbin/firmwarepasswd -verify to verify that the old password equals the veryoldpass below if it doesn't the script won't run.
# To verify the password on 10.6, 10.7, 10.8 & 10.9 run the BinaryOnly package first then run this command
#  

sudo /usr/sbin/setregproptool -m command -p "verynewpass" -o "veryoldpass"


# Logging

echo "The firmware password version 1.0 is now set up!"

exit 0