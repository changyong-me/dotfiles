#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

source macos/setup.sh
source homebrew/setup.sh
source karabiner/setup.sh
source shell/setup.sh
source git/setup.sh
source node/setup.sh
source codex/setup.sh
source zed/setup.sh
