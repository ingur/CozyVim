local config_dir = vim.fn.stdpath("config")
local uv = vim.loop

local function run_job(opts, callback)
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()

    if not stdout or not stderr then
        return
    end

    opts.stdio = { nil, stdout, stderr }

    opts.data = opts.data or {}
    opts.data.stdout = {}
    opts.data.stderr = {}

    local handle
    handle = uv.spawn(opts[1], opts, function(code)
        if handle then handle:close() end
        stdout:close()
        stderr:close()
        callback(code, opts.data)
    end)

    uv.read_start(stdout, function(_, data)
        if data then table.insert(opts.data.stdout, data) end
    end)
    uv.read_start(stderr, function(_, data)
        if data then table.insert(opts.data.stderr, data) end
    end)
end

local function pull_updates()
    run_job(
        {
            "git",
            args = { "pull", "--rebase", "--autostash" },
            cwd = config_dir
        },
        function(code, _)
            if code ~= 0 then
                vim.notify("Error Updating CozyVim, try pulling manually", 'error')
                return
            end
            vim.notify('CozyVim has been updated to the latest version!', 'info')
        end
    )
end

local function fetch_updates()
    run_job(
        {
            "git",
            args = { "fetch", "--dry-run" },
            cwd = config_dir
        },
        function(code, data)
            if code ~= 0 or #data.stderr == 0 then
                return
            end

            local msg = "A new version of CozyVim is available!" .. (cozyvim.auto_update and "" or " (via :CozyUpdate)")
            vim.notify(msg, "info")

            if cozyvim.auto_update then
                vim.notify("Downloading the latest version of CozyVim...", "info")
                pull_updates()
            end
        end
    )
end

vim.api.nvim_create_user_command("CozyUpdate", function(_)
    vim.notify("Downloading the latest version of CozyVim...", "info")
    pull_updates()
end, { bang = true, desc = "Update CozyVim", nargs = 0, })

fetch_updates()
