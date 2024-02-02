#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi

OLD_CONTENT=""
touch /tmp/kblightd

echo "kblightd started..."
echo "Waiting for updates to /tmp/kblightd"

# yes, this is bad code but who cares (it works)s

while true; do
    NEW_CONTENT="$(cat /tmp/kblightd)"

    if [[ "$NEW_CONTENT" != "$OLD_CONTENT" ]]; then
        if [[ "$NEW_CONTENT" =~ "effect" ]]; then
            OLD_CONTENT="$NEW_CONTENT"
            if [[ "$NEW_CONTENT" =~ "effect strobe" ]]; then
                echo "Strobe effect detected"
                while true; do
                    if ! kblight set 0 >/dev/null; then
                        echo "An error occured while trying to apply effect: strobe."
                        exit 1
                    fi

                    sleep 0.04
                    kblight set 100 >/dev/null
                    sleep 0.04
                    
                    NEW_CONTENT="$(cat /tmp/kblightd)"
                    if [[ "$NEW_CONTENT" != "$OLD_CONTENT" ]]; then
                        break
                    fi
                done
            elif [[ "$NEW_CONTENT" =~ "effect breathe" ]]; then
                echo "Breathe effect detected"
                while true; do
                    for i in $(seq 0 1 100); do
                        if ! kblight set "$i" >/dev/null; then
                            echo "An error occured while trying to apply effect: breathe."
                            exit 1
                        fi
                        
                        NEW_CONTENT="$(cat /tmp/kblightd)"
                        if [[ "$NEW_CONTENT" != "$OLD_CONTENT" ]]; then
                            break
                        fi
                        sleep 0.013
                    done
                    NEW_CONTENT="$(cat /tmp/kblightd)"
                    if [[ "$NEW_CONTENT" != "$OLD_CONTENT" ]]; then
                        break
                    fi
                    for i in $(seq 100 -1 0); do
                        kblight set "$i" >/dev/null
                        sleep 0.013
                    done
                    sleep 1

                done
            else
                echo "Other effect detected"
            fi
        fi
    fi
done
