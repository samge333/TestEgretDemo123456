----------------------------------------------------------------------------------------------------
-- 说明：的小图标绘制
-- 物品1类型：
--	1:银币 
--	2:金币 
--	3:声望 
--	4:将魂 
--	5:魂玉 
--	6:道具 
--	7:装备 
--	8:经验 
--	9:耐力 
--	10:功能点 
--	11:上阵人数 
--	12:体力
--	13:武将 
--	14:竞技场排名
-------------------------------------------------------------------------------------------------------
ResourcesIconCell = class("ResourcesIconCellClass", Window)
ResourcesIconCell.__size = nil
ResourcesIconCell.__big_size = nil

function ResourcesIconCell:ctor()
    self.super:ctor()

    -- 定义封装类中的变量
	self.roots = {}		-- 界面中的UI根节点，供模块获取界面中的UI元素实例
	self.prop = nil		-- 当前要绘制的道具实例数据对对象
	self.propName = "" --道具名称
	self.showTip = false --是否弹出提示
	self.isLongTouch = nil -- 长按弹出信息
	self.quality = 0 -- 品质
	self.enum_type = {
		SILVER_COIN_INFORMATION = 1,				-- 	1:银币
		GOLD_COIN_INFORMATION = 2,					--	2:金币 
		REPUTATION_INFORMATION = 3,					--	3:声望 
		HERO_SOUL_INFORMATION = 4,					--	4:将魂 
		SOUL_JADE_INFORMATION = 5,					--	5:魂玉 
		PROP_INFORMATION = 6,						--	6:道具 
		EQUIPMENT_INFORMATION = 7,					--	7:装备 
		EXPERIENCE_INFORMATION = 8,					--	8:经验 
		ENDURANCE_INFORMATION = 9,					--	9:耐力 
		FUNCTION_INFORMATION = 10,					--	10:功能点 
		BATTLE_NUMBER_PEOPLE_INFORMATION = 11,		--	11:上阵人数 
		PHYSICAL_STRENGTH_INFORMATION = 12,			--	12:体力
		HERO_INFORMATION = 13,						--	13:武将 
		AREAN_RANK_INFORMATION = 14,				--	14:竞技场排名
		DPS_INFORMATION = 15,						--	15:伤害
		DUEL_INFORMATION = 16,						--	16:比武积分
		POWER_INFORMATION = 17,						--	17:霸气
		GLORIES_INFORMATION= 18,					--	18:威名
		DAILYTASK_SCORE_INFORMATION = 19,			--	19:日常任务积分
		FEATS_INFORMATION = 20,						--	20:功勋
		BATTLE_ACHIEVEMENT_INFORMATION = 21,		--	21:战功
		RECHARGE_SHOP_INFORMATION = 22,				--	22:充值商店
		UNION_CONTRIBUTION = 28,             		--  28:军团贡献
		WAR_INFORMATION = 31,             			--  31:战神令
		PET_SOUL_INFORMATION = 33,             		--  33:驯兽魂
		TALENT_POINT = 34,             				--  34:天赋点

		VIP_EXPERIENCE = 39,             				--  39:VIP经验
	}
	-- images/face/prop_head/props_%d.png
	self.res_data = {
		{0,"images/ui/props/props_4002.png", _All_tip_string_info._fundName},				-- 	1:银币
		{4,"images/ui/props/props_4001.png", _All_tip_string_info._crystalName},			-- 	2:金币 
		{3,"images/ui/props/props_4004.png", _All_tip_string_info._reputation},--  3:声望 
		{4,"images/ui/props/props_4007.png", _All_tip_string_info._hero},			-- 	4:将魂 
		{3,"images/ui/props/props_3000.png", _All_tip_string_info._juexingsuipian},			-- 	5:魂玉 (水雷魂)
		{0,"images/ui/props/props_2134.png", " "},				-- 	6:道具
		{0,"images/ui/props/props_2142.png", " "},				-- 	7:装备 
		{4,"images/ui/props/props_4003.png", reward_prop_list[8]},				-- 	8:经验
		{0,"images/ui/props/props_3030.png", " "},				-- 	9:耐力 
		{0,"images/ui/props/props_3315.png", " "},				-- 	10:功能点
		{0,"images/ui/props/props_20123.png", " "},				-- 	11:上阵人数 
		{4,"images/ui/props/props_4005.png", _All_tip_string_info._energyName},					--	12:体力
		{0,"images/ui/button/diaoluo_wujiang_small.png", " "},	-- 	13:武将 
		{0,"images/ui/button/icon_pj_paihangbang.png", " "},	-- 	14:竞技场排名
		{0,"images/ui/button/icon_pj_paihangbang.png", " "},	-- 	15:伤害 
		{0,"images/ui/button/icon_pj_paihangbang.png", " "},	-- 	16:比武积分 
		{0,"images/ui/button/icon_pj_paihangbang.png", " "},	-- 	17:霸气 
		{0,"images/ui/props/props_4006.png", _All_tip_string_info._glories},	-- 	18:威名 
		{0,"images/ui/button/icon_pj_paihangbang.png", " "},	-- 	19:日常任务积分 
		{0,"images/ui/icon/icon_juntuan.png", " "},				-- 	20:功勋 
		{0,"images/ui/icon/icon_zhangong.png", " "},			-- 	21:战功
		{4," ", " "},											-- 	22:日常副本基本奖励
		{4," ", " "},											-- 	23:日常副本额外奖励
		{4," ", " "},											-- 	24:出击令
		{4," ", " "},											-- 	25:免战
		{4," ", " "},											-- 	26:
		{4," ", " "},											-- 	27:
		{0,"images/ui/props/props_4013.png", _All_tip_string_info._union_exploit},			-- 	28:军团贡献
		{4," ", " "},											-- 	29
		{4," ", " "},											-- 	30
		{0,"images/ui/props/props_4016.png", ""},				-- 	31
		{0,"", ""},				-- 	32
		{4,"images/ui/props/props_3088.png", _my_gane_name[14]},				-- 	33:驯兽魂
		{4,"images/ui/props/props_4008.png", _my_gane_name[15]},				-- 	34:天赋点
		{3,"", ""},				-- 	35
		{3,"", ""},				-- 	36
		{3,"", ""},				-- 	37
		{3,"", ""},				-- 	38
		{4,"images/ui/props/props_4039.png", _my_gane_name[17]},				-- 	39 VIP经验
	}
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		self.res_data[28] = {3,"images/ui/props/props_4013.png", _All_tip_string_info._union_exploit}
		self.res_data[63] = {4,"images/ui/props/props_4063.png", _my_gane_name[16]}
		for i , v in pairs(_props_image_name) do 
			if v ~= nil and v ~= "" then
				local infor = zstring.split(v , ",")
				if self.res_data[i] ~= nil then
					self.res_data[i][1] = tonumber(infor[2])
				end
			end
		end
	end
	self.rewardType = nil
	self.current_type = 0
	self.item_count = 0
	self.mould_id = nil
	app.load("client.cells.prop.prop_money_info")
	app.load("client.cells.prop.prop_information")
	app.load("client.cells.prop.sm_hero_information")
	local function init_resource_icon_cell_terminal()
		local prop_money_icon_cell_show_info_terminal = {
            _name = "resource_icon_cell_show_info",
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
		local resource_icon_cell_show_prop_info_terminal = {
            _name = "resource_icon_cell_show_prop_info",
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
        state_machine.add(resource_icon_cell_show_prop_info_terminal)
		state_machine.add(prop_money_icon_cell_show_info_terminal)
        state_machine.init()
	end
	init_resource_icon_cell_terminal()

end

function ResourcesIconCell:onDrawIconPad(quality)
	local root = self.roots[1]
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		local Panel_ditu = ccui.Helper:seekWidgetByName(root, "Panel_ditu")   		--底图
		if Panel_ditu ~= nil then
			Panel_ditu:removeBackGroundImage()
			Panel_ditu:setVisible(true)
			Panel_ditu:setBackGroundImage(string.format("images/ui/quality/icon_enemy_%d.png", quality+1))
		end
	else
		local Panel_kuang = ccui.Helper:seekWidgetByName(root, "Panel_kuang")
		Panel_kuang:setBackGroundImage(string.format("images/ui/quality/icon_enemy_%d.png", quality+1))
	end
end

function ResourcesIconCell:onDrawIconPad2(quality)
	--> print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz", quality)
	local root = self.roots[1]
	local Panel_ditu = ccui.Helper:seekWidgetByName(root, "Panel_ditu")   		--底图
	if Panel_ditu ~= nil then
		Panel_ditu:setVisible(true)
	end
	local Panel_kuang = ccui.Helper:seekWidgetByName(root, "Panel_kuang")

	if self.isBig == true then
		if __lua_project_id == __lua_project_digimon_adventure 
			or __lua_project_id == __lua_project_naruto 
			or __lua_project_id == __lua_project_pokemon 
			or __lua_project_id == __lua_project_rouge 
			or __lua_project_id == __lua_project_yugioh 
			then
			Panel_kuang:setBackGroundImage(string.format("images/ui/quality/icon_ditu_%d.png", quality))
		else
			if Panel_kuang ~= nil then
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					Panel_kuang:setBackGroundImage(string.format("images/ui/quality/icon_enemy_%d.png", quality))
				else
					Panel_kuang:setBackGroundImage(string.format("images/ui/quality/icon_bigkuang_%d.png", quality))
				end
			end
			local Image_2 = ccui.Helper:seekWidgetByName(root, "Image_2")
			if Image_2 ~= nil then
				Image_2:setVisible(false)
			end
		end
	else
		if __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			then
			self.panel_ditu = cc.Sprite:create(string.format("images/ui/quality/icon_enemy_%d.png", quality))
	        if self.panel_ditu ~= nil then
		        self.panel_ditu:setPosition(cc.p(Panel_ditu:getContentSize().width/2,Panel_ditu:getContentSize().height/2))
		        Panel_ditu:addChild(self.panel_ditu)
		    end
			-- Panel_ditu:setBackGroundImage(string.format("images/ui/quality/icon_enemy_%d.png", quality))
		else
			Panel_ditu:setBackGroundImage(string.format("images/ui/quality/icon_enemy_0.png"))
			Panel_kuang:setBackGroundImage(string.format("images/ui/quality/icon_enemy_%d.png", quality))
		end
	end
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		if self.current_type == self.enum_type.RECHARGE_SHOP_INFORMATION then
			Panel_ditu:setVisible(false)
		end
	end 
end

function ResourcesIconCell:getName()
	local root = self.roots[1]
	local nameCell = ccui.Helper:seekWidgetByName(root, "Label_name")--mingzi
	ccui.Helper:seekWidgetByName(root, "Label_name"):setVisible(true)
	return nameCell
end

function ResourcesIconCell:showName(id,types)
	local root = self.roots[1]
	local nameCell = ccui.Helper:seekWidgetByName(root, "Label_name")--mingzi
	ccui.Helper:seekWidgetByName(root, "Label_name"):setVisible(true)
	local Image_26 = ccui.Helper:seekWidgetByName(root, "Image_26")
	local quality = nil
	local name = nil
	if tonumber(id) == -1 then
		if types == 1 then		--金钱
			name = _All_tip_string_info._fundName
			quality = 3
		elseif types == 2 then		--转世
			name = _All_tip_string_info._crystalName
			if __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				then
				quality = 3
			else
				quality = 5
			end
		elseif types == 5 then			--魂玉
			name = _All_tip_string_info._soulName
			if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
				or __lua_project_id == __lua_project_rouge then 
				quality = 4
			else
				quality = 5
			end
		elseif types == 8 then
			quality = 4
			name = reward_prop_list[8]
		elseif types == 18 then			--威名
			quality = 5
			name = _All_tip_string_info._glories
		elseif types == 3 then			--声望
			quality = 4
			name = _All_tip_string_info._reputation
		elseif types == 31 then
			quality = 4
			name = red_alert_resouce_tip[1][1]
		elseif types == 33 then 
			quality = 4
			name = _my_gane_name[14]
		elseif types == 34 then 
			quality = 3
			name = _my_gane_name[15]
		elseif types == 4 then  --数码魂
			quality = 4
			name = _All_tip_string_info._hero
		elseif types == 63 then
			quality = 4
			name = _my_gane_name[16]
		end
	else
		if types == self.enum_type.PROP_INFORMATION then
			quality = dms.int(dms["prop_mould"], id, prop_mould.prop_quality)+1
			name = dms.string(dms["prop_mould"], id, prop_mould.prop_name)
			if __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				then
				name = setThePropsIcon(id)[2]
			end
			if dms.int(dms["prop_mould"], id, prop_mould.change_of_equipment) ~= 0 then
				if Image_26 ~= nil then
					Image_26:setVisible(true)
				end
			elseif dms.int(dms["prop_mould"], id,  prop_mould.use_of_ship) ~= 0 then
				if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto 
					or __lua_project_id == __lua_project_pokemon 
					or __lua_project_id == __lua_project_rouge 
					or __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  
					or __lua_project_id == __lua_project_yugioh 
					or __lua_project_id == __lua_project_warship_girl_b 
					then 
					--觉醒道具不显示碎片图标
					if dms.int(dms["prop_mould"], id,  prop_mould.props_type) == 16 then 
						if Image_26 ~= nil then
							Image_26:setVisible(false)
						end
					else
						if Image_26 ~= nil then
							Image_26:setVisible(true)
						end
					end
				else
					if Image_26 ~= nil then
						Image_26:setVisible(true)
					end
				end
				if __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				then
				    local footerData = dms.string(dms["prop_mould"], id, prop_mould.trace_remarks)
				    local footerInfo = zstring.split(footerData ,",")
				    --碎片标识
				    local Panel_props_left_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_left_icon")
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
				    local Panel_props_right_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_right_icon")
				    if Panel_props_right_icon ~= nil then
					    Panel_props_right_icon:removeAllChildren(true)
					    if footerInfo[2] ~= nil and tonumber(footerInfo[2])~= -1 then
					        local props_right_icon = cc.Sprite:create(string.format("images/ui/icon/icon_%d.png", tonumber(footerInfo[2])))
					        if props_right_icon ~= nil then
						        props_right_icon:setPosition(cc.p(Panel_props_right_icon:getContentSize().width/2,Panel_props_right_icon:getContentSize().height/2))
						        Panel_props_right_icon:addChild(props_right_icon)
						    end
					    end
					end
			    end
			end
		elseif types == self.enum_type.EQUIPMENT_INFORMATION then
			quality = dms.int(dms["equipment_mould"], id, equipment_mould.grow_level)+1
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--获取装备名称索引
				local nameindex = dms.int(dms["equipment_mould"], id, equipment_mould.equipment_name)
				--通过索引找到word_mould
				local word_info = dms.element(dms["word_mould"], nameindex)
				local names = word_info[3]
				--绘制
				name = names
				if self.table ~= nil and self.table.equipQuality ~= nil then
					quality = dms.int(dms["equipment_mould"], id, equipment_mould.trace_npc_index)+1
				end
			else
				name = dms.string(dms["equipment_mould"], id, equipment_mould.equipment_name)
			end
		elseif types == self.enum_type.HERO_INFORMATION then
			quality = dms.int(dms["ship_mould"], id, ship_mould.ship_type)+1
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--进化形象
				local evo_image = dms.string(dms["ship_mould"], id, ship_mould.fitSkillTwo)
				local evo_info = zstring.split(evo_image, ",")
				--进化模板id
				-- local ship_evo = zstring.split(hero.evolution_status, "|")
				local evo_mould_id = evo_info[dms.int(dms["ship_mould"], id, ship_mould.captain_name)]
				local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
				local word_info = dms.element(dms["word_mould"], name_mould_id)
				name = word_info[3]
			else
				name = dms.string(dms["ship_mould"],id, ship_mould.captain_name)
			end
		end
	end

	if nameCell ~= nil then
		nameCell:setColor(cc.c3b(color_Type[quality][1],color_Type[quality][2],color_Type[quality][3]))
		nameCell:setString(name)
	end
	return name
end

function ResourcesIconCell:onUpdateDraw()
	local root = self.roots[1]
	local Panel_prop_box = ccui.Helper:seekWidgetByName(root, "Panel_prop_box")
	local Image_2 = ccui.Helper:seekWidgetByName(root, "Image_2")
	self.size = root:getContentSize()
	
	local Panel_prop = ccui.Helper:seekWidgetByName(root, "Panel_prop")
	Panel_prop:removeBackGroundImage()
	local item_order_level = ccui.Helper:seekWidgetByName(root, "Label_l-order_level")--右下角等级
	local name = ccui.Helper:seekWidgetByName(root, "Label_name")--mingzi
	self:setContentSize(self.size)
	if Image_2 ~= nil then
		Image_2:setSwallowTouches(false)
	end
	local quality = nil
	local count = 0
	
	--1:银币 2:金币 3:声望 4:将魂 5:魂玉 6:道具 7:装备 8:经验 9:耐力 10:功能点 11:上阵人数 12:体力 13:武将 14竞技场排名
	--15:伤害 16:比武积分 17:霸气 18 威名 19 日常任务积分 20功勋 21战功 33 驯兽魂
	--> print("00000000000001111111111",self.rewardType)
	for i, v in pairs(self.rewardType.show_reward_list) do
		-- if (tonumber(v.prop_type) == 6 and tonumber(v.item_value) > 0)
			-- or (tonumber(v.prop_type) == 7 and tonumber(v.item_value) > 0) 
			-- or (tonumber(v.prop_type) == 13 and tonumber(v.item_value) > 0) 
			-- or (tonumber(v.prop_type) == 17 and tonumber(v.item_value) > 0) 
			-- then
			-- (1:银币 2:金币 3:声望 4:将魂 5:魂玉 6:道具 7:装备 8:武将 9:鬼道 10: 决斗荣誉)
		if true then
			-- local cell = createRewardItem(v)
			if v.prop_type == -1 then
			
			elseif tonumber(v.prop_type) ==1 and tonumber(v.item_value) > 0 then	--银币
				quality = 0
				if __lua_project_id == __lua_project_l_digital 
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					then
					self.panel_prop = cc.Sprite:create(self.res_data[1][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[1][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[1])
			elseif tonumber(v.prop_type) ==2 and tonumber(v.item_value) > 0 then	--金币
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[2][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[2][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[2])
			elseif tonumber(v.prop_type) ==3 and tonumber(v.item_value) > 0 then	--声望
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[3][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[3][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[3])
			elseif tonumber(v.prop_type) ==4 and tonumber(v.item_value) > 0 then	--将魂
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[4][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[4][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[5])
			elseif tonumber(v.prop_type) ==5 and tonumber(v.item_value) > 0 then	--魂玉
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[5][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[5][2])
				end
				count = v.item_value
			elseif tonumber(v.prop_type) ==8 and tonumber(v.item_value) > 0 then	--经验
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[8][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[8][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[7])
			elseif tonumber(v.prop_type) ==9 and tonumber(v.item_value) > 0 then	--耐力
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[9][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[9][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[9])
			elseif tonumber(v.prop_type) ==10 and tonumber(v.item_value) > 0 then	--功能点
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[10][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[10][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[10])
			elseif tonumber(v.prop_type) ==12 and tonumber(v.item_value) > 0 then	--体力
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[12][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[12][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[8])
			elseif tonumber(v.prop_type) ==18 and tonumber(v.item_value) > 0 then	--威名
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[18][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[18][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[6])
				
			elseif tonumber(v.prop_type) ==20 and tonumber(v.item_value) > 0 then	--功勋
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:createshow_reward_list(self.res_data[20][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[20][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[11])
				
			elseif tonumber(v.prop_type) ==21 and tonumber(v.item_value) > 0 then	--战功
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[21][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[21][2])
				end
				count = v.item_value
			elseif tonumber(v.prop_type) ==28 and tonumber(v.item_value) > 0 then	--军团贡献
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[28][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[28][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[13])
			elseif tonumber(v.prop_type) ==31 and tonumber(v.item_value) > 0 then	--战神令
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[31][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[31][2])
				end
				count = v.item_value
				name:setString(red_alert_resouce_tip[1][1])		
			elseif tonumber(v.prop_type) ==6 and tonumber(v.item_value) > 0 then	--道具
				quality = dms.int(dms["prop_mould"], v.prop_item, prop_mould.prop_quality)
				local icon_index = dms.int(dms["prop_mould"], v.prop_item, prop_mould.pic_index)
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					icon_index = setThePropsIcon(v.prop_item)[1]
					self.panel_prop = cc.Sprite:create(string.format("images/ui/props/props_%d.png", icon_index))
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)

				        local sell_tag = dms.int(dms["prop_mould"], v.prop_item, prop_mould.sell_tag)
						if sell_tag == 3 then
							local effect_paths = string.format(config_res.images.ui.effice.effect_quality_box, 1, 1)
							if cc.FileUtils:getInstance():isFileExist(effect_paths) == true then
								ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(effect_paths)
								local armature = ccs.Armature:create("effect_quality_box_1")
								draw.initArmature(armature, nil, -1, 0, 1)
								armature:setPosition(cc.p(Panel_prop:getContentSize().width/2, Panel_prop:getContentSize().height/2))
								Panel_prop:addChild(armature)
							end
						end
				    end
				else
					Panel_prop:setBackGroundImage(string.format("images/ui/props/props_%d.png", icon_index))
				end
				count = v.item_value
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					name:setString(setThePropsIcon(v.prop_item)[2])
				else
					name:setString(dms.string(dms["prop_mould"], v.prop_item, prop_mould.prop_name))
				end
				name:setColor(cc.c3b(color_Type[quality+1][1],color_Type[quality+1][2],color_Type[quality+1][3]))
				local Image_26 = ccui.Helper:seekWidgetByName(root, "Image_26")
				if Image_26 ~= nil then
					if dms.int(dms["prop_mould"], v.prop_item, prop_mould.change_of_equipment) ~= 0 then
						Image_26:setVisible(true)
					elseif dms.int(dms["prop_mould"], v.prop_item,  prop_mould.use_of_ship) ~= 0 then
						Image_26:setVisible(true)
					end
				end
				self.propName = dms.string(dms["prop_mould"], v.prop_item, prop_mould.prop_name)
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					local footerData = dms.string(dms["prop_mould"], v.prop_item, prop_mould.trace_remarks)
				    local footerInfo = zstring.split(footerData ,",")
				    --碎片标识
				   
				    local Panel_props_left_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_left_icon")
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
				    local Panel_props_right_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_right_icon")
				    if Panel_props_right_icon ~= nil then
					    Panel_props_right_icon:removeAllChildren(true)
					    if footerInfo[2] ~= nil and tonumber(footerInfo[2])~= -1 then
					        local props_right_icon = cc.Sprite:create(string.format("images/ui/icon/icon_%d.png", tonumber(footerInfo[2])))
					        if props_right_icon ~= nil then
						        props_right_icon:setPosition(cc.p(Panel_props_right_icon:getContentSize().width/2,Panel_props_right_icon:getContentSize().height/2))
						        Panel_props_right_icon:addChild(props_right_icon)
						    end
					    end
					end
			    end

			elseif tonumber(v.prop_type) ==7 and tonumber(v.item_value) > 0 then	--装备
				quality = dms.int(dms["equipment_mould"], v.prop_item, equipment_mould.grow_level)
				local icon_index = dms.int(dms["equipment_mould"], v.prop_item, equipment_mould.pic_index)
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(string.format("images/ui/props/props_%d.png", icon_index))
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(string.format("images/ui/props/props_%d.png", icon_index))
				end
				count = v.item_value
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					--获取装备名称索引
					local nameindex = dms.int(dms["equipment_mould"], item_mouldid, equipment_mould.equipment_name)
					--通过索引找到word_mould
					local word_info = dms.element(dms["word_mould"], nameindex)
					local names = word_info[3]
					--绘制
					name:setString(names)
					name:setColor(cc.c3b(color_Type[1][1],color_Type[1][2],color_Type[1][3]))
				else
					name:setString(dms.string(dms["equipment_mould"], v.prop_item, equipment_mould.equipment_name))
					name:setColor(cc.c3b(color_Type[quality+1][1],color_Type[quality+1][2],color_Type[quality+1][3]))
				end	
			elseif tonumber(v.prop_type) == 13 and tonumber(v.item_value) > 0 then	--武将
				quality = dms.int(dms["ship_mould"], v.prop_item, ship_mould.ship_type)
				--> print("self.mould_id----------------------------",self.mould_id)
				local icon_index = dms.int(dms["ship_mould"], v.prop_item, ship_mould.head_icon)
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(string.format("images/ui/props/props_%d.png", icon_index))
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(string.format("images/ui/props/props_%d.png", icon_index))
				end
				count = v.item_value
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					--进化形象
					local evo_image = dms.string(dms["ship_mould"], v.prop_item, ship_mould.fitSkillTwo)
					local evo_info = zstring.split(evo_image, ",")
					--进化模板id
					-- local ship_evo = zstring.split(hero.evolution_status, "|")
					local evo_mould_id = evo_info[dms.int(dms["ship_mould"], v.prop_item, ship_mould.captain_name)]
					local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
					local word_info = dms.element(dms["word_mould"], name_mould_id)
					_name = word_info[3]
					name:setString(_name)
					quality = shipOrEquipSetColour(dms.int(dms["ship_mould"], v.prop_item, ship_mould.initial_rank_level))-1
				else
					name:setString(dms.string(dms["ship_mould"], v.prop_item, ship_mould.captain_name))
				end
				name:setColor(cc.c3b(color_Type[quality+1][1],color_Type[quality+1][2],color_Type[quality+1][3]))
			elseif tonumber(v.prop_type) == 33 and tonumber(v.item_value) > 0 then	--驯兽魂
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[33][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[33][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[14])
			elseif tonumber(v.prop_type) == 34 and tonumber(v.item_value) > 0 then	
				quality = 0
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[34][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[34][2])
				end
				count = v.item_value
				name:setString(_my_gane_name[15])
			elseif tonumber(v.prop_type) == 39 and tonumber(v.item_value) > 0 then	
				quality = 4
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(self.res_data[39][2])
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(self.res_data[39][2])
				end
				count = v.item_value
				name:setString(self.res_data[39][3])
			elseif tonumber(v.prop_type) == 63 and tonumber(v.item_value) > 0 then	--活跃度
				quality = 0
				self.panel_prop = cc.Sprite:create(self.res_data[63][2])
		        if self.panel_prop ~= nil then
			        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
			        Panel_prop:addChild(self.panel_prop)
			    end
				count = v.item_value
				name:setString(_my_gane_name[16])
			end

			-- Panel_prop:setBackGroundImage(self.res_data[self.current_type][2])
			if quality ~= nil then
				self:onDrawIconPad(quality)
			end
			-- if  tonumber(count) >= 100000000 then
			-- 	item_order_level:setString("x"..math.floor(count / 100000000) .. string_equiprety_name[39])
			-- else
			if tonumber(count) >= 10000 then
				item_order_level:setString("x"..math.floor(count / 1000) .. string_equiprety_name[40])
			else
				item_order_level:setString("x"..count)
			end
		end
	end
	
end

function ResourcesIconCell:onUpdateDraw2()
	local root = self.roots[1]
	local Panel_prop_box = ccui.Helper:seekWidgetByName(root, "Panel_prop_box")
	local Image_2 = ccui.Helper:seekWidgetByName(root, "Image_2")
	self.size = root:getContentSize()
	local Panel_prop = ccui.Helper:seekWidgetByName(root, "Panel_prop")
	Panel_prop:removeBackGroundImage()
	self:setContentSize(self.size)
	if Image_2 ~= nil then
		Image_2:setSwallowTouches(false)
	end
	local quality = self.res_data[self.current_type][1]  --判断显示哪个底框
	if self.mould_id == -1 then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			self.panel_prop = cc.Sprite:create(self.res_data[self.current_type][2])
	        if self.panel_prop ~= nil then
		        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
		        Panel_prop:addChild(self.panel_prop)
		    end
		else
			Panel_prop:setBackGroundImage(self.res_data[self.current_type][2])  -- 判断显示那个底图
		end
		self:onDrawIconPad2(quality+1)
		self.propName = self.res_data[self.current_type][3]
		self.quality = quality+1
	else
		
		local path = "images/ui/props/props_%d.png"
		if self.isBig  == true then
			
			if __lua_project_id == __lua_project_gragon_tiger_gate 
				or __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				path = "images/ui/reward/cz_tubiao_%d.png"
				--path = "images/ui/props/props_%d.png"
				local Image_2 = ccui.Helper:seekWidgetByName(root, "Image_2")
				if Image_2 ~= nil then
					Image_2:setVisible(false)
				end
			else
				if __lua_project_id == __lua_project_digimon_adventure 
					or __lua_project_id == __lua_project_naruto 
					or __lua_project_id == __lua_project_pokemon 
					or __lua_project_id == __lua_project_rouge 
					or __lua_project_id == __lua_project_yugioh 
					then 
					path = "images/ui/props/props_%d.png"
				else
					path = "images/face/prop_head/props_%d.png"
				end
			end
		end
		if self.current_type == self.enum_type.PROP_INFORMATION then
			quality = dms.int(dms["prop_mould"], self.mould_id, prop_mould.prop_quality)
			local icon_index = dms.int(dms["prop_mould"], self.mould_id, prop_mould.pic_index)
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				icon_index = setThePropsIcon(self.mould_id)[1]
				self.panel_prop = cc.Sprite:create(string.format(path, icon_index))
		        if self.panel_prop ~= nil then
			        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
			        Panel_prop:addChild(self.panel_prop)
			        
					local sell_tag = dms.int(dms["prop_mould"], self.mould_id, prop_mould.sell_tag)
					if sell_tag == 3 then
						local effect_paths = string.format(config_res.images.ui.effice.effect_quality_box, 1, 1)
						if cc.FileUtils:getInstance():isFileExist(effect_paths) == true then
							ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(effect_paths)
							local armature = ccs.Armature:create("effect_quality_box_1")
							draw.initArmature(armature, nil, -1, 0, 1)
							armature:setPosition(cc.p(Panel_prop:getContentSize().width/2, Panel_prop:getContentSize().height/2))
							Panel_prop:addChild(armature)
						end
					end
			    end
			else
				Panel_prop:setBackGroundImage(string.format(path, icon_index))
			end
			self.propName = dms.string(dms["prop_mould"],self.mould_id, prop_mould.prop_name)
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				self.propName = setThePropsIcon(self.mould_id)[2]
			end
			self.quality = quality
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				local footerData = dms.string(dms["prop_mould"], self.mould_id, prop_mould.trace_remarks)
			    local footerInfo = zstring.split(footerData ,",")
			    --碎片标识
			    local Panel_props_left_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_left_icon")
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
			    local Panel_props_right_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_right_icon")
			    if Panel_props_right_icon ~= nil then
				    Panel_props_right_icon:removeAllChildren(true)
				    if footerInfo[2] ~= nil and tonumber(footerInfo[2])~= -1 then
				        local props_right_icon = cc.Sprite:create(string.format("images/ui/icon/icon_%d.png", tonumber(footerInfo[2])))
				        if props_right_icon ~= nil then
					        props_right_icon:setPosition(cc.p(Panel_props_right_icon:getContentSize().width/2,Panel_props_right_icon:getContentSize().height/2))
					        Panel_props_right_icon:addChild(props_right_icon)
					    end
				    end
				end
		    end
		elseif self.current_type == self.enum_type.EQUIPMENT_INFORMATION then
			quality = dms.int(dms["equipment_mould"], self.mould_id, equipment_mould.grow_level)
			local icon_index = dms.int(dms["equipment_mould"], self.mould_id, equipment_mould.pic_index)
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				self.panel_prop = cc.Sprite:create(string.format(path, icon_index))
		        if self.panel_prop ~= nil then
			        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
			        Panel_prop:addChild(self.panel_prop)
			    end
			    if self.table ~= nil and self.table.equipQuality ~= nil then
					quality = dms.int(dms["equipment_mould"], self.mould_id, equipment_mould.trace_npc_index)
				end
			else
				Panel_prop:setBackGroundImage(string.format(path, icon_index))
			end
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--获取装备名称索引
				local nameindex = dms.int(dms["equipment_mould"], self.mould_id, equipment_mould.equipment_name)
				--通过索引找到word_mould
				local word_info = dms.element(dms["word_mould"], nameindex)
				local names = word_info[3]
				--绘制
				self.propName = names
			else
				self.propName = dms.string(dms["equipment_mould"],self.mould_id, equipment_mould.equipment_name)
			end
			self.quality = quality
		elseif self.current_type == self.enum_type.HERO_INFORMATION then
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--进化形象
				local evo_image = dms.string(dms["ship_mould"], self.mould_id, ship_mould.fitSkillTwo)
				local evo_info = zstring.split(evo_image, ",")
				--进化模板id
				-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
				local evo_mould_id = evo_info[dms.int(dms["ship_mould"], self.mould_id, ship_mould.captain_name)]
				picIndex = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(string.format(path, picIndex))
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(string.format(path, picIndex))
				end
				quality = shipOrEquipSetColour(dms.int(dms["ship_mould"], self.mould_id, ship_mould.initial_rank_level))-1
				self.quality = quality
				self.item_count = 0 -- 不显示等级

				local Panel_star = ccui.Helper:seekWidgetByName(root, "Panel_star")
				if Panel_star ~= nil then
					Panel_star:removeAllChildren(true)
				end
				local initStar = dms.int(dms["ship_mould"], self.mould_id, ship_mould.ship_star)
				if self.table.shipStar ~= nil then
					initStar = tonumber(self.table.shipStar)
				end
				if Panel_star ~= nil then
					neWshowShipStar(Panel_star , initStar)
				end
			else
				quality = dms.int(dms["ship_mould"], self.mould_id, ship_mould.ship_type)
				local icon_index = dms.int(dms["ship_mould"], self.mould_id, ship_mould.head_icon)
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					self.panel_prop = cc.Sprite:create(string.format(path, icon_index))
			        if self.panel_prop ~= nil then
				        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
				        Panel_prop:addChild(self.panel_prop)
				    end
				else
					Panel_prop:setBackGroundImage(string.format(path, icon_index))
				end
				self.quality = quality
			end
			
		elseif self.current_type == self.enum_type.RECHARGE_SHOP_INFORMATION then	--充值页面的图标
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				self.panel_prop = cc.Sprite:create(string.format(path, self.mould_id))
		        if self.panel_prop ~= nil then
			        self.panel_prop:setPosition(cc.p(Panel_prop:getContentSize().width/2,Panel_prop:getContentSize().height/2))
			        Panel_prop:addChild(self.panel_prop)
			    end
			else
				Panel_prop:setBackGroundImage(string.format(path, self.mould_id))
			end
			Panel_prop:setTouchEnabled(false)
			--print("图片下标",self.mould_id)
			if __lua_project_id == __lua_project_gragon_tiger_gate 
				or __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				ccui.Helper:seekWidgetByName(root, "Panel_kuang"):setVisible(false)
			end
		end
		self:onDrawIconPad2(quality+1)
	end
	if self.current_type == self.enum_type.RECHARGE_SHOP_INFORMATION then
	elseif self.item_count > 0 then
		local item_order_level = ccui.Helper:seekWidgetByName(root, "Label_l-order_level")--右下角等级
		item_order_level:setVisible(true)
		local strs = ""
		if self.isnumberX ~= nil then
			strs = ""
		else
			strs = "x"
		end
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			strs = ""
		end
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			-- if  self.item_count >= 100000000 then
			-- 	item_order_level:setString(strs..math.floor(self.item_count / 100000000) .. string_equiprety_name[39])
			-- else
			if self.item_count >= 10000 then
				item_order_level:setString(strs..math.floor(self.item_count / 1000) .. "k")
			else
				item_order_level:setString(strs..self.item_count)
			end
		else
			if self.item_count >= 100000000 then
				item_order_level:setString(strs..math.floor(self.item_count / 100000000) .. string_equiprety_name[39])
			elseif self.item_count >= 10000 then
				item_order_level:setString(strs..math.floor(self.item_count / 10000) .. "w")
			else
				item_order_level:setString(strs..self.item_count)
			end
		end
		
	end
end
	
function ResourcesIconCell:hideCount(isVisibel)
	local root = self.roots[1]
	local item_order_level = ccui.Helper:seekWidgetByName(root, "Label_l-order_level")
	item_order_level:setVisible(isVisibel)
end

function ResourcesIconCell:onEnterTransitionFinish()
end

function ResourcesIconCell:showIconInfo(datas ,sender)
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
		or datas.item_type == 28
		or datas.item_type == 34
		or datas.item_type == 12
		or datas.item_type == 39
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

function ResourcesIconCell:updateStarInfo( bounty_hero_param_id )
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

function ResourcesIconCell:onInit()
	local root = nil
	if __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
		then
		if self.isBig == true then
			root = cacher.createUIRef("icon/item.csb", "root")
		else
			root = cacher.createUIRef("icon/item.csb", "root")
		end
	else
		local csbItem = nil
		if self.isBig == true then
			csbItem = csb.createNode("icon/item.csb")
		else
			csbItem = csb.createNode("icon/item.csb")
		end
		root = csbItem:getChildByName("root")
	end
	root:removeFromParent(false)
	self:setContentSize(ccui.Helper:seekWidgetByName(root, "Panel_prop_box"):getContentSize())
	self:addChild(root)
	table.insert(self.roots, root)
	self:clearUIInfo()

	if self.isBig == true then
		if ResourcesIconCell.__big_size == nil then
			ResourcesIconCell.__big_size = root:getContentSize()
		end
	else
		if ResourcesIconCell.__size == nil then
			ResourcesIconCell.__size = root:getContentSize()
		end
	end

	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		local Panel_props_left_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_left_icon")
	    Panel_props_left_icon:removeAllChildren(true)

	    local Panel_props_right_icon = ccui.Helper:seekWidgetByName(root, "Panel_props_right_icon")
	    Panel_props_right_icon:removeAllChildren(true)

	    if root._x == nil then
	    	root._x = 0
	    	root:setPositionX(root._x)
	    end

	    if root._y == nil then
	    	root._y = 0
	    	root:setPositionY(root._y)
	    end
	end
	
	if self.rewardType ~= nil then
		self:onUpdateDraw()
	else
		self:onUpdateDraw2()
	end

	if self.current_type == 5 then
		if __lua_project_id ==__lua_project_digimon_adventure 
			or __lua_project_id == __lua_project_warship_girl_b 
			or __lua_project_id == __lua_project_pokemon 
			or __lua_project_id == __lua_project_rouge
			then
			--只显示兽魂 
			local Panel_prop = ccui.Helper:seekWidgetByName(root, "Panel_prop")
			fwin:addTouchEventListener(Panel_prop, nil, 
			{
				terminal_name = "resource_icon_cell_show_info", 
				terminal_state = 0, 
				_prop = self.current_type
			},
			nil,0)
			if nil ~= Panel_prop then
				Panel_prop:setSwallowTouches(false)
			end
		end
	end
	if self.showTip == true then 
		--弹出提示 
		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_prop"), nil, 
		{
			terminal_name = "resource_icon_cell_show_prop_info", 
			terminal_state = 0, 
			_prop = self.current_type,
			_id = self.mould_id,
		},
		nil,0)
	end

	local Panel_prop = ccui.Helper:seekWidgetByName(root, "Panel_prop")
	Panel_prop._self = self
	if self.isLongTouch == true then
		local function rewardTouchCallback(sender, eventType)
	        if eventType == ccui.TouchEventType.began then
	        	if sender._self ~= nil and sender._self.roots ~= nil and sender._self.roots[1] ~= nil and sender._self.isLongTouch == true then
		        	sender:runAction(cc.Sequence:create(cc.DelayTime:create(0.5),cc.CallFunc:create((function ( sender )
		        		if sender._self ~= nil and sender._self.roots ~= nil and sender._self.roots[1] ~= nil then
							local cell = sender._self
							cell:showIconInfo(sender._datas, sender)     
						end
                    end))))
		        end
			elseif eventType == ccui.TouchEventType.moved then
			elseif eventType == ccui.TouchEventType.ended 
				or eventType == ccui.TouchEventType.canceled
				then
				sender:stopAllActions()
				local datas = sender._datas
				if datas.item_type == 1 
					or datas.item_type == 2
					or datas.item_type == 3
					or datas.item_type == 8
					or datas.item_type == 12
					or datas.item_type == 18
					or datas.item_type == 28
					or datas.item_type == 34
					or datas.item_type == 39
					then
					fwin:close(fwin:find("propMoneyInfoClass"))
				elseif datas.item_type == 6
					or datas.item_type == 7 
					then
					fwin:close(fwin:find("propInformationClass"))
				elseif datas.item_type == 13 then
					fwin:close(fwin:find("smHeroInformationClass"))
				end
			end
	    end
	    Panel_prop:addTouchEventListener(rewardTouchCallback)
		if nil ~= Panel_prop then
			Panel_prop:setSwallowTouches(false)
		end

	    local info = nil
	    local table = {}
	    local types = 0
	    if self.current_type == 6 then
	    	info = {user_prop_template = self.mould_id, prop_number = tonumber(self.item_count)}
	    	types = 1
	    elseif self.current_type == 7 then
	    	local equipmentData = dms.element(dms["equipment_mould"] , self.mould_id)
	    	local quality = dms.atoi(equipmentData, equipment_mould.grow_level)
	    	if self.table ~= nil and self.table.equipQuality ~= nil then
	    		quality = dms.atoi(equipmentData, equipment_mould.trace_npc_index)
	    	end
	    	local name = smEquipWordlFundByIndex( self.mould_id , 1)
	    	info = {user_prop_template = self.mould_id, mould_id = self.mould_id ,equipment_quality = quality,mould_name = name}
	    	types = 2
	    elseif self.current_type == 13 then
	    	-- for i,v in pairs(_ED.user_ship) do
		    --     if _ED.recruit_success_ship_id == v.ship_id then
		    --         info = v
		    --     end
		    -- end
		    if info == nil then
		    	info = self.mould_id
		    	if self.table ~= nil and self.table.shipStar ~= nil then
		    		table = self.table
		    	end
		    end
	    else
	    	info = self.current_type
	    end
	    
	    Panel_prop._datas = {
			item_type = self.current_type,
			item_info = info,
			types = types,
			table = table,
		}
	else
		fwin:removeTouchEventListener(Panel_prop)
	end
end

function ResourcesIconCell:setChooseSelectState( isChoose )
	local root = self.roots[1]
	if root == nil then
		return
	end
	local Image_xuanzhong = ccui.Helper:seekWidgetByName(root, "Image_xuanzhong")
	if Image_xuanzhong ~= nil then
    	Image_xuanzhong:setVisible(isChoose)
    end
end

function ResourcesIconCell:setActivityDouble( isShow )
	local root = self.roots[1]
	if root == nil then
		return
	end
	local Image_double = ccui.Helper:seekWidgetByName(root, "Image_double")
	if Image_double ~= nil then
    	Image_double:setVisible(isShow)
    end
end

function ResourcesIconCell:clearUIInfo( ... )
	if __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
		then
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
			Image_2:setVisible(true)
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
	        Panel_prop:removeAllChildren(true)
	        Panel_prop:removeBackGroundImage()
	        Panel_prop:setTouchEnabled(true)
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
	        Panel_star:removeAllChildren(true)
	        Panel_star:removeBackGroundImage()
	    end
	    if Panel_props_right_icon ~= nil then
	        Panel_props_right_icon:removeAllChildren(true)
	        Panel_props_right_icon:removeBackGroundImage()
	    end
	    if Panel_props_left_icon ~= nil then
	        Panel_props_left_icon:removeAllChildren(true)
	        Panel_props_left_icon:removeBackGroundImage()
	    end
	    if Panel_num ~= nil then
	        Panel_num:removeAllChildren(true)
	        Panel_num:removeBackGroundImage()
	    end
	    if Panel_4 ~= nil then
	        Panel_4:removeAllChildren(true)
	        Panel_4:removeBackGroundImage()
	    end
	    if Text_1 ~= nil then
	        Text_1:setString("")
	    end
	    if Image_xuanzhong ~= nil then
	    	Image_xuanzhong:setVisible(false)
	    end
	end
end

function ResourcesIconCell:onExit()
	if __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
		then
		local root = self.roots[1]
	    self:clearUIInfo()
	    if self.isBig == true then
			cacher.freeRef("icon/item.csb", root)
		else
			cacher.freeRef("icon/item.csb", root)
		end
	end
end
--为防止参数项过多，第9个定义为table类型，想要什么可以往里面加 
--table解析
--table.shipStar --战船星级
--table.equipQuality -- 装备品质，不填为初始品质，填则为显示品质
--table.lazy 	-- 延迟加载
function ResourcesIconCell:init(interfaceType, item_count, mould_id, rewardType, isBig,showTip ,isLongTouch, isnumberX ,table) -- 道具、道具模板ID，没有为-1
	self.current_type = tonumber(interfaceType)
	self.item_count = tonumber(item_count)
	self.mould_id = tonumber(mould_id)
	if rewardType ~= nil then
		self.rewardType = rewardType
	end
	self.isBig = isBig
	self.showTip = showTip or false
	self.isLongTouch = isLongTouch or nil
	self.isnumberX = isnumberX or nil
	self.table = table or {}
	if self.table.lazy == nil or self.table.lazy ~= true then
		self:onInit()
	end
	if self.isBig == true then
		self:setContentSize(ResourcesIconCell.__big_size)
	else
		self:setContentSize(ResourcesIconCell.__size)
	end
end

function ResourcesIconCell:createCell()
	local cell = ResourcesIconCell:new()
	cell:registerOnNodeEvent(cell)
	return cell
end

function ResourcesIconCell:reload()
	if __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
		then
	    local root = self.roots[1]
	    if root ~= nil then
	        return
	    end
	    self:onInit()
	end
end

function ResourcesIconCell:unload()
    if __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
		then
	    local root = self.roots[1]
	    if root == nil then
	        return
	    end
	    self:clearUIInfo()
	    if self.isBig == true then
			cacher.freeRef("icon/item.csb", root)
		else
			cacher.freeRef("icon/item.csb", root)
		end
		root:removeFromParent(false)
    	self.roots = {}
	end
end

