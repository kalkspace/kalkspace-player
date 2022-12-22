# kalkspace-player

Kalkspace Player is a standalone video player solution for SBCs like raspberry pi and the likes.

## Building

Clone the https://github.com/armbian/build repo and copy the `userpatches` directory over to the cloned directory.
Then you can build the armbian image like this:

```bash
./compile.sh docker BOARD=khadas-vim3 BRANCH=current RELEASE=jammy BUILD_MINIMAL=yes BUILD_DESKTOP=no KERNEL_ONLY=no KERNEL_CONFIGURE=no COMPRESS_OUTPUTIMAGE=sha,gpg,img
```

A list of supported boards (BOARD variable) can be found in `config/targets.conf`.
This will take quite a while for a new build.

At the end you will find a new image in `outputs/images`

## Installing

Copy the img file to your sd card, insert the sd card in your SBC.

Example with dd under Linux:

```bash
sudo dd if=output/images/Armbian_22.11.0-trunk_Odroidc4_jammy_current_5.10.160_minimal.img bs=4M of=/dev/sdb conv=fsync oflag=direct status=progress
```

For a graphical UI to copy the image use https://www.balena.io/etcher/

Then attach a video output via HDMI, power on the SBC and once booting has been done it should show the KalkSpace logo.

## Using Kalkspace Player

Kalkspace player is intended to be used as a standalone video player solution. You should not need to attach a keyboard or whatever. If you deploy it in public make sure that it is not accessible as it is not particulary secure.

Interaction with the player is done via USB sticks. Prepare a USB stick and create a directory `kalkspace-player` on the USB stick.

### Updating the video file

Copy your video file to the `kalkspace-player` directory on your stick. It must be named `video.{avi,mp4,...}`. So for example if you have a mp4 file copy it to `kalkspace-player/video.mp4`.
Attach the stick to the SBC. It will copy the video file to the SBC and restart the player. Once the new video file is playing it is safe to remove the stick.

### Controlling cage

Kalkspace player uses https://www.hjdskes.nl/projects/cage/ as a wayland compositor. You can control `cage` by putting the optional `cage-options` file in the `kalkspace-player` directory.
For example if you want to rotate the screen by 90 degrees create the `kalkspace-player/cage-options` file on your stick with the following content:

```
-r
```

See the `cage` documentation for more options.
Insert the stick into the SBC. Kalkspace player should restart with the new option. Once the new video file is playing it is safe to remove the stick.

### Controlling mpv

Kalkspace player uses https://mpv.io/ to play the video. You can control `mpv` by putting the optional `mpv-options` file in the `kalkspace-player` directory.

The options will be appended to the player's command line.

Consult the `mpv` documentation for options

### Accessing the console

When the player updates its state you have a few seconds to stop it from restarting by pressing `CTRL-C` on an attached keyboard.

To gain super user privileges go to the second tty by pressing `CTRL-ALT-F2` and enter `root`. The standard armbian process will request you to create a new password.
To restart kalkspace player just exit the first console (`CTRL-ALT-F1`) by typing `exit` or hitting `CTRL-D`.