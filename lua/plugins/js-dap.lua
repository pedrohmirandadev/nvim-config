return {
  "mxsdev/nvim-dap-vscode-js",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-vscode-js").setup({
      node_path = os.getenv("HOME") .. "/.nvm/versions/node/v22.14.0/bin/node",
      debugger_path = os.getenv("HOME") .. "/.config/nvim/adapters/vscode-js-debug",
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })
  end,
}

