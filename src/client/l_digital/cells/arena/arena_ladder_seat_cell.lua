-- ----------------------------------------------------------------------------------------------------
-- 说明：竞技场对手控件
-- 创建时间：20170721
-- 作者：李文鋆
-------------------------------------------------------------------------------------------------------

ArenaLadderSeatCell = class("ArenaLadderSeatCellClass", Window)
ArenaLadderSeatCell.__size = nil
function ArenaLadderSeatCell:ctor()
    self.super:ctor()
    self.roots = {}

    self._armature = nil

    -- Initialize ArenaLadderSeatCell page state machine.
    local function init_arena_ladder_seat_terminal()

		local arena_ladder_seat_cell_fight_sm_terminal = {
            _name = "arena_ladder_seat_cell_fight_sm",
            _init = function (terminal) 
                app.load("client.battle.BattleStartEffect")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if tonumber(_ED.arena_user_remain) <= 0 then
            		TipDlg.drawTextDailog(_new_interface_text[178])
            		return
            	end
            	local cells = params._datas.cell
            	instance:requestArenaFightDatas(cells.roleInstance)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local arena_ladder_seat_cell_worship_terminal = {
            _name = "arena_ladder_seat_cell_worship",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	local cells = params._datas.cell
            	local function responseArenaWorshipCallback(response)
					if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						if response.node == nil or response.node.roots == nil or response.node.roots[1] == nil then
							return
						end
						for i, v in pairs(_ED.arena_challenge) do
							if tonumber(v.rank) == tonumber(response.node.roleInstance.rank) then
								response.node.roleInstance = v
							end
						end
						response.node:initDraw()
						local rewardList = getSceneReward(14)
						local number = 0
						for i=1, tonumber(rewardList.show_reward_item_count) do
							if tonumber(rewardList.show_reward_list[i].prop_type) == 1 then
								number = tonumber(rewardList.show_reward_list[i].item_value)
								break
							end
						end
						TipDlg.drawTextDailog(string.format(_new_interface_text[41],zstring.tonumber(number)))
					end
				end
				
				protocol_command.arena_worship.param_list = "0".."\r\n".."0".."\r\n"..cells.roleInstance.rank
				NetworkManager:register(protocol_command.arena_worship.code, nil, nil, nil, cells, responseArenaWorshipCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local arena_ladder_seat_cell_show_info_terminal = {
            _name = "arena_ladder_seat_cell_show_info",
            _init = function (terminal) 
                app.load("client.l_digital.campaign.arena.ArenaPlayerInfoWindow")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	local cells = params._datas.cell
            	state_machine.excute("sm_arena_player_info_window_open",0,cells.roleInstance)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        
		local arena_ladder_seat_cell_fight_sm_five_terminal = {
            _name = "arena_ladder_seat_cell_fight_sm_five",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if funOpenDrawTip(172) == true then
		            return
		        end
            	local cells = params._datas.cell
            	local haveTimes = tonumber(_ED.arena_user_remain)
			    local totalCost = 0
			    local buyTimes = zstring.tonumber(_ED.arena_user_change_times_buy_times)
			    local buyTimesCost = zstring.split(dms.string(dms["arena_config"], 3, pirates_config.param), ",")
			    local cleanCDGold = dms.int(dms["arena_config"], 5, pirates_config.param)
			    local cdTime = _ED.user_launch_battle_cd / 1000 - (_ED.system_time + (os.time() - _ED.native_time))
			    for i=1,5 do
			        if cdTime > 0 then
			            totalCost = totalCost + cleanCDGold
			            cdTime = 0
			        end
			        if haveTimes <= 0 then
			            if buyTimes >= #buyTimesCost then
			                buyTimes = #buyTimesCost
			            else
			                buyTimes = buyTimes + 1
			            end
			            totalCost = totalCost + zstring.tonumber(buyTimesCost[buyTimes])
			        else
			            haveTimes = haveTimes - 1
			            if haveTimes > 0 then
			        		cdTime = 100
			        	end
			        end
			    end
            	local currentGold = zstring.tonumber(_ED.user_info.user_gold)
                if totalCost > currentGold then
                    state_machine.excute("shortcut_open_function_dailog_cancel_and_ok", 0, 
                    {
                        terminal_name = "shortcut_open_recharge_window", 
                        terminal_state = 0, 
                        _msg = _string_piece_info[273], 
                        _datas= 
                        {

                        }
                    })
            		return
            	end
            	local roleInfo = cells.roleInstance
            	local function respondCallback( response )
            		if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
            			state_machine.excute("arena_update_times_info", 0, nil)
            			state_machine.excute("arena_five_time_result_window_open", 0, {roleInfo})
            		end
            	end
            	protocol_command.arena_sweep.param_list = roleInfo.rank .. "\r\n5"
				NetworkManager:register(protocol_command.arena_sweep.code, nil, nil, nil, cells, respondCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

		state_machine.add(arena_ladder_seat_cell_fight_sm_terminal)
		state_machine.add(arena_ladder_seat_cell_worship_terminal)
		state_machine.add(arena_ladder_seat_cell_show_info_terminal)
		state_machine.add(arena_ladder_seat_cell_fight_sm_five_terminal)
        state_machine.init()
    end
    
    -- call func init hom state machine.
    init_arena_ladder_seat_terminal()
end

function ArenaLadderSeatCell:updateFiveTimesInfo( ... )
	local root = self.roots[1]
	local role = self.roleInstance
	local min_rank = dms.int(dms["arena_config"], 17, arena_config.param)
	local lessRank = dms.int(dms["arena_config"], 19, pirates_config.param)
	local Panel_z5 = ccui.Helper:seekWidgetByName(root, "Panel_z5")
	local Button_tiaozhan = ccui.Helper:seekWidgetByName(root, "Button_tiaozhan")
	local Button_mobai = ccui.Helper:seekWidgetByName(root, "Button_mobai")
	Button_tiaozhan:setVisible(false)
	-- Button_tiaozhan:setTouchEnabled(true)
	-- Button_tiaozhan:setBright(true)
	Button_mobai:setVisible(false)
	Button_mobai:setTouchEnabled(true)
	Button_mobai:setBright(true)
	Panel_z5:setVisible(false)
	if tonumber(_ED.user_info.user_id) == tonumber(role.id) then
	else
		if self.index <= 10 then
			if tonumber(_ED.user_arena_worship_state[role.arena_id]) == tonumber(role.arena_id) then
				if tonumber(_ED.arena_user_rank) < tonumber(self.roleInstance.rank) then
					Panel_z5:setVisible(true)
				elseif tonumber(_ED.arena_user_rank) > tonumber(self.roleInstance.rank)
					and tonumber(_ED.arena_user_rank) <= min_rank
					then
					Button_tiaozhan:setVisible(true)
				else
					Button_mobai:setVisible(true)
					Button_mobai:setTouchEnabled(false)
					Button_mobai:setBright(false)
				end
			else
				if _ED.user_worship_number >= 10 then
					--我没有膜拜次数了
					if tonumber(_ED.arena_user_rank) <= min_rank then
						--如果是我可以打的
						Button_tiaozhan:setVisible(true)
					else
						Button_mobai:setVisible(true)
						Button_mobai:setTouchEnabled(false)
						Button_mobai:setBright(false)
					end
				else
					Button_mobai:setVisible(true)
				end
			end
		else
			if tonumber(_ED.arena_user_rank) <= lessRank and tonumber(_ED.arena_user_rank) < tonumber(self.roleInstance.rank) then
				Panel_z5:setVisible(true)
			else
				Button_tiaozhan:setVisible(true)
			end
		end
	end

	local Text_z5_0 = ccui.Helper:seekWidgetByName(root, "Text_z5_0")
	local haveTimes = tonumber(_ED.arena_user_remain)
    local totalCost = 0
    local buyTimes = zstring.tonumber(_ED.arena_user_change_times_buy_times)
    local buyTimesCost = zstring.split(dms.string(dms["arena_config"], 3, pirates_config.param), ",")
    local cleanCDGold = dms.int(dms["arena_config"], 5, pirates_config.param)
    local cdTime = _ED.user_launch_battle_cd / 1000 - (_ED.system_time + (os.time() - _ED.native_time))
    for i=1,5 do
        if cdTime > 0 then
            totalCost = totalCost + cleanCDGold
            cdTime = 0
        end
        if haveTimes <= 0 then
            if buyTimes >= #buyTimesCost then
                buyTimes = #buyTimesCost
            else
                buyTimes = buyTimes + 1
            end
            totalCost = totalCost + zstring.tonumber(buyTimesCost[buyTimes])
        else
            haveTimes = haveTimes - 1
            if haveTimes > 0 then
        		cdTime = 100
        	end
        end
    end
    Text_z5_0:setString(totalCost)
end

function ArenaLadderSeatCell:requestArenaFightDatas(opponentSeat)
	local rank = opponentSeat.rank
	-- local posIndex = opponentSeat.posIndex
	
	---[[
	--DOTO 战斗请求
	local function requestArenaFightDatasCallback(response)
		if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
			--> print("数据回来了 啦啦啦啦。。。战斗结果是：", _ED.attackData.isWin)
			if response.node == nil or response.node.roots == nil then
				return
			end
			if _ED.user_info.last_user_grade ~= _ED.user_info.user_grade then
				_ED.user_is_level_up = true
				_ED.arena_is_level_up = true
				_ED.last_grade = _ED.user_info.last_user_grade
				_ED.last_food = _ED.user_info.last_user_food
				_ED.last_endurance = _ED.user_info.last_endurance			
			end
			-- 胜利了,记录当前.
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

	protocol_command.arena_launch.param_list = rank .. "\r\n0"
	NetworkManager:register(protocol_command.arena_launch.code, nil, nil, nil, self, requestArenaFightDatasCallback, false, nil)
end

function ArenaLadderSeatCell:addHeroAnimaton()
	local root = self.roots[1]
	self.roleIconPanel:removeAllChildren(true)
	if __lua_project_id == __lua_project_l_digital then
		self.roleIconPanel:removeBackGroundImage()
		local playerIconStr = nil
		if tonumber(self.roleInstance.icon) >= 9 then
			playerIconStr = string.format("images/ui/props/props_%s.png", self.roleInstance.icon)
		else
			playerIconStr = string.format("images/ui/home/head_%s.png", self.roleInstance.icon)
		end
		self.roleIconPanel:setBackGroundImage(playerIconStr)
	else
		--模板id:等级:进阶数据:星级:品阶:战力!后面的战船
		local role = self.roleInstance
		--所有的船
		local shipAllData = zstring.split(role.template[1], "!")
		local SelectedId = 0		--战力最大的船的位置
		local fightId = -9999
		for i, v in pairs(shipAllData) do
			local shipData = zstring.split(v, ":")
			if tonumber(shipData[6]) > fightId then
				SelectedId = i
				fightId = tonumber(shipData[6])
			end
		end
		--模板id:等级:进阶数据:星级:品阶:战力:皮肤ID
		local selectedShip = zstring.split(shipAllData[SelectedId], ":")

		--进化形象
		local evo_image = dms.string(dms["ship_mould"], tonumber(selectedShip[1]), ship_mould.fitSkillTwo)
		local evo_info = zstring.split(evo_image, ",")
		--进化模板id
		local ship_evo = zstring.split(selectedShip[3], "|")
		local evo_mould_id = evo_info[tonumber(ship_evo[1])]

		if zstring.tonumber(selectedShip[7]) ~= 0 then
	    	evo_mould_id = dms.int(dms["ship_skin_mould"], selectedShip[7], ship_skin_mould.ship_evo_id)
	    end
		--新的形象编号
		local temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)

		self.roleIconPanel:removeAllChildren(true)
		-- draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), self.roleIconPanel, nil, nil, cc.p(0.5, 0))

		--画光圈
		local camp_preference = dms.int(dms["ship_mould"], tonumber(selectedShip[1]), ship_mould.camp_preference)
		local animation_name = ""
		if camp_preference == 1 then    		--攻击
			animation_name = "type_1"
		elseif camp_preference == 2 then 		--防御
			animation_name = "type_2"
		elseif camp_preference == 3 then 		--技能
			animation_name = "type_3"
		end
		local jsonFile = "sprite/spirte_type_di.json"
	    local atlasFile = "sprite/spirte_type_di.atlas"
	    local animation2 = sp.spine(jsonFile, atlasFile, 1, 0, animation_name, true, nil)
	    animation2:setPosition(cc.p(self.roleIconPanel:getContentSize().width/2,0))
	 		self.roleIconPanel:addChild(animation2)
	    

		self:runAction(cc.Sequence:create({cc.DelayTime:create((math.abs(self.index-#_ED.arena_challenge))*0.05), cc.CallFunc:create(function ( sender )
			app.load("client.battle.fight.FightEnum")
			if self._armature == nil then
				self._armature = sp.spine_sprite(self.roleIconPanel, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self._armature:setScaleX(-1)
				end
			end
		end)}))
	end
	
end

function ArenaLadderSeatCell:initDraw()

	local root = self.roots[1]
	local role = self.roleInstance

	--画角色的
	self.roleIconPanel = ccui.Helper:seekWidgetByName(root, "Panel_role")
	self.roleIconPanel:removeBackGroundImage()
	
	--排名
	local Text_2 = ccui.Helper:seekWidgetByName(root, "Text_2") 
	local Text_rank_n = ccui.Helper:seekWidgetByName(root, "Text_rank_n") 
	Text_2:setString(role.rank)
	Text_rank_n:setString(role.rank)
	--玩家名称
	local Text_role_name = ccui.Helper:seekWidgetByName(root, "Text_role_name")
	Text_role_name:setString(role.name)
	--被膜拜次数
	local Text_mbcs = ccui.Helper:seekWidgetByName(root, "Text_mbcs")
	Text_mbcs:setString(role.worship_value)
	--玩家战力
	local Text_5 = ccui.Helper:seekWidgetByName(root, "Text_5")
	Text_5:setString(role.force)
	--挑战按钮
	local Button_tiaozhan = ccui.Helper:seekWidgetByName(root, "Button_tiaozhan")

	--膜拜按钮
	local Button_mobai = ccui.Helper:seekWidgetByName(root, "Button_mobai")
	local Image_bmb = ccui.Helper:seekWidgetByName(root, "Image_bmb")
	local Text_mbcs = ccui.Helper:seekWidgetByName(root, "Text_mbcs")
	local Image_rank = ccui.Helper:seekWidgetByName(root, "Image_rank")
	local Text_rank_n = ccui.Helper:seekWidgetByName(root, "Text_rank_n")

	Button_tiaozhan:setVisible(false)
	Button_tiaozhan:setTouchEnabled(true)
	Button_tiaozhan:setBright(true)
	Button_mobai:setVisible(false)
	Image_bmb:setVisible(false)
	Text_mbcs:setVisible(false)
	Image_rank:setVisible(false)
	Text_rank_n:setVisible(false)	

	local min_rank = dms.int(dms["arena_config"], 17, arena_config.param) 		-- 可挑战前10名的最小名次
	if tonumber(_ED.user_info.user_id) == tonumber(role.id) then
	else
		if self.index <= 10 then
			if tonumber(_ED.user_arena_worship_state[role.arena_id]) == tonumber(role.arena_id) then
				Button_tiaozhan:setVisible(true)
			else
				if _ED.user_worship_number >= 10 then
					Button_tiaozhan:setVisible(true)
				else
					Button_mobai:setVisible(true)
				end
			end
			if tonumber(_ED.arena_user_rank) > min_rank then
				Button_tiaozhan:setTouchEnabled(false)
				Button_tiaozhan:setBright(false)
			end
		else
			Button_tiaozhan:setVisible(true)
		end
	end

	if self.index <= 10 then
		Image_bmb:setVisible(true)
		Text_mbcs:setVisible(true)
	else
		Image_rank:setVisible(true)
		Text_rank_n:setVisible(true)
	end

	local Panel_dh = ccui.Helper:seekWidgetByName(root, "Panel_dh")
	local rank = tonumber(role.rank)
	if rank == 1 then
		Panel_dh:setBackGroundImage("images/ui/play/arena/arena_list.png")
	elseif rank <= 3 then
		Panel_dh:setBackGroundImage("images/ui/play/arena/arena_list_"..(rank - 1)..".png")
	elseif rank <= 10 and rank > 3 then
		Panel_dh:setBackGroundImage("images/ui/play/arena/arena_list_3.png")
	else
		Panel_dh:setBackGroundImage("images/ui/play/arena/arena_list_4.png")
	end

	self:updateFiveTimesInfo()
	if __lua_project_id == __lua_project_l_digital then
		self:addHeroAnimaton()
	end
end

function ArenaLadderSeatCell:onEnterTransitionFinish()
	
end

function ArenaLadderSeatCell:onInitDraw( isInit )
	if self.roleInstance == -1 then 
		return
	end
	
    local root = cacher.createUIRef("campaign/ArenaStorage/ArenaStorage_list_role.csb", "root")
	table.insert(self.roots, root)
    self:addChild(root)
	
	-- local action = csb.createTimeline(csbPath)
 --    root:runAction(action)
 --    self.action = action
	
	-- local panel = ccui.Helper:seekWidgetByName(root, "Panel_2")
	-- panel:setPosition(cc.p(0, -100))
	root:setTouchEnabled(false)
	root:setSwallowTouches(false)
	self:setContentSize(root:getContentSize())
	

	local Button_tiaozhan = ccui.Helper:seekWidgetByName(root, "Button_tiaozhan")
	if Button_tiaozhan ~= nil then 
		fwin:addTouchEventListener(Button_tiaozhan, 	nil, {
			terminal_name = "arena_ladder_seat_cell_fight_sm", 	
			terminal_state = 0, 
			cell = self
		}, 
		nil, 0)
	end
	--膜拜
	local Button_mobai = ccui.Helper:seekWidgetByName(root, "Button_mobai")
	if Button_mobai ~= nil then 
		fwin:addTouchEventListener(Button_mobai, nil, {
			terminal_name = "arena_ladder_seat_cell_worship", 	
			terminal_state = 0, 
			cell = self
		}, 
		nil, 0)
	end

	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_role"), nil, {
		terminal_name = "arena_ladder_seat_cell_show_info", 	
		terminal_state = 0, 
		cell = self
	}, 
	nil, 0)

	local Button_tiaozhan_0 = ccui.Helper:seekWidgetByName(root, "Button_tiaozhan_0")
	if Button_tiaozhan_0 ~= nil then 
		fwin:addTouchEventListener(Button_tiaozhan_0, 	nil, {
			terminal_name = "arena_ladder_seat_cell_fight_sm", 	
			terminal_state = 0, 
			cell = self
		}, 
		nil, 0)
	end
	local Button_z5 = ccui.Helper:seekWidgetByName(root, "Button_z5")
	if Button_z5 ~= nil then 
		fwin:addTouchEventListener(Button_z5, 	nil, {
			terminal_name = "arena_ladder_seat_cell_fight_sm_five", 	
			terminal_state = 0, 
			cell = self
		}, 
		nil, 0)
	end

	self:initDraw()

	if isInit == true then
		-- self:addHeroAnimaton()
	end
end

function ArenaLadderSeatCell:reload()
    local root = self.roots[1]
    if __lua_project_id == __lua_project_l_digital then
    	if root ~= nil then
	        return
	    end
    	self:onInitDraw()
    else
    	if self._armature == nil then
	    	self:addHeroAnimaton()
	    end

	    if root ~= nil then
	        return
	    end
	    self:onInitDraw()
	end
    
end

function ArenaLadderSeatCell:unload()
    local root = self.roots[1]
    if root == nil then
        return
    end
    self:clearUIInfo()
    cacher.freeRef("campaign/ArenaStorage/ArenaStorage_list_role.csb", root)
    root:stopAllActions()
    root:removeFromParent(false)
    self.roots = {}
end

function ArenaLadderSeatCell:init(role, index)
	if role == -1 then
		self:setVisible(false)
	end
	self.index = index
	self.roleInstance = role
	self.roleShipId = dms.string(dms["ship_mould"], role.template[1], ship_mould.bust_index)
	-- if __lua_project_id == __lua_project_l_digital then
	-- 	if self.index and self.index <= 5 then
	-- 		self:onInitDraw(true)
	-- 	end
	-- else
	-- 	self:onInitDraw(true)
	-- end
	self:onInitDraw(true)
end

function ArenaLadderSeatCell:createCell()
	local cell = ArenaLadderSeatCell:new()
	cell:registerOnNodeEvent(cell)
	return cell
end

function ArenaLadderSeatCell:clearUIInfo( ... )
	local root = self.roots[1]
	local Panel_role = ccui.Helper:seekWidgetByName(root, "Panel_role")
	local Panel_dh = ccui.Helper:seekWidgetByName(root, "Panel_dh")
	if Panel_role ~= nil then
		Panel_role:removeAllChildren(true)
		Panel_role:removeBackGroundImage()
	end
	if Panel_dh ~= nil then
		Panel_dh:removeBackGroundImage()
	end
	self._armature = nil
end

function ArenaLadderSeatCell:onExit()
	self:clearUIInfo()
	cacher.freeRef("campaign/ArenaStorage/ArenaStorage_list_role.csb", self.roots[1])
end
