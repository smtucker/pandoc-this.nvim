local M = {}

local default_config = {
  pandoc_path = 'pandoc',
  open_cmd_path = 'xdg-open',
  defaults = {
    output_type = 'docx',
    args = { '--standalone' },
  },
}

local config = vim.tbl_deep_extend('force', default_config, {})

local Job = require('plenary.job')

local function remove_frontmatter(text)
  return text:gsub([[^---\n.-\n---\n]], '')
end

local function combine_tables(t1, t2)
  local result = {}
  for _, v in ipairs(t1) do
    table.insert(result, v)
  end
  for _, v in ipairs(t2) do
    table.insert(result, v)
  end
  return result
end

local function create_temp_file(content)
  local tmpfile = os.tmpname()
  local file = io.open(tmpfile, 'w')
  file:write(content)
  file:close()
  return tmpfile
end

local function open_file(filepath)
  Job:new({ command = config.open_cmd_path, args = { filepath } }):start()
end

local function run_pandoc(input_file, output_file, output_type)
  local args = combine_tables(config.defaults.args, {
    '-f',
    'markdown',
    '-t',
    output_type,
    '-o',
    output_file,
    input_file,
  })

  Job:new({
    command = config.pandoc_path,
    args = args,
    on_exit = function(_, exit_code)
      os.remove(input_file)
      if exit_code == 0 or exit_code == nil then
        open_file(output_file)
      else
        vim.api.nvim_err_writeln('Pandoc conversion failed with exit code: ' .. tostring(exit_code))
      end
    end,
  }):start()
end

function M.current_buffer(opts)
  local current_buffer = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false)
  local text = table.concat(lines, '\n')

  text = remove_frontmatter(text)

  local input_tmpfile = create_temp_file(text)
  local output_type = opts.fargs[1] or config.defaults.output_type
  local output_tmpfile = os.tmpname() .. '.' .. output_type

  run_pandoc(input_tmpfile, output_tmpfile, output_type)
end

function M.setup(user_config)
  config = vim.tbl_deep_extend('force', config, user_config or {})

  vim.api.nvim_create_user_command('PandocThis', M.current_buffer, { nargs = '*' })
end

return M
