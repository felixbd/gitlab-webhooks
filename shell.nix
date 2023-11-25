# shell.nix for flask webserver in python
#  with pyttsx3 (tts lib using espeak)

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name="dev-environment";
  buildInputs = with pkgs; [
    (python311.withPackages(ps: with ps; [ flask pyttsx3 ]))  # certbot
    espeak
    # openssl
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`find /nix/store -name libespeak.so.1 | head -n 1 | xargs dirname`
    echo "Entering environment with python3.11 {flask, pyttsx3}"
    echo "Start developing..."
  '';
}
