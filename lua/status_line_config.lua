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

vim.cmd('highlight MyStatusLineFileName guifg=#B1EDE8 guibg=#313751')
vim.cmd('highlight MyStatusLineFileNameDivider guifg=#313751 guibg=#2a3d66')

vim.cmd('highlight MyStatusLineDiagnostics guifg=#aaa6a4 guibg=#2a3d66')
vim.cmd('highlight MyStatusLineDiagnosticsDivider guifg=#2a3d66 guibg=#313751')

vim.cmd('highlight MyStatusLineError guifg=#FF2400 guibg=#2a3d66')
vim.cmd('highlight MyStatusLineWarning guifg=#FFAD01 guibg=#2a3d66')
vim.cmd('highlight MyStatusLineInfo guifg=#72A0C1 guibg=#2a3d66')
vim.cmd('highlight MyStatusLineHint guifg=#708238 guibg=#2a3d66')

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

    local file_name = '%#MyStatusLineFileName# %-1.100{v:lua.File_name()} %*'
    local file_name_divider = '%#MyStatusLineFileNameDivider#%*'

    local diagnostics_divider = '%#MyStatusLineDiagnosticsDivider#%*'

    local errors = '%#MyStatusLineError# %-1.100{v:lua.Error()}\u{200a}%*'
    local warnings = '%#MyStatusLineWarning#  %-1.100{v:lua.Warning()}\u{200a}%*'
    local infos = '%#MyStatusLineInfo#  %-1.100{v:lua.Info()}\u{200a}%*'
    local hints = '%#MyStatusLineHint#  %-1.100{v:lua.Hint()}\u{200a}󰌵 %*'

    return mode .. mode_divider .. line .. line_divider .. percentage .. percentage_divider .. modified .. modified_divider .. '%=' .. diagnostics_divider .. errors .. warnings .. infos .. hints .. file_name_divider .. file_name .. type_divider .. type

end

function Info()

    local errossera = vim.diagnostic.get(0, { severity = {
        vim.diagnostic.severity.INFO,
    } })

    local informations = 0

    for _, diagnostic in ipairs(errossera) do

        if diagnostic.severity == 3 then
            informations = informations + 1
        end
    end

    return informations

end

function Hint()

    local errossera = vim.diagnostic.get(0, { severity = {
        vim.diagnostic.severity.HINT
    } })

    local hints = 0

    for _, diagnostic in ipairs(errossera) do

        if diagnostic.severity == 4 then
            hints = hints + 1
        end

    end

    return hints

end

function Warning()

    local errossera = vim.diagnostic.get(0, { severity = {
        vim.diagnostic.severity.WARN,
    } })

    local warnings = 0

    for _, diagnostic in ipairs(errossera) do

        if diagnostic.severity == 2 then
            warnings = warnings + 1
        end
    end

    return warnings

end

function Error()

    local errossera = vim.diagnostic.get(0, { severity = {
        vim.diagnostic.severity.ERROR,
    } })

    local errors = 0

    for _, diagnostic in ipairs(errossera) do

        if diagnostic.severity == 1 then
            errors = errors + 1
        end

    end

    return errors

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

    local type_in_string = vim.api.nvim_buf_get_option(0, 'filetype')

    local type = Split(vim.api.nvim_buf_get_name(0), '.')

    for _, value in pairs(type) do

        local icon = icons.get_icon('a', value)

        if icon ~= nil then

            return (type_in_string .. ' ' .. icon)

        end

    end

    return ''

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

    return errors, warnings, informations, hints

end

vim.opt.statusline = Status_bar()
