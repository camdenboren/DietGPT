# SPDX-FileCopyrightText: 2025 Camden Boren
# SPDX-License-Identifier: GPL-3.0-or-later

{ pkgs }:

pkgs.writeShellScriptBin "build" ''
  set -o pipefail
  box() { ${pkgs.boxes}/bin/boxes -d ansi -s $(tput cols); } 2> /dev/null
  failed() {
    echo -e "\n\033[1;31mBuild failed.\033[0m"
    exit 1
   }
  trap 'failed' ERR

  echo -e "\033[1;33mbuild...\033[0m"
  npm run build | box

  echo -e "\n\033[1;32mBuild succeeded.\033[0m"
''
