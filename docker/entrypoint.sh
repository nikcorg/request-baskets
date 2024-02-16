#!/bin/bash

if [[ -z "$LISTEN" ]]; then
    LISTEN="0.0.0.0"
fi

if [[ -z "$DB" ]]; then
    DB="bolt"
fi

if [[ -z "$FILE" ]]; then
    FILE="/var/lib/rbaskets/baskets.db"
fi

args=(
    -l "$LISTEN" -db "$DB" -file "$FILE"
)

if [[ -n "$CONN" ]]; then
    args+=(-conn "$CONN")
fi

if [[ -n "$PORT" ]]; then
    args+=(-p "$PORT")
fi

if [[ -n "$PAGE" ]]; then
    args+=(-page "$PAGE")
fi

if [[ -n "$SIZE" ]]; then
    args+=(-size "$SIZE")
fi

if [[ -n "$MAXSIZE" ]]; then
    args+=(-maxsize "$MAXSIZE")
fi

if [[ -n "$TOKEN" ]]; then
    args+=(-token "$TOKEN")
fi

if [[ -n "$BASKET" ]]; then
    while IFS="," read -ra baskets; do
        for basket in "${baskets[@]}"; do
            args+=(-basket "$basket")
        done
    done <<<"$BASKET"
fi

if [[ -n "$PATHPREFIX" ]]; then
    args+=(-prefix "$PATHPREFIX")
fi

if [[ -n "$MODE" ]]; then
    args+=(-mode "$MODE")
fi

if [[ -n "$THEME" ]]; then
    args+=(-theme "$THEME")
fi

set -- "/bin/rbaskets" "${args[@]}"
echo "Executing: $*"

"$@"
