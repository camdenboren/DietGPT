# SPDX-FileCopyrightText: 2025 Camden Boren
# SPDX-License-Identifier: GPL-3.0-or-later

{
  description = "DietGPT Development Environment via Nix Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs =
    { nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        function:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          function rec {
            pkgs = nixpkgs.legacyPackages.${system}.extend (import ./nix/overlay.nix { inherit pkgs; });
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              bashInteractive
              nodejs
              cargo
              cargo-tauri
              rustc
              pkg-config
              gobject-introspection
              rust-analyzer
              rustfmt
              build
              format
            ];

            buildInputs = with pkgs; [
              at-spi2-atk
              atkmm
              cairo
              gdk-pixbuf
              glib
              gtk3
              harfbuzz
              librsvg
              libsoup_3
              pango
              webkitgtk_4_1
              openssl
            ];

            env = {
              WEBKIT_DISABLE_DMABUF_RENDERER = 1;
            };

            shellHook = import ./nix/shellHook.nix;
          };
        }
      );
    };
}
