local telescope = require('telescope.builtin')

Path_global = '/home/bruno/dev/java/link-dev/microservicos/'

function Change_add_comments()

    local type = vim.api.nvim_buf_get_option(0, 'filetype')

    if type == 'lua' then
        vim.api.nvim_set_keymap('v', '/', ':s/^/--/<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('v', '<C-r>', ':s/--//<CR>', { noremap = true, silent = true })
    elseif type == 'java' then
        vim.api.nvim_set_keymap('v', '/', ':s/^/\\/\\//<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('v', '<C-r>', ':s/\\/\\///<CR>', { noremap = true, silent = true })
    end

end

function String_repetition(initial_string, string_to_be_appended, how_many_times_it_ll_be_appended, after_or_before)

    if after_or_before > 0 then
        return (initial_string .. (string_to_be_appended:rep(how_many_times_it_ll_be_appended)))
    else
        return ((string_to_be_appended:rep(how_many_times_it_ll_be_appended)) .. initial_string)
    end


end

function Terminal()

    local path = '~/'

    for index, value in ipairs(broken_path) do

        if index < #broken_path and index > 2 then

            path = path .. value .. '/'

        end

    end

    vim.cmd('split')
    vim.cmd('wincmd j')
    vim.cmd('resize 25')
    vim.cmd('cd ' .. path)
    vim.cmd('term')

end

function Split(inputstr, sep)

    if sep == nil then
        sep = "%s"
    end

    local t = {}

    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end

    return t

end

function Find_files_local()

    local name = vim.api.nvim_buf_get_name(0)

    if string.find(name, 'microservicos') then

        Path_global = '/home/bruno/dev/java/link-dev/microservicos/' .. string.match(name, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))') .. '/'

    elseif string.find(name, 'microservicos') then

        Path_global = '/home/bruno/dev/java/link-dev/api/' .. string.match(name, '/home/bruno/dev/java/link%-dev/api/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))') .. '/'

    end

    telescope.find_files({
        prompt_title = 'files',
        cwd = Path_global
    })

end

function Run_py()

    local path = vim.fn.expand('%:p')

    vim.cmd('! python3 ' .. path)

end

function Find_name(microservice_name)

    local file = io.open('/home/bruno/dev/java/link-dev/microservicos/' .. microservice_name .. '/' .. microservice_name .. '-server/src/main/resources/application.yml', 'r')

    if file == nil then

       file = io.open('/home/bruno/dev/java/link-dev/microservicos/' .. microservice_name .. '/' .. microservice_name .. '-server/src/main/resources/application.properties', 'r')

    end

    if file ~= nil then

        for line in file:lines() do

            if string.match(line, '[^zqwsxcdrfvbgtyhjuiklop]name: ') then

                return string.match(line, 'name: (.*)')

            end

        end

    else

        return nil

    end

end

function Push()

    local path = vim.api.nvim_buf_get_name(0)

    if string.find(path, 'microservicos') then

        local microservice_name = string.match(path, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*))')
        local application_name = Find_name(microservice_name)

        if(application_name ~= nil) then

            vim.cmd('cd /home/bruno/dev/java/link-dev/microservicos/' .. microservice_name .. '/')
            vim.cmd('split')
            vim.cmd('wincmd j')
            vim.cmd('resize 25')
            vim.cmd(
                'term ./mvnw clean install -DskipTests ' ..
                '&& cd ' .. microservice_name .. '-server ' ..
                '&& ./mvnw spring-boot:build-image -DskipTests -Pnative -Dspring-boot.build-image.imageName=10.210.7.18:5000/' .. application_name .. ' ' ..
                '&& docker push 10.210.7.18:5000/' .. application_name .. ' ' ..
                '&& docker rmi $(docker images -q 10.210.7.18:5000/' .. application_name .. ') --force ' ..
                '&& exit'
            )
        end

    end

end

function Build()

    local path = vim.api.nvim_buf_get_name(0)

    if string.find(path, 'microservicos') then

        local microservice_name = string.match(path, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*))')
        local application_name = Find_name(microservice_name)

        if(application_name ~= nil) then

            vim.cmd('cd /home/bruno/dev/java/link-dev/microservicos/' .. microservice_name .. '/')
            vim.cmd('split')
            vim.cmd('wincmd j')
            vim.cmd('resize 25')
            vim.cmd(
                'term if [ -n "$(docker images -q ' .. application_name .. ')" ]; then ' ..
                'docker rmi $(docker images -q ' .. application_name .. ') --force; ' ..
                'fi ' ..
                '&& ./mvnw clean install -DskipTests ' ..
                '&& cd ' .. microservice_name .. '-server ' ..
                '&& ./mvnw spring-boot:build-image -DskipTests -Pnative -Dspring-boot.build-image.imageName=' .. application_name .. ' ' ..
                '&& docker run ' .. application_name
            )

        end

    end

end

function Run_dev()

    local path = vim.api.nvim_buf_get_name(0)

    if string.find(path, 'microservicos') and string.find(path, 'server') then

        vim.cmd('split')
        vim.cmd('wincmd j')
        vim.cmd('resize 25')

        local name = string.match(path, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*))')

        local finalPath = 'term java -jar /home/bruno/dev/java/link-dev/microservicos/' .. name .. '/' .. name .. '-server/target/'

        for _, file in ipairs(vim.fn.readdir('/home/bruno/dev/java/link-dev/microservicos/' .. name .. '/' .. name .. '-server/target/')) do

            if(string.match(file, '.jar') and not(string.match(file, '.original'))) then

                finalPath = finalPath .. string.match(file, '(.*)')

            end

        end

        vim.cmd(finalPath)

    end

end

function Mvnw()

    local name = vim.api.nvim_buf_get_name(0)

    if string.find(name, 'microservicos') then

        vim.cmd('cd /home/bruno/dev/java/link-dev/microservicos/' .. string.match(name, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))') .. '/')
        vim.cmd('split')
        vim.cmd('wincmd j')
        vim.cmd('resize 25')
        vim.cmd('term ./mvnw clean install -DskipTests && exit')

    end

end

function MicroservicesTree()

    local name = vim.api.nvim_buf_get_name(0)

    if string.find(name, 'microservicos') then

        Path_global = '/home/bruno/dev/java/link-dev/microservicos/' .. string.match(name, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))') .. '/'

    elseif string.find(name, 'api') then

        Path_global = '/home/bruno/dev/java/link-dev/api/'

    else

        Path_global = '/home/bruno/dev/java/link-dev/microservicos/'

    end

    LocalTree()

end

function ConfigTree()

    Path_global = '/home/bruno/.config/nvim/'

    vim.cmd(':NvimTreeToggle ' .. Path_global)

end

function LocalTree()

    local name = vim.api.nvim_buf_get_name(0)

    if string.find(name, 'microservicos') then

        local match = string.match(name, '/home/bruno/dev/java/link%-dev/microservicos/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))')

        if match ~= nil then

            Path_global = '/home/bruno/dev/java/link-dev/microservicos/' .. match .. '/'

        end

    elseif string.find(name, 'api') then

        local match = string.match(name, '/home/bruno/dev/java/link%-dev/api/((%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?)(%w*)(%-?))')

        if match ~= nil then

            Path_global = '/home/bruno/dev/java/link-dev/api/' .. match .. '/'

        end

    end

    vim.cmd(':NvimTreeToggle ' .. Path_global)

end
