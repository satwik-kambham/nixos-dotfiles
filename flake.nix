{
  description = "My NixOS configuration";

  inputs = {
    # NixOS 26.05
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Llama cpp
    llama-cpp.url = "github:ggml-org/llama.cpp";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, llama-cpp, ... }:
    let
      system = "x86_64-linux";
      llamacpp_pkgs = llama-cpp.packages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      specialArgs = {
        inherit inputs llamacpp_pkgs pkgs-unstable;
      };
    in
    {
      formatter = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (
        system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );

      nixosConfigurations.strix = nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [ ./hosts/strix/configuration.nix ];
      };
    };
}
