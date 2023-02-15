local uv = vim.loop

local function run_job(opts, callback)
    local handle
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()
    opts.stdio = { nil, stdout, stderr }
    opts.data = opts.data or { stdout = {}, stderr = {} }
    handle = uv.spawn(opts[1], opts,
        function(code)
            handle:close()
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

local config_dir = vim.fn.stdpath("config")

local function pull_updates()
    run_job(
        {
            "git",
            args = { "pull" },
            cwd = config_dir
        },
        function(code, _)
            if code ~= 0 then
                vim.notify("Error Updating CozyVim", 'error')
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

            vim.notify('A new version of CozyVim is available!', 'info')
            vim.notify('Downloading the latest version of CozyVim...', 'info')

            pull_updates()
        end
    )
end

fetch_updates()
