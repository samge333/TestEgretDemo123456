----------------------------------------------------------------------------------------------------
-- 说明：武将界面滑动层
-- 创建时间
-- 作者：肖雄
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------
HeroListView = class("HeroListViewClass", Window)
   
function HeroListView:ctor()
    self.super:ctor()
	self.roots = {}
	
	self.tSortedHeroes = {}

	self.UnlockedShip = {}

	self.beSynthesized = {}
	
	---------------------------------------------------------------------------
	-- 用于下拉效果
	---------------------------------------------------------------------------
	self.isRunning = false
	
	self.expansionaryIndex = nil
	
	self.runningExpansionCell = nil
	self.runningExpansionCellHeight = 0
	---------------------------------------------------------------------------

	self.currentListView = nil
	self.currentInnerContainer = nil
	self.currentInnerContainerPosY = 0

	self.currentScrollView = nil
	self.currentScrollViewInnerContainer = nil
	self.currentScrollViewInnerContainerPosY  = 0

    local function init_hero_list_view_terminal()
		-- 武将数量显示
		local hero_show_hero_counts_terminal = {
            _name = "hero_show_hero_counts",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
				if __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
					then
				else
					local usedheroStorageNumber = 0
					local openheroStorageNumber = "0"
					for i, hero in pairs(_ED.user_ship) do
						if hero.ship_id ~= nil then
							local shipData = dms.element(dms["ship_mould"], hero.ship_template_id)
							if dms.atoi(shipData, ship_mould.captain_type) ~= 3 then
								usedheroStorageNumber = usedheroStorageNumber + 1
							end
						end
					end
					openheroStorageNumber = _ED.hero_use
					ccui.Helper:seekWidgetByName(instance.roots[1], "Label_5075"):setString(usedheroStorageNumber.."/"..openheroStorageNumber)
				end
				return true
			end,
            _terminal = nil,
            _terminals = nil
        }
		
		-- 武将排序
		local hero_sort_terminal = {
			_name = "hero_sort",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
				instance.tSortedHeroes = instance:getSortedHeroes()
				instance.UnlockedShip,instance.beSynthesized = instance:getUnlockedShip()
				return true
			end,
            _terminal = nil,
            _terminals = nil
		}
	
		local hero_list_view_show_hero_list_view_sell_terminal = {
            _name = "hero_list_view_show_hero_list_view_sell",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				fwin:open(HeroSell:new(), fwin._ui)
				-- fwin:close(fwin:find("HeroStorageClass"))
				-- fwin:close(fwin:find("UserInformationHeroStorageClass"))
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local hero_list_view_insert_cell_terminal = {
            _name = "hero_list_view_insert_cell",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				-- params == _shipId
				if __lua_project_id == __lua_project_gragon_tiger_gate
					or __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					or __lua_project_id == __lua_project_red_alert 
					or __lua_project_id == __lua_project_legendary_game 
					then
					instance.tSortedHeroes = instance:getSortedHeroes()
					instance:insertCell(nil, 0)
				else
					local listIndex = instance:getListIndexByShipId(instance:getSortedHeroes(), params)
					if listIndex ~= nil then
						local cell = nil
						if __lua_project_id == __lua_project_l_digital 
							or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
							then
							cell = SmHeroSeatCell:createCell()
						else
							cell = HeroSeatCell:createCell()
						end
						cell:init(_ED.user_ship[""..params], nil, 0)
						instance:insertCell(cell, listIndex)
					end
				end
				_ED.recruit_success_ship_ids = ""
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local hero_list_view_remove_cell_terminal = {
            _name = "hero_list_view_remove_cell",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if __lua_project_id == __lua_project_gragon_tiger_gate
					or __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					or __lua_project_id == __lua_project_red_alert 
					then
            		instance:removeCellByShipId(params)
            	else
					for i, v in pairs(params) do
						instance:removeCellByShipId(v.ship_id)
					end	
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local hero_list_view_update_cell_terminal = {
            _name = "hero_list_view_update_cell",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				instance:updateCellByShipId(params)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--删除
		local hero_list_view_remove_cell_by_sell_terminal = {
            _name = "hero_list_view_remove_cell_by_sell",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				instance:cleanListView()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--下拉动画
		local ship_expansion_action_start_terminal = {
            _name = "ship_expansion_action_start",
            _init = function (terminal) 
                app.load("client.cells.ship.ship_expansion_cell")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				if instance.isRunning == true or params._datas.cell.heroInstance == nil then
					return
				end
			
				local _ship_id = params._datas.cell.heroInstance.ship_id
			
				local _herolistView = ccui.Helper:seekWidgetByName(instance.roots[1], "ListView_25081")
				local _listIndex = instance:getListIndexByShipId(instance:getSortedHeroes(), _ship_id)
				local _cell = _herolistView:getItem(_listIndex)

				local expansion_pad = ccui.Helper:seekWidgetByName(_cell.roots[1], "Panel_xiala")
				if expansion_pad == nil then 
					return
				end
				
				local offsetY = expansion_pad:getParent():getContentSize().height - 30 / CC_CONTENT_SCALE_FACTOR()

				local isBottom = false
				local function expansionOn()
					local function expansionActionOverCallback()
						instance.isRunning = false
						if isBottom == true then
							_herolistView:getInnerContainer():setPositionY(0)
						end
						isBottom = false
					end

					instance.isRunning = true 
					instance.expansionaryIndex = _listIndex
					instance.runningExpansionCell = _cell
					instance.runningExpansionCell:retain()
					instance.runningExpansionCellHeight = instance.runningExpansionCell:getContentSize().height
					
					ccui.Helper:seekWidgetByName(params._datas.cell.roots[1], "Button_kuozhan"):setVisible(false)
					ccui.Helper:seekWidgetByName(params._datas.cell.roots[1], "Button_kuozhan_0"):setVisible(true)
					
					expansion_pad:removeAllChildren(true)
					local expansionCell = HeroExpansionsCell:createCell()
					expansionCell:init(params._datas.cell.heroInstance,params._datas.cell)
					expansion_pad:addChild(expansionCell)
					_cell.roots[2] = expansionCell.roots[1]

					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						or __lua_project_id == __lua_project_legendary_game 
						then
						local innerList = _herolistView:getInnerContainer()
						local cellPositonY = _cell:getPositionY()
						local innerPostionY = innerList:getPositionY()
						if cellPositonY + innerPostionY <= offsetY and cellPositonY > offsetY then
							innerList:setPositionY(innerPostionY + _cell:getContentSize().height)
						elseif cellPositonY < offsetY then
							isBottom = true
						end
					end

					expansion_pad:getParent():runAction(cc.Sequence:create(
										cc.MoveBy:create(0.5, cc.p(0, offsetY)), 
										cc.DelayTime:create(0.05),
										cc.CallFunc:create(expansionActionOverCallback)
										))
					expansion_pad:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(0, -offsetY))))
				end
				
				local function expansionOff()
					local function expansionActionOverCallback1()
						instance.isRunning = false
						instance.expansionaryIndex = nil
						instance.runningExpansionCell:release()
						instance.runningExpansionCell = nil
						expansion_pad:removeAllChildren(true)
					end
				
					instance.isRunning = true 
					
					ccui.Helper:seekWidgetByName(params._datas.cell.roots[1], "Button_kuozhan"):setVisible(true)
					ccui.Helper:seekWidgetByName(params._datas.cell.roots[1], "Button_kuozhan_0"):setVisible(false)
					
					if params._off == true then
						local expansion_pad_parent = expansion_pad:getParent()
						expansion_pad_parent:setPosition(expansion_pad_parent._pos)
						expansion_pad:setPosition(expansion_pad._pos)
						expansionActionOverCallback1()
						_herolistView:requestRefreshView()
					else
						expansion_pad:getParent():runAction(cc.Sequence:create(
											cc.MoveBy:create(0.5, cc.p(0, -offsetY)), 
											cc.DelayTime:create(0.05),
											cc.CallFunc:create(expansionActionOverCallback1)
											))
						expansion_pad:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(0, offsetY))))
					end
				end
				
				if nil == instance.expansionaryIndex then
					-- 弹出
					expansionOn()
				elseif _listIndex == instance.expansionaryIndex then
					-- 收回
					expansionOff()
				else
					-- 换个弹出
					local old_expansion_pad = ccui.Helper:seekWidgetByName(instance.runningExpansionCell.roots[1], "Panel_xiala")
					old_expansion_pad:removeAllChildren(true)
					
					old_expansion_pad:getParent():setPositionY(old_expansion_pad:getParent():getPositionY() - offsetY)
					old_expansion_pad:setPositionY(old_expansion_pad:getPositionY() + offsetY)
					
					instance.runningExpansionCell:setContentSize(cc.size(instance.runningExpansionCell:getContentSize().width, instance.runningExpansionCellHeight))
					_herolistView:requestRefreshView()
					
					ccui.Helper:seekWidgetByName(instance.runningExpansionCell.roots[1], "Button_kuozhan"):setVisible(true)
					ccui.Helper:seekWidgetByName(instance.runningExpansionCell.roots[1], "Button_kuozhan_0"):setVisible(false)
					-----------------------------------------------------------
					expansionOn()
				end	
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		--刷新
		local hero_list_view_update_cell_by_sell_terminal = {
            _name = "hero_list_view_update_cell_by_sell",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if __lua_project_id == __lua_project_gragon_tiger_gate
					or __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					or __lua_project_id == __lua_project_red_alert 
					or __lua_project_id == __lua_project_legendary_game 
					then
            		instance:cleanListView()
            	else
					-- ccui.Helper:seekWidgetByName(instance.roots[1], "ListView_25081"):requestRefreshView()
					local oldId = 0
					updateListView = {}
					local listView = ccui.Helper:seekWidgetByName(instance.roots[1], "ListView_25081")
					local items = listView:getItems()
					for i, v in ipairs(instance.getSortedHeroes()) do
						for j=1,#instance.tSortedHeroes do
							-- print("v.ship_id=="..v.ship_id)
							-- print("ccui.Helper:seekWidgetByName(instance.roots[1], )=="..ccui.Helper:seekWidgetByName(instance.roots[1], "ListView_25081"):getItem(j-1).heroInstance.ship_id)
							if items[j] ~= nil and items[j].heroInstance ~= nil and v.ship_id == items[j].heroInstance.ship_id then
								if  params ~= nil and params._datas.shipId == v.ship_id then
									oldId = i
								end
								updateListView[i] = items[j]
								break
							end
						end
					end
					
					for i, v in pairs(items) do
						v:retain()
					end
					
					listView:removeAllChildren(false)
					for i, v in ipairs(updateListView) do
						listView:addChild(v)
					end
					for i, v in pairs(items) do
						v:release()
					end
					-- 复位的逻辑
					-- if params ~= nil then
						-- local listViewSize = listView:getContentSize()
						-- local innerLayout = listView:getInnerContainer()
						-- local innerPosition = cc.p(innerLayout:getPosition())
						
						-- local margin = listView:getItemsMargin()
						-- local size = listView:getItem(oldId-1):getContentSize()
						-- local allSizeHeight = 0-size.height*#updateListView
						-- local beginPosition = cc.p(0, allSizeHeight+(oldId-1)*size.height)
						-- local endPosition = cc.p(0, allSizeHeight+(oldId-1) * (size.height + margin) + listViewSize.height - size.height)
						-- if innerPosition.y < beginPosition.y then
							-- listView:jumpToTop()
							-- innerLayout:runAction(cc.MoveTo:create(0, cc.p(innerPosition.x, beginPosition.y)))
						-- elseif innerPosition.y > endPosition.y then
							-- listView:jumpToTop()
							-- innerLayout:runAction(cc.MoveTo:create(0, cc.p(innerPosition.x, endPosition.y)))
						-- end
					-- end
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --刷新装备推送
		local hero_list_view_update_cell_equip_button_push_terminal = {
            _name = "hero_list_view_update_cell_equip_button_push",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	instance:updateCellEquipButtonPush()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --刷新强化推送
		local hero_list_view_update_cell_strength_button_push_terminal = {
            _name = "hero_list_view_update_cell_strength_button_push",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	instance:updateCellStrengthButtonPush()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --锁定合成
		local hero_list_view_update_cell_lock_synthesis_terminal = {
            _name = "hero_list_view_update_cell_lock_synthesis",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if params == true then
            		local m_layer = cc.Layer:create()	
				    local m_size = instance.roots[1]:getContentSize()
				    m_layer:removeAllChildren(true)
				    m_layer:setContentSize(cc.size(m_size.width, m_size.height))
				    m_layer:setPosition(cc.p(0,0))
				    m_layer:setTag(1024)
				    m_layer:setTouchEnabled(true)
				    instance.roots[1]:addChild(m_layer,1024)
            	else
            		if instance.roots[1]:getChildByTag(1024) ~= nil then 
                    	instance.roots[1]:removeChildByTag(1024)
                	end
            	end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

		local hero_list_view_get_next_ship_info_terminal = {
            _name = "hero_list_view_get_next_ship_info",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	return instance:getNextPageShipInfo(params)
            end,
            _terminal = nil,
            _terminals = nil
        }

		local hero_list_view_update_ship_praise_info_terminal = {
            _name = "hero_list_view_update_ship_praise_info",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
            		instance:updateShipPraiseInfo()
            	end
            	return true
            end,
            _terminal = nil,
            _terminals = nil
        }

		state_machine.add(hero_show_hero_counts_terminal)
		state_machine.add(hero_sort_terminal)
		state_machine.add(hero_list_view_show_hero_list_view_sell_terminal)
		state_machine.add(hero_list_view_insert_cell_terminal)
		state_machine.add(hero_list_view_remove_cell_terminal)
		state_machine.add(hero_list_view_update_cell_terminal)
		state_machine.add(hero_list_view_remove_cell_by_sell_terminal)
		state_machine.add(ship_expansion_action_start_terminal)
		state_machine.add(hero_list_view_update_cell_by_sell_terminal)
		state_machine.add(hero_list_view_update_cell_equip_button_push_terminal)
		state_machine.add(hero_list_view_update_cell_strength_button_push_terminal)
		state_machine.add(hero_list_view_update_cell_lock_synthesis_terminal)
		state_machine.add(hero_list_view_get_next_ship_info_terminal)
		state_machine.add(hero_list_view_update_ship_praise_info_terminal)
        state_machine.init()
    end
    init_hero_list_view_terminal()
end

function HeroListView:getNextPageShipInfo( chooseIndex )
	local ship_id = 0
	if chooseIndex <= 0 then
		chooseIndex = #self.beSynthesized + #self.tSortedHeroes + #self.UnlockedShip
		if #self.UnlockedShip > 0 then
			ship_id = dms.string(dms["prop_mould"], self.UnlockedShip[#self.UnlockedShip], prop_mould.use_of_ship)
		else
			ship_id = self.tSortedHeroes[#self.tSortedHeroes].ship_template_id
		end
	elseif chooseIndex > #self.beSynthesized + #self.tSortedHeroes + #self.UnlockedShip then
		chooseIndex = 1
		if #self.beSynthesized > 0 then
			ship_id = dms.string(dms["prop_mould"], self.beSynthesized[1], prop_mould.use_of_ship)
		else
			ship_id = self.tSortedHeroes[1].ship_template_id
		end
	else
		if chooseIndex <= #self.beSynthesized then
			ship_id = dms.string(dms["prop_mould"], self.beSynthesized[chooseIndex], prop_mould.use_of_ship)
		elseif chooseIndex <= #self.beSynthesized + #self.tSortedHeroes then
			ship_id = self.tSortedHeroes[chooseIndex - #self.beSynthesized].ship_template_id
		else
			ship_id = dms.string(dms["prop_mould"], self.UnlockedShip[chooseIndex - #self.beSynthesized - #self.tSortedHeroes], prop_mould.use_of_ship)
		end
	end
	return zstring.tonumber(ship_id), chooseIndex
end

function HeroListView:cleanListView()
	local root = self.roots[1]
	local listView = ccui.Helper:seekWidgetByName(root, "ListView_25081")
	local items = listView:getItems()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_legendary_game 
		then
		local function checkShipActive(item)
			if item == nil then
				return true
			end
			local status = false
			for j, q in pairs(_ED.user_ship) do
				if tonumber(item.heroInstance.ship_template_id) == tonumber(q.ship_template_id) then
					status = true
				end
			end
			return status
		end
		for i, v in pairs(items) do
			if checkShipActive(v.child1) == false then
				v.child1:removeFromParent(true)
				v.child1 = nil
			end
			if checkShipActive(v.child2) == false then
				v.child2:removeFromParent(true)
				v.child2 = nil
			end
			if v.child1 == nil and v.child2 == nil then
				listView:removeItem(listView:getIndex(v))
			end
		end
		items = listView:getItems()
		for i, v in pairs(items) do
			state_machine.excute("multiple_list_view_cell_manager", 0, v)
		end
		listView:requestRefreshView()
	else
		for i, v in pairs(items) do
			local status = false
			for j, q in pairs(_ED.user_ship) do
				if tonumber(v.heroInstance.ship_template_id) == tonumber(q.ship_template_id) then
					status = true
				end
			end
			if status == false then
				listView:removeItem(listView:getIndex(v))
			end
		end
	end
end

function HeroListView:getUnlockedShip()
	local function fightingCapacity(a,b)
		local al = zstring.tonumber(getPropAllCountByMouldId(a))
		local bl = zstring.tonumber(getPropAllCountByMouldId(b))
		local result = false
		if al > bl then
			result = true
		elseif al == bl then
			if dms.int(dms["prop_mould"], a, prop_mould.trace_scene) < dms.int(dms["prop_mould"], b, prop_mould.trace_scene) then
				result = true
			end
		end
		return result
	end

	local obtainShip = {}
	local tSortedHeroes = {}

	local beSynthesized = {}
	for i, ship in pairs(_ED.user_ship) do
		local isAdd = false
		for j, mould in pairs(obtainShip) do
			if tonumber(ship.ship_template_id) == tonumber(mould) then
				isAdd = true
				break
			end
		end
		if isAdd == false then
			table.insert(obtainShip, ship.ship_template_id)
		end
	end
	for i, shipMould in pairs(dms["prop_mould"]) do
		local isAdd = false
		if tonumber(dms.atoi(shipMould, prop_mould.props_type)) == 1 then
			for j, mould in pairs(obtainShip) do
				if dms.atoi(shipMould, prop_mould.use_of_ship) == tonumber(mould) then
					isAdd = true
					break
				end
			end
			if isAdd == false then
				if tonumber(getPropAllCountByMouldId(dms.atoi(shipMould, prop_mould.id))) >= dms.atoi(shipMould, prop_mould.split_or_merge_count) then
					table.insert(beSynthesized, dms.atoi(shipMould, prop_mould.id))
				else
					table.insert(tSortedHeroes, dms.atoi(shipMould, prop_mould.id))
				end
			end
		end
	end
	table.sort(tSortedHeroes, fightingCapacity)
	table.sort(beSynthesized, fightingCapacity)

	return tSortedHeroes,beSynthesized
end

function HeroListView:getSortedHeroes()
	local function fightingCapacity(a,b)
		local al = tonumber(a.hero_fight)
		local bl = tonumber(b.hero_fight)
		local result = false
		if al > bl then
			result = true
		end
		return result 
	end

	local tSortedHeroes = {}
	-- 上阵武将数组
	local arrBusyHeroes = {}
	-- 各星级武将数组
	local arrStarLevelHeroesWhite = {}--白
	local arrStarLevelHeroesGreen = {}--绿
	local arrStarLevelHeroesKohlrabiblue= {}--蓝
	local arrStarLevelHeroesPurple = {}--紫
	local arrStarLevelHeroesOrange = {}--橙
	local arrStarLevelHeroesRed = {}--红
	local arrStarLevelHeroesGold = {}--金
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		for i, ship in pairs(_ED.user_ship) do
			if ship.ship_id ~= nil then
				if zstring.tonumber(ship.formation_index) > 0 or zstring.tonumber(ship.little_partner_formation_index) > 0 then
					table.insert(arrBusyHeroes, ship)
				else
					table.insert(arrStarLevelHeroesWhite, ship)	
				end
			end
		end
		table.sort(arrBusyHeroes, fightingCapacity)
		table.sort(arrStarLevelHeroesWhite, fightingCapacity)
		for i=1, #arrBusyHeroes do
			table.insert(tSortedHeroes, arrBusyHeroes[i])
		end
		for i=1, #arrStarLevelHeroesWhite do
			table.insert(tSortedHeroes, arrStarLevelHeroesWhite[i])
		end
	else
		-- 主角放在第一位
		for i, ship in pairs(_ED.user_ship) do
			if ship.ship_id ~= nil then
				local shipData = dms.element(dms["ship_mould"], ship.ship_template_id)
				local captain_type = dms.atoi(shipData, ship_mould.captain_type)
				if captain_type == 0 then
					tSortedHeroes[1] = ship
				elseif zstring.tonumber(ship.formation_index) > 0 or zstring.tonumber(ship.little_partner_formation_index) > 0 then
					table.insert(arrBusyHeroes, ship)
				else
					if captain_type ~= 3 then 
						if dms.atoi(shipData, ship_mould.ship_type) == 0 then
							table.insert(arrStarLevelHeroesWhite, ship)
						elseif dms.atoi(shipData, ship_mould.ship_type) == 1 then
							table.insert(arrStarLevelHeroesGreen, ship)
						elseif dms.atoi(shipData, ship_mould.ship_type) == 2 then
							table.insert(arrStarLevelHeroesKohlrabiblue, ship)
						elseif dms.atoi(shipData, ship_mould.ship_type) == 3 then
							table.insert(arrStarLevelHeroesPurple, ship)
						elseif dms.atoi(shipData, ship_mould.ship_type) == 4 then
							table.insert(arrStarLevelHeroesOrange, ship)
						elseif dms.atoi(shipData, ship_mould.ship_type) == 5 then
							table.insert(arrStarLevelHeroesRed, ship)
						elseif dms.atoi(shipData, ship_mould.ship_type) == 6 then
							table.insert(arrStarLevelHeroesGold, ship)
						end 
					end
				end
			end
		end
		table.sort(arrBusyHeroes, fightingCapacity)
		table.sort(arrStarLevelHeroesWhite, fightingCapacity)
		table.sort(arrStarLevelHeroesGreen, fightingCapacity)
		table.sort(arrStarLevelHeroesKohlrabiblue, fightingCapacity)
		table.sort(arrStarLevelHeroesPurple, fightingCapacity)
		table.sort(arrStarLevelHeroesOrange, fightingCapacity)
		table.sort(arrStarLevelHeroesRed, fightingCapacity)
		table.sort(arrStarLevelHeroesGold, fightingCapacity)
		-- 把已排序好的上阵武将加入到 武将排序数组中
		for i=1, #arrBusyHeroes do
			table.insert(tSortedHeroes, arrBusyHeroes[i])
		end
		for i=1, #arrStarLevelHeroesGold do
			table.insert(tSortedHeroes, arrStarLevelHeroesGold[i])
		end
		for i=1, #arrStarLevelHeroesRed do
			table.insert(tSortedHeroes, arrStarLevelHeroesRed[i])
		end
		for i=1, #arrStarLevelHeroesOrange do
			table.insert(tSortedHeroes, arrStarLevelHeroesOrange[i])
		end
		for i=1, #arrStarLevelHeroesPurple do
			table.insert(tSortedHeroes, arrStarLevelHeroesPurple[i])
		end
		for i=1, #arrStarLevelHeroesKohlrabiblue do
			table.insert(tSortedHeroes, arrStarLevelHeroesKohlrabiblue[i])
		end
		for i=1, #arrStarLevelHeroesGreen do
			table.insert(tSortedHeroes, arrStarLevelHeroesGreen[i])
		end
		for i=1, #arrStarLevelHeroesWhite do
			table.insert(tSortedHeroes, arrStarLevelHeroesWhite[i])
		end
	end
	
	return tSortedHeroes
end

function HeroListView:getListIndexByShipId(_sortedHeroes, _shipId)
	for i, v in ipairs(_sortedHeroes) do
		if _shipId == v.ship_id then
			return i-1
		end
	end
	return nil
end

function HeroListView:insertCell(_cell, _index)
	local _herolistView = ccui.Helper:seekWidgetByName(self.roots[1], "ListView_25081")
	--添加取值保险,至少是在合法index范围
	_index = math.max(_index, 0)
	_index = math.min(_index, table.getn(_herolistView:getItems()))
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_legendary_game 
		then
		self:createListView()
	elseif __lua_project_id == __lua_project_l_digital then
		self:createScollView()
		-- local items = _herolistView:getItems()
		-- local preMultipleCell = nil
		-- local multipleCell = nil

		-- for i, v in pairs(items) do
		-- 	if ((i-1) * 2) == _index then
		-- 		preMultipleCell = v.prev
		-- 		multipleCell = MultipleListViewCell:createCell()
		-- 		multipleCell:init(_herolistView, HeroSeatCell.__size)
		-- 		_herolistView:insertCustomItem(multipleCell, i - 1)
		-- 		if preMultipleCell ~= nil then
		-- 			preMultipleCell.next = multipleCell
		-- 		end
		-- 		multipleCell.prev = preMultipleCell
		-- 		v.prev = multipleCell
		-- 		multipleCell.next = v
		-- 		multipleCell:addNode(_cell)
		-- 		break
		-- 	end 
		-- 	if ((i-1) * 2 + 1) == _index then
		-- 		multipleCell = MultipleListViewCell:createCell()
		-- 		multipleCell:init(_herolistView, HeroSeatCell.__size)
		-- 		_herolistView:insertCustomItem(multipleCell, i)
		-- 		if v.next ~= nil then
		-- 			v.next.prev = multipleCell
		-- 			multipleCell.next = v.next
		-- 		end
		-- 		v.next = multipleCell
		-- 		multipleCell.prev = v

		-- 		if v.child2 ~= nil then
		-- 			v.child2:retain()
		-- 			v.child2:removeFromParent(false)
		-- 			multipleCell:addNode(v.child2)
		-- 			v.child2:release()
		-- 			v.child2 = nil
		-- 		end
		-- 		v:addNode(_cell)
		-- 		break
		-- 	end 
		-- end
		-- items = _herolistView:getItems()
		-- for i, v in pairs(items) do
		-- 	state_machine.excute("multiple_list_view_cell_manager", 0, v)
		-- end
	else
		_herolistView:insertCustomItem(_cell, _index)
		state_machine.excute("hero_show_hero_counts", 0, "hero_show_hero_counts.")
	end
end

function HeroListView:removeCellByShipId(_ship_id)
	local _herolistView = ccui.Helper:seekWidgetByName(self.roots[1], "ListView_25081")
	local cells = _herolistView:getItems()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_legendary_game 
		then
		state_machine.excute("hero_sort",0,"")
		self:createListView()
		if  __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
			 then
			_herolistView:jumpToTop()
		end
		_herolistView:requestRefreshView()
		--for i, cell in pairs(cells) do

			-- if cell.child1 ~= nil and cell.child1.heroInstance.ship_id == _ship_id then
			-- 	cell.child1:removeFromParent(true)
			-- 	cell.child1 = nil
			-- end
			-- if cell.child2 ~= nil and cell.child2.heroInstance.ship_id == _ship_id then
			-- 	cell.child2:removeFromParent(true)
			-- 	cell.child2 = nil
			-- end
			-- state_machine.excute("multiple_list_view_cell_manager", 0, cell)
		--end
	elseif __lua_project_id == __lua_project_l_digital then
		state_machine.excute("hero_sort",0,"")
		self:createScollView()
	else
		for i, cell in pairs(cells) do
			if cell.heroInstance.ship_id == _ship_id then
				_herolistView:removeItem(_herolistView:getIndex(cell))
			end
		end
		_herolistView:requestRefreshView()
	end
	state_machine.excute("hero_show_hero_counts", 0, "hero_show_hero_counts.")
end

function HeroListView:updateShipPraiseInfo()
	if __lua_project_id == __lua_project_l_digital then
		local _heroScrollView = ccui.Helper:seekWidgetByName(self.roots[1], "ScrollView_generals")
		local cells = _heroScrollView:getChildren()
		for i, cell in pairs(cells) do
			if cell ~= nil and cell:getTag() and cell:getTag() ~= 500 then
				state_machine.excute("sm_hero_seat_update_ship_praise_info",0,cell)
			end
		end
	else
		local _herolistView = ccui.Helper:seekWidgetByName(self.roots[1], "ListView_25081")
		local cells = _herolistView:getItems()
		for i, cell in pairs(cells) do
			if cell.child1 ~= nil then
				state_machine.excute("sm_hero_seat_update_ship_praise_info",0,cell.child1)
			end
			if cell.child2 ~= nil then
				state_machine.excute("sm_hero_seat_update_ship_praise_info",0,cell.child2)
			end
		end
	end
end

function HeroListView:updateCellEquipButtonPush()
	if __lua_project_id == __lua_project_l_digital then
		local _heroScrollView = ccui.Helper:seekWidgetByName(self.roots[1], "ScrollView_generals")
		local cells = _heroScrollView:getChildren()
		for i, cell in pairs(cells) do
			if cell ~= nil and cell:getTag() and cell:getTag() ~= 500 then
				state_machine.excute("sm_hero_seat_update_equip_button_push",0,cell)
			end
		end
	else
		local _herolistView = ccui.Helper:seekWidgetByName(self.roots[1], "ListView_25081")
		local cells = _herolistView:getItems()
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			for i, cell in pairs(cells) do
				if cell.child1 ~= nil then
					state_machine.excute("sm_hero_seat_update_equip_button_push",0,cell.child1)
				end
				if cell.child2 ~= nil then
					state_machine.excute("sm_hero_seat_update_equip_button_push",0,cell.child2)
				end
			end
		end 
	end
end
function HeroListView:updateCellStrengthButtonPush()
	if __lua_project_id == __lua_project_l_digital then
		local _heroScrollView = ccui.Helper:seekWidgetByName(self.roots[1], "ScrollView_generals")
		local cells = _heroScrollView:getChildren()
		for i, cell in pairs(cells) do
			if cell ~= nil and cell:getTag() and cell:getTag() ~= 500 then
				state_machine.excute("sm_hero_seat_update_strength_button_push",0,cell)
			end
		end
	else
		local _herolistView = ccui.Helper:seekWidgetByName(self.roots[1], "ListView_25081")
		local cells = _herolistView:getItems()
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			for i, cell in pairs(cells) do
				if cell.child1 ~= nil then
					state_machine.excute("sm_hero_seat_update_strength_button_push",0,cell.child1)
				end
				if cell.child2 ~= nil then
					state_machine.excute("sm_hero_seat_update_strength_button_push",0,cell.child2)
				end
			end
		end
	end
end

function HeroListView:updateCellByShipId(_ship_id)
	local _herolistView = ccui.Helper:seekWidgetByName(self.roots[1], "ListView_25081")
	local cells = _herolistView:getItems()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_legendary_game 
		then
		for i, cell in pairs(cells) do
			if cell.child1 ~= nil and cell:getTag() and cell:getTag() ~= 500 and tonumber(cell.child1.heroInstance.ship_id) == tonumber(_ship_id) then
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					state_machine.excute("sm_hero_seat_update", 0, cell.child1)
				else
					state_machine.excute("hero_seat_update", 0, cell.child1)
				end
				break
			end
			if cell.child2 ~= nil and tonumber(cell.child2.heroInstance.ship_id) == tonumber(_ship_id) then
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					state_machine.excute("sm_hero_seat_update", 0, cell.child2)
				else
					state_machine.excute("hero_seat_update", 0, cell.child2)
				end
				break
			end
		end
	elseif __lua_project_id == __lua_project_l_digital then
		local _heroScrollView = ccui.Helper:seekWidgetByName(self.roots[1], "ScrollView_generals")
		local cells = _heroScrollView:getChildren()
		for i, cell in pairs(cells) do
			if cell ~= nil and tonumber(cell.heroInstance.ship_id) == tonumber(_ship_id) then
				state_machine.excute("sm_hero_seat_update", 0, cell)
			end
		end
	else
		for i, cell in pairs(cells) do
			if tonumber(cell.heroInstance.ship_id) == tonumber(_ship_id) then
				state_machine.excute("hero_seat_update", 0, cell)
				break
			end
		end
	end
end

function HeroListView:onUpdate(dt)
	if  __lua_project_id == __lua_project_l_digital then
		if self.currentScrollView ~= nil and self.currentScrollViewInnerContainer ~= nil then
	        local size = self.currentScrollView:getContentSize()
	        local posY = self.currentScrollViewInnerContainer:getPositionY()
	        if self.currentScrollViewInnerContainerPosY == posY then
	            return
	        end
	        self.currentScrollViewInnerContainerPosY = posY
	        local items = self.currentScrollView:getChildren()
	        if items[1] == nil then
	            return
	        end
	        local itemSize = items[1]:getContentSize()
	        for i, v in pairs(items) do
	            local tempY = v:getPositionY() + posY
	            if tempY + itemSize.height * 2 < 0 or tempY > size.height + itemSize.height * 2 then
	                v:unload()
	            else
	                v:reload()
	            end
	        end
	    end
	else
		if self.isRunning == false or self.runningExpansionCell == nil or self.runningExpansionCell.roots[1] == nil then
		else
			local expansion_pad = ccui.Helper:seekWidgetByName(self.runningExpansionCell.roots[1], "Panel_xiala")
			local offsetY = (expansion_pad:getParent():getPositionY() - expansion_pad:getPositionY()) / 2
			
			self.runningExpansionCell:setContentSize(cc.size(self.runningExpansionCell:getContentSize().width, self.runningExpansionCellHeight + offsetY))
			ccui.Helper:seekWidgetByName(self.roots[1], "ListView_25081"):requestRefreshView()
		end	

		if self.currentListView ~= nil and self.currentInnerContainer ~= nil then
			local size = self.currentListView:getContentSize()
			local posY = self.currentInnerContainer:getPositionY()
			if self.currentInnerContainerPosY == posY then
				return
			end
			self.currentInnerContainerPosY = posY
			local items = self.currentListView:getItems()
			if items[1] == nil then
				return
			end
			local itemSize = items[1]:getContentSize()
			for i, v in pairs(items) do
				local tempY = v:getPositionY() + posY
				if tempY + itemSize.height < 0 or tempY > size.height + itemSize.height then
					if v == self.runningExpansionCell then
						if __lua_project_id == __lua_project_l_digital 
							or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
							then
							v:setContentSize(SmHeroSeatCell.__size)
						else
							v:setContentSize(HeroSeatCell.__size)
							state_machine.excute("ship_expansion_action_start", 0, {_datas = {cell = v}, _off = true})
						end
					end
					v:unload()
				else
					v:reload()
				end
			end
		end
	end
end

function HeroListView.loading(texture)
	-- local myListView = ccui.Helper:seekWidgetByName(root, "ListView_25081")
	-- for i, v in ipairs(self.tSortedHeroes) do
	-- 	local cell = HeroSeatCell:createCell()
	-- 	cell:init(v,i)
	-- 	myListView:addChild(cell)
	-- end
	-- myListView:jumpToTop()

	local myListView = HeroListView.myListView
	if myListView ~= nil then
		local cell = HeroSeatCell:createCell()
		cell:init(HeroListView.tSortedHeroes[HeroListView.asyncIndex], nil, HeroListView.asyncIndex)
		myListView:addChild(cell)
		HeroListView.asyncIndex = HeroListView.asyncIndex + 1
		-- myListView:requestRefreshView()
	end
	
	-- HeroPatchListView.loading(texture)
	-- HeroSell.loading(texture)
end

function HeroListView:createScollView()
	local m_ScrollView = HeroListView.myScrollView 
	m_ScrollView:removeAllChildren(true)
    local panel = m_ScrollView:getInnerContainer()
    panel:setContentSize(m_ScrollView:getContentSize())
    panel:setPosition(cc.p(0,0))
    panel:removeAllChildren(true)
    local sSize = panel:getContentSize()
    local sHeight = sSize.height
    local sWidth = sSize.width
    local controlSize = m_ScrollView:getInnerContainerSize()
    local nextY = sSize.height
    local nextX = sSize.width
    local tHeight = 0
    local cellHeight = 0
    local tWidth = 0
    local wPosition = sWidth/3
    local Hlindex = 0
    local number = #(self.beSynthesized) + #(self.tSortedHeroes) + #(self.UnlockedShip)
    local m_number = math.ceil(number/3) + 1
    --172 cell的高度，暂时写死 50分割线的高度
    cellHeight = m_number*172+50
    sHeight = math.max(sHeight, cellHeight)
    panel:setContentSize(m_ScrollView:getContentSize().width, sHeight)
    local first = nil
    local index = 1
    local cell_height = 0
    for j, v in pairs(self.beSynthesized) do
        local cell = SmHeroSeatCell:createCell()
		cell:init(v, 2, j)
        panel:addChild(cell)
        cell_height = cell:getContentSize().height
        tWidth = tWidth + wPosition
        if (index-1)%3 ==0 then
            Hlindex = Hlindex+1
            tWidth = 0
            tHeight = sHeight - cell_height*Hlindex  
        end
        if index <= 3 then
            tHeight = sHeight - cell_height
        end
        cell:setPosition(cc.p(tWidth,tHeight))
        index = index + 1
    end
    for j, v in pairs(self.tSortedHeroes) do
        local cell = SmHeroSeatCell:createCell()
		cell:init(v, 1, j+#self.beSynthesized)
        panel:addChild(cell)
        cell_height = cell:getContentSize().height
        tWidth = tWidth + wPosition
        if (index-1)%3 ==0 then
            Hlindex = Hlindex+1
            tWidth = 0
            tHeight = sHeight - cell_height*Hlindex  
        end
        if index <= 3 then
            tHeight = sHeight - cell_height
        end
        cell:setPosition(cc.p(tWidth,tHeight))
        index = index + 1
    end

    --华丽的分割线
	local dividing_line = SmShipDividingLine:createCell()
	dividing_line:init()
	m_ScrollView:addChild(dividing_line)
	dividing_line:setTag(500)
	tHeight = tHeight-dividing_line:getContentSize().height
	dividing_line:setPosition(cc.p(0,tHeight))

	for j, v in pairs(self.UnlockedShip) do
        local cell = SmHeroSeatCell:createCell()
		cell:init(v, 2, j+#self.tSortedHeroes+#self.beSynthesized)
        panel:addChild(cell)
        cell_height = cell:getContentSize().height
        tWidth = tWidth + wPosition
        if (j-1)%3 ==0 then
            Hlindex = Hlindex+1
            tWidth = 0
            tHeight = sHeight - cell_height*Hlindex - dividing_line:getContentSize().height 
        end
        if index <= 3 then
            tHeight = sHeight - cell_height
        end
        cell:setPosition(cc.p(tWidth,tHeight))
        index = index + 1
    end

    m_ScrollView:jumpToTop()

    self.currentScrollView = m_ScrollView
    self.currentScrollViewInnerContainer = self.currentScrollView:getInnerContainer()
    self.currentScrollViewInnerContainerPosY = self.currentScrollViewInnerContainer:getPositionY()
end

function HeroListView:createListView()
	app.load("client.cells.utils.multiple_list_view_cell")
	HeroListView.myListView:removeAllItems()
	local preMultipleCell = nil
	local multipleCell = nil
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		for i,v in pairs(self.beSynthesized) do
			local cell = nil
			cell = SmHeroSeatCell:createCell()
			cell:init(v, 2, i)
			if multipleCell == nil then
				multipleCell = MultipleListViewCell:createCell()
				-- table.insert(list, multipleCell)
				multipleCell:init(HeroListView.myListView, SmHeroSeatCell.__size)
				HeroListView.myListView:addChild(multipleCell)
				multipleCell.prev = preMultipleCell
				if preMultipleCell ~= nil then
					preMultipleCell.next = multipleCell
				end
			end
			multipleCell:addNode(cell)
			if multipleCell.child2 ~= nil then
				preMultipleCell = multipleCell
				multipleCell = nil
			end
		end
	end
	for i,v in pairs(self.tSortedHeroes) do
		local cell = nil
		if __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			then
			cell = SmHeroSeatCell:createCell()
			cell:init(v, 1, i+#self.beSynthesized)
		else
			cell = HeroSeatCell:createCell()
			cell:init(v, nil, i)
		end
		if multipleCell == nil then
			multipleCell = MultipleListViewCell:createCell()
			-- table.insert(list, multipleCell)
			if __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				then
				multipleCell:init(HeroListView.myListView, SmHeroSeatCell.__size)
			else
				multipleCell:init(HeroListView.myListView, HeroSeatCell.__size)
			end
			HeroListView.myListView:addChild(multipleCell)
			multipleCell.prev = preMultipleCell
			if preMultipleCell ~= nil then
				preMultipleCell.next = multipleCell
			end
		end
		multipleCell:addNode(cell)
		if multipleCell.child2 ~= nil then
			preMultipleCell = multipleCell
			multipleCell = nil
		end
	end

	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		--华丽的分割线
		local dividing_line = SmShipDividingLine:createCell()
		dividing_line:init()
		HeroListView.myListView:addChild(dividing_line)

		-- 未获得的
		local preMultipleCell = nil
		local multipleCell = nil
		for i,v in pairs(self.UnlockedShip) do
			local cell = nil
			cell = SmHeroSeatCell:createCell()
			cell:init(v, 2, i+#self.tSortedHeroes+#self.beSynthesized)
			if multipleCell == nil then
				multipleCell = MultipleListViewCell:createCell()
				-- table.insert(list, multipleCell)
				multipleCell:init(HeroListView.myListView, SmHeroSeatCell.__size)
				HeroListView.myListView:addChild(multipleCell)
				multipleCell.prev = preMultipleCell
				if preMultipleCell ~= nil then
					preMultipleCell.next = multipleCell
				end
			end
			multipleCell:addNode(cell)
			if multipleCell.child2 ~= nil then
				preMultipleCell = multipleCell
				multipleCell = nil
			end
		end
	end
	-- HeroListView.myListView:requestRefreshView()
end

function HeroListView:onEnterTransitionFinish()
    local csbHeroListView = csb.createNode("packs/HeroStorage/generals_list_sui.csb")
	local root = csbHeroListView:getChildByName("root")
	table.insert(self.roots, root)
	self:addChild(csbHeroListView)

	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_red_alert 
		then
		Animations_PlayOpenMainUI({ccui.Helper:seekWidgetByName(root, "Panel_6")}, SHOW_UI_ACTION_TYPR.TYPE_ACTION_CENTER_IN)
    elseif __lua_project_id == __lua_project_legendary_game then
		local action = csb.createTimeline("packs/HeroStorage/generals_list_sui.csb")
	    csbHeroListView:runAction(action)
	    self.m_action = action
	    self:playIntoAction()
	end

	state_machine.excute("hero_show_hero_counts", 0, "hero_show_hero_counts.")
	state_machine.excute("hero_sort", 0, "hero_sort.")

	local hero_storage_sell_button = ccui.Helper:seekWidgetByName(root, "Button_5069")
	fwin:addTouchEventListener(hero_storage_sell_button, nil, 
	{
		terminal_name = "hero_list_view_show_hero_list_view_sell", 	
		current_button_name = "Button_5069",  	
		but_image = "", 	
		terminal_state = 0, 
		isPressedActionEnabled = true
	},	
	nil, 0)	
	
    local Panel_effec = ccui.Helper:seekWidgetByName(root, "Panel_effec")
    if Panel_effec ~= nil then
        Panel_effec:removeAllChildren(true)
        local jsonFile = "images/ui/effice/effect_chixu/effect_chixu.json"
        local atlasFile = "images/ui/effice/effect_chixu/effect_chixu.atlas"
        local animation2 = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
        animation2:setPosition(cc.p(Panel_effec:getContentSize().width/2,0))
        Panel_effec:addChild(animation2)
    end
	-- local myListView = ccui.Helper:seekWidgetByName(root, "ListView_25081")
	-- for i, v in ipairs(self.tSortedHeroes) do
	-- 	local cell = HeroSeatCell:createCell()
	-- 	cell:init(v,i)
	-- 	myListView:addChild(cell)
	-- end
	-- myListView:jumpToTop()

	HeroListView.myListView = ccui.Helper:seekWidgetByName(root, "ListView_25081")
	
	if __lua_project_id == __lua_project_l_digital then
		HeroListView.myScrollView = ccui.Helper:seekWidgetByName(root, "ScrollView_generals")
		HeroListView.myListView:setVisible(false)
	end
	HeroListView.tSortedHeroes = self.tSortedHeroes
	HeroListView.UnlockedShip = self.UnlockedShip
	HeroListView.beSynthesized = self.beSynthesized
	HeroListView.asyncIndex = 1
	-- cc.Director:getInstance():getTextureCache():removeTextureForKey(fwin._asyncImg)
	if __lua_project_id == __lua_project_gragon_tiger_gate
		-- or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_legendary_game 
		then
		self:createListView()
	elseif __lua_project_id == __lua_project_l_digital then
		self:createScollView()
	else
		for i, v in ipairs(self.tSortedHeroes) do
			-- cc.Director:getInstance():getTextureCache():addImageAsync(fwin._asyncImg, self.loading)
			self.loading(nil)
		end
	
		HeroListView.myListView:requestRefreshView()
	end

	self.currentListView = HeroListView.myListView
	self.currentInnerContainer = self.currentListView:getInnerContainer()
	self.currentInnerContainerPosY = self.currentInnerContainer:getPositionY()
end


function HeroListView:playCloseAction()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		self:onClose()
	elseif __lua_project_id == __lua_project_legendary_game then
		self.m_action:play("window_close", false)
	end
end

function HeroListView:playIntoAction()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_legendary_game 
		then
		self.m_action:play("window_open", false)
		self.m_action:setFrameEventCallFunc(function (frame)
	        if nil == frame then
	            return
	        end

	        local str = frame:getEvent()
	        if str == "window_open_over" then
	        	
	        elseif str == "window_close_over" then
	            self:onClose()
	        end
	    end)
	end
end

function HeroListView:close( ... )
    local Panel_effec = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_effec")
    if Panel_effec ~= nil then
        Panel_effec:removeAllChildren(true)
    end
end

function HeroListView:onExit()
	HeroListView.myListView = nil
	HeroListView.asyncIndex = 1
	state_machine.remove("hero_show_hero_counts")
	state_machine.remove("hero_sort")
	state_machine.remove("hero_list_view_show_hero_list_view_sell")
	state_machine.remove("hero_list_view_insert_cell")
	state_machine.remove("hero_list_view_remove_cell")
	state_machine.remove("ship_expansion_action_start")
	state_machine.remove("hero_list_view_update_cell")
	state_machine.remove("hero_list_view_remove_cell_by_sell")
	state_machine.remove("hero_list_view_update_cell_equip_button_push")
	state_machine.remove("hero_list_view_update_cell_strength_button_push")
	state_machine.remove("hero_list_view_get_next_ship_info")
	state_machine.remove("hero_list_view_update_ship_praise_info")
end
