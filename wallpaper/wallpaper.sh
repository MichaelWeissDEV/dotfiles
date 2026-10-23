#!/usr/bin/env bash
# ============================================================================
# wallpaper.sh - Wallpaper-Switcher für Hyprland (hyprpaper)
# ============================================================================
# - Default-Wallpaper für alle Bildschirme
# - Pro-Monitor-Overrides (z. B. für Zweit-/Drittschirme)
# - Wallpaper-Ordner werden automatisch eingelesen (neue Bilder einfach ablegen)
# - Fuzzel-TUI bei Aufruf ohne Argumente, vollständige CLI mit Parametern
#
# Beispiele:
#   wallpaper                                  TUI öffnen
#   wallpaper list                             verfügbare Wallpapers anzeigen
#   wallpaper set forest.png                   Default setzen (alle ohne Override)
#   wallpaper set ocean.png --monitor eDP-1    Override für einen Monitor
#   wallpaper set city.png --all               überall setzen + Overrides löschen
#   wallpaper default forest.png               nur den Default setzen
#   wallpaper monitor DP-1 ocean.png           Monitor-Override setzen
#   wallpaper monitor DP-1 default             Override entfernen
#   wallpaper next | prev | random             durchwechseln
#   wallpaper current                          aktuelle Belegung anzeigen
#   wallpaper dirs                             Wallpaper-Ordner anzeigen
#   wallpaper add ~/Downloads/bild.jpg --set   Bild in die Bibliothek übernehmen
# ============================================================================
set -euo pipefail

# Symlink-Kette auflösen: ~/.local/bin/wallpaper -> ~/.config/wallpaper/wallpaper.sh
# -> ~/git/dotfiles/wallpaper/wallpaper.sh
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
DOTFILES_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
CONFIG_FILE="${WALLPAPER_CONFIG:-$CONFIG_HOME/wallpaper/wallpaper.conf}"
STATE_DIR="$STATE_HOME/wallpaper"
STATE_FILE="$STATE_DIR/state"

# Direkt aus dem Repository gestartet? Dann die Repo-Konfiguration verwenden.
if [[ ! -r "$CONFIG_FILE" && -r "$SCRIPT_DIR/wallpaper.conf" ]]; then
    CONFIG_FILE="$SCRIPT_DIR/wallpaper.conf"
fi

QUIET=0

# ----------------------------------------------------------------------------
# Ausgaben
# ----------------------------------------------------------------------------
if [[ -t 1 ]]; then
    BLUE='\033[1;34m'
    GREEN='\033[1;32m'
    YELLOW='\033[1;33m'
    RED='\033[1;31m'
    RESET='\033[0m'
else
    BLUE='' GREEN='' YELLOW='' RED='' RESET=''
fi

info()  { (( QUIET )) || printf "${BLUE}[INFO]${RESET}  %s\n" "$*"; }
ok()    { (( QUIET )) || printf "${GREEN}[OK]${RESET}    %s\n" "$*"; }
warn()  { (( QUIET )) || printf "${YELLOW}[WARN]${RESET}  %s\n" "$*"; }
error() { printf "${RED}[ERROR]${RESET} %s\n" "$*" >&2; }
die()   { error "$*"; exit 1; }

notify() {
    case "${WALLPAPER_NOTIFY:-1}" in
        0|false|no|off) return 0 ;;
    esac
    command -v hyprctl >/dev/null 2>&1 || return 0
    hyprctl notify -1 2200 "rgb(89b4fa)" "$*" >/dev/null 2>&1 || true
}

# ----------------------------------------------------------------------------
# Konfiguration & Status
# ----------------------------------------------------------------------------
load_config() {
    WALLPAPER_DIRS=()
    WALLPAPER_FIT="cover"
    WALLPAPER_NOTIFY=1

    if [[ -r "$CONFIG_FILE" ]]; then
        # shellcheck source=/dev/null
        source "$CONFIG_FILE"
    fi

    if (( ${#WALLPAPER_DIRS[@]} == 0 )); then
        WALLPAPER_DIRS=("$DOTFILES_ROOT/pictures")
    fi

    case "$WALLPAPER_FIT" in
        contain|cover|tile|fill) ;;
        *)
            warn "Ungültiger WALLPAPER_FIT '$WALLPAPER_FIT' – verwende 'cover'."
            WALLPAPER_FIT="cover"
            ;;
    esac
}

state_init() {
    mkdir -p "$STATE_DIR"
    [[ -f "$STATE_FILE" ]] || : > "$STATE_FILE"
}

state_default_get() {
    state_init
    awk -F '\t' '$1 == "default" { print $2; exit }' "$STATE_FILE"
}

state_monitor_get() {
    state_init
    awk -F '\t' -v m="$1" '$1 == "monitor" && $2 == m { print $3; exit }' "$STATE_FILE"
}

state_set_default() {
    state_init
    local value="$1" tmp
    tmp="$(mktemp "$STATE_DIR/.state.XXXXXX")"
    awk -F '\t' -v OFS='\t' -v val="$value" '
        $1 != "default" { print }
        END { print "default", val }
    ' "$STATE_FILE" > "$tmp"
    mv "$tmp" "$STATE_FILE"
}

state_set_monitor() {
    state_init
    local monitor="$1" value="$2" tmp
    tmp="$(mktemp "$STATE_DIR/.state.XXXXXX")"
    awk -F '\t' -v OFS='\t' -v mon="$monitor" -v val="$value" '
        !($1 == "monitor" && $2 == mon) { print }
        END { print "monitor", mon, val }
    ' "$STATE_FILE" > "$tmp"
    mv "$tmp" "$STATE_FILE"
}

state_clear_monitor() {
    state_init
    local monitor="$1" tmp
    tmp="$(mktemp "$STATE_DIR/.state.XXXXXX")"
    awk -F '\t' -v mon="$monitor" '!($1 == "monitor" && $2 == mon)' "$STATE_FILE" > "$tmp"
    mv "$tmp" "$STATE_FILE"
}

state_clear_monitors() {
    state_init
    local tmp
    tmp="$(mktemp "$STATE_DIR/.state.XXXXXX")"
    awk -F '\t' '$1 != "monitor"' "$STATE_FILE" > "$tmp"
    mv "$tmp" "$STATE_FILE"
}

# ----------------------------------------------------------------------------
# Wallpaper-Bibliothek
# ----------------------------------------------------------------------------
list_wallpapers() {
    local entry f root rel abs id parent
    local -A seen_abs=()
    local -A seen_id=()

    for entry in "${WALLPAPER_DIRS[@]}"; do
        entry="${entry/#\~/$HOME}"
        local -a matches=()

        if [[ -d "$entry" ]]; then
            root="$(readlink -f -- "$entry" 2>/dev/null || printf '%s' "$entry")"
            while IFS= read -r -d '' f; do
                matches+=("$f")
            done < <(find "$root" \( -type f -o -type l \) \( \
                -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o \
                -iname '*.webp' -o -iname '*.gif' -o -iname '*.bmp' -o \
                -iname '*.avif' -o -iname '*.jxl' -o -iname '*.tif' -o \
                -iname '*.tiff' \) -print0 2>/dev/null)
        elif [[ -f "$entry" ]]; then
            matches=("$entry")
            root=""
        else
            # Dateimuster wie /usr/share/hypr/wall*.png unterstützen
            while IFS= read -r f; do
                [[ -f "$f" ]] && matches+=("$f")
            done < <(compgen -G "$entry" || true)
            root=""
        fi

        for f in "${matches[@]}"; do
            abs="$(readlink -f -- "$f" 2>/dev/null)" || continue
            [[ -f "$abs" ]] || continue
            [[ -n "${seen_abs[$abs]:-}" ]] && continue
            seen_abs[$abs]=1

            if [[ -n "$root" && "$abs" == "$root"/* ]]; then
                rel="${abs#"$root"/}"
            else
                rel="$(basename -- "$abs")"
            fi

            # Doppelte Anzeigenamen eindeutig machen
            id="$rel"
            if [[ -n "${seen_id[$id]:-}" ]]; then
                parent="$(basename -- "$(dirname -- "$abs")")"
                id="$parent/$rel"
                [[ -n "${seen_id[$id]:-}" ]] && id="$abs"
            fi

            # Tabs/Zeilenumbrüche würden das Zustandsformat zerstören
            [[ "$id" == *$'\t'* || "$id" == *$'\n'* ]] && continue
            seen_id[$id]=1

            printf '%s\t%s\n' "$id" "$abs"
        done
    done | LC_ALL=C sort -t $'\t' -k1,1
}

first_wallpaper_id() {
    list_wallpapers | awk -F '\t' 'NR == 1 { print $1; exit }'
}

resolve_wallpaper() {
    local query="${1-}"
    [[ -n "$query" ]] || return 1

    local expanded="${query/#\~/$HOME}"
    if [[ -f "$expanded" ]]; then
        readlink -f -- "$expanded"
        return 0
    fi

    local -a exact=() base=() substr=()
    local id abs b

    while IFS=$'\t' read -r id abs; do
        [[ -z "$id" ]] && continue

        if [[ "$id" == "$query" ]]; then
            exact+=("$abs")
            continue
        fi

        b="$(basename -- "$id")"
        [[ "$b" == "$query" ]] && base+=("$abs")
        [[ "${id,,}" == *"${query,,}"* ]] && substr+=("$abs")
    done < <(list_wallpapers)

    if (( ${#exact[@]} == 1 )); then
        printf '%s\n' "${exact[0]}"
        return 0
    fi

    if (( ${#base[@]} == 1 )); then
        printf '%s\n' "${base[0]}"
        return 0
    fi

    if (( ${#base[@]} > 1 )); then
        error "Mehrere Wallpapers heißen '$query':"
        printf '  %s\n' "${base[@]}" >&2
        return 2
    fi

    if (( ${#substr[@]} == 1 )); then
        printf '%s\n' "${substr[0]}"
        return 0
    fi

    if (( ${#substr[@]} > 1 )); then
        error "Mehrdeutige Suche '$query'. Bitte präzisieren:"
        printf '  %s\n' "${substr[@]}" >&2
        return 2
    fi

    error "Wallpaper '$query' nicht gefunden."
    return 1
}

id_for_path() {
    local target id abs
    target="$(readlink -f -- "$1" 2>/dev/null || printf '%s' "$1")"

    while IFS=$'\t' read -r id abs; do
        if [[ "$abs" == "$target" ]]; then
            printf '%s\n' "$id"
            return 0
        fi
    done < <(list_wallpapers)

    printf '%s\n' "$target"
}

ensure_default() {
    local id
    id="$(state_default_get)"

    if [[ -n "$id" ]] && resolve_wallpaper "$id" >/dev/null 2>&1; then
        printf '%s\n' "$id"
        return 0
    fi

    if [[ -n "$id" ]]; then
        warn "Default-Wallpaper '$id' wurde nicht gefunden – wähle das erste verfügbare."
    fi

    id="$(first_wallpaper_id)"
    if [[ -z "$id" ]]; then
        die "Keine Wallpapers gefunden. Lege Bilder in einem dieser Ordner ab: ${WALLPAPER_DIRS[*]}"
    fi

    state_set_default "$id"
    printf '%s\n' "$id"
}

# ----------------------------------------------------------------------------
# Hyprpaper / Monitore
# ----------------------------------------------------------------------------
get_monitors() {
    command -v hyprctl >/dev/null 2>&1 || die "hyprctl nicht gefunden – läuft Hyprland?"
    hyprctl monitors -j 2>/dev/null | jq -r '.[].name' \
        || die "Monitore konnten nicht über hyprctl ermittelt werden."
}

monitor_exists() {
    local monitor="$1"
    get_monitors | grep -Fxq -- "$monitor"
}

ensure_daemon() {
    command -v hyprpaper >/dev/null 2>&1 \
        || die "hyprpaper ist nicht installiert. Installiere es mit: sudo pacman -S hyprpaper"

    if pgrep -x hyprpaper >/dev/null 2>&1; then
        # Läuft bereits und antwortet die IPC? Sonst z. B. nach einem
        # Hyprland-Neustart verwaist -> neu starten.
        hyprctl hyprpaper listactive >/dev/null 2>&1 && return 0
        warn "hyprpaper läuft, aber die IPC antwortet nicht – starte neu."
        pkill -x hyprpaper >/dev/null 2>&1 || true
        sleep 0.2
    fi

    info "Starte hyprpaper..."
    setsid hyprpaper >/dev/null 2>&1 < /dev/null &
    disown 2>/dev/null || true

    local i
    for i in {1..30}; do
        if hyprctl hyprpaper listactive >/dev/null 2>&1; then
            return 0
        fi
        sleep 0.1
    done

    die "hyprpaper konnte nicht gestartet werden (IPC nicht erreichbar)."
}

hyprpaper_set() {
    local monitor="$1" path="$2"
    hyprctl hyprpaper wallpaper "${monitor},${path},${WALLPAPER_FIT}" >/dev/null
}

apply_monitor() {
    local monitor="$1" default_id="$2"
    local id abs

    id="$(state_monitor_get "$monitor")"
    [[ -z "$id" ]] && id="$default_id"

    if ! abs="$(resolve_wallpaper "$id" 2>/dev/null)"; then
        warn "Wallpaper '$id' für $monitor nicht gefunden – verwende Default '$default_id'."
        abs="$(resolve_wallpaper "$default_id" 2>/dev/null)" \
            || die "Auch das Default-Wallpaper '$default_id' ist nicht mehr verfügbar."
    fi

    if ! hyprpaper_set "$monitor" "$abs"; then
        warn "Konnte das Wallpaper für $monitor nicht setzen (Monitor noch nicht bereit?)."
        return 0
    fi
    ok "$monitor: $(basename -- "$abs")"
}

apply_all() {
    local default_id default_abs
    default_id="$(ensure_default)"
    default_abs="$(resolve_wallpaper "$default_id" 2>/dev/null)" \
        || die "Default-Wallpaper '$default_id' ist nicht mehr verfügbar."

    ensure_daemon

    # Fallback für neu angeschlossene Monitore (hyprpaper nutzt ihn nur,
    # solange für den Monitor noch kein eigener Eintrag gesetzt wurde)
    hyprpaper_set "" "$default_abs" || true

    local -a monitors=()
    mapfile -t monitors < <(get_monitors)
    (( ${#monitors[@]} > 0 )) || die "Keine Monitore gefunden."

    local m
    for m in "${monitors[@]}"; do
        apply_monitor "$m" "$default_id"
    done
}

apply_monitor_only() {
    local monitor="$1"
    monitor_exists "$monitor" || die "Monitor '$monitor' nicht gefunden. Verfügbar: $(get_monitors | paste -sd ', ' -)"

    ensure_daemon
    local default_id
    default_id="$(ensure_default)"
    apply_monitor "$monitor" "$default_id"
}

# ----------------------------------------------------------------------------
# Aktionen
# ----------------------------------------------------------------------------
apply_choice() {
    local query="$1" target="$2"
    local abs id

    if [[ "$query" == "__reset__" ]]; then
        [[ "$target" == "__all__" || "$target" == "all" || "$target" == "__default__" ]] \
            && die "Für dieses Ziel gibt es keinen Monitor-Override zum Entfernen."
        monitor_exists "$target" || die "Monitor '$target' nicht gefunden."
        state_clear_monitor "$target"
        apply_monitor_only "$target"
        notify "$target: Default"
        return 0
    fi

    abs="$(resolve_wallpaper "$query")" || exit 1
    id="$(id_for_path "$abs")"

    case "$target" in
        __all__|all)
            state_set_default "$id"
            state_clear_monitors
            apply_all
            notify "Wallpaper überall: $(basename -- "$abs")"
            ;;
        __default__|default)
            state_set_default "$id"
            apply_all
            notify "Default-Wallpaper: $(basename -- "$abs")"
            ;;
        *)
            monitor_exists "$target" || die "Monitor '$target' nicht gefunden. Verfügbar: $(get_monitors | paste -sd ', ' -)"
            state_set_monitor "$target" "$id"
            apply_monitor_only "$target"
            notify "$target: $(basename -- "$abs")"
            ;;
    esac
}

cmd_set() {
    local target="default" query=""

    while (( $# > 0 )); do
        case "$1" in
            --monitor|-m)
                [[ $# -ge 2 ]] || die "Option $1 benötigt einen Monitor-Namen."
                target="$2"
                shift 2
                ;;
            --all|-a)
                target="all"
                shift
                ;;
            --)
                shift
                query="${1-}"
                shift || true
                ;;
            -*)
                die "Unbekannte Option: $1"
                ;;
            *)
                [[ -z "$query" ]] || die "Es wurde mehr als ein Wallpaper angegeben."
                query="$1"
                shift
                ;;
        esac
    done

    [[ -n "$query" ]] || die "Verwendung: wallpaper set <name|pfad> [--monitor MON | --all]"
    apply_choice "$query" "$target"
}

cmd_default() {
    if (( $# == 0 )); then
        local id abs
        id="$(ensure_default)"
        abs="$(resolve_wallpaper "$id" 2>/dev/null || true)"
        printf 'Default: %s\n' "$id"
        printf 'Pfad:    %s\n' "${abs:-nicht gefunden}"
        return 0
    fi

    [[ $# == 1 ]] || die "Verwendung: wallpaper default [<name|pfad>]"
    apply_choice "$1" "default"
}

cmd_monitor() {
    local monitor="${1-}" query="${2-}"

    [[ -n "$monitor" ]] || die "Verwendung: wallpaper monitor <MON> [<name|pfad>|default]"
    monitor_exists "$monitor" || die "Monitor '$monitor' nicht gefunden. Verfügbar: $(get_monitors | paste -sd ', ' -)"

    if [[ -z "$query" ]]; then
        local default_id override effective
        default_id="$(ensure_default)"
        override="$(state_monitor_get "$monitor")"
        effective="${override:-$default_id}"
        printf 'Monitor:  %s\n' "$monitor"
        printf 'Eigenes:  %s\n' "${override:-– (nutzt Default)}"
        printf 'Effektiv: %s\n' "$effective"
        return 0
    fi

    case "$query" in
        default|clear|-)
            state_clear_monitor "$monitor"
            apply_monitor_only "$monitor"
            notify "$monitor: Default"
            ;;
        *)
            apply_choice "$query" "$monitor"
            ;;
    esac
}

cmd_clear() {
    local target="${1-}"

    [[ -n "$target" ]] || die "Verwendung: wallpaper clear <MON> | --all"

    if [[ "$target" == "--all" || "$target" == "all" ]]; then
        state_clear_monitors
        apply_all
        notify "Monitor-Overrides entfernt"
        return 0
    fi

    monitor_exists "$target" || die "Monitor '$target' nicht gefunden."
    state_clear_monitor "$target"
    apply_monitor_only "$target"
    notify "$target: Default"
}

cmd_apply() {
    local only=""

    while (( $# > 0 )); do
        case "$1" in
            --quiet|-q)
                QUIET=1
                shift
                ;;
            --monitor|-m)
                [[ $# -ge 2 ]] || die "Option $1 benötigt einen Monitor-Namen."
                only="$2"
                shift 2
                ;;
            *)
                die "Unbekannte Option: $1"
                ;;
        esac
    done

    if [[ -n "$only" ]]; then
        apply_monitor_only "$only"
    else
        apply_all
    fi
}

cmd_current() {
    local default_id active_map m override effective active source
    default_id="$(ensure_default)"
    active_map="$(hyprctl hyprpaper listactive 2>/dev/null || true)"

    printf 'Default: %s\n\n' "$default_id"
    printf '%-14s %-9s %s\n' "MONITOR" "QUELLE" "AKTIV"
    printf '%-14s %-9s %s\n' "-------" "------" "-----"

    while IFS= read -r m; do
        override="$(state_monitor_get "$m")"
        effective="${override:-$default_id}"
        source="Default"
        [[ -n "$override" ]] && source="Eigenes"

        active="$(awk -v mon="$m" '
            index($0, mon ": ") == 1 { print substr($0, length(mon) + 3); exit }
        ' <<< "$active_map")"

        printf '%-14s %-9s %s\n' "$m" "$source" "${active:-– (hyprpaper nicht aktiv)}"
        [[ -n "$active" ]] || printf '%-14s %-9s %s\n' "" "" "gespeichert: $effective"
    done < <(get_monitors)
}

cmd_list() {
    local monitor="" plain=0

    while (( $# > 0 )); do
        case "$1" in
            --monitor|-m)
                [[ $# -ge 2 ]] || die "Option $1 benötigt einen Monitor-Namen."
                monitor="$2"
                shift 2
                ;;
            --plain|-p)
                plain=1
                shift
                ;;
            *)
                die "Unbekannte Option: $1"
                ;;
        esac
    done

    local default_id
    default_id="$(ensure_default)"
    if [[ -n "$monitor" ]]; then
        monitor_exists "$monitor" || die "Monitor '$monitor' nicht gefunden. Verfügbar: $(get_monitors | paste -sd ', ' -)"
    fi

    state_init
    local -A overrides=()
    local kind mon val
    while IFS=$'\t' read -r kind mon val; do
        [[ "$kind" == "monitor" ]] || continue
        [[ -n "$monitor" && "$mon" != "$monitor" ]] && continue
        if [[ -n "${overrides[$val]:-}" ]]; then
            overrides[$val]+=", $mon"
        else
            overrides[$val]="$mon"
        fi
    done < "$STATE_FILE"

    local id abs found=0 marks
    while IFS=$'\t' read -r id abs; do
        found=1
        if (( plain )); then
            printf '%s\n' "$id"
            continue
        fi

        marks=""
        [[ "$id" == "$default_id" ]] && marks+="★"
        [[ -n "${overrides[$id]:-}" ]] && marks+="●"
        [[ -z "$marks" ]] && marks=" "

        printf '%s %s' "$marks" "$id"
        if [[ -n "${overrides[$id]:-}" ]]; then
            printf '  (%s)' "${overrides[$id]}"
        fi
        printf '\n'
    done < <(list_wallpapers)

    if (( ! found )); then
        error "Keine Wallpapers gefunden. Durchsuchte Ordner: ${WALLPAPER_DIRS[*]}"
        return 1
    fi
}

current_id_for_target() {
    local target="$1" id
    case "$target" in
        __all__|all|default|__default__)
            ensure_default
            ;;
        *)
            id="$(state_monitor_get "$target")"
            [[ -n "$id" ]] || id="$(ensure_default)"
            printf '%s\n' "$id"
            ;;
    esac
}

cmd_cycle() {
    local direction="$1" target="default"
    shift

    while (( $# > 0 )); do
        case "$1" in
            --monitor|-m)
                [[ $# -ge 2 ]] || die "Option $1 benötigt einen Monitor-Namen."
                target="$2"
                shift 2
                ;;
            --all|-a)
                target="all"
                shift
                ;;
            *)
                die "Unbekannte Option: $1"
                ;;
        esac
    done

    local -a ids=()
    mapfile -t ids < <(list_wallpapers | cut -f1)
    (( ${#ids[@]} > 0 )) || die "Keine Wallpapers gefunden."

    local current idx=-1 i
    current="$(current_id_for_target "$target")"
    for i in "${!ids[@]}"; do
        if [[ "${ids[$i]}" == "$current" ]]; then
            idx="$i"
            break
        fi
    done

    if (( idx < 0 )); then
        idx=0
    elif [[ "$direction" == "next" ]]; then
        idx=$(( (idx + 1) % ${#ids[@]} ))
    else
        idx=$(( (idx - 1 + ${#ids[@]}) % ${#ids[@]} ))
    fi

    apply_choice "${ids[$idx]}" "$target"
}

cmd_random() {
    local target="default"

    while (( $# > 0 )); do
        case "$1" in
            --monitor|-m)
                [[ $# -ge 2 ]] || die "Option $1 benötigt einen Monitor-Namen."
                target="$2"
                shift 2
                ;;
            --all|-a)
                target="all"
                shift
                ;;
            *)
                die "Unbekannte Option: $1"
                ;;
        esac
    done

    local -a ids=()
    mapfile -t ids < <(list_wallpapers | cut -f1)
    (( ${#ids[@]} > 0 )) || die "Keine Wallpapers gefunden."

    local idx=$(( RANDOM % ${#ids[@]} ))
    apply_choice "${ids[$idx]}" "$target"
}

cmd_dirs() {
    printf 'Konfiguration: %s\n' "$CONFIG_FILE"
    printf 'Status:        %s\n' "$STATE_FILE"
    printf 'Fit-Modus:     %s\n\n' "$WALLPAPER_FIT"
    printf 'Wallpaper-Quellen:\n'

    local entry
    for entry in "${WALLPAPER_DIRS[@]}"; do
        entry="${entry/#\~/$HOME}"
        if [[ -d "$entry" ]]; then
            printf '  ✓ %s\n' "$entry"
        elif compgen -G "$entry" >/dev/null 2>&1; then
            printf '  ✓ %s (Dateimuster)\n' "$entry"
        else
            printf '  ✗ %s (fehlt)\n' "$entry"
        fi
    done
}

cmd_add() {
    local move=0 set_after=0
    local -a files=()

    while (( $# > 0 )); do
        case "$1" in
            --move|-m)
                move=1
                shift
                ;;
            --set|-s)
                set_after=1
                shift
                ;;
            -*)
                die "Unbekannte Option: $1"
                ;;
            *)
                files+=("$1")
                shift
                ;;
        esac
    done

    (( ${#files[@]} > 0 )) || die "Verwendung: wallpaper add <datei>... [--move] [--set]"

    local default_dir="$DOTFILES_ROOT/pictures"
    local dest="${WALLPAPER_DIRS[0]:-$default_dir}"
    dest="${dest/#\~/$HOME}"
    if [[ -f "$dest" || "$dest" == *'*'* || "$dest" == *'?'* || "$dest" == *'['* ]]; then
        dest="$default_dir"
    fi
    mkdir -p "$dest"

    local f target name base ext i
    for f in "${files[@]}"; do
        [[ -f "$f" ]] || { warn "Überspringe '$f' (keine Datei)."; continue; }

        target="$dest/$(basename -- "$f")"
        if [[ -e "$target" ]]; then
            name="$(basename -- "$target")"
            if [[ "$name" == *.* && "$name" != .* ]]; then
                base="${target%.*}"
                ext=".${target##*.}"
            else
                base="$target"
                ext=""
            fi
            i=1
            while [[ -e "${base}-${i}${ext}" ]]; do
                i=$(( i + 1 ))
            done
            target="${base}-${i}${ext}"
        fi

        if (( move )); then
            mv -- "$f" "$target"
        else
            cp -- "$f" "$target"
        fi
        ok "Hinzugefügt: $target"

        if (( set_after )); then
            apply_choice "$target" "default"
        fi
    done
}

cmd_open() {
    local default_dir="$DOTFILES_ROOT/pictures"
    local dir="${WALLPAPER_DIRS[0]:-$default_dir}"
    dir="${dir/#\~/$HOME}"
    [[ -d "$dir" ]] || dir="$default_dir"
    mkdir -p "$dir"

    if command -v pcmanfm >/dev/null 2>&1; then
        setsid pcmanfm "$dir" >/dev/null 2>&1 &
    elif command -v xdg-open >/dev/null 2>&1; then
        setsid xdg-open "$dir" >/dev/null 2>&1 &
    else
        die "Kein Dateimanager gefunden (pcmanfm/xdg-open)."
    fi
}

cmd_reload() {
    info "Starte hyprpaper neu..."
    pkill -x hyprpaper >/dev/null 2>&1 || true
    sleep 0.3
    apply_all
}

cmd_doctor() {
    printf 'Wallpaper-Switcher\n'
    printf '  Konfiguration: %s\n' "$CONFIG_FILE"
    printf '  Status:        %s\n' "$STATE_FILE"
    printf '  Fit-Modus:     %s\n' "$WALLPAPER_FIT"
    printf '  Wallpapers:    %s\n' "$(list_wallpapers | wc -l)"
    printf '\nProgramme:\n'

    local c
    for c in hyprctl hyprpaper jq fuzzel; do
        if command -v "$c" >/dev/null 2>&1; then
            printf '  ✓ %-10s %s\n' "$c" "$(command -v "$c")"
        else
            printf '  ✗ %-10s fehlt\n' "$c"
        fi
    done

    printf '\nLaufzeit:\n'
    if pgrep -x hyprpaper >/dev/null 2>&1; then
        printf '  ✓ hyprpaper läuft (PID %s)\n' "$(pgrep -x hyprpaper | paste -sd ',' -)"
    else
        printf '  ✗ hyprpaper läuft nicht\n'
    fi

    if command -v hyprctl >/dev/null 2>&1; then
        printf '\nMonitore:\n'
        get_monitors | sed 's/^/  - /' || true
    fi
}

# ----------------------------------------------------------------------------
# Fuzzel-TUI
# ----------------------------------------------------------------------------
choose_from_menu() {
    local prompt="$1" placeholder="$2" data="$3" width="$4" lines="$5"
    local display chosen

    display="$(printf '%s' "$data" | cut -f2-)"
    [[ -n "$display" ]] || return 1

    chosen="$(printf '%s\n' "$display" | fuzzel --dmenu \
        --prompt="$prompt" \
        --placeholder="$placeholder" \
        --width="$width" \
        --lines="$lines")" || return 1

    [[ -n "$chosen" ]] || return 1
    awk -F '\t' -v sel="$chosen" '$2 == sel { print $1; exit }' <<< "$data"
}

cmd_tui() {
    command -v fuzzel >/dev/null 2>&1 || die "fuzzel ist nicht installiert."
    [[ -n "${WAYLAND_DISPLAY:-}" || -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]] \
        || die "Die TUI benötigt eine laufende Hyprland-Session (oder nutze die CLI, z. B. 'wallpaper list')."

    # Wie Window-Switcher/Powermenu: bereits offenes Fuzzel zuerst schließen
    if pgrep -x fuzzel >/dev/null 2>&1; then
        pkill -x fuzzel
        exit 0
    fi

    local only_monitor=""
    while (( $# > 0 )); do
        case "$1" in
            --monitor|-m)
                [[ $# -ge 2 ]] || die "Option $1 benötigt einen Monitor-Namen."
                only_monitor="$2"
                shift 2
                ;;
            *)
                die "Unbekannte Option: $1"
                ;;
        esac
    done

    local default_id target data m override
    default_id="$(ensure_default)"

    if [[ -n "$only_monitor" ]]; then
        monitor_exists "$only_monitor" || die "Monitor '$only_monitor' nicht gefunden."
        target="$only_monitor"
    else
        data="__all__"$'\t'"󰍹  Alle Bildschirme (einheitlich)  ·  $default_id"$'\n'
        data+="__default__"$'\t'"★  Nur Default (Overrides behalten)  ·  $default_id"$'\n'
        while IFS= read -r m; do
            override="$(state_monitor_get "$m")"
            if [[ -n "$override" ]]; then
                data+="$m"$'\t'"󰍹  $m  ·  Eigenes: $override"$'\n'
            else
                data+="$m"$'\t'"󰍹  $m  ·  Default: $default_id"$'\n'
            fi
        done < <(get_monitors)

        target="$(choose_from_menu "Ziel wählen: " "Bildschirm oder alle..." "$data" 68 8)" || exit 0
        [[ -n "$target" ]] || exit 0
    fi

    local -a ids=()
    mapfile -t ids < <(list_wallpapers | cut -f1)
    (( ${#ids[@]} > 0 )) || die "Keine Wallpapers gefunden. Lege Bilder in ${WALLPAPER_DIRS[*]} ab."

    local current
    if [[ "$target" == "__all__" || "$target" == "all" || "$target" == "__default__" ]]; then
        current="$default_id"
    else
        current="$(state_monitor_get "$target")"
        [[ -n "$current" ]] || current="$default_id"
    fi

    data="__random__"$'\t'"󰒝  Zufällig"$'\n'
    if [[ "$target" != "__all__" && "$target" != "all" && "$target" != "__default__" ]]; then
        data+="__reset__"$'\t'"↺  Default verwenden"$'\n'
    fi
    local id marker
    for id in "${ids[@]}"; do
        marker="  "
        [[ "$id" == "$current" ]] && marker="★ "
        data+="$id"$'\t'"$marker$id"$'\n'
    done

    local lines=$(( ${#ids[@]} + 2 ))
    (( lines > 14 )) && lines=14
    local target_label="$target"
    [[ "$target" == "__all__" || "$target" == "all" ]] && target_label="alle Bildschirme"
    [[ "$target" == "__default__" ]] && target_label="Default"

    local choice
    choice="$(choose_from_menu "Wallpaper für $target_label: " "Wallpaper suchen..." "$data" 72 "$lines")" || exit 0
    [[ -n "$choice" ]] || exit 0

    if [[ "$choice" == "__random__" ]]; then
        local idx=$(( RANDOM % ${#ids[@]} ))
        choice="${ids[$idx]}"
    fi

    apply_choice "$choice" "$target"
}

# ----------------------------------------------------------------------------
# Hilfe
# ----------------------------------------------------------------------------
usage() {
    cat <<EOF
Wallpaper-Switcher für Hyprland (hyprpaper)

Verwendung: $(basename "$0") [BEFEHL] [OPTIONEN]

Ohne Befehl wird die Fuzzel-TUI geöffnet.

Befehle:
  tui [--monitor MON]        Interaktive Auswahl (Ziel + Wallpaper)
  list [--monitor MON]       Verfügbare Wallpapers anzeigen (★ Default, ● Override)
  set <name|pfad> [--monitor MON | --all]
                             Default setzen (ohne Ziel) bzw. Monitor-Override
  default [<name|pfad>]      Default anzeigen oder setzen
  monitor <MON> [<name|pfad>|default]
                             Monitor-Override setzen, anzeigen oder entfernen
  clear <MON> | --all        Override(s) entfernen (zurück zum Default)
  current                    Aktuelle Belegung pro Monitor anzeigen
  next | prev [--monitor MON | --all]
                             Nächstes/vorheriges Wallpaper
  random [--monitor MON | --all]
                             Zufälliges Wallpaper
  apply [--quiet] [--monitor MON]
                             Gespeicherte Belegung (erneut) anwenden
  reload                     hyprpaper neu starten und Belegung anwenden
  dirs                       Wallpaper-Ordner und Konfiguration anzeigen
  add <datei>... [--move] [--set]
                             Bilder in die Bibliothek kopieren/verschieben
  open                       Wallpaper-Ordner im Dateimanager öffnen
  doctor                     Installation, Monitore und Status prüfen
  help                       Diese Hilfe anzeigen

Wallpapers hinzufügen:
  Bilder in die private Bibliothek ~/git/dotfiles/pictures legen
  (Unterordner werden rekursiv gelesen). Das Verzeichnis ist per .gitignore
  aus dem öffentlichen Dotfiles-Repo ausgeschlossen (Urheberrecht).
  Einrichtung des privaten Repos: ~/git/dotfiles/scripts/install-wallpapers.sh <git-url>

Beispiele:
  wallpaper
  wallpaper set forest.png
  wallpaper set ocean.png --monitor eDP-1
  wallpaper set city.png --all
  wallpaper default forest.png
  wallpaper monitor DP-1 ocean.png
  wallpaper monitor DP-1 default
  wallpaper next
  wallpaper random --all
  wallpaper add ~/Downloads/bild.jpg --set

Dateien:
  Konfiguration: $CONFIG_FILE
  Status:        $STATE_FILE
EOF
}

# ----------------------------------------------------------------------------
# Hauptprogramm
# ----------------------------------------------------------------------------
main() {
    load_config

    local cmd="${1:-tui}"
    shift || true

    case "$cmd" in
        tui|menu)
            cmd_tui "$@"
            ;;
        list|ls)
            cmd_list "$@"
            ;;
        set)
            cmd_set "$@"
            ;;
        default|def)
            cmd_default "$@"
            ;;
        monitor|mon)
            cmd_monitor "$@"
            ;;
        clear|unset)
            cmd_clear "$@"
            ;;
        current|status)
            cmd_current "$@"
            ;;
        next)
            cmd_cycle next "$@"
            ;;
        prev|previous)
            cmd_cycle prev "$@"
            ;;
        random|rand)
            cmd_random "$@"
            ;;
        apply)
            cmd_apply "$@"
            ;;
        reload|restart)
            cmd_reload "$@"
            ;;
        dirs|dir)
            cmd_dirs "$@"
            ;;
        add)
            cmd_add "$@"
            ;;
        open)
            cmd_open "$@"
            ;;
        doctor|check)
            cmd_doctor "$@"
            ;;
        help|-h|--help)
            usage
            ;;
        *)
            error "Unbekannter Befehl: $cmd"
            usage
            exit 1
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi
