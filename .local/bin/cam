#!/bin/bash
# Sergi Webcam-Script V-0.8

# Gerät für Pixel 7a Webcam
PIXEL_DEVICE="/dev/video2"

# Standard Webcam Gerät
STANDARD_DEVICE="/dev/video0"

# Überprüfen, ob Pixel Webcam angeschlossen ist
if v4l2-ctl --list-devices | grep -q "Pixel 7a: Android Webcam"; then
    # Pixel Webcam ist angeschlossen
    DEVICE=$PIXEL_DEVICE
    # Setze die Auflösung und starte MPV mit Effekten und Crop
    v4l2-ctl --set-fmt-video=width=1920,height=1080,pixelformat=MJPG --device=$DEVICE
    mpv --untimed --no-cache --no-osc --no-input-default-bindings --profile=low-latency \
        --input-conf=/dev/null --title=webcam \
        --vf='crop=1080:1080,scale=1080:1080,hue=s=0' \
        --video-rotate=90 $DEVICE
else
    # Pixel Webcam ist nicht angeschlossen, Standard Webcam verwenden
    DEVICE=$STANDARD_DEVICE
    # Setze die bestmögliche Auflösung und Bildwiederholfrequenz für die Standard Webcam
    v4l2-ctl --set-fmt-video=width=1280,height=720,pixelformat=MJPG --device=$DEVICE
    # Starte MPV mit Effekten und Crop
    mpv --untimed --no-cache --no-osc --no-input-default-bindings --profile=low-latency \
        --input-conf=/dev/null --title=webcam \
        --vf='hue=s=0,crop=720:720,scale=720:720,vflip' \
        $DEVICE
fi


# Weitere mpv Filter
# vflip         Spiegelt das Video vertikal
# hflip         Spiegelt das Video horizontal
# rotate=PI/2   Dreht das Video um 90 Grad im Uhrzeigersinn
# transpose=1   Dreht das Video um 90 Grad gegen den Uhrzeigersinn
# crop=w:h:x:y  Schneidet das Video zu
# scale=w:h     Skaliert das Video
# flip          Spiegelt das Video sowohl horizontal als auch vertikal
