-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- if you want to treat warnings as errors add this flag to you commad: -Werror
vim.api.nvim_create_user_command("RunCpp", function()
    -- Ensure the Makefile exists in the current directory
    local makefile = vim.fn.getcwd() .. "/Makefile"
    if vim.fn.filereadable(makefile) == 0 then
        vim.notify("Makefile not found in the current directory!", vim.log.levels.ERROR)
        return
    end

    -- Get the current file name (e.g., main.cpp)
    -- local file = vim.fn.expand("%:t") -- Just the file name, not the full path
    local output = vim.fn.expand("%:t:r") -- File name without extension (e.g., main)

    -- Run `make` to build in debug mode
    vim.cmd("!make")

    -- Run the compiled executable
    -- vim.cmd("!./bin/" .. output)
end, {})

vim.api.nvim_create_user_command("RunCppRelease", function()
    -- Ensure the Makefile exists in the current directory
    local makefile = vim.fn.getcwd() .. "/Makefile"
    if vim.fn.filereadable(makefile) == 0 then
        vim.notify("Makefile not found in the current directory!", vim.log.levels.ERROR)
        return
    end

    -- Get the current file name (e.g., main.cpp)
    local file = vim.fn.expand("%:t") -- Just the file name, not the full path
    local output = vim.fn.expand("%:t:r") -- File name without extension (e.g., main)

    -- Run `make mode=release` to build in release mode
    vim.cmd("!make mode=release")

    -- Run the compiled executable
    -- vim.cmd("!./bin/" .. output)
end, {})
