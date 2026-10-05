#!/bin/bash -e
# AP Computer Science A — close out today's log entry.
# Run it in the last minutes of the period, or when you stop working at home.
# It carries your task list forward so you can check things off and
# scaffolds the reflection block.

# Work from the top of the repository no matter where you ran this from.
cd "$(dirname "$0")/.."

# Turn on the commit helper in .githooks/. When you run `git commit` it asks
# whether you are in class or out of class and writes the message for you.
git config core.hooksPath .githooks

FILENAME="logs/$(date +'%Y-%m-%d').log.md"

if [ ! -f "$FILENAME" ]; then
  echo "No sign-on entry for today. Run scripts/start-entry.sh first."
  exit 1
fi

# Pull the task list out of the most recent entry so you can check items off
# instead of retyping them. Empty checkboxes are dropped.
TASKS=$(awk '/^# /{buf=""} /^- \[/{ if ($0 !~ /^- \[ \] *$/) buf=buf $0 "\n"} END{printf "%s", buf}' "$FILENAME")
[ -z "$TASKS" ] && TASKS="- [ ] "

{
  echo ""
  echo "# $(date +'%A, %B %e, %Y %I:%M %p')"
  echo ""
  printf '%s\n' "$TASKS"
  echo ""
  echo "Signing off."
  echo ""
  echo "## Reflection"
  echo ""
  echo "**Q1.** "
  echo ""
  echo ""
  echo "**Q2.** "
  echo ""
  echo ""
  echo "**Q3.** "
  echo ""
  echo ""
  echo "**AI use:** none."
} >> "$FILENAME"

if command -v code > /dev/null; then
  code "$FILENAME"
elif command -v nano > /dev/null; then
  nano "$FILENAME"
else
  echo "Wrote $FILENAME. Open it in your editor."
fi

echo ""
echo "Check off what you finished, say in one honest word why anything is not"
echo "finished, answer all 3 questions, replace the AI line if you used it, then:"
echo "    git add logs && git commit && git push"
echo "git commit asks: in class or out of class? Answer i or o, then save and"
echo "close the tab."
