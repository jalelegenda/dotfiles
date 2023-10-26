local noice = require 'noice'
require 'lualine'.setup {
    sections = {
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 4,
            },
            {
                noice.api.statusline.mode.get,
                cond = noice.api.statusline.mode.has,
                color = { fg = "#ff9e64" },
            },
        },
    },
    -- options = {
    --     theme = 'tokyonight',
    -- },
}
