require('functions')

vim.api.nvim_set_keymap('n', 'asd', '<Esc>:lua Open_window_note_pad()<CR>i', {noremap = true, silent = true})

Buffer_view_note_pad = nil

local path = '/home/bruno/.config/nvim/.note_pad.txt'
local path_backup = '/home/bruno/.config/nvim/.note_pad_backup.txt'

function Open_window_note_pad()

    Buffer_view_note_pad = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_name(Buffer_view_note_pad, "note_pad")

    vim.api.nvim_buf_set_keymap(Buffer_view_note_pad, 'i', 'qq', '<Esc>:lua Write_to_file_note_pad()<CR>', { noremap = true, silent = true })

    vim.api.nvim_buf_set_lines(Buffer_view_note_pad, 0, -1, false, Load_file())

    local screen_width, screen_height = vim.fn.winwidth(0), vim.fn.winheight(0)
    local x_location, y_location = math.floor(screen_width / 4), math.floor((screen_height * 0.2))
    local window_width, window_height = math.floor(screen_width / 2), math.floor((screen_height * 0.6))

    vim.api.nvim_open_win(Buffer_view_note_pad, true, {
        relative = 'editor',
        width = window_width,
        height = window_height,
        row = y_location,
        col = x_location,
        focusable = true,
        border =  { '@', "=" ,'@', "|", '@', '=', '@', '|'},
    })

end

function Build_line_marking(mark)

    local size = vim.fn.winwidth(0)

    local index = (size - (string.len(mark) + 6)) / 2

    local iguais = ''

    while index > 0 do

        iguais = iguais .. "="

        index = index - 1

    end

    if string.len(mark) % 2 == 0 then

        return "@" .. iguais .. "@>" .. mark .. "<@" .. string.sub(iguais, 2) .. "@"

    end

    return "@" .. iguais .. "@>" .. mark .. "<@" .. iguais .. "@"

end

function Write_to_file_note_pad_backup()

    local amount_of_lines_files = 0

    local file = io.open(path, 'r')

    if file ~= nil then

        for line in file:lines() do
            amount_of_lines_files = amount_of_lines_files + 1
            print(line)
        end

        file:close()

    end

    if amount_of_lines_files > 0 then



    else
        
    end

end

function Write_to_file_note_pad()

    local file = io.open(path, 'w')

    if file ~= nil then

        local lines = vim.api.nvim_buf_get_lines(Buffer_view_note_pad, 0, -1, true)

        for index, line in ipairs(lines) do

            if string.match(line, '@') then

                lines[index] = Build_line_marking(string.match(line, '%a+'))

            end

        end

        vim.fn.writefile(lines, path)

    end

    vim.cmd('q!')

end

function Load_file()

    local file = io.open(path, 'r')

    local data = ''

    if file ~= nil then

        data = file:read('*a')

        file:close()

    end

    return Split(data, '\n')

end

function Modify_notepad_buffer()
    vim.wo.relativenumber = false
    vim.cmd('hi FloatBorder guifg=#A9AEE1 ctermbg=235')
end

vim.api.nvim_create_autocmd('BufEnter',{pattern = 'note_pad', command = 'lua Modify_notepad_buffer()'})
