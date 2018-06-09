-- ----------------------------------------------------------------------------------------------------
-- 说明：自己的账号管理界面
-------------------------------------------------------------------------------------------------------
AccountSysManager = class("AccountSysManagerClass", Window)
local account_sys_manager_open_terminal = {
    _name = "account_sys_manager_open",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
        local _window = fwin:find("AccountSysManagerClass")
        if _window == nil then
            fwin:open(AccountSysManager:new(),fwin._ui)
        else
            state_machine.excute("account_sys_manager_update", 0, 0)
        end
    	return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(account_sys_manager_open_terminal)
state_machine.init()
    
function AccountSysManager:ctor()
    self.super:ctor()
   	self.actions = {}
	self.roots = {}
	
    local function init_sm_player_change_nick_name_terminal()
        --登陆
        local account_sys_manager_login_define_terminal = {
            _name = "account_sys_manager_login_define",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local account_name = ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_1")
                local account_password = ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_2")
                local names = zstring.exchangeTo(account_name:getString())
                local passwords = zstring.exchangeTo(account_password:getString())
                -- if names == nil or names == "" or names == "&nbsp;" then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[8])
                --     return
                -- end
                -- if passwords == nil or passwords == "" or passwords == "&nbsp;" then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[8])
                --     return
                -- end

                -- if StringFilteringDecideAccount(account_name:getString()) == false then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[7])
                --     return
                -- end

                -- if StringFilteringDecideAccount(account_password:getString()) == false then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[7])
                --     return
                -- end

                local function responseLogins(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        m_account_sys_user_name = names
                        m_account_sys_user_password = passwords
                        protocol_command.platform_user_login.passwords = passwords
                        app.load("client.login.Manager.AccountSysTips")
                        state_machine.excute("account_sys_tips_open", 0, account_sys_manager_tips[1])
                        state_machine.unlock("login_vali_register")
                        state_machine.unlock("platform_sdk_google_login", 0, "")
                        state_machine.unlock("platform_sdk_facebook_login", 0, "")
                        state_machine.unlock("platform_sdk_hotgame_login", 0, "")
                        state_machine.excute("log_in_verify_special_account", 0, 0)
                        fwin:close(fwin:find("platformSDKLoginMoveClass"))
                        fwin:close(instance)
                    else
                        state_machine.unlock("platform_sdk_google_login", 0, "")
                        state_machine.unlock("platform_sdk_facebook_login", 0, "")
                        state_machine.unlock("platform_sdk_hotgame_login", 0, "")
                        instance:setVisible(true)
                    end
                end
                if app.configJson.OperatorName == "t4" then
                    protocol_command.platform_user_login.param_list = names.."\r\n"..passwords.."\r\n".."com.gftun.d11supp.us"
                else
                    protocol_command.platform_user_login.param_list = names.."\r\n"..passwords.."\r\n"..""
                end
                NetworkManager:register(protocol_command.platform_user_login.code, app.configJson.url, nil, nil, nil, responseLogins, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --注册
        local account_sys_manager_register_terminal = {
            _name = "account_sys_manager_register",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:setVisible(false)
                app.load("client.login.Manager.AccountSysRegister")
                state_machine.excute("account_sys_register_open", 0, "account_sys_register_open.")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --自动登陆
        local account_sys_manager_login_automatic_terminal = {
            _name = "account_sys_manager_login_automatic",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local automatic = ccui.Helper:seekWidgetByName(instance.roots[1], "CheckBox_1")
                local m_boolen = automatic:isSelected()
                if m_boolen == true then
                    cc.UserDefault:getInstance():setStringForKey("account_automatic_login", "1")
                else
                    cc.UserDefault:getInstance():setStringForKey("account_automatic_login", "2")
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --关闭
        local account_sys_manager_close_terminal = {
            _name = "account_sys_manager_close",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:close(instance)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --刷新
        local account_sys_manager_update_terminal = {
            _name = "account_sys_manager_update",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:onUpdataDraw()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --进入账号找回
        local account_sys_manager_open_recovery_terminal = {
            _name = "account_sys_manager_open_recovery",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                app.load("client.login.Manager.AccountPasswordRecoveryWindow")
                state_machine.excute("account_password_recovery_window_open", 0, ".")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

		state_machine.add(account_sys_manager_login_define_terminal)
        state_machine.add(account_sys_manager_register_terminal)
        state_machine.add(account_sys_manager_close_terminal)
        state_machine.add(account_sys_manager_login_automatic_terminal)
        state_machine.add(account_sys_manager_update_terminal)
        state_machine.add(account_sys_manager_open_recovery_terminal)

        state_machine.init()
    end
    
    init_sm_player_change_nick_name_terminal()
end


function AccountSysManager:onUpdataDraw()
	local root = self.roots[1]
	local m_type = cc.UserDefault:getInstance():getStringForKey("account_automatic_login", "")
    if m_type==nil or m_type == "" then
        m_type = "1"
    end
    --2是选中1是未选中
    if tonumber(m_type) == 2 then
        ccui.Helper:seekWidgetByName(root, "CheckBox_1"):setSelected(true)
    elseif tonumber(m_type) == 1 then
        ccui.Helper:seekWidgetByName(root, "CheckBox_1"):setSelected(false)
    end
    if _ED.default_user == nil or _ED.default_user == "" then
        
    else
        local account_name = ccui.Helper:seekWidgetByName(root, "TextField_1")
        local account_password = ccui.Helper:seekWidgetByName(root, "TextField_2")
        account_name:setString(_ED.user_platform[_ED.default_user].platform_account)
        account_password:setString(_ED.user_platform[_ED.default_user].password)

        if m_account_sys_floating_switch == false and tonumber(m_type) == 2 then
            if m_login_search_user == true then
            else
                self:setVisible(false)
                state_machine.excute("account_sys_manager_login_define", 0, "account_sys_manager_login_define.")
				m_login_search_user = true
            end
        else
            m_account_sys_floating_switch = false
        end
    end
    
end

function AccountSysManager:onEnterTransitionFinish()
	local csbUserInfo = csb.createNode("login/register/register_prompt_1.csb")
	self:addChild(csbUserInfo)
	local root = csbUserInfo:getChildByName("root")
	table.insert(self.roots, root)

    --登陆
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_login"),nil, 
    {
        terminal_name = "account_sys_manager_login_define",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    },
    nil, 0)

    --注册
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_register"),nil, 
    {
        terminal_name = "account_sys_manager_register",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    },
    nil, 0)

    --自动登陆
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "CheckBox_1"),nil, 
    {
        terminal_name = "account_sys_manager_login_automatic",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    },
    nil, 0)

    local Button_register_0 = ccui.Helper:seekWidgetByName(root, "Button_register_0")
    if Button_register_0 ~= nil then
        -- if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_IPHONE or cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_IPAD then
            if app.configJson.OperatorName == "move" then
                Button_register_0:setVisible(true)
            else
                Button_register_0:setVisible(false)
            end
        -- else
            -- Button_register_0:setVisible(false)
        -- end
        -- 进入账号找回
        fwin:addTouchEventListener(Button_register_0,nil, 
        {
            terminal_name = "account_sys_manager_open_recovery",     
            terminal_state = 0, 
            isPressedActionEnabled = true
        },
        nil, 0)
    end
    local Button_close = ccui.Helper:seekWidgetByName(root, "Button_close")
    if Button_close ~= nil then
        fwin:addTouchEventListener(Button_close,nil, 
        {
            terminal_name = "account_sys_manager_close",     
            terminal_state = 0, 
            isPressedActionEnabled = true
        },
        nil, 0)
    end

    --账号
    local Panel_Username = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_Username")
    local TextField_1 = ccui.Helper:seekWidgetByName(self.roots[1], "TextField_1")
    local textField1 = draw:addEditBoxEx(TextField_1, account_sys_manager_tips[9], "effect/effice_1500.png", ccui.Helper:seekWidgetByName(root, "Button_login"), 100, cc.KEYBOARD_RETURNTYPE_DONE)
    Panel_Username:addTouchEventListener(function ( sender, eventType )
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        elseif eventType == ccui.TouchEventType.canceled then
        elseif eventType == ccui.TouchEventType.ended then
            if textField1.touchDownAction ~= nil then
                textField1:touchDownAction(textField1, eventType)
            end
        end
    end)
    --密码
    local Panel_Password = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_Password")
    local TextField_2 = ccui.Helper:seekWidgetByName(self.roots[1], "TextField_2")
    local textField2 = draw:addEditBoxEx(TextField_2, account_sys_manager_tips[10], "effect/effice_1500.png", ccui.Helper:seekWidgetByName(root, "Button_login"), 20, cc.KEYBOARD_RETURNTYPE_DONE, nil, nil, nil, nil, nil, cc.EDITBOX_INPUT_FLAG_PASSWORD)
    Panel_Password:addTouchEventListener(function ( sender, eventType )
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        elseif eventType == ccui.TouchEventType.canceled then
        elseif eventType == ccui.TouchEventType.ended then
            if textField2.touchDownAction ~= nil then
                textField2:touchDownAction(textField2, eventType)
            end
        end
    end)
    self:onUpdataDraw()
    -- local function responseSearchCallback(response)
    --     if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
            
    --     else
    --         self:onUpdataDraw()
    --     end
    -- end
    -- NetworkManager:register(protocol_command.search_user_platform.code, app.configJson.url, nil, nil, nil, responseSearchCallback, false, nil)
end

function AccountSysManager:onExit()
end
