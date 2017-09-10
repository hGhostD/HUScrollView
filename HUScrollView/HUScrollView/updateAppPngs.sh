#!/bin/sh

#  updateAppPngs.sh
#
#
#  Created by Jianfeng Wu on 9/22/16.
#

sips -Z 40 ../1024.png --out AppIcon.appiconset/20@2x.png
sips -Z 60 ../1024.png --out AppIcon.appiconset/20@3x.png

sips -Z 58 ../1024.png --out AppIcon.appiconset/29@2x.png
sips -Z 87 ../1024.png --out AppIcon.appiconset/29@3x.png

sips -Z 80 ../1024.png --out AppIcon.appiconset/40@2x.png
sips -Z 120 ../1024.png --out AppIcon.appiconset/40@3x.png

sips -Z 120 ../1024.png --out AppIcon.appiconset/60@2x.png
sips -Z 180 ../1024.png --out AppIcon.appiconset/60@3x.png

#sips -Z 167 ../1024.png --out AppIcon.appiconset/83.5@2x.png

#create square slpash
#mkdir splash.imageset
#sips -Z 128 ../1024.png --out splash.imageset/splash.png
#sips -Z 256 ../1024.png --out splash.imageset/splash@2x.png
#sips -Z 384 ../1024.png --out splash.imageset/splash@3x.png

#create slim splash
#mkdir slimsplash.imageset
#sips -p 568 320 --padColor FFFFFF splash.imageset/splash.png --out slimsplash.imageset/slimsplash.png
#sips -p 1334 750 --padColor FFFFFF splash.imageset/splash@2x.png --out slimsplash.imageset/slimsplash@2x.png
#sips -p 2208 1242 --padColor FFFFFF splash.imageset/splash@3x.png --out slimsplash.imageset/slimsplash@3x.png

#create default splash image for iphone5/ios7
#sips -p 1136 640 --padColor FFFFFF splash.imageset/splash.png --out LaunchImage.launchimage/Default-568h@2x.png

