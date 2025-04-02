local M = {}

M.defaults = {
  silent = true,
  notify = true,
  commands = {
    python = 'zellij run --cwd ${cwd} -- python3 ${file}',
    javascript = 'zellij run --cwd ${cwd} -c -- npm run dev',
    lua = 'zellij run --cwd ${cwd} -- lua ${file}',
    rust = function(root, _)
      return 'zellij run --cwd ' .. vim.fn.shellescape(root) .. ' -- cargo run'
    end,
  },
  default_command = 'echo "No command defined for filetype: ${filetype}"',
}

function M.setup(opts)
  M.settings = vim.tbl_deep_extend('force', M.defaults, opts or {})
end

-- 提供配置访问接口
setmetatable(M, {
  __index = function(_, key)
    return M.settings and M.settings[key] or M.defaults[key]
  end
})

return M
