# nix-build docker.nix -o result
# docker load -i ./result
# docker images | grep gitlab-webhooks-server
# docker run -it -v $(pwd)/app.py:/app.py -p 5000:5000 gitlab-webhooks-server:latest flask run --host=0.0.0.0

{ pkgs ? import <nixpkgs> { system = "x86_64-linux";} }:

pkgs.dockerTools.buildLayeredImage {
  name = "gitlab-webhooks-server";
  tag = "latest";
  contents = with pkgs; [
    (python311.withPackages(ps: with ps; [ flask pyttsx3 ]))  # certbot
    espeak
    # openssl
  ];

  config = {
    Cmd = [ "sh" "-c" 
      ''
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(find /nix/store -name libespeak.so.1 | head -n 1 | xargs dirname)
        exec "$@"
      ''
    ];
  };
}
