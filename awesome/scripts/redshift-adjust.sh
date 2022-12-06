set -e

file="/tmp/.${UID}.${DISPLAY}.redshift-adjust"

if [ ! $# = 1 ] || [ "${1}" = "-h" ] || [ "${1}" = "--help" ]; then
    cat <<EOF
$0 =TEMP    Set colour temperature to TEMP K
$0 +TEMP    Increase colour temperature by TEMP K
$0 -TEMP    Decrease colour temperature by TEMP K
$0 -p       Print the current temperature
EOF
    if [ $# = 1 ]; then
	exit 0
    fi
    exit 1
fi

if [ ! -e "${file}" ]; then
    echo 6500 > "${file}"
fi

if [ "${1}" = "-p" ] || [ "${1}" = "--print" ]; then
    cat "${file}"
    exit 0
fi


if [ "${1::1}" = "=" ]; then
    temperature="${1:1}"
else
    temperature=$(( $(cat "${file}") ${1::1} ${1:1} ))
fi


redshift -P -O $temperature && echo $temperature > "${file}"