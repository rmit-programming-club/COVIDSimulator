{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell { 
  name = "tcp-game-env";
  buildInputs = with pkgs; [ godot gimp ];
}
