#!/usr/bin/env bash
# One check for every page of a slide. Prints one JSON summary.
#   scripts/check-slides.sh <slide-id>
set -u

id="${1:?usage: scripts/check-slides.sh <slide-id>}"
cd "$(dirname "$0")/.."

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
typecheck_log="$work/typecheck.txt"

if npm run typecheck >"$typecheck_log" 2>&1; then
  typecheck=pass
else
  typecheck=fail
fi

page=1
while [[ $page -le 40 ]]; do
  agent-browser open "http://localhost:3000/s/${id}?p=${page}" || exit $?
  raw=$(agent-browser eval "$(cat scripts/verify-slides.js)") || exit $?
  printf '%s' "$raw" > "$work/raw.txt"
  node --input-type=module -e '
    import { readFileSync, writeFileSync } from "node:fs"
    const raw = readFileSync(process.argv[1], "utf8")
    const start = raw.indexOf("{")
    const end = raw.lastIndexOf("}")
    if (start === -1 || end < start) {
      console.error("verify-slides returned no JSON")
      process.exit(2)
    }
    const data = JSON.parse(raw.slice(start, end + 1))
    const issues = Array.isArray(data.issues) ? data.issues : []
    const noDeck = issues.some((issue) => issue.type === "no-deck")
    writeFileSync(process.argv[2], JSON.stringify({ noDeck, page: String(data.page ?? process.argv[3]), issues }))
    process.exit(noDeck ? 0 : 10)
  ' "$work/raw.txt" "$work/parsed.json" "$page"
  status=$?
  if [[ $status -eq 2 ]]; then exit 2; fi
  if [[ $status -eq 0 ]]; then
    if [[ $page -eq 1 ]]; then
      mv "$work/parsed.json" "$work/keep-$page.json"
    fi
    break
  fi
  if [[ $status -ne 10 ]]; then exit "$status"; fi
  agent-browser screenshot "/tmp/slides-${id}-${page}.png" || exit $?
  mv "$work/parsed.json" "$work/keep-$page.json"
  page=$((page + 1))
done

node --input-type=module -e '
  import { readdirSync, readFileSync } from "node:fs"
  const work = process.argv[1]
  const typecheck = process.argv[2]
  const slideId = process.argv[3]
  const typecheckOutput = typecheck === "fail" ? readFileSync(process.argv[4], "utf8").trim() : ""
  const pages = readdirSync(work)
    .filter((name) => name.startsWith("keep-"))
    .sort((a, b) => Number(a.slice(5)) - Number(b.slice(5)))
    .map((name) => {
      const data = JSON.parse(readFileSync(`${work}/${name}`, "utf8"))
      return { page: String(data.page), issues: data.issues }
    })
  const summary = { slideId, typecheck, typecheckOutput, pages }
  process.stdout.write(JSON.stringify(summary))
  const failed = typecheck === "fail" || pages.some((item) => item.issues.length > 0)
  process.exit(failed ? 1 : 0)
' "$work" "$typecheck" "$id" "$typecheck_log"
