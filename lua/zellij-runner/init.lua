local core = require('zellij-runner.core')
local config = require('zellij-runner.config')

local function setup(opts)
  config.setup(opts)
  vim.api.nvim_create_user_command('ZellijRun', core.run_command, {})
end

return {
  setup = setup,
  run = core.run_command,
}
