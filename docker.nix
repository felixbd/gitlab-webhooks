# We all love docker. But over time it can become tedious to write
# reliable docker files.
# What if you could use the power of Nix to build Docker images?

# nix-build docker.nix -o result
# docker load -i ./result
# docker images | grep gitlab-webhooks-server
# docker run -it -v $(pwd)/app.py:/app.py -p 5000:5000 gitlab-webhooks-server:latest flask run --host=0.0.0.0

{ pkgs ? import <nixpkgs> { system = "x86_64-linux";}
}:                                    # nixpkgs package set
pkgs.dockerTools.buildLayeredImage {  # helper to build Docker image
  name = "gitlab-webhooks-server";    # give docker image a name
  tag = "latest";                     # provide a tag
  contents = with pkgs; [             # packages in docker image
    # python3
    (python38.withPackages(ps: with ps; [ flask ]))  # certbot
    espeak-classic
    # openssl
    # pkgs.hello
  ];

  # runAsRoot = ''
  #   # mkdir -p /app
  #   # chown -R nobody:nogroup /app
  # '';

  # meta = with pkgs; {
  #   description = "Docker image for a Flask gitlab webhooks server";
  #   license = licenses.mit;
  # };
}
