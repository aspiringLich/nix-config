{ pkgs }: {
    environment.systemPackages = [
        pkgs.neofetch
        pkgs.nh
        pkgs.vim
        pkgs.git
        pkgs.sudo
    ];
    programs.fish = {
        enable = true;
    };
    programs.bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    programs.starship = {
        enable = true;
        settings = {
            
        };
    };
}
