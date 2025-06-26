# A IKEA/Ingka Neovim flavored Configuration
This is a modular Neovim configuration written in Lua, designed for productivity, code intelligence, and a beautiful UI. It leverages the latest plugin ecosystem and is organized for easy customization.

## Features

- LSP, completion, and code actions
- AI/code assistant integration
- Debugging (DAP) for multiple languages
- Git integration
- Treesitter-based syntax highlighting
- Modern statusline and UI enhancements
- Python virtual environment selector
- Fuzzy finding and search
- Markdown and documentation tools

## Plugin Overview

| Category      | Plugin(s) / Description                                                                 |
|---------------|----------------------------------------------------------------------------------------|
| **AI/Code Assistant** | `yetone/avante.nvim`, `zbirenbaum/copilot.lua`, `ravitemer/mcphub.nvim` (AI, Copilot, MCP Hub) |
| **LSP & Completion**  | `neovim/nvim-lspconfig`, `mason-org/mason.nvim`, `folke/snacks.nvim`, `saghen/blink.cmp`, `L3MON4D3/LuaSnip`, `Kaiser-Yang/blink-cmp-avante`, etc. |
| **Debugging (DAP)**   | `mfussenegger/nvim-dap`, `rcarriga/nvim-dap-ui`, `leoluz/nvim-dap-go`, `mfussenegger/nvim-dap-python`, `linux-cultist/venv-selector.nvim` |
| **Git**               | `kdheepak/lazygit.nvim`                                                          |
| **UI**                | `nvim-lualine/lualine.nvim` (statusline), `folke/which-key.nvim`, `noice.nvim`, `toggleterm.nvim`, `snacks.nvim`, `rainbow-delimiters.nvim`, `indent-blankline.nvim` |
| **Editor**            | `windwp/nvim-autopairs`, `nmac427/guess-indent.nvim`, `folke/todo-comments.nvim`      |
| **Fuzzy Finder**      | `nvim-telescope/telescope.nvim`, `telescope-fzf-native`, `telescope-ui-select`       |
| **Treesitter**        | `nvim-treesitter/nvim-treesitter`, `nvim-treesitter-textobjects`                   |
| **Markdown**          | `magnusriga/markdown-tools.nvim`                                                 |
| **Python Env Select** | `linux-cultist/venv-selector.nvim`                                               |
| **Themes**            | `rose-pine`, and others                                                          |

## Directory Structure

```
.
├── init.lua
├── lua/
│   ├── config/         # Core config (options, keymaps, etc)
│   ├── plugins/        # All plugin configs, grouped by category
│   │   ├── ai/
│   │   ├── dap/
│   │   ├── editor/
│   │   ├── git/
│   │   ├── lsp/
│   │   ├── markdown-tools.lua
│   │   ├── snacks.lua
│   │   ├── telescope.lua
│   │   ├── theme/
│   │   ├── treesitter/
│   │   └── ui/
│   └── ...
├── lazy-lock.json
└── ...
```

## Getting Started

1. Clone this repo into your Neovim config directory.
2. Open Neovim and run `:Lazy sync` to install plugins.
3. Explore the `lua/plugins/` directory to customize features.

---
