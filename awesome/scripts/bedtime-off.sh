
file="/tmp/.${UID}.${DISPLAY}.bedtime-adjust"
cat > ${file}

redshift -x
brightnessctl s 20%

killall picom
picom