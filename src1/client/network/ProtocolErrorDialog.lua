ProtocolErrorDialog = class("ProtocolErrorDialogClass", Window)

function ProtocolErrorDialog:ctor()
    self.super:ctor()
	self.request = nil
end

function ProtocolErrorDialog:onEnterTransitionFinish()
	if self.request~=nil and self.request.protocol_datas ~= nil 
		and (_ED ~= nil and _ED.m_is_games == true)
		and (self.request.protocol_datas[3] == "-3"
				or self.request.protocol_datas[3] == "-5"
				or self.request.protocol_datas[3] == "-305"
				or self.request.protocol_datas[3] == "-306"
			) then

		local str = ""..getVersion().."\r\n"
		str = str .. getApplicationName().."\r\n"
		str = str .. m_sOperationPlatformName.."\r\n"
		str = str .. getPlatformParam().."\r\n"

		-- cleanAllDataForAgainEnterGame()
		
		if __lua_project_id == __lua_project_red_alert_time 
			or __lua_project_id == __lua_project_pacific_rim 
			or __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon 
			or __lua_project_id == __lua_project_l_naruto 
			then
			-- NetworkAdaptor.reconnectSocket()
			-- -- local sendStr = NetworkProtocol.command_func(protocol_command.init_user_socket_service.code)
			-- -- NetworkAdaptor.socketSend(sendStr)
			if self.request.protocol_datas[3] == "-5" then
				state_machine.excute("logout_tip_window_open", 0, 0)
			else
				protocol_command.login_init_again.param_list = str
				NetworkManager:register(protocol_command.login_init_again.code, nil, nil, nil, nil, nil, false, nil)
				NetworkView:reconnectViewDisplay(self.request)
			end
		else
			protocol_command.login_init_again.param_list = str
			NetworkManager:register(protocol_command.login_init_again.code, nil, nil, nil, nil, nil, false, nil)
			NetworkView:reconnectViewDisplay(self.request)
		end
	end
	if self.request.protocol_datas[3] == "-4" then
		if config_operation.AccountManager == true then
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
			m_sUin = ""
			handlePlatformRequest(0, LOGOUT, "")
			m_account_sys_floating_switch = true
			m_login_search_user = true
			if fwin:find("LoginClass") == nil then
				fwin:removeAll()
				fwin:reset(nil)
				fwin:open(Login:new(), fwin._view)
				fwin:close(fwin:find("ConnectingViewClass"))
			end
		end
	end

	if self.request.protocol_datas[3] ~= "-6" and self.request.protocol_datas[3] ~= "-21" and self.request.protocol_datas[3] ~= "-269" then
		local tipString = "";
		if #_lua_release_language_param > 1 then
			local str_index = ""..math.abs(zstring.tonumber(self.request.protocol_datas[3]))
			if _ED.errorCodeInfo ~= nil and _ED.errorCodeInfo[str_index] ~= nil then
				tipString = _ED.errorCodeInfo[str_index]
			else
				tipString = self.request.protocol_datas[4]
			end
		elseif __lua_project_id == __lua_project_adventure and zstring.tonumber(_game_platform_version_type) == 4 then  
			--在挖矿与冒险中 ,东南亚版本会取本地配置
			tipString = dms.string(dms["error_code"], math.abs(zstring.tonumber(self.request.protocol_datas[3])), error_code.infoCn)
		else
			-- tipString = self.request.protocol_datas[4]
			local str_index = ""..math.abs(zstring.tonumber(self.request.protocol_datas[3]))
			if _ED.errorCodeInfo ~= nil and _ED.errorCodeInfo[str_index] ~= nil then
				tipString = _ED.errorCodeInfo[str_index]
			else
				tipString = self.request.protocol_datas[4]
			end
		end

		if nil ~= self.request.protocol_datas[5] then
			tipString = string.format(tipString, self.request.protocol_datas[5])
		end

		-- 修改昵称，昵称太长的提示统一用弹窗
		if self.request.protocol_datas[3] == "-132" and fwin:find("SmPlayerChangeNickNameClass") ~= nil then
			app.load("client.l_digital.union.meeting.SmUnionTipsWindow")
            state_machine.excute("sm_union_tips_window_open", 0, {_new_interface_text[109], 2})
		else
			TipDlg.drawTextDailog(tipString)
		end
		
		
	-- else
		-- if self.request~=nil 
			-- and self.request.protocol_datas ~= nil 
			-- and self.request.protocol_datas[4] ~= nil 
			-- and self.request.protocol_datas[3] == "-54" then
				-- TipDlg.drawTextDailog(self.request.protocol_datas[4])
		-- end
	end
	if self.request.protocol_datas[3] == "-269" then
		handlePlatformRequest(0, LOGIN_AGAIN, "")
	end
	NetworkView:protocolErrorViewErase(self.request)
end

function ProtocolErrorDialog:onExit()

end

function ProtocolErrorDialog:reset(request)
	-- NetworkView:protocolErrorViewErase(self.request)
	self.request = request
end
