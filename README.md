# NixOS Condiguration

I have no idea what I'm doing.

```bash
# to switch configuration / initialize configuration ig?
nixos-rebuild switch --flake .#amitofu

# and then afterwards...
nh os switch .
```

## Server: Cloudflake

a flake in the cloud

```
nixos-anywhere --flake .#cloudflake --generate-hardware-config nixos-facter ./facter.json -i ~/.ssh/id_ed25519 --target-host root@155.138.194.30 

nixos-rebuild switch --flake .#cloudflake --target-host "root@155.138.194.30"
```
