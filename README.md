# zellij-runner.nvim

## 简述

使用 `:ZellijRun` 来执行项目或者文件

支持类型

- Python 文件 -> python3 xxx.py
- Javascript 项目 -> npm run dev
- Lua 文件 -> lua xxx.lua
- Rust 项目 -> cargo run

## 安装

```lua
return {
  "kikuBruce/zellij-runner.nvim",
  config = function()
    require("zellij-runner").setup {
      commands = {
        python = "zellij run --cwd ${cwd} -c -- python3 ${file}",
      },
    }
  end,
}
```
