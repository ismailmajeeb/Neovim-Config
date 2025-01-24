-- In this file I overridden some of lualine plugin configurations and add mine.
local colors = {
    bg = "#1a1b2b", -- Choose one of these colors: 1e1a2f, 13142a, 1a1a24
    fg = "#a0a8cd",
    blue = "#7a88cf",
    cyan = "#008080",
    green = "#6dce87",
    yellow = "#ECBE7B",
    orange = "#d7a087",
    purple = "#b399ef",
    magenta = "#d091e4",
    red = "#e05a5a",
    section_bg = "#1e1a2f",
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = {
                        normal = {
                            a = { fg = colors.section_bg, bg = colors.blue, gui = "bold" },
                            b = { fg = colors.fg, bg = colors.section_bg },
                            c = { fg = colors.fg, bg = colors.bg },
                        },
                        insert = { a = { fg = colors.bg, bg = colors.green } },
                        visual = { a = { fg = colors.bg, bg = colors.purple } },
                        replace = { a = { fg = colors.bg, bg = colors.red } },
                        command = { a = { fg = colors.bg, bg = colors.yellow } },
                    },
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    always_divide_middle = true,
                    globalstatus = true, -- Changed to true for proper persistence
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    },
                },
                sections = {
                    lualine_a = {
                        "mode",
                        {
                            function()
                                return "  "
                            end,
                            color = function()
                                local mode_color = {
                                    n = colors.blue,
                                    i = colors.green,
                                    v = colors.purple,
                                    c = colors.yellow,
                                    [""] = colors.purple,
                                    V = colors.purple,
                                    R = colors.red,
                                    t = colors.red,
                                }
                                return { bg = mode_color[vim.fn.mode()] }
                            end,
                            separator = { left = "", right = "" },
                            padding = { right = 0 },
                        },
                    },
                    lualine_b = {
                        {
                            "filesize",
                            cond = conditions.buffer_not_empty,
                            color = { fg = colors.magenta, gui = "bold" },
                        },
                        {
                            "filename",
                            cond = conditions.buffer_not_empty,
                            color = { fg = colors.magenta, gui = "bold" },
                        },
                        {
                            "%l:%c %p%%|%L",
                            color = { fg = colors.magenta, gui = "bold" },
                        },
                    },
                    lualine_c = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " " },
                            colors = {
                                error = colors.red,
                                warn = colors.yellow,
                                info = colors.cyan,
                            },
                        },
                        {
                            "diff",
                            symbols = { added = " ", modified = "柳 ", removed = " " },
                            diff_color = {
                                added = { fg = colors.green },
                                modified = { fg = colors.orange },
                                removed = { fg = colors.red },
                            },
                        },
                    },
                    lualine_x = {
                        {
                            function()
                                local msg = "No Active Lsp"
                                local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                                local clients = vim.lsp.get_clients()
                                if next(clients) == nil then
                                    return msg
                                end
                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return client.name
                                    end
                                end
                                return msg
                            end,
                            icon = "  LSP:",
                            color = { fg = colors.magenta, gui = "bold" },
                        },
                        { "filetype", colored = true },
                        { "encoding", fmt = string.upper, color = { fg = colors.cyan } },
                        { "fileformat", fmt = string.upper, color = { fg = colors.green } },
                    },
                    lualine_y = {
                        {
                            "branch",
                            icon = "",
                            color = { fg = colors.orange, gui = "bold" },
                            separator = { left = "", right = "" },
                        },
                    },
                    lualine_z = {
                        {
                            "diff",
                            symbols = { added = " ", modified = "柳 ", removed = " " },
                            diff_color = {
                                added = { fg = colors.green },
                                modified = { fg = colors.orange },
                                removed = { fg = colors.red },
                            },
                        },
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end,
    },
}
