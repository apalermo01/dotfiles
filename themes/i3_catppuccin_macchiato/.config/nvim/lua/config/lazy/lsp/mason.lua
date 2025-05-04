return {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
        require("mason").setup({
            PATH = IS_NIXOS and 'skip' or 'prepend',
        })
    end,
}
