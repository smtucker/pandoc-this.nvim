local M = {}

local Job = require('plenary.job')

local function remove_frontmatter(text)
  return text:gsub([[^---\n.-\n---\n]], '')
end

function M.current_buffer()
  local current_buffer = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false)
  local text = table.concat(lines, '\n')

  text = remove_frontmatter(text)

  local input_tmpfile = os.tmpname()
  local output_tmpfile = os.tmpname() .. '.docx'

  local file = io.open(input_tmpfile, 'w')
  file:write(text)
  file:close()

  local pandoc = Job:new({
    command = 'pandoc',
    args = { '-f', 'markdown', '-t', 'docx', '-o', output_tmpfile, input_tmpfile },
    on_exit = function(j, exit_code)
      os.remove(input_tmpfile) -- Clean up the temporary input file.

      if exit_code == 0 or exit_code == nil then
        vim.schedule(function()
          vim.api.nvim_command('!xdg-open ' .. output_tmpfile)
        end)
      else
        vim.api.nvim_err_writeln('Pandoc conversion failed with exit code: ' .. exit_code)
      end
    end,
  })

  pandoc:start()
end

return M
