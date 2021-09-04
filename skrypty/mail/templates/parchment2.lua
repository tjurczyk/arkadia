--  __________________________________________________________________________ 
-- / _\\                                                                       \\
-- |/ >|                                                                       |
-- |\\_/_______________________________________________________________________/
-- \\.                                                                      ./
--  |                                                                      |
--  |                                                                      |
--  |                                                                      |
--  |                                                                      |
--  |                                                                      |
--  | _____________________________________________________________________|
--  |/\\                                                                     \\
--  \\\\_|                                                                     |
--   \\_/____________________________________________________________________/


local mail_creator = {}

function mail_creator:crate_content(content)
    local result = {}
    for _, line in pairs(content) do
        table.insert(result, self:border_line(line))
    end
    return table.n_flatten({self:create_header(), result, self:create_footer()})
end

function mail_creator:border_line(line)
    return [[ |    ]] .. scripts.utils.str_pad(line:gsub("^>", ""), self.width, line:sub(1,1) ~= ">" and "left" or "right") ..[[ |   ]]
end

function mail_creator:create_header()
    return {
        
        [[ ______]] .. string.rep("_", self.width) ..[[_____  ]],
        [[/ _\\  ]] .. string.rep(" ", self.width) ..[[     \\]],
        [[|/ >|  ]] .. string.rep(" ", self.width) ..[[     | ]],
        [[|\\_/__]] .. string.rep("_", self.width) ..[[______/]],
        [[\\.    ]] .. string.rep(" ", self.width) ..[[   ./  ]],
        [[ |     ]] .. string.rep(" ", self.width) ..[[   |   ]]
    }
end

function mail_creator:create_footer()
    return {
        [[ |  ___]] .. string.rep("_", self.width) ..[[___|    ]],
        [[ |/\\  ]] .. string.rep(" ", self.width) ..[[     \\ ]],
        [[ \\\\_|]] .. string.rep(" ", self.width) ..[[       |]],
        [[  \\_/_]] .. string.rep("_", self.width) ..[[_____/  ]],
    }
end

return {
    init = function(width)
        mail_creator.width = width
        return mail_creator
    end
}