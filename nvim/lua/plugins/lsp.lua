-- You can modify OR disable any plugin/option regarding Lsp servers.

return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                cpp = { "clang_format" },
                c = { "clang_format" },
                objc = { "clang_format" },
            },
            formatters = {
                clang_format = {
                    command = "clang-format",
                    args = {
                        "-style={BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 0}",
                        "-assume-filename",
                        "{filename}", -- Changed from $FILENAME to {filename}
                    },
                },
            },
        },
    },
}
