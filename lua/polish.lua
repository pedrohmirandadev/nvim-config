-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
local dap = require "dap"
require("nvim-dap-virtual-text").setup {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  all_frames = false,
  commented = false,
}

require("dap-vscode-js").setup({
  debugger_path =  os.getenv "HOME" .. "/.config/nvim/adapters/vscode-js-debug",
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    }}
end

-- Do not forget to run 'npm install' and 'npm run build' inside the adapters/vscode-php-debug folder
dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { os.getenv "HOME" .. "/.config/nvim/adapters/vscode-php-debug/out/phpDebug.js" },
}

vim.opt.clipboard = "unnamedplus"
if vim.fn.has "wsl" == 1 then
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("Yank", { clear = true }),
    callback = function() vim.fn.system("clip.exe", vim.fn.getreg '"') end,
  })
end

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.g.codeium_disable_bindings = 1

vim.keymap.set("i", "<C-Enter>", function()

return vim.fn["codeium#Accept"]()

end, { expr = true, silent = true, desc = "Codeium: Accept" })

vim.keymap.set("n", "<leader>k", "<cmd>LazyDocker<CR>", { desc = "Toggle LazyDocker", noremap = true, silent = true })

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Toggle Lazy", noremap = true, silent = true })


