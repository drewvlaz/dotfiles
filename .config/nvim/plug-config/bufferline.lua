require('bufferline').setup {
    options = {
        -- numbers = function(opts)
        --     return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
        -- end,
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = "bdelete! %d",
        indicator_icon = '▎',
        buffer_close_icon = '',
        modified_icon = '',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 14,
        max_prefix_length = 13, -- prefix used when a buffer is de-duplicated
        tab_size = 20,
        diagnostics = "coc",
        diagnostics_update_in_insert = false,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        -- separator_style = "slant",
        -- sort_by = 'relative_directory',
        offsets = {
            {
                filetype = "NvimTree", 
                text = "File Explorer", 
                -- text = "",
                padding = 1,
                text_align = "center"
            }
        },
    }
}
