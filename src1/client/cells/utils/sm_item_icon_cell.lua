----------------------------------------------------------------------------------------------------
-- 说明：数码的小图标绘制
-------------------------------------------------------------------------------------------------------
SmItemIconCell = class("SmItemIconCellClass", Window)
SmItemIconCell.__size = nil

local sm_item_icon_cell_create_terminal = {
    _name = "sm_item_icon_cell_create",
    _init = function (terminal)
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        local cell = SmItemIconCell:new()
        cell:init(params[1],params[2],params[3],params[4],params[5],params[6],params[7])
        cell:registerOnNodeEvent(cell)
        return cell
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_item_icon_cell_create_terminal)
state_machine.init()

function SmItemIconCell:ctor()
    self.super:ctor()
	self.roots = {}

	self.res_data = {
		{2,"images/ui/props/props_4002.png", _All_tip_string_info._fundName},				-- 	1:银币
		{2,"images/ui/props/props_4001.png", _All_tip_string_info._crystalName},			-- 	2:金币 
		{2,"images/ui/props/props_4004.png", _All_tip_string_info._reputation},--  3:声望 
		{0,"images/ui/props/props_4007.png", _All_tip_string_info._hero},												-- 	4:将魂 
		{2,"images/ui/props/props_3000.png", _All_tip_string_info._juexingsuipian},												-- 	5:魂玉 (水雷魂)
		{0,"", ""},												-- 	6:道具
		{0,"", ""},												-- 	7:装备 
		{2,"images/ui/props/props_4003.png", reward_prop_list[8]},				-- 	8:经验
		{0,"", ""},												-- 	9:耐力 
		{0,"", ""},												-- 	10:功能点
		{0,"", ""},												-- 	11:上阵人数 
		{2,"images/ui/props/props_4005.png", _All_tip_string_info._energyName},					--	12:体力
		{0,"", ""},												-- 	13:武将 
		{0,"", ""},												-- 	14:竞技场排名
		{0,"", ""},												-- 	15:伤害 
		{0,"", ""},												-- 	16:比武积分 
		{0,"", ""},												-- 	17:霸气 
		{2,"images/ui/props/props_4006.png", _All_tip_string_info._glories},	-- 	18:试炼币
		{0,"", ""},												-- 	19:日常任务积分 
		{0,"", ""},												-- 	20:功勋 
		{0,"", ""},												-- 	21:战功
		{4," ", " "},											-- 	22:日常副本基本奖励
		{4," ", " "},											-- 	23:日常副本额外奖励
		{4," ", " "},											-- 	24:出击令
		{4," ", " "},											-- 	25:免战
		{4," ", " "},											-- 	26:
		{4," ", " "},											-- 	27:
		{2,"images/ui/props/props_4013.png", _All_tip_string_info._union_exploit},			-- 	28:公会币
		{4," ", " "},											-- 	29
		{4," ", " "},											-- 	30
		{0,"", ""},												-- 	31
		{0,"", ""},												-- 	32
		{0,"", ""},												-- 	33:驯兽魂
		{2,"images/ui/props/props_4008.png", _my_gane_name[15]},				-- 	34:天赋点
		{2,"images/ui/props/props_4009.png", " "},											-- 	35:探索币
		{0," ", " "},											-- 	36
		{0," ", " "},											-- 	37
		{0," ", " "},											-- 	38
		{4,"images/ui/props/props_4039.png", _my_gane_name[17]},										-- 	39
		{0," ", " "},											-- 	40
		{0," ", " "},											-- 	41
		{0," ", " "},											-- 	42
		{0," ", " "},											-- 	43
		{0," ", " "},											-- 	44
		{0," ", " "},											-- 	45
		{0," ", " "},											-- 	46
		{0," ", " "},											-- 	47
		{0," ", " "},											-- 	48
		{0," ", " "},											-- 	49
		{0," ", " "},											-- 	50
		{0," ", " "},											-- 	51
		{0," ", " "},											-- 	52
		{0," ", " "},											-- 	53
		{0," ", " "},											-- 	54
		{0," ", " "},											-- 	55
		{0," ", " "},											-- 	56
		{0," ", " "},											-- 	57
		{0," ", " "},											-- 	58
		{0," ", " "},											-- 	59
		{0," ", " "},											-- 	60
		{0," ", " "},											-- 	61
		{0," ", " "},											-- 	62
		{4,"images/ui/props/props_4063.png", _my_gane_name[16]},	-- 	63:活跃度
	}

	app.load("client.cells.prop.prop_money_info")
	app.load("client.cells.prop.prop_information")
	app.load("client.cells.prop.sm_hero_information")
	local function init_sm_item_icon_cell_terminal()
		local prop_money_icon_cell_show_info_terminal = {
            _name = "sm_item_icon_cell_show_info",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
            	app.load("client.cells.prop.prop_money_info")
            	if fwin:find("propInformationClass") ~= nil then
            		fwin:close(fwin:find("propInformationClass"))
            	end
            	if fwin:find("propMoneyInfoClass") ~= nil then
            		fwin:close(fwin:find("propMoneyInfoClass"))
            	end
				local prop = params._datas._prop
				local cell = propMoneyInfo:new()
				cell:init("" .. prop)
				fwin:open(cell, fwin._dialog)
				
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --显示道具信息
		local sm_item_icon_cell_show_prop_info_terminal = {
            _name = "sm_item_icon_cell_show_prop_info",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
            	if fwin:find("propInformationClass") ~= nil then
            		fwin:close(fwin:find("propInformationClass"))
            	end
            	if fwin:find("propMoneyInfoClass") ~= nil then
            		fwin:close(fwin:find("propMoneyInfoClass"))
            	end
            				
            	local types = params._datas._prop
            	local mould_id = params._datas._id
            	if mould_id == -1 then 
            		app.load("client.cells.prop.prop_money_info")
					local prop = params._datas._prop
					local cell = propMoneyInfo:new()
					cell:init("" .. types)
					fwin:open(cell, fwin._dialog)
            	else
            		if types== 6 then
            			--道具
            			app.load("client.cells.prop.prop_information")
		        		local cell = propInformation:new()
						cell:init({user_prop_template = mould_id},1)
						fwin:open(cell, fwin._windows)
					elseif types == 7 then 
						--装备
						app.load("client.packs.equipment.EquipFragmentInfomation")
						local prop = mould_id
						if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto then
							if  dms.int(dms["equipment_mould"], prop, equipment_mould.equipment_type) == 6 then
								app.load("client.packs.fashion.FashionInformation")
			            		state_machine.excute("fashion_information_open", 0, {_datas={_equip = nil,_equip_mould = prop}})
		            			return true
		            		end
		            	end
						local FragmentInformation = EquipFragmentInfomation:new()
						
						if dms.int(dms["equipment_mould"], prop, equipment_mould.equipment_type) == 4 or 
							dms.int(dms["equipment_mould"], prop, equipment_mould.equipment_type) == 5 or
							dms.int(dms["equipment_mould"], prop, equipment_mould.equipment_type) == 8 then
							FragmentInformation:init(prop,2,3)
						else
							FragmentInformation:init(prop,nil,2)
						end
						fwin:open(FragmentInformation, fwin._windows)

            		end
            		
            	end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        state_machine.add(sm_item_icon_cell_show_prop_info_terminal)
		state_machine.add(prop_money_icon_cell_show_info_terminal)
        state_machine.init()
        state_machine.init()
	end
	init_sm_item_icon_cell_terminal()
end

function SmItemIconCell:onUpdateDraw()
	local root = self.roots[1]
	local Label_l_order_level = ccui.Helper:seekWidgetByName(root,"Label_l-order_level")        
	local Label_name = ccui.Helper:seekWidgetByName(root,"Label_name")    
	local Label_quantity = ccui.Helper:seekWidgetByName(root,"Label_quantity") 
	local Label_shuxin = ccui.Helper:seekWidgetByName(root,"Label_shuxin") 
	local Panel_prop = ccui.Helper:seekWidgetByName(root,"Panel_prop") 
	local Panel_kuang = ccui.Helper:seekWidgetByName(root,"Panel_kuang") 
	local Panel_ditu = ccui.Helper:seekWidgetByName(root,"Panel_ditu") 
	local Panel_star = ccui.Helper:seekWidgetByName(root,"Panel_star") 
	local Panel_props_right_icon = ccui.Helper:seekWidgetByName(root,"Panel_props_right_icon") 
	local Panel_props_left_icon = ccui.Helper:seekWidgetByName(root,"Panel_props_left_icon") 
	local Panel_num = ccui.Helper:seekWidgetByName(root,"Panel_num") 
	local Text_1 = ccui.Helper:seekWidgetByName(root,"Text_1") 
	local Image_26 = ccui.Helper:seekWidgetByName(root,"Image_26") 
	local Image_item_vip = ccui.Helper:seekWidgetByName(root,"Image_item_vip") 
	local Panel_4 = ccui.Helper:seekWidgetByName(root,"Panel_4") 
	local Image_bidiao = ccui.Helper:seekWidgetByName(root,"Image_bidiao") 
	local Image_dangqian = ccui.Helper:seekWidgetByName(root,"Image_dangqian") 
	local Image_nub2 = ccui.Helper:seekWidgetByName(root,"Image_nub2") 
	local Image_lock = ccui.Helper:seekWidgetByName(root,"Image_lock") 
	local Image_3 = ccui.Helper:seekWidgetByName(root, "Image_3")
	local Image_xuanzhong = ccui.Helper:seekWidgetByName(root, "Image_xuanzhong")
	local Image_2 = ccui.Helper:seekWidgetByName(root, "Image_2")
	local Image_double = ccui.Helper:seekWidgetByName(root, "Image_double")

	local name = ""
	local quality = 0
	local count = 0
	local prop_icon = nil
	local items = self.item
	if zstring.tonumber(items[3]) > 0 then
		count = zstring.tonumber(items[3])
		if zstring.tonumber(items[1]) == 1 then
			quality = self.res_data[1][1]
			prop_icon = cc.Sprite:create(self.res_data[1][2])
			name = _my_gane_name[1]
		elseif zstring.tonumber(items[1]) == 2 then
			quality = self.res_data[2][1]
			prop_icon = cc.Sprite:create(self.res_data[2][2])
			name = _my_gane_name[2]
		elseif zstring.tonumber(items[1]) == 3 then
			quality = self.res_data[3][1]
			prop_icon = cc.Sprite:create(self.res_data[3][2])
			name = _my_gane_name[3]
		elseif zstring.tonumber(items[1]) == 4 then	--将魂
			quality = self.res_data[4][1]
			prop_icon = cc.Sprite:create(self.res_data[4][2])
			name = _my_gane_name[5]
		elseif zstring.tonumber(items[1]) == 5 then	--魂玉
			quality = self.res_data[5][1]
			prop_icon = cc.Sprite:create(self.res_data[5][2])
			name = self.res_data[5][3]
		elseif zstring.tonumber(items[1]) == 8 then	--经验
			quality = self.res_data[8][1]
			prop_icon = cc.Sprite:create(self.res_data[8][2])
			count = zstring.tonumber(items[3])
			name = _my_gane_name[7]
		elseif zstring.tonumber(items[1]) == 9 then	--耐力
			quality = self.res_data[9][1]
			prop_icon = cc.Sprite:create(self.res_data[9][2])
			name = _my_gane_name[9]
		elseif zstring.tonumber(items[1]) == 10 then	--功能点
			quality = self.res_data[10][1]
			prop_icon = cc.Sprite:create(self.res_data[10][2])
			name = _my_gane_name[10]
		elseif zstring.tonumber(items[1]) == 12 then	--体力
			quality = self.res_data[12][1]
			prop_icon = cc.Sprite:create(self.res_data[12][2])
			name = _my_gane_name[8]
		elseif zstring.tonumber(items[1]) == 18 then	--威名
			quality = self.res_data[18][1]
			prop_icon = cc.Sprite:create(self.res_data[18][2])
			name = _my_gane_name[6]
		elseif zstring.tonumber(items[1]) == 20 then	--功勋
			quality = self.res_data[20][1]
			prop_icon = cc.Sprite:createshow_reward_list(self.res_data[20][2])
			name = _my_gane_name[11]
		-- elseif zstring.tonumber(items[1]) == 21 then	--战功
		-- 	quality = 0
		-- 	prop_icon = cc.Sprite:create(self.res_data[21][2])
		elseif zstring.tonumber(items[1]) == 28 then	--军团贡献
			quality = self.res_data[28][1]
			prop_icon = cc.Sprite:create(self.res_data[28][2])
			name = _my_gane_name[13]
		elseif zstring.tonumber(items[1]) == 31 then	--战神令
			quality = self.res_data[31][1]
			prop_icon = cc.Sprite:create(self.res_data[31][2])
			name = red_alert_resouce_tip[1][1]
		elseif zstring.tonumber(items[1]) == 6 then	--道具
			quality = dms.int(dms["prop_mould"], items[2], prop_mould.prop_quality)
			local info = setThePropsIcon(items[2])
			prop_icon = cc.Sprite:create(string.format("images/ui/props/props_%d.png", info[1]))
			name = info[2]
	        local sell_tag = dms.int(dms["prop_mould"], items[2], prop_mould.sell_tag)
			if sell_tag == 3 then
				local effect_paths = string.format(config_res.images.ui.effice.effect_quality_box, 1, 1)
				if cc.FileUtils:getInstance():isFileExist(effect_paths) == true then
					ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(effect_paths)
					local armature = ccs.Armature:create("effect_quality_box_1")
					draw.initArmature(armature, nil, -1, 0, 1)
					armature:setPosition(cc.p(Panel_prop:getContentSize().width/2, Panel_prop:getContentSize().height/2))
					Panel_prop:addChild(armature,10)
				end
			end
			if dms.int(dms["prop_mould"], items[2], prop_mould.change_of_equipment) ~= 0 then
				if Image_26 ~= nil then
					Image_26:setVisible(true)
				end
			elseif dms.int(dms["prop_mould"], items[2],  prop_mould.use_of_ship) ~= 0 then
				if dms.int(dms["prop_mould"], items[2],  prop_mould.props_type) == 16 then 
					if Image_26 ~= nil then
						Image_26:setVisible(false)
					end
				else
					if Image_26 ~= nil then
						Image_26:setVisible(true)
					end
				end
			end
			local footerData = dms.string(dms["prop_mould"], items[2], prop_mould.trace_remarks)
		    local footerInfo = zstring.split(footerData, ",")
		    -- local Panel_props_left_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_left_icon")
		    if Panel_props_left_icon ~= nil then
			    Panel_props_left_icon:removeAllChildren(true)
			    if footerInfo[1] ~= nil and tonumber(footerInfo[1])~= -1 then
			        local props_left_icon = cc.Sprite:create(string.format("images/ui/icon/icon_%d.png", tonumber(footerInfo[1])))
			        if props_left_icon ~= nil then
				        props_left_icon:setPosition(cc.p(Panel_props_left_icon:getContentSize().width/2,Panel_props_left_icon:getContentSize().height/2))
				        Panel_props_left_icon:addChild(props_left_icon)
				    end
			    end
			end
		    --升级材料标识
		    -- local Panel_props_right_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_right_icon")
		    if Panel_props_right_icon ~= nil then
			    Panel_props_right_icon:removeAllChildren(true)
			    if footerInfo[2] ~= nil and tonumber(footerInfo[2]) ~= -1 then
			        local props_right_icon = cc.Sprite:create(string.format("images/ui/icon/icon_%d.png", tonumber(footerInfo[2])))
			        if props_right_icon ~= nil then
				        props_right_icon:setPosition(cc.p(Panel_props_right_icon:getContentSize().width/2,Panel_props_right_icon:getContentSize().height/2))
				        Panel_props_right_icon:addChild(props_right_icon)
				    end
			    end
			end
		elseif zstring.tonumber(items[1]) == 7 then	--装备
			quality = dms.int(dms["equipment_mould"], items[2], equipment_mould.grow_level)
			local icon_index = dms.int(dms["equipment_mould"], items[2], equipment_mould.pic_index)
			prop_icon = cc.Sprite:create(string.format("images/ui/props/props_%d.png", icon_index))
			local nameindex = dms.int(dms["equipment_mould"], items[2], equipment_mould.equipment_name)
			local word_info = dms.element(dms["word_mould"], nameindex)
			name = word_info[3]
		elseif zstring.tonumber(items[1]) == 13 then	--武将
			local evo_image = dms.string(dms["ship_mould"], items[2], ship_mould.fitSkillTwo)
			local evo_info = zstring.split(evo_image, ",")
			local evo_mould_id = evo_info[dms.int(dms["ship_mould"], items[2], ship_mould.captain_name)]
			picIndex = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)
			prop_icon = cc.Sprite:create(string.format("images/ui/props/props_%d.png", picIndex))
			quality = shipOrEquipSetColour(dms.int(dms["ship_mould"], items[2], ship_mould.initial_rank_level))-1

			if Panel_star ~= nil then
				Panel_star:removeAllChildren(true)
			end
			local initStar = dms.int(dms["ship_mould"], items[2], ship_mould.ship_star)
			if self.table.shipStar ~= nil then
				initStar = tonumber(self.table.shipStar)
			end
			if Panel_star ~= nil then
				neWshowShipStar(Panel_star , initStar)
			end
			self.isShowCount = false
		elseif zstring.tonumber(items[1]) == 33 then	--驯兽魂
			quality = self.res_data[33][1]
			prop_icon = cc.Sprite:create(self.res_data[33][2])
			name = _my_gane_name[14]
		elseif zstring.tonumber(items[1]) == 34 then	
			quality = self.res_data[34][1]
			prop_icon = cc.Sprite:create(self.res_data[34][2])
			name = _my_gane_name[15]
		elseif zstring.tonumber(items[1]) == 39 then	
			quality = self.res_data[39][1]
			prop_icon = cc.Sprite:create(self.res_data[39][2])
			name = self.res_data[39][3]
		elseif zstring.tonumber(items[1]) == 63 then	--活跃度
			quality = self.res_data[63][1]
			prop_icon = cc.Sprite:create(self.res_data[63][2])
			name = _my_gane_name[16]
		end
	end
    if prop_icon ~= nil then
        prop_icon:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
        Panel_prop:addChild(prop_icon)
    end
    if self.isShowName == true then
		Label_name:setString(name)
	end
	Label_name:setColor(cc.c3b(color_Type[quality+1][1],color_Type[quality+1][2],color_Type[quality+1][3]))
	if self.isShowCount == true then
		-- if tonumber(count) >= 100000000 then
		-- 	Label_l_order_level:setString(math.floor(count / 100000000) .. string_equiprety_name[39])
		-- else
		if tonumber(count) >= 10000 then
			Label_l_order_level:setString(math.floor(count / 1000) .. string_equiprety_name[40])
		else
			Label_l_order_level:setString(count)
		end
	end
	if quality ~= nil then
		Panel_ditu:removeBackGroundImage()
		Panel_ditu:setVisible(true)
		Panel_ditu:setBackGroundImage(string.format("images/ui/quality/icon_enemy_%d.png", quality+1))
		if zstring.tonumber(items[1]) == 13 then
			Panel_kuang:setBackGroundImage(string.format("images/ui/quality/quality_frame_%d.png", quality))
		end
	end
end

function SmItemIconCell:onEnterTransitionFinish()
end

function SmItemIconCell:showIconInfo(datas ,sender)
	if fwin:find("propInformationClass") ~= nil then
		fwin:close(fwin:find("propInformationClass"))
	end
	if fwin:find("propMoneyInfoClass") ~= nil then
		fwin:close(fwin:find("propMoneyInfoClass"))
	end
	if datas.item_type == 1 
		or datas.item_type == 2
		or datas.item_type == 3
		or datas.item_type == 8
		or datas.item_type == 18
		or datas.item_type == 34
		then
		local cell = propMoneyInfo:new()
		cell:init(""..datas.item_info, nil, sender)
		fwin:open(cell, fwin._windows)
	elseif datas.item_type == 6
		or datas.item_type == 7
		then
		local cell = propInformation:new()
		cell:init(datas.item_info, datas.types, sender)
		fwin:open(cell, fwin._windows)
	elseif datas.item_type == 13 then
		local cell = smHeroInformation:new()
		cell:init(datas.item_info, sender , datas.table)
		fwin:open(cell, fwin._windows)
	end
end

-- 星级-------------需要干掉
function SmItemIconCell:updateStarInfo( bounty_hero_param_id )
	local root = self.roots[1]
	local Panel_star = ccui.Helper:seekWidgetByName(root,"Panel_star")
	if Panel_star ~= nil then
		if bounty_hero_param_id ~= nil then
			local rewards = dms.string(dms["bounty_hero_param"], bounty_hero_param_id, bounty_hero_param.rewards)
			if rewards ~= nil then
				rewards = zstring.split(rewards, ",")
				if zstring.tonumber(rewards[4]) > 0 then
					Panel_star:removeAllChildren(true)
					neWshowShipStar(Panel_star, zstring.tonumber(rewards[4]))
				end
			end
		else
			Panel_star:removeAllChildren(true)
		end
	end
end

function SmItemIconCell:onInit()
	local root = nil
	root = cacher.createUIRef("icon/item.csb", "root")
	root:removeFromParent(false)
	self:setContentSize(ccui.Helper:seekWidgetByName(root, "Panel_prop_box"):getContentSize())
	self:addChild(root)
	table.insert(self.roots, root)

	if SmItemIconCell.__size == nil then
		SmItemIconCell.__size = root:getContentSize()
	end
	if root._x == nil then
		root._x = 0
	end
	if root._y == nil then
		root._x = 0
	end
	self:clearUIInfo()
	self:onUpdateDraw()

	if self.showTip == true then 
		--弹出提示 
		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_prop"), nil, 
		{
			terminal_name = "sm_item_icon_cell_show_prop_info", 
			terminal_state = 0, 
			_prop = self.item[1],
			_id = self.item[2],
		},
		nil,0)
	else
		if self.isLongTouch == true then
			local Panel_prop = ccui.Helper:seekWidgetByName(root, "Panel_prop")
			local function rewardTouchCallback(sender, eventType)
		        if eventType == ccui.TouchEventType.began then
		        	if sender._self ~= nil and sender._self.roots ~= nil and sender._self.roots[1] ~= nil and sender._self.isLongTouch == true then
			        	sender:runAction(cc.Sequence:create(cc.DelayTime:create(0.5),cc.CallFunc:create((function ( sender )
			        		if sender._self ~= nil and sender._self.roots ~= nil and sender._self.roots[1] ~= nil and sender._self.isLongTouch == true then
								local cell = sender._self
								cell:showIconInfo(sender._datas ,sender)     
							end
	                    end))))
			        end
				elseif eventType == ccui.TouchEventType.moved then
				elseif eventType == ccui.TouchEventType.ended 
					or eventType == ccui.TouchEventType.canceled
					then
					sender:stopAllActions()
					local datas = sender._datas
					if tonumber(datas.item_type) == 1 
						or tonumber(datas.item_type) == 2
						or tonumber(datas.item_type) == 3
						or tonumber(datas.item_type) == 8
						or tonumber(datas.item_type) == 18
						or tonumber(datas.item_type) == 34
						then
						fwin:close(fwin:find("propMoneyInfoClass"))
					elseif tonumber(datas.item_type) == 6
						or tonumber(datas.item_type) == 7 
						then
						fwin:close(fwin:find("propInformationClass"))
					elseif tonumber(datas.item_type) == 13 then
						fwin:close(fwin:find("smHeroInformationClass"))
					end
				end
		    end
			if nil ~= Panel_prop then
				Panel_prop._self = self
				Panel_prop:addTouchEventListener(rewardTouchCallback)
				Panel_prop:setSwallowTouches(false)
				local info = nil
			    local table = {}
			    local types = 0
			    if zstring.tonumber(self.item[1]) == 6 then
			    	info = {user_prop_template = self.item[2], prop_number = zstring.tonumber(self.item[3])}
			    	types = 1
			    elseif zstring.tonumber(self.item[1]) == 7 then
			    	local equipmentData = dms.element(dms["equipment_mould"] , self.item[2])
			    	local quality = dms.atoi(equipmentData, equipment_mould.grow_level)
			    	if self.table ~= nil and self.table.equipQuality ~= nil then
			    		quality = dms.atoi(equipmentData, equipment_mould.trace_npc_index)
			    	end
			    	local name = smEquipWordlFundByIndex( self.item[2] , 1)
			    	info = {user_prop_template = self.item[2], mould_id = self.item[2] ,equipment_quality = quality,mould_name = name}
			    	types = 2
			    elseif zstring.tonumber(self.item[1]) == 13 then
				    if info == nil then
				    	info = self.item[2]
				    	if self.table ~= nil and self.table.shipStar ~= nil then
				    		table = self.table
				    	end
				    end
			    else
			    	info = zstring.tonumber(self.item[1])
			    end
			    
			    Panel_prop._datas = {
					item_type = tonumber(self.item[1]),
					item_info = info,
					types = tonumber(types),
					table = table,
				}
			end
		else
			fwin:removeTouchEventListener(Panel_prop)
		end
	end
end

-- 选中框
function SmItemIconCell:setChooseSelectState( isChoose )
	local root = self.roots[1]
	if root == nil then
		return
	end
	local Image_xuanzhong = ccui.Helper:seekWidgetByName(root, "Image_xuanzhong")
	if Image_xuanzhong ~= nil then
    	Image_xuanzhong:setVisible(isChoose)
    end
end

-- 双倍
function SmItemIconCell:setActivityDouble( isShow )
	local root = self.roots[1]
	if root == nil then
		return
	end
	local Image_double = ccui.Helper:seekWidgetByName(root, "Image_double")
	if Image_double ~= nil then
    	Image_double:setVisible(isShow)
    end
end

function SmItemIconCell:clearUIInfo( ... )
	local root = self.roots[1]
	if root == nil then
		return
	end
	if root._x ~= nil then
		root:setPositionX(root._x)
	end
	if root._y ~= nil then
		root:setPositionY(root._y)
	end
	local Label_l_order_level = ccui.Helper:seekWidgetByName(root,"Label_l-order_level")        
	local Label_name = ccui.Helper:seekWidgetByName(root,"Label_name")    
	local Label_quantity = ccui.Helper:seekWidgetByName(root,"Label_quantity") 
	local Label_shuxin = ccui.Helper:seekWidgetByName(root,"Label_shuxin") 
	local Panel_prop = ccui.Helper:seekWidgetByName(root,"Panel_prop") 
	local Panel_kuang = ccui.Helper:seekWidgetByName(root,"Panel_kuang") 
	local Panel_ditu = ccui.Helper:seekWidgetByName(root,"Panel_ditu") 
	local Panel_star = ccui.Helper:seekWidgetByName(root,"Panel_star") 
	local Panel_props_right_icon = ccui.Helper:seekWidgetByName(root,"Panel_props_right_icon") 
	local Panel_props_left_icon = ccui.Helper:seekWidgetByName(root,"Panel_props_left_icon") 
	local Panel_num = ccui.Helper:seekWidgetByName(root,"Panel_num") 
	local Text_1 = ccui.Helper:seekWidgetByName(root,"Text_1") 
	local Image_26 = ccui.Helper:seekWidgetByName(root,"Image_26") 
	local Image_item_vip = ccui.Helper:seekWidgetByName(root,"Image_item_vip") 
	local Panel_4 = ccui.Helper:seekWidgetByName(root,"Panel_4") 
	local Image_bidiao = ccui.Helper:seekWidgetByName(root,"Image_bidiao") 
	local Image_dangqian = ccui.Helper:seekWidgetByName(root,"Image_dangqian") 
	local Image_nub2 = ccui.Helper:seekWidgetByName(root,"Image_nub2") 
	local Image_lock = ccui.Helper:seekWidgetByName(root,"Image_lock") 
	local Image_3 = ccui.Helper:seekWidgetByName(root, "Image_3")
	local Image_xuanzhong = ccui.Helper:seekWidgetByName(root, "Image_xuanzhong")
	local Image_2 = ccui.Helper:seekWidgetByName(root, "Image_2")
	local Image_double = ccui.Helper:seekWidgetByName(root, "Image_double")
	if Image_double ~= nil then
		Image_double:setVisible(false)
	end
	if Image_2 ~= nil then
		Image_2:setVisible(false)
	end
	if Image_3 ~= nil then
		Image_3:setVisible(false)
	end
	if Label_l_order_level ~= nil then 
		Label_l_order_level:setVisible(true)
		Label_l_order_level:setString("")
	end
	if Label_name ~= nil then
		Label_name:setString("")
		Label_name:setVisible(true)
		Label_name:setColor(cc.c3b(color_Type[1][1],color_Type[1][2],color_Type[1][3]))
	end
	if Label_quantity ~= nil then
		Label_quantity:setString("")
	end
	if Label_shuxin ~= nil then
		Label_shuxin:setString("")
	end
	if Panel_prop ~= nil then
		Panel_prop._self = nil
		Panel_prop._datas = nil
		Panel_prop:setVisible(true)
		Panel_prop:removeAllChildren(true)
		Panel_prop:removeBackGroundImage()
		Panel_prop:setSwallowTouches(false)
		fwin:removeTouchEventListener(Panel_prop)
	end
	if Panel_kuang ~= nil then
		Panel_kuang:setVisible(true)
		Panel_kuang:removeAllChildren(true)
		Panel_kuang:removeBackGroundImage()
	end
	if Panel_ditu ~= nil then
		Panel_ditu:setVisible(true)
		Panel_ditu:removeAllChildren(true)
		Panel_ditu:removeBackGroundImage()
	end
	if Panel_star ~= nil then
		Panel_star:setVisible(true)
		Panel_star:removeAllChildren(true)
		Panel_star:removeBackGroundImage()
	end
	if Panel_props_right_icon ~= nil then
		Panel_props_right_icon:setVisible(true)
		Panel_props_right_icon:removeAllChildren(true)
		Panel_props_right_icon:removeBackGroundImage()
	end
	if Panel_props_left_icon ~= nil then
		Panel_props_left_icon:setVisible(true)
		Panel_props_left_icon:removeAllChildren(true)
		Panel_props_left_icon:removeBackGroundImage()
	end
	if Panel_num ~= nil then
		Panel_num:setVisible(true)
		Panel_num:removeAllChildren(true)
		Panel_num:removeBackGroundImage()
	end
	if Panel_4 ~= nil then
		Panel_4:setVisible(true)
		Panel_4:removeAllChildren(true)
		Panel_4:removeBackGroundImage()
	end
	if Text_1 ~= nil then
		Text_1:setVisible(true)
		Text_1:setString("")
	end
	if Image_xuanzhong ~= nil then
		Image_xuanzhong:setVisible(true)
		Image_xuanzhong:setVisible(false)
	end
end

function SmItemIconCell:onExit()
	local root = self.roots[1]
	self:clearUIInfo()
	cacher.freeRef("icon/item.csb", root)
end

--为防止参数项过多，第7个定义为table类型，想要什么可以往里面加 
--interfaceType:使用类型
--item：道具信息（{type, mouldid, num}）
--isShowName：是否显示名字
--isShowCount：是否显示数量
--showTip：是否弹出提示
--isLongTouch：是否长按出提示
--table解析
--table.shipStar --战船星级
--table.equipQuality -- 装备品质，不填为初始品质，填则为显示品质		
function SmItemIconCell:init(interfaceType, item, isShowName, isShowCount, showTip, isLongTouch, table)
	self.current_type = zstring.tonumber(interfaceType)
	self.item = item
	self.isShowName = isShowName
	self.isShowCount = isShowCount
	self.showTip = showTip
	self.isLongTouch = isLongTouch
	self.table = table or {}
	self:onInit()
	self:setContentSize(SmItemIconCell.__size)
end

function SmItemIconCell:reload()
	local root = self.roots[1]
	if root ~= nil then
		return
	end
	self:onInit()
end

function SmItemIconCell:unload()
    local root = self.roots[1]
	if root == nil then
		return
	end
	self:clearUIInfo()
	cacher.freeRef("icon/item.csb", root)
	root:removeFromParent(false)
	self.roots = {}
end

