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
    require_plugins = function(excludes)
        local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"
        local handle = vim.loop.fs_scandir(plugins_dir)
        if not handle then
            return {}
        end

        local plugins = {}
        while true do
            local name, typ = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end
            local plugin_name = name:gsub("%.lua$", "")
            local is_excluded = false
            for _, excluded_plugin in ipairs(excludes) do
                if excluded_plugin == plugin_name then
                    is_excluded = true
                    break
                end
            end
            -- Skip non-Lua files and the init.lua file
            if typ == "file" and name:match("%.lua$") and name ~= "init.lua" and not is_excluded then
                table.insert(plugins, require("plugins." .. plugin_name))
            end
        end

        return plugins
    end,
}
