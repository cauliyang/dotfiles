local M = {}

M.config = function()
    if vim.g.neovide then
        vim.g.neovide_scale_factor = 1.0
        vim.g.neovide_hide_mouse_when_typing = true
        vim.g.neovide_input_macos_alt_is_meta = true
        vim.g.neovide_hide_mouse_when_typing = false
        vim.g.neovide_refresh_rate = 60
        vim.g.neovide_refresh_rate_idle = 5
        vim.g.neovide_no_idle = true
        vim.g.neovide_confirm_quit = true
        vim.g.neovide_input_use_logo = true

        vim.g.neovide_cursor_antialiasing = true
        vim.g.neovide_cursor_animate_in_insert_mode = true
        vim.g.neovide_cursor_vfx_mode = "pixiedust"
        vim.g.neovide_cursor_vfx_particle_speed = 20.0

        vim.g.neovide_padding_top = 0
        vim.g.neovide_padding_bottom = 0
        vim.g.neovide_padding_right = 0
        vim.g.neovide_padding_left = 0

        vim.g.neovide_transparency = 0.65
        vim.g.transparency = 0.4

        -- Helper function for transparency formatting
        local alpha = function()
            return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
        end

        vim.g.neovide_background_color = "#0f1117" .. alpha()

        local fonts = {
            iosevka = "Iosevka:h13",
            victor = "Victor Mono:h13",
            ia = "iA Writer Mono S:h13",
            cascadia = "Cascadia Code:h13",
            cascadiam = "Cascadia Mono:h13",
            fira = "Fira Code:h13",
            firam = "Fira Mono:h13",
        }

        vim.opt.guifont = fonts.ia

        vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
        vim.keymap.set("v", "<D-c>", '"+y') -- Copy
        vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
        vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
        vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
        vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
    end
end

return M
