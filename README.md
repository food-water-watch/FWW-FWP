FWW-FWP
=======

FWW Firmware Password Package

Extraction of binary
=======

Lets create a directory where we’ll store the binary, the scripts and the pkg

``` cd ; mkdir firmwareInstaller ; cd firmwareInstaller
diskutil mount Recovery\ HD 
hdiutil attach -quiet /Volumes/Recovery\ HD/com.apple.recovery.boot/BaseSystem.dmg
cp /Volumes/Mac\ OS\ X\ Base\ System/Applications/Utilities/Firmware\ Password\ Utility.app/Contents/Resources/setregproptool .
hdiutil detach /Volumes/Mac\ OS\ X\ Base\ System/
diskutil unmount Recovery\ HD ```

