set -e

file1="/tmp/.${UID}.${DISPLAY}.redshift-adjust"
file2="/tmp/.${UID}.${DISPLAY}.bedtime-adjust"

if [ "${1}" = "-p1" ] || [ "${1}" = "--print1" ]; then
    cat "${file1}"
    exit 0
fi

if [ "${1}" = "-p2" ] || [ "${1}" = "--print2" ]; then
    cat "${file2}"
    exit 0
fi

if [ "${1}" = "-s1" ]; then
    redshift -P -O "${2}" && echo "${2}" > "${file1}"
fi

if [ "${1}" = "-s2" ]; then
    killall picom

    redshift -P -O "${2}" && echo "${2}" > "${file2}"
    brightnessctl s 5%
    picom -b --config /dev/null --backend glx --glx-fshader-win  "uniform sampler2D tex; uniform float opacity; void main() { vec4 c = texture2D(tex, gl_TexCoord[0].xy); float y = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722)); gl_FragColor = opacity*vec4(y, y, y, c.a); }" &
fi