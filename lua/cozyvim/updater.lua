-- local job = require("plenary.job")
--
-- job:new({
--     command = "git",
--     args = { "fetch", "--dry-run" },
--     cwd = vim.fn.stdpath("config"),
--     on_stderr = function(_, data)
--         -- git reports progress to error stream
--         if data == nil then return end
--         job:new({
--             command = "git",
--             args = { "pull" },
--             cwd = vim.fn.stdpath("config"),
--         }):start()
--     end,
-- }):start()
--
-- print("hi!")


-- local function run_job(cmd, opts, callback)
--     local stdout, stderr = uv.new_pipe(), uv.new_pipe()
--     local handle
--     opts.stdio = { nil, stdout, stderr }
--     handle = uv.spawn(cmd, opts, function(code)
--         callback(code)
--         handle:close()
--         stdout:close()
--         stderr:close()
--     end)
--     print('hi')
--     opts.data.stdout = opts.data.stdout or {}
--     opts.data.stderr = opts.data.stderr or {}
--     uv.read_start(stdout, function(_, chunk)
--         if chunk then
--             table.insert(opts.data.stdout, chunk)
--         end
--     end)
--     uv.read_start(stderr, function(_, chunk)
--         if chunk then table.insert(opts.data.stderr, chunk) end
--     end)
-- end
-- local data_xd = {}
-- local function run_job(cmd, opts, callback)
--     local handle
--     local stdout = uv.new_pipe()
--     local stderr = uv.new_pipe()
--     opts.stdio = { nil, stdout, stderr }
--     handle = vim.loop.spawn(cmd, {
--         args = opts.args,
--         stdio = opts.stdio,
--     },
--         function(code)
--             handle:close()
--             stdout:close()
--             stderr:close()
--             callback(code)
--         end
--     )
--     uv.read_start(stdout, function(err, data)
--         if err then
--             error(err)
--         end
--
--         if data then
--             print(data)
--             table.insert(data_xd, data)
--         end
--     end)
--     uv.read_start(stderr, function(err, data)
--         if err then
--             error(err)
--         end
--
--         if data then
--             print(data)
--         end
--     end)
-- end
--
-- local data = {
--     stdout = {},
--     stderr = {},
-- }

local uv = vim.loop

local function run_job(cmd, opts, callback)
    local handle
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()
    opts.stdio = { nil, stdout, stderr }
    opts.data = opts.data or { stdout = {}, stderr = {} }
    handle = uv.spawn(cmd, opts,
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

-- run_job("echo", { args = { "foo" } }, function(code, data)
--     print(code, vim.inspect(data))
--     if code == 0 then
--         run_job("echo", { args = { "bar" } }, function(code, data)
--             print(code, vim.inspect(data))
--             if code == 0 then
--                 run_job("echo", { args = { "baz" } }, function(code, data)
--                     print(code, vim.inspect(data))
--                 end)
--             end
--         end)
--     end
-- end)

local opts = {
    args = { "fetch", "--dry-run" },
    cwd = vim.fn.stdpath("config"),
}

run_job("git", opts, function(code, data)
    if code ~= 0 or #data.stderr == 0 then return end
    local opts = {
        args = { "pull" },
        cwd = vim.fn.stdpath("config"),
    }
    run_job("git", opts, function(code, data)
        print(code, vim.inspect(data))
    end)
end)

-- local stdout_pipe = uv.new_pipe()
-- local stderr_pipe = uv.new_pipe()
--
-- local handle;
-- local on_exit = function(status)
--     uv.close(handle)
-- end
--
-- local opts = {
--     args = { "status" },
--     cwd = vim.fn.stdpath("config"),
--     stdio = { nil, stdout_pipe, stderr_pipe },
-- }
--
-- handle = uv.spawn("git", opts, on_exit)
--
-- uv.read_start(stderr_pipe, function(err, data)
--     if err then
--         error(err)
--     end
--
--     if data then
--         print(data)
--     end
-- end)
--
-- uv.read_start(stdout_pipe, function(err, data)
--     if err then
--         error(err)
--     end
--
--     if data then
--         print(data)
--     end
-- end)
--
-- print("hi")
