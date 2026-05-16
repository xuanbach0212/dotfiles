#!/bin/bash

# ┏━━━┳━━┳━┓┏━┳━━━┳┓╋╋┏━━┳━┓┏━┓
# ┗┓┏┓┣┫┣┫┃┗┛┃┃┏━━┫┃╋╋┗┫┣┻┓┗┛┏┛
# ╋┃┃┃┃┃┃┃┏┓┏┓┃┗━━┫┃╋╋╋┃┃╋┗┓┏┛
# ╋┃┃┃┃┃┃┃┃┃┃┃┃┏━━┫┃╋┏┓┃┃╋┏┛┗┓
# ┏┛┗┛┣┫┣┫┃┃┃┃┃┃╋╋┃┗━┛┣┫┣┳┛┏┓┗┓
# ┗━━━┻━━┻┛┗┛┗┻┛╋╋┗━━━┻━━┻━┛┗━┛
# The program was created by DIMFLIX
# Github: https://github.com/DIMFLIX

FLAG_DIR="/tmp/battery_flags"
BATTERY_THRESHOLDS=(15 10 5 3)
CHARGING_ICONS=("󰢟 " "󰢜 " "󰂆 " "󰂇 " "󰂈 " "󰢝 " "󰂉 " "󰢞 " "󰂊 " "󰂋 " "󰂅 ")
SESSION_TYPE="$XDG_SESSION_TYPE"
DISCHARGED_COLOR=""
CHARGED_COLOR=""

# Создаем директорию для флагов, если её нет
mkdir -p "$FLAG_DIR"

get_battery_paths() {
    upower -e | grep 'BAT'
}

has_battery() {
    [ -z "$(get_battery_paths)" ] && return 1 || return 0
}

get_battery_charge() {
    local path="$1"
    upower -i "$path" | grep percentage | awk '{print $2}' | sed s/%//
}

is_charging() {
    local path="$1"
    upower -i "$path" | grep state | awk '{print $2}'
}

notify_battery_time() {
    local parts=()
    local idx=0
    local labels=("①" "②" "③" "④")
    while IFS= read -r path; do
        local label="${labels[$idx]}"
        idx=$((idx + 1))
        local charge=$(get_battery_charge "$path")
        local state=$(is_charging "$path")
        local remaining=$(upower -i "$path" | grep --color=never -E "time to empty|time to full" | awk '{print $4, $5}')

        local state_label=""
        case "$state" in
            charging)       state_label="Charging" ;;
            discharging)    state_label="Discharging" ;;
            fully-charged)  state_label="Full" ;;
            pending-charge) state_label="Pending charge" ;;
            *)              state_label="$state" ;;
        esac

        if [ -n "$remaining" ] && [[ "$remaining" != *"0"* ]]; then
            parts+=("$label ${charge}% — $state_label, $remaining left")
        else
            parts+=("$label ${charge}% — $state_label")
        fi
    done < <(get_battery_paths)
    notify-send "Battery" "$(printf '%s\n' "${parts[@]}")"
}

get_battery_icon() {
    local charge="$1"
    local charging_status="$2"
    local icon=""
    if [ "$charging_status" == "charging" ]; then
        icon="${CHARGING_ICONS[9]}"
    elif [ "$charging_status" == "fully-charged" ]; then
        icon="󰁹 "
    else
        case $charge in
            100|9[0-9]) icon="󰁹 " ;;
            8[0-9]) icon="󰂂 " ;;
            7[0-9]) icon="󰂁 " ;;
            6[0-9]) icon="󰂀 " ;;
            5[0-9]) icon="󰁿 " ;;
            4[0-9]) icon="󰁾 " ;;
            3[0-9]) icon="󰁽 " ;;
            2[0-9]) icon="󰁼 " ;;
            1[5-9]) icon="󰁺 " ;;
            *) icon="󰂎 " ;;
        esac
    fi
    echo "$icon"
}

print_status() {
    local icon_only=false
    for arg in "$@"; do
        [[ "$arg" == "--icon-only" ]] && icon_only=true
    done

    local parts=()
    while IFS= read -r path; do
        local charge=$(get_battery_charge "$path")
        local charging_status=$(is_charging "$path")
        local icon=$(get_battery_icon "$charge" "$charging_status")
        local color=""

        if [ "$charging_status" == "charging" ] || [ "$charging_status" == "fully-charged" ]; then
            color=$CHARGED_COLOR
        elif [ "$charge" -le "15" ]; then
            color=$DISCHARGED_COLOR
        else
            color=$CHARGED_COLOR
        fi

        local output=""
        if $icon_only; then
            output="${icon}"
        else
            output="${icon}${charge}%"
        fi

        if [[ -n "$color" ]]; then
            if [[ "$SESSION_TYPE" == "wayland" ]]; then
                parts+=("<span color=\"$color\">$output</span>")
            elif [[ "$SESSION_TYPE" == "x11" ]]; then
                parts+=("%{F$color}$output%{F-}")
            else
                parts+=("$output")
            fi
        else
            parts+=("$output")
        fi
    done < <(get_battery_paths)

    local IFS=' '
    echo "${parts[*]}"
}

check_battery_notifications() {
    local lock_file="$FLAG_DIR/.battery.lock"

    while IFS= read -r path; do
        local bat_name=$(basename "$path")
        local battery_charge=$(get_battery_charge "$path")
        local charging_status=$(is_charging "$path")

        if [ "$charging_status" == "charging" ]; then
            rm -f "$FLAG_DIR/${bat_name}_"*.flag 2>/dev/null
            continue
        fi

        for threshold in "${BATTERY_THRESHOLDS[@]}"; do
            local flag_file="$FLAG_DIR/${bat_name}_${threshold}.flag"

            if [ "$battery_charge" -le "$threshold" ]; then
                (
                    flock -n 200 || exit 1
                    if [ ! -f "$flag_file" ]; then
                        local urgency="critical"
                        local timeout=10000
                        if [ "$threshold" -eq 5 ]; then
                            timeout=0
                        fi
                        touch "$flag_file"
                        if [ "$threshold" -eq 3 ]; then
                            sh ${XDG_BIN_HOME:-$HOME/bin}/screen-lock.sh --suspend
                            exit 0
                        fi
                        notify-send "Low battery charge ($bat_name)" \
                            "The battery charge level is $battery_charge%, connect the charger." \
                            -u "$urgency" \
                            -t "$timeout"
                    fi
                ) 200>"$lock_file"
            else
                rm -f "$flag_file" 2>/dev/null
            fi
        done
    done < <(get_battery_paths)
}

main() {
    local status_mode=false
    local notify_mode=false
    local icon_only=false
    
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --status)
                status_mode=true
                shift
                ;;
            --notify)
                notify_mode=true
                shift
                ;;
            --charged-color)
                CHARGED_COLOR="$2"
                shift 2
                ;;
            --discharged-color)
                DISCHARGED_COLOR="$2"
                shift 2
                ;;
            --icon-only)
                icon_only=true
                shift
                ;;
            *)
                echo "Invalid option: $1"
                exit 1
                ;;
        esac
    done

    if [[ $status_mode == true ]]; then
        if $icon_only; then
            print_status --icon-only
        else
            print_status
        fi
    fi

    if [[ $notify_mode == true ]]; then
        notify_battery_time
    fi

    # Проверяем уведомления о низком заряде
    check_battery_notifications
}

if has_battery; then
    main "$@"
else
    status_mode=false
    icon_only=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --status)
                status_mode=true
                shift
                ;;
            --icon-only)
                icon_only=true
                shift
                ;;
            --charged-color)
                CHARGED_COLOR="$2"
                shift 2
                ;;
            --discharged-color)
                DISCHARGED_COLOR="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done

    if [[ $status_mode == true ]]; then
        output="󱟩"
        color="$DISCHARGED_COLOR"
        
        if ! $icon_only; then
            if [[ -n "$color" ]]; then
                case "$SESSION_TYPE" in
                    "wayland") echo "<span color='$color'>$output</span>" ;;
                    "x11")     echo "%{F$color}$output%{F-}" ;;
                    *)         echo "$output" ;;
                esac
            else
                echo "$output"
            fi
        else
            echo "$output"
        fi
    fi
fi
