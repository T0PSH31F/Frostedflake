{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
  #  howdy = inputs.nixpkgs-howdy;
    mod = "${self}/system";

    # get the basic config to build on top of
    inherit (import "${self}/system") desktop laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    LeNix = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./LeNix
        #  "${mod}/core/lanzaboote.nix"

          "${mod}/programs/gamemode.nix"
          "${mod}/programs/hyprland.nix"
          "${mod}/programs/steam.nix"

        # "${mod}/network/spotify.nix"
        #  "${mod}/network/syncthing.nix"

         # "${mod}/services/kmonad"
          "${mod}/services/gnome-services.nix"
          "${mod}/services/location.nix"

          {
            home-manager = {
              users.t0psh31f.imports = homeImports."t0psh31f@LeNix";
              extraSpecialArgs = specialArgs;
            };
          }

          # enable unmerged Howdy
        #  {disabledModules = ["security/pam.nix"];}
        #  "${howdy}/nixos/modules/security/pam.nix"
        #  "${howdy}/nixos/modules/services/security/howdy"
         # "${howdy}/nixos/modules/services/misc/linux-enable-ir-emitter.nix"

         # inputs.agenix.nixosModules.default
        # inputs.chaotic.nixosModules.default
        ];
    };

  #   LeNix = nixosSystem {
    #  inherit specialArgs;
   #    modules =
   #      laptop
   #      ++ [
  #        ./LeNix
    #       "${mod}/core/lanzaboote.nix"

   #        "${mod}/programs/gamemode.nix"
   #        "${mod}/programs/hyprland.nix"
   #        "${mod}/programs/steam.nix"

   #        "${mod}/services/kmonad"
   #        {home-manager.users.t0psh31f.imports = homeImports."t0psh31f@LeNix";}
   #     ];
    # };

    # kiiro = nixosSystem {
    #   inherit specialArgs;
    #   modules =
    #     desktop
    #     ++ [
    #       ./kiiro
    #       {home-manager.users.mihai.imports = homeImports.server;}
    #     ];
    # };
  };
}
