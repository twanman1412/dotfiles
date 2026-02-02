return {
    "github/copilot.vim",
    lazy = false,
    config = function()
        local function check_copilot_disable_file()
            local buffer_name = vim.api.nvim_buf_get_name(0)
            if buffer_name == "" then return end

            local current_dir = vim.fs.dirname(buffer_name)

            local git_dir_results = vim.fs.find(".git", { path = current_dir, upward = true, type = "directory" })

            if #git_dir_results > 0 then
                local git_root = vim.fs.dirname(git_dir_results[1])
                local disable_file = git_root .. "/.copilot-disable"

                if vim.uv.fs_stat(disable_file) then
                    vim.b.copilot_enabled = false
                    vim.notify("Copilot disabled (found .copilot-disable)", vim.log.levels.INFO)
                else
                    vim.b.copilot_enabled = true
                end
            end
        end

        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = check_copilot_disable_file,
        })

        check_copilot_disable_file()

        vim.keymap.set("i", "<C-y>", 'copilot#Accept("<CR>")', {
            expr = true,
            replace_keycodes = false,
        })
        vim.g.copilot_no_tab_map = true
    end
}
