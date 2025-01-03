-- [[ Install packer ]]
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
    -- Package manager
    use("wbthomason/packer.nvim")

    use({ -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            "j-hui/fidget.nvim",
        },
    })

    use({ -- Autocompletion
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-emoji",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    })

    use({ -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        run = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
    })

    use({ -- Additional text objects via treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    })

    -- Git related plugins
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("lewis6991/gitsigns.nvim")

    -- Misc
    use("w0ng/vim-hybrid") -- Colorscheme
    use("rebelot/kanagawa.nvim") -- Colorscheme
    use({ "catppuccin/nvim", as = "catppuccin" }) -- Colorscheme
    use("nvim-lualine/lualine.nvim") -- Fancier statusline
    use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
    use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
    use("akinsho/toggleterm.nvim") -- Terminal (with C-T)
    use("nvim-tree/nvim-web-devicons") -- Icons
    use("adelarsq/vim-matchit") -- Extended matching for %
    use("mhinz/vim-startify") -- Better startpage
    use("tpope/vim-abolish") -- Better search and replace
    use("tpope/vim-repeat") -- Repeat more commands with .
    use("tpope/vim-sensible") -- Sensible defaults
    use("tpope/vim-surround") -- Change surroundings like parenthesis
    use("vim-scripts/SearchComplete") -- Autocomplete for search input
    use("mhartington/formatter.nvim") -- Prettier, black, whitespace removal
    use("airblade/vim-rooter") -- Set cwd to project root
    use("ray-x/lsp_signature.nvim") -- Show signatures while typing
    use("nvim-telescope/telescope-ui-select.nvim") -- Use telescope as selector
    use("folke/todo-comments.nvim") -- Highlight TODO and others
    use("luukvbaal/stabilize.nvim") -- Prevent scrolling when splitting -- Prevent scrolling when splitting
    use("lewis6991/hover.nvim") -- Show signatures on hover
    use("chentoast/marks.nvim") -- Show marks in signcolumn
    use("dhruvasagar/vim-table-mode") -- For ASCII tables

    -- Telescope
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })
    use("nvim-telescope/telescope-project.nvim")
    use("nvim-telescope/telescope-file-browser.nvim")
    use("xiyaowong/telescope-emoji.nvim")

    -- Languages
    use("sophacles/vim-bundle-mako")
    use("yuezk/vim-js")
    use("chase/vim-ansible-yaml")
    use("hashivim/vim-terraform")
    use("leafgarland/typescript-vim")
    use("nelsyeung/twig.vim")
    use("jose-elias-alvarez/null-ls.nvim")
    use("simrat39/rust-tools.nvim")
    use("towolf/vim-helm")
    use("glench/vim-jinja2-syntax")

    if is_bootstrap then
        require("packer").sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print("==================================")
    print("    Plugins are being installed")
    print("    Wait until Packer completes,")
    print("       then restart nvim")
    print("==================================")
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | PackerCompile",
    group = packer_group,
    pattern = vim.fn.expand("$MYVIMRC"),
})

-- [[ Setting options ]]
vim.cmd.colorscheme("hybrid")

vim.o.completeopt = "menuone,noselect"
vim.o.formatoptions = "qjrn"
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.laststatus = 2
vim.o.mouse = "a"
vim.o.backup = false
vim.o.writebackup = false
vim.o.number = true
vim.o.secure = true
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.signcolumn = "number"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = true
vim.o.tabstop = 4
vim.o.textwidth = 80
vim.o.updatetime = 300
vim.o.wildignore = "*/tmp/*,*.so,*.swp,*.zip"
vim.o.inccommand = "split"

-- Allow copy paste in neovim/neovide
vim.keymap.set("", "<D-v>,", '"+p<CR>')
vim.keymap.set("!", "<D-v>,", '<C-R>+')
vim.keymap.set("t", "<D-v>,", '<C-R>+')

-- [[ Filetype maps ]]
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.mak",
    callback = function()
        vim.bo.filetype = "mako"
    end,
})

-- [[ Basic Keymaps ]]
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>,", ":noh<CR>", { desc = "[,] Remove search highlight" })
vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next, { desc = "[j] Jump to next error" })
vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev, { desc = "[k] Jump to previous error" })
vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").find_files()
end, { desc = "[C-p] Search files" })
vim.keymap.set("n", "<C-f>", function()
    require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "[C-g] Live grep" })
vim.keymap.set("n", "<C-g>", function()
    require("telescope.builtin").live_grep({ cwd = "." })
end, { desc = "[C-g] Live grep" })
vim.keymap.set("n", "<C-h>", function()
    require("telescope.builtin").live_grep({ cwd = "%:h" })
end, { desc = "[C-g] Live grep in current directory" })
vim.keymap.set("n", "<C-e>", function()
    require("telescope").extensions.file_browser.file_browser({ path = "%:h", grouped = true, hidden = true })
end, { desc = "[C-h] Live grep in current directory" })
vim.keymap.set("n", "<C-ü>", function()
    require("telescope").extensions.project.project()
end, { desc = "[C-ü] Open project browser" })
vim.keymap.set("n", "<leader>t", function()
    require("telescope.command").load_command()
end, { desc = "[<leader>t] Open [t]elescope" })
vim.keymap.set("n", "<leader>c", function()
    require("telescope.builtin").commands()
end, { desc = "[<leader>c] Show [c]ommands" })
vim.keymap.set("n", "<leader>a", function()
    vim.lsp.buf.code_action()
end, { desc = "[<leader>a] Show code [a]ctions" })
vim.keymap.set("n", "<leader>h", function()
    require('telescope').extensions.notify.notify()
end, { desc = "[<leader>h] Show message [h]istory" })
vim.keymap.set("n", "<leader>?", function()
    vim.lsp.buf.hover()
end, { desc = "[<leader>?] Show signature under cursor [?]" })
vim.keymap.set("n", "<C-d>", function()
    require("telescope.builtin").resume()
end, { desc = "[<C-d>] resume last picker" })

-- Use C-T to open up a floating terminal
require("toggleterm").setup({
    open_mapping = [[<c-t>]],
    direction = "float",
})

-- Set lualine as statusline
require("lualine").setup({
    options = {
        theme = "codedark",
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
        path = 1,
    },
})

-- Enable Comment.nvim
require("Comment").setup()

-- Gitsigns
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})

-- devicons
require("nvim-web-devicons").setup({
    default = true,
})

-- formatter
require("formatter").setup {
    filetype = {
        css = { require("formatter.filetypes.css").prettier },
        html = { require("formatter.filetypes.html").prettier },
        javascript = { require("formatter.filetypes.javascript").prettier },
        javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
        json = { require("formatter.filetypes.json").prettier },
        -- lua = { require("formatter.filetypes.lua").stylua },
        python = {
            require("formatter.filetypes.python").black,
            require("formatter.filetypes.python").isort,
        },
        sh = { require("formatter.filetypes.sh").shfmt },
        typescript = { require("formatter.filetypes.typescript").prettier },
        typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
        yaml = { require("formatter.filetypes.yaml").prettier },
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    command = "FormatWrite",
})

-- rooter (find project root)
vim.g.rooter_patterns = {"setup.py", "package.json", ".env"}

-- [[ Configure Telescope ]]
require("telescope").setup({
    defaults = {
        path_display = { truncate = 3 },
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    },
    extensions = {
        project = {
            base_dirs = {
                "~/src",
            },
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown { }
        },
    },
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    },
})

-- Enable telescope extensions
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "project")
pcall(require("telescope").load_extension, "file_browser")
pcall(require("telescope").load_extension, "emoji")

-- [[ Configure Treesitter ]]
require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "typescript",
        "vim", "regex", "bash", "markdown", "markdown_inline"},

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        },
    },
})

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>r", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = "Format current buffer with LSP" })
end

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Enable the following language servers
local servers = { "pyright", "ts_ls", "lua_ls", "helm_ls" },

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
    ensure_installed = servers,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- Turn on lsp status information
require("fidget").setup()

-- custom configuration for lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
        },
    },
})

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help"},
        { name = "buffer", keyword_length = 2 },
        { name = "nvim_lsp" },
        { name = "calc"},
        { name = "emoji"},
    },
})

-- lsp_signature
require"lsp_signature".setup({ max_width=120, })

-- show diagnostics in signcolumn
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- show diagnostics in hover window
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = 0,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- highlight TODO, BUG and other annotations in comments
require("todo-comments").setup { }

-- prevent code scrolling when opening splits
-- (will be upstreamed with splitkeep=screen in neovim 9)
require("stabilize").setup()

-- show signature on hover
require("hover").setup({
    init = function()
        require("hover.providers.lsp")
        require('hover.providers.man')
    end,
})

-- Show marks in signcolumn
require'marks'.setup {
  default_mappings = false,
  builtin_marks = { "." },
}

-- rust
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- vim: ts=2 sts=2 sw=2 et
