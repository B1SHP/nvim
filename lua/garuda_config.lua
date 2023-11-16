require('functions')

Buffer_view_bookmarks_list = nil
Bookmarks_loaded = {}
Local_path_for_garuda_bookmark = ''

local garuda_path = '/home/bruno/.config/nvim/.garuda.txt'

vim.api.nvim_set_keymap('n', 'tp', ':lua Open_window_bookmarks_view()<CR>', {noremap = true, silent = true})

function Open_window_bookmarks_view()

    Local_path_for_garuda_bookmark = vim.fn.bufname(vim.fn.bufnr('%'))

    if Buffer_view_bookmarks_list == nil then

        Buffer_view_bookmarks_list = vim.api.nvim_create_buf(false, true)

        vim.api.nvim_buf_set_name(Buffer_view_bookmarks_list, "book_marks")

        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'af', ':lua Add_new_folder()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'ab', ':lua Add_new_bookmark()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'h', ':lua Open()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'tp', ':q!<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'rmb', ':lua Remove_bookmark()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'rmf', ':lua Remove_folder()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'rnb', ':lua Rename_bookmark()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'rnf', ':lua Rename_folder()<CR>', { noremap = true, silent = true })

    end

    Read_from_files_garuda()

    Reload_bookmarks_view()

    return vim.api.nvim_open_win(Buffer_view_bookmarks_list, true, {
        relative = 'editor',
        anchor = 'NW',
        width = 50,
        height = 50,
        row = 0,
        col = 0,
        focusable = true,
        border =  { '╭', "━" ,'╮', "┃", "╯", "━", "╰", "┃" },
    })

end

function Reload_and_write()

    Reload_bookmarks_view()

    Write_to_file_garuda()

end

function Rename_folder()

    Bookmarks_loaded[tonumber(Find_folder())][1] = vim.fn.input('Write the new name for this folder: ')

    Reload_and_write()

end

function Rename_bookmark()

    local folder_id, bookmark_id = Find_bookmark()

    if folder_id == 0 and bookmark_id == 0 then

        print('This Command Was Meant To Be Used With Bookmarks Only')

    else

        local new_name = vim.fn.input('Write the new name for this bookmark: ')

        Bookmarks_loaded[tonumber(folder_id)][3][tonumber(bookmark_id)][1] = new_name

        Reload_and_write()

    end

end

function Remove_folder()

    table.remove(Bookmarks_loaded, tonumber(Find_folder()))

    Reload_and_write()

end

function Remove_bookmark()

    local folder_id, bookmark_id = Find_bookmark()

    if folder_id == 0 and bookmark_id == 0 then

        print('Wrong Command, This One Is Used To Remove Only Bookmarks')

    else

        table.remove(Bookmarks_loaded[tonumber(folder_id)][3], tonumber(bookmark_id))

    end

    Reload_and_write()

end

function Find_bookmark()

    local line_number = vim.fn.line(".")

    local line = vim.api.nvim_buf_get_lines(vim.fn.bufnr('%'), line_number - 1, line_number, false)[1]

    if string.find(line, '╰') then

        local folder_and_id = Split(Split(line, ':')[1]:gsub('╰', ''), '.')

        return folder_and_id[1], folder_and_id[2]

    else

        return 0, 0

    end

end

function Add_new_bookmark()

    local folder_id = Find_folder()

    local path = '/home/bruno/'

    local broken_path = Split(Local_path_for_garuda_bookmark, '/')

    for index, value in ipairs(broken_path) do

        if index < #broken_path then

            path = path .. value .. '/'

        end

    end

    local nickname = vim.fn.input('Write the name for the new bookmark: ')

    local size = #Bookmarks_loaded[folder_id]

    if size > 2 then

        table.insert(Bookmarks_loaded[folder_id][3], {nickname, path})

    else

        table.insert(Bookmarks_loaded[folder_id], {{nickname, path}})
        Bookmarks_loaded[folder_id][2] = true
    end

    Reload_and_write()

end

function Add_new_folder()

    table.insert(Bookmarks_loaded, {vim.fn.input('Write the name for the new folder: '), false})

    Reload_and_write()

end

function Read_from_files_garuda()

    Bookmarks_loaded = {}

    local file = io.open(garuda_path, 'r')

    local line = ''

    if file ~= nil then

        while line ~= nil do

            local data = {}

            line = file:read('l')

            if line ~= nil then

                line = line:gsub('\n', '')

                local folder_name_and_rest = Split(line, '=')

                table.insert(data, folder_name_and_rest[1])
                table.insert(data, false)

                if folder_name_and_rest[2] ~= nil then

                    local bookmarks_and_paths_groups = Split(folder_name_and_rest[2], '|')

                    local index = 1

                    local bookmarks = {}

                    while index <= #bookmarks_and_paths_groups do

                        local bookmarks_and_paths = Split(bookmarks_and_paths_groups[index], ':')

                        table.insert(bookmarks, bookmarks_and_paths)

                        index = index + 1

                    end

                    table.insert(data, bookmarks)

                end

                table.insert(Bookmarks_loaded, data)

            end

        end

    end

end

function Write_to_file_garuda()

    local file = io.open(garuda_path, 'w')

    if file ~= nil then

        for _, folder in ipairs(Bookmarks_loaded) do

            local line = folder[1] .. '='

            if #folder > 2 then

                for _, file_path in ipairs(folder[3]) do

                    line = line .. file_path[1] .. ':' .. file_path[2] .. '|'

                end

            end

            line = line .. '\n'

            file:write(line)

        end

        file:close()

    end

end

function Reload_bookmarks_view()

    Bookmarks_in_memory = {
        '                    BookMarks                    ',
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    }

    local index = 1

    while index <= #Bookmarks_loaded do

        table.insert(Bookmarks_in_memory, (' ' .. tostring(index) .. ': ' .. Bookmarks_loaded[index][1]))

        if #Bookmarks_loaded[index] > 2 then

            local inner_index = 1

            while inner_index <= #Bookmarks_loaded[index][3] do

                if Bookmarks_loaded[index][2] then

                    table.insert(Bookmarks_in_memory, (' ╰' .. tostring(index) .. '.' .. tostring(inner_index) .. ': ' .. Bookmarks_loaded[index][3][inner_index][1]))

                end

                inner_index = inner_index + 1

            end

        end

        index = index + 1

    end

    vim.api.nvim_buf_set_lines(Buffer_view_bookmarks_list, 0, -1, false, Bookmarks_in_memory)

end

function Find_folder()

    local line_number = vim.fn.line(".")

    local line = vim.api.nvim_buf_get_lines(vim.fn.bufnr('%'), line_number - 1, line_number, false)[1]

    if string.find(line, '╰') then

        return tonumber(Split(Split(line, ':')[1]:gsub('╰', ''), '.')[1])

    else

        return tonumber(Split(line, ':')[1])

    end

end

function Open()

    local line_number = vim.fn.line(".")

    local line = vim.api.nvim_buf_get_lines(vim.fn.bufnr('%'), line_number - 1, line_number, false)[1]

    if string.find(line, '╰') then

        local locations = Split(Split(line, ':')[1]:gsub('╰', ''), '.')

        Path_global = Bookmarks_loaded[tonumber(locations[1])][3][tonumber(locations[2])][2]

        vim.cmd('e ' .. Path_global)

    else

        local folder_id = tonumber(Split(line, ':')[1])

        if folder_id ~= nil then

            Bookmarks_loaded[folder_id][2] = not Bookmarks_loaded[folder_id][2]

            Reload_bookmarks_view()

        end

    end

end

function Reload_window_bookmarks_view()
    vim.cmd('highlight CursorLine guibg=#171717 guifg=#ca9dd7')
    vim.cmd('setlocal nonumber norelativenumber')
    vim.cmd('highlight CustomChar guifg=#7fcbd7')
    vim.cmd('syntax match CustomChar /./')
    vim.cmd('highlight link CustomChar SpecialChar')
    vim.cmd('hi FloatBorder guifg=#7fcbd7 ctermbg=235')
end

vim.api.nvim_create_autocmd('BufEnter',
    {
        pattern = 'book_marks',
        command = 'lua Reload_window_bookmarks_view()'
    }
)
