{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # disable fish_greeting
    '';
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
      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[✗](bold red) ";
        vimcmd_symbol = "[❯](bold cyan) ";
        vimcmd_replace_one_symbol = "[❱](bold purple) ";
        vimcmd_replace_symbol = "[❱](bold purple) ";
        vimcmd_visual_symbol = "[❮](bold yellow) ";
      };
      # directory.substitutions = {
      #   Documents = "󰈙 ";
      #   Downloads = " ";
      #   Music = " ";
      #   Pictures = " ";
      #   Programming = " ";
      # };
    };
  };
}
