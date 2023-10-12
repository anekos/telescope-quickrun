local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local state = require('telescope.actions.state')

local plugin = require('telescope._extensions.quickrun.plugin')
local previewer = require('telescope._extensions.quickrun.previewer')

return function (opts)
  opts = opts or {}

  local results = {}
  local configs = plugin.configs()
  for name, _ in pairs(configs) do
    if configs[name] ~= nil then
      table.insert(results, name)
    end
  end

  pickers.new(opts, {
    prompt_title = 'quickrun',
    finder = finders.new_table {
      results = results,
      entry_maker = function (name)
        return {
          value = name,
          display = name,
          ordinal = name,
        }
      end
    },
    sorter = sorters.fuzzy_with_index_bias(),
    previewer = previewer,
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = state.get_selected_entry()
        vim.cmd('QuickRun ' .. selection.value)
      end)
      return true
    end,
  }):find()
end
