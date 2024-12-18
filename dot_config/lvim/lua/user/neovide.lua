local M = {}

M.config = function()
    if vim.g.neovide then
        vim.g.neovide_scale_factor = 1.0
        vim.g.neovide_hide_mouse_when_typing = true
        vim.g.neovide_input_macos_option_key_is_meta = "both"
        vim.g.neovide_hide_mouse_when_typing = true
        vim.g.neovide_refresh_rate = 60
        vim.g.neovide_refresh_rate_idle = 5
        vim.g.neovide_no_idle = true
        vim.g.neovide_confirm_quit = true
        vim.g.neovide_input_use_logo = true
        vim.g.neovide_cursor_antialiasing = true

        vim.g.neovide_cursor_antialiasing = true
        vim.g.neovide_scroll_animation_length = 0.3
        vim.g.neovide_cursor_animate_in_insert_mode = true

        vim.g.neovide_cursor_vfx_mode = "ripple" -- pixiedust
        vim.g.neovide_cursor_vfx_particle_speed = 10.0
        vim.g.neovide_padding_top = 0
        vim.g.neovide_padding_bottom = 0
        vim.g.neovide_padding_right = 0
        vim.g.neovide_padding_left = 0

        vim.g.neovide_floating_shadow = true
        vim.g.neovide_floating_z_height = 10
        vim.g.neovide_light_angle_degrees = 45
        vim.g.neovide_light_radius = 5

        -- only macos
        vim.g.neovide_window_blurred = true

        vim.g.neovide_floating_blur_amount_x = 2.0
        vim.g.neovide_floating_blur_amount_y = 2.0

        local fonts = {
            inconsolata = "Inconsolata:h13",
            iosevka = "Iosevka:h13",
            victor = "Victor Mono:h13",
            ia = "iA Writer Mono S:h13",
            cascadia = "Cascadia Code NF:h13",
            cascadiam = "Cascadia Mono:h13",
            fira = "Fira Code:h13",
            firam = "Fira Mono:h13",
            monaspace_radon = "Monaspace Radon:h13",
            monaspace_argon = "Monaspace Argon:h13",
            monaspace_xenon = "Monaspace Xenon:h13",
        }

        vim.o.guifont = fonts.inconsolata
        vim.opt.linespace = 0

        vim.g.neovide_transparency = 0.8

        local change_scale_factor = function(delta)
            vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
        end
        vim.keymap.set("n", "<D-=>", function()
            change_scale_factor(1.10)
        end)
        vim.keymap.set("n", "<D-->", function()
            change_scale_factor(1 / 1.10)
        end)

        vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
        vim.keymap.set("v", "<D-c>", '"+y') -- Copy
        vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
        vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
        vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
        vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

        -- Allow clipboard copy paste in neovim
        vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    end
end

return M
