local job = require("plenary.job")

job:new({
    command = "git",
    args = { "fetch", "--dry-run" },
    cwd = vim.fn.stdpath("config"),
    on_stderr = function(_, data)
        -- git reports progress to error stream
        if data == nil then return end
        job:new({
            command = "git",
            args = { "pull" },
            cwd = vim.fn.stdpath("config"),
        }):start()
    end,
}):start()

print("hi!")
