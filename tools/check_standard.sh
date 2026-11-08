#!/bin/bash
# tools/check_standard.sh - checks this repository against the GS repository standard
# (Developer Documentation Specification v3.0 §5, §11, §12). Run from the repository root.
set -u; fail=0
ok(){ if eval "$2"; then echo "PASS $1"; else echo "FAIL $1"; fail=1; fi; }
for f in README.md CHANGELOG.md SECURITY.md AGENTS.md LICENSE VERSION docs/architecture.md docs/operations.md \
         docs/testing.md docs/decisions/README.md docs/decisions/0000-adr-template.md docs/templates/review-record.md \
         .github/pull_request_template.md tests/run_all.sh; do
  ok "file $f" '[ -f "$f" ]'
done
ok "GS CI workflow (name: GS CI) in .github/workflows" 'grep -lqx "name: GS CI" .github/workflows/*.y*ml 2>/dev/null'
i=1
for s in "Purpose and boundaries" "Ownership" "Source provenance" "Supported environment" "Setup and secrets" \
         "Build and run" "Code map" "Contracts" "Verification" "Debugging" "Release and recovery" "Maintenance"; do
  ok "README section $i: $s" 'grep -qx "## $i. $s" README.md'; i=$((i+1))
done
for k in "Document ID" "Title" "Audience" "Owner" "Status" "Applicable versions" "Source revision" "Last validation" "Review trigger"; do
  ok "README metadata: $k" 'grep -q "^| $k |" README.md'
done
ok "README ends with Credits and licence" '[ "$(grep -E "^## " README.md | tail -1)" = "## Credits and licence" ]'
V=$(cat VERSION 2>/dev/null)
ok "VERSION is semantic ($V)" '[[ "$V" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]'
ok "CHANGELOG has an entry for $V" 'grep -E "^## " CHANGELOG.md | grep -qE "(\[| |v)${V//./\\.}(\]| |$)"'
for f in .github/pull_request_template.md; do
  for k in "Task ID" "Requirement IDs" "Base commit" "Acceptance scenarios" "Recovery" "Tests actually run" "Exact results" "Codex review request"; do
    ok "PR template field: $k" 'grep -q "$k" "$f"'
  done
done
ok "no 'Home Assistant' in README or docs prose (use GS core)" '! grep -rqi "home assistant" README.md docs'
# tools/check_standard.allow: known public test fixtures (one path per line), e.g. an upstream dummy test key
ok "no private key blocks (except listed test fixtures)" '[ -z "$(grep -rIlE "BEGIN [A-Z ]*PRIVATE KEY" --exclude-dir=.git --exclude-dir=node_modules . | sed "s#^\./##" | grep -vxFf <(grep -v "^#" tools/check_standard.allow 2>/dev/null; echo /dev/null))" ]'
exit $fail
