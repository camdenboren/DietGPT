# SPDX-FileCopyrightText: 2025 Camden Boren
# SPDX-License-Identifier: GPL-3.0-or-later

{ pkgs }:

pkgs.writeShellScriptBin "format" ''
  set -o pipefail
  box() { ${pkgs.boxes}/bin/boxes -d ansi -s $(tput cols); } 2> /dev/null
  failed() {
    echo -e "\n\033[1;31mFormat failed.\033[0m"
    exit 1
  }
  trap 'failed' ERR

  echo -e "\033[1;33mrustfmt...\033[0m"
  rustfmt src-tauri/**/*.rs src-tauri/*.rs | box

  echo -e "\n\033[1;33mnix...\033[0m"
  ${pkgs.nixfmt-rfc-style}/bin/nixfmt flake.nix **/*.nix | box

  echo -e "\n\033[1;33mprettier...\033[0m"
  ${pkgs.nodePackages.prettier}/bin/prettier \
  --plugin=${pkgs.nodePackages.prettier-plugin-toml}\
  /lib/node_modules/prettier-plugin-toml/lib/index.cjs \
  --write "**/*.md" "**/*.vue" "**/*.ts" "**/*.json" "**/*.toml" \
  "!src-tauri/{gen,target}" "**/*.html" "**/*.css" | box

  echo -e "\n\033[1;32mFormat succeeded.\033[0m"
''
