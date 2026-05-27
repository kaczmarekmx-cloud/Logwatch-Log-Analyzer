#!/bin/bash

# ─────────────────────────────────────────
#  logwatch.sh — Log Analyzer
# ─────────────────────────────────────────

# KOLORY
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
RESET='\033[0m'

# DOMYŚLNY PLIK LOGÓW NA MACU
DEFAULT_LOG="/var/log/system.log"

# ─── FUNKCJE ──────────────────────────────

usage() {
    echo -e "${BOLD}Użycie:${RESET}"
    echo -e "  ./logwatch.sh                        — analiza domyślnego logu"
    echo -e "  ./logwatch.sh --file <plik>          — analiza konkretnego pliku"
    echo -e "  ./logwatch.sh --level <ERROR|WARN|INFO> — filtruj według poziomu"
    echo -e "  ./logwatch.sh --summary              — podsumowanie statystyk"
}

check_file() {
    local file=$1
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ Błąd: plik '$file' nie istnieje${RESET}"
        exit 1
    fi
}

show_summary() {
    local file=$1
    local total=$(wc -l < "$file")
    local errors=$(grep -ci "error" "$file" 2>/dev/null || echo 0)
    local warns=$(grep -ci "warn" "$file" 2>/dev/null || echo 0)
    local infos=$(grep -ci "info" "$file" 2>/dev/null || echo 0)

    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${BOLD}  📊 LOGWATCH — $(basename $file)${RESET}"
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  Łącznie linii: ${BOLD}${total}${RESET}"
    echo -e "  ${RED}ERROR:${RESET}  ${errors}"
    echo -e "  ${YELLOW}WARN:${RESET}   ${warns}"
    echo -e "  ${GREEN}INFO:${RESET}   ${infos}"
    echo ""
}

filter_level() {
    local file=$1
    local level=$2
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${BOLD}  🔍 Filtr: ${level} — $(basename $file)${RESET}"
    echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    grep -i "$level" "$file" | tail -20
    echo ""
}

# ─── MAIN ─────────────────────────────────

LOG_FILE=$DEFAULT_LOG
MODE="summary"
LEVEL=""
usage

while [ $# -gt 0 ]; do
    case "$1" in
        --file)
            LOG_FILE="$2"
            shift 2
            ;;
        --level)
            LEVEL="$2"
            MODE="filter"
            shift 2
            ;;
        --summary)
            MODE="summary"
            shift
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Nieznana flaga: $1${RESET}"
            usage
            exit 1
            ;;
    esac
done

check_file "$LOG_FILE"

if [ "$MODE" == "filter" ]; then
    filter_level "$LOG_FILE" "$LEVEL"
else
    show_summary "$LOG_FILE"
fi