local icons = require('nvim-web-devicons')

vim.cmd('highlight statusline guibg=#313751')

vim.cmd('highlight MyStatusLineMode guifg=#413C58 guibg=#E0BE36')
vim.cmd('highlight MyStatusLineModeDivider guifg=#E0BE36 guibg=#FF6978')

vim.cmd('highlight MyStatusLineNumber guifg=#B1EDE8 guibg=#FF6978')
vim.cmd('highlight MyStatusLineNumberDivider guifg=#FF6978 guibg=#B1EDE8')

vim.cmd('highlight MyStatusLinePercentage guifg=#574D68 guibg=#B1EDE8')
vim.cmd('highlight MyStatusLinePercentageDivider guifg=#B1EDE8 guibg=#F7FF58')

vim.cmd('highlight MyStatusLineModified guifg=#537A5A guibg=#F7FF58')
vim.cmd('highlight MyStatusLineModifiedDivider guifg=#F7FF58 guibg=#313751')

vim.cmd('highlight MyStatusLineType guifg=#E0BE36 guibg=#413C58')
vim.cmd('highlight MyStatusLineTypeDivider guifg=#413C58 guibg=#313751')

vim.cmd('highlight MyStatusLineDiagnostics guifg=#B1EDE8 guibg=#313751')
vim.cmd('highlight MyStatusLineDiagnosticsDivider guifg=#313751 guibg=#7F62B3')

vim.cmd('highlight MyStatusLineFileName guifg=#F7FF58 guibg=#7F62B3')
vim.cmd('highlight MyStatusLineFileNameDivider guifg=#7F62B3 guibg=#313751')

function Status_bar()

    local mode = '%#MyStatusLineMode# %-1.100{v:lua.Mode()} %*'
    local mode_divider = '%#MyStatusLineModeDivider#%*'

    local line = '%#MyStatusLineNumber# %-1.100{v:lua.Line_number()} %*'
    local line_divider = '%#MyStatusLineNumberDivider#%*'

    local percentage = '%#MyStatusLinePercentage# %-1.100{v:lua.Percentage()} %*'
    local percentage_divider = '%#MyStatusLinePercentageDivider#%*'

    local modified = '%#MyStatusLineModified# %-1.100{v:lua.Modified()} %*'
    local modified_divider = '%#mystatuslinemodifieddivider#%*'

    local type = '%#MyStatusLineType# %-1.100{v:lua.Type()} %*'
    local type_divider = '%#MyStatusLineTypeDivider#%*'

    local diagnostics = '%#MyStatusLineDiagnostics# %-1.100{v:lua.Diagnostics()} %*'
    local diagnostics_divider = '%#MyStatusLineDiagnosticsDivider#%*'

    local file_name = '%#MyStatusLineFileName# %-1.100{v:lua.File_name()} %*'
    local file_name_divider = '%#MyStatusLineFileNameDivider#%*'

    return mode .. mode_divider .. line .. line_divider .. percentage .. percentage_divider .. modified .. modified_divider .. '%=' .. file_name_divider .. file_name .. diagnostics_divider .. diagnostics .. type_divider .. type

end

function File_name()

    local name = vim.fn.expand('%:t')

    if name ~= nil then

        local clean_name = Split(name, '.')[1]

        if clean_name ~= nil then

            name = clean_name

        end

    end

    return name

end

function Modified()
    return vim.fn.getbufinfo(vim.api.nvim_get_current_buf())[1].changed == 1 and '+' or '-'
end

function Percentage()
    return tostring(math.floor((vim.fn.line('.') * 100) / vim.fn.line('$'))) .. '%'
end

function Line_number()
    return tostring(vim.fn.line('.')) .. ':' .. tostring(vim.fn.line('$'))
end

function Mode()

    local mode = vim.fn.mode()

    if mode == 'n' then
        mode = 'Normal'
    elseif mode == 'i' then
        mode = 'Insert'
    elseif mode == 'c' then
        mode = 'Command'
    elseif mode == 'v' then
        mode = 'Visual'
    else
        mode = 'Visual Block'
    end

    return mode

end

function Type()

    local type = vim.api.nvim_buf_get_option(0, 'filetype')

    if type ~= nil then

        local icon = icons.get_icon('a', type)

        if icon ~= nil then

            type = type .. ' ' .. icon

        end

    end

    return type

end

function Diagnostics()

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

    return (tostring(errors) .. '‼️  ' .. tostring(warnings) .. '⚠️  ' .. tostring(informations) .. 'ℹ️  ' .. tostring(hints) .. '💡')

end

vim.opt.statusline = Status_bar()
