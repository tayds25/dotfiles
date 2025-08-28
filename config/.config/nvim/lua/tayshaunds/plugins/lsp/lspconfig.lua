return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        -- Import cmp-nvim-lsp plugin for enhanced capabilities
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        -- LSP attach function with keybinds
        vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)

            -- Buffer local mappings
            local opts = { buffer = ev.buf, silent = true }

            -- Navigation
            opts.desc = "Show LSP references"
            keymap.set("n", "gR", function() require("snacks").picker.lsp_references() end, opts)

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", function() require("snacks").picker.lsp_definitions() end, opts)

            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", function() require("snacks").picker.lsp_implementations() end, opts)

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", function() require("snacks").picker.lsp_type_definitions() end, opts)

            -- Actions
            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", function()
                vim.lsp.buf.code_action()
            end, opts)

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            -- Diagnostics
            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", function() require("snacks").picker.diagnostics() end, opts)

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", function()
                vim.diagnostic.open_float({
                    border = "rounded",
                    source = "always",
                    prefix = " ",
                    scope = "line",
                })
            end, opts)

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

            -- Documentation
            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts)

            opts.desc = "Show signature help"
            keymap.set("n", "<leader>rh", vim.lsp.buf.signature_help, opts)

            -- Workspace
            opts.desc = "Show LSP workspace symbols"
            keymap.set("n", "<leader>ls", function() require("snacks").picker.lsp_symbols() end, opts)

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end,
        })

        -- Enhanced capabilities for autocompletion
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Enhanced diagnostic configuration
        vim.diagnostic.config({
        virtual_text = {
            prefix = "●", -- Could be '■', '▎', 'x'
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
        })

        -- Custom diagnostic signs
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- Configure LSP servers with enhanced settings

        -- Lua Language Server
        vim.lsp.enable('lua_ls', {
        capabilities = capabilities,
        settings = {
            Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            completion = {
                callSnippet = "Replace",
            },
            telemetry = {
                enable = false,
            },
            },
        },
        })

        -- Python
        vim.lsp.enable('pyright', {
        capabilities = capabilities,
        settings = {
            python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
            },
            },
        },
        })

        -- TypeScript/JavaScript
        vim.lsp.enable('ts_ls', {
        capabilities = capabilities,
        init_options = {
            preferences = {
            disableSuggestions = true,
            },
        },
        })

        -- Enhanced TypeScript (vtsls)
        vim.lsp.enable('vtsls', {
        capabilities = capabilities,
        })

        -- HTML
        vim.lsp.enable('html', {
        capabilities = capabilities,
        filetypes = { "html", "templ" },
        })

        -- CSS
        vim.lsp.enable('cssls', {
        capabilities = capabilities,
        settings = {
            css = {
            validate = true,
            lint = {
                unknownAtRules = "ignore",
            },
            },
            scss = {
            validate = true,
            lint = {
                unknownAtRules = "ignore",
            },
            },
            less = {
            validate = true,
            lint = {
                unknownAtRules = "ignore",
            },
            },
        },
        })

        -- Tailwind CSS
        vim.lsp.enable('tailwindcss', {
        capabilities = capabilities,
        settings = {
            tailwindCSS = {
            experimental = {
                classRegex = {
                "tw`([^`]*)",
                'tw="([^"]*)',
                'tw={"([^"}]*)',
                "tw\\.\\w+`([^`]*)",
                "tw\\(.*?\\)`([^`]*)",
                },
            },
            },
        },
        })

        -- Emmet
        vim.lsp.enable('emmet_ls', {
        capabilities = capabilities,
        filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "svelte"
        },
        })

        -- Bash
        vim.lsp.enable('bashls', {
        capabilities = capabilities,
        })

        -- JSON
        vim.lsp.enable('jsonls', {
        capabilities = capabilities,
        settings = {
            json = {
            validate = { enable = true },
            },
        },
        })

        -- YAML
        vim.lsp.enable('yamlls', {
        capabilities = capabilities,
        settings = {
            yaml = {
            keyOrdering = false,
            },
        },
        })

        -- GraphQL
        vim.lsp.enable('graphql', {
        capabilities = capabilities,
        filetypes = { "graphql", "gql", "svelte", "astro", "vue" },
        })

        -- Markdown
        vim.lsp.enable('marksman', {
        capabilities = capabilities,
        })

        -- Prisma
        vim.lsp.enable('prisma', {
        capabilities = capabilities,
        })

        -- Svelte
        vim.lsp.enable('svelte', {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
            })
        end,
        })

        -- ESLint
        vim.lsp.enable('eslint', {
        capabilities = capabilities,
        settings = {
            codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine"
            },
            showDocumentation = {
                enable = true
            }
            },
            codeActionOnSave = {
            enable = false,
            mode = "all"
            },
            experimental = {
            useFlatConfig = false
            },
            format = true,
            nodePath = "",
            onIgnoredFiles = "off",
            problems = {
            shortenToSingleLine = false
            },
            quiet = false,
            rulesCustomizations = {},
            run = "onType",
            useESLintClass = false,
            validate = "on",
            workingDirectory = {
            mode = "location"
            }
        },
        })
    end,
}
