{ pkgs, ... }:
# Fonts from a lot of people.
{
    fonts = {
      enableCoreFonts = true;
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        hack-font
        anonymousPro
        corefonts
        dejavu_fonts
        emojione
        fira
        fira-code
        fira-code-symbols
        fira-mono
        font-awesome-ttf
        freefont_ttf
        liberation_ttf
        # nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        source-code-pro
        source-sans-pro
        terminus_font
        ttf_bitstream_vera
        ubuntu_font_family
        powerline-fonts
        font-awesome-ttf
        siji
      ];
    };

    # Select internationalisation properties.
    i18n = {
      consoleFont = "Lat2-Terminus16";
      consoleKeyMap = "us";
      defaultLocale = "en_US.UTF-8";
    };
}