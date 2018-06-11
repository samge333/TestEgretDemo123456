-- ----------------------------------------------------------------------------------------------------
-- 说明：数码系统设置页
-------------------------------------------------------------------------------------------------------
SmPlayerSystemSetPage = class("SmPlayerSystemSetPageClass", Window)
local sm_player_system_set_page_open_terminal = {
    _name = "sm_player_system_set_page_open",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
        local page = SmPlayerSystemSetPage:createCell():init()
    	return page
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_player_system_set_page_open_terminal)
state_machine.init()
    
function SmPlayerSystemSetPage:ctor()
    self.super:ctor()
   	self.actions = {}
	self.roots = {}
    self.image_on_group = {}
    self.image_off_group = {}
    self.image_button_group = {}
	
    local function init_sm_player_system_set_page_terminal()
        --显示
        local sm_player_system_set_page_show_terminal = {
            _name = "sm_player_system_set_page_show",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
                	instance:setVisible(true)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        --隐藏
        local sm_player_system_set_page_hide_terminal = {
            _name = "sm_player_system_set_page_hide",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
                    instance:setVisible(false)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --推送
        local sm_player_system_set_tuisong_terminal = {
            _name = "sm_player_system_set_tuisong",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                TipDlg.drawTextDailog(_new_interface_text[113])
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --黑名单
        local sm_player_system_set_back_list_open_terminal = {
            _name = "sm_player_system_set_back_list_open",
            _init = function (terminal)
                app.load("client.l_digital.player.SmPlayerSystemSetBackList")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        state_machine.excute("sm_playersystem_set_backList_open",0,"sm_playersystem_set_backList_open.")
                    end
                end
                NetworkManager:register(protocol_command.friend_update.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --兑换码
        local sm_player_system_set_cdKey_open_terminal = {
            _name = "sm_player_system_set_cdKey_open",
            _init = function (terminal)
                app.load("client.l_digital.player.SmPlayerSystemSetCDKey")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("sm_player_system_set_cdkey_page_open",0,"sm_player_system_set_cdkey_page_open.")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --客服
        local sm_player_system_set_service_open_terminal = {
            _name = "sm_player_system_set_service_open",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if config_operation.gmMessageAndReply == true then
                    local function responseGMCallback(response)
                        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                            app.load("client.l_digital.player.SmPlayerSystemGMMessage")
                            state_machine.excute("sm_player_system_GM_message_page_open",0,"sm_player_system_GM_message_page_open.")
                        end
                    end
                    NetworkManager:register(protocol_command.gm_message_init.code, nil, nil, nil, instance, responseGMCallback, false, nil)
                else
                    app.load("client.l_digital.player.SmPlayerSystemSetService")
                    state_machine.excute("sm_player_system_set_service_page_open",0,"sm_player_system_set_service_page_open.")
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --公告
        local sm_player_system_set_announce_open_terminal = {
            _name = "sm_player_system_set_announce_open",
            _init = function (terminal)
                app.load("client.red_alert_time.game_announcement.GameAnnouncement")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        state_machine.excute("game_announcement_window_open", 0, nil)
                    end
                end
                NetworkManager:register(protocol_command.get_system_notice.code, app.configJson.urlForAnnounce, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 头衔
        local sm_player_system_set_designation_open_terminal = {
            _name = "sm_player_system_set_designation_open",
            _init = function (terminal)
                -- app.load("client.l_digital.player.SmPlayerSystemSetDesignation")
                app.load("client.l_digital.player.SmTitleInfoWindow")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                -- TipDlg.drawTextDailog(_new_interface_text[113])
                -- state_machine.excute("sm_player_system_set_designation_page_open",0,"sm_player_system_set_designation_page_open.")
                state_machine.excute("sm_title_info_window_open", 0, "sm_title_info_window_open")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_player_system_set_logout_terminal = {
            _name = "sm_player_system_set_logout",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:open(ConnectingView:new(), fwin._windows)
                if cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_WINDOWS 
                    and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_LINUX 
                    and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_MAC then
                    handlePlatformRequest(0, LOGOUT, "")
                else
                    local platformloginInfo = {
                        platform_id="",
                        register_type="",
                        platform_account="",
                        nickname="",        
                        password="",
                        is_registered = false
                    }
                    _ED.user_platform = {}
                    _ED.user_platform[platformloginInfo.platform_account] = platformloginInfo
                    _ED.default_user = platformloginInfo.platform_account
                    fwin:addService({
                        callback = function ( params )
                            fwin:removeAll()
                            app.unload("client.loader.EnvironmentDatas")
                            app.load("client.loader.EnvironmentDatas")
                            -- fwin:reset(nil)
                            fwin:open(Login:new(), fwin._view)
                            fwin:close(fwin:find("ConnectingViewClass"))
                            _ED.m_is_games = false
                        end,
                        delay = 0.1,
                        params = self
                    })
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil,
        }

        local sm_player_system_url_jump_terminal = {
            _name = "sm_player_system_url_jump",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local m_type = tonumber(params._datas._type)
                handlePlatformRequest(0, CC_OPEN_URL, _web_page_jump[m_type])
                return true
            end,
            _terminal = nil,
            _terminals = nil,
        }

        local sm_player_system_user_center_terminal = {
            _name = "sm_player_system_user_center",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if app.configJson.OperatorName == "gfunfun" and 
                    cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_ANDROID  then
                    handlePlatformRequest(0, CC_USER_CENTER, "")
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil,
        }

        local sm_player_system_user_record_terminal = {
            _name = "sm_player_system_user_record",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if app.configJson.OperatorName == "gfunfun" and 
                    cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_ANDROID  then
                    handlePlatformRequest(0, CC_RECHAEGE_LIST, "")
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil,
        }


        state_machine.add(sm_player_system_set_page_show_terminal)
		state_machine.add(sm_player_system_set_page_hide_terminal)
        state_machine.add(sm_player_system_set_tuisong_terminal)
        state_machine.add(sm_player_system_set_back_list_open_terminal)
        state_machine.add(sm_player_system_set_cdKey_open_terminal)
        state_machine.add(sm_player_system_set_service_open_terminal)
        state_machine.add(sm_player_system_set_announce_open_terminal)
        state_machine.add(sm_player_system_set_designation_open_terminal)
        state_machine.add(sm_player_system_set_logout_terminal)
        state_machine.add(sm_player_system_url_jump_terminal)
        state_machine.add(sm_player_system_user_center_terminal)
        state_machine.add(sm_player_system_user_record_terminal)
        state_machine.init()
    end
    
    init_sm_player_system_set_page_terminal()
end
function SmPlayerSystemSetPage:onUpdataDraw()
	local root = self.roots[1]
    if isBgmOpen() == true then
        self.image_button_group[1]:setPosition(cc.p(self.image_off_group[1]:getPosition()))
    else
        self.image_button_group[1]:setPosition(cc.p(self.image_on_group[1]:getPosition()))
    end
    if iscurrentBgm() == true then
        self.image_button_group[2]:setPosition(cc.p(self.image_off_group[2]:getPosition()))
    else
        self.image_button_group[2]:setPosition(cc.p(self.image_on_group[2]:getPosition()))
    end
    local showMasterHp = cc.UserDefault:getInstance():getStringForKey("m_isShowMasterHp")
    if tonumber(showMasterHp) == 1 then
        self.image_button_group[3]:setPosition(cc.p(self.image_off_group[3]:getPosition()))
    else
        self.image_button_group[3]:setPosition(cc.p(self.image_on_group[3]:getPosition()))
    end
    local sceneExtrude = cc.UserDefault:getInstance():getStringForKey("m_isSceneExtrude")
    if tonumber(sceneExtrude) == 1 then
        self.image_button_group[4]:setPosition(cc.p(self.image_off_group[4]:getPosition()))
    else
        self.image_button_group[4]:setPosition(cc.p(self.image_on_group[4]:getPosition()))
    end  
end

function SmPlayerSystemSetPage:onInit()
	local csbUserInfo = csb.createNode("player/role_information_tab_2.csb")
	self:addChild(csbUserInfo)
	local root = csbUserInfo:getChildByName("root")
	table.insert(self.roots, root)
    --推送
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_tuisong"),nil, 
    {
        terminal_name = "sm_player_system_set_tuisong",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, 
    nil, 0)
    --黑名单
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_tuisong_2"),nil, 
    {
        terminal_name = "sm_player_system_set_back_list_open",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, 
    nil, 0)
    --兑换码
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_tuisong_3"),nil, 
    {
        terminal_name = "sm_player_system_set_cdKey_open",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, 
    nil, 0)
    --官方客服
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_tuisong_4"),nil, 
    {
        terminal_name = "sm_player_system_set_service_open",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, 
    nil, 0)

    --游戏公告
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_tuisong_5"),nil, 
    {
        terminal_name = "sm_player_system_set_announce_open",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, 
    nil, 0)

    --头衔
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_tuisong_6"),nil, 
    {
        terminal_name = "sm_player_system_set_designation_open",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, 
    nil, 0)

    --退出
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_tuisong_7"),nil, 
    {
        terminal_name = "sm_player_system_set_logout",
        terminal_state = 0,
        isPressedActionEnabled = true
    }, 
    nil, 0)

    --facebook粉丝页
    local Button_tuisong_8 = ccui.Helper:seekWidgetByName(root, "Button_tuisong_8")
    if Button_tuisong_8 ~= nil then
        fwin:addTouchEventListener(Button_tuisong_8,nil, 
        {
            terminal_name = "sm_player_system_url_jump",
            terminal_state = 0,
            _type = 1,
            isPressedActionEnabled = true
        }, 
        nil, 0)
    end

    --官方网页
    local Button_tuisong_9 = ccui.Helper:seekWidgetByName(root, "Button_tuisong_9")
    if Button_tuisong_9 ~= nil then
        fwin:addTouchEventListener(Button_tuisong_9,nil, 
        {
            terminal_name = "sm_player_system_url_jump",
            terminal_state = 0,
            _type = 2,
            isPressedActionEnabled = true
        }, 
        nil, 0)
    end

    --客服中心
    local Button_tuisong_10 = ccui.Helper:seekWidgetByName(root, "Button_tuisong_10")
    if Button_tuisong_10 ~= nil then
        fwin:addTouchEventListener(Button_tuisong_10,nil, 
        {
            terminal_name = "sm_player_system_url_jump",
            terminal_state = 0,
            _type = 3,
            isPressedActionEnabled = true
        }, 
        nil, 0)
    end

    --用户中心
    local Button_tuisong_11 = ccui.Helper:seekWidgetByName(root, "Button_tuisong_11")
    if Button_tuisong_11 ~= nil then
        fwin:addTouchEventListener(Button_tuisong_11,nil, 
        {
            terminal_name = "sm_player_system_user_center",
            terminal_state = 0,
            isPressedActionEnabled = true
        }, 
        nil, 0)
    end

    --充值记录
    local Button_tuisong_12 = ccui.Helper:seekWidgetByName(root, "Button_tuisong_12")
    if Button_tuisong_12 ~= nil then
        fwin:addTouchEventListener(Button_tuisong_12,nil, 
        {
            terminal_name = "sm_player_system_user_record",
            terminal_state = 0,
            isPressedActionEnabled = true
        }, 
        nil, 0)
    end

    for i = 1 , 4 do 
        self.image_on_group[i] = ccui.Helper:seekWidgetByName(root, "Image_on_"..i)
        self.image_off_group[i] = ccui.Helper:seekWidgetByName(root, "Image_off_"..i)
        self.image_button_group[i] = ccui.Helper:seekWidgetByName(root, "Image_button_"..i)
    end
    
    for i = 1 , 4 do   
        local status = true
        if i == 1 then
            status = isBgmOpen()
        elseif i == 2 then
            status = iscurrentBgm()
        elseif i == 3 then
            local showMasterHp = cc.UserDefault:getInstance():getStringForKey("m_isShowMasterHp")
            status = (tonumber(showMasterHp) == 1)
        else
            local sceneExtrude = cc.UserDefault:getInstance():getStringForKey("m_isSceneExtrude")
            status = (tonumber(sceneExtrude) == 1)
        end
        local function musicCallBack(sender, eventType)
            if eventType == ccui.TouchEventType.ended then
                if status == false then
                    status = true
                    if sender.index == 1 then
                        openBgm()
                    elseif sender.index == 2 then
                        openSoundEffect()
                    elseif sender.index == 3 then
                        cc.UserDefault:getInstance():setStringForKey("m_isShowMasterHp","1")
                        cc.UserDefault:getInstance():flush()
                    else
                        cc.UserDefault:getInstance():setStringForKey("m_isSceneExtrude","1")
                        cc.UserDefault:getInstance():flush()
                    end
                    sender:setPosition(cc.p(self.image_off_group[sender.index]:getPosition()))
                elseif status == true then
                    status = false
                    if sender.index == 1 then
                        muteBgm()
                    elseif sender.index == 2 then
                        muteSoundEffect()
                    elseif sender.index == 3 then
                        cc.UserDefault:getInstance():setStringForKey("m_isShowMasterHp","0")
                        cc.UserDefault:getInstance():flush()
                    else
                        cc.UserDefault:getInstance():setStringForKey("m_isSceneExtrude","0")
                        cc.UserDefault:getInstance():flush()
                    end
                    sender:setPosition(cc.p(self.image_on_group[sender.index]:getPosition()))
                end
            end
        end
        self.image_button_group[i].index = i
        self.image_button_group[i]:addTouchEventListener(musicCallBack)
    end

	self:onUpdataDraw()
end

function SmPlayerSystemSetPage:init(params)
    -- local _windows = params
    -- self._rootWindows = _windows
    self:onInit()
    return self
end

function SmPlayerSystemSetPage:onExit()
	state_machine.remove("sm_player_system_set_page_show")
    state_machine.remove("sm_player_system_set_page_hide")
    state_machine.remove("sm_player_system_set_tuisong")
    state_machine.remove("sm_player_system_set_back_list_open")
    state_machine.remove("sm_player_system_set_cdKey_open")
    state_machine.remove("sm_player_system_set_service_open")
    state_machine.remove("sm_player_system_set_announce_open")
    state_machine.remove("sm_player_system_set_designation_open")
    state_machine.remove("sm_player_system_set_logout")
end

function SmPlayerSystemSetPage:createCell()
    local cell = SmPlayerSystemSetPage:new()
    cell:registerOnNodeEvent(cell)
    return cell
end