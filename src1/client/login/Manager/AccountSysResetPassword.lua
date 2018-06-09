-- ----------------------------------------------------------------------------------------------------
-- 说明：自己的账号修改密码界面
-------------------------------------------------------------------------------------------------------
AccountSysResetPassword = class("AccountSysResetPasswordClass", Window)
local account_sys_reset_password_open_terminal = {
    _name = "account_sys_reset_password_open",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
        local _window = fwin:find("AccountSysResetPasswordClass")
        if _window == nil then
            fwin:open(AccountSysResetPassword:new(),fwin._ui)
        end
    	return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(account_sys_reset_password_open_terminal)
state_machine.init()
    
function AccountSysResetPassword:ctor()
    self.super:ctor()
   	self.actions = {}
	self.roots = {}
	
    local function init_sm_player_change_nick_name_terminal()

        --注册并登录按钮
        local account_sys_reset_password_login_define_terminal = {
            _name = "account_sys_reset_password_login_define",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local oldPassword = zstring.exchangeTo(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_3"):getString())
                local userPassword = zstring.exchangeTo(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_4"):getString())
                local newPasswordAffirm = zstring.exchangeTo(ccui.Helper:seekWidgetByName(instance.roots[1], "TextField_5"):getString())
                local str = ""
                str = str..m_account_sys_user_name.."\r\n"
                str = str..oldPassword.."\r\n"
                str = str..userPassword.."\r\n"
                str = str..newPasswordAffirm.."\r\n"
                str = str..m_sUin
                if app.configJson.OperatorName == "t4" then
                    str = str.."\r\n".."com.gftun.d11supp.us"
                else
                    str = str.."\r\n"..""
                end
                -- if #userPassword < 6 then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[4])
                --     return
                -- elseif #userPassword > 18 then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[5])
                --     return
                -- end

                -- if userPassword ~= newPasswordAffirm then
                --     TipDlg.drawTextDailog(account_sys_manager_tips[6])
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

                local function responseResetPassword(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        state_machine.excute("account_sys_floating_switch", 0, "account_sys_floating_switch.")
                        TipDlg.drawTextDailog(account_sys_manager_tips[3])
                        m_account_sys_user_password = newPasswordAffirm
                    end
                end
                protocol_command.platform_user_modify_password.param_list = str
                NetworkManager:register(protocol_command.platform_user_modify_password.code, app.configJson.url, nil, nil, nil, responseResetPassword, false, nil)      
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        
        --关闭
        local account_sys_reset_password_close_terminal = {
            _name = "account_sys_reset_password_close",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("log_in_your_own_account_system", 0, "log_in_your_own_account_system.")
                fwin:close(instance)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		state_machine.add(account_sys_reset_password_login_define_terminal)
        state_machine.add(account_sys_reset_password_close_terminal)
        state_machine.init()
    end
    
    init_sm_player_change_nick_name_terminal()
end


function AccountSysResetPassword:onUpdataDraw()
	local root = self.roots[1]
    
end

function AccountSysResetPassword:onEnterTransitionFinish()
	local csbUserInfo = csb.createNode("login/register/register_prompt_4.csb")
	self:addChild(csbUserInfo)
	local root = csbUserInfo:getChildByName("root")
	table.insert(self.roots, root)

	local TextField_3 = ccui.Helper:seekWidgetByName(root, "TextField_3")
    if protocol_command.platform_user_login.passwords ~= nil then
        TextField_3:setString(protocol_command.platform_user_login.passwords)
    end
    --老密码
    local Panel_Password_0 = ccui.Helper:seekWidgetByName(root, "Panel_Password_0")
    local textField1 = draw:addEditBoxEx(TextField_3, account_sys_manager_tips[10], "effect/effice_1500.png", ccui.Helper:seekWidgetByName(root, "Button_modify_1"), 20, cc.KEYBOARD_RETURNTYPE_DONE)  
    Panel_Password_0:addTouchEventListener(function ( sender, eventType )
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        elseif eventType == ccui.TouchEventType.canceled then
        elseif eventType == ccui.TouchEventType.ended then
            if textField1.touchDownAction ~= nil then
                textField1:touchDownAction(textField1, eventType)
            end
        end
    end)
    textField1:setPlaceHolder(protocol_command.platform_user_login.passwords)
    textField1:setText(protocol_command.platform_user_login.passwords)
    --新密码
    local Panel_Password_1 = ccui.Helper:seekWidgetByName(root, "Panel_Password_1")
    local TextField_4 = ccui.Helper:seekWidgetByName(root, "TextField_4")
    local textField2 = draw:addEditBoxEx(TextField_4, account_sys_manager_tips[10], "effect/effice_1500.png", ccui.Helper:seekWidgetByName(root, "Button_modify_1"), 20, cc.KEYBOARD_RETURNTYPE_DONE, nil, nil, nil, nil, nil, cc.EDITBOX_INPUT_FLAG_PASSWORD)
    Panel_Password_1:addTouchEventListener(function ( sender, eventType )
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        elseif eventType == ccui.TouchEventType.canceled then
        elseif eventType == ccui.TouchEventType.ended then
            if textField2.touchDownAction ~= nil then
                textField2:touchDownAction(textField2, eventType)
            end
        end
    end)
    textField2:setPlaceHolder("")
    textField2:setText("")
    --新密码2
    local Panel_Password_2 = ccui.Helper:seekWidgetByName(root, "Panel_Password_2")
    local TextField_5 = ccui.Helper:seekWidgetByName(root, "TextField_5")
    local textField3 = draw:addEditBoxEx(TextField_5, account_sys_manager_tips[10], "effect/effice_1500.png", ccui.Helper:seekWidgetByName(root, "Button_modify_1"), 20, cc.KEYBOARD_RETURNTYPE_DONE, nil, nil, nil, nil, nil, cc.EDITBOX_INPUT_FLAG_PASSWORD)
    Panel_Password_2:addTouchEventListener(function ( sender, eventType )
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        elseif eventType == ccui.TouchEventType.canceled then
        elseif eventType == ccui.TouchEventType.ended then
            if textField3.touchDownAction ~= nil then
                textField3:touchDownAction(textField3, eventType)
            end
        end
    end)
    textField3:setPlaceHolder("")
    textField3:setText("")

	self:onUpdataDraw()

    --退出
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_1077"),nil, 
    {
        terminal_name = "account_sys_reset_password_close",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    },
    nil, 0)

    --修改
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_modify_1"),nil, 
    {
        terminal_name = "account_sys_reset_password_login_define",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    },
    nil, 0)
end

function AccountSysResetPassword:onExit()
end
