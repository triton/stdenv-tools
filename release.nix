{ src ? ./. }:
let
  pkgs = import <nixpkgs> { };

  version = builtins.readFile (pkgs.stdenv.mkDerivation {
    name = "stdenv-tools-version";
    preferLocalBuild = true;
    nativeBuildInputs = [ pkgs.git pkgs.coreutils pkgs.gnugrep pkgs.gnused ];
    buildCommand = ''
      cd ${src}

      # Check if we are building a release version
      TAGS="$(git tag --points-at HEAD)"
      COUNT="$(echo -n "$TAGS" | wc -l)"

      if [ "$COUNT" -eq "0" ]; then
        if [ -n "$TAGS" ]; then
          if ! grep -q "\[$TAGS\]" configure.ac; then
            echo "Autoconf defined version is different than the tagged version" >&2
            exit 1
          fi
          echo -n "$TAGS" > "$out"
        else
          echo -n "git-" > "$out"
          git rev-parse --short HEAD | tr -d '\n' >> "$out"
        fi
      else
        echo "Found multiple tags:" >&2
        echo "$TAGS" | sed 's,^,  ,' >&2
        exit 1
      fi
    '';
  });
in
rec {
  tarball = pkgs.releaseTools.sourceTarball {
    name = "stdenv-tools-tarball";
    inherit version src;
    versionSuffix = "";
    nativeBuildInputs = with pkgs; [
      autoconf-archive
    ];
    buildInputs = with pkgs; [
      rapidjson
      pkgconf
    ];
  };

  build = pkgs.lib.genAttrs [ "x86_64-linux" "i686-linux" ] (system:
    let
      pkgs' = import <nixpkgs> { inherit system; };
    in pkgs'.releaseTools.nixBuild {
      name = "stdenv-tools";
      src = tarball;
      buildInputs = with pkgs'; [
        rapidjson
        pkgconf
      ];
      doCheck = true;
    }
  );

  release = pkgs.releaseTools.aggregate {
    name = "stdenv-tools-${version}";
    constituents = [
      tarball
      build.x86_64-linux
      build.i686-linux
    ];
  };
}
