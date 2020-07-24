VORP = exports.vorp_core:vorpAPI()

VORP.addNewCallBack("getjobUser", function(source, cb, item)
    local _source = source
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local job = user.job
        if job ~= nil then
            cb(job)
        else
            cb('unemployed')
        end
    end)
end)