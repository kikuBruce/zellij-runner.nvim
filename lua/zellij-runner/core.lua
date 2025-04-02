local M = {}

-- 查找项目根目录
function M.find_project_root()
  local current_file = vim.fn.expand('%:p')
  if current_file == '' then
    return vim.fn.getcwd()
  end

  local markers = { '.git', 'package.json', 'Makefile', 'pyproject.toml' }
  local path = vim.fn.fnamemodify(current_file, ':h')
  local last_path = ''

  while path ~= last_path do
    for _, marker in ipairs(markers) do
      if vim.fn.filereadable(path .. '/' .. marker) == 1 then
        return path
      end
    end
    last_path = path
    path = vim.fn.fnamemodify(path, ':h')
  end

  return vim.fn.getcwd()
end

-- 执行 Zellij 命令
function M.run_command()
  local config = require('zellij-runner.config')
  local project_root = M.find_project_root()
  local filetype = vim.bo.filetype
  local current_file = vim.fn.expand('%:p')

  -- 获取用户配置的命令或使用默认
  local cmd = config.commands[filetype] or config.default_command
  if type(cmd) == 'function' then
    cmd = cmd(project_root, current_file)
  end

  -- 替换模板变量
  cmd = cmd:gsub('${cwd}', vim.fn.shellescape(project_root))
           :gsub('${file}', vim.fn.shellescape(current_file))
           :gsub('${filename}', vim.fn.shellescape(vim.fn.expand('%:t')))

  -- 执行命令
  if config.silent then
    vim.cmd('silent !' .. cmd)
  else
    vim.cmd('!' .. cmd)
  end

  if config.notify then
    vim.notify('Executed: ' .. cmd, vim.log.levels.INFO)
  end
end

return M
