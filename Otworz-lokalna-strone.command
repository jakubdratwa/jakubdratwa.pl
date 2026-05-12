#!/bin/bash
# Uruchamia prosty serwer i otwiera stronę w przeglądarce.
# NIE zamykaj tego okna, dopóki oglądasz stronę. Zamknięcie = koniec serwera.

set -e
cd "$(dirname "$0")" || exit 1

PORT=3333
URL="http://127.0.0.1:${PORT}/"

# Jeśli ten port już ktoś użył — tylko otwórz przeglądarkę
if lsof -Pi :"${PORT}" -sTCP:LISTEN -t >/dev/null 2>&1; then
  open "${URL}"
  echo "Port ${PORT} już nasłuchuje. Otworzyłem ${URL} w przeglądarce."
  echo "Naciśnij Enter, aby zamknąć to okno."
  read -r
  exit 0
fi

echo "Startuję serwer strony na ${URL}"
echo "— nie zamykaj tego okna, póki strona ma być widoczna w przeglądarce —"
echo ""

python3 -m http.server "${PORT}" &
SERVER_PID=$!
sleep 0.6
open "${URL}" || true

echo "Gdy skończysz, naciśnij Enter, żeby wyłączyć serwer i zamknąć to okno."
read -r
kill "${SERVER_PID}" 2>/dev/null || true
echo "Serwer zatrzymany."
