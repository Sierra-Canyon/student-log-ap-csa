#!/bin/bash -e
# Build a revision document out of everything you have written this year.
#
#   bash scripts/study-guide.sh              everything
#   bash scripts/study-guide.sh 2026-09      just September
#   bash scripts/study-guide.sh --shaky      only the things you marked Shaky
#
# Output: study-guide.md at the top of the repo. It is git-ignored, so it never
# clutters your commits — rebuild it whenever you want a fresh one.

FILTER="${1:-}"
OUT="study-guide.md"

{
  echo "# Study guide"
  echo
  echo "_Built $(date +'%A, %B %e, %Y %I:%M %p') from your own log._"
  echo
} > "$OUT"

if [ "$FILTER" = "--shaky" ]; then
  echo "## Everything you marked Shaky" >> "$OUT"
  echo >> "$OUT"
  for f in logs/*.log.md; do
    [ -e "$f" ] || continue
    d=$(basename "$f" .log.md)
    grep -h '^\*\*Shaky:\*\*' "$f" 2>/dev/null \
      | sed "s|^\*\*Shaky:\*\* *|- **$d** — |" \
      | grep -v -- '— *$' >> "$OUT" || true
  done
  echo >> "$OUT"
  echo "_Anything still on this list two days before a test is your study plan._" >> "$OUT"
else
  for f in logs/*.log.md; do
    [ -e "$f" ] || continue
    d=$(basename "$f" .log.md)
    case "$d" in ${FILTER}*) ;; *) [ -n "$FILTER" ] && continue ;; esac
    echo "## $d" >> "$OUT"
    echo >> "$OUT"
    grep -h -E '^\*\*(Today.s one idea|Terms released|Shaky)' "$f" >> "$OUT" 2>/dev/null || true
    echo >> "$OUT"
  done
fi

echo "Wrote $OUT"
wc -l < "$OUT" | xargs echo "  lines:"
