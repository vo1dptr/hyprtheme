#!/bin/sh
# github.com/0x76OID/HyprV

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

    # Copy configs
    if [ -d "$theme_path/config" ]; then
        cp -r "$theme_path/config/"* ~/.config
        echo -e "${GREEN}Configs copied to ~/.config.${NC}"
    fi

    # Install theme requirements
    if [ -f "$theme_path/Requirements/Requirements.txt" ]; then
        install_pkgs "$theme_path/Requirements/Requirements.txt"
        echo -e "${GREEN}Theme requirements installed.${NC}"
    fi

    # Execute HyprV_Run_This script if it exists
    if [ -f "$theme_path/HyprV_Run_This" ]; then
        chmod +x "$theme_path/HyprV_Run_This"
        "$theme_path/HyprV_Run_This"
        echo -e "${GREEN}HyprV_Run_This script executed.${NC}"
    fi
}

# Check if the script is running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Please do not run this script as root. Exit and run it as a regular user.${NC}"
    exit 1
fi

echo -e "${MAGENTA}"
cat << "HYPRV_L"
/$$   /$$                               /$$    /$$
| $$  | $$                              | $$   | $$
| $$  | $$ /$$   /$$  /$$$$$$   /$$$$$$ | $$   | $$
| $$$$$$$$| $$  | $$ /$$__  $$ /$$__  $$|  $$ / $$/
| $$__  $$| $$  | $$| $$  \ $$| $$  \__/ \  $$ $$/
| $$  | $$| $$  | $$| $$  | $$| $$        \  $$$/
| $$  | $$|  $$$$$$$| $$$$$$$/| $$         \  $/
|__/  |__/ \____  $$| $$____/ |__/          \_/
           /$$  | $$| $$
          |  $$$$$$/| $$
           \______/ |__/
HYPRV_L
echo -e "${NC}"

# Main menu
echo -e "${BLUE}What do you want to do?${NC}"
echo "1. Setup Hyprland"
echo "2. Setup Themes"
read -p "Enter your choice (1 or 2): " main_choice

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
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac

echo -e "\n\n${GREEN}Setup completed. Enjoy!!!${NC}"
