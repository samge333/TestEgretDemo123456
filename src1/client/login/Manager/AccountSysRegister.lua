-- ----------------------------------------------------------------------------------------------------
-- 说明：自己的账号注册界面
-------------------------------------------------------------------------------------------------------
AccountSysRegister = class("AccountSysRegisterClass", Window)
local account_sys_register_open_terminal = {
    _name = "account_sys_register_open",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
        local _window = fwin:find("AccountSysRegisterClass")
        if _window == nil then
            fwin:open(AccountSysRegister:new(),fwin._ui)
        end
    	return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(account_sys_register_open_terminal)
state_machine.init()
    
function AccountSysRegister:ctor()
    self.super:ctor()
   	self.actions = {}
	self.roots = {}
	
    local function init_sm_player_change_nick_name_terminal()

        --注册并登录按钮
        local account_sys_register_login_define_terminal = {
            _name = "account_sys_register_login_define",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if config_operation.userPrivacyProtocol == true then
                    local userPrivacyProtocol = cc.UserDefault:getInstance():getStringForKey("platform_user_privacy_protocol", "")
                    if userPrivacyProtocol == nil or userPrivacyProtocol == "" then
                        app.load("client.login.Manager.AccountUserPrivacyProtocol")
                        state_machine.excute("account_user_privacy_protocol_open", 0, "")
                        return
                    end
                end
                local userName = zstring.exchangeTo(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_3"):getString())
                local userPassword = zstring.exchangeTo(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_4"):getString())
                local confirmPassword = zstring.exchangeTo(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_4_0"):getString())
                local str = ""
                str = str..userName.."\r\n"--用户名
                str = str..userPassword.."\r\n"
                str = str..confirmPassword.."\r\n"
                if app.configJson.OperatorName == "t4" then
                    str = str.."com.gftun.d11supp.us"
                else
                    str = str..""
                end
                -- if userPassword ~= confirmPassword then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[6])
                --     return
                -- end
                -- if #userPassword < 6 or #confirmPassword < 6 then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[4])
                --     return
                -- elseif #userPassword > 18 or #confirmPassword > 18 then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[5])
                --     return
                -- end

                -- if StringFilteringDecideAccount(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_3"):getString()) == false then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[7])
                --     return
                -- end

                -- if StringFilteringDecideAccount(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_4"):getString()) == false then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[7])
                --     return
                -- end

                -- if StringFilteringDecideAccount(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_4_0"):getString()) == false then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[7])
                --     return
                -- end

                local function responseRegister(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        state_machine.excute("account_sys_register_login", 0, "account_sys_register_login.")
                    end
                end
                protocol_command.platform_user_register.param_list = str
                NetworkManager:register(protocol_command.platform_user_register.code, app.configJson.url, nil, nil, nil, responseRegister, false, nil)      
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --登陆
        local account_sys_register_login_terminal = {
            _name = "account_sys_register_login",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local account_name = ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_3")
                local account_password = ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_4")
                local names = zstring.exchangeTo(account_name:getString())
                local passwords = zstring.exchangeTo(account_password:getString())
                local function responseLogins(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        m_account_sys_user_name = names
                        m_account_sys_user_password = passwords
                        protocol_command.platform_user_login.passwords = passwords
                        app.load("client.login.Manager.AccountSysTips")
                        state_machine.excute("account_sys_tips_open", 0, account_sys_manager_tips[1])
                        state_machine.unlock("login_vali_register")
                        if app.configJson.OperatorName == "t4" then
                            jttd.facebookAPPeventSlogger("3|".._ED.default_user)
                        end
                        -- 注册账号
                        jttd.myDataSubmitted("4",_ED.default_user..","..names)
                        if app.configJson.OperatorName == "move" then
                            cc.UserDefault:getInstance():setStringForKey("moveLofinType", "3")
                            cc.UserDefault:getInstance():flush()
                        end
                        state_machine.unlock("platform_sdk_google_login", 0, "")
                        state_machine.unlock("platform_sdk_facebook_login", 0, "")
                        state_machine.unlock("platform_sdk_hotgame_login", 0, "")
                        state_machine.excute("log_in_verify_special_account", 0, 0)
                        fwin:close(fwin:find("platformSDKLoginMoveClass"))
                        fwin:close(instance)
                        fwin:close(fwin:find("AccountSysManagerClass"))
                    else
                        state_machine.unlock("platform_sdk_google_login", 0, "")
                        state_machine.unlock("platform_sdk_facebook_login", 0, "")
                        state_machine.unlock("platform_sdk_hotgame_login", 0, "")
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
        
        --关闭
        local account_sys_register_close_terminal = {
            _name = "account_sys_register_close",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:find("AccountSysManagerClass"):setVisible(true)
                fwin:close(instance)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		state_machine.add(account_sys_register_login_define_terminal)
        state_machine.add(account_sys_register_login_terminal)
        state_machine.add(account_sys_register_close_terminal)
        state_machine.init()
    end
    
    init_sm_player_change_nick_name_terminal()
end


function AccountSysRegister:onUpdataDraw()
	local root = self.roots[1]
    local name = ""
    local password = ""
    
    if app.configJson.OperatorName == "move" then
        -- 自动登录去除
    else
    	local fristName = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
        local secendName = {"0","1","2","3","4","5","6","7","8","9"}
        
        for i=1,10 do
            if i < 3 then
                name = name..fristName[math.random(1, #fristName)]
            else
                name = name..secendName[math.random(1, #secendName)]
            end
            if i < 7 then
                password = password..secendName[math.random(1, #secendName)]
            end
        end
    end
    local TextField_3 = ccui.Helper:seekWidgetByName(self.roots[1], "TextField_3")
    local TextField_4 = ccui.Helper:seekWidgetByName(self.roots[1], "TextField_4")
    local TextField_4_0 = ccui.Helper:seekWidgetByName(self.roots[1], "TextField_4_0")
    if app.configJson.OperatorName == "move" then
    else
        TextField_3:setString(name)
        TextField_4:setString(password)
        TextField_4_0:setString(password)
    end
    local keyboard_type = nil
    if app.configJson.OperatorName == "move" then
        keyboard_type = cc.EDITBOX_INPUT_FLAG_PASSWORD
    else
        keyboard_type = cc.KEYBOARD_RETURNTYPE_DONE
    end
    --账号
    local Panel_Account = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_Account")
    local textField1 = draw:addEditBoxEx(TextField_3, account_sys_manager_tips[9], "effect/effice_1500.png", ccui.Helper:seekWidgetByName(root, "Button_register"), 20, cc.KEYBOARD_RETURNTYPE_DONE)
    Panel_Account:addTouchEventListener(function ( sender, eventType )
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
    local Panel_Password_1_1 = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_Password_1_1")
    local textField2 = draw:addEditBoxEx(TextField_4, account_sys_manager_tips[10], "effect/effice_1500.png", ccui.Helper:seekWidgetByName(root, "Button_register"), 20, cc.KEYBOARD_RETURNTYPE_DONE, nil, nil, nil, nil, nil, keyboard_type)
    Panel_Password_1_1:addTouchEventListener(function ( sender, eventType )
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        elseif eventType == ccui.TouchEventType.canceled then
        elseif eventType == ccui.TouchEventType.ended then
            if textField2.touchDownAction ~= nil then
                textField2:touchDownAction(textField2, eventType)
            end
        end
    end)
    local Panel_Password_2_1 = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_Password_2_1")
    local textField3 = draw:addEditBoxEx(TextField_4_0, account_sys_manager_tips[10], "effect/effice_1500.png", ccui.Helper:seekWidgetByName(root, "Button_register"), 20, cc.KEYBOARD_RETURNTYPE_DONE, nil, nil, nil, nil, nil, keyboard_type)
    Panel_Password_2_1:addTouchEventListener(function ( sender, eventType )
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        elseif eventType == ccui.TouchEventType.canceled then
        elseif eventType == ccui.TouchEventType.ended then
            if textField3.touchDownAction ~= nil then
                textField3:touchDownAction(textField3, eventType)
            end
        end
    end)
    if app.configJson.OperatorName == "move" then
    else
        textField1:setPlaceHolder(name)
        textField1:setText(name)
        textField2:setPlaceHolder(password)
        textField2:setText(password)
        textField3:setPlaceHolder(password)
        textField3:setText(password)
    end
end

function AccountSysRegister:onEnterTransitionFinish()
    local csbUserInfo = csb.createNode("login/register/register_prompt_2.csb")
    self:addChild(csbUserInfo)
    local root = csbUserInfo:getChildByName("root")
    table.insert(self.roots, root)
    
    self:onUpdataDraw()

    --退出
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_1077"),nil, 
    {
        terminal_name = "account_sys_register_close",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    },
    nil, 0)

    --注册
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_register"),nil, 
    {
        terminal_name = "account_sys_register_login_define",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    },
    nil, 0)
end

function AccountSysRegister:onExit()
end
