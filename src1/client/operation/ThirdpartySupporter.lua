CC_SUBMIT_CRASH_REPORT								= -1000
CC_APPLICTION_RESUME								= -311
CC_APPLICTION_PAUSE									= -310
CC_CALL_SYSTEM_GC_COLLECT							= -300
SYS_EXIT_APPLICATION								= -200	--退出系统应用
SHOW_EDITBOX		                                = -100	--显示编辑区域
SHOW_SYS_EXIT_DIALOG                                = -2	--显示系统退出对话
SHOW_EXIT_DIALOG                                    = -1	--显示退出对话
CHECK_CDN_DOWNLOAD_STATE	                        = -5	--下载完成或者缺失资源（1，2，文件名）1表示中断下载完成，2表示开始下载完成一个包
CHECK_CDN_SYNC_DOWNLOAD_RESOURCES					= -4	--请求中断下载
CHECK_CDN_DOWNLOAD_RESOURCES                        = -3	--请求开始下载
UPDATEVERSION                                       = 0		--版本更新
UPDATE_NO_NEW_VERSION                               = 1		--没有可以更新的版本
UPDATE_FORCE_UPDATE_CANCEL_BY_USER                  = 2		--用户取消强制更新
UPDATE_NORMAL_UPDATE_CANCEL_BY_USER                 = 3		--用户取消普通更新
UPDATE_NEW_VERSION_DOWNLOAD_FAIL                    = 4		--新版本更新失败
UPDATE_CHECK_NEW_VERSION_FAIL                       = 5		--新版本更新检查失败
LOGIN                                               = 10	--登录
LOGIN_SUCCESS                                       = 11	--登入成功
LOGIN_CANCEL                                        = 12	--登入取消
LOGIN_LOSE                                          = 13	--登入失败
LOGIN_AGAIN											= 14	--重新登录
LOGOUT                                              = 20	--注销，切换账号
LOGOUT_SUCCESS	                                    = 21	--注销成功
ENTERPLATFORM									    = 30	--登录平台
PLATFORMRECHARGE									= 40	--平台充值
RECHARGESUCCESS                                     = 41	--平台充值成功
RECHARGELOSE                                        = 42	--平台充值失败
CC_INITIALIZE_RECHARGE_PARAM                        = 43	--初始化App
RETURNLOGINFACE									 	= 50	--取消平台充值
REGISTER											= 60	--注册
REGISTER_USER_ALREADER_EXIST						= 61	--注册用户已经存在
REGISTER_SUCCESS									= 62	--注册成功
REGISTER_LOSE										= 63	--注册失败
CHECK_USER											= 70	--检查用户
CHECK_USER_ALREADER_EXIST							= 71	--检查用户已经存在
CHECK_USER_NONEXISTENT								= 72	--检查用户不存在
VERIFY_RECEIPT_SOUCCESS							 	= 80	--核实收据成功
SAVE_RECEIPT										= 81	--储存收据
CLEAR_RECEIPT										= 82	--清除收据
REGISTER_ONEREGISTER								= 90	--注册一个账号
REGISTER_ONEREGISTER_SUCCESS						= 91	--注册一个账号成功
REGISTER_ONEREGISTER_LOSE							= 92	--注册一个账号失败
BINDACCOUNT										 	= 100	--绑定账号
BINDACCOUNT_SUCCESS								 	= 101	--绑定账号成功
BINDACCOUNT_LOSE									= 102	--绑定账号失败
COLLECT_CRASH_REPORT								= 110	--收集崩溃信息
COLLECT_CRASH_REPORT_END							= 111	--收集崩溃信息结束
OURPALM_FINDONEUSER								 	= 120	--找到一个掌趣用户
OURPALM_JUDGEUSER									= 121	--发现掌趣用户
ENTERED_THE_GAME									= 130	--进入游戏
INIT_APP_NAME										= 140	--初始化应用名称
BUG_FEEDBACK										= 150	--BUG反馈
BUG_SUBMIT_TO_91PLATFORM							= 151	--BUG提交给19平台
INIT_PLATFORM_EXTRAS								= 160	--初始化平台附加信息
INIT_OPERATION_PARAMS								= 161
PLATFORM_ACCOUNT_MANAGER							= 170	--平台账号管理
CC_MARKETPLACE_REVIEW_TASK							= 180
CC_MEET_THE_OF_AGE_13_TASK							= 181
CC_OPEN_URL										 	= 190
FOUND_ROLE											= 191	--创建角色
CC_OPEN_URL_LAYOUT									= 192   --打开url布局
CC_PLATFORM_TYPE									= 193   --确定平台类型
CC_EXIT_PLATFORM							 	    = 200
CC_LOGOUTGAME							 			= 210
CC_INIT_PLATFORM_PARAM						 		= 220
CC_CLEAN_PLATFORM_PARAM						     	= 230
CC_PLATFORM_PAUSE								    = 240
CC_PLATFORM_RESUME								    = 250
CC_DESTORY_PLATFORM								 	= 260
CC_ENTER_PLATFORM_BBS								= 270
CC_MARKETPLACE_DETAIL_TASK							= 280
CC_SHOW_GAME_CENTER								 	= 290		
CC_SHOW_GLEADERBOARD								= 300		
CC_SHOWACHIEVEMENT									= 310
CC_ADD_DOWNLOAD_URL								 	= 320
CC_DELETE_DOWNLOAD_FOLDER							= 321
CC_TRANSFER_PROGRESS								= 322
CC_TRANSFER_ERROR									= 323
CC_TRANSFER_FILE_UNZIP								= 324
CC_SYSTEM_PAUSE										= 325
CC_EXIT_APPLICATION							 	 	= 326
CC_SYSTEM_SOFTKEYBOARD							 	= 327
CC_INIT_TALKINGDATA							 	    = 330
CC_RESUME_TALKINGDATA							 	= 331
CC_PAUSE_TALKINGDATA							 	= 332
CC_TALKINGDATA_SET_ACCOUNT						 	= 333
CC_TALKINGDATA_SET_ACCOUNT_TYPE				 	 	= 334
CC_TALKINGDATA_SET_ACCOUNT_NAME				 	 	= 335
CC_TALKINGDATA_SET_LEVEL						 	= 336
CC_TALKINGDATA_SET_GENDER						 	= 337
CC_TALKINGDATA_SET_AGE		  					 	= 338
CC_TALKINGDATA_SET_GAME_SERVER					 	= 339
CC_TALKINGDATA_RECHARGE_CHANGE_REQUEST			 	= 340
CC_TALKINGDATA_RECHARGE_CHANGE_SUCCESS			 	= 341
CC_TALKINGDATA_REWARD_GOLD						 	= 342
CC_TALKINGDATA_PURCHASE						 	 	= 343
CC_TALKINGDATA_USE								 	= 344
CC_TALKINGDATA_TASK_BEGIN						 	= 345
CC_TALKINGDATA_TASK_COMPLETED					 	= 346
CC_TALKINGDATA_TASK_FAILED						 	= 347
CC_TALKINGDATA_CUSTOM_EVENT					 	 	= 348
CC_FACEBOOK_CLOSE									= 400	--facebook退出
CC_GET_SERVERS_ID									= 401	--获取服务器id
CC_BUY_PROP											= 402	--购买道具
CC_IS_DISPLAY_PLATFORM								= 410--显示个人中心
CC_IS_DISPLAY_ACCOUNT								= 411--显示切换账号
COLLECT_CRASH_REPORT_TESTIN							= 500--testin的崩溃追踪
CC_GET_PAY_INFO										= 2500 --获取支付信息
CC_PAY_INFO_OVER									= 2501 --获取支付信息结束
CC_PLATFORM_SHOW_BUOY								= 2600 --显示平台的浮标
CC_PLATFORM_HIDE_BUOY								= 2601 --隐藏平台的浮标
CC_GAME_OPEN_EXIT									= 2602 --打开游戏退出界面
CC_GAME_EXIT_DETERMINE								= 2603 --游戏退出界面确定
CC_GAME_DAYA_TRACKING								= 3000 --登陆成功后的数据报送
CC_GAME_PAYSUCCESS_TRACKING							= 3001 --支付成功后的数据报送
CC_ROLE_CREATION									= 3002 --角色创建
CC_ROLE_UPGRADE										= 3003 --角色升级
CC_FORM_OFFSET_REDUCTION							= 3004 --界面偏移还原
CC_SHARE_REQUEST									= 3005 --请求分享
CC_SHARE_SUCCESS									= 3006 --分享成功
CC_SCORE_START										= 3007 --请求评分
CC_SCORE_SUCCESS									= 3008 --评分成功
CC_GET_CURRENT_LANGUAGE								= 4000 --获取当前系统语言环境
CC_GET_PUSH_NOTIFICATION							= 4001 --本地推送信息
CC_GET_EXTERNAL_PATH								= 4002 --获取
CC_OPEN_FANS_PAGE									= 4003 --进入粉丝页
CC_FACEBOOK_FRIENDS_REQUEST							= 4004 --facebook好友请求
CC_FACEBOOK_FRIENDS_RETURN							= 4005 --facebook好友返回
CC_FACEBOOK_FRIENDS_INVITE							= 4006 --facebook好友邀请
CC_FACEBOOK_FRIENDS_INVITE_SUCCESS					= 4007 --facebook好友邀请成功
CC_GET_PUSH_NOTIFICATION_REQUEST					= 4008 --本地推送信息请求
CC_VOICE_SEND_REQUEST								= 4009 --语音发送请求
CC_VOICE_SEND_OVER                                  = 4010 --语音发送结束
CC_VOICE_RECEIVE_SUCCESS							= 4011 --语音接收成功
CC_VOICE_URL_PLAY									= 4012 --网路语音播放
CC_PREVENT_DECOMPILE_ONE							= 4013 --防止反编译控制1
CC_PREVENT_DECOMPILE_TWO							= 4014 --防止反编译控制2
CC_COPY_PASTE_TEXT_START							= 4015 --COPY并粘贴text开始
CC_COPY_PASTE_TEXT_OVER								= 4016 --COPY并粘贴text结束
CC_FACEBOOK_ACTIVITY                                = 4017 --facebook按钮状态
CC_GOTO_EVALUATEGAME                                = 4018 --前往评价游戏
CC_FACEBOOK_LIKES							 	 	= 4019 --FaceBook点赞
CC_FACEBOOK_APPEVENTSLOGGER							= 4020 --FACEBOOK的事件埋点
CC_FACEBOOK_BE_INVITED                              = 4022 --facebook点击被邀请领奖如果未登陆则请求
CC_REMOVE_PUSH_NOTIFICATION							= 4023 --本地推送清除
CC_FACEBOOK_HOME                                    = 4024 --facebook客户端
CC_GET_SIGNAL_AND_NETWORK							= 4025 --信号强度网络延迟
CC_GET_RETURN_SIGNAL_AND_NETWORK					= 4026 --返回信号强度网络延迟
CC_SENT_INPUT_INFO									= 4027 --输入框确认按钮信息
CC_DATA_STATISTICS									= 4028 --数据信息统计
CC_USER_CENTER										= 4029 --T4SDK用户中心
CC_RECHAEGE_LIST 									= 4030 --T4SDK充值列表	



platform_extras = ""
package_rc = "1.0"
m_sURL = ""
m_sURL_IP = ""
m_tOperateSystem = 3
m_tOperator = "jar-world"
m_tOperationPlatform = 1
m_tUserAccountPlatform = 1
m_tApplicationStore = 1
m_tReleaseLanguage = 1
m_tReleaseVersionStyle = 1
m_tReleaseProject = 5
m_sOperatorName = app.configJson.OperatorName
m_sOperationPlatformName = app.configJson.OperationPlatformName
m_sUserAccountPlatformName = app.configJson.UserAccountPlatformName
m_sUserAccountPlatformNameExt = ""
m_sUserAccountPlatformNameExtTwo = ""
m_sPayMould = ""
m_iStartLogCount = 1
m_sOperateSystemName = ""
m_tResourceMap = 0
m_tResourcePicture = 0
m_sVersion = app.configJson.version

m_sUin = ""
m_sSessionId = ""
m_platformTokenKey = ""
m_platformRefreshtokens = ""

m_interior_url=""

m_register_username=""
m_register_password=""

m_reqcharge_info = {}

m_platform_tx_login_info = ""

m_platform_app_value = ""
m_platform_app_ptext = ""

m_tx_pay_start = false
m_tx_pay_over = false

m_tx_pay_index = 0

m_get_pay_info = 0

m_roleName_info = ""

m_current_language = "zh-cn"

m_videoPlayer = nil

m_show_data_aid = nil

--facebook进入游戏的好友
m_aladion_facebook_friends = ""
--facebook未进入游戏的好友
m_aladion_facebook_graph_path = ""
--邀请了的facebook好友
m_aladion_facebook_invite = ""

m_push_platform_id = ""

m_tencent_pay_number = 1
m_play_pay_type = ""

m_loading_start = true

m_channel_confirm = false

m_copy_paste_text_info = nil

m_fb_button_show = 1

m_my_fb_id = nil --当前登陆的facebook id

m_curr_choose_language = ""

m_recharge_protocol_is_ok = false
m_recharge_thirdparty_is_ok = false

m_account_sys_floating_switch = false

m_account_sys_user_name = ""
m_account_sys_user_password = ""

m_first_role = false

m_login_search_user = false

function Sleep(n)
   os.execute("sleep " .. n)
end

local function submitCrashReport(pText)
	--push_method("::submitCrashReport")
	--local ss = print_crash_reoprt_log()
	--pop_method()
	
	local errorFunc = "LUA Func\r\n"
	local errorLine = "0\r\n"
	local errorName = "LUA ERROR\r\n"
	local errorMsg = "LUA ERROR: " .. debug.traceback() .. "\r\n"
	local traceback = pText
	local tbString = errorFunc..errorLine..errorName..errorMsg .. traceback
	if protocol_command.record_crash.param_list ~= tbString then
		protocol_command.record_crash.param_list = tbString
        	local request = NetworkManager:register(protocol_command.record_crash.code, nil, nil, nil, nil, nil, false, nil)
		NetworkAdaptor.send(request)
	end
	
	Sleep(2)
end
local function responseSearchUserPlatform(_cObj, _tJsd)
	local pNode = tolua.cast(_cObj, "CCNode")
	local pDataInterpreter = tolua.cast(_tJsd, "CCNetworkDataInterpreter")
	if pDataInterpreter ~= nil and pDataInterpreter:isSucceed() then
	end
	local user_info = _ED.user_platform[_ED.default_user]
		-- if table.getn(_ED.user_platform) > 0 then
	if m_sUserAccountPlatformNameExt == "jar-world" then
		if user_info ~= nil then
			-- userId:setText(user_info.platform_account)
			handlePlatformRequest(0, LOGIN, user_info.platform_account.."|"..user_info.password)
		else
			--userId:setText(_string_piece_info[210])
			handlePlatformRequest(0, LOGIN, "")
		end	
	end	
end

local function thirdpartyresponseLogin(_cObj, _tJsd)	
	local pNode = tolua.cast(_cObj, "CCNode")
	local pDataInterpreter = tolua.cast(_tJsd, "CCNetworkDataInterpreter")
	if pDataInterpreter ~= nil and pDataInterpreter:isSucceed() then
	else
		Sender(protocol_command.search_user_platform.code, nil, nil, nil, nil, responseSearchUserPlatform, 1)
	end
end

local function thirdpartyresponseRegister(_cObj, _tJsd)
	local pNode = tolua.cast(_cObj, "CCNode")
	local pDataInterpreter = tolua.cast(_tJsd, "CCNetworkDataInterpreter")
	if pDataInterpreter ~= nil and pDataInterpreter:isSucceed() then
		handlePlatformRequest(0, REGISTER_SUCCESS, "")
	end
end

local handlePlatformResponse = nil

handlePlatformResponse = function(response, pText, value)
	if handlePlatformResponseExt ~= nil then
		if handlePlatformResponseExt(response, pText, value) == true then
			return
		end
	end
	if CC_SUBMIT_CRASH_REPORT == response or COLLECT_CRASH_REPORT == response then
		submitCrashReport(pText)
	elseif INIT_PLATFORM_EXTRAS == response then
		platform_extras = pText
		local function responseActivateAppCallback(response)
			if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
				
			end
		end
		if app.configJson.dpurl ~= nil and app.configJson.dpurl ~= "" then
			NetworkManager:register(protocol_command.activate_app.code, app.configJson.dpurl, nil, nil, nil, responseActivateAppCallback, false, nil)
		end
		-- 开机统计设备信息
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		else
			if jttd ~= nil then
				jttd.init(jttd_app_id, m_sUserAccountPlatformName)
				-- jttd.gameinfo(gameinfo_params.open_app)
				jttd.myDataSubmitted("1","")
			end
		end

	elseif INIT_OPERATION_PARAMS == response then
		local params = zstring.split(pText, ",")
		m_sOperateSystemName = cc.Application:getInstance():getTargetPlatform()						--操作系统名称
		m_tOperateSystem = app.configJson.OperateSystem--操作系统
		m_tReleaseLanguage = app.configJson.ReleaseLanguage--发布语言
		m_tReleaseProject = app.configJson.ReleaseProject--发布项目
		__lua_project_id = zstring.tonumber(m_tReleaseProject)
		m_sOperatorName = app.configJson.OperatorName	--运营商名称
		local sliptPlatformName = zstring.split(app.configJson.OperationPlatformName,"|")
		m_sOperationPlatformName = sliptPlatformName[1] == nil and app.configJson.OperationPlatformName or sliptPlatformName[1] --操作平台的名字
		m_sUserAccountPlatformNameExt = sliptPlatformName[2]	--操作平台的名字1
		m_sUserAccountPlatformNameExtTwo = sliptPlatformName[3] --操作平台的名字2
		m_sUserAccountPlatformName = app.configJson.UserAccountPlatformName	--用户账户来源
		m_sPayMould = app.configJson.PayMould					--支付类型
		m_sVersion = app.configJson.version						--资源版本号
		
		package_rc = cc.UserDefault:getInstance():getStringForKey("package")
		cc.UserDefault:getInstance():flush()
		if #package_rc <= 0 then
			package_rc = "0.0"
		end
	elseif LOGOUT_SUCCESS == response then
		if fwin:find("MainWindowClass")~= nil then
			fwin:close(fwin:find("MainWindowClass"))
		end
		-- if _ED.m_is_games == true then
			if app.configJson.OperatorName == "tencent" or app.configJson.OperatorName == "move" then
				if app.configJson.OperatorName == "move" then
					cc.UserDefault:getInstance():setStringForKey("moveLofinType", "0")
					cc.UserDefault:getInstance():flush()
				end
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
				m_sUin = nil
				fwin:removeAll()
				fwin:reset(nil)
				initialize_ed()
				fwin:open(Login:new(), fwin._view)
				fwin:close(fwin:find("ConnectingViewClass"))
				_ED.m_is_games = false
				-- state_machine.excute("platform_manager_open_sdk_interface", 0, "platform_manager_open_sdk_interface.")
				-- fwin:close(fwin:find("ConnectingViewClass"))
				return
			end
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
			m_sUin = nil
			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				fwin:addService({
                    callback = function ( params )
                        fwin:removeAll()
                        initialize_ed()
                        -- fwin:reset(nil)
                        fwin:open(Login:new(), fwin._view)
                        fwin:close(fwin:find("ConnectingViewClass"))
                        _ED.m_is_games = false
                    end,
                    delay = 0.1,
                    params = self
                })
			else	
				fwin:removeAll()
				fwin:reset(nil)
				initialize_ed()
				fwin:open(Login:new(), fwin._view)
				fwin:close(fwin:find("ConnectingViewClass"))
				_ED.m_is_games = false
			end
			
			if app.configJson.OperatorName == "pps" then
				if pText~= "" and pText~=nil then
					local params = zstring.split(pText, "|")
					m_sUin = params[1]
					state_machine.excute("platform_manager_login_success", 0, { platformInfo = params[1] })
					for i=1, #_app_push_notification do
						local _app_delayTime = 0
						if _app_push_notification[i][3] ~= "?" then
							_app_delayTime = 0
						else
							_app_delayTime = -1
						end
						state_machine.excute("platform_push_request", 0, { pushid = i , delayTime=_app_delayTime})
					end
				end
			end
		-- end
	elseif ENTERED_THE_GAME == response then
		state_machine.excute("platform_manager_sdk_init_success", 0, "platform_manager_sdk_init_success.")
	elseif CHECK_USER_ALREADER_EXIST == response then
		fwin:open(ConnectingView:new(), fwin._windows)
		fwin:close(fwin:find("platformSDKLoginTencentClass"))
	elseif LOGIN_SUCCESS == response then
		-- 登录成功
		m_loading_start = true
		fwin:close(fwin:find("platformSDKLoginTencentClass"))
		local params = zstring.split(pText, "|")
		m_sUin = params[1]
		if app.configJson.OperatorName == "tencent" or app.configJson.OperatorName == "gdtppk" then
			state_machine.excute("platform_manager_login_success", 0, { platformInfo = params[1], platformAdditional = params[2]})
		else
			state_machine.excute("platform_manager_login_success", 0, { platformInfo = params[1] })
		end
		state_machine.unlock("platform_sdk_google_login", 0, "")
        state_machine.unlock("platform_sdk_facebook_login", 0, "")
        state_machine.unlock("platform_sdk_hotgame_login", 0, "")
		fwin:close(fwin:find("platformSDKLoginMoveClass"))
	elseif LOGIN_LOSE == response then
		m_loading_start = true
		state_machine.unlock("platform_sdk_google_login", 0, "")
        state_machine.unlock("platform_sdk_facebook_login", 0, "")
        state_machine.unlock("platform_sdk_hotgame_login", 0, "")
		state_machine.excute("platform_manager_login_lose", 0, "platform_manager_login_lose.")
	elseif RECHARGESUCCESS == response then
		--充值成功
		m_platform_app_value = value
		m_platform_app_ptext = pText
		m_play_pay_type = ""
		if __lua_project_id == __lua_project_red_alert then
			if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_IPHONE or cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_IPAD then
				if app.configJson.OperatorName == "play800" then
					if zstring.tonumber(pText) == 1 then
						m_play_pay_type = "_ApplePay"
					elseif zstring.tonumber(pText) == 2 then
						m_play_pay_type = "_Alipay"
					else
						m_play_pay_type = "_WechatPay"
					end
				end
			end
		end
		state_machine.excute("platform_the_success_of_payment", 0, "platform_the_success_of_payment.")
		fwin:close(fwin:find("ConnectingViewClass"))
		state_machine.unlock("recharge_list_button")
		m_recharge_thirdparty_is_ok = true
	elseif RECHARGELOSE == response then
		fwin:close(fwin:find("ConnectingViewClass"))
		state_machine.unlock("recharge_list_button")
		if app.configJson.OperatorName == "t4" then
			jttd.facebookAPPeventSlogger("9")
		end
	elseif CC_APPLICTION_RESUME == response then
		-- NetworkAdaptor.restartSocket()
		againPlayBgm()
		if nil ~= play2dResume then
			play2dResume()
		end
		cc.SimpleAudioEngine:getInstance():resumeAllEffects()
		if m_videoPlayer ~= nil then
			m_videoPlayer.resume();
		end
		if _ED.user_info == nil or _ED.user_info.user_id == nil or _ED.user_info.user_id == "" then
			return
		end	
        local url = NetworkAdaptor.LuaSocket.url
		NetworkAdaptor.socketClose()
		fwin:addService({
        	callback = function ( params )
                NetworkAdaptor.LuaSocket.url = params
				if nil ~= NetworkAdaptor.LuaSocket.url then
					-- NetworkAdaptor.LuaSocket.heartbeat = true
					-- NetworkAdaptor.socketSend("heartbeat")
					NetworkAdaptor.intSocket()
				end
	        end,
	        delay = 3,
	        params = url
	    })
	
		handlePlatformRequest(0, CC_RESUME_TALKINGDATA, "")
		
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			fwin:addService({
	        	callback = function ( params )
					if fwin:find("redAlertTimeMineEventQueueClass") ~= nil then
						state_machine.excute("red_alert_time_mine_event_queue_update_show_lists", 0, 0)
					end
					if fwin:find("WonderfulClass") ~= nil and fwin:find("RedAlertTimeOnlineRewardClass") ~= nil then
						state_machine.excute("red_alert_time_online_reward_activity_codes", 0, 0)
					end
		        end,
		        delay = 3,
		        params = nil
		    })
		    NetworkManager:register(protocol_command.verify_system_time.code, nil, nil, nil, nil, nil, false, nil)
		else
			if _ED._is_recharge_succeed == true then
				Sender(protocol_command.vali_top_up_order_number.code, nil, nil, nil, nil, nil, -1)
				_ED._is_recharge_succeed = false
			end
			if fwin:find("LoginClass") == nil then
				NetworkManager:register(protocol_command.keep_alive.code, nil, nil, nil, nil, nil, false, nil)
			end
		end
		
		--fwin._frameview:setPosition(cc.p(0,0)) --暂时屏蔽防止报错  应该是改成fwin._layer
	elseif CC_APPLICTION_PAUSE == response then
		handlePlatformRequest(0, CC_PAUSE_TALKINGDATA, "")
		if m_videoPlayer ~= nil then
			m_videoPlayer.pause();
		end
		if nil ~= play2dPause then
			play2dPause()
		end
		cc.SimpleAudioEngine:getInstance():pauseAllEffects()
	elseif SAVE_RECEIPT == response then
		if cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_WINDOWS 
			and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_LINUX 
			and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_MAC then
			if app.configJson.OperatorName == "jar-world" or (app.configJson.OperatorName == "play800" and app.configJson.PayOperatorName == "app") 
				or (app.configJson.OperatorName == "play800-2" and app.configJson.PayOperatorName == "app") 
				or (app.configJson.OperatorName == "88box" and app.configJson.PayOperatorName == "app" )
				or (app.configJson.OperatorName == "pocket" and app.configJson.PayOperatorName == "app") 
				or app.configJson.OperatorName == "t4" or app.configJson.OperatorName == "move" 
				or app.configJson.OperatorName == "cayenne"
				then
				local met = "p"
				met = met..value
				local zdr = _ED.user_info.user_id
				zdr = zdr.."|"
				zdr = zdr..value
				zdr = zdr.."|"
				zdr = zdr.._ED.selected_server
				cc.UserDefault:getInstance():setStringForKey(met, zdr)
				cc.UserDefault:getInstance():flush()
				-- 添加苹果充值的记录
				cc.UserDefault:getInstance():setStringForKey("AppStoreRecharge", zdr.."|"..pText)
				cc.UserDefault:getInstance():flush()

			elseif app.configJson.OperatorName == "tencent" or app.configJson.OperatorName == "gdtppk" then
				cc.UserDefault:getInstance():setStringForKey("tencentPay", pText)
				cc.UserDefault:getInstance():flush()
			end
		end
	elseif CLEAR_RECEIPT == response then
		if cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_WINDOWS 
			and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_LINUX 
			and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_MAC then
			if app.configJson.OperatorName == "jar-world" or (app.configJson.OperatorName == "play800" and app.configJson.PayOperatorName == "app") 
				or (app.configJson.OperatorName == "play800-2" and app.configJson.PayOperatorName == "app") 
				or (app.configJson.OperatorName == "88box" and app.configJson.PayOperatorName == "app")
				or (app.configJson.OperatorName == "pocket" and app.configJson.PayOperatorName == "app") 
				or app.configJson.OperatorName == "t4" or app.configJson.OperatorName == "move" 
				or app.configJson.OperatorName == "cayenne"
				then
				local met = "p"
				met = met..value
				cc.UserDefault:getInstance():setStringForKey(met, "")
				cc.UserDefault:getInstance():setStringForKey("AppStoreRecharge", "")
			elseif app.configJson.OperatorName == "tencent" or app.configJson.OperatorName == "gdtppk" then	
				cc.UserDefault:getInstance():setStringForKey("tencentPay", "-1")
			end
			cc.UserDefault:getInstance():flush()
			fwin:close(fwin:find("ConnectingViewClass"))
			handlePlatformRequest(0, CC_GAME_PAYSUCCESS_TRACKING, "")
			if app.configJson.OperatorName == "aladin" and fwin:find("platformSDKPayAladinClass")~= nil then
				fwin:close(fwin:find("platformSDKPayAladinClass"))
			end
		end
	elseif CC_PAY_INFO_OVER == response then
		state_machine.excute("platform_get_pay_info_over", 0, "platform_get_pay_info_over.")
	elseif CC_GAME_OPEN_EXIT == response then
		state_machine.excute("open_exit_game_view", 0, "open_exit_game_view.")
	elseif CC_FORM_OFFSET_REDUCTION == response then
		local scene = fwin._framewindow -- cc.Director:getInstance():getRunningScene()
		scene:runAction(cc.MoveTo:create(0.225, cc.p(0, 0)))
	elseif CC_PLATFORM_RESUME == response then
		state_machine.excute("shortcut_function_cc_platform_resume", 0, "shortcut_function_cc_platform_resume.")
	elseif CC_PLATFORM_PAUSE == response then
		state_machine.excute("shortcut_function_cc_platform_pause", 0, "shortcut_function_cc_platform_pause.")
	elseif CC_SHARE_SUCCESS == response then
		if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game 
		or __lua_project_id == __lua_project_adventure then			--龙虎门，冒险与挖矿项目控制
			if __lua_project_id == __lua_project_l_naruto then
				TipDlg.drawTextDailog(game_share_tip_text[1])
				function responseGetServerListCallback( response )
					
				end
				NetworkManager:register(protocol_command.face_book_share_complete.code, nil, nil, nil, nil, responseGetServerListCallback, false, nil)
			end

		elseif __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			state_machine.excute("platform_fb_info_command",0,5)
		else
			-- state_machine.excute("platform_the_share_success", 0, "platform_the_share_success.")
			if pText == nil or pText == "" then
				state_machine.excute("platform_the_share_success", 0, "platform_the_share_success.")
			else
				state_machine.excute("home_get_share_ok", 0, zstring.tonumber(pText))
			end
			
		end
	elseif CC_SCORE_SUCCESS == response then
		state_machine.excute("adventure_share_grade_success", 0, "adventure_share_grade_success.")
	elseif CC_GET_CURRENT_LANGUAGE == response then
		m_current_language = pText
		if #_lua_release_language_param > 1 then
			local _current_language = cc.UserDefault:getInstance():getStringForKey("current_language", "")
			if _current_language == "" then
				if m_current_language ~= nil then
					local lparms = zstring.split(m_current_language, "-")
					if lparms[1] == "zh" then
						m_curr_choose_language = "zh_TW"
						cc.UserDefault:getInstance():setStringForKey("current_language", "zh_TW")
						cc.UserDefault:getInstance():flush()
					else
						m_curr_choose_language = "en"
						cc.UserDefault:getInstance():setStringForKey("current_language", "en")
						cc.UserDefault:getInstance():flush()
						app.setSearchPaths("en")
					end
				else
					m_curr_choose_language = "en"
					cc.UserDefault:getInstance():setStringForKey("current_language", "en")
					cc.UserDefault:getInstance():flush()
					app.setSearchPaths("en")
				end
			else
				m_curr_choose_language = _current_language
				app.setSearchPaths(_current_language)
			end
			local initial_language = cc.UserDefault:getInstance():getStringForKey("m_initial_language")
			if initial_language == "" then
				local language = cc.UserDefault:getInstance():getStringForKey("current_language")
				cc.UserDefault:getInstance():setStringForKey("m_initial_language", language)
				cc.UserDefault:getInstance():flush()
			end
			if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_ANDROID then
				handlePlatformRequest(0, CC_INIT_TALKINGDATA, "E2BE67B1E6EB4645B171908C958EDE2B".."|"..cc.UserDefault:getInstance():getStringForKey("m_initial_language"))
			else
				handlePlatformRequest(0, CC_INIT_TALKINGDATA, "BDF5F52EEB144180AB41D5FEEFAEA6ED".."|"..cc.UserDefault:getInstance():getStringForKey("m_initial_language"))
			end
		end
	elseif CC_SYSTEM_SOFTKEYBOARD == response then
		local params = zstring.split(pText, ",")
		fwin._framewindow:setPositionY(zstring.tonumber(params[1]))
	elseif CC_SYSTEM_PAUSE == response then
		m_show_data_aid = pText
	elseif CC_FACEBOOK_FRIENDS_RETURN == response then
		-- local params = zstring.split(pText, "@")
		-- m_aladion_facebook_friends = params[1]
		fwin:close(fwin:find("ConnectingViewClass"))
		m_aladion_facebook_graph_path = pText
		if m_aladion_facebook_graph_path ~= nil or m_aladion_facebook_graph_path ~= "" then
			if fwin:find("platformFbMethodClass") ~= nil then
				state_machine.excute("platform_fb_friend_invite_open", 0, "platform_fb_friend_invite_open.")
			end
		end
		-- if m_aladion_facebook_friends == nil or m_aladion_facebook_friends == "" then
			-- protocol_command.friend_invite_init.param_list = "-1"
		-- else
			-- local m_friends = zstring.split(m_aladion_facebook_friends, "|")
			-- for i=1, #m_friends do
				-- local m_friends_info = zstring.split(m_friends[i], ",")
				-- if i == #m_friends then
					-- protocol_command.friend_invite_init.param_list = protocol_command.friend_invite_init.param_list..m_friends_info[1]
				-- else
					-- protocol_command.friend_invite_init.param_list = protocol_command.friend_invite_init.param_list..m_friends_info[1]..","
				-- end
			-- end
		-- end
		-- NetworkManager:register(protocol_command.friend_invite_init.code, m_facebook_reward, nil, nil, nil, nil, false, nil)
	elseif CC_FACEBOOK_FRIENDS_INVITE_SUCCESS == response then
		m_aladion_facebook_invite = pText
		if m_aladion_facebook_invite ~= nil and m_aladion_facebook_invite ~= "" then
			state_machine.excute("platform_fb_info_command",0,2)
		end
		-- local newinvite = zstring.split(pText, ",")
		-- if m_aladion_facebook_invite == nil or m_aladion_facebook_invite == "" then
			-- m_aladion_facebook_invite = pText
		-- else
			-- local oldInvite = zstring.split(m_aladion_facebook_invite, ",")
			-- m_aladion_facebook_invite = ""
			-- for i=1, #oldInvite do
				-- local isparams = false
				-- for j=1, #newinvite do
					-- if newinvite[j] == oldInvite[i] then
						-- isparams = true
					-- end
				-- end
				-- if isparams == false then
					-- if i== #oldInvite then
						-- m_aladion_facebook_invite = m_aladion_facebook_invite..newinvite[j]
					-- else
						-- m_aladion_facebook_invite = m_aladion_facebook_invite..newinvite[j]..","
					-- end
				-- end
			-- end
		-- end
		-- state_machine.excute("facebook_friends_invite_success", 0, m_aladion_facebook_invite)
	elseif CC_FACEBOOK_BE_INVITED == response then
		m_my_fb_id = pText
		state_machine.excute("platform_fb_login_command", 0, "platform_fb_login_command.")
	elseif CC_FACEBOOK_LIKES == response then
		if pText ~= "" and pText ~= nil and pText == 1 then
			state_machine.excute("platform_fb_info_command",0,3)
		end
	elseif CC_VOICE_RECEIVE_SUCCESS == response then
		if pText ~= "" and pText ~= nil then
			state_machine.excute("voice_send_message", 0, pText)
		end		
	elseif CC_PREVENT_DECOMPILE_ONE == response then
		if app.configJson.OperatorName ~= "uc" and app.configJson.OperatorName ~= "duoku" and app.configJson.OperatorName ~= "oppo"
			and app.configJson.OperatorName ~= "amigo" and app.configJson.OperatorName ~= "pps" and app.configJson.OperatorName ~= "sy37" 
			and app.configJson.OperatorName ~= "meizu" and app.configJson.OperatorName ~= "pptv" and app.configJson.OperatorName ~= "ewan" 
			and app.configJson.OperatorName ~= "zhangyue" and app.configJson.OperatorName ~= "kaopu" and app.configJson.OperatorName ~= "papa" 
			and app.configJson.OperatorName ~= "360" and app.configJson.OperatorName ~= "xiaomi" and app.configJson.OperatorName ~= "anzhi" 
			and app.configJson.OperatorName ~= "wdj" and app.configJson.OperatorName ~= "sougou" then
				local params = zstring.split(pText, "|")
				local signatureOne = zstring.split(params[1], "=")
				local signatureTwo = zstring.split(params[2], "=")
				if signatureOne[2] ~= "jar-world" or signatureTwo[2] ~= "jar-world" then
					m_channel_confirm = true
				end
			end
	elseif CC_PREVENT_DECOMPILE_TWO == response then
		if app.configJson.OperatorName == "uc" or app.configJson.OperatorName == "duoku" or app.configJson.OperatorName == "oppo"
			or app.configJson.OperatorName == "amigo" or app.configJson.OperatorName == "pps" or app.configJson.OperatorName == "sy37" 
			or app.configJson.OperatorName == "meizu" or app.configJson.OperatorName == "pptv" or app.configJson.OperatorName == "ewan" 
			or app.configJson.OperatorName == "zhangyue" or app.configJson.OperatorName == "kaopu" or app.configJson.OperatorName == "papa" 
			or app.configJson.OperatorName == "360" or app.configJson.OperatorName == "xiaomi" or app.configJson.OperatorName == "anzhi" 
			or app.configJson.OperatorName == "wdj" or app.configJson.OperatorName == "sougou" then
				local params = zstring.split(pText, "|")
				local _drawMonth = dms.searchs(dms["platform_SDK_parameter"], 2, app.configJson.OperatorName)
				local platformInfo = zstring.split(_drawMonth[1][3], "|")
				for j=1, #params do
					if params[j] ~= platformInfo[j] then
						m_channel_confirm = true
						return
					end
				end
			end
	elseif CC_COPY_PASTE_TEXT_OVER == response then	
		state_machine.excute("copy_paste_text", 0, pText)
	elseif CHECK_USER == response then
		if app.configJson.OperatorName == "tencent" then
			fwin:open(ConnectingView:new(), fwin._windows)
			fwin:close(fwin:find("platformSDKLoginTencentClass"))
		end
	elseif CHECK_CDN_DOWNLOAD_STATE == response then
		local downloadParam = zstring.split(pText, "|")
		local downloadStatus = downloadParam[1]
		local currentDownloadGroupId = downloadParam[2]
		local nextDownloadGroupId = nil
		local requestCode = CHECK_CDN_DOWNLOAD_RESOURCES
		if downloadStatus == "1" or downloadStatus == "2" then
			if nil ~= currentDownloadGroupId then
				local needAdd = true
				for i, v in pairs(_ED.cdn_download_resource_group_ids) do
					if v == currentDownloadGroupId then
						needAdd = false
					end
				end
				if true == needAdd then
					table.insert(_ED.cdn_download_resource_group_ids, currentDownloadGroupId)
				end
				local saveCdnDownloadResourceGroupIds = ""
				for i, v in pairs(_ED.cdn_download_resource_group_ids) do
					if #saveCdnDownloadResourceGroupIds > 0 then
						saveCdnDownloadResourceGroupIds = saveCdnDownloadResourceGroupIds .. "|"
					end
					saveCdnDownloadResourceGroupIds = saveCdnDownloadResourceGroupIds .. v
					cc.UserDefault:getInstance():setStringForKey("platformUpdateId", saveCdnDownloadResourceGroupIds)
					cc.UserDefault:getInstance():flush()
				end
				
				local nCount = #_ED.cdn_local_resource_group_ids
				for i = 1, nCount do
					local v = _ED.cdn_local_resource_group_ids[i]
					local lnCount = #_ED.cdn_download_resource_group_ids
					local downloadGroupId = v
					for l = 1, lnCount do
						if v == _ED.cdn_download_resource_group_ids[l] then
							downloadGroupId = nil
							break
						end
					end
					if nil ~= downloadGroupId then
						nextDownloadGroupId = downloadGroupId
						break
					end
				end
			end
		else
			if nil ~= dms["patch_file_ids"] then
				local filename = pText
				for i, v in pairs(dms["patch_file_ids"]) do
					local groupId = dms.atos(v, 2)
					local downloadFileName = dms.atos(v, 3)
					if filename == downloadFileName then
						nextDownloadGroupId = groupId
						break
					end
				end
				
				local canDownload = true
				for i, v in pairs(_ED.cdn_download_resource_group_ids) do
					if v == currentDownloadGroupId then
						canDownload = false
					end
				end
				if false == canDownload then
					print("error") 
					nextDownloadGroupId = nil
				end
				requestCode = CHECK_CDN_SYNC_DOWNLOAD_RESOURCES
			end
		end
		if nil ~= nextDownloadGroupId then
			handlePlatformRequest(0, requestCode, nextDownloadGroupId.."|"
													..app.patch_path .."|" 
													.. app.assets_update_url .."|"
													..cc.FileUtils:getInstance():fullPathForFilename("data/mould/patch_res.cdn"))
		end
	elseif CC_GET_RETURN_SIGNAL_AND_NETWORK	== response then
		local param = zstring.split(pText, "|")
		_ED.signal_strength = param[1]
		_ED.network_delay_time_ms = param[2]
		state_machine.excute("platform_get_signal_strength_and_network_delay_time_ms",0,nil)
	end
end

local function handlePlatformResponse_ios(event,args)
	local params = tolua.cast(args, "CCArray")
	local response = tolua.cast(params:objectAtIndex(0), "CCString"):intValue()
	local pText = tolua.cast(params:objectAtIndex(1), "CCString"):getCString()
	local value = tolua.cast(params:objectAtIndex(2), "CCString"):intValue()
	handlePlatformResponse(response, pText, value)
end


local _schedulerEntry = nil
local h_args = {}

local _unregisterUpdateScheduler = function()
	if app.scheduler ~= nil and _schedulerEntry ~= nil then 
		app.scheduler:unscheduleScriptEntry(_schedulerEntry)
		_schedulerEntry = nil
	end
end

local _update = function(dt)
	if #h_args == 0 then
		_unregisterUpdateScheduler()
		return
	end

	local args = h_args[1]
	local params = zstring.split(args, "|||")
	local response = zstring.tonumber(params[1])
	local pText = params[2]
	local value = zstring.tonumber(params[3])
	handlePlatformResponse(response, pText, value)

	table.remove(h_args, "1")
end

local _registerUpdateScheduler = function()
	_schedulerEntry = app.scheduler:scheduleScriptFunc(_update, 0.5, false)
end

local function handlePlatformResponse_android(args)
	-- local params = zstring.split(args, "|||")
	-- local response = zstring.tonumber(params[1])
	-- local pText = params[2]
	-- local value = zstring.tonumber(params[3])
	-- handlePlatformResponse(response, pText, value)

	table.insert(h_args, args)

	if _schedulerEntry == nil then
		_registerUpdateScheduler()
	end
end

function isUserAccountPlatformName()
end

--平台登录
function platformLogin()
	handlePlatformRequest(0, LOGIN, "")
end

local function OperateSDKHandlePlatformRequest(response, pText)
	handlePlatformRequest(0, response, pText)
end

--初始化平台登录后的信息
function initializePlatformLoginInfo()

end

--进入平台中心
function entrancePlatform()
	handlePlatformRequest(0, ENTERPLATFORM, "")
end

function handlePlatformRequest(request, messageType, messageText)
	if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_WINDOWS 
	or cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_LINUX 
	or cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_MAC then
		return
	end
	if messageText == nil then
		messageText = ""
	end
	if messageType == CC_CALL_SYSTEM_GC_COLLECT then
		if m_tOperateSystem == 5 then
			-- cc.CCThirdpartySupporter:getSupporter():handlePlatformRequest(request, messageType, messageText)
			app.lua_bridge:call({request, messageType, messageText})
		end
	else
		-- cc.CCThirdpartySupporter:getSupporter():handlePlatformRequest(request, messageType, messageText)
		app.lua_bridge:call({request, messageType, messageText})
	end
end

function initThirdpartySupporter()
	if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_MAC then
	else
		local targetPlatform = cc.Application:getInstance():getTargetPlatform()
		cc.CCOperationManager:sharedOperationManager():init()
		
		if (cc.PLATFORM_OS_ANDROID == targetPlatform) then
			app.lua_bridge:init(handlePlatformResponse_android)
			cc.CCThirdpartySupporter:getSupporter():registerScriptHandler(handlePlatformResponse_ios)
		end
		if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or (cc.PLATFORM_OS_MAC == targetPlatform) then
			app.lua_bridge:init(handlePlatformResponse_ios)
			cc.CCThirdpartySupporter:getSupporter():registerScriptHandler(handlePlatformResponse_ios)
		end
		handlePlatformRequest(0, CC_GET_CURRENT_LANGUAGE, "")
		handlePlatformRequest(0, INIT_OPERATION_PARAMS, "")
		handlePlatformRequest(0, INIT_PLATFORM_EXTRAS, "")
		
		
		-- state_machine.excute("platform_manager_sdk_init", 0, { messageType = ENTERED_THE_GAME ,messageText = ""})
	end
end

function setPlatformAccessType()
	if app.configJson.OperatorName == "pp" or app.configJson.OperatorName == "uc" 
	or app.configJson.OperatorName == "ky" or app.configJson.OperatorName == "360" 
	or app.configJson.OperatorName == "lenovo" or app.configJson.OperatorName == "mzw" 
	or app.configJson.OperatorName == "sy37" or app.configJson.OperatorName == "88box" 
	or app.configJson.OperatorName == "pocket" or app.configJson.OperatorName == "efun" 
	or app.configJson.OperatorName == "egame" or app.configJson.OperatorName == "zhangyue" 
	or app.configJson.OperatorName == "wdj" then
		return 1
	elseif app.configJson.OperatorName == "ksyun" or app.configJson.OperatorName == "tb" 
		or app.configJson.OperatorName == "xy" or app.configJson.OperatorName == "duoku" 
		or app.configJson.OperatorName == "91" or app.configJson.OperatorName == "iTools" 
		or app.configJson.OperatorName == "guopan" or app.configJson.OperatorName == "haima" 
		or app.configJson.OperatorName == "iiapple" or app.configJson.OperatorName == "i4" 
		or app.configJson.OperatorName == "huawei" or app.configJson.OperatorName == "xiaomi" 
		or app.configJson.OperatorName == "anzhi" or app.configJson.OperatorName == "guopan-android" 
		or app.configJson.OperatorName == "duowan" or app.configJson.OperatorName == "haima-android" 
		or app.configJson.OperatorName == "pps"  or app.configJson.OperatorName == "kaopu"  
		or app.configJson.OperatorName == "kugou" or app.configJson.OperatorName == "tangteng" 
		or app.configJson.OperatorName == "pptv" or app.configJson.OperatorName == "nubia"
		or app.configJson.OperatorName == "4399" or app.configJson.OperatorName == "downjoy" 
		or app.configJson.OperatorName == "7k7k" or app.configJson.OperatorName == "sougou" 
		or app.configJson.OperatorName == "le8" or app.configJson.OperatorName == "oasgames" 
		or app.configJson.OperatorName == "gamexdd" or app.configJson.OperatorName == "ewan" 
		or app.configJson.OperatorName == "jrtt" or app.configJson.OperatorName == "sinagame"
		or app.configJson.OperatorName == "pyw" or app.configJson.OperatorName == "morefun"
		or app.configJson.OperatorName == "gfan" or app.configJson.OperatorName == "anqu" 
		or app.configJson.OperatorName == "iTools-android" or app.configJson.OperatorName == "agame"
		or app.configJson.OperatorName == "aladin" or app.configJson.OperatorName == "memoriki" 
		or app.configJson.OperatorName == "gamedreamer" or app.configJson.OperatorName == "tapfuns"
		or app.configJson.OperatorName == "funtap" or app.configJson.OperatorName == "youliang"
		or app.configJson.OperatorName == "cayenne"
		then
		return 2
	elseif app.configJson.OperatorName == "tencent" or app.configJson.OperatorName == "gdtppk" then
		return 3
	elseif app.configJson.OperatorName == "play800" or app.configJson.OperatorName == "play800-android" 
		or app.configJson.OperatorName == "play800-2" or app.configJson.OperatorName == "play800-enterprise" 
		or app.configJson.OperatorName == "play800-enterprise-two" or app.configJson.OperatorName == "play800-ios" 
		or app.configJson.OperatorName == "sina" or app.configJson.OperatorName == "baidu-sem" 
		or app.configJson.OperatorName == "appduoduo" or app.configJson.OperatorName == "ptbus" 
		or app.configJson.OperatorName == "mobilemm" or app.configJson.OperatorName == "play800-android-ggame" 
		or app.configJson.OperatorName == "play800-android-ggame2" or app.configJson.OperatorName == "play800-android-ggame3" 
		or app.configJson.OperatorName == "play800-android-ggame4" or app.configJson.OperatorName == "ggame" then
		return 4
	elseif app.configJson.OperatorName == "oppo" then
		return 5
	elseif app.configJson.OperatorName == "vivo" then
		return 6
	elseif app.configJson.OperatorName == "yyh" then	
		return 7
	elseif app.configJson.OperatorName == "meizu" then
		return 8
	elseif app.configJson.OperatorName == "coolpad-new" then	
		return 9
	elseif app.configJson.OperatorName == "amigo" then
		return 10
	elseif app.configJson.OperatorName == "anfan" then	
		return 11
	elseif app.configJson.OperatorName == "tt" then
		return 12
	elseif app.configJson.OperatorName == "letv" then
		return 13
	elseif app.configJson.OperatorName == "youku" then
		return 14
	elseif app.configJson.OperatorName == "921" then	
		return 15
	elseif app.configJson.OperatorName == "samsung" then	
		return 16
	elseif app.configJson.OperatorName == "dianyou" then	
		return 17
	elseif app.configJson.OperatorName == "papa" then	
		return 18
	elseif app.configJson.OperatorName == "tutu" then
		return 19
	elseif app.configJson.OperatorName == "move" then
		return 20
	elseif app.configJson.OperatorName == "jar-world" or app.configJson.OperatorName == "jar-world-1" then
		return 0
	end
	return 0
end

if cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_WINDOWS 
and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_LINUX 
and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_MAC then
	app.load("client.operation.platformSDKAccess.platformSDKAccessType_"..setPlatformAccessType())
	initThirdpartySupporter()
end



local platform_handle_platform_request_terminal = {
    _name = "platform_handle_platform_request",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = nil,
    _state = 0,
    _invoke = function(terminal, instance, params)
    	handlePlatformRequest(params[1], params[2], params[3])
        return true
    end,
    _terminal = nil,
    _terminals = nil      
}

state_machine.add(platform_handle_platform_request_terminal)

local open_exit_game_view_terminal = {
	_name = "open_exit_game_view",
	_init = function (terminal)
		app.load("client.utils.ExitGameView")
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if nil == fwin:find("ExitGameViewClass") then
			fwin:open(ExitGameView:new(), fwin._system)
		else
			fwin:close(fwin:find("ExitGameViewClass"))
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}
		
state_machine.add(open_exit_game_view_terminal)
state_machine.init()

