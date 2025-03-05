# ⚈ .dotfiles

These are the custom dotfiles for my personalised installation, they are quite simple. It makes setting up a Linux system much quicker and easier, especially when I use it together with [LINUS](https://github.com/merijnvervoorn/LINUS) (my install script)

## 🔩 Requirements

- **Unux based operating system** (It is set up from Ubuntu)

## 🪛 Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/merijnvervoorn/.dotfiles
   cd .dotfiles
   ```
2. **Make the symlink script executable:**

    ```bash
   chmod +x symlink.sh
    ```

4. **Run the script:**

    ```bash
   ./symlink.sh
    ```

5. **Create .gpgkey file for signing Git commits:**

    ```bash
   touch .gpgkey

    echo -e "[user]\n\tsigningkey = [Your gpg key]" >> .gpgkey

    ```

## 🔨 Customization

You can modify the script to suit your preferences:

- Add custom dotfiles: Update the URL in the dotfiles function to point to your own repository if you'd like to use a different set of dotfiles.
- Add symlinks: When adding personal dotfiles, make sure to also add the new symlinks and rm the original files.

## 🔗 Updating the Script

To keep the script updated:

- Navigate to the directory containing the repository.
- Run:
    ```bash
    git pull origin main
    ```

## 🔬 Troubleshooting

- Permission issues: Ensure you have root privileges when running the script, as it requires sudo for package installation and system modifications.

## 📜 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for more details
