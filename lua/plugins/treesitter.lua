local parsers = {
  "c",
  "cpp",
  "lua",
  "html",
  "go",
  "css",
  "json",
  "php",
  "rust",
  "slint",
  "vue",
  "javascript",
  "typescript",
  "java",
  "toml",
  "yaml",
  "ini",
  "scss",
  "gitcommit",
  "gitignore",
  "sql",
  "vim",
  "python",
  "markdown",
  "markdown_inline",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf = args.buf
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then return end
        pcall(vim.treesitter.start, buf)
      end,
    })
  end,
}
