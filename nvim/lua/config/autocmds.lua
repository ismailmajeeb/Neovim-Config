-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function compile_latex(engine)
    return function()
        -- Get paths (convert backslashes to forward slashes for compatibility)
        local file = vim.fn.expand("%:p"):gsub("\\", "/")
        local dir = vim.fn.expand("%:p:h"):gsub("\\", "/")
        local base = vim.fn.expand("%:r"):gsub("\\", "/")
        local pdf = base .. ".pdf"

        -- Save file
        vim.cmd("update")

        -- Windows-specific quoting
        local quoted_file = '"' .. file .. '"'
        local quoted_dir = '"' .. dir .. '"'

        -- Compilation command
        local cmd = string.format(
            "cd /D %s && %s -interaction=nonstopmode -synctex=1 -shell-escape %s",
            quoted_dir,
            engine,
            quoted_file
        )

        -- Execute
        local result = vim.fn.system(cmd)
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_err_writeln("Compilation failed")
            print(result)
            return
        end

        -- Open PDF with default viewer
        if vim.fn.has("win32") == 1 then
            vim.fn.jobstart({ "cmd", "/C", "start", "", pdf }, { detach = true, cwd = dir })
        else
            vim.fn.jobstart({ "xdg-open", pdf }, { detach = true })
        end
    end
end

vim.api.nvim_create_user_command("Pdflatex", compile_latex("pdflatex"), {})
vim.api.nvim_create_user_command("Xelatex", compile_latex("xelatex"), {})
vim.api.nvim_create_user_command("Lualatex", compile_latex("lualatex"), {})
-------------------------------------------
-- Loading Default Template
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.tex",
    callback = function(args)
        -- Path to your template (adjust as needed)
        local template_path = vim.fn.expand("E:/LaTeX-Docs/Templates/Default Template.tex")

        -- Only insert template if file is empty (new file)
        if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
            local lines = vim.fn.readfile(template_path)
            vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
        end
    end,
})

-------------------------------------------

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
