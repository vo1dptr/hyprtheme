# HyprTheme - Hyprland Configuration Setup Script
![hyprtheme](/assets/hyprtheme.png)

**HyprTheme is an easy-to-use script for setting up and customizing Hyprland themes on ArchLinux / Arch-Based Distros. Whether you're a newbie or just want a smoother experience, this script is designed to simplify your setup.**

## Features
- **User-Friendly**: hyprtheme is beginner-friendly, with easy setup in customizing your Hyprland environment.
- **Automation**: hyprtheme automates the setup process. There is no need to invest too much time and effort.

## Getting Started

<details>
<summary><strong>Installation Instructions</strong></summary>

1. **Clone the repository**:

       git clone https://github.com/0x76OID/hyprtheme.git

2. **Navigate to the repository directory**:

       cd hyprtheme

3. **Make the hyprtheme script executable** if it isn't already:

       chmod +x hyprtheme.sh

4. **Run the setup script**:

       ./hyprtheme.sh

</details>

## How It Works

<details>
<summary><strong>How It Works?</strong></summary>
Let’s explain what the Hyprtheme does and what it changes. While i can’t specify exactly what it changes since each theme can use different utilities and therefore different configuration folders and files, in general, this script is going to do the following:

1. **Copied Configuration Files**: It copies configuration files from the theme's directory to your system.

2. **Installs Theme Requirements**: If a `Requirements.txt` file exists inside the theme, the packages listed in it will be installed via this script.

3. **Runs Optional Scripts**:
   - **Hypr_RUN**: This script, when present in the theme's folder, is run once. It can perform several tasks specific to that theme. For an example, see [here](Themes/Default/Hypr_RUN)
   - **Hypr_UNINSTALL**: This script, if present in the theme's folder, runs when you uninstall the theme, cleaning up its specific configurations and dependencies. For an example, see [here](Themes/Default/Hypr_UNINSTALL)

**Check the [Default](Themes/Default) theme since it's a great example, and the [hyprtheme](hyprtheme.sh) script. Hope this helps!**
</details>

## Reporting Issues
If you have any bugs or other issues you find, or if you have suggestions for me to improve, feel free to submit them [here](https://github.com/0x76OID/hyprtheme/issues).

## Contributing
I appreciate contributions! For further information, please have a look in the [CONTRIBUTING](CONTRIBUTING.md) file.

Thank you for using the hyprtheme script! I hope you'll enjoy using Hyprland. 

## License
This project is licensed under the [MIT License](LICENSE).
