# pandoc-this.nvim

**Convert your Neovim buffers to various formats with the power of pandoc!**

**🚧 Work in Progress! 🚧**

This plugin is in its early stages of development. It currently provides a basic
proof-of-concept for converting Markdown buffers to docx format. However, we
have big plans for the future!

**Planned Features:**

- **Format Flexibility:**
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
  - Asynchronous execution to avoid blocking Neovim.
  - Customizable keybindings for frequently used conversions.

**Current Functionality:**

- Convert the current buffer (assumed to be Markdown) to a docx file.
- Open the converted docx file in your default application.

**Installation:**

- Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

  _(Instructions to be added soon)_

**Usage:**

- Currently, there's a basic command to trigger the conversion. This will be
  expanded upon in future releases.

**Contributing:**

- Contributions are welcome! Feel free to open issues or submit pull requests.

**License:**

- [MIT License](LICENSE)
