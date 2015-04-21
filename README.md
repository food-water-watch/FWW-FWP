FWW-FWP
=======

FWW Firmware Password Package
Required App: http://s.sudre.free.fr/Software/Packages/about.html

Extraction of binary
=======

Lets create a directory where we’ll store the binary, the scripts and the pkg

``` cd ; mkdir firmwareInstaller ; cd firmwareInstaller
diskutil mount Recovery\ HD 

hdiutil attach -quiet /Volumes/Recovery\ HD/com.apple.recovery.boot/BaseSystem.dmg

cp /Volumes/Mac\ OS\ X\ Base\ System/Applications/Utilities/Firmware\ Password\ Utility.app/Contents/Resources/setregproptool

hdiutil detach /Volumes/Mac\ OS\ X\ Base\ System/
diskutil unmount Recovery\ HD ```

Now for the sake of documenting check which version you just got and read through the available switches

``` sudo ./setregproptool ```

I am getting this on a 10.10

setregproptool v 2.0 (9) Jun 20 2012

Scripts
=======

Create the two scripts, one for enabling the firmware password and the second to disable the same. I highly recommend you create the installer and “uninstaller” in pairs and always match the version numbers. This is specially critical if you are required to change the firmware passwords in the future and versioning starts to be an issue.
The main reason for this is that computer models newer than 2010 require the same password to disable the prompt, so the “uninstaller” version should always match the installer version used previously.

This is, for example, you receive a brand new recent model half batch of computers, then you install your firmware password version 1.0. Then the next week you receive the other half of the shipment and install the firmware password version 1.1. Then if you use the uninstaller 1.0 to target all of them only the first half will have it disabled. What a difficult explanation but I hope is clear

Also it is a good practice that when you set the password to blank when disabling it. This way you won’t face problem if the computer needs to be protected again

touch enable.postflight.sh disable.postflight.sh
enable.postflight.sh could be something like this

```
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
```

```
#!/bin/sh
###
# VERSION 1.0 of the password disabler. Works only if the password was set up using the same version enabler
###
# Setting the password to blank WILL TAKE EFFECT AFTER REBOOT
$setregproptool -p "" -o "NewPassword"
sleep 1
# Disable the prompt for password
$setregproptool -d -o "NewPassword"
# Logging
echo "Firmware password now set to blank and prompt disabled, reboot for the changes to take effect!"
#forget that the password was ever installed. Munki likes this
pkgutil --forget com.mycompany.pkg.firm.pass
exit 0
As long a you use the same pkg name you can verify what version of the password a computer has by running
```

``` pkgutil --info com.mycompany.pkg.firm.pass ```

Then use the correct uninstaller

Packaging the Firmware Package
=======
Use the existing Packages projects as a guide. Keep in mind the critical steps are outlined below. Remember these packages require a reboot and propper permissions when adding the binary.

![alt tag](https://raw.githubusercontent.com/jonbrown21/FWW-FWP/master/img/1.png)
![alt tag](https://raw.githubusercontent.com/jonbrown21/FWW-FWP/master/img/2.png)
![alt tag](https://raw.githubusercontent.com/jonbrown21/FWW-FWP/master/img/3.png)
![alt tag](https://raw.githubusercontent.com/jonbrown21/FWW-FWP/master/img/4.png)
![alt tag](https://raw.githubusercontent.com/jonbrown21/FWW-FWP/master/img/5.png)
![alt tag](https://raw.githubusercontent.com/jonbrown21/FWW-FWP/master/img/6.png)

Let the mass deployment of firmware passwords begin!

Credit: http://www.nbalonso.com/install-firmware-passwords/
