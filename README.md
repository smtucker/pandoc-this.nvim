# pandoc-this.nvim

**Convert your Neovim buffers to various formats with the power of pandoc!**

**🚧 Work in Progress! 🚧**

This plugin is in its early stages of development. It currently provides a basic
proof-of-concept for converting Markdown buffers to docx format. However, we
have big plans for the future!

**Planned Features:**

- **Input Format Flexibility:**
  - Support for various input formats (not just Markdown).
  - Automatic input format detection.
- **Output Choice:**
  - Easy selection of output formats (docx, html, pdf, epub, etc.).
  - Integration with a picker UI (like Telescope) for convenient format
    selection.
- **Pandoc Power:**
  - Ability to pass custom arguments to pandoc for precise control over
    conversion.
  - Support for pandoc templates and filters.
- **Seamless Integration:**
  - Option for in-place buffer conversion.
  - Customizable keybindings for frequently used conversions.

**Current Functionality:**

- Convert the current buffer (assumed to be Markdown) to a tmp file.
- Open the converted file in your default application.

**Installation and Configuration:**

- Using [lazy.nvim](https://github.com/folke/lazy.nvim):

  ```lua
  {
    "smtucker/pandoc-this.nvim",
    ft = "markdown",
    opts = { -- Defaults shown
      pandoc_path = 'pandoc',
      open_cmd_path = 'xdg-open', -- or 'start' for windows
      defaults = {
        output_type = 'docx',
        args = { '--standalone' }, -- Additional arguments to be passed to pandoc
      },
    },
  }
  ```

**Usage:**

- `:PandocThis [output type]`

  - Sends current buffer to pandoc to output to a temp file and open it.
    Optionally takes a output file type to override the default. e.g. 'html'

**Contributing:**

- Contributions are welcome! Feel free to open issues or submit pull requests.

**License:**

- [MIT License](LICENSE)
