-- ----------------------------------------------------------------------------------------------------
-- 说明：游戏中的事件演绎
-- 创建时间2014-03-30 21:51
-- 作者：周义文
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------
function isRunning()
	
end

local isInBattler = false
function mission_setIsInBattler( isIn )
	isInBattler = isIn
end

MissionClass = class("MissionClass", Window)
MissionClass.__index = MissionClass
MissionClass._uiLayer= nil
MissionClass._widget = nil
MissionClass._pClip = nil
MissionClass._pDialog = nil
MissionClass._pBlankScreen = nil
MissionClass._pTuitionDlg = nil

MissionClass._touchUICallback = nil
MissionClass._windowName = nil
MissionClass._widgetName = nil
MissionClass._isFirstGame = false
MissionClass._fristFightEnd = false
--[[
0剧情事件
1战斗事件
2教学事件

--]]
mission_mould_plot			 		 = "0剧情事件"			-- 0
mission_mould_battle		 		 = "1战斗事件"			-- 1
mission_mould_tuition		 		 = "2教学事件"			--2


--[[
0进入主页
1进入场景
2点击NPC
3战斗开始
4战斗结束
5战斗升级回到场景
--]]
touch_off_mission_into_home			 = "0进入主页"				-- 0	-- 进入主页
touch_off_mission_into_scene		 = "1进入场景"				-- 1	-- 进入场景
touch_off_mission_touch_npc			 = "2点击NPC"				-- 2	-- 点击NPC
touch_off_mission_start_battle		 = "3战斗开始"				-- 3	-- 战斗开始
touch_off_mission_battle_over		 = "4战斗结束"				-- 4	-- 战斗结束
touch_off_mission_ls_scene			 = "5战斗升级回到场景"			-- 5	-- 战斗升级回到场景
touch_off_mission_touch_ui			 = "6点击UI"					-- 6	-- 6点击UI
touch_off_mission_comkill			 = "7连击进度条开始"			-- 7	-- 7连击进度条开始
local trigger_timing				 = ""	-- 0
local mission_mould					 = ""	-- 0

mission_id					 = 1	
mission_event_id			 = 2
mission_trigger_timing		 = 3
mission_off					 = 4
mission_repeat				 = 5
mission_skip_id				 = 6
mission_start_param			 = 7
mission_start_conditions	 = 8
mission_end_param			 = 9
mission_progress			 = 10
mission_repeat_target		 = 11
mission_event_type			 = 12
mission_execute_type		 = 13
mission_round				 = 14
mission_param1				 = 15
mission_param2				 = 16
mission_param3				 = 17
mission_param4				 = 18
mission_param5				 = 19
mission_param6				 = 20
mission_param7				 = 21
mission_param8				 = 22
mission_param9				 = 23
mission_param10				 = 24
mission_param11				 = 25
mission_param12				 = 26
mission_param13				 = 27
mission_param14				 = 28
mission_param15				 = 29
mission_param16				 = 30
mission_param17				 = 31
mission_param18				 = 32

--[[
0切换场景
1切换背景
2切换背景音效
3点击UI
4打开界面
5在当前场景背景上面绘制光效
6请求战斗
7对话
8角色出现或消失
9黑屏事件
10播放音效
11启动教学事件

--]]
execute_type_change_scene										= "0切换场景"							-- 0
execute_type_changeBackground									= "1切换背景"							-- 1
execute_type_bgMusic											= "2切换背景音效"						-- 2
execute_type_touchUI											= "3点击UI"							-- 3
execute_type_openWindow											= "4打开界面"							-- 4
execute_type_drawEffect											= "5在当前场景背景上面绘制光效"			-- 5
execute_type_requestFight										= "6请求战斗"							-- 6
execute_type_dialog												= "7对话"							-- 7
execute_type_hsRole												= "8角色出现或消失"					-- 8
execute_type_blankScreen										= "9黑屏事件"							-- 9
execute_type_playMusic											= "10播放音效"						-- 10
execute_type_startTuition										= "11启动教学事件"						-- 11
execute_type_open_func											= "12开启功能提示"						-- 12
execute_type_move_team											= "13角色移动"						-- 13
execute_type_request_battle										= "14准备战斗"						-- 14
execute_type_start_battle										= "15开始战斗"						-- 15
execute_type_resume_battle										= "16返回战斗"						-- 16
execute_type_over_battle										= "17战斗结束"						-- 17
execute_type_get_resource										= "18发送资源"						-- 18
execute_type_openzhuce											= "19创建角色"						-- 19
execute_type_start_play											= "20剧情战斗初始化事件"				-- 20
execute_type_getdata_play										= "21剧情战斗数据初始化"				-- 21
execute_type_play_CG											= "22CG场景"							-- 22
execute_type_treasure_drop										= "23宝物掉落"						-- 23
execute_type_wait_cd											= "24等待CD"							-- 24
execute_type_role_restart										= "25角色开始入场"						-- 25
execute_type_role_restart_over									= "26角色入场结束"						-- 26
execute_type_prologue											= "27开场动画"						-- 27
execute_type_script			 									= "28执行脚本"						-- 28
execute_type_stop_fight											= "29暂停战斗绘制"						-- 29
execute_type_camp_choose										= "30阵营选择"						-- 30
execute_type_start_plot_battle									= "31发起剧情战斗"						-- 31
execute_type_play_plot_dialog									= "32发起剧情对话"						-- 32
execute_type_battle_pause										= "33战斗暂停"						-- 33
execute_type_battle_resume										= "34战斗继续"						-- 34
execute_type_add_role_power										= "35增加角色怒气"						-- 35
execute_type_battle_result										= "36战斗结算"						-- 36
execute_type_role_death											= "37角色死亡"						-- 37
execute_type_role_change										= "38更换英雄形象"						-- 38
execute_type_role_remove										= "39角色移除"						-- 39
execute_type_role_add											= "40角色添加"						-- 40
execute_type_scale_window										= "41缩放窗口"						-- 41
execute_type_wait_battle_change_scene							= "42暂停战斗切场"						-- 42
execute_type_battle_change_scene								= "43开始战斗切场"						-- 43
execute_type_battle_role_skill_attack							= "44角色释放技能"						-- 44
execute_type_battle_role_super_skill							= "45角色释放绝技"						-- 45
execute_type_change_formation									= "46角色上阵"						-- 46
execute_type_stop_fight_change_scene_action						= "47禁用战斗切场动画"					-- 47
execute_type_change_battle_role									= "48变更战斗角色"						-- 48
execute_type_change_battle_role_attack_state					= "49角色行动状态"						-- 49
execute_type_change_battle_role_process_attack_state			= "50变改角色出手状态"					-- 50

local currentEventBattleRoundCound = 0

local mission_executeOverCallback = nil

function clearMissionUIData()
	state_machine.excute("window_lock_swallow_touches", 0, false)
	state_machine.excute("events_teaching_skip_close", 0, false)

	if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
		state_machine.excute("window_lock_window_close", 0, 0)
	end

	--> print("~~~~ ++ clearMissionUIData ++ ~~~~")
	if MissionClass._pClip ~= nil then
		MissionClass._pClip:removeFromParent(true)
		MissionClass._pClip = nil
	end
	
	if MissionClass._pTuitionDlg ~= nil then
		MissionClass._pTuitionDlg:removeFromParent(true)
		MissionClass._pTuitionDlg = nil
	end
	
	if MissionClass._pDialog ~= nil then
		MissionClass._pDialog:removeFromParent(true)
		MissionClass._pDialog = nil
	end
	
	if MissionClass._pBlankScreen ~= nil then
		MissionClass._pBlankScreen:removeFromParent(true)
		MissionClass._pBlankScreen = nil
	end
	
	if MissionClass._uiLayer ~= nil then
		MissionClass._uiLayer:removeFromParent(true)
		MissionClass._uiLayer = nil
	end
	MissionClass._windowName = nil
	MissionClass._widgetName = nil

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		if nil ~= mission_tip_string and nil ~= _ED.user_info and nil ~= _ED.user_info.user_grade and "" ~= _ED.user_info.user_grade then
		    local msp = zstring.split(mission_tip_string[4], ",")
		    if tonumber(msp[1]) <= tonumber(_ED.user_info.user_grade) 
		        and tonumber(msp[2]) <= tonumber(_ED.user_info.user_experience) 
		        then
		        _ED._mission_3 = _ED._mission_3 or "0"
		        if tonumber(msp[4]) > tonumber(_ED._mission_3) then
		            _ED._mission_3 = msp[4]
		        end
		    end
		end
	end
end

-- function MissionClass.drawPlotDialog()

-- end


-- function MissionClass:init()
	-- MissionClass._uiLayer = TouchGroup:create()
	-- self:addChild(MissionClass._uiLayer)
-- end	

-- function MissionClass.initData()
	
-- end

-- function MissionClass.create()
	-- local layer = MissionClass.super.extend(MissionClass, CCLayer:create())
    -- layer:init()
    -- return layer
-- end

-- function MissionClass.Draw()
	-- MissionClass._layer = MissionClass.create()
	-- draw.addScene(MissionClass._layer, 11000)
-- end

-- function MissionClass.backCallback()
	
-- end

-- function MissionClass.closeCallback()

-- end

function MissionClass:ctor()
    self.super:ctor()
end

local executeEvent = nil
local missions = nil 
local mission = nil 
local saveKey = nil
local missionId = 0
local eventIndex = 0
local eventRepeat = "0"
local complated = "0"
local offval = ""
local tuitionMissionId = 0

local saveEData = nil
local saveKeyBase = nil
local saveBaseEData = nil
local exBaseEData = true

checkCurrentMissionEnd = nil
local executeTouchUI = nil
local executeOpenWindows = nil
local executeDialog = nil
local executeBlankScreen = nil
local waitExecuteMission = false

mission_effect = nil

local mission_network_next_over_terminal = {
    _name = "mission_network_next_over",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
    	local TuitionControllerWindow = fwin:find("TuitionControllerClass")
    	if nil ~= TuitionControllerWindow then
    		state_machine.excute("tuition_controller_network_node", 0, params)

   --  		if missionIsOver() == false then
			-- 	if params == "error" then
			-- 		fwin:addService({
		 --                callback = function ( params )
			-- 				state_machine.excute("reconnect_view_window_close", 0, 0)
			-- 				state_machine.excute("logout_tip_window_open", 0, 0)
		 --                end,
		 --                params = nil
		 --            })
			-- 	end
			-- end
    	else
			if mission ~= nil and #mission > 0 then
				local missionEndParam = dms.atos(mission, mission_end_param)
				if missionEndParam == params then
					saveExecuteEvent(mission, true, true)
				end
			end
		end
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local mission_network_send_mission_skip_info_terminal = {
    _name = "mission_network_send_mission_skip_info",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
    	local arrs = zstring.split(params, "|")
		local arr1 = zstring.split(arrs[1], ",")
		if nil ~= arr1 and #arr1 >= 3 then
		    _ED._mission_1 = arr1[1]
		    _ED._mission_2 = arr1[2]
		    _ED._mission_3 = arr1[3]
		    if nil ~= arrs[2] then
		    	_ED._mission_execute = zstring.split(arrs[2], ",")
		    end

		    if nil ~= _ED._mission_1 and #_ED._mission_1 == 0 then
		    	 _ED._mission_1 = nil
		    end
		    if nil ~= _ED._mission_2 and #_ED._mission_2 == 0 then
		    	 _ED._mission_2 = nil
		    end
		    if nil ~= _ED._mission_3 and #_ED._mission_3 == 0 then
		    	 _ED._mission_3 = nil
		    end
		end
		protocol_command.mission_skip_info.param_list = "" .. params
        NetworkManager:register(protocol_command.mission_skip_info.code, nil, nil, nil, nil, nil, false, nil)
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local mission_stop_current_background_music_terminal = {
    _name = "mission_stop_current_background_music",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
    	stopBgm()
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local mission_play_background_music_terminal = {
    _name = "mission_play_background_music",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
    	playBgm(formatMusicFile("background", params))
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(mission_network_next_over_terminal)
state_machine.add(mission_network_send_mission_skip_info_terminal)
state_machine.add(mission_stop_current_background_music_terminal)
state_machine.add(mission_play_background_music_terminal)
state_machine.init()

function MissionClass:drawTuition(layer, areanXYWH)
	local s = cc.Director:getInstance():getWinSize()
	
	local osffx = (s.width - 640 /CC_CONTENT_SCALE_FACTOR()) / 2 
	local osffy = (s.height - 960 /CC_CONTENT_SCALE_FACTOR()) / 2 
	
	local size = layer:getContentSize()
	local offsetx = (areanXYWH == nil and 0 or zstring.tonumber(areanXYWH[1]))/CC_CONTENT_SCALE_FACTOR()
	local offsety = (areanXYWH == nil and 0 or zstring.tonumber(areanXYWH[2]))/CC_CONTENT_SCALE_FACTOR()
	local offwidth = (areanXYWH == nil and 0 or zstring.tonumber(areanXYWH[3]))/CC_CONTENT_SCALE_FACTOR()
	local offheight = (areanXYWH == nil and 0 or zstring.tonumber(areanXYWH[4]))/CC_CONTENT_SCALE_FACTOR()
	
	local e_position = fwin:convertToWorldSpaceAR(layer, ccp(0, 0)) -- layer:convertToWorldSpaceAR(ccp(0, 0))
	local a_position = layer:getAnchorPoint()
	e_position.x = e_position.x + offsetx - a_position.x * size.width - osffx
	e_position.y = e_position.y + offsety - a_position.y * size.height - osffy
	
	size.width = size.width + offwidth
	size.height = size.height + offheight
	
	local pClip = cc.Node:create()
	pClip:setContentSize(CCSizeMake(size.width, size.height))
	pClip:setPosition(e_position)
	
	createEffect("effect_8", "images/ui/effice/effect_8.ExportJson", pClip, -1, 1)
	
	draw.graphics(pClip, 11000)
	
	if MissionClass._pClip ~= nil then
		MissionClass._pClip:removeFromParent(true)
		MissionClass._pClip = nil
	end
	MissionClass._pClip = pClip
	
	-- cc.Director:getInstance():touchListener(true)
end

function MissionClass:drawTuitionDlg(dialogXY, message, dlgWH, textWH, textXY)	
	local pTuitionDlg = MissionClass._pTuitionDlg 
	
	if pTuitionDlg == nil then
		pTuitionDlg = draw.getWidget("interface/teaching.json")
		MissionClass._pTuitionDlg = pTuitionDlg
		if MissionClass._uiLayer == nil then
			MissionClass._uiLayer = TouchGroup:create()
			draw.graphics(MissionClass._uiLayer, 100)
		end
		if MissionClass._uiLayer ~= nil then
			MissionClass._uiLayer:addWidget(MissionClass._pTuitionDlg )
		end
	end
	
	local dlgW = (dlgWH == nil and 0 or zstring.tonumber(dlgWH[1]))/CC_CONTENT_SCALE_FACTOR()
	local dlgH = (dlgWH == nil and 0 or zstring.tonumber(dlgWH[2]))/CC_CONTENT_SCALE_FACTOR()
	local dlgX = (dialogXY == nil and 0 or zstring.tonumber(dialogXY[1]))/CC_CONTENT_SCALE_FACTOR()
	local dlgY = (dialogXY == nil and 0 or zstring.tonumber(dialogXY[2]))/CC_CONTENT_SCALE_FACTOR()
	pTuitionDlg:setPosition(ccp(dlgX, dlgY))
	--pTuitionDlg:getWidgetByName("ImageView_7993"):setSize(CCSizeMake(dlgW, dlgH))
	
	local msg = pTuitionDlg:getWidgetByName("Label_7994_1")
	local textW = (textWH == nil and 0 or zstring.tonumber(textWH[1]))/CC_CONTENT_SCALE_FACTOR()
	local textH = (textWH == nil and 0 or zstring.tonumber(textWH[2]))/CC_CONTENT_SCALE_FACTOR()
	local textX = (textXY == nil and 0 or zstring.tonumber(textXY[1]))/CC_CONTENT_SCALE_FACTOR()
	local textY = (textXY == nil and 0 or zstring.tonumber(textXY[2]))/CC_CONTENT_SCALE_FACTOR()
	local lxx, lyy = msg:getPosition()
	if lyy == nil then
		lyy = lxx.y
		lxx = lxx.x
	end
	pTuitionDlg:getWidgetByName("ImageView_7993"):setSize(CCSizeMake(textW + 50, textH + 50))
	local s = cc.Director:getInstance():getWinSize()
	local osffy = 0 --(s.height - 960 /CC_CONTENT_SCALE_FACTOR()) / 2
	
	msg:setAnchorPoint(ccp(0.0, 1.0))
	msg:setPosition(ccp(textX+lxx, textY+lyy + osffy + 15))
	msg = tolua.cast(msg, "Label")
	msg:setTextAreaSize(CCSizeMake(textW,textH + 10))
	--msg:setText(message)
	draw.text(msg,message)
	
end

local function SenderRecodeExt(instantSend)
    if mission ~= nil then
    	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
	    	if zstring.tonumber(mission[10]) > 0 then
	    		local eventLogger = dms.searchs(dms["app_event_logger"], app_event_logger.event_id, zstring.tonumber(mission[10]))
	    		if jttd ~= nil and nil ~= eventLogger then
		    		jttd.appEventsLogger(eventLogger[1][2].."|"..eventLogger[1][4])
		    	end
		    	if zstring.tonumber(mission[10]) == 305036 then
		    		jttd.facebookAPPeventSlogger("3")
		    	end
			end
		end
	    local missionProgress = dms.atos(mission, mission_progress)
	    if missionProgress ~= nil and missionProgress ~="" and tonumber(missionProgress) > -1 then
            protocol_command.education_change.param_list = missionProgress
            if instantSend == nil or instantSend == true then
                --Sender(protocol_command.education_change.code, nil, nil, nil, nil, nil,-1)
				if nil ~= _ED.user_info.user_id and "" ~= _ED.user_info.user_id then
					NetworkManager:register(protocol_command.education_change.code, nil, nil, nil, nil, nil, false, nil)
					-- NetworkManager:register(protocol_command.education_change.code, nil, NetworkAdaptor.mode.LUASOCKET, nil, nil, nil, false, nil)
				end
            end
	    end
    end
end

local function SenderRecode(rwb)
    if true then
        SenderRecodeExt()
        return
    end
	
	if _ED.user_info.new_user_teach_record[saveKey] == nil then
		_ED.user_info.new_user_teach_record[saveKey] = {"", ""}
	end
	
	if _ED.user_info.new_user_teach_record[saveKeyBase] == nil then
		_ED.user_info.new_user_teach_record[saveKeyBase] = {"", ""}
	end
	
	if (saveEData ~= nil and _ED.user_info.new_user_teach_record[saveKey][2] ~= saveEData and rwb == true)
		or (saveBaseEData ~= nil and _ED.user_info.new_user_teach_record[saveKeyBase][2] ~= saveBaseEData) then
		if saveEData ~= nil then
			_ED.user_info.new_user_teach_record[saveKey] = {saveKey, saveEData}
		end
		if saveBaseEData ~= nil then
			_ED.user_info.new_user_teach_record[saveKeyBase] = {saveKeyBase, saveBaseEData}
		end
		
		local sendString = ""
		for i, v in pairs(_ED.user_info.new_user_teach_record) do 
			if #sendString > 0 then
				sendString = sendString .. "|"
			end
			sendString= sendString..v[1].."&"..v[2]
		end
		
		if mission ~= nil then
			local missionProgress = dms.atos(mission, mission_progress)
			if missionProgress ~= nil then
				sendString = sendString.."|"..missionProgress
			end
		end
		protocol_command.education_change.param_list = sendString
		--Sender(protocol_command.education_change.code, nil, nil, nil, nil, nil,-1)
	end
end

function extraEventRecord(rwb)
	if missions == nil then
		return
	end
    if true then
        SenderRecodeExt()
        return
	end
	local eventCount = #missions
	local mission = eventIndex < eventCount and missions[eventIndex + 1] or nil
	if mission == nil then
		complated = "1"
		saveEData = ""..missionId..","..eventIndex..","..eventRepeat..","..complated..","..offval
	else
		eventRepeat = dms.atos(mission, mission_repeat)
		saveBaseEData = dms.atos(mission, mission_repeat_target)
		local eventIndexs = tonumber(eventIndex)+1
		saveEData = ""..missionId..","..eventIndexs..","..eventRepeat..","..complated..","..offval
	end
	if _ED.user_info.new_user_teach_record[saveKey] == nil then
		_ED.user_info.new_user_teach_record[saveKey] = {"", ""}
	end
	
	if _ED.user_info.new_user_teach_record[saveKeyBase] == nil then
		_ED.user_info.new_user_teach_record[saveKeyBase] = {"", ""}
	end
	
	if (saveEData ~= nil and _ED.user_info.new_user_teach_record[saveKey][2] ~= saveEData and rwb == true)
		or (saveBaseEData ~= nil and _ED.user_info.new_user_teach_record[saveKeyBase][2] ~= saveBaseEData) then
		if saveEData ~= nil then
			_ED.user_info.new_user_teach_record[saveKey] = {saveKey, saveEData}
		end
		if saveBaseEData ~= nil then
			_ED.user_info.new_user_teach_record[saveKeyBase] = {saveKeyBase, saveBaseEData}
		end
		
		local sendString = ""
		local sendIndexs = 0
		for i, v in pairs(_ED.user_info.new_user_teach_record) do 
			if v[1]~=nil and v[1]~="" and v[2]~=nil and v[2]~="" then
				sendIndexs = sendIndexs + 1
				if sendIndexs >= 5 then
					break;
				end
				if #sendString > 0 then
					sendString = sendString .. "|"
				end
				sendString= sendString..v[1].."&"..v[2]
			end
		end
		if mission ~= nil then
			local missionProgress = dms.atos(mission, mission_progress)
			if missionProgress ~= nil then
				sendString = sendString.."|"..missionProgress
			end
		end
		protocol_command.education_change.param_list = sendString
	end
end

local function checkOverMission(emtAccount, emtServerNumber, emtName)
	local saveData = ""--CCUserDefault:sharedUserDefault():getStringForKey(saveKeyBase)
	local saveElement = zstring.split(saveData, ",") -- missionMould, eid, eIndex
	local missionMould = saveElement[1]==nil and "" or saveElement[1]
	local eId = zstring.tonumber(saveElement[2])
	local eIndex = zstring.tonumber(saveElement[3])
	if eId > 0 then
		mission_mould = missionMould
		if mission_mould == mission_mould_tuition then
			saveKey = emtAccount..emtServerNumber.."tt".."m"..mission_mould.."end"
		elseif mission_mould == mission_mould_battle then
			saveKey = emtAccount..emtServerNumber.."bt".."m"..mission_mould.."end"
		else
			saveKey = emtAccount..emtServerNumber.."sn".."m"..mission_mould.."end"
		end
		--saveKey = emtAccount..emtServerNumber..emtName.."m"..mission_mould.."end"
		missionId = eId
		eventIndex = eIndex
		if mission_mould == mission_mould_tuition then
			-- missions = tolua.cast(mission3Data:searchs(mission_id, missionId), "CCArray")
			missions = dms.searchs(dms["mission3"], mission_id, missionId)
		elseif mission_mould == mission_mould_battle then
			-- missions = tolua.cast(mission2Data:searchs(mission_id, missionId), "CCArray")
			missions = dms.searchs(dms["mission2"], mission_id, missionId)
		else
			-- missions = tolua.cast(mission1Data:searchs(mission_id, missionId), "CCArray")
			missions = dms.searchs(dms["mission1"], mission_id, missionId)
		end
		if missions ~= nil then
			missions:retain()
			mission =  missions[eventIndex + 1]
			eventRepeat = dms.atos(mission, mission_repeat)
			complated = "0"
			offval = dms.atos(mission, mission_off)
			repeatTarget = dms.atos(mission, mission_repeat_target)
			triggerTiming = dms.atos(mission, mission_trigger_timing)
		end
		oldMissionId = 0
		-- --CCUserDefault:sharedUserDefault():setStringForKey(saveKeyBase, ""..missionId..","..eventIndex..","..eventRepeat..","..complated..","..offval)
		-- CCUserDefault:sharedUserDefault():flush()
	end
end

local function checkMission(emtAccount, emtServerNumber, emtName, emtOffVal, triggerTiming)
	saveKey = emtAccount..emtServerNumber..emtName.."m"..mission_mould.."end"
	
	local saveData = ""--CCUserDefault:sharedUserDefault():getStringForKey(saveKey)
	local saveElement = zstring.split(saveData, ",") -- ID, SKIP , repeat, COMP, OFFVAL
	missionId = zstring.tonumber(saveElement[1])
	local oldMissionId = zstring.tonumber(saveElement[1])
	complated = "0"
	offval = emtOffVal
    -- 1.0.4
    oldMissionId = 0
	if saveElement[4] == "0" and saveElement[3] == "1是" then
		if offval == saveElement[5] then
			eventIndex = zstring.tonumber(saveElement[2])
			complated = saveElement[4]
			offval = saveElement[5]
			if mission_mould == mission_mould_tuition then
				eventIndex = 0
			else
				oldMissionId = 0
				eventIndex = 0
			end
		end
	else
		--if tuitionMissionId == 0 and mission_mould == mission_mould_tuition then
		--	return
		--end
		if tuitionMissionId > 0 then
			missionId = zstring.tonumber(tuitionMissionId)
			tuitionMissionId = 0
		elseif mission_mould == mission_mould_tuition then
			missionId = 0
			--missionId = missionId + 1
		else
			missionId = missionId + 1
		end
	end
	
	eventIndex = 0
    --missionId = 0
	
	if mission_mould == mission_mould_tuition then
		if missionId > 0 then
			-- missions = tolua.cast(mission3Data:searchs(mission_id, missionId), "CCArray")
			missions = dms.searchs(dms["mission3"], mission_id, missionId)
		else
			-- missions = tolua.cast(mission3Data:searchs(mission_off, offval), "CCArray")
			missions = dms.searchs(dms["mission3"], mission_off, offval)
		end
		
		if missions ~= nil then
			mission =  missions[eventIndex + 1]
			missionId = dms.atoi(mission, mission_id)
			triggerTiming = dms.atos(mission, mission_trigger_timing)
		end
	elseif mission_mould == mission_mould_battle then
		-- missions = tolua.cast(mission2Data:searchs(mission_trigger_timing, triggerTiming, mission_off, offval), "CCArray")
		missions = dms.searchs(dms["mission2"], mission_trigger_timing, triggerTiming, mission_off, offval)
	else
		-- missions = tolua.cast(mission1Data:searchs(mission_id, missionId, mission_off, offval), "CCArray")
		missions = dms.searchs(dms["mission2"], mission_id, missionId, mission_off, offval)
	end
	
	--[[
	if mission_mould == mission_mould_tuition then
		missions = tolua.cast(mission3Data:searchs(mission_id, missionId), "CCArray")
		if missions ~= nil then
			mission =  missions[eventIndex + 1]
			triggerTiming = dms.atos(mission, mission_trigger_timing)
		end
	elseif mission_mould == mission_mould_battle then
		missions = tolua.cast(mission2Data:searchs(mission_id, missionId, mission_off, offval), "CCArray")
	else
		if touch_off_mission_ls_scene == triggerTiming then
			missions = tolua.cast(mission1Data:searchs(mission_off, offval), "CCArray")
		else
			missions = tolua.cast(mission1Data:searchs(mission_id, missionId, mission_off, offval), "CCArray")
		end
	end
	--]]
	
	if missions ~= nil then
		mission =  missions[eventIndex + 1]
		local missionOff = dms.atos(mission, mission_off)
		local trigger_timing = dms.atos(mission, mission_trigger_timing)		-- dms.atoi(mission, mission_trigger_timing)
		if missionOff ~= offval or trigger_timing ~= triggerTiming  or (oldMissionId >= dms.atoi(mission, mission_id)) then	
			mission = nil
			missions = nil
			
			return
		end
		missionId = dms.atoi(mission, mission_id)
		eventRepeat = dms.atos(mission, mission_repeat)
		-- missions:retain()
		saveEData = ""..missionId..","..eventIndex..","..eventRepeat..","..complated..","..offval
		SenderRecode(true)
		--CCUserDefault:sharedUserDefault():setStringForKey(saveKey, saveEData)
		--CCUserDefault:sharedUserDefault():flush()
	else
		missionId = 0
	end
end

function checkMissionSkipTo(missionType, missionId, skipEventIndex)
	missions = dms.searchs(dms["mission" .. missionType], mission_id, missionId)
	if nil ~= missions then
		eventIndex = skipEventIndex
		mission =  missions[eventIndex]
		if mission ~= nil then
			missionId = dms.atoi(mission, mission_id)
			eventRepeat = dms.atos(mission, mission_repeat)

			missionRepeatTarget = dms.atos(mission, mission_repeat_target)
			repeatEventInfo = zstring.split(missionRepeatTarget, ",")
			if table.getn(repeatEventInfo) >= 3 and repeatEventInfo[2] ~= nil and repeatEventInfo[3] ~= nil then
				local tempEventIndex = zstring.tonumber(repeatEventInfo[3])
				if tempEventIndex > eventIndex then
					eventIndex = tempEventIndex
					mission =  missions[eventIndex + 1]
					missionId = dms.atoi(mission, mission_id)
					eventRepeat = dms.atos(mission, mission_repeat)
				end
			end
			executeEvent()
		else
			missions = nil
        end
	end
end

local function checkMissionExt(emtOffVal, triggerTiming, cmpOffVal, executeRepeatEvent)
	eventIndex = 0
	if mission_mould == mission_mould_tuition then
        if emtOffVal ~= nil then
		    -- missions = tolua.cast(mission3Data:searchs(mission_off, emtOffVal, mission_start_param, cmpOffVal), "CCArray")
		    missions = dms.searchs(dms["mission3"], mission_off, emtOffVal, mission_start_param, cmpOffVal)
        else
		    -- missions = tolua.cast(mission3Data:searchs(mission_start_param, cmpOffVal), "CCArray")
		    missions = dms.searchs(dms["mission3"], mission_start_param, cmpOffVal)
        end
		
		if missions ~= nil then
			mission =  missions[eventIndex + 1]
			missionId = dms.atoi(mission, mission_id)
			triggerTiming = dms.atos(mission, mission_trigger_timing)
		end
	elseif mission_mould == mission_mould_battle then
		-- print("==========战斗事件",triggerTiming,emtOffVal,cmpOffVal)
        if triggerTiming ~= nil and emtOffVal ~= nil then
            local emtOffValParam = zstring.split(emtOffVal, "v")
            local currentNpcId = zstring.tonumber(emtOffValParam[1])
			local npcLastState 
			
			if _ED.npc_last_state == nil then
				npcLastState = -1	
			else
				npcLastState = zstring.tonumber(_ED.npc_last_state[currentNpcId]) or -1;
		    end
		    -- print("=========npcLastState",npcLastState)
		    if npcLastState <= 0 then
		        -- missions = tolua.cast(mission2Data:searchs(mission_trigger_timing, triggerTiming, mission_off, emtOffVal), "CCArray")
				missions = dms.searchs(dms["mission2"], mission_trigger_timing, triggerTiming, mission_off, emtOffVal)
            end
        elseif cmpOffVal ~= nil then
            -- missions = tolua.cast(mission2Data:searchs(mission_start_param, cmpOffVal), "CCArray")
            missions = dms.searchs(dms["mission2"], mission_start_param, cmpOffVal)
        end
	else
		-- missions = tolua.cast(mission1Data:searchs(mission_off, emtOffVal, mission_start_param, cmpOffVal), "CCArray")
		missions = dms.searchs(dms["mission1"], mission_off, emtOffVal, mission_start_param, cmpOffVal)
	end
	
	------------------------------------------------------------------------------------------------------
	-- 用于跳过被中断的非主线事件,此类事件被中断后就不再继续了
	------------------------------------------------------------------------------------------------------
	local wfeg = true
	if missions ~= nil and #missions > 0 then
		local _temp_mission = missions[eventIndex + 1]
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local mission_start_conditions = _temp_mission[mission_param.mission_start_conditions]
			if mission_start_conditions == "feg:1-0" then
				-- 获取记录值 
				local mission_progress = zstring.tonumber(_temp_mission[mission_param.mission_progress])
				local keyName = "shkp_feg"
				local keyStr = readKey(keyName)
				if tostring(keyStr) == tostring(mission_progress) then
					missions = nil
					return
				else
					-- 记录值
					writeKey(keyName, tostring(mission_progress))
				end
			end
		else
			local checkMissionId = nil
			local missionType = 3
			if mission_mould == mission_mould_tuition then
				checkMissionId = _ED._mission_3
				missionType = 3
			elseif mission_mould == mission_mould_battle then
				checkMissionId = _ED._mission_2
				missionType = 2
			else
				checkMissionId = _ED._mission_1
				missionType = 1
			end

			if nil ~= checkMissionId 
				and nil ~= _temp_mission
				and _ED._mission_execute ~= nil
				and missionType == tonumber(_ED._mission_execute[1])
				then
				if nil == _temp_mission or tonumber(checkMissionId) > tonumber(_temp_mission[mission_id]) 
					then
					missions = nil
				elseif tonumber(checkMissionId) == tonumber(_temp_mission[mission_id]) and tonumber(_temp_mission[mission_id]) == tonumber(_ED._mission_execute[2]) then
					eventIndex = tonumber(_ED._mission_execute[3] - 1)
					_temp_mission = missions[eventIndex]
					if nil == _temp_mission then
						missions = nil
					end
				end
			end

			if nil ~= missions then
				local mission_start_conditions = _temp_mission[mission_param.mission_start_conditions]
				if mission_start_conditions == "feg:1-0" then
					-- 获取记录值 
					local mission_progress = zstring.tonumber(_temp_mission[mission_param.mission_progress])
					if mission_progress > 0 then
						local keyName = "shkp_feg_" .. mission_progress
						local keyStr = readKey(keyName)
						if tostring(keyStr) == tostring(mission_progress) then
							missions = nil
						else
							wfeg = false
							-- 记录值
							writeKey(keyName, tostring(mission_progress))
						end
					end
				end
			end
		end
	end
	------------------------------------------------------------------------------------------------------

	if missions ~= nil and #missions > 0 then
		-- mission =  missions[eventIndex + 1]
		-- missionId = dms.atoi(mission, mission_id)
		-- eventRepeat = dms.atos(mission, mission_repeat)
		-- missions:retain()
		mission = missions[eventIndex + 1]
		missionId = dms.atoi(mission, mission_id)
		eventRepeat = dms.atos(mission, mission_repeat)

        local generalQuality = nil
		
        if executeRepeatEvent == true then
            local missionRepeatTarget = dms.atos(mission, mission_repeat_target)
            local repeatEventInfo = zstring.split(missionRepeatTarget, ",")
            if table.getn(repeatEventInfo) >= 3 and repeatEventInfo[2] ~= nil and repeatEventInfo[3] ~= nil then
                eventIndex = zstring.tonumber(repeatEventInfo[3])
                mission =  missions[eventIndex + 1]
                missionId = dms.atoi(mission, mission_id)
		        eventRepeat = dms.atos(mission, mission_repeat)
            end

            local lastMissionStartConditions = nil
            local checkOver = false
            while checkOver == false do
                mission =  missions[eventIndex + 1]
				if mission == nil then
					break
				end
                local missionStartConditions = dms.atos(mission, mission_start_conditions)
                if missionStartConditions ~= "" and missionStartConditions ~= "0" then
                    if lastMissionStartConditions == missionStartConditions then
                        eventIndex = eventIndex + 1
                        -- print("=======不筛选")
                    else
                    	-- print("=======筛选")
                        lastMissionStartConditions = missionStartConditions
                        local missionStartConditionsInfos = zstring.split(missionStartConditions, ",")
                        for i, v in pairs(missionStartConditionsInfos) do
                            local missionStartConditionsParam = zstring.split(v, ":")
                            -- debug.print_r(missionStartConditionsParam)
                            if missionStartConditionsParam[1] == "f" then -- 判断阵型中的某个位置是否有战士
                                -- if _ED.user_formetion_status[zstring.tonumber(missionStartConditionsParam[2])] == "0" then
                                --     checkOver = true
                                --     break
                                -- end
                                local nfCount = 0
                                for m, n in pairs(_ED.user_formetion_status) do
                                	if tonumber(n) > 0 then
                                		nfCount = nfCount + 1
                                	end
                                end
                                if nfCount < zstring.tonumber(missionStartConditionsParam[2]) then
                                	checkOver = true
                                	break
                                end
                                eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "c" then -- 判断玩家的战力值是否小于等于某个值
                            	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
	                                if zstring.tonumber(_ED.user_info.fighter_capacity) <= zstring.tonumber(missionStartConditionsParam[2]) then
	                                    checkOver = true
	                                    break
	                                end
                            	else
	                                if zstring.tonumber(_ED.user_info.fight_capacity) <= zstring.tonumber(missionStartConditionsParam[2]) then
	                                    checkOver = true
	                                    break
	                                end
	                            end
                                eventIndex = eventIndex + 1
									
                            elseif missionStartConditionsParam[1] == "g" then -- 判断玩家的品质
                                if generalQuality == nil then
                                    local ship = fundShipWidthId(_ED.user_formetion_status[1])
                                    local shipData = elementAt(shipMoulds, ship.ship_template_id)
                                    generalQuality = shipData:atos(ship_mould.ship_type)
                                end
                                if generalQuality <= missionStartConditionsParam[2] then
                                    checkOver = true
                                    break
                                end
                                eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "svl" then -- 判断武将的强化等级
                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
                            	local currShip = fundShipWidthTemplateId(additionParam[1])
                            	if currShip ~= nil then
	                                if currShip.ship_grade <= additionParam[2] then
	                                    checkOver = true
	                                    break
	                                end
                            	end
                                eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "svs" then -- 判断主武将的突破
                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
                            	local currShip = fundShipWidthId(_ED.user_formetion_status[1])
        --                     	local gender = zstring.tonumber(_ED.user_info.user_gender)
								-- gender = gender <= 0 and 1 or gender
        --                     	if currShip.ship_template_id == additionParam[gender] then
        --                             checkOver = true
        --                             break
        --                         end

                                local currShip = fundShipWidthId(_ED.user_formetion_status[1])
			
								local user_camp = 1
								if currShip ~= nil then
									user_camp = dms.int(dms["ship_mould"], currShip.ship_template_id, ship_mould.capacity)
								end
								if currShip.ship_template_id == additionParam[user_camp] then
                                    checkOver = true
                                    break
                                end


                                eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "lvg" then -- 等级礼包
                                local activeItem = _ED.active_activity[12]
                                if activeItem ~= nil then
                                    if zstring.tonumber(activeItem.activity_Info[zstring.tonumber(missionStartConditionsParam[2])].activityInfo_isReward) == 0 then
                                        checkOver = true
                                        break
                                    end
                                end
                                eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "fct" then -- 战士免费招募cd
                                if zstring.tonumber(_ED.free_info[zstring.tonumber(missionStartConditionsParam[2])].next_free_time) <= 0 then
                                    checkOver = true
                                    break
                                end
                                eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "sc" then -- 判断场景宝箱的领取状态
                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
                            	local drawState = zstring.tonumber(_ED.star_reward_state[zstring.tonumber(additionParam[1])])
                            	if drawState == zstring.tonumber(additionParam[2]) then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "nc" then -- 判断NPC宝箱的领取状态
                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
                            	local drawState = zstring.tonumber(_ED.scene_draw_chest_npcs[""..zstring.tonumber(additionParam[1])])
                            	if drawState == zstring.tonumber(additionParam[2]) then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "abw" then -- 竞技场胜利
                            	local abwCount = zstring.tonumber(missionStartConditionsParam[2])
                            	if abwCount == _ED.arena_module.battle_count then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "pbw" then -- 抢夺胜利
                            	local abwCount = zstring.tonumber(missionStartConditionsParam[2])
                            	if abwCount == _ED.plunder_module.battle_count then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "p" then -- 道具是否存在
                            	if fundPropWidthId(missionStartConditionsParam[2]) == nil then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
								
							
							elseif missionStartConditionsParam[1] == "wjpz" then -- 找到指定品质的武将个数,大于时判定完后  wjpz:3-2-0
                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
								
								-- 找到指定品质的战船组个数
								
								local quality = zstring.tonumber(additionParam[1]) -- 品质
								
								local count = zstring.tonumber(additionParam[2]) -- 个数条件
								
								local judge = zstring.tonumber(additionParam[3]) -- 判定条件
								
								local list = getQualityHeroes(quality) --取指定品质战船组
								
								local leng = table.getn(list)

								local isover = false
								if judge == 0 then	-- 判定等于
									if count == leng then
									else
										isover = true
									end
								elseif judge == 1 then -- 判定大于
									if count > leng then
									else
										isover = true
									end
								elseif judge == 2 then -- 判定小于
									if count < leng then
									else
										isover = true
									end
								elseif judge == 3 then -- 判定大于或等于
									if count >= leng then
									else
										isover = true
									end
								elseif judge == 4 then -- 判定小于或等于
									if count <= leng then
									else
										isover = true
									end
								end
								
								if isover == true then
									checkOver = true
                                    break
								end
								
                            	eventIndex = eventIndex + 1						
							elseif missionStartConditionsParam[1] == "feg" then
								if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
									if wfeg then
										local mission_start_conditions = mission[mission_param.mission_start_conditions]
										if mission_start_conditions == "feg:1-0" then
											-- 获取记录值 
											local mission_progress = zstring.tonumber(mission[mission_param.mission_progress])
											if mission_progress > 0 then
												local keyName = "shkp_feg_" .. mission_progress
												local keyStr = readKey(keyName)
												if tostring(keyStr) == tostring(mission_progress) then
													missions = nil
													return
												else
													-- 记录值
													writeKey(keyName, tostring(mission_progress))
												end
											end
										end
									end
									if true then
										checkOver = true
	                                    break
									end
								else
	                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
	                            	local ship = fundShipWidthId(_ED.user_formetion_status[1])
									local equipmentInstance = ship.equipment[ zstring.tonumber(additionParam[1])]
	                            	if equipmentInstance.ship_id == "0" then
	                            		checkOver = true
	                                    break
	                            	end
	                            end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "ges" then
                            	local skillMouldIds = zstring.split(missionStartConditionsParam[2], "-")
                            	local gender = zstring.tonumber(_ED.user_info.user_gender)
                            	gender = gender <= 0 and 1 or gender
                            	local skillMouldId = zstring.tonumber(skillMouldIds[gender])
                            	if getIsEquipSkillMould(skillMouldId) == false then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "wood" then
                            	if zstring.tonumber(_ED.user_info.user_iron) <= zstring.tonumber(missionStartConditionsParam[2]) then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "gold" then
                            	if zstring.tonumber(_ED.user_info.user_silver) <= zstring.tonumber(missionStartConditionsParam[2]) then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "camp" then
                            	if zstring.tonumber(_ED.user_info.user_force) == 0 then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "ct" then
                            	local build_info = zstring.split(missionStartConditionsParam[2], "-")
                            	local build_id = build_info[1]
                            	local build_level = build_info[2]
                            	if zstring.tonumber(_ED.home_build[""..build_id].level) <= zstring.tonumber(build_level) then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "fn" then
                            	local hero_need_numbers = zstring.tonumber(missionStartConditionsParam[2])
                            	local hero_inforamtion_numbers = 0
                            	for i = 2 ,7 do
									if zstring.tonumber(_ED.formetion[i]) ~= 0 then
										hero_inforamtion_numbers = hero_inforamtion_numbers + 1
									end
							    end
                            	if hero_inforamtion_numbers ~= hero_need_numbers then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "npc" then --npc是否打过
                            	local npc_id = zstring.tonumber(missionStartConditionsParam[2])
                            	if _ED.npc_state[npc_id] <= 0 then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "l" then --npc是否打过
                            	local user_info = zstring.split(missionStartConditionsParam[2], "-")
                            	local rls = false
                            	if zstring.tonumber(_ED.user_info.user_grade) < zstring.tonumber(user_info[1]) then
                            		rls = true
                            	end
                            	if false == rls and zstring.tonumber(_ED.user_info.user_experience) <= zstring.tonumber(user_info[2])  then
                            		rls = true
                            	end
                            	if rls then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
							elseif missionStartConditionsParam[1] == "xg" then --星格是否激活
                            	local star_index = zstring.tonumber(missionStartConditionsParam[2])
                            	local formation_temp = {}
							    local position_str = dms.string(dms["formation_mould"],tonumber(_ED.formetion[1]),formation_mould.position)
							    position_str = zstring.split(position_str,",")
							    for i,v in pairs(position_str) do
							        if zstring.tonumber(_ED.formetion[i+1]) ~= 0 then
							            table.insert(formation_temp,_ED.user_ship["".._ED.formetion[i+1]])
							        end
							    end

							    local formation_temp_change_index = {}
							    for i,v in pairs(formation_temp) do
							        table.insert(formation_temp_change_index,formation_temp[#formation_temp-i+1])
							    end

							    local ship = formation_temp_change_index[1]
							    local star_id_str = dms.string(dms["ship_mould"],ship.ship_template_id,ship_mould.star_id_tab)
							    local star_id_tab = zstring.split(star_id_str,",")
							    local star_id = tonumber(star_id_tab[star_index])
							    local stars_state = ship.stars_state

							    local state = 0
							    for i,v in pairs(stars_state) do
							    	if star_id == tonumber(v.star_id) then
							    		state = tonumber(v.state)
							    	end
							    end
							    -- print("=======star_index==",star_index)
							    -- debug.print_r(stars_state)
							    -- print("=====state========,大于0激活，小于0没激活",state)
                            	if state <= 0 then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "fbtc" then -- 新增】带兵量大于XX formation battle team count
                            	if zstring.tonumber(_ED.user_info.soldier) <= zstring.tonumber(missionStartConditionsParam[2]) then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "ubc" then -- 【新增】某建筑数量大于XXXX  ubc:1-3  ubc:建筑ID-数量
                            	local build_info = zstring.split(missionStartConditionsParam[2], "-")
                            	local build_id = tonumber(build_info[1])
                            	local build_count = tonumber(build_info[2])
                            	local nCount = 0
                            	for i, v in pairs(_ED.home_build) do
                            		if tonumber(v.build_mould_id) == build_id then
                            			nCount = nCount + 1
                            		end 
                            		-- debug.print_r(v)
                            		-- print("udc:", v.base_mould_id, build_id, build_count, nCount)
                            	end
                            	if nCount < build_count then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "upl" then -- 【新增】科技中某科技等级大于XXXX upl:1-3 upl:科技id-等级
                            	local scientific_info = zstring.split(missionStartConditionsParam[2], "-")
                            	local scientific_id = scientific_info[1]
                            	local scientific_level = tonumber(scientific_info[2])
                            	if zstring.tonumber(_ED.base_barracks_info[scientific_id].barrack_level) <= scientific_level then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "afbc" then -- 【新增】战地争霸部署数量大于XXXX
                            	local nCount = tonumber(missionStartConditionsParam[2])
                            	if _ED.arena_info.arena_formation == nil then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "tpl" then
                            	local tpl_info = zstring.split(missionStartConditionsParam[2], "-")
                            	local tpl_count = tonumber(tpl_info[1])
                            	local ship_id = tpl_info[2]
                            	local battle_count = tonumber(tpl_info[3])
                            	local ship = fundShipWidthBaseTemplateId(ship_id)
                            	local nCount = 0
                            	local tnCount = 0
                            	if _ED.production_info["0"] ~= nil then
							        for k, v in pairs(_ED.production_info["0"]) do
							            if tonumber(v.production_state) == 0 
							            	then
							            	nCount = nCount + 1
							            	if (v.production_start_time + v.production_start_cd) < _ED.system_time then
							            		tnCount = tnCount + 1
							            	end
							            end
							        end
							    end
							    if nCount == tpl_count then
							    	if 0 == tpl_count or tnCount ~= tpl_count then
								    	if nil == ship or tonumber(ship.ship_count) <= battle_count then
								    		checkOver = true
								    		break
								    	end
								    end
							    end
							    eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "wjmp" then -- 进阶完成,大于时判定完后  wjmp:3-2  wjmp:模板ID-阶数
                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
                            	local ship = fundShipWidthTemplateId(additionParam[1])
                            	local quality = zstring.tonumber(additionParam[2]) -- 品阶
                            	if tonumber(ship.Order) < quality then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "wjms" then -- 进星完成,大于时判定完后  wjms:3-2  wjms:模板ID-阶数
                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
                            	local ship = fundShipWidthTemplateId(additionParam[1])
                            	local star = zstring.tonumber(additionParam[2]) -- 星数
                            	if tonumber(ship.StarRating) < star then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            elseif missionStartConditionsParam[1] == "wjme" then -- 进化完成,大于时判定完后  wjme:3-2  wjms:模板ID-进化等级
                            	local additionParam = zstring.split(missionStartConditionsParam[2], "-")
                            	local ship = fundShipWidthTemplateId(additionParam[1])
                            	local evom = zstring.tonumber(additionParam[2]) -- 进化等级
                            	local ship_evo = zstring.split(ship.evolution_status, "|")
                            	if tonumber(ship_evo[1]) < evom then
                            		checkOver = true
                                    break
                            	end
                            	eventIndex = eventIndex + 1
                            else
                                checkOver = true
                                break
                            end
                        end
                    end
                else
                    checkOver = true
                    break
                end
            end
            mission =  missions[eventIndex + 1]
			if mission ~= nil then
				missionId = dms.atoi(mission, mission_id)
				eventRepeat = dms.atos(mission, mission_repeat)

				missionRepeatTarget = dms.atos(mission, mission_repeat_target)
				repeatEventInfo = zstring.split(missionRepeatTarget, ",")
				if table.getn(repeatEventInfo) >= 3 and repeatEventInfo[2] ~= nil and repeatEventInfo[3] ~= nil then
					local tempEventIndex = zstring.tonumber(repeatEventInfo[3])
					if tempEventIndex > eventIndex then
						eventIndex = tempEventIndex
						mission =  missions[eventIndex + 1]
						missionId = dms.atoi(mission, mission_id)
						eventRepeat = dms.atos(mission, mission_repeat)
					end
				end
			else
				missions = nil
            end
        end
        -- SenderRecodeExt()
	end
end

function missionIsOver()
	if missions == nil then
		return true
	else
		local eventCount = #missions
		if eventIndex >= eventCount then
			return true
		end
	end
	return false
end

function isMissionSnatch()
	if mission==nil then
		return false
	else
		local snatchMissionProgress = dms.atoi(mission, mission_progress) 
		local snatchMissionId = dms.atoi(mission, mission_id)
		if snatchMissionProgress >= 301101 and snatchMissionProgress <= 3011028 and snatchMissionId == 11 then
			return true
		end
	end
	return false
end

function missionType()
	return mission_mould
end
	

function executeMission(missionMould, triggerTiming, emtOffVal, executeOverCallback, canExecute)
	local currentAccount = _ED.user_platform[_ED.default_user].platform_account
	local currentServerNumber = _ED.all_servers[_ED.selected_server].server_number
	local texBaseEData = exBaseEData
	exBaseEData = false
	saveKeyBase = currentAccount..currentServerNumber.."ds".."end"
	if missions ~= nil then
		if (mission ~= nil and mission._isOver == true) or waitExecuteMission or canExecute == true then
			waitExecuteMission = false
			mission_executeOverCallback = executeOverCallback
			executeEvent()
		end
		return true
	end
	mission_mould = missionMould
	local function getUserShip()
		for i, v in pairs(_ED.user_ship) do
			local shipData = elementAt(shipMoulds, tonumber(v.ship_template_id))
			local shipType = shipData:atoi(ship_mould.captain_type)
			if shipType == 0 then
				return v
			end
		end
	end
	if mission_mould == mission_mould_tuition then
	   if __lua_project_id == __lua_project_all_star 
	        or __lua_project_id == __lua_project_superhero  then 
		   if  tonumber(emtOffVal) == 10 then  --10级新手教学时先卸下主角已装备的4号类型宝物
				local _shipId = getUserShip()
				for i, equip in pairs(_shipId.equipment) do
					if i > 6 then
						break
					end				
					if tonumber(equip.ship_id) > 0 then  
						if tonumber(equip.equipment_type) == 4 then
							local str = ""
							str = str.._shipId.ship_id.."\r\n"
							str = str.."0".."\r\n"
							str = str..equip.equipment_type
							protocol_command.equipment_adorn.param_list = str
							Sender(protocol_command.equipment_adorn.code, nil, nil, nil, nil, nil)
						end
					end
				end 
			end
		end
		checkMission(currentAccount, currentServerNumber, "tt", emtOffVal, triggerTiming)
	elseif mission_mould == mission_mould_battle then
		checkMission(currentAccount, currentServerNumber, "bt", emtOffVal, triggerTiming)
	else
		checkMission(currentAccount, currentServerNumber, "sn", emtOffVal, triggerTiming)
	end
	
	currentEventBattleRoundCound = 0
	if missions ~= nil then
		mission_executeOverCallback = executeOverCallback
		waitExecuteMission = true
		if canExecute == nil or canExecute == true then
			waitExecuteMission = false
			executeEvent()
		end
	else
		mission_mould = "" --0
	end
	
	local result = missions ~= nil and true or false
	if result == false and texBaseEData == true then
		checkOverMission(currentAccount, currentServerNumber, "ds")
		if missions ~= nil then
			mission_executeOverCallback = executeOverCallback
			executeEvent()
			return true
		end
	end
	
	return result
end

function executeMissionExt(missionMould, triggerTiming, emtOffVal, executeOverCallback, canExecute, cmpOffVal, executeRepeatEvent)
	app.load("client.utils.texture_cache")
	-- cacher.addTextureAsync(texture_cache_load_images_mission_dialog)
	local currentAccount = _ED.user_platform[_ED.default_user].platform_account
	local currentServerNumber = _ED.all_servers[_ED.selected_server].server_number
	local texBaseEData = exBaseEData
	exBaseEData = false
	saveKeyBase = currentAccount..currentServerNumber.."ds".."end"
	if missions ~= nil then
		if (mission ~= nil and mission._isOver == true) or waitExecuteMission or canExecute == true then
			waitExecuteMission = false
			mission_executeOverCallback = executeOverCallback
			executeEvent()
		end
		return true
	end
	mission_mould = missionMould
	if mission_mould == mission_mould_tuition then
		checkMissionExt(emtOffVal, triggerTiming, cmpOffVal, executeRepeatEvent)
	elseif mission_mould == mission_mould_battle then
		checkMissionExt(emtOffVal, triggerTiming, cmpOffVal, executeRepeatEvent)
	else
		checkMissionExt(emtOffVal, triggerTiming, cmpOffVal, executeRepeatEvent)
	end
	
	currentEventBattleRoundCound = 0
	if missions ~= nil then
		mission_executeOverCallback = executeOverCallback
		waitExecuteMission = true
		if canExecute == nil or canExecute == true then
			waitExecuteMission = false
			executeEvent()
		end
	else
		mission_mould = ""
	end

	local result = missions ~= nil and true or false
	if result == false and texBaseEData == true then
		if missions ~= nil then
			mission_executeOverCallback = executeOverCallback
			executeEvent()
			return true
		end
	end
	return result
end

-- 在保存进度时,检查进度,在指定的进度完成后做一些事情
function checkupExecuteEventDispose(mission)
	-- 检查当前是 第几个进度
	if mission ~= nil then
		local mission_progress = zstring.tonumber(mission[mission_param.mission_progress])

		-- 10204 事件进度 是 5级教学后对话完毕开启副本2-1了,提示首充弹窗--去除,挪到2-2之后
		-- 308021 事件进度 是 10级演习教学后对话完毕,提示首充弹窗
		if mission_progress == 308021 then
			state_machine.excute("show_activity_first_recharge_popup", 0, nil)
		end
	end
end

local missionLock = false -- 锁定期间不进行下一步操作
local last_mission_type = 0
local current_execute_type = ""
function saveExecuteEvent(mission, bRet, unlock)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		if nil ~= mission then
			local execute_type = dms.atos(mission, mission_execute_type) 
			if execute_type == execute_type_touchUI then
				local mission_skip_id = dms.atoi(mission, mission_skip_id) 
				if mission_skip_id > 0 then
					eventIndex = mission_skip_id
					fwin:close(fwin:find("WindowLockClass"))
				end

				local mission_start_conditions = mission[mission_param.mission_start_conditions]
				if mission_start_conditions == "feg:1-0" then
					-- 获取记录值 
					local mission_progress = zstring.tonumber(mission[mission_param.mission_progress])
					if mission_progress > 0 then
						local keyName = "shkp_feg_" .. mission_progress
						local keyStr = readKey(keyName)
						if tostring(keyStr) == tostring(mission_progress) then
							-- missions = nil
							-- return
						else
							-- 记录值
							writeKey(keyName, tostring(mission_progress))
						end
					end
				 end
			end
		end
	end

	checkupExecuteEventDispose(mission)
	
	if saveKeyBase ~= nil then
		--CCUserDefault:sharedUserDefault():setStringForKey(saveKeyBase, saveBaseEData)
	end
	if unlock ~= nil then
		missionLock = false
	end
	if missionLock == true then
		return
	end
	saveEData = ""..missionId..","..eventIndex..","..eventRepeat..","..complated..","..offval
	-- SenderRecode()
	SenderRecodeExt()

	--CCUserDefault:sharedUserDefault():setStringForKey(saveKey, saveEData)
	--CCUserDefault:sharedUserDefault():flush()
	eventIndex = eventIndex + 1
	if bRet == true then
		mission._isOver = true
		executeEvent()
	end
	
	-- if current_execute_type == execute_type_startTuition then
		-- tuitionMissionId = dms.atoi(mission, mission_param1)
		--> debug.print_r(mission)
		--> print("加载教学事件", tuitionMissionId)
		-- executeEvent()
		
		-- executeMission(mission_mould_tuition, 0, "0", nil)
	-- end
	
	if bRet == false and missions ~= nil then
		local eventCount = #missions
		if eventIndex >= eventCount then
			if mission ~= nil then
				local execute_type = dms.atos(mission, mission_execute_type)
				if execute_type == execute_type_dialog then
					return
				end
			end
			executeEvent()
		end
	end
end

saveExecuteEventByOfScriptAfter = function ( ... )
	if mission ~= nil then
		saveExecuteEvent(mission, true)
	end
end

-- 根据索引,变更当前执行的事件
changeExecuteEvent = function(index)
	eventIndex = index
end

currentExecuteMission = function( ... )
	return mission
end

app.load("client.mission.missionex.WindowLock")
___stop_mission = false
executeEvent = function()
	if missions == nil then
		return
	end
	if missionLock == true or ___stop_mission == true then
		return
	end
	local eventCount = #missions
	mission = eventIndex < eventCount and missions[eventIndex + 1] or nil
	local windowLock = fwin:find("WindowLockClass")
	if windowLock == nil then
		local windows = WindowLock:new()
		if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  
			or __lua_project_id == __lua_project_red_alert 
			or __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim
			then
			local isChangeEvent = false
			if mission ~= nil then
				local isNeedChangeClickEvent = tonumber(dms.atos(mission, mission_param3))
				if isNeedChangeClickEvent == 1 then
					isChangeEvent = true		
				end
			end
			fwin:open(windows:init(isChangeEvent), fwin._windows)
		else
			fwin:open(windows:init(), fwin._windows)
		end
	end
	state_machine.excute("window_lock_swallow_touches", 0, true)

	if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  then
		local now_skip_id = dms.atoi(mission,mission_param.mission_skip_id)
		local skipDialogue = fwin:find("LRoleDialogueSkipClass")
		if now_skip_id == 1 then
			app.load("client.mission.missionex.LRoleDialogueSkip")	
			if skipDialogue == nil then
				local skip_btn = LRoleDialogueSkip:new()
				skip_btn:init(eventIndex,mission,missions)
				fwin:open(skip_btn,fwin._dialog)
			else
				skipDialogue:init(eventIndex,mission,missions)
			end
		else
			if skipDialogue ~= nil then
				fwin:close(skipDialogue)
			end
		end
	end

	if __lua_project_id == __lua_project_red_alert 
		-- or __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim
		then
		if _ED.user_info ~= nil and _ED.user_info.user_grade ~= nil and
			_ED.user_info.user_grade ~= "" and tonumber(_ED.user_info.user_grade) <= 1 
			and fwin:find("BattleSceneClass") == nil 
			and fwin:find("MainWindowClass") == nil
			then
			app.load("client.mission.missionex.CGSkip")
			local skipnext1 = fwin:find("CGSkipClass")
			if skipnext1 ~= nil then 
				fwin:close(skipnext1) 
			end
			local skipnextWnd1 = CGSkip:new()
			skipnextWnd1:init(eventIndex,skipIndex)
			fwin:open(skipnextWnd1, fwin._system)
		else
			local skipnext1 = fwin:find("CGSkipClass")
			if skipnext1 ~= nil then 
				fwin:close(skipnext1)
			end
		end
	end

	if mission ~= nil then

	------------------------------------------------------------------------------------------------------
	-- 用于处理剧情跳过
	------------------------------------------------------------------------------------------------------
		local is2002 = false
			if __lua_project_id == __lua_project_warship_girl_a 
			or __lua_project_id == __lua_project_warship_girl_b 
			or __lua_project_id == __lua_project_digimon_adventure 
			or __lua_project_id == __lua_project_naruto 
			or __lua_project_id == __lua_project_pokemon 
			or __lua_project_id == __lua_project_rouge 
			or __lua_project_id == __lua_project_yugioh 
			or __lua_project_id == __lua_project_koone
			-- or __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim
			then
				if dev_version >= 2002 then
					is2002 = true
				end
			end
		
		if true == is2002 then
			local mission_skip_id = mission[mission_param.mission_skip_id]
			local skipIndex = zstring.tonumber(mission_skip_id)
			if skipIndex ~= 0 then
				app.load("client.mission.missionex.CGEventSkipNext")
				local skipnext = fwin:find("CGEventSkipNextClass")
				if skipnext ~= nil 
					then 
					fwin:close(skipnext) 
				end
				local skipnextWnd = CGEventSkipNext:new()
						
				skipnextWnd:init(eventIndex,skipIndex)
				fwin:open(skipnextWnd, fwin._system)
						
				--eventIndex = e2
				--mission = missions[eventIndex]
			end
				
			local mission_skip_id = mission[mission_param.mission_skip_id]
			if zstring.tonumber(mission_skip_id) == 0 then
				local skipnext = fwin:find("CGEventSkipNextClass")
				if skipnext ~= nil 
					then 
					fwin:close(skipnext) 
				end
			end
			if __lua_project_id == __lua_project_warship_girl_a 
				or __lua_project_id == __lua_project_warship_girl_b 
				or __lua_project_id == __lua_project_digimon_adventure 
				or __lua_project_id == __lua_project_naruto 
				or __lua_project_id == __lua_project_pokemon 
				or __lua_project_id == __lua_project_rouge 
				or __lua_project_id == __lua_project_yugioh 
				then
				if _ED.user_info.user_id == nil 
					or _ED.user_info.user_id == "" 
					then
					app.load("client.mission.missionex.CGSkip")
					local skipnext1 = fwin:find("CGSkipClass")
					if skipnext1 ~= nil then fwin:close(skipnext1) end
					local skipnextWnd1 = CGSkip:new()
							
					skipnextWnd1:init(eventIndex,skipIndex)
					fwin:open(skipnextWnd1, fwin._system)
							
					--eventIndex = e2
					--mission = missions[eventIndex]
					end
						
					local mission_skip_id = mission[mission_param.mission_skip_id]
					if zstring.tonumber(mission_skip_id) == 0 then
					local skipnext1 = fwin:find("CGSkip")
					if skipnext1 ~= nil then fwin:close(skipnext1) end
				end
			end	
		end

		-- 跳过事件段
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			local missionParam13 = mission[mission_param.mission_param13]
			if #missionParam13 > 2 then
				local snw = fwin:find("EventsTeachingSkipClass")
				if nil == snw then
					app.load("client.mission.missionex.EventsTeachingSkip")
					state_machine.excute("events_teaching_skip_open", 0, mission)
				else
					state_machine.excute("events_teaching_skip_open", 0, mission)
				end
			else
				local mission_skip_id = mission[mission_param.mission_skip_id]
				if zstring.tonumber(mission_skip_id) == -1 then
					app.load("client.mission.missionex.CGSkip")
					local skipnext1 = fwin:find("CGSkipClass")
					if skipnext1 ~= nil then fwin:close(skipnext1) end
					local skipnextWnd1 = CGSkip:new()
							
					skipnextWnd1:init(eventIndex,skipIndex)
					fwin:open(skipnextWnd1, fwin._system)
							
					--eventIndex = e2
					--mission = missions[eventIndex]
					end
						
					local mission_skip_id = mission[mission_param.mission_skip_id]
					if zstring.tonumber(mission_skip_id) == 0 then
					local skipnext1 = fwin:find("CGSkip")
					if skipnext1 ~= nil then fwin:close(skipnext1) end
				end
				state_machine.excute("events_teaching_skip_exit", 0, 0)
			end
		end
	------------------------------------------------------------------------------------------------------

		eventRepeat = dms.atos(mission, mission_repeat)
		saveBaseEData = dms.atos(mission, mission_repeat_target)
		if saveKeyBase ~= nil then
			--CCUserDefault:sharedUserDefault():setStringForKey(saveKeyBase, saveBaseEData)
		end
		
		-- SenderRecode()
		
		local missionProgress = dms.atos(mission, mission_progress)
		
		if m_tOperateSystem == 5 then
			if missionProgress == "301014" then
				require "script/transformers/tip/MarketplaceReviewTask"
				if MarketplaceReviewTaskDialog ~= nil then
					MarketplaceReviewTaskDialog()
				end
			end
		end
		local bRet = false
		local execute_type = dms.atos(mission, mission_execute_type) -- dms.atoi(mission, mission_execute_type)
		-- print("execute_type", execute_type)
		last_mission_type = current_execute_type
		current_execute_type = execute_type
		if last_mission_type == execute_type_touchUI and current_execute_type ~= execute_type_touchUI then
			--print("关闭教学指引窗口！")
			state_machine.excute("tuition_controller_exit", 0, "")
		end
		if execute_type ~= execute_type_dialog and execute_type ~= execute_type_treasure_drop
			and execute_type ~= execute_type_get_resource then
			if MissionClass._pDialog ~= nil then
				MissionClass._pDialog:removeFromParent(true)
				MissionClass._pDialog = nil
			end
		end
		
		local missionRound = dms.atoi(mission, mission_round)
		if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  
			or __lua_project_id == __lua_project_red_alert 
			or __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim
			then
			if missionRound ~= currentEventBattleRoundCound and isInBattler == true then
				return
			end
		else
			if isRunning() == true and missionRound > currentEventBattleRoundCound then
				--LuaClasses["BattleSceneClass"].nextAttack()
				if MissionClass._pDialog ~= nil then
					MissionClass._pDialog:removeFromParent(true)
					MissionClass._pDialog = nil
				end
				LuaClasses["BattleSceneClass"].missionAttack()
				--[[
				if mission_executeOverCallback ~= nil then
					mission_executeOverCallback()
					mission_executeOverCallback = nil
				else
					LuaClasses["BattleSceneClass"].missionAttack()
				end
				--]]
				return
			end
		end

		if __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			then
			if true == _mission_play_effect then
				_mission_play_effect = false

				stopEffect()
				-- stopAllEffects()
				-- cc.SimpleAudioEngine:getInstance():stopAllEffects()
			end
		end

		if execute_type ~= execute_type_touchUI then 
			local tuitionWindow = fwin:find("TuitionControllerClass")
			if tuitionWindow ~= nil then
				fwin:close(tuitionWindow)
			end
		end

		if execute_type == execute_type_change_scene then
			_ED._current_scene_id = tonumber(dms.atos(mission, mission_param1))
			if _ED._current_scene_id == 0 then
				draw.scene = nil
				-- cc.Director:getInstance():runWithScene(draw.scene)
				local scene = CCScene:create()
				cc.Director:getInstance():replaceScene(scene)
		
				LuaClasses["MainWindowClass"]._buttonIndex = 1
				LuaClasses["MainWindowClass"]:Draw()
			else
				LuaClasses["PlotSceneClass"].Draw()
			end
			bRet = true
		elseif execute_type == execute_type_changeBackground then
			if isRunning() == true then
				LuaClasses["BattleSceneClass"].changeBackground(dms.atos(mission, mission_param1))
			else
				LuaClasses["PlotSceneClass"].changeBackground(dms.atos(mission, mission_param1))
			end
			bRet = true
		elseif execute_type == execute_type_bgMusic then
			local musicIndex = dms.atoi(mission, mission_param1)
			if musicIndex >= 0 then
				playBgm(formatMusicFile("background", musicIndex))
			end
			bRet = true
		elseif current_execute_type == execute_type_startTuition then
			tuitionMissionId = dms.atoi(mission, mission_param1)
			local missionType = dms.atoi(mission, mission_param2)
			missions = nil
			executeEvent()
			if missionType == 1 then
				executeMission(mission_mould_plot, 0, "0", nil)
			elseif missionType == 2 then
				executeMission(mission_mould_battle, 0, "0", nil)
			else
				executeMission(mission_mould_tuition, 0, "0", nil)
			end
			return
		elseif execute_type == execute_type_touchUI then
			local hFightWnd = fwin:find("FightClass")
			if hFightWnd ~= nil then
				if BattleSceneClass._isSkepBattle ~= true then
					state_machine.excute("fight_attack_logic_round_running", 0, 0)
				else
					if fwin:find("PlunderBattleRewardClass") == nil and fwin:find("BattleWinCardLotteryClass") == nil then
						state_machine.excute("fight_check_skeep_fight", 0, 0)
					end
				end
			end
			state_machine.excute("battle_ui_change_show_state", 0, true)
			executeTouchUI()
			return
		elseif execute_type == execute_type_openWindow then
			-- MainWindowClass.openWindow(LuaClasses[dms.atos(mission, mission_param1)])
			executeOpenWindows()
			bRet = true
		elseif execute_type == execute_type_drawEffect then
			local armatureName = dms.atos(mission, mission_param1)
			local armatureFile = string.format("effect/effice_%s.ExportJson", armatureName)
			armatureName = string.format("effice_%s", armatureName)
			local armaturePad = nil
			local loop =  dms.atoi(mission, mission_param4)
			
			local effectType = dms.atoi(mission, mission_param7)
			if __lua_project_id==__lua_project_all_star 
				or __lua_project_id == __lua_king_of_adventure or true then
				if loop == 0 and effectType ~= 1 then
					local armatureBack = fwin:find("FightMapClass"):getBackgroundPanel():getChildByTag(1) -- LuaClasses["BattleSceneClass"]._widgetBg:getChildByTag(1)
					if armatureBack ~= nil then
						local fileName = armatureBack._fileName
						-- tolua.cast(armatureBack, "cc.Node"):removeFromParent(true)
						armatureBack:removeFromParent(true)
						-- CCArmatureDataManager:sharedArmatureDataManager():removeArmatureFileInfo(fileName)
						ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo(fileName)
					end
					saveExecuteEvent(mission, true)
					return
				end
			end
			local x, y = tonumber(dms.atoi(mission, mission_param2)), tonumber(dms.atoi(mission, mission_param3))
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				local modeParams = zstring.split(dms.atos(mission, mission_param13), ",")
				local mode = dms.atoi(modeParams[1])
				local anchorX = dms.atof(mission, mission_param14)
				local anchorY = dms.atof(mission, mission_param15)
				x = x + (fwin._width - app.baseOffsetX) * anchorX
				y = y + (fwin._height - app.baseOffsetY) * anchorY
				if mode == 1 then
					x = x - app.baseOffsetX / 2
					y = y - app.baseOffsetY / 2
				end
				if ((app.screenSize.width == 2436 and app.screenSize.height == 1125)
                        or (app.screenSize.width == 1624 and app.screenSize.height == 750)
                        ) then
					if nil ~= modeParams[2] then
						x = x + tonumber(modeParams[2])
					end
					if nil ~= modeParams[3] then
						y = y + tonumber(modeParams[3])
					end
				end
			end
			local className = dms.atos(mission, mission_param5)
			if #className < 4 then
				className = "FightMapClass"
			end
			local window = fwin:find(className)
			if nil == window then
				window = fwin._view._layer
			end
			local root = window
			if window.getBackgroundPanel ~= nil then
				root = window:getBackgroundPanel()
			end
			
			local effect = nil
			if effectType == 1 then
				local baseNames = zstring.split(dms.atos(mission, mission_param1), ",")
				local baseName = baseNames[1]
				if loop > 0 or loop < 0 then
					local skeletonNode = sp.spine(baseName .. ".json", baseName .. ".atlas", 1, 0, nil, false, nil)
					skeletonNode:registerSpineEventHandler(function (event)
						local armatureBack = event.skeletonAnimation
						if armatureBack ~= nil and armatureBack._LastsCountTurns > 0 then
							if armatureBack._LastsCountTurns > 0 then
								-- 删除光效
								armatureBack._LastsCountTurns = armatureBack._LastsCountTurns == nil and 0 or armatureBack._LastsCountTurns - 1
								if armatureBack._LastsCountTurns <= 0 then
									local tmission = armatureBack._mission
									armatureBack._mission = nil
									armatureBack:removeFromParent(true)
									mission_effect = nil
									local skipnext1 = fwin:find("CGSkipClass")
									if skipnext1 ~= nil then 
										fwin:close(skipnext1)
									end
									if __lua_project_id == __lua_project_red_alert_time 
										or __lua_project_id == __lua_project_pacific_rim 
										or __lua_project_id == __lua_project_l_digital 
										or __lua_project_id == __lua_project_l_pokemon 
										or __lua_project_id == __lua_project_l_naruto  
										then
										cacher.removeAllTextures()
									else
										cacher.destorySystemCacher(nil)
									end
									if dms.atoi(tmission, mission_param6) ~= 1 then
										saveExecuteEvent(tmission, true)
									end
								end
							end
						end
					end, sp.EventType.ANIMATION_COMPLETE)

					skeletonNode:setAnimation(0, dms.atos(mission, mission_param8), true)
					if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
						skeletonNode:registerSpineEventHandler(function (event)
					        if event.eventData.stringValue ~= "" and event.eventData.stringValue ~= " " then
					        	local params = zstring.split(event.eventData.stringValue, "_")
					        	if params[1] == "change" then
					        		-- local coord = zstring.split(params[2], ",")
					        		-- state_machine.excute("home_map_scroll_to_position", 0, {cc.p(coord[1], coord[2]), false, 0})
					        	elseif params[1] == "move" then
					        		-- local coord = zstring.split(params[2], ",")
					        		-- state_machine.excute("home_map_scroll_to_position", 0, {cc.p(coord[1], coord[2]), true, tonumber(coord[3])})
					        	elseif params[1] == "come" then
					        		playEffect(formatMusicFile("effect", dms.atoi(mission, mission_param10)))	
					        	end
					        end
					    end, sp.EventType.ANIMATION_EVENT)
					end

					skeletonNode:setTimeScale(1.0 / cc.Director:getInstance():getScheduler():getTimeScale())

					if #baseNames > 1 then
						for i = 2, #baseNames do
							local skeletonNode2 = sp.spine(baseNames[i] .. ".json", baseNames[i] .. ".atlas", 1, 0, nil, false, nil)
							skeletonNode2:setAnimation(0, dms.atos(mission, mission_param8), true)
							skeletonNode:addChild(skeletonNode2, 1)
							skeletonNode2:setTimeScale(1.0 / cc.Director:getInstance():getScheduler():getTimeScale())
						end
					end

					root:addChild(skeletonNode, dms.atoi(mission, mission_param9))
					root.__event_effects = root.__event_effects or {}
					root.__event_effects[baseName] = skeletonNode
					
					effect = skeletonNode
					effect._LastsCountTurns = loop
				else
					if loop == 0 then
						local skeletonNode = root.__event_effects[baseName]
						root.__event_effects[baseName] = nil
						--if nil ~= skeletonNode then
							root:removeChild(skeletonNode, true)
						--end
					end
				end
			else
				effect = draw.createEffect(armatureName, armatureFile, root, loop)
			end
			mission_effect = effect
			
			if __lua_project_id == __lua_king_of_adventure or true then
				if nil ~= effect then
					local parent_node = root --fwin:find("FightMapClass"):getBackgroundPanel()
					if armatureName == "effice_4003" or armatureName == "effice_4004" or armatureName == "effice_4005" 
					or armatureName == "effice_4006" or armatureName == "effice_4007" then
						parent_node:reorderChild(effect, 1000)
					else
						parent_node:reorderChild(effect, 4000)
					end
				end
			end
			
			if __lua_project_id==__lua_project_all_star 
				or __lua_project_id == __lua_king_of_adventure or true then
				if loop == -1 then
					if nil ~= effect then
						effect:setTag(1)
					end
				end
			end
			if nil ~= effect then
				effect:setPosition(cc.p(x, y))
			end
			local function drawEffectMissionOverFunc(armatureBack)
				if armatureBack == nil then
					return
				end
				
				if armatureBack._LastsCountTurns > 0 then
					-- 删除光效
					armatureBack._LastsCountTurns = armatureBack._LastsCountTurns == nil and 0 or armatureBack._LastsCountTurns - 1
					if armatureBack._LastsCountTurns <= 0 then
						local fileName = armatureBack._fileName
						local tmission = armatureBack._mission
						armatureBack._mission = nil
						-- tolua.cast(armatureBack, "cc.Node"):removeFromParent(true)
						armatureBack:removeFromParent(true)
						-- 删除光效文件
						-- CCArmatureDataManager:sharedArmatureDataManager():removeArmatureFileInfo(fileName)
						ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo(fileName)
						if dms.atoi(tmission, mission_param6) ~= 1 then
							saveExecuteEvent(tmission, true)
						end
					end
				end
			end
			if loop > 0 then
				effect._invoke = drawEffectMissionOverFunc
				effect._mission = mission
				if dms.atoi(mission, mission_param6) ~= 1 then
					return
				end
			end
			bRet = true
		elseif execute_type == execute_type_requestFight then
			-- local function responseBattleFieldInitCallback(_cObj, _tJsd)
				-- local pNode = tolua.cast(_cObj, "cc.Node")
				-- local pDataInterpreter = tolua.cast(_tJsd, "CCNetworkDataInterpreter")
				-- if pDataInterpreter ~= nil and pDataInterpreter:isSucceed() == true then
					-- saveExecuteEvent(mission, false)
					-- LuaClasses["BattleSceneClass"].Draw()
					-- -- cc.Director:getInstance():touchListener(true)
					-- if __lua_project_id == __lua_king_of_adventure then
						-- if mission ~= nil then
							-- local currentMissionId = dms.atos(mission, mission_progress)
							-- if currentMissionId == "10102" then
								-- LuaClasses["BattleSceneClass"].hideMaster()
								-- LuaClasses["BattleSceneClass"].changeBackground(11)
							-- elseif currentMissionId == "203057" then
								-- LuaClasses["BattleSceneClass"].hideMaster()
								-- LuaClasses["BattleSceneClass"].changeBackground(103)
							-- elseif currentMissionId == "302010" or
								-- currentMissionId == "304020" or 
								-- currentMissionId == "30703" or 
								-- currentMissionId == "302105" or 
								-- currentMissionId == "203065" or 
								-- currentMissionId == "302005" or 
								-- currentMissionId == "30808" then
								-- LuaClasses["BattleSceneClass"].hideMaster()
							-- end
						-- end
					-- end
				-- else
					-- local scheduler = cc.Director:getInstance():getScheduler()
					-- local responseBattleFieldInitEntry = nil
					-- local function responseBattleFieldInitStep()
						-- if responseBattleFieldInitEntry ~= nil then
							-- scheduler:unscheduleScriptEntry(responseBattleFieldInitEntry)
							-- responseBattleFieldInitEntry = nil
						-- end
						-- -- 添加断连 请求链接
						-- if draw.isLogin == false then
							-- if Sender(protocol_command.battle_field_init.code, nil, nil, nil, nil, responseBattleFieldInitCallback,1) ~= nil then
								-- showConnecting()
							-- end
						-- end
					-- end
					-- responseBattleFieldInitEntry = scheduler:scheduleScriptFunc(responseBattleFieldInitStep, 1, false)
					
				-- end
			-- end
			--DOTO 战斗请求
			local _battle_type = dms.atoi(mission, mission_param5)
			local function responseBattleFieldInitCallback(response)
				if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
					if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
						for i,v in pairs(_ED.scene_max_state) do
							if tonumber(v) == -1 then
								_ED._now_scene_count = i
								break
							end
						end
						for i,v in pairs(_ED.scene_max_state) do
							if i > 50 and tonumber(v) == -1 then
								_ED._now_hard_scene_count = i
								break
							end
						end
					end
					saveExecuteEvent(mission, false)

					local fightLoadingCell = fwin:find("FightLoadingCellClass")
					if fwin:find("FightLoadingCellClass") == nil then
						-- _ED._npc_addition_params = senderStr
						app.load("client.battle.BattleStartEffect")
						local bse = BattleStartEffect:new()
						bse:init(1)
						fwin:open(bse, fwin._windows)
					else
						fightLoadingCell._unload = false
					end
					
					app.load("client.battle.fight.Fight")
					if _battle_type == 1 then
						Fight._lock_start_count = 3
					end
				end
			end
				
			_ED._current_scene_id =  dms.atos(mission, mission_param1)
			local envId = zstring.split(dms.atos(mission, mission_param2), ",")
			_ED._scene_npc_id = dms.atos(mission, mission_param3)
			_ED._npc_difficulty_index = dms.atos(mission, mission_param4)
			local _battle_type = dms.atoi(mission, mission_param5)
			local unlockNpc = dms.atos(mission, mission_param6)
			_ED._battle_eve_unlock_npc = unlockNpc
			local battleCount = dms.atos(mission, mission_param7)

			_ED._battle_eve_release_ship_id = dms.atos(mission, mission_param10)
			_ED._battle_eve_auto_fight = tonumber(dms.atos(mission, mission_param11)) == 1
			
			local senderStr = ""

			local currShip = fundShipWidthId(_ED.user_formetion_status[1])
			
			local user_camp = 1
			if currShip ~= nil then 
				user_camp = dms.int(dms["ship_mould"], currShip.ship_template_id, ship_mould.capacity)
				if user_camp < 1 then
					user_camp = 1
				end
			end

			_ED._battle_eve_environment_ship_id = envId[zstring.tonumber(user_camp)]

			if _battle_type == 1 then		-- EVE的战斗
				_ED._battle_init_type = "0"
				-- senderStr = senderStr .. "1,".._ED._scene_npc_id..","..unlockNpc..","..battleCount
				
				if __lua_project_id == __lua_king_of_adventure then 
					senderStr = senderStr .. "1,"..envId[zstring.tonumber(_ED.user_info.user_head)]..","..unlockNpc..","..battleCount
				else
					-- senderStr = senderStr .. "1,"..envId[zstring.tonumber(_ED.user_info.user_gender)]..","..unlockNpc..","..battleCount
					senderStr = senderStr .. "1,"..envId[zstring.tonumber(user_camp)]..","..unlockNpc..","..battleCount
				end
				
			elseif _battle_type ==0 then	-- 脚本战斗
				-- senderStr = senderStr .. "2,".._ED._current_scene_id..",".._ED.user_info.user_gender..","..battleCount
				senderStr = senderStr .. "2,".._ED._current_scene_id..","..user_camp..","..battleCount
				_ED._battle_init_type = "0"
			end
			
			-- _ED._npc_addition_params = senderStr
			-- app.load("client.battle.BattleStartEffect")
			-- local bse = BattleStartEffect:new()
			-- bse:init(1)
			-- fwin:open(bse, fwin._windows)
			
			-- cc.Director:getInstance():touchListener(false)
			if __lua_project_id == __lua_project_legendary_game then			-- 超神请求本地战斗数据
				app.load("client.battle.report.BattleReport")
				local fightModule = FightModule:new()
				fightModule:initFight(_ED._scene_npc_id, _ED._npc_difficulty_index, 0)
				fightModule:doFight()
				
				responseBattleInitCallback({RESPONSE_SUCCESS = true, PROTOCOL_STATUS = 0})
			elseif __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon 
				or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				local function responseBattleStartCallback( response )
					if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						app.load("client.battle.report.BattleReport")
						local resultBuffer = {}
						if _ED._fightModule == nil then
							_ED._fightModule = FightModule:new()
						end
						_ED.attackData = {
							roundCount = _ED._fightModule.totalRound,
							roundData ={}
						}
						_ED._fightModule:initFight(_ED._scene_npc_id, _ED._npc_difficulty_index, _battle_type, resultBuffer, _ED._battle_eve_environment_ship_id)
						local orderList = {}
						_ED._fightModule:initFightOrder(_ED.user_info, orderList)
						_ED._is_eve_battle = true
						_ED.battleData.battle_init_type = 0
						
						responseBattleFieldInitCallback({RESPONSE_SUCCESS = true, PROTOCOL_STATUS = 0})
					end
				end
				app.load("client.battle.fight.FightEnum")
				protocol_command.battle_result_start.param_list = "".._enum_fight_type._fight_type_0.."\r\n".._ED._current_scene_id.."\r\n".._ED._scene_npc_id.."\r\n".._ED._npc_difficulty_index.."\r\n"..senderStr
				NetworkManager:register(protocol_command.battle_result_start.code, nil, nil, nil, nil, responseBattleStartCallback, false, nil)
			else
				protocol_command.battle_field_init.param_list = "".._ED._current_scene_id.."\r\n".._ED._scene_npc_id.."\r\n".._ED._npc_difficulty_index.."\r\n"..senderStr
				-- Sender(protocol_command.battle_field_init.code, nil, nil, nil, nil, responseBattleFieldInitCallback,1)
				NetworkManager:register(protocol_command.battle_field_init.code, nil, nil, nil, nil, responseBattleFieldInitCallback, false, nil)
			end
			return
		elseif execute_type == execute_type_dialog then
			-- stopAllEffects()
			if dms.atoi(mission, mission_param9) > 0 then
				-- cc.SimpleAudioEngine:getInstance():stopAllEffects()
				-- playEffect(formatMusicFile("effect", dms.atoi(mission, mission_param9)))
				if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
					playEffectOld(formatMusicFile("effect", dms.atoi(mission, mission_param9)))
				else
					playEffectExt(formatMusicFile("effect", dms.atoi(mission, mission_param9)))
				end
				_mission_play_effect = true
			end
			-- executeDialog()
			app.load("client.mission.missionex.RoleDialogue")

			local closeIt = fwin:find("BlankScreenClass")
			if closeIt ~= nil then fwin:close(closeIt) end
			
			local historyDialog = fwin:find("RoleDialogueClass")
			if historyDialog ~= nil then
				state_machine.excute("role_dialogue_push", 0, {_mission = mission, _missions = missions, _eventIndex = eventIndex})
			else
				local hWnd = RoleDialogue:new()
				hWnd:init(mission, missions, eventIndex)
				fwin:open(hWnd, fwin._windows)
			end	
			return
		elseif execute_type == execute_type_hsRole then
			-- LuaClasses["BattleSceneClass"].showRole(dms.atos(mission, mission_param1), dms.atos(mission, mission_param2))
			-- return
			-- --bRet = true

			local result = fwin:find("FightClass"):showRole(dms.atos(mission, mission_param1), dms.atos(mission, mission_param2))
			if result == false then
				return
			end
			bRet = true
		elseif execute_type == execute_type_blankScreen then
			executeBlankScreen()
			-- bRet = true
			return
		elseif execute_type == execute_type_playMusic then
			if dms.atoi(mission, mission_param1) > 0 then
				playEffect(formatMusicFile("effect", dms.atoi(mission, mission_param1)))
			end
			bRet = true
		elseif execute_type == execute_type_open_func then
			executeOpenFunc()
		elseif execute_type == execute_type_move_team then
			LuaClasses["BattleSceneClass"].missionAttack(execute_type)
			return
		elseif execute_type == execute_type_request_battle then
			LuaClasses["BattleSceneClass"].missionAttack(execute_type)
			bRet = true
		elseif execute_type == execute_type_start_battle then
			-- saveExecuteEvent(mission, false)
			-- LuaClasses["BattleSceneClass"].missionAttack(execute_type)
			-- return
			bRet = true
		elseif execute_type == execute_type_resume_battle then
			saveExecuteEvent(mission, false)
			--LuaClasses["BattleSceneClass"].missionAttack(execute_type)
			if __lua_project_id == __lua_project_adventure then
				state_machine.excute("fight_attack_logic_round_running_adventure", 0, 0)
			else
				state_machine.excute("fight_attack_logic_round_running", 0, 0)
			end
			return
		elseif execute_type == execute_type_over_battle then
			saveExecuteEvent(mission, false)
			--LuaClasses["BattleSceneClass"].missionAttack(execute_type)
			state_machine.excute("fight_exit", 0, 0)
			return
		elseif execute_type == execute_type_get_resource then
			-- local function responseGetResourceCallback(_cObj, _tJsd)
				-- hideConnecting()
				-- local pNode = tolua.cast(_cObj, "cc.Node")
				-- local pDataInterpreter = tolua.cast(_tJsd, "CCNetworkDataInterpreter")
				-- if pDataInterpreter ~= nil and pDataInterpreter:isSucceed() == true then
					-- saveExecuteEvent(mission, true)
				-- else
					-- if Sender(protocol_command.get_resource.code, nil, nil, nil, nil, responseGetResourceCallback,1) ~= nil then
						-- showConnecting()
					-- end
				-- end
			-- end
			local function responseGetResourceCallback(response)
				if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
					if response.node == "1" then
						TipDlg.drawTextDailog(mission_tip_string[5])
					end
					missionLock = false
					saveExecuteEvent(mission, true)
				end
			end
			protocol_command.get_resource.param_list = ""..dms.atos(mission, mission_param1)
			local tipController = ""..dms.atos(mission, mission_param2)
			-- if Sender(protocol_command.get_resource.code, nil, nil, nil, nil, responseGetResourceCallback,1) ~= nil then
				-- showConnecting()
			-- end
			NetworkManager:register(protocol_command.get_resource.code, nil, nil, nil, tipController, responseGetResourceCallback, false, nil)
			return
		elseif execute_type == execute_type_openzhuce then
			-- local closeIt = fwin:find("BlankScreenClass")
			-- if closeIt ~= nil then fwin:close(closeIt) end
			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				-- resetMission()
				fwin:removeAll()
				-- cacher.destorySystemCacher(nil)
				cacher.removeAllTextures()
				state_machine.excute("login_character_create", 0, "login_character_create.")
			else
				fwin:removeAll()
				state_machine.excute("login_character_create", 0, "login_character_create.")
			end
			return
			
			-- MissionClass._pBlankScreen:setVisible(false)
			-- LuaClasses["CharacterCreateClass"]:Draw() 
			-- return
		elseif execute_type == execute_type_start_play then
			local ids = zstring.split(dms.atos(mission, mission_param10), ",")
			
			local currShip = fundShipWidthId(_ED.user_formetion_status[1])
			
			local user_camp = 1
			if currShip ~= nil then
				user_camp = dms.int(dms["ship_mould"], currShip.ship_template_id, ship_mould.capacity)
			end
			
			-- local gender = zstring.tonumber(_ED.user_info.user_gender)
			-- gender = gender <= 0 and 1 or gender
			
			local str = _all_star_head_leader[tonumber(ids[user_camp])]
			-- str = zstring.exchangeFrom(str)
			_ED._current_scene_id =  dms.atos(mission, mission_param1)
			-- local envId = zstring.split(dms.atos(mission, mission_param2), ",")
			_ED._scene_npc_id = dms.atos(mission, mission_param3)
			_ED._npc_difficulty_index = dms.atos(mission, mission_param4)
			-- _ED._battle_init_type = "0"
			
			_ED.npc_state[zstring.tonumber("".._ED._scene_npc_id)]=0

			if __lua_project_id == __lua_project_adventure then
				_ED.npc_last_state[zstring.tonumber("".._ED._scene_npc_id)]=0
				local str1 = _all_star_head_leader[8]
				local str2 = _all_star_head_leader[2]
				missions = nil
				parser2(str2,39)
				parser2(str1,400)
				parser2(str,182)
				local scheduler = cc.Director:getInstance():getScheduler()  
				local schedulerID = nil  
				local  timer = 0

				schedulerID = scheduler:scheduleScriptFunc(function ()
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedulerID)

           			cacher.removeAllTextures()
					fwin:removeAll()
					app.load("client.adventure.battle.AdventureBattle")
                	cc.Director:getInstance():purgeCachedData()

            		fwin:open(AdventureBattle:new():init(), fwin._background)	
    			end,1.0,false) 
			else
				parser2(str,182)
				if _ED.battleData ~= nil then
					-- saveExecuteEvent(mission, false)
					-- LuaClasses["BattleSceneClass"].Draw()
					app.load("client.battle.BattleStartEffect")
					local bse = BattleStartEffect:new()
					bse:init(1)
					fwin:open(bse, fwin._windows)
			    end 
			end
			return
		elseif execute_type == execute_type_getdata_play then
			local ids = zstring.split(dms.atos(mission, mission_param10), ",")
			
			local currShip = fundShipWidthId(_ED.user_formetion_status[1])
			
			local user_camp = 1
			if currShip ~= nil then 
				user_camp = dms.int(dms["ship_mould"], currShip.ship_template_id, ship_mould.capacity)
			end
			
			-- local gender = zstring.tonumber(_ED.user_info.user_gender)
			-- gender = gender <= 0 and 1 or gender
			
			local strData = _all_star_head_leader[tonumber(ids[user_camp])]
			-- strData = zstring.exchangeFrom(strData)
			parser2(strData,39)
			MissionClass._isFirstGame = true

			bRet = true
			saveExecuteEvent(mission, bRet)
			state_machine.excute("fight_start_fight", 0, 0)
			return
		elseif execute_type == execute_type_play_CG then
			app.load("client.mission.missionex.CGScene")
			local closeIt = fwin:find("CGSceneClass")
			if closeIt ~= nil then fwin:close(closeIt) end
			local hWnd = CGScene:new()
			hWnd:init(mission)
			fwin:open(hWnd, fwin._screen)
			
			
			return
		elseif execute_type == execute_type_treasure_drop then
			local icon_index = dms.atos(mission, mission_param1) 	--道具图片索引
			local prop_name = dms.atos(mission, mission_param2)		--道具名字
			local prop_number = dms.atos(mission, mission_param3)	--道具数量
			local prop_count = dms.atos(mission, mission_param4)	--道具简介
			app.load("client.mission.missionex.BattleAcquireProp")
			local fightWindow = BattleAcquireProp:new()
			fightWindow:init(
			{
				BigIconIndex = icon_index,
				PropName = prop_name,
				PropNumber = prop_number,
				PropCount = prop_count
			})
			fwin:open(fightWindow, fwin._windows)
		elseif execute_type == execute_type_wait_cd then
			local _cdTime = dms.atof(mission, mission_param1)/1000 	--等待的cd时长
			app.load("client.mission.missionex.WaitCD")
			fwin:open(WaitCD:new():init(mission, _cdTime), fwin._system)
			return
		elseif execute_type == execute_type_role_restart then
			bRet = true
		elseif execute_type == execute_type_role_restart_over then
			return
		elseif execute_type == execute_type_prologue then
			
			--print(a+1)
			missionLock = true
			local openType = zstring.tonumber(dms.atos(mission, mission_param1))
			local sceneIndex = zstring.tonumber(dms.atos(mission, mission_param2))
			local sceneID = zstring.tonumber(dms.atos(mission, mission_param3))

			executePrologueScreen(openType, sceneIndex, sceneID)
			
			return
		elseif execute_type == execute_type_stop_fight then
			TuitionController._locked = true
			local _cdTime = dms.atof(mission, mission_param1)/1000
			local state = dms.atof(mission, mission_param2)
			state_machine.excute("fight_role_controller_mission_fight", 0, {_cdTime, state, mission})
			return
		elseif execute_type == execute_type_script then
			bRet = true
			local cmission = mission
			missionLock = true
			executeScript(mission)
			if missionRound == 1 then -- 不结束事件
				return
			else
				local missionEndParam = dms.atos(mission, mission_end_param)
				if nil ~= missionEndParam and #missionEndParam > 2 then
					return
				end
			end
			if cmission ~= mission then
				cmission = nil
				return
			end
		elseif execute_type == execute_type_camp_choose then
			-- local closeIt = fwin:find("BlankScreenClass")
			-- if closeIt ~= nil then fwin:close(closeIt) end
			local skipnext1 = fwin:find("CGSkipClass")
			if skipnext1 ~= nil then 
				fwin:close(skipnext1)
			end
			app.load("client.red_alert.login.CampChose")
	        state_machine.excute("camp_chose_window_open",0,"")
			return
		elseif execute_type == execute_type_start_plot_battle then
			bRet = true
			-- missionLock = true
			-- _ED.npc_last_state[npc_id] = "".._ED.npc_state[npc_id]
			local skipnext1 = fwin:find("CGSkipClass")
			if skipnext1 ~= nil then 
				fwin:close(skipnext1)
			end
            _ED._current_scene_id = dms.atos(mission, mission_param1)
            _ED._scene_npc_id = dms.atos(mission, mission_param3)
            _ED._npc_difficulty_index = "1"
            _ED._attacker_npc_id = dms.atos(mission, mission_param2)
            app.load("client.red_alert.battle.battle_enum")
			app.load("client.red_alert.battle.battle_loading")
			_ED._battle_init_type = battle_enum._fight_type._fight_type_20
            state_machine.excute("battle_loading_window_open",0,battle_enum._fight_type._fight_type_20)
        elseif execute_type == execute_type_play_plot_dialog then
        	bRet = false
        	app.load("client.mission.missionex.BattleStoryOne")
			-- missionLock = true
			state_machine.excute("battle_story_one_window_open", 0, dms.atos(mission, mission_param1))
			return
		elseif execute_type == execute_type_battle_pause then
			bRet = false
			-- missionLock = true

			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local attackCount = dms.atoi(mission, mission_param3)

            -- state_machine.excute("battle_scene_pause", 0, 0)
            _ED._battle_pause = true
            state_machine.excute("battle_scene_push_mission", 0, {execute_type, attackerCamp, attackerFormationIndex, attackCount})

            if __lua_project_id == __lua_project_l_digital 
            	or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
            	then
            	if attackerCamp == 2 then
            		bRet = true
            	else
            		return
            	end
            else
            	return
        	end
		elseif execute_type == execute_type_battle_resume then
			bRet = true
			-- missionLock = true

			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local attackCount = dms.atoi(mission, mission_param3)
			
            state_machine.excute("battle_scene_resume", 0, 0)
            state_machine.excute("battle_ui_change_show_state", 0, true)

            _ED._battle_pause = false
            -- state_machine.excute("fight_role_controller_battle_lock_attack_for_mission", 0, false)
            state_machine.excute("fight_role_controller_check_battle_speed_for_mission", 0, 0)
            state_machine.excute("fight_role_controller_check_battle_speed", 0, 0)
        elseif execute_type == execute_type_add_role_power then
        	-- 35增加角色怒气		出手方 0我方 1敌方	1-9阵容位置	第x次出手	怒气增加方 0我方 1敌方	0主公 1-9阵容位置	加的值	
        	bRet = false
			-- missionLock = true
			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local attackCount = dms.atoi(mission, mission_param3)
			
			local adderCamp = dms.atoi(mission, mission_param4)
			local adderFormationIndex = dms.atoi(mission, mission_param5)
			local addValue = dms.atoi(mission, mission_param6)
			-- print("-----:::::", "35增加角色怒气")

			state_machine.excute("battle_scene_push_mission", 0, {execute_type, attackerCamp, attackerFormationIndex, attackCount, adderCamp, adderFormationIndex, addValue})

			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				bRet = true
				_ED._fightModule:addPowerValueFightObject(attackerCamp, attackerFormationIndex, attackCount)
				_ED._fightModule:addPowerValueFightObject(adderCamp, adderFormationIndex, addValue)

				local states = _ED._fightModule:checkSelfAttackStatus()
				for i,v in pairs(states) do
                    state_machine.excute("fight_qte_controller_init_role_qte_state", 0, {slot = i, state = v})
                end
			else
				return
			end
		elseif execute_type == execute_type_battle_result then
			bRet = true
			missionLock = false
			state_machine.excute("battle_win_window_open", 0, "")
		elseif execute_type == execute_type_role_death then
			bRet = false
			-- missionLock = true

			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local attackCount = dms.atoi(mission, mission_param3)

            -- state_machine.excute("battle_scene_pause", 0, 0)
            state_machine.excute("battle_scene_push_mission", 0, {execute_type, attackerCamp, attackerFormationIndex, attackCount})
            return
        elseif execute_type == execute_type_role_change then
        	bRet = false
			-- missionLock = true
			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local spriteId = dms.atoi(mission, mission_param3)

            -- state_machine.excute("battle_scene_pause", 0, 0)
            state_machine.excute("battle_scene_push_mission", 0, {execute_type, attackerCamp, attackerFormationIndex, spriteId})
        	return
        elseif execute_type == execute_type_role_remove then
        	bRet = false
			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local attackCount = dms.atoi(mission, mission_param3)
			
            state_machine.excute("battle_scene_push_mission", 0, {execute_type, attackerCamp, attackerFormationIndex, spriteId})
        	return
        elseif execute_type == execute_type_role_add then
        	bRet = false
			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local attackCount = dms.atoi(mission, mission_param3)

            state_machine.excute("battle_scene_push_mission", 0, {execute_type, attackerCamp, attackerFormationIndex, spriteId})
        	return
		elseif execute_type == execute_type_scale_window then
			local windowName = dms.atos(mission, mission_param1)
			local t = dms.atof(mission, mission_param2)
			local scaleTo = dms.atof(mission, mission_param3)
			local window = fwin:find(windowName)
			if nil ~= window then
				local size = window:getContentSize()
				local movePosition = cc.p(fwin._width / 2 - app.baseOffsetX / 2, fwin._height / 2 - app.baseOffsetX / 2)
				window:setAnchorPoint(cc.p(movePosition.x / size.width, movePosition.y / size.height))
				window:setPosition(movePosition)
				window._mission = mission
				window:runAction(cc.Sequence:create({cc.ScaleTo:create(t, scaleTo), cc.CallFunc:create(function(sender) 
					saveExecuteEvent(sender._mission, true)
				end)}))
				return
			else
				bRet = true
			end
		elseif execute_type == execute_type_wait_battle_change_scene then
			bRet = false
			_ED._battle_wait_change_scene = true

			local skip = dms.atoi(mission, mission_param1)
			if skip == 1 then
				bRet = true
			elseif skip == 2 then
				_ED._battle_wait_change_scene = false
			else
				return
			end
		elseif execute_type == execute_type_battle_change_scene then
			bRet = false
			-- _ED._battle_wait_change_scene = false
			-- state_machine.excute("fight_start_fight", 0, 0)
			state_machine.excute("fight_role_controller_change_battle", 0, 0)
			-- _ED._battle_wait_change_scene = false

			local skip = dms.atoi(mission, mission_param1)
			if skip == 1 then
				bRet = true
			elseif skip == 2 then
				_ED._battle_wait_change_scene = false
				bRet = true
			else
				return
			end
		elseif execute_type == execute_type_battle_role_skill_attack then 	--	= "44角色释放技能"					-- 44
			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local lockType = dms.atoi(mission, mission_param3)
			_ED._fightModule:setFightObjectSkillAttack(attackerCamp, attackerFormationIndex, lockType)
			bRet = true
		elseif execute_type == execute_type_battle_role_super_skill then 	--	= "45角色释放绝技"					-- 45
			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			_ED._fightModule:setPowerSkillState(attackerCamp, attackerFormationIndex, true)

			bRet = true
		elseif execute_type == execute_type_change_formation then 			--	= "46角色上阵"					-- 46
			bRet = false
			local shipMouldId = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)

			local _ship = fundShipWidthTemplateId(shipMouldId)

			local function responseChoiceHeroBattleCallback(response)
				if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
					state_machine.excute("home_hero_main_tip_show",0,{ ship = _ship })
					state_machine.excute("home_hero_refresh_draw", 0, "")
					state_machine.excute("hero_develop_page_update_for_icon",0,_ship)
					state_machine.excute("formation_sort_and_get_index",0,"")
					state_machine.excute("hero_icon_listview_update_all_icon",0,_ship)
					saveExecuteEvent(mission, true)
				end
			end

			local str = ""
            str = str.._ship.ship_id .. "\r\n" --战船ID
            str = str..attackerFormationIndex   --阵型ID
            protocol_command.formation_change.param_list = str
            NetworkManager:register(protocol_command.formation_change.code, nil, nil, nil, nil, responseChoiceHeroBattleCallback, false, nil)
			return
		elseif execute_type == execute_type_stop_fight_change_scene_action then
			_mission_stop_fight_change_scene_action = dms.atoi(mission, mission_param1)
			bRet = true
		elseif execute_type == execute_type_change_battle_role then -- 48变更战斗角色
			local attackerCamp = dms.atoi(mission, mission_param1)
			local attackerFormationIndex = dms.atoi(mission, mission_param2)
			local environmentShipId = dms.atoi(mission, mission_param3)

			state_machine.excute("fight_role_controller_change_battle_role", 0, {attackerCamp, attackerFormationIndex, environmentShipId})

			bRet = true
		elseif execute_type == execute_type_change_battle_role_attack_state then -- 49角色行动状态
			local attackState = dms.atoi(mission, mission_param1) -- 0暂停 1恢复
			_ED._battle_role_attack_state = attackState
			bRet = true
		elseif execute_type == execute_type_change_battle_role_process_attack_state then -- 50变改角色出手状态
			local attackerFormationIndexs = dms.atos(mission, mission_param1)
			local attackerAttackState = dms.atoi(mission, mission_param2) == 1
			local defenderFormationIndexs = dms.atos(mission, mission_param3)
			local defenderAttackState = dms.atoi(mission, mission_param4) == 1

			local data = zstring.split(attackerFormationIndexs, ",")
			for i, v in pairs(data) do
				_ED._fightModule:setActionStatus(0, v, attackerAttackState)
			end

			data = zstring.split(defenderFormationIndexs, ",")
			for i, v in pairs(data) do
				_ED._fightModule:setActionStatus(1, v, defenderAttackState)
			end

			bRet = true
		end
		saveExecuteEvent(mission, bRet)
		
	else
		missionId = missionId or -1
		complated = "1"
		eventRepeat = eventRepeat or "0"
		saveEData = ""..missionId..","..eventIndex..","..eventRepeat..","..complated..","..offval

		if saveKeyBase ~= nil then
			--CCUserDefault:sharedUserDefault():setStringForKey(saveKeyBase, saveBaseEData)
		end
		
		-- SenderRecode(true)
		SenderRecodeExt()
		
		--CCUserDefault:sharedUserDefault():setStringForKey(saveKey, saveEData)
		--CCUserDefault:sharedUserDefault():flush()
		
		eventIndex = 0
		-- missions:release()
		missions = nil
		mission = nil
		
		clearMissionUIData()
		
		currentEventBattleRoundCound = 0
		mission_mould = -1
		
		if mission_executeOverCallback ~= nil then
			mission_executeOverCallback()
			mission_executeOverCallback = nil
		end
		--if isRunning() == true then
		--	LuaClasses["BattleSceneClass"].missionAttack()
		--end
		
		--if isRunning() == true then
		--	LuaClasses["BattleSceneClass"].missionAttack()
		--end
		-- cacher.destorySystemCacher(nil)
		cc.Director:getInstance():getTextureCache():removeUnusedTextures()
	end
end


checkCurrentMissionEnd = function(endParam)
	local tempMission = mission
	if tempMission ~= nil then
		local missionEndParam = tempdms.atos(mission, mission_end_param)
		if missionEndParam == endParam then
			missionLock = false
			clearMissionUIData()
			unregisterTuitionTouchEventListener(MissionClass._touchUICallback)
			if tempMission ~= nil then
				tempMission._isOver = true
			end
			executeEvent()
		end
	end
end

local function mission_unregisterTuitionTouchEventListener()
	unregisterTuitionTouchEventListener(MissionClass._touchUICallback)
	MissionClass._widgetName = nil
end

local function mission_registerTuitionTouchEventListener(widgetName, touchUICallback)
	registerTuitionTouchEventListener(widgetName, touchUICallback)
	MissionClass._widgetName = widgetName
	MissionClass._touchUICallback = touchUICallback
end

local function mission_moveTouchEventListener(moveCalssHome, moveLayerName,touchX, touchY,WidgetName1)--封装移动的方法
	--如果移动的calss和移动的层还有
	if moveCalssHome == nil or moveCalssHome == "" or moveCalssHome == "0" 
		or moveLayerName == nil or moveLayerName == ""or moveLayerName == "0" 
		or touchX == nil or touchY == nil  then
		return
	end
	local widget = LuaClasses[moveCalssHome]._uiLayer:getWidgetByName(moveLayerName)--那个calss的得到UI对象
	local mWidgetName = LuaClasses[moveCalssHome]._uiLayer:getWidgetByName(WidgetName1)--那个calss的得到UI对象
	
	local percents = 0
	if mWidgetName:getPositionX() > draw.size().width/2 then
		percents = (mWidgetName:getPositionX()+draw.size().width/2-mWidgetName:getContentSize().width)/widget:getInnerContainerSize().width*100--计算按钮在滑动层的X的百分比
		if percents <= 0 then
			percents = 100
		end
	else
		percents = 1
	end
	widget:scrollToPercentHorizontal(percents,0,false)--让滑动层定位在见的区域（参数1=百分比，参数2=时间，参数3=false）
end

executeTouchUI = function()
	missionLock = true
	if true then
		-- missionLock = true
		local tuitionWindow = fwin:find("TuitionControllerClass")
		if tuitionWindow == nil then
			fwin:open(TuitionController:new():init(mission), fwin._dialog)
		else
			tuitionWindow:executeMission(mission)
		end
		state_machine.excute("events_teaching_skip_swap", 0, 0)
		return
	end

	-- cc.Director:getInstance():touchListener(false)
	missionLock = true
	
	local missionId = dms.atoi(mission, mission_id)
	local missionEventId = dms.atoi(mission, mission_event_id)
	local windowName = dms.atos(mission, mission_param1)
	local widgetName = dms.atos(mission, mission_param2)
	local cellIndex = dms.atoi(mission, mission_param3)
	local controlName = dms.atos(mission, mission_param4)
	local areanXYWH = zstring.split(dms.atos(mission, mission_param5), ",")
	local dialogXYCamp = zstring.split(dms.atos(mission, mission_param6), "|")
	local dialogXY = nil
	if #dialogXYCamp > 1 and zstring.tonumber(_ED.user_info.user_force) ~= 0 then
		dialogXY = dialogXYCamp[zstring.tonumber(_ED.user_info.user_force)]
	else
		dialogXY = dialogXYCamp[1]
	end
	dialogXY = zstring.split(dialogXY, ",")
	local message = dms.atos(mission, mission_param7)
	local dlgWH = zstring.split(dms.atos(mission, mission_param8), ",")
	local textWH = zstring.split(dms.atos(mission, mission_param9), ",")
	local textXY = zstring.split(dms.atos(mission, mission_param10), ",")
	local touchUI = dms.atoi(mission, mission_param11)
	MissionClass._touchUICallback = function()
		if mission ~= nil then
			local missionEndParam = dms.atos(mission, mission_end_param)
			if missionEndParam ~= "" and missionEndParam ~= "0" then
				return
			end
		end
		missionLock = false
		clearMissionUIData()
		unregisterTuitionTouchEventListener(MissionClass._touchUICallback)
		if mission ~= nil then
			mission._isOver = true
		end
		executeEvent()
	end
	if missionId == 7 and missionEventId == 3 then
		LuaClasses["FormationClass"].resetPageIndex()
	end
	
	mission_unregisterTuitionTouchEventListener()
	
	if MissionClass._uiLayer == nil then
		MissionClass._uiLayer = TouchGroup:create()
		draw.graphics(MissionClass._uiLayer, 100)
	end
	
	if __lua_project_id == __lua_king_of_adventure then
		if mission ~= nil then
			local moveClassName = dms.atos(mission, mission_param12)
			local moveLayerName = dms.atos(mission, mission_param13)
			local touchXY = zstring.split(dms.atos(mission, mission_param14), ",")
			local widgetName = dms.atos(mission, mission_param2)
			mission_moveTouchEventListener(moveClassName, moveLayerName, touchXY[1], touchXY[2],widgetName)
		end
	end
	if windowName ~= nil and windowName ~= "0" and #windowName > 0 then
		mission_registerTuitionTouchEventListener(widgetName, MissionClass._touchUICallback)
		local uiObject = nil 
		local _uox = nil
		local _uoy = nil
		local selfUiLayer = tolua.cast(LuaClasses[windowName]._uiLayer, "cc.Node")
		
		if __lua_project_id == __lua_project_all_star or 
			__lua_project_id == __lua_king_of_adventure then
			if windowName == "EquipmentInformationClass" then
				if selfUiLayer == nil then
					windowName = "EmboitementInformationClass"
					selfUiLayer = tolua.cast(LuaClasses[windowName]._uiLayer, "cc.Node")
				end
			end
		end
		
		if selfUiLayer~= nil and LuaClasses[windowName]._uiLayer ~= nil and LuaClasses[windowName]._uiLayer:getParent() ~= nil then
			uiObject= LuaClasses[windowName]._uiLayer:getWidgetByName(widgetName)
			if windowName == "PlotSceneClass" and string.match(widgetName, "%D+") == "Panel_pve_target" then
				local i = string.match(widgetName, "%d")
				local npcPlace = string.format("Panel_coordinate_%s", i)
				local placeInfo = LuaClasses[windowName]._uiLayer:getWidgetByName(npcPlace)
				local scrollinfo = tolua.cast(LuaClasses[windowName]._uiLayer:getWidgetByName("ScrollView_13314"),"ScrollView")
				if placeInfo:getPositionY() > draw.size().height/2 then
					percents = 100-(placeInfo:getPositionY()+draw.size().height/2-placeInfo:getContentSize().height)/scrollinfo:getInnerContainerSize().height*100
					
					-- 如果移动超过了最上方，就定位在最上方
					if percents < 0 then
						percents = 1
					end
				else
					-- 如果移动超过了最下方，就定位在最下方
					percents = 100
				end
			
				-- scrollinfo:scrollToPercentVertical(percents,0,false)
			end
		end
		
		if cellIndex <= 0 then
			local scheduler = cc.Director:getInstance():getScheduler()
			local pauseEntry = nil
			local missionSuspendTime = 0
			local function update(delta)

				missionSuspendTime = missionSuspendTime + delta
				
				if missionSuspendTime >= 3600 then
					unregisterTuitionTouchEventListener(MissionClass._touchUICallback)
					if MissionClass._pTuitionDlg ~= nil then
						MissionClass._pTuitionDlg:removeFromParent(true)
						MissionClass._pTuitionDlg = nil
					end
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(pauseEntry)
					pauseEntry = nil
					if missions~= nil then
						eventIndex = #missions
						executeEvent()
					end
					return
				end
				uiObject = nil
				if uiObject == nil then
					local selfUiLayer = tolua.cast(LuaClasses[windowName]._uiLayer, "cc.Node")
					if selfUiLayer~=nil and LuaClasses[windowName]._uiLayer ~= nil and LuaClasses[windowName]._uiLayer:getParent() ~= nil then
						uiObject= LuaClasses[windowName]._uiLayer:getWidgetByName(widgetName)
						if windowName == "PlotSceneClass"  and string.match(widgetName, "%D+") == "Panel_pve_target" then
							local i = string.match(widgetName, "%d")
							local npcPlace = string.format("Panel_coordinate_%s", i)
							local placeInfo = LuaClasses[windowName]._uiLayer:getWidgetByName(npcPlace)
							local scrollinfo = tolua.cast(LuaClasses[windowName]._uiLayer:getWidgetByName("ScrollView_13314"),"ScrollView")
							if placeInfo:getPositionY() > draw.size().height/2 then
								percents = 100-(placeInfo:getPositionY()+draw.size().height/2-placeInfo:getContentSize().height)/scrollinfo:getInnerContainerSize().height*100
								
								-- 如果移动超过了最上方，就定位在最上方
								if percents < 0 then
									percents = 1
								end
							else
								-- 如果移动超过了最下方，就定位在最下方
								percents = 100
							end
						
							-- scrollinfo:scrollToPercentVertical(percents,0,false)
						end
					end
				end
					
				-- local item = uiObject
				if uiObject ~= nil then
				--[[
					if uiObject._xx == nil then
						uiObject._xx, xyy = uiObject:getPosition()
					else
						local xx, yy = uiObject:getPosition()
						if xx == uiObject._xx then
							
						else
							uiObject._xx = xx
						end
					end
				--]]
					
					if _uox == nil then
						_uox, _uoy = uiObject:getPosition()
					else
						local xx, yy = uiObject:getPosition()
						if xx == _uox then
							mission_unregisterTuitionTouchEventListener()
							mission_registerTuitionTouchEventListener(widgetName, MissionClass._touchUICallback)
							uiObject._touchUI = touchUI
							MissionClass:drawTuition(uiObject, areanXYWH)
							if message ~= "0" then
								if MissionClass._pTuitionDlg == nil then
									MissionClass:drawTuitionDlg(dialogXY, message, dlgWH, textWH, textXY)
								else
									draw.label(MissionClass._pTuitionDlg, "Label_7994_1", message)
								end
							else
								if MissionClass._pTuitionDlg ~= nil then
									MissionClass._pTuitionDlg:removeFromParent(true)
									MissionClass._pTuitionDlg = nil
								end
							end
							cc.Director:getInstance():getScheduler():unscheduleScriptEntry(pauseEntry)
							pauseEntry = nil
						else
							_uox = xx
						end
					end
					
				end
			end
			
			pauseEntry = scheduler:scheduleScriptFunc(update, 0.3, false)
			
			-- registerTuitionTouchEventListener(widgetName, touchUICallback)
			-- MissionClass:drawTuition(uiObject)
		else
			local scheduler = cc.Director:getInstance():getScheduler()
			local pauseEntry = nil
			local missionSuspendTime = 0
			local function update(delta)
				missionSuspendTime = missionSuspendTime + delta

				if missionSuspendTime >= 3600 then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(pauseEntry)
					pauseEntry = nil
					mission_unregisterTuitionTouchEventListener()
					if MissionClass._pTuitionDlg ~= nil then
						MissionClass._pTuitionDlg:removeFromParent(true)
						MissionClass._pTuitionDlg = nil
					end
					if missions~= nil then
						eventIndex = #missions
						executeEvent()
					end
					return
				end

				local touchListView = tolua.cast(uiObject, "ListView")
				if touchListView == nil then
					local _lvParent = nil
					if LuaClasses[windowName]._uiLayer~= nil then
						_lvParent = LuaClasses[windowName]._uiLayer:getParent()
					end
					if LuaClasses[windowName]._uiLayer ~= nil and _lvParent ~= nil 
						and _lvParent:isRunning() == true then
						uiObject= LuaClasses[windowName]._uiLayer:getWidgetByName(widgetName)
					end
					if uiObject ~= nil then
						touchListView = tolua.cast(uiObject, "ListView")
					end
				end
				if touchListView ~= nil then
					local item = touchListView:getItem(cellIndex-1)
					if item ~= nil then
						if item._xx == nil then
							item._xx, xyy = item:getPosition()
						else
							local xx, yy = item:getPosition()
							if xx == item._xx then
								cc.Director:getInstance():getScheduler():unscheduleScriptEntry(pauseEntry)
								pauseEntry = nil
								mission_unregisterTuitionTouchEventListener()
								mission_registerTuitionTouchEventListener(controlName, MissionClass._touchUICallback)
								local touchObject = item:getWidgetByName(controlName)
								touchObject._touchUI = touchUI
								MissionClass:drawTuition(touchObject, areanXYWH)
								if message ~= "0" then
									if MissionClass._pTuitionDlg == nil then
										MissionClass:drawTuitionDlg(dialogXY, message, dlgWH, textWH, textXY)
									else
										draw.label(MissionClass._pTuitionDlg, "Label_7994_1", message)
									end
								else
									if MissionClass._pTuitionDlg ~= nil then
										MissionClass._pTuitionDlg:removeFromParent(true)
										MissionClass._pTuitionDlg = nil
									end
								end
							else
								item._xx = xx
							end
						end
					end
				end
			end
			-- touchListView:scheduleUpdateWithPriorityLua(update, 1)
			pauseEntry = scheduler:scheduleScriptFunc(update, 0.3, false)
			
			-- MissionClass:drawTuition(touchListView:getItem(cellIndex-1))
			-- MissionClass:drawTuition(touchListView:getItem(cellIndex-1))
		end
	end
	if (message ~= "0" and #message > 0 ) then
		--[[
		if MissionClass._pTuitionDlg == nil then
			MissionClass:drawTuitionDlg(dialogXY, message, dlgWH, textWH, textXY)
		else
			draw.label(MissionClass._pTuitionDlg, "Label_7994_1", message)
		end
		--]]
		MissionClass:drawTuitionDlg(dialogXY, message, dlgWH, textWH, textXY)
		if windowName == "0" or windowName == nil or #windowName <= 0 then
			local function TuitionDlgCallback(sender, eventType)
				if eventType == ccs.TouchEventType.ended then
					if MissionClass._pTuitionDlg ~= nil then
						MissionClass._pTuitionDlg:removeFromParent(true)
						MissionClass._pTuitionDlg = nil
					end
					mission._isOver = true
					executeEvent()
				elseif eventType == ccs.TouchEventType.began then
					playEffect(formatMusicFile("button", 1))		--加入按钮音效
				end
				
			end
			MissionClass._pTuitionDlg:getWidgetByName("Panel_8017"):addTouchEventListener(TuitionDlgCallback)
		end
	else
		if MissionClass._pTuitionDlg ~= nil then
			MissionClass._pTuitionDlg:removeFromParent(true)
			MissionClass._pTuitionDlg = nil
		end
	end
end

executeOpenWindows = function()
	local missionId = dms.atoi(mission, mission_id)
	local missionEventId = dms.atoi(mission, mission_event_id)
	local resetWindos = dms.atos(mission, mission_round)
	local windowParams = dms.atos(mission, mission_param1)
		
	local opened = fwin:find(windowParams)
	if resetWindos == "1" and opened == nil then
		fwin:removeAll()
	end
	if windowParams == "MenuClass" then
		local next_terminal_name_string = dms.atos(mission, mission_param2)
		local button_name_string = dms.atos(mission, mission_param3)
		local image_name_string = dms.atos(mission, mission_param4)
		if opened == nil then
			app.load("client.home.Menu")
			fwin:open(Menu:new(), fwin._taskbar)
		end
		state_machine.unlock("menu_manager_change_to_page", 0, "")
		state_machine.excute("menu_manager", 0, 
			{
				_datas = {
					terminal_name = "menu_manager", 	
					next_terminal_name = next_terminal_name_string, 
					current_button_name = button_name_string,
					but_image = image_name_string, 		
					terminal_state = 0, 
					isPressedActionEnabled = true
				}
			}
		)
	end
end

executeScript = function()
	local funcString = dms.atos(mission, mission_param1)
	local func = assert(loadstring(funcString))
	if func ~= nil then
		func()
	end
	missionLock = false
end

executeOpenFunc = function()
	if MissionClass._uiLayer == nil then
		MissionClass._uiLayer = TouchGroup:create()
		draw.graphics(MissionClass._uiLayer, 100)
	end
	local _widget = GUIReader:shareReader():widgetFromJsonFile("interface/feature_is_turned_on.json")
	MissionClass._uiLayer:addWidget(_widget)
	
	local function backHomeButtonCallback(sender, eventType)
		if eventType == ccs.TouchEventType.ended then
			LuaClasses["MainWindowClass"]._buttonIndex = 1
			LuaClasses["MainWindowClass"]:Draw()
			mission._isOver = true
			executeEvent()
		elseif eventType == ccs.TouchEventType.began then
			playEffect(formatMusicFile("button", 1))		--加入按钮音效
		end
	end
	
	local tipTop = zstring.split(dms.atos(mission, mission_param4), "x")
	draw.label(_widget, "Label_53480", ""..tipTop[1].."["..dms.atos(mission, mission_param3).."]"..tipTop[2])
	if __lua_project_id == __lua_king_of_adventure then 
		draw.label(_widget, "Label_53490", ""..dms.atos(mission, mission_param5))
	else
		draw.label(_widget, "Label_53481", ""..dms.atos(mission, mission_param5))
	end
	
	draw.setVisible(_widget, "ImageView_"..dms.atos(mission, mission_param2), true)
	
	local backHomeButton = tolua.cast(MissionClass._uiLayer:getWidgetByName("Button_53482"), "Button")
	backHomeButton:addTouchEventListener(backHomeButtonCallback)
end

executeDialog = function()
	
end

executePrologueScreen = function(openType,sceneIndex,sceneID)
	-- 0 开启 1 完成
	app.load("client.mission.missionex.PrologueScreenInfo")
	local closeIt = fwin:find("PrologueScreenInfoClass")
	if closeIt ~= nil then fwin:close(closeIt) end
	
	local infoGUI = PrologueScreenInfo:new()
	infoGUI:init(sceneID, sceneIndex,openType,mission)
	fwin:open(infoGUI, fwin._screen)
end


executeBlankScreen = function()
	if true then
		app.load("client.mission.missionex.BlankScreen")
		local closeIt = fwin:find("BlankScreenClass")
		if closeIt ~= nil then fwin:close(closeIt) end
		local hWnd = BlankScreen:new()
		hWnd:init(mission)
		fwin:open(hWnd, fwin._screen)
		return
	end

	local scheduler = cc.Director:getInstance():getScheduler()
	local schedulerEntry = nil
	local isShow = dms.atoi(mission, mission_param1)
	local fInterval = mission:atof(mission_param2)
	local contentText = dms.atos(mission, mission_param3)
	local armatureName = dms.atos(mission, mission_param4)
	local loop = dms.atoi(mission, mission_param7)
	if isShow == 0 then
		if MissionClass._pBlankScreen ~= nil then
			MissionClass._pBlankScreen:removeFromParent(true)
			MissionClass._pBlankScreen = nil
		end
	else
		local s = draw.size() --cc.Director:getInstance():getWinSize() --draw.size()
		local layer = CCLayerColor:create(ccc4(0, 0, 0, 255), s.width * 2, s.height * 2)
		layer:setPosition(ccp(- 1 * draw.size().width/2, -1 * draw.size().height/2))
		if __lua_project_id == __lua_king_of_adventure 
		or __lua_project_id == __lua_project_koone then
			layer:setAnchorPoint(CCPoint(0.5,0.5))
		end
		-- layer:setCascadeColorEnabled(true)
		
		MissionClass._pBlankScreen = layer
		
		if fInterval > 0 then		
			local ecount = 0
			local function exitBlankScreen(dt)
				---- cc.Director:getInstance():touchListener(true)
				--if MissionClass._pBlankScreen ~= nil then
				--	MissionClass._pBlankScreen:removeFromParent(true)
				--	MissionClass._pBlankScreen = nil
				--end
				ecount = ecount + 1
				if ecount == 1 then
					return
				end
				if schedulerEntry ~= nil then
					scheduler:unscheduleScriptEntry(schedulerEntry)
					schedulerEntry = nil
				end
				saveExecuteEvent(mission, true)
				ecount = 0
			end
			
			local function onNodeEvent(event)
				if event == "enterTransitionFinish" then
					schedulerEntry = scheduler:scheduleScriptFunc(exitBlankScreen, fInterval, false)
				elseif event == "exit" then
					if schedulerEntry ~= nil then
						scheduler:unscheduleScriptEntry(schedulerEntry)
						schedulerEntry = nil
					end
				end
			end
			-- cc.Director:getInstance():touchListener(false)
			layer:registerScriptHandler(onNodeEvent)
		end
		
		draw.graphics(layer, 100)
		
		--开场事件的光效文件
		if __lua_project_id == __lua_king_of_adventure 
		or __lua_project_id == __lua_project_koone then
			if  armatureName~="" and armatureName ~= "0" then
				local armatureFile = string.format("effect/effice_%d.ExportJson", tonumber(armatureName))
				armatureName = string.format("effice_%d", tonumber(armatureName))
				local effect = createEffect(armatureName, armatureFile, layer, loop)
				effect:setAnchorPoint(CCPoint(0.5,0.5))
				
				local function drawEffectMissionOverFunc(armatureBack)
					if armatureBack == nil then
						return
					end
					
					if armatureBack._LastsCountTurns > 0 then
						-- 删除光效
						armatureBack._LastsCountTurns = armatureBack._LastsCountTurns == nil and 0 or armatureBack._LastsCountTurns - 1
						if armatureBack._LastsCountTurns <= 0 then
							local fileName = armatureBack._fileName
							tolua.cast(armatureBack, "cc.Node"):removeFromParent(true)
							-- 删除光效文件
							CCArmatureDataManager:sharedArmatureDataManager():removeArmatureFileInfo(fileName)
							-- saveExecuteEvent(mission, true)
						end
					end
				end
				if loop>0 then
					effect._invoke = drawEffectMissionOverFunc
					return
				end
			end
		end
		-- -----------------------
		local contentLabel = nil
		if contentText ~= "0" and contentText ~= "" then
			contentText = zstring.replace(contentText, "\\r\\n", "\r\n")
			local fontSize = 12
			local contentLabel = Label:create()
			--contentLabel:setText(contentText)
			draw.text(contentLabel,contentText)
			contentLabel:setFontName("fonts/FZZYJW.TTF")-->设置字体名字
			contentLabel:setFontSize(fontSize)-->设置字体大小
			
			--local contentLabel =CCLabelTTF:create(contentText, "fonts/FZZYJW.TTF", fontSize, CCSizeMake(0, 0), kCCTextAlignmentLeft)
			
			contentLabel:setAnchorPoint(CCPoint(0.5, 0.5))-->设置锚点
			local csize = contentLabel:getContentSize()
			contentLabel:setPosition(ccp(s.width, s.height))
			layer:addChild(contentLabel)
		end
			
		if fInterval > 0 then
			if contentLabel ~= nil then
				local array = CCArray:createWithCapacity(3)
				array:addObject(CCActionInterval:create(fInterval/2))
				array:addObject(CCFadeOut:create(fInterval/2))
				local seq = CCSequence:create(array)
				contentLabel:runAction(seq)
			end
		else
			saveExecuteEvent(mission, true)
		end
	end
end


function executeNextEvent(callFunc, ext)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		if nil ~= mission_effect then
			mission_effect:removeFromParent(true)
			mission_effect = nil
			-- cacher.destorySystemCacher(nil)
			cacher.removeAllTextures()
		end
	end
	if ext == true then
		executeEvent()
	elseif mission ~= nil then
		saveExecuteEvent(mission, true)
	end
	--executeEvent()
	--[[
	if missions == nil then
		callFunc()
		return false
	end
	mission_executeOverCallback = callFunc
	--]]
	if missions == nil then
		-- callFunc()
		return false
	end
	return true
end

function executeResetCurrentEvent(unexit)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		if nil ~= mission_effect then
			mission_effect:removeFromParent(true)
			mission_effect = nil
			-- cacher.destorySystemCacher(nil)
			cacher.removeAllTextures()
		end
	end
	missionLock = false
	eventIndex = eventIndex + 1
	if unexit == true then
	else
		state_machine.excute("tuition_controller_exit", 0, "")
	end
	fwin:close(fwin:find("WindowLockClass"))
	executeEvent()
end

function executeNextRoundBattleEvent(roundCount)
	if missions == nil then
		--> print("executeNextRoundBattleEvent:missions-nil")
		return false
	end
	local eventCount = #missions
	mission = eventIndex < eventCount and missions[eventIndex + 1] or nil
	--> print("executeNextRoundBattleEvent:mission--", mission, roundCount)
	if mission ~= nil then
		eventRepeat = dms.atos(mission, mission_repeat)
		local missionRound = dms.atoi(mission, mission_round)
		if missionRound == roundCount then
			currentEventBattleRoundCound = roundCount
			executeEvent()
			return true
		end
	end
	return false
end

function checkEventType(_type, offset)
	local eventCount = missions == nil and 0 or #missions
	if eventCount > 0 then
		offset = offset or 0
		local _tmission = eventIndex < eventCount and missions[eventIndex + offset] or nil
		local execute_type = dms.atos(_tmission, mission_execute_type)
		if "20剧情战斗初始化事件" == execute_type then
			_tmission = eventIndex < eventCount and missions[eventIndex + offset + 1] or nil
			execute_type = dms.atos(_tmission, mission_execute_type) 
			if execute_type == _type then
				eventIndex = eventIndex + 1
			end
		end	
		if execute_type == _type then
			return true
		end
	end
	return false
end


function checkMissionIsOver()
	if missionIsOver() == true then
		executeNextEvent(nil, true)
	end
end

function resetMission(force)
	if force == false then
		if missionIsOver() == false and eventIndex > 0 and fwin:find("TuitionControllerClass") ~= nil then
			return
		end
	end
	if __lua_project_id == __lua_project_red_alert 
		-- or __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim
		then
		if mission_effect ~= nil then
			local tmission = mission_effect._mission
			mission_effect._mission = nil
			-- mission_effect:removeFromParent(true)
			mission_effect = nil
			if tmission ~= nil and dms.atoi(tmission, mission_param6) ~= 1 then
				saveExecuteEvent(tmission, true)
			end
		end
	end
	clearMissionUIData()
	
	currentEventBattleRoundCound = 0
	mission_mould = -1
	mission_executeOverCallback = nil
	
	missions = nil 
	mission = nil 
	saveKey = nil
	missionId = 0
	eventIndex = 0
	eventRepeat = "0"
	complated = "0"
	offval = ""
	tuitionMissionId = 0
	
	saveEData = nil
	saveKeyBase = nil
	saveBaseEData = nil
	exBaseEData = true

	waitExecuteMission = false
    missionLock = false
	
	current_execute_type = ""
	
	if missions ~= nil then
		-- missions:release()
		missions = nil
		mission = nil
	end
	-- unregisterTuitionTouchEventListener(nil)
	-- cc.Director:getInstance():touchListener(true)
end

function clearMission()
	-- if missionIsOver() == false and eventIndex > 0 then
		clearMissionUIData()
		
		currentEventBattleRoundCound = 0
		mission_mould = -1
		mission_executeOverCallback = nil
		
		missions = nil 
		mission = nil 
		saveKey = nil
		missionId = 0
		eventIndex = 0
		eventRepeat = "0"
		complated = "0"
		offval = ""
		tuitionMissionId = 0
		
		saveEData = nil
		saveKeyBase = nil
		saveBaseEData = nil
		exBaseEData = true

		waitExecuteMission = false
	    missionLock = false
		
		current_execute_type = ""
	-- end
end
		
--教学用的
local mission_open_game_world_map_terminal = {
	_name = "mission_open_game_world_map",
	_init = function (terminal) 
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params) 
		app.load("configs.csb.config")
		app.load("client.red_alert.campaign.nationalwar.NationalTruce")
		app.load("client.red_alert.campaign.nationalwar.NationalTruceLoading")
		app.load("client.utils.DrawHelper")
		state_machine.excute("national_truce_loading_window_open",0,{_datas={open_type = 1}})
		return true
	end,
	_terminal = nil,
	_terminals = nil
}
state_machine.add(mission_open_game_world_map_terminal)
state_machine.init()