# korf.vim

A highly customized and optimized Neovim configuration focused on enhancing productivity and developer experience.

## Features
**Intelligent Autocompletion** — powered by configured completion plugins for smooth and efficient coding. - **Integrated LSP Support** — seamless Language Server Protocol setup for smart code diagnostics, navigation, and refactoring. - **Custom Dashboard** — a clean and informative startup dashboard to quickly access recent files and sessions. - Additional quality-of-life improvements and plugin integrations for a modern Neovim experience.

## Included Plugins
korf.vim comes preloaded and configured with essential plugins to boost your workflow, including but not limited to: - Autocompletion plugins (e.g., `nvim-cmp`, snippets) - LSP configuration plugins (e.g., `nvim-lspconfig`) - Dashboard plugins for Neovim startup screen - Various utility and UI enhancement plugins *(For a complete list, please refer to the plugin management config files.)*

## Installation **Prerequisites:**

- Neovim 0.7+ installed.
- - Git installed. Clone this repository and follow your preferred plugin manager's setup procedure.

**Example using [lazy.nvim]:**``
```sh
git clone [https://github.com/eliaskorf/korf.vim](https://github.com/eliaskorf/korf.vim) ~/.config/nvim
```


Open Neovim and ensure plugins are installed and compiled (depends on your plugin manager).

## Usage Open Neovim as usual:
```sh
nvim
```

Enjoy autocompletion, LSP features, and a welcoming dashboard on startup.

## Configuration
You can customize further by editing configuration files under `~/.config/nvim/lua/` or adding more plugins as needed.

## Contributing
Contributions and feature requests are welcome! Please submit issues or pull requests on GitHub.

## License
This project is licensed under the MIT License.

*Happy hacking with korf.vim!*