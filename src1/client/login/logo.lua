local Logo = class("LogoClass", Window)

function Logo:ctor()
    self.super:ctor()
    self.roots = {}
    self.exitLogo = false
    self.videoPlayer = nil
    self.waitTime = 3
	self.isMp4 = true
    app.load("client.operation.Config")
    dms.load("data/mould/sound_effect_param.txt")
    -- Initialize logo page state machine.
    local function init_logo_terminal()
        local logo_check_assets_terminal = {
            _name = "logo_check_assets",
            _init = function (terminal)
                -- local terminal = state_machine.find("logo_check_assets")
                -- terminal._instance:scheduler("1", terminal._instance.inAssetsManagerExPage, 1, false)
                -- terminal._instance:addTimer(terminal._instance.inAssetsManagerExPage, 0, 10.6, false, nil)
				
                fwin:initAsyncImg("effect/effice_1500.png")

				app.load("data.TipStringInfo")
				app.load("client.utils.TipDraw")
				-- app.load("client.loader.LocalDatas")
				app.load("client.protocol.ProtocolParser")
                app.load("client.protocol.ProtocolCommander")
				app.load("client.loader.EnvironmentDatas")
				-- app.load("client.player.UserTopInfoA")
				
                NetworkProtocol.protocol_commands = protocol_command
                NetworkProtocol.protocol_parses = protocol_parse
				
				NetworkManager:registerUrl(app.configJson.url, app.configJson.wsurl)
				app.load("client.network.ConnectingView")
				app.load("client.network.ReconnectView")
				app.load("client.network.NetworkErrorDialog")
				app.load("client.network.ProtocolErrorDialog")
                NetworkView:register(ConnectingView:new(), ReconnectView:new(), NetworkErrorDialog:new(), ProtocolErrorDialog:new())
                NetworkManager:registerKeepAlive(protocol_command.keep_alive.code, 180*2)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				local targetPlatform = cc.Application:getInstance():getTargetPlatform()
				if targetPlatform == cc.PLATFORM_OS_WINDOWS and false then
                 --   localData()
					-- app.load("client.operation.Config")
					-- app.load("client.utils.shortcut")
					-- show game AssetsManagerEx page view.
					-- fwin:addBorder(nil) -- add frame window border.          
					fwin:reset()
					app.load("client.login.AssetsManager")
					-- app.load("client.loader.LocalDatas")
					-- localData_attack_logic()
					-- app.load("client.battle.BattleScene")
					-- app.load("client.mission.Mission")
					-- app.load("client.mission.tuition.TuitionController")
					
					-- fwin:open(AssetsManager:new(), fwin._view)
					
					-- terminal._state = 1 -- To login
					
					-- show game login page view.
					-- fwin:addBorder(nil) -- add frame window border.
					-- fwin:reset()
					app.load("client.login.login")
					fwin:open(Login:new(), fwin._view)
				else
					instance:removeAllChildren(true)
                    -- app.load("client.utils.shortcut")
					-- app.load("client.operation.Config")
					app.load("client.assets.AssetsManager")
					-- app.load("client.loader.LocalDatas")
					-- localData_attack_logic()
					-- app.load("client.battle.BattleScene")
					fwin:open(AssetsManager:new(), fwin._background)
				end
				if fwin._x > 0 or fwin._y > 0 then
                	fwin:addBorder(csb.createNode("utils/adaptive_keep_out.csb"))
            	end
				return true
				
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local logo_activate_app_terminal = {
            _name = "logo_activate_app",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local function responseActivateAppCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						
					end
                end
                NetworkManager:register(protocol_command.activate_app.code, nil, nil, nil, nil, responseActivateAppCallback, false, nil)
				return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
				
		-- local open_exit_game_view_terminal = {
            -- _name = "open_exit_game_view",
            -- _init = function (terminal)
				-- app.load("client.utils.ExitGameView")
            -- end,
            -- _inited = false,
            -- _instance = self,
            -- _state = 0,
            -- _invoke = function(terminal, instance, params)
				 -------------
				-- state_machine.excute("open_exit_game_view", 0, "event open_exit_game_view.")
				-------------------
				
				-- fwin:open(ExitGameView:new(), fwin._ui)
				-- return true
            -- end,
            -- _terminal = nil,
            -- _terminals = nil
        -- }
		
		local logo_stop_video_terminal = {
            _name = "logo_stop_video",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance.videoPlayer ~= nil then
                	self.videoPlayer:stop()
                	self.videoPlayer = nil
                end
				return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		-- state_machine.add(open_exit_game_view_terminal)
        state_machine.add(logo_check_assets_terminal)
		state_machine.add(logo_activate_app_terminal)
		state_machine.add(logo_stop_video_terminal)
        state_machine.init()
    end
    init_logo_terminal()
    if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
		or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
    	--默认播放一次,解决视频播放中,不点击屏幕,导致进入游戏会没有音效
    	ccexp.AudioEngine:play2d(formatMusicFile("button", 1), false, 0.01)
    end
end

function Logo:onUpdate (dt)
	if self.exitLogo == true then
		if platform_extras ~= "" then
			self.exitLogo = false
			state_machine.excute("logo_check_assets", 0, "change to 'AssetsManagerEx'")
		end
	end
	if self.videoPlayer ~= nil then
		self.waitTime = self.waitTime - dt
		if self.waitTime < 0 then
			if self.videoPlayer.isPlaying ~= nil and self.videoPlayer:isPlaying() == false then
				app.load("client.operation.Config")
				self.exitLogo = true
				sener:setVisible(false)
				self.videoPlayer = nil
			end
		end
	end
end

function Logo:onEnterTransitionFinish()
	local function addLogoCsb( ... )
	    local csbLogo = csb.createNode("login/logo.csb")
	    local root = csbLogo:getChildByName("root")
		table.insert(self.roots, root)
		-- 停止视频
		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_1"), nil, 
		{
			terminal_name = "logo_stop_video", 
	        terminal_state = 0, 
	        isPressedActionEnabled = false
		}, 
		nil, 0)

	    local action = csb.createTimeline("login/logo.csb")
	    self.action = action
	    -- action:setTimeSpeed(app.getTimeSpeed())
	    csbLogo:runAction(action)
	    action:gotoFrameAndPlay(0, action:getDuration(), false)
	    action:setFrameEventCallFunc(function (frame)
	        if nil == frame then
	            return
	        end

	        local str = frame:getEvent()
	        if str == "open" then
				state_machine.excute("logo_activate_app", 0, "logo_activate_app.")
	        elseif str == "exit" then
	            -- 
				if cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_WINDOWS 
				and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_LINUX 
				and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_MAC then
					if #_lua_release_language_param > 1 then
						local _current_language = cc.UserDefault:getInstance():getStringForKey("current_language", "")
						if _current_language ~= "" then
							m_curr_choose_language = _current_language
							app.setSearchPaths(_current_language)
						else
							cc.UserDefault:getInstance():setStringForKey("current_language", "zh_TW")
							m_curr_choose_language = "zh_TW"
							cc.UserDefault:getInstance():flush()
						end
					else
						m_curr_choose_language = app.configJson.ReleaseLanguage
					end
					-- 播放视频
					if self.isMp4 == false then
						app.load("client.operation.Config")
						self.exitLogo = true
					else
						if __lua_project_id == __lua_project_gragon_tiger_gate 
							or __lua_project_id == __lua_project_l_digital 
							or __lua_project_id == __lua_project_l_pokemon 
							or __lua_project_id == __lua_project_l_naruto  
							or __lua_project_id == __lua_project_red_alert 
							or __lua_project_id == __lua_project_red_alert_time 
							or __lua_project_id == __lua_project_pacific_rim
							or __lua_project_id == __lua_project_warship_girl_b 
							or __lua_project_id == __lua_project_digimon_adventure 
							or __lua_project_id == __lua_project_naruto 
							or __lua_project_id == __lua_project_pokemon 
							or __lua_project_id == __lua_project_rouge 
							or __lua_project_id == __lua_project_yugioh 
							then
							local targetPlatform = cc.Application:getInstance():getTargetPlatform()
							if cc.PLATFORM_OS_IPHONE == targetPlatform
								or cc.PLATFORM_OS_ANDROID == targetPlatform
								or cc.PLATFORM_OS_IPAD == targetPlatform
								then
								local videoFullPath = cc.FileUtils:getInstance():fullPathForFilename("video/video.mp4")
								if cc.FileUtils:getInstance():isFileExist(videoFullPath) == true then
									local function onVideoEventCallback(sener, eventType)
										if eventType == ccexp.VideoPlayerEvent.PLAYING then
											-- print("PLAYING")
										elseif eventType == ccexp.VideoPlayerEvent.PAUSED then
											-- print("PAUSED")
											app.load("client.operation.Config")
											self.exitLogo = true
											sener:setVisible(false)
											self.videoPlayer = nil
										elseif eventType == ccexp.VideoPlayerEvent.STOPPED then
											-- print("STOPPED")
											app.load("client.operation.Config")
											self.exitLogo = true
											sener:setVisible(false)
											self.videoPlayer = nil
										elseif eventType == ccexp.VideoPlayerEvent.COMPLETED then
											-- print("COMPLETED")
											sener:stop()
											self.videoPlayer = nil
											if cc.PLATFORM_OS_ANDROID == targetPlatform then
												app.load("client.operation.Config")
												self.exitLogo = true
												sener:setVisible(false)
												self.videoPlayer = nil
											end
										end
									end
									if __lua_project_id == __lua_project_digimon_adventure 
										or __lua_project_id == __lua_project_naruto 
										or __lua_project_id == __lua_project_pokemon 
										or __lua_project_id == __lua_project_rouge 
										or __lua_project_id == __lua_project_yugioh 
										or __lua_project_id == __lua_project_warship_girl_b 
										then
										if ___is_open_video == false then 
											app.load("client.operation.Config")
											self.exitLogo = true
											return
										end
									end						    
									local videoPlayer = ccexp.VideoPlayer:create()
									local layerSize = self:getContentSize()
									videoPlayer:setAnchorPoint(cc.p(0, 0))
									local widgetSize = app.screenSize
									if __lua_project_id == __lua_project_warship_girl_a 
										or __lua_project_id == __lua_project_warship_girl_b 
										or __lua_project_id == __lua_project_digimon_adventure 
										or __lua_project_id == __lua_project_naruto 
										or __lua_project_id == __lua_project_pokemon 
										or __lua_project_id == __lua_project_rouge 
										or __lua_project_id == __lua_project_yugioh 
										then
										videoPlayer:setPosition(cc.p(app.baseOffsetX/2, layerSize.height/17))
										videoPlayer:setContentSize(cc.size(layerSize.width - app.baseOffsetX, layerSize.height - app.baseOffsetY))
									else
										videoPlayer:setPosition(cc.p(0, 0))
										-- videoPlayer:setContentSize(cc.size(layerSize.width - app.baseOffsetX, layerSize.height))
										videoPlayer:setContentSize(cc.size(layerSize.width, layerSize.height))
									end
									videoPlayer:addEventListener(onVideoEventCallback)
									self:addChild(videoPlayer, -1)
									self.videoPlayer = videoPlayer

									videoPlayer:setFileName(videoFullPath)   
									videoPlayer:play()
									-- videoPlayer:setFullScreenEnabled(true)
								else
									app.load("client.operation.Config")
									self.exitLogo = true
								end
							else
								app.load("client.operation.Config")
								self.exitLogo = true
							end
						else
							app.load("client.operation.Config")
							self.exitLogo = true
						end
					end
				else
					if #_lua_release_language_param > 1 then
						local _current_language = cc.UserDefault:getInstance():getStringForKey("current_language", "")
						if _current_language ~= "" then
							m_curr_choose_language = _current_language
							app.setSearchPaths(_current_language)
						else
							cc.UserDefault:getInstance():setStringForKey("current_language", "zh_TW")
							m_curr_choose_language = "zh_TW"
							cc.UserDefault:getInstance():flush()
						end
					else
						m_curr_choose_language = app.configJson.ReleaseLanguage
					end
					state_machine.excute("logo_check_assets", 0, "change to 'AssetsManagerEx'")
				end
	        end
	    end)
	    -- assert(action:IsAnimationInfoExists("in") == true, "in animation didn't exist")
	    -- action:play("in", true)
	    self:addChild(csbLogo)
    end

    -- app.load("client.operation.Config")  
	local function responseGetServerListCallback(response)
        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
        	local result = cc.FileUtils:getInstance():isFileExist("language/ps/data/TipStringInfo.lua")
        	if _ED.all_servers ~= nil and table.nums(_ED.all_servers) == 1 then
            	for i,v in pairs(_ED.all_servers) do
            		if v ~= nil and zstring.tonumber(v.server_number)%1000 == 999 then
                		if result == true then
                    		app.setSearchPaths("ps")
							self.isMp4 = false
                		end
            		end
        		end
        		addLogoCsb()
        	else
        		addLogoCsb()
        	end
		else
			if response.node._request_count < 2 then
				response.node._request_count = response.node._request_count + 1
				NetworkView:reconnectErase(nil)
    			NetworkManager:register(protocol_command.new_get_server_list.code, app.configJson.url, nil, nil, self, responseGetServerListCallback, false, nil)
			end
		end
    end
    --启动
    self._request_count = 0
    NetworkView:reconnectErase(nil)
    NetworkManager:register(protocol_command.new_get_server_list.code, app.configJson.url, nil, nil, self, responseGetServerListCallback, false, nil)
    -- jttd.myDataSubmitted("1","")
end

function Logo:inAssetsManagerExPage()
    state_machine.excute("logo_check_assets", 0, "change to 'AssetsManagerEx'")
end

function Logo:onExit()
	self.videoPlayer = nil
	state_machine.remove("logo_check_assets")
	state_machine.remove("logo_activate_app")
	state_machine.remove("logo_stop_video")
end

return Logo:new()