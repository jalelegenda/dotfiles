return {
    "kndndrj/nvim-dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    build = function()
        -- Install tries to automatically detect the install method.
        -- if it fails, try calling it with one of these parameters:
        --    "curl", "wget", "bitsadmin", "go"
        require("dbee").install()
    end,
    config = function()
        local dbee = require("dbee")
        dbee.setup(map("n", "<leader>-", dbee.open(), set_desc(common.opts, "Open Dbee UI")))
    end,
}
