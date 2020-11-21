local mail_creator = {}

function mail_creator:crate_content(content)
    return content
end

return {
    init = function(width)
        return mail_creator
    end
}