#!/usr/bin/env bash
# Drives scripts/check-slides.sh with a fake npm and agent-browser.
set -u
root=$(cd "$(dirname "$0")/.." && pwd)
fail=0

assert() {
  local name=$1
  shift
  if "$@"; then
    echo "ok $name"
  else
    echo "FAIL $name" >&2
    fail=1
  fi
}

run_case() {
  local name=$1
  local typecheck=$2
  local pages_dir=$3
  local expect_exit=$4
  local expect_pages=$5
  local expect_shots=$6
  local expect_opens=$7
  local expect_total=$8
  local expect_truncated=$9
  local state
  state=$(mktemp -d)
  mkdir -p "$state/bin" "$state/shots"
  echo pass > "$state/typecheck"
  if [[ $typecheck == fail ]]; then echo fail > "$state/typecheck"; fi
  cp -a "$pages_dir/." "$state/"

  cat > "$state/bin/npm" << EOF
#!/usr/bin/env bash
if [[ \$(cat "$state/typecheck") == fail ]]; then
  echo "error TS2322: bad" >&2
  exit 1
fi
exit 0
EOF
  cat > "$state/bin/agent-browser" << EOF
#!/usr/bin/env bash
if [[ \$1 == open ]]; then
  page=\${2##*p=}
  echo "\$page" >> "$state/opens"
  echo "\$page" > "$state/current"
  total=\$(cat "$state/total" 2>/dev/null || echo 1)
  if [[ \$total != none ]] && ! grep -q no-deck "$state/page-\$page.json" 2>/dev/null; then
    idx=\$(( page > total ? total : page ))
    printf '{"slideId":"deck","pageIndex":%s,"totalPages":%s}' \$((idx - 1)) "\$total" > "$state/current.json"
  fi
  exit 0
fi
if [[ \$1 == screenshot ]]; then
  echo "\${@: -1}" >> "$state/shots.log"
  exit 0
fi
if [[ \$1 == eval ]]; then
  page=\$(cat "$state/current")
  total=\$(cat "$state/total" 2>/dev/null || echo 1)
  if [[ \$total != none && \$page -gt \$total ]]; then page=\$total; fi
  cat "$state/page-\$page.json"
  exit 0
fi
echo "unexpected \$*" >&2
exit 1
EOF
  chmod +x "$state/bin/npm" "$state/bin/agent-browser"

  local out err status
  out=$(mktemp)
  err=$(mktemp)
  set +e
  OPEN_SLIDE_CURRENT="$state/current.json" PATH="$state/bin:$PATH" "$root/scripts/check-slides.sh" deck >"$out" 2>"$err"
  status=$?
  assert "$name exit" test "$status" -eq "$expect_exit"
  if [[ $expect_exit -eq 0 || $expect_exit -eq 1 ]]; then
    node --input-type=module -e '
      import { readFileSync } from "node:fs"
      const summary = JSON.parse(readFileSync(process.argv[1], "utf8"))
      const expectPages = Number(process.argv[2])
      const typecheck = process.argv[3]
      if (JSON.stringify(summary.totalPages) !== process.argv[4]) process.exit(7)
      if (String(summary.truncated) !== process.argv[5]) process.exit(8)
      if (summary.slideId !== "deck") process.exit(2)
      if (summary.typecheck !== typecheck) process.exit(3)
      if (summary.pages.length !== expectPages) process.exit(4)
      if (typecheck === "fail" && !summary.typecheckOutput.includes("TS2322")) process.exit(5)
      if (typecheck === "pass" && summary.typecheckOutput !== "") process.exit(6)
    ' "$out" "$expect_pages" "$typecheck" "$expect_total" "$expect_truncated"
    assert "$name summary" test $? -eq 0
  fi
  local shots=0
  if [[ -f $state/shots.log ]]; then shots=$(wc -l < "$state/shots.log"); fi
  assert "$name screenshots" test "$shots" -eq "$expect_shots"
  local opens=0
  if [[ -f $state/opens ]]; then opens=$(wc -l < "$state/opens"); fi
  assert "$name opens" test "$opens" -eq "$expect_opens"
  rm -rf "$state" "$out" "$err"
}

tmpdir=$(mktemp -d)
clean_page() { printf '%s\n' "{\"page\":\"$1\",\"issues\":[]}"; }
node_deck() { printf '%s\n' "{\"page\":\"$1\",\"issues\":[{\"type\":\"no-deck\",\"element\":\"\",\"detail\":\"no slide canvas\"}]}"; }
issue_page() { printf '%s\n' "{\"page\":\"$1\",\"issues\":[{\"type\":\"clipped\",\"element\":\"p\",\"detail\":\"clipped\"}]}"; }

# three real pages: the app clamps ?p= past the end, so the walk stops at totalPages
mkdir -p "$tmpdir/end"
for n in 1 2 3; do clean_page "$n" > "$tmpdir/end/page-$n.json"; done
echo 3 > "$tmpdir/end/total"
run_case "deck ends" pass "$tmpdir/end" 0 3 3 3 3 false

# page 1 missing is a failure and takes no screenshot
mkdir -p "$tmpdir/missing"
node_deck 1 > "$tmpdir/missing/page-1.json"
run_case "missing deck" pass "$tmpdir/missing" 1 1 0 1 null false

# an issue fails the run
mkdir -p "$tmpdir/bad"
clean_page 1 > "$tmpdir/bad/page-1.json"
issue_page 2 > "$tmpdir/bad/page-2.json"
echo 2 > "$tmpdir/bad/total"
run_case "clipped" pass "$tmpdir/bad" 1 2 2 2 2 false

# a build error shows on every page, and the walk still ends at totalPages
mkdir -p "$tmpdir/build"
for n in 1 2 3; do printf '%s\n' "{\"page\":\"$n\",\"issues\":[{\"type\":\"build-error\",\"element\":\"\",\"detail\":\"boom\"}]}" > "$tmpdir/build/page-$n.json"; done
echo 3 > "$tmpdir/build/total"
run_case "build error" pass "$tmpdir/build" 1 3 3 3 3 false

# typecheck failure is in the summary even when pages are clean
run_case "typecheck" fail "$tmpdir/end" 1 3 3 3 3 false

# no totalPages from the dev server: only page 1 is checked and the summary says so
mkdir -p "$tmpdir/unknown"
clean_page 1 > "$tmpdir/unknown/page-1.json"
echo none > "$tmpdir/unknown/total"
run_case "unknown total" pass "$tmpdir/unknown" 0 1 1 1 null false

# the walk stops at 40 real pages and says it was cut
mkdir -p "$tmpdir/cap"
for n in $(seq 1 41); do clean_page "$n" > "$tmpdir/cap/page-$n.json"; done
echo 41 > "$tmpdir/cap/total"
run_case "cap" pass "$tmpdir/cap" 0 40 40 40 41 true

rm -rf "$tmpdir"
exit "$fail"
