local icons = require('nvim-web-devicons')
require('functions')

Constante_de_tamanho = 100

vim.cmd('highlight StatusLeft guifg=#F1F111 guibg=#41496b')
vim.cmd('highlight StatusMiddle guifg=#A8B385 guibg=#313751')
vim.cmd('highlight StatusRight guifg=#17e0e8 guibg=#495177')

vim.cmd('highlight statusline guibg=#313751')

vim.opt.statusline = '%#StatusLeft# %-5.100{v:lua.Status_line_left_side()} %*%= %#StatusMiddle#%-10{v:lua.Diagnostics_status_bar()}%* %=%#StatusRight# %-5.100{v:lua.Status_line_right_side()} %*'

function Status_line_left_side()

    local mode = string.upper(vim.fn.mode())
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    local percentage = math.floor((current_line * 100) / total_lines)
    local saved = vim.fn.getbufinfo(vim.api.nvim_get_current_buf())[1].changed == 1 and '+' or '-'

    local final_string = '[' .. mode .. ']  ' .. '[' .. tostring(current_line) .. '/' .. tostring(total_lines) .. ']  ' .. '[' .. percentage .. '%]  [' .. saved .. ']'

    return String_repetition(final_string, ' ', (Constante_de_tamanho - string.len(final_string)), 1)

end

function Status_line_right_side()

    local type = vim.api.nvim_buf_get_option(0, 'filetype')
    local name = vim.fn.expand('%:t')

    if type ~= nil then

        local icon = icons.get_icon('a', type)

        if icon ~= nil then

            type = string.upper(type) .. ' ' .. icon

        end

    end

    if name ~= nil then

        local clean_name = Split(name, '.')[1]

        if clean_name ~= nil then

            name = clean_name

        end

    end

    local final_string = ''

    if name ~= nil and type ~= nil and #name > 0 and #type > 0 then

        final_string = type .. ' | ' .. name

        Size_right = string.len(final_string)

    elseif name ~= nil and #name > 0 then

        final_string = name

        Size_right = string.len(final_string)

    elseif type ~= nil and #type > 0 then

        final_string = type

        Size_right = string.len(final_string)

    end

    return String_repetition(final_string, ' ', (Constante_de_tamanho - string.len(final_string)), -1)

end

function Change_status_line_color()

    local mode = vim.fn.mode()

    if mode == 'n' then
        vim.cmd('highlight CursorLine guibg=#171717 guifg=#7fcbd7')
    elseif mode == 'i' then
        vim.cmd('highlight CursorLine guibg=#171717 guifg=#ca9dd7')
    end

end


function Diagnostics_status_bar()

    local errossera = vim.diagnostic.get(0, { severity = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT
    } })

    local errors = 0
    local warnings = 0
    local informations = 0
    local hints = 0

    for _, diagnostic in ipairs(errossera) do

        if diagnostic.severity == 1 then
            errors = errors + 1
        elseif diagnostic.severity == 2 then
            warnings = warnings + 1
        elseif diagnostic.severity == 3 then
            informations = informations + 1
        elseif diagnostic.severity == 4 then
            hints = hints + 1
        end
    end

    return (tostring(errors) .. '‼️  ' .. tostring(warnings) .. '⚠️  ' .. tostring(informations) .. '   ' .. tostring(hints) .. '💡')

end
