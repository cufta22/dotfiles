killall picom

file1="/tmp/.${UID}.${DISPLAY}.redshift-adjust"
file2="/tmp/.${UID}.${DISPLAY}.bedtime-adjust"

redshift -x

cat > ${file1}
cat > ${file2}