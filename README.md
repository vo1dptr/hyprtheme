# HyprTheme - Hyprland Configuration Setup Script
![hyprtheme](/assets/hyprtheme.png)

**HyprTheme is an easy-to-use shell script for setting up and customizing Hyprland themes on ArchLinux / Arch-Based Distros. This script is designed to simplify your setup.**

## Personal Dotfiles and Contributions

You can use your personal or favorite dotfiles from anywhere on the internet. Simply edit them to automate with the HyprTheme script, and apply them to your setup. If you'd like, you can also contribute your dotfiles to this repository for others to use! If you don’t have any dotfiles of your own, feel free to start with the "default" dotfiles included in HyprTheme, and modify them as you like.

## Goals and Features
<details>
<summary><strong>Goals</strong></summary>

- **Simplicity**: The main objective of HyprTheme is to provide a simple way for users to set up and switch through various themes in Hyprland.

- **Ease Contributions**: Make it easy for everyone to contribute themes so that the collaborative environment where themes can be shared and improved remains open.
</details>
<details>
<summary><strong>Features</strong></summary>

- **User-Friendly**: HyprTheme is beginner-friendly, with easy setup for customizing your Hyprland environment.

- **Automation**: HyprTheme automates the setup process, saving users time and effort.

- **Support Customization**: The `Hypr_RUN` script, when included by theme creators, runs automatically in HyprTheme. This script is typically developed by the theme owner to install dependencies, configure settings, add further customizations, or perform other setup steps.

- **Dynamic Configuration**: If a theme creator does not want their configs copied directly, they can use the `Hypr_RUN` script to dynamically generate or modify configuration files based on user choices, bypassing the need for a static config directory.

- **Streamlined Uninstallation**: Theme maintainers can provide a `Hypr_UNINSTALL` script to handle the uninstallation of their theme. This script ensures specific configurations and dependencies are properly cleaned up, providing a hassle-free removal process for users.
</details>

## Getting Started

<details>
<summary><strong>Installation Instructions</strong></summary>

### Option 1: Clone the Repository

1. **Clone the repository**:

       git clone https://github.com/vo1dptr/hyprtheme.git

2. **Navigate to the repository directory**:

       cd hyprtheme

3. **Make the HyprTheme script executable** if it isn't already:

       chmod +x hyprtheme

4. **Run the setup script**:

       ./hyprtheme

### Option 2: Download and Install from Zip

1. **Download the zip file**:

   - Using `wget`:

         wget https://github.com/vo1dptr/hyprtheme/archive/refs/heads/main.zip

   - Using `curl`:

         curl -LO https://github.com/vo1dptr/hyprtheme/archive/refs/heads/main.zip

   - Or download it directly from the [GitHub repository](https://github.com/vo1dptr/hyprtheme/archive/refs/heads/main.zip) using your web browser.

2. **Extract the zip file**:

       unzip main.zip

3. **Navigate to the extracted directory**:

       cd hyprtheme-main

4. **Make the HyprTheme script executable** if it isn't already:

       chmod +x hyprtheme

5. **Run the setup script**:

       ./hyprtheme

</details>

## How It Works

<details>
<summary><strong>How It Works</strong></summary>
Let’s explain what HyprTheme does and what it changes. While I can’t specify exactly what it changes since each theme can use different utilities and therefore different configuration folders and files, in general, this script is going to do the following:

1. **Copied Configuration Files**: It copies configuration files from the theme's directory to your system.

2. **Installs Theme Requirements**: If a `Requirements.txt` file exists inside the theme, the packages listed in it will be installed via this script using `pacman`. If a package cannot be installed via `pacman`, you must use another package manager like `yay`, or any method you prefer. To do this, you can include the necessary installation steps in the `Hypr_RUN` script and place it in your theme folder.

3. **Runs Optional Scripts**:
   - **Hypr_RUN**: This script, when present in the theme's folder, is run once. It can perform several tasks specific to that theme. For an example, see [here](Themes/Default/Hypr_RUN).
   - **Hypr_UNINSTALL**: This script, if present in the theme's folder, runs when you uninstall the theme, cleaning up its specific configurations and dependencies. For an example, see [here](Themes/Default/Hypr_UNINSTALL).

**Check the [Default](Themes/Default) theme as it’s a great example, and the [HyprTheme](hyprtheme) script. Hope this helps!**
</details>

## Reporting Issues
If you encounter any bugs or have suggestions for improvement, feel free to submit them [here](https://github.com/vo1dptr/hyprtheme/issues).

## Contributing
I appreciate contributions! For further information, please have a look at the [CONTRIBUTING](CONTRIBUTING.md) file.

Thank you for using the HyprTheme script! I hope you enjoy using Hyprland.

## License
This project is licensed under the [MIT License](LICENSE).
