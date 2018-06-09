
-- Add default search paths for game.
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")

-- CC_USE_DEPRECATED_API = true
require "cocos.init"

-- cclog
local cclog = function(...)
    print(string.format(...))
end

function __sleep(n)
    if cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_WINDOWS then 
        os.execute("sleep " .. n)
    end
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    local errorFunc = "LUA Func\r\n"
    local errorLine = "0\r\n"
    local errorName = "LUA ERROR\r\n"
    local errorMsg = "LUA ERROR: " .. tostring(msg) .. "\r\n"
    local traceback = debug.traceback()
    local tbString = errorFunc..errorLine..errorName..errorMsg .. traceback
    if NetworkManager~=nil and protocol_command~= nil and protocol_command.record_crash.param_list ~= tbString then
        protocol_command.record_crash.param_list = tbString
        local request = NetworkManager:register(protocol_command.record_crash.code, nil, nil, nil, nil, nil, false, nil)
        NetworkAdaptor.send(request)
        -- handlePlatformRequest(0, COLLECT_CRASH_REPORT_TESTIN, msg.."|"..traceback)
        __sleep(1)
    end
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    -- debug.error(true, "----------------------------------------\r\n".."LUA ERROR: " .. tostring(msg) .. "\r\n"..debug.traceback().."\r\n----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    -- load frameworks moudle for create application.
    local _app = require("frameworks.app")
    _app.create()

    -- launch the game.
    app.load("client.launch")

    local m_targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if m_targetPlatform == cc.PLATFORM_OS_MAC 
        -- or m_targetPlatform == cc.PLATFORM_OS_WINDOWS
        then
        local pvr = require("frameworks.support.pvr")
        pvr.converts("./../pvr")
    end
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
