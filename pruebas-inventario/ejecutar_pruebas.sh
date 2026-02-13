#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "[INFO] Ejecutando pruebas Karate con Maven..."
mvn test

echo "[INFO] Reporte HTML generado en: $SCRIPT_DIR/target/karate-reports/karate-summary.html"
