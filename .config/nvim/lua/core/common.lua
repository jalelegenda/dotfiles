return {
    map = vim.keymap.set,
    opts = { noremap = true, silent = true },
    set_desc = function(opts, props)
        opts.desc = props.desc
        if props.icon ~= nil then
            opts.icon = props.icon
        end
        return opts
    end,
}
