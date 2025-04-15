local function compile_latex(engine)
    return function()
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.expand("%:p:h")
        local base = vim.fn.expand("%:r")
        local pdf = base .. ".pdf"

        -- Save file if modified
        vim.cmd("update")

        -- Compile with error handling
        local cmd = string.format(
            '%s -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape -output-directory="%s" "%s"',
            engine,
            dir,
            file
        )

        -- Run compilation
        local result = vim.fn.system(cmd)
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_err_writeln("Compilation failed")
            print(result)
            return
        end

        -- Open PDF with default viewer
        if vim.fn.has("win32") == 1 then
            vim.fn.jobstart({ "cmd", "/c", "start", pdf }, { detach = true })
        else
            vim.fn.jobstart({ "xdg-open", pdf }, { detach = true })
        end
    end
end

vim.api.nvim_create_user_command("Pdflatex", compile_latex("pdflatex"), {})
vim.api.nvim_create_user_command("Xelatex", compile_latex("xelatex"), {})
vim.api.nvim_create_user_command("Lualatex", compile_latex("lualatex"), {})
