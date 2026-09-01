#!/bin/bash -e
# AP Computer Science A — start a log entry for today.
# Nine lines. Read them; you will be able to follow all of them by October.

# Sync with GitHub. "|| true" means: if the network is down, keep going anyway
# instead of stopping. A script that refuses to work on a train is a script you
# stop using.
git pull --quiet 2>/dev/null || true

FILENAME="logs/$(date +'%Y-%m-%d').log.md"        # one file per day, sortable
touch "$FILENAME"                                 # create it if it isn't there

echo ""                                    >> "$FILENAME"
echo "# $(date +'%A, %B %e, %Y %I:%M %p')" >> "$FILENAME"   # timestamp header
echo ""                                    >> "$FILENAME"
echo "- [ ] "                              >> "$FILENAME"   # first task

# Open it in VS Code. The `nano` branch is a safety net for the one machine where
# the `code` command did not get installed — you should not need it. No absolute
# paths here on purpose: they break the moment an app moves.
if command -v code > /dev/null; then
  code "$FILENAME"
elif command -v nano > /dev/null; then
  nano "$FILENAME"
else
  echo "Wrote $FILENAME. Open it in your editor."
fi
