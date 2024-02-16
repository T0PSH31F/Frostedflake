{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
  #  "t0psh31f@io" = [
  #    ../.
  #    ./io
  #  ];
    "t0psh31f@LeNix" = [
      ../.
      ./LeNix
    ];
    server = [
      ../.
      ./server
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  # we need to pass this to NixOS' HM module
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
  #   "mihai_io" = homeManagerConfiguration {
  #    modules = homeImports."mihai@io";
  #    inherit pkgs extraSpecialArgs;
  #    };

      "t0psh31f_LeNix" = homeManagerConfiguration {
        modules = homeImports."t0psh31f@LeNix";
        inherit pkgs extraSpecialArgs;
      };

      server = homeManagerConfiguration {
        modules = homeImports.server;
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
