# NixOS Configuration

I have no idea what I'm doing.

```bash
# to switch configuration / initialize configuration ig?
nixos-rebuild switch --flake .#amitofu

# and then afterwards...
nh os switch .
```

## amitofu

Amituofo + tofu. The normal config for my framework laptop.

Secrets are handled using SOPS. An AGE key is stored in 
`~/.config/sops/age/keys.txt`, and the SSH key is stored in `~/.ssh/id_ed25519`.

## Server: `cloudflake`

a flake in the cloud

```bash
nixos-anywhere --flake .#cloudflake --generate-hardware-config nixos-facter ./cloudflake/facter.json -i ~/.ssh/id_ed25519 --target-host root@155.138.194.30

nixos-rebuild switch --flake .#cloudflake --target-host "root@155.138.194.30"
```
