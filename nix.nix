{ ... }:
{
    nix.settings = {
        experimental-features = ["nix-command" "flakes"];
        substituters = [
            "https://nix-community.cachix.org"
        ];
    };
}