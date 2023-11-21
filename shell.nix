{ pkgs ? import <nixpkgs> {} }: # here we import the nixpkgs package set
pkgs.mkShell {                  # mkShell is a helper function
  name="dev-environment";       # that requires a name
  buildInputs = with pkgs; [    # and a list of packages
    # python3
    espeak-classic
    (python38.withPackages(ps: with ps; [ flask ]))  # certbot
    # openssl
  ];
  shellHook = ''                # bash to run when you enter the shell
    echo "Start developing..."
  '';
}
