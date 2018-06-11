-- ----------------------------------------------------------------------------------------------------
-- 说明：竞技场战报list
-------------------------------------------------------------------------------------------------------

ArenaWarReportSeatCell = class("ArenaWarReportSeatCellClass", Window)
ArenaWarReportSeatCell.__size = nil
function ArenaWarReportSeatCell:ctor()
    self.super:ctor()
    self.roots = {}
	
	app.load("client.cells.campaign.icon.arena_role_icon_cell")
	
	self.roleInstance = nil
	
    -- Initialize ArenaWarReportSeatCell page state machine.
    local function init_arena_ladder_seat_terminal()
	
		local arena_ladder_seat_playback_terminal = {
            _name = "arena_ladder_seat_playback",
            _init = function (terminal) 
                app.load("client.battle.BattleStartEffect")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	local cells = params._datas.cell
            	local function responseCallback(response)
					if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
							_ED.battle_playback_arena.playback = true
							_ED.battle_playback_arena.nType = cells._info.nType
							_ED.battle_playback_arena.time = cells._info.time
							
							if _ED.user_info.last_user_grade ~= _ED.user_info.user_grade then
								_ED.user_is_level_up = true
								_ED.arena_is_level_up = true
								_ED.last_grade = _ED.user_info.last_user_grade
								_ED.last_food = _ED.user_info.last_user_food
								_ED.last_endurance = _ED.user_info.last_endurance			
							end
							-- 胜利了,记录当前.requestArenaFightDatas
							if tonumber(_ED.attackData.isWin) == 1 then
								
								-- 并且排名高过自己
								-- if tonumber(rank) < tonumber(self.heroQueue[self.userIndex].roleInstance.rank) then
								-- 	response.node:writeCacheData(posIndex)
								-- end

							end
							fwin:close(self.userInformationHeroStorage)
							fwin:cleanView(fwin._windows)
							fwin:freeAllMemeryPool()
							local bse = BattleStartEffect:new()
							bse:init(_enum_fight_type._fight_type_11)
							fwin:open(bse, fwin._windows)
						end	
					end
				end
            	protocol_command.battlefield_report_battle_info_get.param_list = cells._info.nType.."\r\n"..cells._info.time
				NetworkManager:register(protocol_command.battlefield_report_battle_info_get.code, nil, nil, nil, cells, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        
        state_machine.add(arena_ladder_seat_playback_terminal)
        state_machine.init()
    end
    
    -- call func init hom state machine.
    init_arena_ladder_seat_terminal()
end

function ArenaWarReportSeatCell:initDraw()
	local root = self.roots[1]
	local attachedInfo = zstring.split(self._info.param, ",")
	local isResult = false
	if zstring.tonumber(attachedInfo[6]) == tonumber(_ED.user_info.user_id) then
		if tonumber(self._info.result) == 1 then
			--失败
			isResult = false
		else
			--成功
			isResult = true
		end
	else
		if tonumber(self._info.result) == 1 then
			--成功
			isResult = true
		else
			--失败
			isResult = false
		end
	end
	
	--胜利
	local Image_win = ccui.Helper:seekWidgetByName(root, "Image_win")
	--失败
	local Image_lose = ccui.Helper:seekWidgetByName(root, "Image_lose")
	if isResult == false then
		Image_win:setVisible(false)
		Image_lose:setVisible(true)
	else
		Image_win:setVisible(true)
		Image_lose:setVisible(false)
	end
	--头像
	local Panel_player_icon = ccui.Helper:seekWidgetByName(root, "Panel_player_icon")
	Panel_player_icon:removeAllChildren(true)
	local icon = ArenaRoleIconCell:createCell()
	icon:init(tonumber(self._info.userHeadPic), 1)
	Panel_player_icon:addChild(icon)
	--名称
	local Text_name_lv = ccui.Helper:seekWidgetByName(root, "Text_name_lv")
	Text_name_lv:setString(self._info.userName.." Lv"..self._info.userLevel)
	--战力
	local Text_fighting_n = ccui.Helper:seekWidgetByName(root, "Text_fighting_n")
	Text_fighting_n:setString(self._info.userFighting)
	--速度
	local Text_speed_n = ccui.Helper:seekWidgetByName(root, "Text_speed_n")
	Text_speed_n:setString(self._info.userSpeed)
	--时间
	local Text_time = ccui.Helper:seekWidgetByName(root, "Text_time")
	Text_time:setString(self:getDifferDay((_ED.system_time + (os.time() - _ED.native_time))-tonumber(self._info.time)/1000))

	--排名上升
	local Image_up = ccui.Helper:seekWidgetByName(root, "Image_up")
	--排名下降
	local Image_down = ccui.Helper:seekWidgetByName(root, "Image_down")
	--上升或者下架的排名
	local Text_rank_n = ccui.Helper:seekWidgetByName(root, "Text_rank_n")
	if zstring.tonumber(attachedInfo[6]) == tonumber(_ED.user_info.user_id) then
		if zstring.tonumber(attachedInfo[4]) - zstring.tonumber(attachedInfo[5]) > 0 then
			Image_up:setVisible(true)
			Image_down:setVisible(false)
			Text_rank_n:setVisible(true)
		elseif zstring.tonumber(attachedInfo[4]) - zstring.tonumber(attachedInfo[5]) == 0 then	
			Image_up:setVisible(false)
			Image_down:setVisible(false)
			Text_rank_n:setVisible(false)
		else
			Image_down:setVisible(true)
			Image_up:setVisible(false)	
			Text_rank_n:setVisible(true)
		end
		Text_rank_n:setString(math.abs(zstring.tonumber(attachedInfo[4]) - zstring.tonumber(attachedInfo[5])))
	else
		if math.abs(zstring.tonumber(attachedInfo[4]) - zstring.tonumber(attachedInfo[5])) > 0 then
			Image_up:setVisible(true)
			Image_down:setVisible(false)
			Text_rank_n:setVisible(true)
		elseif math.abs(zstring.tonumber(attachedInfo[4]) - zstring.tonumber(attachedInfo[5])) == 0 then	
			Image_up:setVisible(false)
			Image_down:setVisible(false)
			Text_rank_n:setVisible(false)
		else
			Image_down:setVisible(true)
			Image_up:setVisible(false)	
			Text_rank_n:setVisible(true)
		end
		Text_rank_n:setString(math.abs(zstring.tonumber(attachedInfo[4]) - zstring.tonumber(attachedInfo[5])))
	end
	--回放按钮
	local Button_replay = ccui.Helper:seekWidgetByName(root, "Button_replay")
	Button_replay:setVisible(true)
	
end

function ArenaWarReportSeatCell:getDifferDay(times)
	local str = ""
	local hour = math.floor(tonumber(times)/3600)
	local mins = math.floor((tonumber(times)%3600)/60)
	local day = ""
	if times == 0 then
		str = _string_piece_info[290]
	elseif hour < 1 then
		str = mins .. _string_piece_info[289]
	elseif hour >= 1 and hour < 24 then
		str = hour .._string_piece_info[288]
	elseif hour >= 24 then
		day = math.ceil(hour / 24)
		str = day .._string_piece_info[291]
	end
	return str
end

function ArenaWarReportSeatCell:onEnterTransitionFinish()
	
end

function ArenaWarReportSeatCell:onInit()
	local root = cacher.createUIRef("campaign/ArenaStorage/ArenaStorage_report_list.csb", "root")
 	table.insert(self.roots, root)
 	self:addChild(root)

 	if ArenaWarReportSeatCell.__size == nil then
	 	local Panel_2 = ccui.Helper:seekWidgetByName(root, "Panel_2")
		local MySize = Panel_2:getContentSize()

	 	ArenaWarReportSeatCell.__size = MySize
	end
	
	-- 回放
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_replay"), 	nil, 
	{
		terminal_name = "arena_ladder_seat_playback", 	
		terminal_state = 0, 
		isPressedActionEnabled = false,
		cell = self,
	}, 
	nil, 0)
	
	self:initDraw()
end


function ArenaWarReportSeatCell:reload()
	local root = self.roots[1]
	if root ~= nil then
		return
	end
	self:onInit()
end

function ArenaWarReportSeatCell:unload()
	local root = self.roots[1]
	if root == nil then
		return
	end
	self:clearUIInfo()
	cacher.freeRef("campaign/ArenaStorage/ArenaStorage_report_list.csb", root)
	root:stopAllActions()
	root:removeFromParent(false)
	self.roots = {}
end

function ArenaWarReportSeatCell:init(role, index)
	self._info = role
	if index ~= nil and index < 9 then
		self:onInit()
	end
	self:setContentSize(ArenaWarReportSeatCell.__size)
	return self
end

function ArenaWarReportSeatCell:createCell()
	local cell = ArenaWarReportSeatCell:new()
	cell:registerOnNodeEvent(cell)
	return cell
end

function ArenaWarReportSeatCell:clearUIInfo( ... )
	local root = self.roots[1]
	local Panel_player_icon = ccui.Helper:seekWidgetByName(root, "Panel_player_icon")
	if Panel_player_icon ~= nil then
		Panel_player_icon:removeAllChildren(true)
	end
end

function ArenaWarReportSeatCell:onExit()
	self:clearUIInfo()
	cacher.freeRef("campaign/ArenaStorage/ArenaStorage_report_list.csb", self.roots[1])
end
