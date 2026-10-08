#!/usr/bin/env bash
# One check for every page of a slide. Prints one JSON summary.
#   scripts/check-slides.sh <slide-id>
set -u

# Walks ?p=1..N. The app clamps ?p= past the last page, so N comes from the
# totalPages the dev server records in current.json, not from the page itself.
id="${1:?usage: scripts/check-slides.sh <slide-id>}"
cd "$(dirname "$0")/.."

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
typecheck_log="$work/typecheck.txt"
current="${OPEN_SLIDE_CURRENT:-node_modules/.open-slide/current.json}"
limit=40
rm -f /tmp/slides-"${id}"-*.png

if npm run typecheck >"$typecheck_log" 2>&1; then
  typecheck=pass
else
  typecheck=fail
fi

# totalPages of this slide as the dev server last recorded it, once page 1 mounted.
read_total() {
  node --input-type=module -e '
    import { readFileSync } from "node:fs"
    try {
      const data = JSON.parse(readFileSync(process.argv[1], "utf8"))
      if (data.slideId === process.argv[2] && data.pageIndex === 0 && data.totalPages > 0) console.log(data.totalPages)
    } catch {}
  ' "$current" "$id"
}

# Pages after the first switch inside the running app: a full load of the dev server's
# unbundled modules takes several seconds, so only page 1 pays for it. The retry reloads.
goto_page() {
  if [[ $1 -gt 1 && $2 -eq 1 ]]; then
    agent-browser eval "history.pushState(null, '', '/s/${id}?p=$1'); dispatchEvent(new PopStateEvent('popstate')); 0" >/dev/null &&
      agent-browser wait 300 >/dev/null
  else
    agent-browser open "http://localhost:3000/s/${id}?p=$1"
  fi
}

# A freshly launched browser keeps its first real open on about:blank, so launch it here.
agent-browser open about:blank || exit $?

page=1
total=1
total_pages=null
truncated=false
while [[ $page -le $total ]]; do
  # no-deck can be a page that is slow to mount, so look twice before trusting it.
  for attempt in 1 2; do
    goto_page "$page" "$attempt" || exit $?
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
    if [[ $status -ne 0 ]]; then break; fi
  done
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
  if [[ $page -eq 1 ]]; then
    for _ in 1 2 3 4 5 6 7 8 9 10; do
      found=$(read_total)
      [[ -n $found ]] && break
      sleep 0.3
    done
    if [[ -n ${found:-} ]]; then
      total_pages=$found
      total=$found
      if [[ $total -gt $limit ]]; then
        total=$limit
        truncated=true
      fi
    fi
  fi
  page=$((page + 1))
done

node --input-type=module -e '
  import { readdirSync, readFileSync } from "node:fs"
  const work = process.argv[1]
  const typecheck = process.argv[2]
  const slideId = process.argv[3]
  const totalPages = JSON.parse(process.argv[5])
  const truncated = process.argv[6] === "true"
  const typecheckOutput = typecheck === "fail" ? readFileSync(process.argv[4], "utf8").trim().slice(0, 2000) : ""
  const pages = readdirSync(work)
    .filter((name) => name.startsWith("keep-"))
    .sort((a, b) => Number(a.replace(/\D/g, "")) - Number(b.replace(/\D/g, "")))
    .map((name) => {
      const data = JSON.parse(readFileSync(`${work}/${name}`, "utf8"))
      return { page: String(data.page), issues: data.issues }
    })
  const summary = { slideId, typecheck, typecheckOutput, totalPages, truncated, pages }
  process.stdout.write(JSON.stringify(summary))
  const failed = typecheck === "fail" || pages.some((item) => item.issues.length > 0)
  process.exit(failed ? 1 : 0)
' "$work" "$typecheck" "$id" "$typecheck_log" "$total_pages" "$truncated"
