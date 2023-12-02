{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
  let
    packageName = "advent-of-code-2023";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages.${system} = rec {
      default = pkgs.buildDotnetModule {
        pname = packageName;
        version = "0.0.0";

        src = ./.;
        nugetDeps = ./deps.nix;

        dotnet-sdk = pkgs.dotnet-sdk_7;
        dotnet-runtime = pkgs.dotnet-runtime_7;

        projectFile = "${packageName}.sln";
      };
      fetch-deps = default.passthru.fetch-deps // {
        executable = true;
      };
    };

    apps.${system} = let
      systemPackage = self.packages.${system};
    in {
      default = {
        type = "app";
        program = "${systemPackage.default}/bin/${packageName}";
      };
      fetch-deps = {
        type = "app";
        program = "${systemPackage.fetch-deps}";
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.dotnet-sdk_7
        pkgs.omnisharp-roslyn
        pkgs.mono
        (pkgs.buildDotnetGlobalTool {
          pname = "dotnet-script";
          version = "1.5.0";
          nugetSha256 = "sha256-PRcgWOOr1+Tx3DNZYHjGgZ+zxHPSjEGwJsue0DoRXMg=";
          dotnet-sdk = pkgs.dotnet-sdk_7;
        })
      ];
    };
  };
}
