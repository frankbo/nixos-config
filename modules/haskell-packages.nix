{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.haskellPackages;
  [
    alex
    cabal2nix
    cabal-install
    ghc
    ghcid
    #  ghc-mod
    happy
    hlint
    stack
    stylish-haskell
    hindent
  ];
}