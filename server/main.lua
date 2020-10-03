local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpCore.addRpcCallback("getjobUser", function(source, cb, item)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job ~= 'unemployed' then
        cb(job)
    else
        cb('unemployed')
    end
end)