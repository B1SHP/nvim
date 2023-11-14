require('functions')

Buffer_view_bookmarks_list = nil
Bookmarks_folders = {}
Bookmarks_connections = {}
Bookmarks_files = {}
Path = ''
Test = {}

local garuda_path = '/home/bruno/.config/nvim/.garuda.txt'

vim.api.nvim_set_keymap('n', 'tp', ':lua Open_window_bookmarks_view()<CR>', {noremap = true, silent = true})

function Open_window_bookmarks_view()

    Path = vim.fn.expand('%:p')

    if Buffer_view_bookmarks_list == nil then

        Buffer_view_bookmarks_list = vim.api.nvim_create_buf(false, true)

        vim.api.nvim_buf_set_name(Buffer_view_bookmarks_list, "book_marks")

        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'af', ':lua Add_new_folder()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'ab', ':lua Add_new_bookmark()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'h', ':lua Open()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(Buffer_view_bookmarks_list, 'n', 'tp', ':q!<CR>', { noremap = true, silent = true })

    end

    Read_from_files()

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

--[[

{
    String:Folder_name, 
    Boolean:Open, 
    List of List:{
        {Bookmark_name, Bookmark_path},
        {Bookmark_name, Bookmark_path},
    }
}

]]--

function Read_from_files()

    local file = io.open(garuda_path, 'r')

    local line = ''

    if file ~= nil then

        while line ~= nil do

            local data = {}

            line = file:read('l')

            if line ~= nil then

                line = line:gsub('\n', '')

                line = line:gsub(',', '')

                local folder_name_and_rest = Split(line, '=')

                table.insert(data, folder_name_and_rest[1])
                table.insert(data, false)

                local bookmarks_and_paths_groups = Split(folder_name_and_rest[2], '|')

                local index = 1

                local bookmarks = {}

                while index <= #bookmarks_and_paths_groups do

                    local bookmarks_and_paths = Split(bookmarks_and_paths_groups[index], ':')

                    table.insert(bookmarks, bookmarks_and_paths)

                    index = index + 1

                end

                table.insert(data, bookmarks)
                table.insert(Test, data)

            end

        end

    end

end

function Write_to_files()



end

function Reload_bookmarks_view()

    Bookmarks_in_memory = {
        '                    BookMarks                    ',
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    }

    local index = 1

    while index <= #Test do

        table.insert(Bookmarks_in_memory, (' ' .. tostring(index) .. ': ' .. Test[index][1]))

        local inner_index = 1

        while inner_index <= #Test[index][3] do

            if Test[index][2] then

                table.insert(Bookmarks_in_memory, (' ╰' .. tostring(index) .. '.' .. tostring(inner_index) .. ': ' .. Test[index][3][inner_index][1]))

            end

            inner_index = inner_index + 1

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

        Path_global = Bookmarks_files[tonumber(locations[1])][tonumber(locations[2])][2]

        vim.cmd('e ' .. Path_global)

    else

        local folder_id = tonumber(Split(line, ':')[1])

        if folder_id ~= nil then

            Test[folder_id][2] = not Test[folder_id][2]

            Reload_bookmarks_view()

        end

    end

end

function Add_new_bookmark()

    local file = io.open(garuda_path, 'r')

    local target_line = Find_folder()

    local lines = {}

    if file ~= nil then

        for line in file:lines() do

            local clean_line = line:gsub('\n', '')

            clean_line = clean_line:gsub(',', '')

            table.insert(lines, clean_line)

        end

        file:close()

    end

    file = io.open(garuda_path, 'w')

    if file ~= nil then

        file:close()

    end

    local dir = '/'

    local split_path = Split(Path, '/');

    for index, name in ipairs(split_path) do

        if name ~= nil and index < #split_path then

            dir = dir .. name .. '/'

        end

    end

    local line_to_be_modified = lines[target_line] .. vim.fn.input("Choose a Nickname For This Bookmark: ") .. ':' .. dir .. '|'

    lines[target_line] = line_to_be_modified

    file = io.open(garuda_path, 'w')

    if file ~= nil then

        for index, line in ipairs(lines) do

            local final_line = line .. ',\n'

            file:write(final_line)

        end

        file:close()

    end

    Collect_bookmarks()

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
