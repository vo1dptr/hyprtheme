#!/bin/sh
# github.com/0x76OID/hyprtheme

source ./Colors

# Install packages
install_pkgs() {
    local requirements_file=$1
    sudo pacman -S --noconfirm $(cat "$requirements_file")
}

# Set up themes
setup_theme() {
    echo -e "${BLUE}Available themes:${NC}"
    themes=($(ls Themes))
    for i in "${!themes[@]}"; do
        echo "$((i+1)). ${themes[$i]}"
    done

    read -p "Select a theme by number: " theme_choice
    selected_theme=${themes[$((theme_choice-1))]}

    echo -e "${YELLOW}Setting up theme: ${selected_theme}${NC}"

    theme_path="Themes/$selected_theme"

    # Copy configs if the config folder exists
    if [ -d "$theme_path/config" ]; then
        cp -r "$theme_path/config/"* ~/.config
        echo -e "${GREEN}Configs copied to config folder.${NC}"
    else
        echo -e "${YELLOW}No config folder found. Skipping config copy.${NC}"
    fi

    # Install theme requirements
    if [ -f "$theme_path/Requirements/Requirements.txt" ]; then
        install_pkgs "$theme_path/Requirements/Requirements.txt"
        echo -e "${GREEN}Theme requirements installed.${NC}"
    fi

    # Execute Hypr_RUN script if it exists
    if [ -f "$theme_path/Hypr_RUN" ]; then
        chmod +x "$theme_path/Hypr_RUN"
        "$theme_path/Hypr_RUN"
        echo -e "${GREEN}Hypr_RUN script executed.${NC}"
    fi
}

# Uninstall themes
uninstall_theme() {
    echo -e "${BLUE}Available themes:${NC}"
    themes=($(ls Themes))
    for i in "${!themes[@]}"; do
        echo "$((i+1)). ${themes[$i]}"
    done

    read -p "Select a theme to uninstall by number: " theme_choice
    selected_theme=${themes[$((theme_choice-1))]}

    echo -e "${YELLOW}Uninstalling theme: ${selected_theme}${NC}"

    theme_path="Themes/$selected_theme"

    # Execute Hypr_UNINSTALL script if it exists
    if [ -f "$theme_path/Hypr_UNINSTALL" ]; then
        chmod +x "$theme_path/Hypr_UNINSTALL"
        "$theme_path/Hypr_UNINSTALL"
        echo -e "${GREEN}Hypr_UNINSTALL script executed.${NC}"
    else
        echo -e "${RED}Hypr_UNINSTALL script not found. The theme owner did not provide an uninstall script. Please uninstall manually.${NC}"
        exit 1
    fi
}

# Check if the script is running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Please do not run this script as root. Exit and run it as a regular user.${NC}"
    exit 1
fi

echo -e "${MAGENTA}"
cat << "HYPRTHEME_L"
 /$$   /$$                            /$$$$$$$$ /$$
| $$  | $$                           |__  $$__/| $$
| $$  | $$ /$$   /$$  /$$$$$$   /$$$$$$ | $$   | $$$$$$$   /$$$$$$  /$$$$$$/$$$$   /$$$$$$ 
| $$$$$$$$| $$  | $$ /$$__  $$ /$$__  $$| $$   | $$__  $$ /$$__  $$| $$_  $$_  $$ /$$__  $$
| $$__  $$| $$  | $$| $$  \ $$| $$  \__/| $$   | $$  \ $$| $$$$$$$$| $$ \ $$ \ $$| $$$$$$$$
| $$  | $$| $$  | $$| $$  | $$| $$      | $$   | $$  | $$| $$_____/| $$ | $$ | $$| $$_____/
| $$  | $$|  $$$$$$$| $$$$$$$/| $$      | $$   | $$  | $$|  $$$$$$$| $$ | $$ | $$|  $$$$$$$
|__/  |__/ \____  $$| $$____/ |__/      |__/   |__/  |__/ \_______/|__/ |__/ |__/ \_______/
           /$$  | $$| $$
          |  $$$$$$/| $$
           \______/ |__/
HYPRTHEME_L
echo -e "${NC}"

# Main menu
echo -e "${BLUE}What do you want to do?${NC}"
echo "1. Setup Hyprland"
echo "2. Setup Themes"
echo "3. Uninstall Theme"
read -p "Enter your choice (1, 2, or 3): " main_choice

case $main_choice in
    1)
        # Setup Hyprland
        echo -e "${YELLOW}Setting up Hyprland...${NC}"

        # Install dependencies for yay
        echo -e "${YELLOW}Installing dependencies for yay...${NC}"
        sudo pacman -S --noconfirm git base-devel

        # Install Yay if not already installed
        if ! command -v yay >/dev/null 2>&1; then
            echo -e "${YELLOW}Installing yay...${NC}"
            git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
            cd ..
            rm -rf yay
            echo -e "${GREEN}Yay installed.${NC}"
        else
            echo -e "${GREEN}Yay is already installed.${NC}"
        fi

        # Install Hyprland using Yay
        yay -S hyprland
        echo -e "${GREEN}Hyprland installed.${NC}"

        # Install Nvidia drivers if needed
        read -p "Do you want to install Nvidia drivers? (Y/n) " nvidia_choice
        if [[ "$nvidia_choice" =~ ^[Yy]$ ]]; then
            sudo pacman -S --noconfirm nvidia nvidia-utils
            echo -e "${GREEN}Nvidia drivers installed.${NC}"
        fi
        ;;
    2)
        setup_theme
        ;;
    3)
        uninstall_theme
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac

echo -e "\n\n${GREEN}Setup completed. Enjoy!${NC}"
