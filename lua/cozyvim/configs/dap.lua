local mason_dap = require("mason-nvim-dap")
local dap = require("dap")

local signs = {
    DapBreakpoint = "DiagnosticSignError",
    DapBreakpointRejected = "DiagnosticSignError",
    DapStopped = "DiagnosticSignWarn",
}

for sign, hl in pairs(signs) do
    vim.fn.sign_define(sign, {
        text = cozyvim.icons.dap[sign],
        texthl = hl,
        linehl = "",
        numhl = "",
    })
end

mason_dap.setup(cozyvim.dap.opts)
mason_dap.setup_handlers({})

for adapter, config in pairs(cozyvim.dap.adapters) do
    dap.adapters[adapter] = config
end

for key, config in pairs(cozyvim.dap.configurations) do
    dap.configurations[key] = config
end

-- NOTE: this only runs once, not on a per cwd basis
require("dap.ext.vscode").load_launchjs(cozyvim.dap.launch_path, {})

local dapui_available, dapui = pcall(require, "dapui")
if not dapui_available then return end

if cozyvim.dap.auto_open then
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
end

if cozyvim.dap.auto_close then
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end
