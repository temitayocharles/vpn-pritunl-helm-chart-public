#!/bin/bash
set -e

echo "[INFO] Running helm dependency update..."
helm dependency update .

echo "[INFO] Decrypting secrets..."
sops -d secrets.sops.yaml > secrets.yaml

echo "[INFO] Linting chart..."
helm lint .

echo "[INFO] Rendering chart (dry-run)..."
helm template vpn-pritunl . -f values.yaml -f secrets.yaml

echo "[INFO] ✅ Chart rendered successfully"

# Optional cleanup
rm -f secrets.yaml
