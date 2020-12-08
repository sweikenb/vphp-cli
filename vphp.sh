#!/usr/bin/env bash
set -euo pipefail

#
# 0. Init vars and define helper functions
#
PHP_BIN="php"
STOPFILENAME="vphp-cli"
VPHP_DEBUG="${VPHP_DEBUG:-}"

trim() {
  local var="$*"
  # remove leading whitespace characters
  var="${var#"${var%%[![:space:]]*}"}"
  # remove trailing whitespace characters
  var="${var%"${var##*[![:space:]]}"}"
  printf '%s' "$var"
}

# Start with the current working directory
WORKINGDIR="$(pwd)"
if [[ "/" != "$WORKINGDIR" ]]; then
  WORKINGDIR="$WORKINGDIR/"
fi
LOOKUPFILE="$WORKINGDIR.$STOPFILENAME"

#
# 1. Try to find the lookup-file / stopfile where we can find
#    the binary path for the PHP version to use.
#
until [[ -f "$LOOKUPFILE" ]]; do
  # Debug
  if [[ -n "$VPHP_DEBUG" ]]; then
    echo "WORKINGDIR: $WORKINGDIR"
  fi

  # Filesystem root special handling
  if [[ "/" == "$WORKINGDIR" ]]; then
    LOOKUPFILE=""
    break
  fi

  # Find the next parent dir
  WORKINGDIR=$(cd "$WORKINGDIR/.." && pwd)
  if [[ "/" != "$WORKINGDIR" ]]; then
    WORKINGDIR="$WORKINGDIR/"
  fi

  # Update lookup file
  LOOKUPFILE="$WORKINGDIR.$STOPFILENAME"

  # Debug
  if [[ -n "$VPHP_DEBUG" ]]; then
    echo "LOOKUPFILE: $LOOKUPFILE"
  fi
done

#
# 2. If we found a lookup file, use the defined path for the PHP binary.
#
PHP_PATH=""
if [[ -n "$LOOKUPFILE" ]]; then
  PHP_PATH=$(trim "$(cat "$LOOKUPFILE")")
  if [[ -n "$PHP_PATH" ]] && [[ -x "$PHP_PATH" ]]; then
    PHP_BIN="$PHP_PATH"
  fi
fi

# Debug
if [[ -n "$VPHP_DEBUG" ]]; then
  echo "LOOKUPFILE: $LOOKUPFILE"
  echo "PHP_PATH: $PHP_PATH"
  echo "PHP_BIN: $PHP_BIN"
fi

#
# 3. Pass the arguemtns to the PHP binary if we not in debug mode
#
if [[ -n "$VPHP_DEBUG" ]]; then
  "$PHP_BIN" "-v"
else
  "$PHP_BIN" "$@"
fi
