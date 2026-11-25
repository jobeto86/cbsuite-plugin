#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PUBLIC_SRC="${ROOT_DIR}/public/cbsuite"
FULL_SKILLS_SRC="${ROOT_DIR}/plugins/cbsuite/skills"
AGY_SRC="${ROOT_DIR}/public/antigravity"
VERSION="$(jq -r '.version' "${AGY_SRC}/plugin.json")"
OUT_ZIP="${ROOT_DIR}/dist/cbsuite-antigravity-${VERSION}.zip"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

cp -r "${PUBLIC_SRC}/assets" "${TMP_DIR}/assets"
mkdir -p "${TMP_DIR}/skills"
cp -r "${FULL_SKILLS_SRC}/ayuda" "${TMP_DIR}/skills/ayuda"
cp "${AGY_SRC}/plugin.json" "${TMP_DIR}/plugin.json"
cp "${AGY_SRC}/mcp_config.json" "${TMP_DIR}/mcp_config.json"
cp "${AGY_SRC}/README.md" "${TMP_DIR}/README.md"

mkdir -p "${ROOT_DIR}/dist"
rm -f "${OUT_ZIP}"
(cd "${TMP_DIR}" && zip -rq "${OUT_ZIP}" .)

echo "Built: ${OUT_ZIP}"
agy plugin validate "${OUT_ZIP}" --strict
