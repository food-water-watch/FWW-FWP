#!/bin/sh
###
# VERSION 1.0 of the password enabler. Use the same version to disable it.
###
# Deactivating the password if it was set. Assuming the password was Detached
# ./setregproptool -d -o "<put current password here>"
sleep 20
# Setting the password and the mode
setregproptool -m command -p "<put new password here>" -o ""
# Logging
echo "The firmware password version 1.0 is now set up!"
exit 0