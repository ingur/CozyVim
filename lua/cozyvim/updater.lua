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

local dir = vim.fn.stdpath("config")

run_job(
    {
        "git",
        args = { "fetch", "--dry-run" },
        cwd = dir
    },
    function(c1, d1)
        if c1 ~= 0 or #d1.stderr == 0 then
            return
        end
        run_job(
            {
                "git",
                args = { "pull" },
                cwd = dir
            },
            function(c2, d2)
                print(c2, vim.inspect(d2))
            end
        )
    end
)
