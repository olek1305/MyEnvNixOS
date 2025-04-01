{ config, pkgs, ... }:

{
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            ohMyZsh = {
                enable = true;
                theme = "arrow";
                plugins = [
                    "docker"
                    "docker-compose"
                    "git"
                    "gitignore"
                    "golang"
                    "history"
                    "laravel"
                    "nanoc"
                    "node"
                    "npm"
                    "symfony"
                    "systemd"
                ];
            };
        shellAliases = {
            pa = "php artisan";
            dc = "docker-compose";
            ll = "ls -l";
            update = "sudo nixos-rebuild switch";
        };
        histSize = 10000;
        };
    };
}