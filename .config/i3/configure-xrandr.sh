#!/run/current-system/sw/bin/bash -e

PRIMARY="LVDS1"
HDMI1="HDMI1"

if (xrandr | grep "$HDMI1 connected"); then
        xrandr --output $HDMI1 --primary --auto --left-of $PRIMARY
        echo "External screen set as primary"
fi
