
local previewers = require('telescope.previewers')

local plugin = require('telescope._extensions.quickrun.plugin')

return previewers.new_buffer_previewer {
  title = 'Config',
  define_preview = function (self, entry, status)
    local name = entry.value
    local config = plugin.configs[name]

    local lines = {}

    if config == nil then
      table.insert(lines, 'No config')
    else
      for key, value in pairs(config) do
        table.insert(lines, key .. ':')
        table.insert(lines, '  ' .. vim.fn.json_encode(value))
      end
    end

    if #lines == 0 then
      table.insert(lines, 'Empty')
    end

    vim.api.nvim_buf_set_lines(
      self.state.bufnr,
      0,
      -1,
      false,
      lines
    )
  end
}
