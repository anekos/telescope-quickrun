return {
  configs = function ()
    return vim.tbl_deep_extend('force', vim.g['quickrun#default_config'], vim.g.quickrun_config)
  end
}
