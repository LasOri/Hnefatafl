#!/bin/bash
set -euo pipefail

MODE="${1:-debug}"
SDK_ID="${SWIFT_SDK_ID:-wasm32-unknown-wasip1}"

echo "Building Hnefatafl (${MODE})..."
swift package --swift-sdk "${SDK_ID}" js --use-cdn -c "${MODE}"

echo "Build complete. Output in .build/plugins/PackageToJS/outputs/HnefataflPackageTests/"
echo "Run with: npx serve .build/plugins/PackageToJS/outputs/HnefataflPackageTests/"
