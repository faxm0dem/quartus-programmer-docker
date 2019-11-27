# Note

This was forked from corna/quartus-docker and adapted to use for the Quartus Programmer.
I am using it for programming the Apollo Team's Vampire V4.

# Why docker?

Two reasons:

1. Quartus needs outdated 32bit libraries like libpng12 which most of us don't have access to on our GNU/Linux distributions without crippling them unnecessarily
2. Containers give extra security for instance by not exposing local filesystems to the running app

# Docker for Quartus Programmer 13.1

Needs [x11docker](https://github.com/mviereck/x11docker). Additional packages [may be required](https://github.com/mviereck/x11docker#dependencies).

### Building the container

```
docker build -t quartus .
```

This should:

1. Download the installer
2. Run the installer
3. move the installed files to the correct final place
4. build the container

You can also specify an alternate url for the installer:

```
docker build -t quartus --build-arg url=http://download.altera.com/akdlm/software/acdsinst/13.1/162/ib_installers/QuartusProgrammerSetup-13.1.0.162.run .
```

### Setting udev rules

Don't forget to add the udev rules (on the host) to allow Quartus access to the USB programmers; for example, this file

```
# USB-Blaster
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"

# USB-Blaster II
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
```

put in /etc/udev/rules.d/50-usb-blaster.rules gives full access to the USB-Blaster devices to any user.
Use `udevadm control --reload` (and plug again the device if already plugged) to refresh the permissions.

### Running the container

```
x11docker --clipboard --home=/path/to/my/jitfiles -- "--device=/dev/bus/usb/ --network none" quartus
```

This should run Quartus programmer, and you should have access to your USB Blaster, and to your `.jic` files in `/path/to/my/jitfiles`.

