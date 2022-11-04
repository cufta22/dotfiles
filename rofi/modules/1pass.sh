
#!/bin/bash
set -e
set -o pipefail


# : "${PINENTRY_PROGRAM:=pinentry-rofi}"

login() {
  if command -v pinentry-rofi > /dev/null; then
    pinentry-rofi << EOS | grep -oP 'D \K.*' | op signin --account my > ~/.op/session
SETPROMPT Master Password:
GETPIN
EOS
  fi
  source ~/.op/session
}

print-account-list() {
  set +e
  op item list | jq -r '.[] | " - \(.overview.title) (\(.overview.ainfo)) [\(.uuid)]"'
  LOGGED_IN=${PIPESTATUS[0]}
  set -e

  if [ $LOGGED_IN -eq 127 ]; then
    echo "1password CLI tool 'op' not found"
    exit 2
  fi

  if [ ! $LOGGED_IN -eq 0 ]; then
    login
    print-account-list
  fi
}

open-account-url() {
  local url=$(op get item "$1" | jq -r '.overview.url')
  if [[ -n $url ]]; then
    xdg-open "$url" >/dev/null 2>/dev/null
  else
    exit 2
  fi
}

is-actual-url() {
  local url="$1"
  if [[ -n $url && "$url" != " " && "$url" != "http://" && "$url" != "https://" ]]; then
    return 0
  else
    return 1
  fi
}

show-account-options() {
  local id="$1"
  local entry=$(op get item "$id")

  echo ">> Copy password [$id]"
  echo ">> Copy username [$id]"

  if [[ -n $(echo $entry | jq -r '.details.sections[] | select(.fields != null) | .fields[] | select(.v != null) | select(.v | contains("otpauth://"))') ]]; then
    echo ">> Copy OTP [$id]"
  fi

  url=$(echo $entry | jq -r '.overview.url')
  if is-actual-url "$url"; then
    echo ">> Open $url [$id]"
    echo ">> Copy URL [$id]"
  fi

  echo ">> Copy ID [$id]"
}

is-entry-selected() {
  if [[ -n $@ ]]; then
    return 0
  else
    return 1
  fi
}

id-in-selection() {
  echo "$1" | grep -oE '\[[a-z0-9]+\]$' | tr -d '[]'
}

debug() {
  echo "$@" > /dev/stderr
}

if [[ ! -f ~/.op/session ]]; then
  login
fi
source ~/.op/session

echo -e "WTF test"

if is-entry-selected "$1"; then
  selected="$1"

  id="$(id-in-selection "$selected")"

  if [[ -n $id ]]; then
    case "$selected" in
      '>> Copy password'*)
        op get item "$id" | jq -j '.details.fields[] | select(.designation == "password") | .value' | xclip -selection c >/dev/null 2>/dev/null ;;
      '>> Copy username'*)
        op get item "$id" | jq -j '.details.fields[] | select(.designation == "username") | .value' | xclip -selection c >/dev/null 2>/dev/null ;;
      '>> Copy OTP'*)
        op get totp "$id" | xclip -selection c >/dev/null 2>/dev/null ;;
      '>> Copy URL'*)
        op get item "$id" | jq -j '.overview.url' | xclip -selection c >/dev/null 2>/dev/null ;;
      '>> Copy ID'*)
        op get item "$id" | jq -j '.uuid' | xclip -selection c > /dev/null 2>/dev/null ;;
      '>> Open'*)
        open-account-url "$id" ;;
      *)
        show-account-options "$id" ;;
    esac
  else
    echo "Could not detect the entry ID of \"${selection}\""
    exit 1
  fi
else
  print-account-list
fi