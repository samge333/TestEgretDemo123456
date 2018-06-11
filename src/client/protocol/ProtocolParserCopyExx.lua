 ---------------------------------------------------------------------------------------------------------
-- parse_return_red_alert_formation 6012 --返回阵型 (6012)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_red_alert_formation( interpreter,datas,pos,strDatas,list,count )
	local formation_type = npos(list)
	_ED.formetion[1] = formation_type
    for i = 2 ,7 do
		_ED.formetion[i] = npos(list)
    end

    for i,ship in pairs(_ED.user_ship) do
    	local in_formation = false
    	for n = 2 ,6 do
    		if _ED.formetion[n] == ship.ship_id then
    			in_formation = true
    			break
    		end
    	end

    	if in_formation == true then
    		_ED.user_ship[ship.ship_id].formation_index = "1"
    	else
    		ship.formation_index = ""
    		_ED.user_ship[ship.ship_id].formation_index = ""
    	end
    end
    getUserFight()
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_gem_duplicate_attack_times 6013 --返回宝石副本攻击次数
-- ---------------------------------------------------------------------------------------------------------
function parse_gem_duplicate_attack_times( interpreter,datas,pos,strDatas,list,count )
	_ED.gem_duplicate_attack_times = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_weapon_house_attack_times 6014 --返回兵器冢攻击次数
-- ---------------------------------------------------------------------------------------------------------
function parse_weapon_house_attack_times( interpreter,datas,pos,strDatas,list,count )
	_ED.weapon_house_attack_times = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_hero_soul_duplicate_attack_times 6015 --返回将魂副本攻击次数
-- ---------------------------------------------------------------------------------------------------------
function parse_hero_soul_duplicate_attack_times( interpreter,datas,pos,strDatas,list,count )
	_ED.hero_soul_duplicate_attack_times = npos(list)
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_user_scene_states 6020 --返回用户场景状态(6020)
-- ---------------------------------------------------------------------------------------------------------
function parse_user_scene_states(interpreter,datas,pos,strDatas,list,count )
	-- if _ED.key_scene_current_state ~= nil then
	-- 	local scene_current_state = aeslua.decrypt("jar-world", _ED.key_scene_current_state, aeslua.AES128, aeslua.ECBMODE)
	-- 	if _ED.base_scene_current_state ~= scene_current_state then
	-- 		if fwin:find("ReconnectViewClass") == nil then
	--             fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
	--         end
	--         return false
	-- 	end
	-- end
	local scene_current_state = npos(list)
	local scene_max_state = npos(list)
	local get_star_count = npos(list)
	local star_reward_state = npos(list)
	_ED.scene_current_state = zstring.split(scene_current_state,",")
	_ED.scene_last_state = zstring.split(scene_current_state,",")
	
	_ED.scene_max_state = zstring.split(scene_max_state,",")
	_ED.get_star_count = zstring.split(get_star_count,",")
	_ED.star_reward_state = zstring.split(star_reward_state,",")
	-- print("=========scene")
	-- debug.print_r(_ED.scene_current_state)
	-- debug.print_r(_ED.scene_max_state)
	for i,v in pairs(_ED.scene_max_state) do
		local scene_type = dms.int(dms["pve_scene"],i,pve_scene.scene_type)
		if scene_type == 0 then
			if tonumber(v) == -1 then
				_ED.easy_now_scene_id = last_easy_scene_id
				break
			end
			last_easy_scene_id = i
		end
	end

	for i,v in pairs(_ED.scene_max_state) do
		local scene_type = dms.int(dms["pve_scene"],i,pve_scene.scene_type)
		if scene_type == 1 then
			if tonumber(v) == -1 then
				_ED.normal_now_scene_id = last_normal_scene_id
				break
			end
			last_normal_scene_id = i
		end
	end

	for i,v in pairs(_ED.scene_max_state) do
		local scene_type = dms.int(dms["pve_scene"],i,pve_scene.scene_type)
		if scene_type == 10 then
			if tonumber(v) == -1 then
				_ED.hard_now_scene_id = last_hard_scene_id
				break
			end
			last_hard_scene_id = i
		end
	end
	-- _ED.base_scene_current_state = aeslua.encrypt("jar-world", scene_current_state, aeslua.AES128, aeslua.ECBMODE)
	-- print("======",_ED.easy_now_scene_id,_ED.normal_now_scene_id,_ED.hard_now_scene_id)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_pve")
		state_machine.excute("notification_center_update", 0, "push_notification_pve_parts_supply")
		state_machine.excute("notification_center_update", 0, "push_notification_pve_armor")
	end
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_user_scene_change 6021 --返回用户场景变更(6021)
-- ---------------------------------------------------------------------------------------------------------
function parse_user_scene_change(interpreter,datas,pos,strDatas,list,count )
	-- if _ED.key_scene_current_state ~= nil then
	-- 	local scene_current_state = aeslua.decrypt("jar-world", _ED.key_scene_current_state, aeslua.AES128, aeslua.ECBMODE)
	-- 	if _ED.base_scene_current_state ~= scene_current_state then
	-- 		if fwin:find("ReconnectViewClass") == nil then
	--             fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
	--         end
	--         return false
	-- 	end
	-- end
	local scene_id = tonumber(npos(list))
	local state = npos(list)
	local max_state = npos(list)
	local star_count = npos(list)
	local star_reward_state = npos(list)
	_ED.scene_current_state[scene_id] = state 
	_ED.scene_max_state[scene_id] = max_state
	_ED.get_star_count[scene_id] = star_count
	_ED.star_reward_state[scene_id] = star_reward_state

	local last_easy_scene_id = 0
	local last_normal_scene_id = 0
	local last_hard_scene_id = 0

	for i,v in pairs(_ED.scene_max_state) do
		local scene_type = dms.int(dms["pve_scene"],i,pve_scene.scene_type)
		if scene_type == 0 then
			if tonumber(v) == -1 then
				_ED.easy_now_scene_id = last_easy_scene_id
				break
			end
			last_easy_scene_id = i
		end
	end

	for i,v in pairs(_ED.scene_max_state) do
		local scene_type = dms.int(dms["pve_scene"],i,pve_scene.scene_type)
		if scene_type == 1 then
			if tonumber(v) == -1 then
				_ED.normal_now_scene_id = last_normal_scene_id
				break
			end
			last_normal_scene_id = i
		end
	end

	for i,v in pairs(_ED.scene_max_state) do
		local scene_type = dms.int(dms["pve_scene"],i,pve_scene.scene_type)
		if scene_type == 10 then
			if tonumber(v) == -1 then
				_ED.hard_now_scene_id = last_hard_scene_id
				break
			end
			last_hard_scene_id = i
		end
	end
	local result = ""
	for k,v in pairs(_ED.scene_current_state) do
		result = result..v
	end
	-- _ED.base_scene_current_state = aeslua.encrypt("jar-world", result, aeslua.AES128, aeslua.ECBMODE)
	-- print("======",_ED.easy_now_scene_id,_ED.normal_now_scene_id,_ED.hard_now_scene_id)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_pve")
		state_machine.excute("notification_center_update", 0, "push_notification_pve_parts_supply")
		state_machine.excute("notification_center_update", 0, "push_notification_pve_armor")
	end
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_user_npc_states 6022 --返回用户NPC状态(6022)
-- ---------------------------------------------------------------------------------------------------------
function parse_user_npc_states(interpreter,datas,pos,strDatas,list,count )
	-- if _ED.key_npc_state ~= nil then
	-- 	local npc_state = aeslua.decrypt("jar-world", _ED.key_npc_state, aeslua.AES128, aeslua.ECBMODE)
	-- 	if _ED.base_npc_state ~= npc_state then
	-- 		if fwin:find("ReconnectViewClass") == nil then
	--             fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
	--         end
	--         return false
	-- 	end
	-- end
	local npcStates = npos(list)
	_ED.base_npc_state = npcStates
	_ED.npc_state = zstring.split(npcStates, ",")						-- 用户当前NPC状态（-1为NPC隐藏状态，0为锁定状态，1为可以攻击第一个战斗组，以此类推）
	_ED.npc_last_state = zstring.split(npcStates, ",")		
	_ED.npc_max_state = zstring.split(npos(list), ",")					-- 用户当前NPC的最大状态	
	_ED.npc_current_attack_count = zstring.split(npos(list), ",")		-- 用户当前npc的攻击次数(0,0,0,0,0,0,0)
	_ED.npc_current_buy_count = zstring.split(npos(list), ",")			-- 用户当前npc的购买次数(0,0,0,0,0,0,0)
	_ED.npc_hard_all_attack_times = npos(list) -- 炼狱副本总次数
	_ED.npc_equip_all_attack_times = npos(list) -- 兵器副本总次数
	
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
	else
		_ED.seven_star_attack_times = npos(list) -- 七星台已攻击次数
	end
	
	-- print("==========npc",_ED.npc_hard_all_attack_times)
	for i,v in pairs(_ED.scene_max_state) do
		if tonumber(v) == -1 then
			_ED._now_scene_max_open_number = i 
			break
		end
	end
	-- _ED.key_npc_state = aeslua.encrypt("jar-world", npcStates, aeslua.AES128, aeslua.ECBMODE)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_npc_change 6023 --返回用户NPC状态变更(6023)
-- ---------------------------------------------------------------------------------------------------------
function parse_user_npc_change(interpreter,datas,pos,strDatas,list,count )
	local npc_id = tonumber(npos(list))
	local npc_state = npos(list)
	local npc_max_state = npos(list)
	local npc_current_attack_count = npos(list)
	local npc_current_buy_count = npos(list)
	_ED.npc_hard_all_attack_times = npos(list)
	_ED.npc_equip_all_attack_times = npos(list) -- 兵器副本总次数

	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
	else
		_ED.seven_star_attack_times = npos(list) -- 七星台已攻击次数
	end

	_ED.npc_state[npc_id] = npc_state	
	-- _ED.npc_last_state[npc_id] = npc_state
	_ED.npc_max_state[npc_id] = npc_max_state		
	_ED.npc_current_attack_count[npc_id] = npc_current_attack_count	
	_ED.npc_current_buy_count[npc_id] = npc_current_buy_count	
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_prop_list 6024 --返回用户道具信息(6024)
-- ---------------------------------------------------------------------------------------------------------
function parse_user_prop_list(interpreter,datas,pos,strDatas,list,count )
	_ED.user_prop_number = npos(list)
	_ED.user_prop = {}
	for i=1,tonumber(_ED.user_prop_number) do

		local propIndex = npos(list)
		local propMouldIndex = npos(list)
		local propAmount = npos(list)
		local propMould = dms.element(dms["prop_mould"], propMouldIndex)

		local userProp = _ED.user_prop[propIndex] or {}
		userProp.user_prop_id= propIndex															--用户道具ID号
		userProp.user_prop_template = propMouldIndex												--用户道具模版ID号
		userProp.prop_name = dms.atos(propMould,prop_mould.prop_name)							--道具名称
		userProp.prop_function_remark= dms.atos(propMould,prop_mould.remarks)					--道具功能备注
		userProp.sell_system_price=dms.atos(propMould,prop_mould.silver_price)					--变卖给系统的价格
		userProp.prop_use_type= dms.atos(propMould,prop_mould.use_type)				 			--道具使用类型
		userProp.prop_number = propAmount														--道具数量
		userProp.prop_picture =  dms.atoi(propMould,prop_mould.pic_index)						--道具图片标识
		userProp.prop_track_remark = dms.atos(propMould,prop_mould.trace_remarks)				--道具追踪备注
		userProp.prop_track_scene = dms.atos(propMould,prop_mould.trace_scene)					--道具追踪场景
		userProp.prop_track_npc = dms.atos(propMould,prop_mould.trace_npc)						--道具追踪NPC
		userProp.prop_track_npc_index = dms.atos(propMould,prop_mould.trace_npc_index)				--道具追踪NPC下标
		userProp.prop_type = dms.atos(propMould,prop_mould.prop_type)							--道具类型
		userProp.prop_experience = dms.atos(propMould,prop_mould.full_experience)					--道具经验
		userProp.quality = dms.atoi(propMould,prop_mould.prop_quality)					--道具品质
		userProp.coming_need_number = dms.atoi(propMould,prop_mould.split_or_merge_count)	--需要数量
		userProp.storage_page_index = dms.atoi(propMould,prop_mould.storage_page_index)	--仓库页索引
		_ED.user_prop[propIndex] = userProp
		if tonumber(propAmount) == 0 then
			_ED.user_prop[propIndex] = nil		
		end
	end

end
-- ---------------------------------------------------------------------------------------------------------
-- parse_user_prop_list 6025 --返回用户道具信息(6025)
-- ---------------------------------------------------------------------------------------------------------
function parse_user_prop_change_list(interpreter,datas,pos,strDatas,list,count )
	local propIndex = npos(list)
	local propMouldIndex = npos(list)
	local propAmount = npos(list)
	local propMould = dms.element(dms["prop_mould"], propMouldIndex)

	local userProp = _ED.user_prop[propIndex] or {}
	userProp.user_prop_id= propIndex															--用户道具ID号
	userProp.user_prop_template = propMouldIndex												--用户道具模版ID号
	userProp.prop_name = dms.atos(propMould,prop_mould.prop_name)							--道具名称
	userProp.prop_function_remark= dms.atos(propMould,prop_mould.remarks)					--道具功能备注
	userProp.sell_system_price=dms.atos(propMould,prop_mould.silver_price)					--变卖给系统的价格
	userProp.prop_use_type= dms.atos(propMould,prop_mould.use_type)				 			--道具使用类型
	userProp.prop_number = propAmount														--道具数量
	userProp.prop_picture =  dms.atoi(propMould,prop_mould.pic_index)						--道具图片标识
	userProp.prop_track_remark = dms.atos(propMould,prop_mould.trace_remarks)				--道具追踪备注
	userProp.prop_track_scene = dms.atos(propMould,prop_mould.trace_scene)					--道具追踪场景
	userProp.prop_track_npc = dms.atos(propMould,prop_mould.trace_npc)						--道具追踪NPC
	userProp.prop_track_npc_index = dms.atos(propMould,prop_mould.trace_npc_index)				--道具追踪NPC下标
	userProp.prop_type = dms.atos(propMould,prop_mould.prop_type)							--道具类型
	userProp.prop_experience = dms.atos(propMould,prop_mould.full_experience)					--道具经验
	userProp.quality = dms.atoi(propMould,prop_mould.prop_quality)					--道具品质
	userProp.coming_need_number = dms.atoi(propMould,prop_mould.split_or_merge_count)	--需要数量
	userProp.storage_page_index = dms.atoi(propMould,prop_mould.storage_page_index)
	_ED.user_prop[propIndex] = userProp

	if tonumber(propAmount) == 0 then
		_ED.user_prop[propIndex] = nil		
	end
	-- debug.print_r(userProp)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		getUpdateUserPropTip()
		getRedAlertTimeEquipmentPartsTip()
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_packs")
		state_machine.excute("notification_center_update", 0, "push_notification_packs")
		state_machine.excute("notification_center_update", 0, "push_notification_equipment_packs")
        state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_data")
        state_machine.excute("notification_center_update", 0, "push_notification_armor_pack")
        state_machine.excute("notification_center_update", 0, "push_notification_quick_prop_push")
	end 
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_prop_remove 6026 --返回用户道具移除
-- ---------------------------------------------------------------------------------------------------------
function parse_user_prop_remove(interpreter,datas,pos,strDatas,list,count )
	--道具索引 道具模板 道具数量
	local prop_id = npos(list)
	local remove_prop_number = npos(list)
	local prop_number = tonumber(_ED.user_prop[prop_id].prop_number) - remove_prop_number
	if tonumber(prop_number) == 0 then
		_ED.user_prop[prop_id] = nil
	else
		_ED.user_prop[prop_id].prop_number = prop_number
	end
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		getUpdateUserPropTip()
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_packs")
		state_machine.excute("notification_center_update", 0, "push_notification_packs")
		state_machine.excute("notification_center_update", 0, "push_notification_equipment_packs")
        state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_data")
        state_machine.excute("notification_center_update", 0, "push_notification_armor_pack")
        state_machine.excute("notification_center_update", 0, "push_notification_quick_prop_push")
	end 
end
--公用函数 -- 战船的增加 修改 所有
function parse_read_ship_info(interpreter,datas,pos,strDatas,list,count)
	for n=1,tonumber(_ED.user_ship_number) do
		local ship_id_temp = npos(list)									--用户战船1ID
		local usership = _ED.user_ship[ship_id_temp] or {}
		usership.ship_id=ship_id_temp

		parse_read_all_ship_info(list,usership)						
		
		_ED.user_ship[usership.ship_id] = usership
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		else
			_ED.user_ship[usership.ship_id].hero_fight = getShipFight(usership)
		end
		if _ED.recruit_success_ship_ids == "" then
			_ED.recruit_success_ship_ids = usership.ship_id
		else
			_ED.recruit_success_ship_ids = _ED.recruit_success_ship_ids..","..usership.ship_id
		end
		_ED.recruit_success_ship_id = usership.ship_id		--记录招募到的武将id		
	end
end

-- 解析战船属性 
function parse_read_all_ship_info(list,usership)
	usership.ship_template_id=npos(list)						--战船模版ID
	usership.ship_base_template_id = dms.int(dms["ship_mould"],usership.ship_template_id,ship_mould.base_mould)
	usership.hero_fight=npos(list)								--英雄战斗力
	usership.ship_health=npos(list)							    --战船体力值  	血量
	usership.key_ship_health = aeslua.encrypt("jar-world", usership.ship_health, aeslua.AES128, aeslua.ECBMODE)
	usership.ship_courage=npos(list)							--战船勇气值  	攻击
	usership.attack_speed = npos(list)						    --攻速 			载重
	usership.gas_gather = npos(list)							--聚气			
	usership.key_gas_gather = aeslua.encrypt("jar-world", usership.gas_gather, aeslua.AES128, aeslua.ECBMODE)
	usership.ship_quick = npos(list)							--物防
	usership.ship_intellect = npos(list)						--法防
	usership.hit = npos(list)								    --命中			命中
	usership.dodge = npos(list)								    --闪躲			闪避
	usership.crit = npos(list)								    --暴击			暴击
	usership.toughness = npos(list)								--韧性			抗暴
	usership.block = npos(list)								    --格挡			防护
	usership.wreck = npos(list)								    --破击 			穿透
	usership.add_damage = npos(list)							--加伤
	usership.lessen_damage = npos(list)							--减伤
	usership.deadly_strike_persent = tonumber(npos(list))/100		--必杀百分比
	usership.strong_persent = tonumber(npos(list))/100				--强韧百分比
	usership.by_cure_persent = tonumber(npos(list))/100				--疗效百分比
	usership.damage_add_persent = tonumber(npos(list))/100			--加伤百分比
	usership.damage_sub_persent = tonumber(npos(list))/100			--减伤百分比
	usership.final_damage_add_persent = tonumber(npos(list))/100	--伤害增加百分比
	usership.final_damage_sub_persent = tonumber(npos(list))/100	--伤害减少百分比

	usership.equipment = 
		{
			{user_equiment_id = npos(list)},
			{user_equiment_id = npos(list)},
			{user_equiment_id = npos(list)},
			{user_equiment_id = npos(list)},
			{user_equiment_id = npos(list)},
			{user_equiment_id = npos(list)},
		}
	usership.talent_state = npos(list)						--天赋激活状态
	usership.fetters_state = npos(list)							--羁绊激活状态
	usership.is_have_fetters = false
	local stars_state_str = npos(list)	
    local star_id_str = dms.string(dms["ship_mould"],usership.ship_template_id,ship_mould.star_id_tab)
    local stars_state_tab = zstring.split(stars_state_str,",")
    local star_id_tab = zstring.split(star_id_str,",")
	usership.stars_state = {						--当前星格点亮状态
		{star_id = star_id_tab[1],state = stars_state_tab[1]},
		{star_id = star_id_tab[2],state = stars_state_tab[2]},
		{star_id = star_id_tab[3],state = stars_state_tab[3]},
		{star_id = star_id_tab[4],state = stars_state_tab[4]},
		{star_id = star_id_tab[5],state = stars_state_tab[5]},
		{star_id = star_id_tab[6],state = stars_state_tab[6]},
	}
	usership.little_partner_formation_index = npos(list)
	usership.rider_horse_id = npos(list) --骑乘战马id
	usership.ship_level = npos(list)	--英雄等级
	usership.skill_grow_up_states = zstring.split(npos(list),",")--英雄技能突破等级
	usership.god_weaponry = npos(list) --神兵
	usership.god_weaponry_task_id = npos(list) --神兵开启任务id
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		usership.ship_count = npos(list) --战船总数量
		usership.lose_ship_count = npos(list) --战船战损数量
		usership.battle_ship_count = npos(list) -- 战船出征的数量
		usership.current_count = zstring.tonumber(usership.ship_count) - zstring.tonumber(usership.lose_ship_count) - zstring.tonumber(usership.battle_ship_count)
		if usership.current_count < 0 then
			usership.current_count = 0
		end
		usership.city_ship_count = 0
		usership.city_battle_ship_count = 0
		usership.city_current_count = 0
		usership.experience = npos(list) 		-- 经验值
		usership.pierce_through = npos(list) 	-- 指挥
		usership.protect = npos(list) 			-- 坚守
		usership.expedition_lose_count = npos(list) -- 远征损失的数量
	end
	usership.skill_grow_up_level = 0
	for i, v in pairs(usership.skill_grow_up_states) do
		if v == "1" then
			usership.skill_grow_up_level = i
		end
	end
	usership.talents = {}
	usership.relationship = {}
	usership.camp_preference = 0
	usership.capacity = 0
	usership.talent_count = 0
	local ship_mould_id = usership.ship_template_id
	local ship_data = nil
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		--进化形象
		local evo_image = dms.string(dms["ship_mould"], ship_mould_id, ship_mould.fitSkillTwo)
		local evo_info = zstring.split(evo_image, ",")
		--进化模板id
		local ship_evo = zstring.split(usership.evolution_status, "|")
		local evo_mould_id = evo_info[tonumber(ship_evo[1])]
		local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
		local word_info = dms.element(dms["word_mould"], name_mould_id)
		ship_data = word_info[3]
	else
		ship_data = dms.element(dms["ship_mould"], ship_mould_id)
	end
	local captain_name = dms.atos(ship_data,ship_mould.captain_name)
	local ship_type = dms.atoi(ship_data,ship_mould.ship_type)
	local camp_preference = dms.atoi(ship_data,ship_mould.camp_preference)
	local capacity = dms.atoi(ship_data,ship_mould.capacity)
	local talent_str = dms.atos(ship_data,ship_mould.talent_id)
	local talent_tab = zstring.split(talent_str,"|")
	local talent_state_tab = zstring.split(usership.talent_state,",")
	local captain_type = dms.atoi(ship_data,ship_mould.captain_type)
	for i,v in pairs(talent_tab) do
		local talent_id_tab = zstring.split(v,",")
		local talent_id_t = talent_id_tab[3]	
		usership.talents[i] = 
		{
			talent_id = talent_id_t,
			is_activited = talent_state_tab[i]
		}
	end

	usership.talent_count = #talent_tab
	local relationship_id_str = dms.atos(ship_data,ship_mould.relationship_id)
	local relationship_id_tab = zstring.split(relationship_id_str,",")
	local relationship_state_tab = zstring.split(usership.fetters_state,"|")
	-- print("===========fetters_state=====",usership.fetters_state)
	for j,k in pairs(relationship_id_tab) do
		usership.relationship[j] =  usership.relationship[j] or {}
		-- print("================",j,relationship_state_tab[j],relationship_id_str,k)
		if relationship_state_tab[j] ~= nil then
			local relationship_state =zstring.split(relationship_state_tab[j],",")
			usership.relationship[j].relationship_id = k
			usership.relationship[j].is_activited = {}
			for i,v in pairs(relationship_state) do
				if v ~= "" then
					usership.relationship[j].is_activited[i] = v
					if zstring.tonumber(v) > 0 then
						usership.is_have_fetters = true
					end
				end
			end
		end
	end
	usership.relationship_count = #relationship_id_tab
	usership.captain_name = captain_name
	usership.ship_type = ship_type
	usership.camp_preference = camp_preference
	usership.capacity = capacity
	usership.current_hp = usership.current_hp or 0
	usership.captain_type = captain_type
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_all_user_equip 6027 --返回用户装备信息--红警
-- ---------------------------------------------------------------------------------------------------------
function parse_return_all_user_equip( interpreter,datas,pos,strDatas,list,count )
	if __lua_project_id == __lua_project_red_alert then
		if checkGameDataVerify() == false then
			return
		end
		_ED.user_equiment_number=npos(list)							--用户装备数量
		_ED.user_equiment = {}	
		for n=1,tonumber(_ED.user_equiment_number) do
			local equip_id = npos(list)
			local equipment_mould_id = npos(list)
			local equip_data = dms.element(dms["equipment_mould"],equipment_mould_id)
			local equipment_name = dms.atos(equip_data,equipment_mould.equipment_name)
			local silver_price = dms.atoi(equip_data,equipment_mould.silver_price)
			local influence_type = dms.atoi(equip_data,equipment_mould.influence_type)
			local equip_type = dms.atoi(equip_data,equipment_mould.equipment_type)
			local growup_value_data = dms.atos(equip_data,equipment_mould.grow_value) 
			local equip_quality = dms.atoi(equip_data,equipment_mould.grow_level)
			local equip_suit_id = dms.atoi(equip_data,equipment_mould.suit_id)
			local equip_rank_level = dms.atoi(equip_data,equipment_mould.rank_level)
			local userequiment = _ED.user_equiment[equip_id] or {}
			
			userequiment.user_equiment_id=equip_id						--用户装备ID号
			userequiment.user_equiment_template=equipment_mould_id				--用户装备模版ID号
			userequiment.user_equiment_name=equipment_name					--用户装备名称
			userequiment.sell_price=silver_price								--出售价格
			userequiment.user_equiment_influence_type=influence_type			--用户装备影响类型
			userequiment.equipment_type=equip_type						--装备类型
			userequiment.ship_id = npos(list)								--绑定战船id
			userequiment.user_equiment_ability=npos(list)					--用户装备能力值
			userequiment.user_equiment_grade=npos(list)					--用户装备等级
			userequiment.growup_value=growup_value_data								--成长值
			userequiment.quality = equip_quality						-- 品质
			userequiment.suit_id = equip_suit_id 						-- 套装id
			userequiment.rank_level = equip_rank_level 					-- 品级
			userequiment.jewelrys = 
				{
					npos(list),     -- -1 没解锁  0 解锁了 未穿戴  1 穿戴了
					npos(list),
					npos(list),
					npos(list),
					npos(list),
					npos(list)	
				}
			userequiment.rela_state = npos(list)   -- 0 没有， 1 shipid
			userequiment.equip_fight = npos(list)
			
			_ED.user_equiment[""..userequiment.user_equiment_id] = userequiment
			_ED.user_equiment[""..userequiment.user_equiment_id].equip_fight = 	getEquipmentFight(userequiment,0)
		end
	 	getUserFight()
	else
 		_ED.user_equiment_number = npos(list)
		_ED.user_equiment = _ED.user_equiment or {}	
		for n=1,tonumber(_ED.user_equiment_number) do
	 		parse_user_equip(interpreter,datas,pos,strDatas,list,count)
	 	end
	 	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
	 		getRedAlertTimeEquipmentPartsTip()
			state_machine.excute("notification_center_update", 0, "push_notification_equipment_parts_icon")
		    state_machine.excute("notification_center_update", 0, "push_notification_equipment_parts")
		    state_machine.excute("notification_center_update", 0, "push_notification_equipment_packs")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_fit")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_chip")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_data")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_chip_compose")

    		setRedAlertTimeArmorPartsChanged()
    		state_machine.excute("notification_center_update", 0, "push_notification_armor_icon")
			state_machine.excute("notification_center_update", 0, "push_notification_armor_formation")
			state_machine.excute("notification_center_update", 0, "push_notification_armor_equipment")
			state_machine.excute("notification_center_update", 0, "push_notification_armor_pack")
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_add_user_equip 6028 --返回红警装备增加--红警 变更
-- ---------------------------------------------------------------------------------------------------------
function parse_return_add_user_equip( interpreter,datas,pos,strDatas,list,count )
	if __lua_project_id == __lua_project_red_alert then
		if checkGameDataVerify() == false then
			return
		end
		local equip_id = npos(list)
		local equipment_mould_id = npos(list)
		local equip_data = dms.element(dms["equipment_mould"],equipment_mould_id)
		local equipment_name = dms.atos(equip_data,equipment_mould.equipment_name)
		local silver_price = dms.atoi(equip_data,equipment_mould.silver_price)
		local influence_type = dms.atoi(equip_data,equipment_mould.influence_type)
		local equip_type = dms.atoi(equip_data,equipment_mould.equipment_type)
		local growup_value_data = dms.atos(equip_data,equipment_mould.grow_value) 
		local equip_suit_id = dms.atoi(equip_data,equipment_mould.suit_id)
		local equip_rank_level = dms.atoi(equip_data,equipment_mould.rank_level)
		local userequiment = _ED.user_equiment[equip_id] or {}
		userequiment.user_equiment_id=equip_id					--用户装备ID号
		userequiment.user_equiment_template=equipment_mould_id					--用户装备模版ID号
		userequiment.user_equiment_name=equipment_name						--用户装备名称
		userequiment.sell_price=silver_price								--出售价格
		userequiment.user_equiment_influence_type=influence_type			--用户装备影响类型
		userequiment.equipment_type=equip_type							--装备类型
		userequiment.ship_id = npos(list)								--绑定战船id
		userequiment.user_equiment_ability=npos(list)					--用户装备能力值
		userequiment.user_equiment_grade=npos(list)					--用户装备等级
		userequiment.growup_value=growup_value_data								--成长值
		userequiment.suit_id = equip_suit_id 						-- 套装id
		userequiment.rank_level = equip_rank_level 					-- 品级
		userequiment.jewelrys = 
		{
			npos(list),     -- -1 没解锁  0 解锁了 未穿戴  1 穿戴了
			npos(list),
			npos(list),
			npos(list),
			npos(list),
			npos(list)	
		}
		userequiment.rela_state = npos(list)
		userequiment.equip_fight = npos(list)
		userequiment.quality = dms.atoi(equip_data,equipment_mould.grow_level)
		_ED.user_equiment[equip_id] = userequiment
		_ED.user_equiment[equip_id].equip_fight = getEquipmentFight(userequiment,0)
		getUserFight()
	else
		local count = tonumber(npos(list))
		for i=1,count do
			parse_user_equip(interpreter,datas,pos,strDatas,list,count)
		end
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			getRedAlertTimeEquipmentPartsTip()
			state_machine.excute("notification_center_update", 0, "push_notification_equipment_parts_icon")
		    state_machine.excute("notification_center_update", 0, "push_notification_equipment_parts")
		    state_machine.excute("notification_center_update", 0, "push_notification_equipment_packs")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_fit")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_chip")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_data")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment")
    		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_chip_compose")

    		setRedAlertTimeArmorPartsChanged()
    		state_machine.excute("notification_center_update", 0, "push_notification_armor_icon")
			state_machine.excute("notification_center_update", 0, "push_notification_armor_formation")
			state_machine.excute("notification_center_update", 0, "push_notification_armor_equipment")
			state_machine.excute("notification_center_update", 0, "push_notification_armor_pack")
		end
	end
end

function parse_user_equip( interpreter,datas,pos,strDatas,list,count )
	local equip = {}
	equip.equip_id = npos(list)
	equip.equipment_mould_id = npos(list)
	equip.is_equiped = npos(list)			--0未穿，1已穿
	equip.attr = npos(list)					--属性值
	equip.upgrade_level = npos(list)		--强化等级
	equip.rank_up_level = npos(list)		--改造等级
	equip.strength = npos(list)				--强度
	equip.formation_type = tonumber(npos(list))
	equip.experience = tonumber(npos(list))

	equip_data = dms.element(dms["equipment_mould"], equip.equipment_mould_id)
	equip.equipment_name = dms.atos(equip_data, equipment_mould.equipment_name)
	equip.influence_type = dms.atoi(equip_data, equipment_mould.influence_type)
	equip.equipment_type = dms.atoi(equip_data, equipment_mould.equipment_type)
	equip.initial_value = dms.atos(equip_data, equipment_mould.initial_value)
	equip.star_level = dms.atoi(equip_data, equipment_mould.star_level)
	equip.grow_level = dms.atoi(equip_data, equipment_mould.grow_level) 			-- 品质
	equip.grow_value = dms.atos(equip_data, equipment_mould.grow_value)
	equip.pic_index = dms.atos(equip_data, equipment_mould.pic_index)
	equip.refining_items = dms.atos(equip_data, equipment_mould.refining_items)
	equip.equipment_gem_numbers = dms.atoi(equip_data, equipment_mould.equipment_gem_numbers)
	equip.additive_attribute = dms.atos(equip_data, equipment_mould.additive_attribute)
	equip.awaken_need_resource = dms.atos(equip_data, equipment_mould.awaken_need_resource)
	equip.weapon_book_convert = dms.atoi(equip_data, equipment_mould.weapon_book_convert)
	equip.weapon_book_attr_ids = dms.atof(equip_data, equipment_mould.weapon_book_attr_ids)
	equip.armor_type = dms.atoi(equip_data, equipment_mould.equipment_seat) 		-- 装甲类型：1-6, 0：配件
	equip.trace_remarks = dms.atos(equip_data, equipment_mould.trace_remarks)
	equip.suit_id = dms.atoi(equip_data, equipment_mould.suit_id) 					-- 套装id

	_ED.user_equiment[""..equip.equip_id] = equip
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_remove_user_equip 6029 --返回红警装备移除--红警
-- ---------------------------------------------------------------------------------------------------------
function parse_return_remove_user_equip( interpreter,datas,pos,strDatas,list,count )
	if checkGameDataVerify() == false then
		return
	end
	local equip_id = npos(list)
	_ED.user_equiment[quip_id] = nil
	getUserFight()
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		getRedAlertTimeEquipmentPartsTip()
		state_machine.excute("notification_center_update", 0, "push_notification_equipment_parts_icon")
	    state_machine.excute("notification_center_update", 0, "push_notification_equipment_parts")
	    state_machine.excute("notification_center_update", 0, "push_notification_equipment_packs")
		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_fit")
		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_chip")
		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_data")
		state_machine.excute("notification_center_update", 0, "push_notification_equipment")
		state_machine.excute("notification_center_update", 0, "push_notification_equipment_pack_chip_compose")

		setRedAlertTimeArmorPartsChanged()
		state_machine.excute("notification_center_update", 0, "push_notification_armor_icon")
		state_machine.excute("notification_center_update", 0, "push_notification_armor_formation")
		state_machine.excute("notification_center_update", 0, "push_notification_armor_equipment")
		state_machine.excute("notification_center_update", 0, "push_notification_armor_pack")
	end
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_all_user_ship 6030 --返回用户所有武将--红警
-- ---------------------------------------------------------------------------------------------------------
function parse_return_all_user_ship( interpreter,datas,pos,strDatas,list,count )
	if checkGameDataVerify() == false then
		return
	end
	_ED.user_ship = {}
	_ED.user_ship_number = npos(list)--用户战船数量	
	parse_read_ship_info(interpreter,datas,pos,strDatas,list,count)	
	getUserFight()
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_formation")
		state_machine.excute("notification_center_update", 0, "push_notification_formation_repair")
		state_machine.excute("notification_center_update", 0, "push_notification_battle_reward_repair")
		state_machine.excute("notification_center_update", 0, "push_notification_battle_lose_repair")
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_add_user_ship 6031 --添加武将--红警
-- ---------------------------------------------------------------------------------------------------------
function parse_add_user_ship( interpreter,datas,pos,strDatas,list,count )
	if checkGameDataVerify() == false then
		return
	end
	_ED.user_ship_number = 1
	parse_read_ship_info(interpreter,datas,pos,strDatas,list,count)	
	getUserFight()
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_formation")
		state_machine.excute("notification_center_update", 0, "push_notification_formation_repair")
		state_machine.excute("notification_center_update", 0, "push_notification_battle_reward_repair")
		state_machine.excute("notification_center_update", 0, "push_notification_battle_lose_repair")
	end
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_remove_user_ship 6032 --移除英雄
-- ---------------------------------------------------------------------------------------------------------
function parse_remove_user_ship( interpreter,datas,pos,strDatas,list,count )
	if checkGameDataVerify() == false then
		return
	end
	local ship_id = npos(list)
	_ED.user_ship[ship_id] = nil
	getUserFight()
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_formation")
		state_machine.excute("notification_center_update", 0, "push_notification_formation_repair")
		state_machine.excute("notification_center_update", 0, "push_notification_battle_reward_repair")
		state_machine.excute("notification_center_update", 0, "push_notification_battle_lose_repair")
	end
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_change_user_ship 6033 --变更
-- ---------------------------------------------------------------------------------------------------------
function parse_change_user_ship( interpreter,datas,pos,strDatas,list,count )
	if checkGameDataVerify() == false then
		return
	end
	_ED.user_ship_number = 1
	parse_read_ship_info(interpreter,datas,pos,strDatas,list,count)
	getUserFight()
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_formation")
		state_machine.excute("notification_center_update", 0, "push_notification_formation_repair")
		state_machine.excute("notification_center_update", 0, "push_notification_battle_reward_repair")
		state_machine.excute("notification_center_update", 0, "push_notification_battle_lose_repair")
	end
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_all_user_info 6039 返回用户信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_all_user_info( interpreter,datas,pos,strDatas,list,count )
	if __lua_project_id == __lua_project_red_alert_time 
		or __lua_project_id == __lua_project_pacific_rim 
		then
	else
		if list[2] == "login_init" or list[2] == "login_init_again" then
			local sequence = NetworkProtocol.sequence
			sequence = zstring.tonumber(list[1])
			NetworkProtocol.sequence = sequence
			NetworkProtocol.lock = true
		end
	end
	local isVerity = true
	if _ED.user_info ~= nil and _ED.user_info.key_user_id ~= nil then
		local user_id = aeslua.decrypt("jar-world", _ED.user_info.key_user_id, aeslua.AES128, aeslua.ECBMODE)
		if tonumber(user_id) ~= tonumber(_ED.user_info.user_id) then
			isVerity = false
		end
	end
	if isVerity == true and _ED.user_info ~= nil and _ED.user_info.key_user_grade ~= nil then
		local user_grade = aeslua.decrypt("jar-world", _ED.user_info.key_user_grade, aeslua.AES128, aeslua.ECBMODE)
		if tonumber(user_grade) ~= tonumber(_ED.user_info.user_grade) then
			isVerity = false
		end
	end
	if isVerity == true and _ED.user_info ~= nil and _ED.user_info.key_user_all_gems ~= nil then
		local user_all_gems = aeslua.decrypt("jar-world", _ED.user_info.key_user_all_gems, aeslua.AES128, aeslua.ECBMODE)
		if tonumber(user_all_gems) ~= tonumber(_ED.user_info.user_all_gems) then
			isVerity = false
		end
	end
	if isVerity == true and _ED.user_info ~= nil and _ED.user_info.key_user_gold ~= nil then
		local user_gold = aeslua.decrypt("jar-world", _ED.user_info.key_user_gold, aeslua.AES128, aeslua.ECBMODE)
		if tonumber(user_gold) ~= tonumber(_ED.user_info.user_gold) then
			isVerity = false
		end
	end
	if isVerity == true and _ED.user_info ~= nil and _ED.user_info.key_vip_level ~= nil then
		local vip_level = aeslua.decrypt("jar-world", _ED.user_info.key_vip_level, aeslua.AES128, aeslua.ECBMODE)
		if tonumber(vip_level) ~= tonumber(_ED.user_info.vip_level) then
			isVerity = false
		end
	end

	if isVerity == false then
        -- if fwin:find("ReconnectViewClass") == nil then
        --     fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
        -- end
        -- return false
    end

	_ED.user_info = _ED.user_info or {}
	_ED.user_info.user_id = npos(list)				--用户id 
	_ED.user_info.user_name = npos(list)					--名称
	_ED.user_info.user_grade = npos(list)				--等级
	_ED.user_info.user_gender = npos(list)				--性别
	_ED.user_info.user_head_id = npos(list)				--头像
	_ED.user_info.user_force = npos(list)				--势力
	_ED.user_info.misson_id = npos(list)					--教学记录
	_ED.user_info.recharge_all_rmb = npos(list)			--总充值
	_ED.user_info.user_all_gems = npos(list)             --总宝石
	_ED.user_info.user_gold = npos(list)					--宝石
	_ED.user_info.user_silver = npos(list)			    --银币 (宝石矿)
	_ED.user_info.user_iron = npos(list)					--铁矿
	_ED.user_info.soul = npos(list)						--将魂
	_ED.user_info.user_honour = npos(list)				--声望 (战地勋章)
	_ED.user_info.jade  = npos(list)						--玉璧
	_ED.user_info.exploits = npos(list)					--战功令(铅矿)
	_ED.user_info.tiger_shaped = npos(list)				--虎符(钛矿)
	_ED.user_info.forage = npos(list)				    --军粮(最大繁荣度)
	_ED.user_info.horse_spirits_patch = npos(list)		--马魂碎片
	_ED.user_info.dragon_horse_patch = npos(list)		--龙马碎片
	_ED.user_info.union_contribute = npos(list)		    --军团贡献
	_ED.user_info.user_experience = npos(list)			--经验
	_ED.user_info.user_food = npos(list)					--体力
	_ED.user_info.max_user_food = npos(list)				--体力上限
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		_ED.user_info.max_user_food = dms.int(dms["user_experience_param"] ,tonumber(_ED.user_info.user_grade) ,user_experience_param.combatFoodCapacity)
		--武将强化推送
		setHeroDevelopAllShipPushState(3)
		state_machine.excute("hero_list_view_update_cell_strength_button_push",0,"hero_list_view_update_cell_strength_button_push.")
		state_machine.excute("hero_list_view_update_cell_equip_button_push",0,"hero_list_view_update_cell_equip_button_push.")
       	state_machine.excute("notification_center_update",0,"push_notification_center_ship_warehouse_all")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_home_hero_icon")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_duplicate_formation")
	end
	_ED.user_info.user_food_add_cd = npos(list)			--体力恢复CD
	_ED.user_info.family_index = npos(list)				--家族索引
	_ED.user_info.family_name = npos(list)				--家族名称
	_ED.user_info.endurance = npos(list)					--耐力
	_ED.user_info.fighter_capacity = npos(list)				--战力
	_ED.last_fight_number = _ED.user_info.fighter_capacity
	print("战力6:" .. _ED.last_fight_number)
	_ED.user_info.vip_level = npos(list)					--vip等级
	
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		_ED.user_info.oil_field = npos(list)					--油矿
		_ED.user_info.booming = npos(list)					--当前繁荣度
		_ED.user_info.credit = npos(list) 					--声望
		_ED.user_info.credit_level = npos(list) 	       -- 声望等级
		_ED.user_info.soldier = npos(list) 	       -- 带兵量
		_ED.user_info.user_glory = npos(list) 	       -- 荣誉
		_ED.user_info.command_level = npos(list) 	       -- 统率等级
	end

	_ED.recharge_rmb_number = _ED.user_info.recharge_all_rmb
	_ED.recharge_precious_number = _ED.user_info.user_all_gems
	_ED.vip_grade = _ED.user_info.vip_level

	_ED.user_info.mission_user_grade = tonumber(_ED.user_info.user_grade)
	
	if __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim
		then
		local user_experiencex = dms.int(dms["user_experience_param"],zstring.tonumber(_ED.user_info.user_grade),user_experience_param.needs_experience)
		_ED.user_info.user_grade_need_experience = user_experiencex
	end
	
	_ED.user_info.key_user_id = aeslua.encrypt("jar-world", _ED.user_info.user_id, aeslua.AES128, aeslua.ECBMODE)
	_ED.user_info.key_user_grade = aeslua.encrypt("jar-world", _ED.user_info.user_grade, aeslua.AES128, aeslua.ECBMODE)
	_ED.user_info.key_user_all_gems = aeslua.encrypt("jar-world", _ED.user_info.user_all_gems, aeslua.AES128, aeslua.ECBMODE)
	_ED.user_info.key_user_gold = aeslua.encrypt("jar-world", _ED.user_info.user_gold, aeslua.AES128, aeslua.ECBMODE)
	_ED.user_info.key_vip_level = aeslua.encrypt("jar-world", _ED.user_info.vip_level, aeslua.AES128, aeslua.ECBMODE)

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		if tonumber(_ED.user_info.max_user_food) - tonumber(_ED.user_info.user_food) > 0 then
			if _ED.app_push_number[1] == nil or _ED.app_push_number[1] == "" then
				_ED.app_push_number[1] = {}
			end
			if _ED.app_push_number[1][1] ~= nil and _ED.app_push_number[1][1].pushid == 9999 then
				_ED.app_push_number[1][1] = nil
			end
			if _ED.app_push_number[1][1] == nil or _ED.app_push_number[1][1] == "" then
				_ED.app_push_number[1][1] = {}
				_ED.app_push_number[1][1].pushid = 9999
				
				if _ED.app_push_number[1].number == nil or _ED.app_push_number[1].number == "" then
					_ED.app_push_number[1].number = 1
				else
					_ED.app_push_number[1].number = _ED.app_push_number[1].number + 1
				end
				local cdtime = dms.int(dms["user_config"],8,user_config.param)
				local up_push_time = os.time()+ (tonumber(_ED.user_info.max_user_food) - tonumber(_ED.user_info.user_food))*cdtime + _ED.time_add_or_sub
				local system_local_push_list = cc.UserDefault:getInstance():getStringForKey("system_local_push_list")
				local isPush = false
				if system_local_push_list ~= nil and system_local_push_list ~= "" then
					local push_list_info = zstring.split(system_local_push_list ,",")
					if tonumber(push_list_info[tonumber(_app_push_notification[1][4])]) == 0 then
						isPush = true
					end
				else
					isPush = true
				end
				if isPush == true then
					state_machine.excute("platform_push_request", 0, { pushid = 1 , delayTime=up_push_time , system_push_text = _app_push_notification[1][2], push_number_id = 1})
				end
			end
		end
		checkEffectLevelUp()
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_recuit_times 6040 --返回招募次数
-- ---------------------------------------------------------------------------------------------------------
function parse_return_recuit_times( interpreter,datas,pos,strDatas,list,count )
	_ED.free_info = _ED.free_info or {}
	for i=1,3 do
		_ED.free_info[i] = _ED.free_info[i] or {}
		_ED.free_info[i].next_free_time=npos(list)					--下次免费时间
		_ED.free_info[i].first_satus=npos(list)					--首刷状态
		_ED.free_info[i].surplus_free_number=npos(list)				--剩余免费次数
		_ED.free_info[i].free_start= os.time()
	end
	_ED.user_accumulate_buy_god=npos(list)			--神将招募累积次数
	_ED.user_accumulate_camp_god=npos(list)			--群雄招募累积次数
	--print("_ED.user_accumulate_buy_god==".._ED.user_accumulate_buy_god)
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		state_machine.excute("notification_center_update", 0, "push_notification_center_new_shop")
		state_machine.excute("notification_center_update", 0, "push_notification_center_sm_chest_store")
		state_machine.excute("notification_center_update", 0, "push_notification_center_new_recruit")
		state_machine.excute("notification_center_update", 0, "push_notification_center_shop_small_building")
		state_machine.excute("notification_center_update", 0, "push_notification_center_shop_large_building")
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_food_ready_buy_times 6041 --返回体力已经购买的次数
-- ---------------------------------------------------------------------------------------------------------
function parse_return_food_ready_buy_times( interpreter,datas,pos,strDatas,list,count )
	_ED.food_ready_buy_times = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 6042 --返回服务器评审状态
-- ---------------------------------------------------------------------------------------------------------
function parse_return_server_review( interpreter,datas,pos,strDatas,list,count )
	_ED.server_review = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 6043  --返回用户资源变更
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_resource_change( interpreter,datas,pos,strDatas,list,count )
	local sourceType = npos(list)
	local sourceValue = npos(list)
	if "1" == sourceType then -- 铁矿
		_ED.user_info.user_iron = sourceValue
	elseif "2" == sourceType then -- 玉璧
		_ED.user_info.jade = sourceValue
	elseif "3" == sourceType then -- 战功令
		_ED.user_info.exploits = sourceValue
	elseif "4" == sourceType then -- 虎符
		_ED.user_info.tiger_shaped = sourceValue
	elseif "5" == sourceType then -- 备用1
		--数码项目这里是天赋点
		_ED.user_info.talent_point = sourceValue
	elseif "6" == sourceType then -- 备用2

	elseif "7" == sourceType then -- 备用3

	elseif "8" == sourceType then -- 备用4

	elseif "9" == sourceType then -- 备用5

	elseif "10" == sourceType then -- 备用6

	end
end


-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 6501 --返回国战信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_info( interpreter,datas,pos,strDatas,list,count )
	_ED.warfareCityNum = tonumber(npos(list))
	for i=1,_ED.warfareCityNum do
		local city_id = tonumber(npos(list))
		local cityInfo = _ED.warfareCityInfo[city_id] or {}
		cityInfo.city_id = city_id
		cityInfo.state = npos(list)
		cityInfo.camp = npos(list)

		_ED.warfareCityInfo[cityInfo.city_id] = cityInfo
	end
	if _ED.war_city_last_info == nil then
		_ED.war_city_last_info = {}
		for i,v in pairs(_ED.warfareCityInfo) do
			_ED.war_city_last_info[i]= {}
			_ED.war_city_last_info[i].state = v.state
			_ED.war_city_last_info[i].camp = v.camp
		end
	end

	-- debug.print_r(_ED.warfareCityInfo)
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 6502 --返回城池状态更新(6502)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_city_info( interpreter,datas,pos,strDatas,list,count )
	local city_id = tonumber(npos(list))
	local state = npos(list)
	local camp = npos(list)
	local cityInfo = _ED.warfareCityInfo[city_id]
	if cityInfo ~= nil then
		cityInfo.state = state
		cityInfo.camp = camp
	end
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 返回战斗结算(6503)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_battle_result( interpreter,datas,pos,strDatas,list,count )
	local result = npos(list)
	local selfCamp = npos(list)
	local selfGener = npos(list)
	local combatForce = npos(list)
	local level = npos(list)
	local name = npos(list)
	local count = npos(list)
	for i=1,tonumber(count) do
		local shipInfo = {
			ship_id = npos(list),
			lessHp = npos(list),
			maxHp = npos(list),
		}
		_ED.warfare_my_formation[shipInfo.ship_id] = shipInfo
	end
	local armyCamp = npos(list)
	local armyGener = npos(list)
	local armyCombatForce = npos(list)
	local armylevel = npos(list)
	local armyName  = npos(list)
	local armycount = npos(list)
	local armyFormation = {}
	for i=1,tonumber(armycount) do
		local shipInfo = {
			ship_id = npos(list),
			lessHp = npos(list),
			maxHp = npos(list),
		}
		table.insert(armyFormation,shipInfo)
	end
	_ED.war_city_war_result = result
	_ED.war_city_war_server_review = nil
	-- _ED.war_city_war_server_review = {}
	_ED.war_city_war_server_review={
		{
			selfCamp = selfCamp,
			selfGener = selfGener,
			combatForce = combatForce,
			level = level,
			name = name,
			warfare_formation = _ED.warfare_my_formation,
		},
		{
			selfCamp = armyCamp,
			selfGener = armyGener,
			combatForce = armyCombatForce,
			level = armylevel,
			name = armyName,
			warfare_formation = armyFormation,
		},
	}
	--debug.print_r(_ED.war_city_war_server_review)

end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 返回国战个人信息(6504)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_self_warfare_info( interpreter,datas,pos,strDatas,list,count )
	_ED.selfWarProvisions = npos(list)
	_ED.selfHonnor = npos(list)
	_ED.selfWinCount = npos(list)
	_ED.user_war_info.user_leader_level = tonumber(npos(list))
	_ED.user_war_info.union_user_level = tonumber(npos(list))
	_ED.user_war_info.union_id = tonumber(npos(list))
	if __lua_project_id ~= __lua_project_gragon_tiger_gate and __lua_project_id ~= __lua_project_l_digital and __lua_project_id ~= __lua_project_l_pokemon and __lua_project_id ~= __lua_project_l_naruto  then
		_ED.user_war_info.release_order_count = tonumber(npos(list))
		--print("------------ release_order_count =", _ED.user_war_info.release_order_count)
	end
	--print("==========",_ED.user_war_info.user_leader_level,_ED.user_war_info.union_user_level,_ED.user_war_info.union_id)
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 返回号令发放信息(6505)
--						 	  发布数量
--							  发布地图 发布人 发布人官职 发布CD时间
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_order_info( interpreter,datas,pos,strDatas,list,count )
	_ED.warfare_order_info = {}
	local count = npos(list)
	for i=1,tonumber(count) do
		local orderInfo = {
			city = npos(list),
			userName = npos(list),
			officer = npos(list),
			coolintTime = npos(list),
			order_type = tonumber(npos(list)),
			union_id = tonumber(npos(list)),
		}
		if tonumber(orderInfo.order_type) == 2 then
			if _ED.union ~= nil and _ED.union.union_info ~= nil and tonumber(orderInfo.union_id) == tonumber(_ED.union.union_info.union_id) then
				table.insert(_ED.warfare_order_info,orderInfo)	
			end
		else
			table.insert(_ED.warfare_order_info,orderInfo)
		end
		-- 记录时间
		local war_decree_time = _ED.war_decree_time[tonumber(orderInfo.city)] or {}
		local city_id = tonumber(orderInfo.city)
		local leave_time = tonumber(orderInfo.coolintTime)
		local order_type = orderInfo.order_type
		war_decree_time.country_start_time = os.time()
		war_decree_time.family_start_time = os.time()
		if order_type == 1 then
			war_decree_time.country_leave_time = leave_time
		elseif order_type == 2 then
			war_decree_time.family_leave_time = leave_time
		end
		_ED.war_decree_time[city_id] = war_decree_time		
	end
	-- debug.print_r(_ED.warfare_order_info)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_city_info 返回城池信息(6506)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_city_info( interpreter,datas,pos,strDatas,list,count )

	local now_city_camp = zstring.tonumber(npos(list))
	local defense_people_number = zstring.tonumber(npos(list))
	local union_people_number = zstring.tonumber(npos(list))

	local union_table = {}
	for i= 1,union_people_number do
		if i > 6 then
			break
		end
		local data = 
		{
			gender = zstring.tonumber(npos(list)),
			name = npos(list)
		}
		table.insert(union_table,data)
	end

	local act_of_god_numbers = zstring.tonumber(npos(list))
	local act_of_god_table = {}
	for i= 1,act_of_god_numbers do
		if i > 6 then
			break
		end
		local data = 
		{
			gender = zstring.tonumber(npos(list)),
			name = npos(list)
		}
		table.insert(act_of_god_table,data)
	end	

	local natural_numbers = zstring.tonumber(npos(list))
	local natural_table = {}
	for i= 1,natural_numbers do
		if i > 6 then
			break
		end
		local data = 
		{
			gender = zstring.tonumber(npos(list)),
			name = npos(list)
		}
		table.insert(natural_table,data)
	end	

	_ED.war_in_city_info = _ED.war_in_city_info or {}
	_ED.war_in_city_info.now_city_camp = now_city_camp
	_ED.war_in_city_info.defense_people_number = defense_people_number
	_ED.war_in_city_info.union_people_number = union_people_number--蜀国人数
	_ED.war_in_city_info.act_of_god_numbers = act_of_god_numbers--吴国人数
	_ED.war_in_city_info.natural_numbers = natural_numbers--魏国人数
	_ED.war_in_city_info.union_table = union_table
	_ED.war_in_city_info.act_of_god_table = act_of_god_table
	_ED.war_in_city_info.natural_table = natural_table

end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 返回自身血量更新(6507)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_formation_change( interpreter,datas,pos,strDatas,list,count )
	local count = npos(list)
	for i=1,tonumber(count) do
		local ship_id = npos(list)
		local shipInfo = _ED.warfare_formation[ship_id] or {}
		shipInfo.ship_id = ship_id
		shipInfo.lessHp = npos(list)
		shipInfo.maxHp = npos(list)
		if _ED.warfare_formation[ship_id] == nil then
			_ED.warfare_formation[ship_id] = shipInfo
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 返回战况信息(6508)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_news_info( interpreter,datas,pos,strDatas,list,count )
	
	local count = npos(list)
	_ED.warfar_news.fight_info = {}
	for i=1,tonumber(count) do
		local city_info = {
			city_id = npos(list),
			all_people_numbers = 
			{
				npos(list),
				npos(list),
				npos(list),
			},
			guard_numbers = npos(list),
			attack_camp = npos(list),
			defense_camp = npos(list),
		}
		_ED.warfar_news.fight_info[i] = city_info
	end
	_ED.warfar_news.union_city_numbers = npos(list)
	_ED.warfar_news.tribe_city_numbers = npos(list)
	_ED.warfar_news.neutral_city_numbers = npos(list)
	
	-- debug.print_r(_ED.warfar_news)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 返回战斗冷却时间(6509)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_battle_cooling_time( interpreter,datas,pos,strDatas,list,count )
	_ED.battle_cooling_time = npos(list)
	_ED.battle_cooling_time_update = os.time()
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 返回死亡复活时间(6510)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_revive_cooling_time( interpreter,datas,pos,strDatas,list,count )
	_ED.revive_cooling_time = npos(list)
	if tonumber(_ED.revive_cooling_time) > 0 then
		_ED.war_user_dead = true
	else
		_ED.war_user_dead = false
	end

	_ED.revive_cooling_start_time = os.time()

end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_review 返回城池附加状态(6511)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_city_buff_info( interpreter,datas,pos,strDatas,list,count )
	local city_id = tonumber(npos(list))
	local buffcount = npos(list)
	local cityInfo = _ED.warfareCityInfo[city_id] or {}
	cityInfo.buffs = {}
	for i=1,tonumber(buffcount) do
		local buff = {
			card_info= npos(list),
			buff_laye = npos(list),
		}
		cityInfo.buffs[i] = buff
		-- table.insert(cityInfo.buffs,buff)
	end
end

-------------------------------------------------------------------------------------------------
-- parse_return_user_at_city_id_change 返回用户当前所在城市(6512)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_at_city_id_change(interpreter,datas,pos,strDatas,list,count)
	_ED.war_user_at_city_id = tonumber(npos(list))
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_city_fight_info 返回军情信息(6513)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_city_fight_info( interpreter,datas,pos,strDatas,list,count )
	local city_id = tonumber(npos(list))
	local now_city_camp = tonumber(npos(list))
	local attack_camp_number = tonumber(npos(list))
	local attack_info_table = {}
	for i=1,attack_camp_number do
		local data = 
		{
			camp = tonumber(npos(list)),
			number =tonumber(npos(list))
		}
		table.insert(attack_info_table,data)
	end
	local defense_number = tonumber(npos(list))
	local defense_info_table = {}
	for i=1,defense_number do
		local data = 
		{
			camp = tonumber(npos(list)),
			number =tonumber(npos(list))
		}
		table.insert(defense_info_table,data)
	end	
	local official_number = tonumber(npos(list))
	local official_info_table = {}
	for i=1,official_number do
		local data = 
		{
			camp = tonumber(npos(list)),
			official_level =tonumber(npos(list)),
			name = npos(list)
		}
		table.insert(official_info_table,data)
	end
	_ED.war_city_fight_info[city_id] = _ED.war_city_fight_info[city_id] or {}
	_ED.war_city_fight_info[city_id].city_id = city_id
	_ED.war_city_fight_info[city_id].attack_camp_number = attack_camp_number
	_ED.war_city_fight_info[city_id].defense_number = defense_number
	_ED.war_city_fight_info[city_id].official_number = official_number
	_ED.war_city_fight_info[city_id].attack_info_table = attack_info_table
	_ED.war_city_fight_info[city_id].defense_info_table = defense_info_table
	_ED.war_city_fight_info[city_id].official_info_table = official_info_table
	_ED.war_city_fight_info[city_id].now_city_camp = now_city_camp
	
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_task_info 返回国战任务信息 6514
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_task_info( interpreter,datas,pos,strDatas,list,count )

	local country_task_numbers = npos(list)
	local war_task_info = _ED.war_task_info or {}

	war_task_info.country = {}	
	for i=1,country_task_numbers do	
		local data = 
		{
			task_id =  npos(list) ,
			task_state =  npos(list) ,
			task_cd = npos(list),
		}
		table.insert(war_task_info.country,data)
	end

	local user_task_numbers = npos(list)
	war_task_info.user = {}
	for i = 1,user_task_numbers do
		local data = 
		{
			task_id =  npos(list),
			task_progress =  npos(list),
			task_state =  npos(list),
		}
		table.insert(war_task_info.user,data)
	end
	_ED.war_task_info.country = war_task_info.country
	_ED.war_task_info.user = war_task_info.user 
end


-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_fail_info 返回城内战斗失败结果6515
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_fail_info( interpreter,datas,pos,strDatas,list,count )
	--击败敌人 挫败兵力 活动荣耀 最高连斩
	_ED.war_fight_fail_info.kill_person = npos(list)
	_ED.war_fight_fail_info.kill_hp = npos(list)
	_ED.war_fight_fail_info.get_hornor = npos(list)
	_ED.war_fight_fail_info.kill_max = npos(list)
	_ED.war_fight_fail_info.otherSideName = npos(list)
	_ED.war_fight_fail_info.otherSideCountry = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_outcome_of_the_battle_in_the_city 返回城内战斗结果6516
-- ---------------------------------------------------------------------------------------------------------
function parse_return_outcome_of_the_battle_in_the_city( interpreter,datas,pos,strDatas,list,count )
	local number = zstring.tonumber(npos(list))
	local matchingData = {}
	for i=1, number do
		matchingData[i] = {}
		local m_datas = {}
		for j=1,2 do
			m_datas[j] = {}
			local Datas = {
				userId = npos(list) ,--攻方ID
				userName = npos(list) ,--攻方昵称
				gender = npos(list) ,--攻方性别
				country = npos(list) ,--攻方国家
				outcome = npos(list) ,--胜负状态(0负1胜)
			}
			m_datas[j]=Datas
		end
		matchingData[i]=m_datas
	end
	_ED.war_city_war_matchingData = nil
	_ED.war_city_war_matchingData = {}	
	_ED.war_city_war_matchingData = matchingData
	--数据交换
	
	local m_attack = nil
	local m_defend = nil
	local m_tindex = 0
	for j ,w in pairs(_ED.war_city_war_matchingData) do
		if zstring.tonumber(_ED.war_in_city_info.now_city_camp) == zstring.tonumber(w[1].country) then
			m_defend = w[1]
			m_attack = w[2]
			_ED.war_city_war_matchingData[j][1] = m_attack
			_ED.war_city_war_matchingData[j][2] = m_defend
		end
	end
	
	local allInfo = {}
	local m_dataOne = nil
	local m_number = 1
	local m_index = 0
	if true then
		for i ,w in pairs(_ED.war_city_war_matchingData) do
			if zstring.tonumber(w[1].userId) == zstring.tonumber(_ED.user_info.user_id) or zstring.tonumber(w[2].userId) == zstring.tonumber(_ED.user_info.user_id) then
				m_index = i
			end
		end
		
		--确认主角
		if m_index==0 then
			allInfo[1] = _ED.war_city_war_matchingData[1]
		else
			allInfo[1] = _ED.war_city_war_matchingData[m_index]
		end
		for j ,z in pairs(_ED.war_city_war_matchingData) do
			if (zstring.tonumber(allInfo[1][1].userId) ~= 0 
				and zstring.tonumber(allInfo[1][1].userId) ~= zstring.tonumber(z[1].userId) 
				and zstring.tonumber(allInfo[1][1].userId) ~= zstring.tonumber(z[2].userId))
				or (zstring.tonumber(allInfo[1][2].userId) ~= 0 
				and zstring.tonumber(allInfo[1][2].userId) ~= zstring.tonumber(z[1].userId) 
				and zstring.tonumber(allInfo[1][2].userId) ~= zstring.tonumber(z[2].userId)) then
				m_number = m_number + 1
				allInfo[m_number] = z
			end		
		end
		if m_number == 3 then
			if (zstring.tonumber(allInfo[2][1].userId) ~= 0 
				and( zstring.tonumber(allInfo[2][1].userId) == zstring.tonumber(allInfo[3][1].userId) 
				or zstring.tonumber(allInfo[2][1].userId) == zstring.tonumber(allInfo[3][2].userId)))
				or (zstring.tonumber(allInfo[2][2].userId) ~= 0 
				and (zstring.tonumber(allInfo[2][2].userId) ~= zstring.tonumber(allInfo[3][1].userId) 
				or zstring.tonumber(allInfo[2][2].userId) ~= zstring.tonumber(allInfo[3][2].userId))) then
				allInfo[2] = allInfo[3]
				allInfo[3] = nil
			end			
		end
		_ED.war_city_war_matchingData = nil
		_ED.war_city_war_matchingData = {}	
		_ED.war_city_war_matchingData = allInfo
	end

	local index = 0
	local isReqlace = false
	local reqlaceData1 = {}
	local reqlaceData2 = {}
	for x ,g in pairs(_ED.war_city_war_matchingData) do
		if zstring.tonumber(g[1].userId) == zstring.tonumber(_ED.user_info.user_id) then
			isReqlace = true
			index = x
		end
	end
	if isReqlace == true and number>1 and index~=2 then
		reqlaceData1 = _ED.war_city_war_matchingData[2]
		reqlaceData2 = _ED.war_city_war_matchingData[index]
		_ED.war_city_war_matchingData[2] = reqlaceData2
		_ED.war_city_war_matchingData[index] = reqlaceData1
	end
	
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_rank_info 返回国战排行榜信息 6517
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_rank_info( interpreter,datas,pos,strDatas,list,count )

	local country_rank_numbers = npos(list)
	local war_rank_info = _ED.war_rank_info or {}

	war_rank_info.country = {}	
	for i=1,tonumber(country_rank_numbers) do	
		local data = 
		{
			rank_order =  npos(list) ,
			rank_camp =  npos(list) ,
			rank_league =  npos(list) ,
			rank_city_num = npos(list),
		}
		table.insert(war_rank_info.country,data)
	end

	war_rank_info.camp1 = {}
	war_rank_info.camp2 = {}
	war_rank_info.camp3 = {}
	for k = 1,3 do
		local personal_rank_numbers = npos(list)
		for i = 1,tonumber(personal_rank_numbers) do
			local data = 
			{
				rank_order =  npos(list),
				rank_lv =  npos(list),
				rank_name =  npos(list),
				rank_sex =  npos(list),
				rank_point =  npos(list),
			}
			local camp = "camp" .. k
			table.insert(war_rank_info[camp],data)
		end
	end
	war_rank_info.rankme = {}
	local rankme_num = npos(list)
	local data = {}
	if tonumber(rankme_num) == 1 then
		data = 
		{
			rank_camp =  npos(list),
			rank_order =  npos(list),
			rank_lv =  npos(list),
			rank_name =  npos(list),
			rank_sex =  npos(list),
			rank_point =  npos(list)
		}
	end
	--print("rank_camp11111111111111111",data.rank_camp)
	war_rank_info.rankme = data

	--print("111111111111111111",war_rank_info.rankme.rank_camp)

	_ED.war_rank_info.country = war_rank_info.country
	_ED.war_rank_info.camp1 = war_rank_info.camp1
	_ED.war_rank_info.camp2 = war_rank_info.camp2
	_ED.war_rank_info.camp3 = war_rank_info.camp3
	_ED.war_rank_info.rankme = war_rank_info.rankme
end


-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_get_order_time 返回国战领旨时间 6518
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_get_order_time( interpreter,datas,pos,strDatas,list,count )
	_ED.warfar_is_open = tonumber(npos(list))
	_ED.warfar_get_order_time = tonumber(npos(list))/1000
	_ED.warfar_get_order_start_time = os.time()
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_get_order_task 返回国战领旨任务 6519
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_get_order_task( interpreter,datas,pos,strDatas,list,count )
	local task_level = npos(list)
	_ED.warfar_get_order_task_level =tonumber(task_level)
	_ED.warfar_get_order_task = {}
	local task_string = npos(list)
	task_string = zstring.split(task_string,",")
	for i,v in pairs(task_string) do
		local task_id = tonumber(v)
		table.insert(_ED.warfar_get_order_task,task_id)
	end
	--debug.print_r(_ED.warfar_get_order_task)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_personal_card_info 返回个人卡牌信息(6520)
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_personal_card_info( interpreter,datas,pos,strDatas,list,count )
	local cardNumber = zstring.tonumber(npos(list))
	local cardInfo = {}
	for i=1,cardNumber do
		cardInfo[i]={
			card_id = npos(list),
			card_use_surplus_number = npos(list),
			card_use_time = npos(list),
		}
	end
	_ED.warfare_card_info = {}
	_ED.warfare_card_info = cardInfo
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_personal_buff_info 返回个人buff信息 6521
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_personal_buff_info( interpreter,datas,pos,strDatas,list,count )
	local buffNumber = zstring.tonumber(npos(list))
	local warfareBuffInfo = {}
	for i=1, buffNumber do
		warfareBuffInfo[i]={
			buff_type = npos(list),
			buff_card_id = npos(list),
		}
	end
	_ED.warfare_buff_personal = {}
	_ED.warfare_buff_personal = warfareBuffInfo
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_get_reward 返回国战奖励， 6522
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_get_reward( interpreter,datas,pos,strDatas,list,count )
	_ED.user_war_get_reward_state = npos(list)
	_ED.user_war_now_country_rank = npos(list)
	_ED.user_war_now_person_rank = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warfare_my_fighting_info 返回个人战报信息（6523）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warfare_my_fighting_info( interpreter,datas,pos,strDatas,list,count )
	local numbers = npos(list)
	_ED.warfar_my_fight_info = {}
	for i=1,numbers do
		_ED.warfar_my_fight_info[i] = {}
		_ED.warfar_my_fight_info[i].name = npos(list) -- 敌方名字
		_ED.warfar_my_fight_info[i].attack_index = npos(list) -- 0 自己是防守方，1 自己是攻击方
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_open_server_days 返回开服天数（6524）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_open_server_days( interpreter,datas,pos,strDatas,list,count )
	_ED.open_server_days = tonumber(npos(list))
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_iron_number 返回用户铁矿数量（12000）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_iron_number( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.user_iron = tonumber(npos(list))
end	


-- ---------------------------------------------------------------------------------------------------------
-- parse_return_system_time 返回服务器时间（12001）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_system_time( interpreter,datas,pos,strDatas,list,count )
	_ED.system_time=npos(list)	 										-- 系统当前时间
	_ED.open_server_time=npos(list)										-- 开服时间
	_ED.system_current_sweep_time = _ED.system_time
	_ED.system_time=tonumber(_ED.system_time)/1000							

	_ED.native_time=os.time()											-- 本地当前时间
	_ED.time_add_or_sub = _ED.system_time - _ED.native_time
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_levelex 返回经验值和等级变更（12002）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_levelex( interpreter,datas,pos,strDatas,list,count )
	local isVerity = true
	if _ED.user_info ~= nil and _ED.user_info.key_user_grade ~= nil then
		local user_grade = aeslua.decrypt("jar-world", _ED.user_info.key_user_grade, aeslua.AES128, aeslua.ECBMODE)
		if tonumber(user_grade) ~= tonumber(_ED.user_info.user_grade) then
			isVerity = false
		end
	end
	if isVerity == false then
        if fwin:find("ReconnectViewClass") == nil then
            fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
        end
        return false
    end

	_ED.user_info.change_experience = npos(list)
	local old_user_grade = _ED.user_info.user_grade
	_ED.user_info.user_grade = npos(list)
	_ED.user_info.user_experience = npos(list)
	_ED.user_info.user_food = npos(list)

	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		if zstring.tonumber(old_user_grade) < zstring.tonumber(_ED.user_info.user_grade) then
			for i,v in pairs(_ED.user_ship) do
				toViewShipPushData(v.ship_id,false,1,-1)
			end
		end
		_ED.user_info.max_user_food = dms.int(dms["user_experience_param"] ,tonumber(_ED.user_info.user_grade) ,user_experience_param.combatFoodCapacity)
	end

	if __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim
		then
		local user_experiencex = dms.int(dms["user_experience_param"],zstring.tonumber(_ED.user_info.user_grade),user_experience_param.needs_experience)
		_ED.user_info.user_grade_need_experience = user_experiencex
	end
	_ED.user_info.key_user_grade = aeslua.encrypt("jar-world", _ED.user_info.user_grade, aeslua.AES128, aeslua.ECBMODE)
	
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("main_window_update_energy", 0, "")
		if tonumber(_ED.user_info.max_user_food) - tonumber(_ED.user_info.user_food) > 0 then
			if _ED.app_push_number[1] == nil or _ED.app_push_number[1] == "" then
				_ED.app_push_number[1] = {}
			end
			if _ED.app_push_number[1][1] ~= nil and _ED.app_push_number[1][1].pushid == 9999 then
				_ED.app_push_number[1][1] = nil
			end
			if _ED.app_push_number[1][1] == nil or _ED.app_push_number[1][1] == "" then
				_ED.app_push_number[1][1] = {}
				_ED.app_push_number[1][1].pushid = 9999
				
				if _ED.app_push_number[1].number == nil or _ED.app_push_number[1].number == "" then
					_ED.app_push_number[1].number = 1
				else
					_ED.app_push_number[1].number = _ED.app_push_number[1].number + 1
				end
				local cdtime = dms.int(dms["user_config"],8,user_config.param)
				local up_push_time = os.time()+ (tonumber(_ED.user_info.max_user_food) - tonumber(_ED.user_info.user_food))*cdtime + _ED.time_add_or_sub
				local system_local_push_list = cc.UserDefault:getInstance():getStringForKey("system_local_push_list")
				local isPush = false
				if system_local_push_list ~= nil and system_local_push_list ~= "" then
					local push_list_info = zstring.split(system_local_push_list ,",")
					if tonumber(push_list_info[tonumber(_app_push_notification[1][4])]) == 0 then
						isPush = true
					end
				else
					isPush = true
				end
				if isPush == true then
					state_machine.excute("platform_push_request", 0, { pushid = 1 , delayTime=up_push_time , system_push_text = _app_push_notification[1][2]})
				end
			end
		end
	end
	
	state_machine.excute("platform_the_role_upgrade", 0, "platform_the_role_upgrade.")
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_pvp_formation_info 返回PVP战斗阵型信息（12003）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_pvp_formation_info( interpreter,datas,pos,strDatas,list,count )
	_ED.other_user_info = _ED.other_user_info or {}
	_ED.other_user_info.ship_formation_type = npos(list)
	_ED.other_user_info.ship_formation = zstring.split(npos(list), ",")
	_ED.other_user_info.user_counts = npos(list)
	_ED.other_user_info.ship_list = {}
	for n=1,tonumber(_ED.other_user_info.user_counts) do
		local ship_id_temp = npos(list)
		local usership = _ED.other_user_info.ship_list[ship_id_temp] or {}
		usership.ship_id = ship_id_temp

		parse_read_all_ship_info(list,usership)
		
		usership.hero_fight = getShipFight(usership)
		_ED.other_user_info.ship_list[usership.ship_id] = usership
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_pvp_user_info 返回PVP战斗玩家信息（12004）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_pvp_user_info( interpreter,datas,pos,strDatas,list,count )
	_ED.other_user_info = _ED.other_user_info or {}
	_ED.other_user_info.user_id = npos(list)
	_ED.other_user_info.user_name = npos(list)
	_ED.other_user_info.user_level = npos(list)
	_ED.other_user_info.user_grade = _ED.other_user_info.user_level
	_ED.other_user_info.user_sex = npos(list)
	_ED.other_user_info.user_head_id = npos(list)
	_ED.other_user_info.fight_capacity = npos(list)
	local majesty_info = npos(list)
	if majesty_info == nil or majesty_info == "" then
		majesty_info = "1,0,0,0"
	end
	_ED.other_user_info.majesty_info = zstring.split(majesty_info,",")
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		_ED.user_info.max_user_food = dms.int(dms["user_experience_param"] ,tonumber(_ED.user_info.user_grade) ,user_experience_param.combatFoodCapacity)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_other_user_info 其他用户信息 12005
-- ---------------------------------------------------------------------------------------------------------
function parse_return_other_user_info( interpreter,datas,pos,strDatas,list,count )
	_ED.other_user_info = _ED.other_user_info  or {}
	_ED.other_user_info.user_id = npos(list)
	_ED.other_user_info.user_name = npos(list)
	_ED.other_user_info.user_arena_id = npos(list)
	_ED.other_user_info.user_fight = npos(list)
	_ED.other_user_info.user_level = npos(list)
	_ED.other_user_info.user_camp = npos(list)
	_ED.other_user_info.user_sex = npos(list)
	-- TODO...
	_ED.other_user_info.user_head_id = npos(list)
	_ED.other_user_info.union_name = npos(list)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		_ED.other_user_info.vip_grade = npos(list)
		_ED.other_user_info.title = npos(list)
		_ED.other_user_info.booming = npos(list)
		_ED.other_user_info.forage = npos(list)
		_ED.other_user_info.base_image = npos(list)	--"天赋id,天赋类型,天赋起始时间,天赋结束时间|天赋id,天赋类型,天赋起始时间,天赋结束时间"
		_ED.other_user_info.rank_id = npos(list)
	end
	--debug.print_r(_ED.other_user_info)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_change_honor 用户声望变更 12006
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_change_honor( interpreter,datas,pos,strDatas,list,count )
	local old_user_honour = _ED.user_info.user_honour
	_ED.user_info.user_honour = npos(list)
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		--武将强化推送
		-- setHeroDevelopAllShipPushState(3)
		if zstring.tonumber(old_user_honour) > zstring.tonumber(_ED.user_info.user_honour) then
			for i,v in pairs(_ED.user_ship) do
				toViewShipPushData(v.ship_id,true,14,-1)
			end
		elseif zstring.tonumber(old_user_honour) < zstring.tonumber(_ED.user_info.user_honour) then
			for i,v in pairs(_ED.user_ship) do
				toViewShipPushData(v.ship_id,false,14,-1)
			end
		end
		state_machine.excute("hero_list_view_update_cell_strength_button_push",0,"hero_list_view_update_cell_strength_button_push.")
		state_machine.excute("hero_list_view_update_cell_equip_button_push",0,"hero_list_view_update_cell_equip_button_push.")
       	state_machine.excute("notification_center_update",0,"push_notification_center_ship_warehouse_all")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_home_hero_icon")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_duplicate_formation")
       	state_machine.excute("formation_update_equip_icon_push",0,"formation_update_equip_icon_push.")
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_change_honor 用户马魂碎片 12007
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_horse_spirit_patch( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.horse_spirits_patch = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_change_honor 用户龙马碎片 12008
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_dragon_horse_patch( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.dragon_horse_patch = npos(list)
end	
-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_change_honor 用户军团贡献 12009
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_union_contribute( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.union_contribute = npos(list)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		_ED.user_info.union_week_contribute = npos(list) 		-- 周贡献

		if _ED.union ~= nil and _ED.union.user_union_info ~= nil then
			_ED.union.user_union_info.rest_contribution = _ED.user_info.union_contribute
		end
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_change_honor 用户总宝石数(vip经验) 12010
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_all_gems( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.user_all_gems = npos(list)
	_ED.recharge_precious_number = _ED.user_info.user_all_gems
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_god_weaponry_open_state 神兵开启状态 12011
-- ---------------------------------------------------------------------------------------------------------
function parse_return_god_weaponry_open_state( interpreter,datas,pos,strDatas,list,count )
	_ED.god_weaponry_open_state = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_union_fight_exploit 返回工会战战功值 12012
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_union_fight_exploit( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.user_union_fight_exploit = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_function_open_state 返回功能是否开启 12013
-- ---------------------------------------------------------------------------------------------------------
function parse_return_function_open_state( interpreter,datas,pos,strDatas,list,count )
	_ED.function_open_states = _ED.function_open_states or {}
	local funcId = npos(list)
	local state = npos(list) -- （0关闭，1开启）
	_ED.function_open_states[""..funcId] = state
end		

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_return_skill_points 返回用户技能点信息 12040
-- ---------------------------------------------------------------------------------------------------------
function parse_return_return_skill_points( interpreter,datas,pos,strDatas,list,count )
	_ED.skill_number_info = npos(list)		--点数,上次恢复时间,购买次数
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_seq_user_sign_info 返回用户技能点信息 12041
-- ---------------------------------------------------------------------------------------------------------
function parse_seq_user_sign_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.user_signature = npos(list)		--个性签名
	--修改名称次数
	local user_data = zstring.splits(npos(list) ,"|",",")
	_ED.user_info.change_name_number = user_data
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_ship_all_speed_info 返回战队总速度 12042
-- ---------------------------------------------------------------------------------------------------------
function parse_return_ship_all_speed_info( interpreter,datas,pos,strDatas,list,count )
	local isVerity = true
	if isVerity == true and _ED.old_ship_all_speed ~= nil then
		local ship_all_speed_info = aeslua.decrypt("jar-world", _ED.old_ship_all_speed, aeslua.AES128, aeslua.ECBMODE)
		if tonumber(ship_all_speed_info) ~= tonumber(_ED.ship_all_speed_info) then
			isVerity = false
		end
	end
	_ED.ship_all_speed_info = tonumber(npos(list))		--战队总速度
	if isVerity == false then
		if fwin:find("ReconnectViewClass") == nil then
			fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
		end
		return false
	else
		_ED.old_ship_all_speed = aeslua.encrypt("jar-world", _ED.ship_all_speed_info, aeslua.AES128, aeslua.ECBMODE)
	end
	getUserSpeedSum()
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_data_reset_info 返回用户数据重置信息 12043
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_data_reset_info( interpreter,datas,pos,strDatas,list,count )
	--npc当前状态 npc最大状态 npc攻击次数 购买次数
	--金币抽卡cd时间 金币免费抽卡次数 高级抽卡cd时间 高级抽卡免费次数 觉醒宝箱cd时间 觉醒宝箱免费次数
	local npcStates = npos(list)
    _ED.npc_last_state = zstring.split(npcStates, ",")
    _ED.npc_last_state1 = zstring.split(npcStates, ",")
	_ED.npc_state=zstring.split(npcStates, ",")						-- 用户当前NPC状态（-1为NPC隐藏状态，0为锁定状态，1为可以攻击第一个战斗组，以此类推）
	_ED.npc_max_state=zstring.split(npos(list), ",")					-- 用户当前NPC的最大状态	
	_ED.npc_current_attack_count = zstring.split(npos(list), ",")		-- 用户当前npc的攻击次数(0,0,0,0,0,0,0)
	_ED.npc_current_buy_count = zstring.split(npos(list), ",")			-- 用户当前npc的购买次数(0,0,0,0,0,0,0)
	_ED.free_info[1].next_free_time = npos(list)						-- 金币抽卡cd时间
	_ED.free_info[1].surplus_free_number = npos(list)					-- 金币免费抽卡次数
	_ED.free_info[1].free_start = os.time()
	_ED.free_info[2].next_free_time = npos(list)						-- 高级抽卡cd时间
	_ED.free_info[2].surplus_free_number = npos(list)					-- 高级抽卡免费次数
	_ED.free_info[2].free_start = os.time()
	_ED.free_info[3].next_free_time = npos(list)						-- 觉醒宝箱cd时间
	_ED.free_info[3].surplus_free_number = npos(list)					-- 觉醒宝箱免费次数
	_ED.free_info[3].free_start = os.time()
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_recruit_state 返回用户抽卡状态 12044
-- ---------------------------------------------------------------------------------------------------------
function parse_return_recruit_state( interpreter,datas,pos,strDatas,list,count )
    _ED.user_recruit_state_info = zstring.split(npos(list), ",")
    if app.configJson.OperatorName == "cayenne" then
	    local return_recruit_1 = cc.UserDefault:getInstance():getStringForKey(getKey("return_recruit_1"))
		if zstring.tonumber(return_recruit_1) >=1 then
		else
			if tonumber(_ED.user_recruit_state_info[1]) == 1 then
				jttd.facebookAPPeventSlogger("4|".._ED.all_servers[_ED.selected_server].server_number.."_".._ED.user_info.user_id.."|1")
				cc.UserDefault:getInstance():setStringForKey(getKey("return_recruit_1"), _ED.user_recruit_state_info[1])
			end
		end
		local return_recruit_2 = cc.UserDefault:getInstance():getStringForKey(getKey("return_recruit_2"))
		if zstring.tonumber(return_recruit_2) >=1 then
		else
			if tonumber(_ED.user_recruit_state_info[2]) == 1 then
				jttd.facebookAPPeventSlogger("4|".._ED.all_servers[_ED.selected_server].server_number.."_".._ED.user_info.user_id.."|2")
				cc.UserDefault:getInstance():setStringForKey(getKey("return_recruit_2"), _ED.user_recruit_state_info[2])
			end
		end
		cc.UserDefault:getInstance():flush()
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_linkage_check_server 12045 -- 返回在hg登录后请求，如果返回服务器id大于0，则限定只能登陆这个服务器
-- ---------------------------------------------------------------------------------------------------------
function parse_linkage_check_server(interpreter,datas,pos,strDatas,list,count)
	local bindInfo = npos(list)
	_ED.linkage_check_serverid = bindInfo
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_title_open_stutas 12046 -- 返回头衔开启
-- ---------------------------------------------------------------------------------------------------------
function parse_title_open_stutas(interpreter,datas,pos,strDatas,list,count)
	-- 当前设置的头衔id|头衔id1:状态,头衔id2:状态,头衔id3:状态,....
	local infos = zstring.split(npos(list), "|")
	_ED.user_rank_title_info = _ED.user_rank_title_info or {}
	_ED.user_rank_title_info._current_title = tonumber(infos[1])
	_ED.user_rank_title_info._title_infos = zstring.splits(infos[2], ",", ":")
	local function SortingOfTitles(a,b)
		local al = zstring.tonumber(dms.string(dms["title_param"], tonumber(a[1]), title_param.sorting))
		local bl = zstring.tonumber(dms.string(dms["title_param"], tonumber(b[1]), title_param.sorting))
		local result = false
		if al < bl then
			result = true
		end
		return result
	end
	table.sort(_ED.user_rank_title_info._title_infos, SortingOfTitles)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_home_build_info 返回城池信息（12100）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_home_build_info( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	for i = 1, count do
		if __lua_project_id == __lua_project_red_alert then
			local id = npos(list)
			local build_id = npos(list)
			local level = npos(list)
			local update_state = npos(list)
			local update_start_time = npos(list)
			local output_start_time = npos(list)
			local output_deviation = npos(list)
			
			_ED.home_build[""..build_id] = _ED.home_build[""..build_id] or {}
			_ED.home_build[""..build_id].id = id
			_ED.home_build[""..build_id].build_id = build_id
			_ED.home_build[""..build_id].level = level
			_ED.home_build[""..build_id].update_state = update_state
			_ED.home_build[""..build_id].update_start_time = math.floor(zstring.tonumber(update_start_time)/1000)
			_ED.home_build[""..build_id].output_start_time = math.floor(zstring.tonumber(output_start_time)/1000)
			_ED.home_build[""..build_id].output_deviation = tonumber(output_deviation)
		else
			_ED.home_build = _ED.home_build or {}
			local id = npos(list)
			local build_ids = zstring.split(npos(list), ",")
			local levels = zstring.split(npos(list), ",")
			if _ED.my_HQ_level == 0 then
				_ED.my_HQ_level = tonumber(levels[1])
			end
			local update_states = zstring.split(npos(list), ",")
			local update_start_times = zstring.split(npos(list), ",")
			local update_time_cds = zstring.split(npos(list), ",")
			local output_start_times = npos(list)
			local output_deviation = npos(list)
			local base_build_ids = zstring.split(npos(list), ",")
			_ED.home_build_max_count = tonumber(npos(list))
			for k,v in pairs(base_build_ids) do
				_ED.home_build[""..v] = _ED.home_build[""..v] or {}
				_ED.home_build[""..v].id = tonumber(id)
				_ED.home_build[""..v].base_mould_id = tonumber(v)
				_ED.home_build[""..v].build_mould_id = tonumber(build_ids[k])
				_ED.home_build[""..v].level = tonumber(levels[k])
				_ED.home_build[""..v].update_state = tonumber(update_states[k])
				_ED.home_build[""..v].update_start_time = zstring.tonumber(update_start_times[k])
				_ED.home_build[""..v].update_time_cd = math.floor(zstring.tonumber(update_time_cds[k])/1000)
				_ED.home_build[""..v].output_start_time = zstring.tonumber(output_start_times)
				_ED.home_build[""..v].output_deviation = tonumber(output_deviation)

				-- _ED.home_build[""..v].build_type = dms.int(dms["build_mould"], _ED.home_build[""..v].base_mould_id, build_mould.build_type)

				if tonumber(_ED.home_build[""..v].update_state) == 1 then
					if _ED.app_push_number[2] == nil or _ED.app_push_number[2] == "" then
						_ED.app_push_number[2] = {}
					end
					if _ED.app_push_number[2][_ED.home_build[""..v].base_mould_id] ~= nil and _ED.app_push_number[2][_ED.home_build[""..v].base_mould_id].pushid == _ED.home_build[""..v].base_mould_id then
						_ED.app_push_number[2][_ED.home_build[""..v].base_mould_id] = nil
					end
					if _ED.app_push_number[2][_ED.home_build[""..v].base_mould_id] == nil or _ED.app_push_number[2][_ED.home_build[""..v].base_mould_id] == "" then
						_ED.app_push_number[2][_ED.home_build[""..v].base_mould_id] = {}
						_ED.app_push_number[2][_ED.home_build[""..v].base_mould_id].pushid = _ED.home_build[""..v].base_mould_id
						
						if _ED.app_push_number[2].number == nil or _ED.app_push_number[2].number == "" then
							_ED.app_push_number[2].number = 1
						else
							_ED.app_push_number[2].number = _ED.app_push_number[2].number + 1
						end
						local up_push_time = (_ED.home_build[""..v].update_start_time+_ED.home_build[""..v].update_time_cd) + _ED.time_add_or_sub
						local name = dms.string(dms["build_mould"],_ED.home_build[""..v].build_mould_id,build_mould.build_name)
						local system_push_text = string.format(_app_push_notification[2][2],name,_ED.home_build[""..v].level+1)
						local system_local_push_list = cc.UserDefault:getInstance():getStringForKey("system_local_push_list")
						local isPush = false
						if system_local_push_list ~= nil and system_local_push_list ~= "" then
							local push_list_info = zstring.split(system_local_push_list ,",")
							if tonumber(push_list_info[tonumber(_app_push_notification[2][4])]) == 0 then
								isPush = true
							end
						else
							isPush = true
						end
						if isPush == true then
							state_machine.excute("platform_push_request", 0, { pushid = 2 , delayTime=up_push_time , system_push_text = system_push_text, push_number_id = _ED.home_build[""..v].base_mould_id})
						end
					end
				end
			end
		end
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_barracks_info 返回用户兵营科技（12101）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_barracks_info( interpreter,datas,pos,strDatas,list,count )

	if __lua_project_id == __lua_project_red_alert then
		_ED.barracks_leave_time = math.floor(tonumber(npos(list)) / 1000)
		_ED.barracks_start_time = os.time()
		-- print("==============time====",_ED.barracks_leave_time,_ED.barracks_start_time)
		local count = tonumber(npos(list))
		for i = 1 ,count do
			local id = npos(list)
			local barrack_id = npos(list)
			local barrack_level = npos(list)
		
			_ED.barracks_info[""..barrack_id] = _ED.barracks_info[""..barrack_id] or {}
			_ED.barracks_info[""..barrack_id].id = id
			_ED.barracks_info[""..barrack_id].barrack_id = barrack_id
			_ED.barracks_info[""..barrack_id].barrack_level = barrack_level

			local element_data = dms.element(dms["teach_escalate_param"],barrack_id)
			_ED.barracks_info[""..barrack_id].name = dms.atos(element_data,teach_escalate_param.name)
			_ED.barracks_info[""..barrack_id].pic_index = dms.atoi(element_data,teach_escalate_param.pic_index)
			_ED.barracks_info[""..barrack_id].update_group = dms.atoi(element_data,teach_escalate_param.update_group)
			_ED.barracks_info[""..barrack_id].open_level = dms.atoi(element_data,teach_escalate_param.open_level)
		end
	else
		_ED.barracks_info = _ED.barracks_info or {}
		local count = tonumber(npos(list))
		for i = 1, count do
			local barrackInfo = {}
			barrackInfo.id = npos(list)
			barrackInfo.barrack_id = npos(list)
			barrackInfo.barrack_level = npos(list)
			barrackInfo.barrack_state = npos(list)
			barrackInfo.barrack_upgrade_time = math.floor(zstring.tonumber(npos(list))/1000)
			barrackInfo.barrack_upgrade_cd = math.floor(zstring.tonumber(npos(list))/1000)
			_ED.barracks_info[""..barrackInfo.barrack_id] = barrackInfo
			if tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_state) == 1 then
				if _ED.app_push_number[3] == nil or _ED.app_push_number[3] == "" then
					_ED.app_push_number[3] = {}
				end
				if _ED.app_push_number[3][tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)] ~= nil and _ED.app_push_number[3][tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)].pushid == tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id) then
					_ED.app_push_number[3][tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)] = nil
				end
				if _ED.app_push_number[3][tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)] == nil or _ED.app_push_number[3][tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)] == "" then
					_ED.app_push_number[3][tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)] = {}
					_ED.app_push_number[3][tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)].pushid = tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)
					
					if _ED.app_push_number[3].number == nil or _ED.app_push_number[3].number == "" then
						_ED.app_push_number[3].number = 1
					else
						_ED.app_push_number[3].number = _ED.app_push_number[3].number + 1
					end
					local up_push_time = (_ED.barracks_info[""..barrackInfo.barrack_id].barrack_upgrade_time+_ED.barracks_info[""..barrackInfo.barrack_id].barrack_upgrade_cd) + _ED.time_add_or_sub 
					local name = dms.string(dms["teach_escalate_param"],_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id,teach_escalate_param.name)
					local system_push_text = string.format(_app_push_notification[3][2],name,tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_level)+1)
					local system_local_push_list = cc.UserDefault:getInstance():getStringForKey("system_local_push_list")
					local isPush = false
					if system_local_push_list ~= nil and system_local_push_list ~= "" then
						local push_list_info = zstring.split(system_local_push_list ,",")
						if tonumber(push_list_info[tonumber(_app_push_notification[3][4])]) == 0 then
							isPush = true
						end
					else
						isPush = true
					end
					if isPush == true then
						state_machine.excute("platform_push_request", 0, { pushid = 3 , delayTime=up_push_time , system_push_text = system_push_text, push_number_id = tonumber(_ED.barracks_info[""..barrackInfo.barrack_id].barrack_id)})
					end
				end
			end	
		end
	end
	-- print("==============",_ED.barracks_leave_time)
	-- debug.print_r(_ED.barracks_info)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_majesty_info 返回主公技（12102）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_majesty_info( interpreter,datas,pos,strDatas,list,count )
	local majesty_info = npos(list)
	if majesty_info == nil or majesty_info == "" then
		if __lua_project_id == __lua_project_red_alert then
			majesty_info = "1,0,0,0"
		else
			majesty_info = "0,0,0,0,0,0,0,0,0,0,0,0"
		end
	end
	_ED.majesty_info = zstring.split(majesty_info, ",")
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_fate_times 返回祭祀次数（12103）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_fate_times( interpreter,datas,pos,strDatas,list,count )
	 _ED.now_week_day = tonumber(npos(list))
	 -- 当前收费祭祀消耗次数
	 local silver_cost_times = npos(list)
	 local equip_cost_times = npos(list)
	 local gems_cost_times = npos(list)
	 local star_cost_times = npos(list)
	 -- 当前免费祭祀消耗次数
	 local silver_free_times = npos(list)
	 local equip_free_times = npos(list)
	 local gems_free_times = npos(list)
	 local star_free_times = npos(list)

	 _ED.fate_times = _ED.fate_times or {}
	 _ED.fate_times[1] = _ED.fate_times[1] or {}
	 _ED.fate_times[2] = _ED.fate_times[2] or {}
	 _ED.fate_times[3] = _ED.fate_times[3] or {}
	 _ED.fate_times[4] = _ED.fate_times[4] or {}
	 _ED.fate_times[1].cost_times = silver_cost_times
	 _ED.fate_times[1].free_times = silver_free_times
	 _ED.fate_times[2].cost_times = equip_cost_times
	 _ED.fate_times[2].free_times = equip_free_times
	 _ED.fate_times[3].cost_times = gems_cost_times
	 _ED.fate_times[3].free_times = gems_free_times
	 _ED.fate_times[4].cost_times = star_cost_times
	 _ED.fate_times[4].free_times = star_free_times
	 -- debug.print_r(_ED.fate_times)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_all_max_packs 返回资源容量上限 12104
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_all_max_packs( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.user_iron_max = npos(list)		-- 最大铁矿
	_ED.user_info.oil_field_max = npos(list)		-- 最大油矿
	_ED.user_info.exploits_max = npos(list)		-- 最大铅矿
	_ED.user_info.tiger_shaped_max = npos(list)		-- 最大钛矿
	_ED.user_info.user_silver_max = npos(list)		-- 最大宝石矿
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_production_info 返回生产信息 12105
-- ---------------------------------------------------------------------------------------------------------
function parse_return_production_info( interpreter,datas,pos,strDatas,list,count )
	local ncount = npos(list)
	_ED.production_info = {}
	for i=1,tonumber(ncount) do
		local info = {}
		info.id = npos(list)
		info.ntype = npos(list)					-- (0:坦克生产1, 1:坦克生产2, 2:改造 3:制造)
		info.mould_id = npos(list)
		info.count = npos(list)
		info.production_state = npos(list)		--(0:生产中, 1:等待中)
		info.production_start_time = math.floor(zstring.tonumber(npos(list))/1000)
		info.production_start_cd = math.floor(zstring.tonumber(npos(list))/1000)
		if _ED.production_info[""..info.ntype] == nil then
			_ED.production_info[""..info.ntype] = {}
		end
		_ED.production_info[""..info.ntype][""..info.id] = info
	end

end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_build_auto_upgrade_state 返回自动建造信息 12106
-- ---------------------------------------------------------------------------------------------------------
function parse_return_build_auto_upgrade_state( interpreter,datas,pos,strDatas,list,count )
	_ED.build_auto_upgrade_state = npos(list)	-- (0:关闭 1:开启)
	_ED.build_auto_upgrade_time = npos(list)	-- 结束时间戳
	_ED.build_auto_upgrade_cd = npos(list)	-- 结束时间段
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_resource_output_per_hour 返回用户资源产出信息 12107
-- ---------------------------------------------------------------------------------------------------------
function parse_return_resource_output_per_hour( interpreter,datas,pos,strDatas,list,count )
	_ED.output_per_hour_iron = npos(list)	-- 铁矿产量
	_ED.output_per_hour_oil = npos(list)	-- 油矿产量
	_ED.output_per_hour_exploits = npos(list)	-- 铅矿产量
	_ED.output_per_hour_tiger = npos(list)	-- 钛矿产量
	_ED.output_per_hour_silver = npos(list)	-- 宝石产量
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_warehouse_capacity 返回用户资源仓库容量信息 12108
-- ---------------------------------------------------------------------------------------------------------
function parse_return_warehouse_capacity( interpreter,datas,pos,strDatas,list,count )
	_ED.warehouse_capacity_iron = npos(list)	-- 铁矿容量
	_ED.warehouse_capacity_oil = npos(list)	-- 油矿容量
	_ED.warehouse_capacity_exploits = npos(list)	-- 铅矿容量
	_ED.warehouse_capacity_tiger = npos(list)	-- 钛矿容量
	_ED.warehouse_capacity_silver = npos(list)	-- 宝石容量
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_update_time_factor 返回用户时间消耗增益信息 12109
-- ---------------------------------------------------------------------------------------------------------
function parse_return_update_time_factor( interpreter,datas,pos,strDatas,list,count )
	_ED.build_time_factor = zstring.tonumber(npos(list))	         -- 建筑升级时间增益
	_ED.barracks_time_factor = zstring.tonumber(npos(list))	     -- 科技时间增益
	_ED.production_time_factor = zstring.tonumber(npos(list))	 -- 生产时间增益
	_ED.reform_time_factor = zstring.tonumber(npos(list))	     -- 改造时间增益
	_ED.battle_exp_factor = zstring.tonumber(npos(list))	     -- 战斗经验增益
	_ED.world_map_mobile_factor = zstring.tonumber(npos(list))	  -- 行军时间增益
	_ED.rebel_haunt_mobile_factor = zstring.tonumber(npos(list))	  -- 叛军时间增益
	_ED.max_ship_load_factor = zstring.tonumber(npos(list))/100	  -- 载重百分比
	_ED.world_map_help_move_factor = zstring.tonumber(npos(list))	  -- 协防行军加速
	_ED.repair_cost_factor = zstring.tonumber(npos(list))           -- 修理消耗减少
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_home_build_level_up 返回建筑升级 12110
-- ---------------------------------------------------------------------------------------------------------
function parse_home_build_level_up( interpreter,datas,pos,strDatas,list,count )
	local build_id = npos(list)
	local build_mould_id = npos(list)
	local build_level = npos(list)
	local build_base_mould_id = npos(list)
	local mould_id_info = zstring.split(build_mould_id, ",")
	local level_info = zstring.split(build_level, ",")
	if zstring.tonumber(level_info[1]) ~= _ED.my_HQ_level then
		if zstring.tonumber(level_info[1]) == 3 then
			jttd.facebookAPPeventSlogger("5")
		elseif zstring.tonumber(level_info[1]) == 6 then
			jttd.facebookAPPeventSlogger("6")
		elseif zstring.tonumber(level_info[1]) == 16 then
			jttd.facebookAPPeventSlogger("7")
		elseif zstring.tonumber(level_info[1]) == 26 then
			jttd.facebookAPPeventSlogger("8")
		elseif zstring.tonumber(level_info[1]) == 30 then
			jttd.facebookAPPeventSlogger("9")
		end
		_ED.my_HQ_level = zstring.tonumber(level_info[1])
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_home_patrol_reward_info 返回主城巡逻兵奖励信息 12111
-- ---------------------------------------------------------------------------------------------------------
function parse_home_patrol_reward_info( interpreter,datas,pos,strDatas,list,count )
	_ED.home_patrol_reeard_info = {}
	_ED.home_patrol_reeard_info.normal_reward_times = tonumber(npos(list))
	_ED.home_patrol_reeard_info.high_reward_times = tonumber(npos(list))
	npos(list)
	_ED.home_patrol_reeard_info.last_calc_times = tonumber(npos(list))/1000
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_oil_field 用户油矿 12014
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_oil_field( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.oil_field = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_exploits 用户铅矿 12015
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_exploits( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.exploits = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_tiger_shaped 用户钛矿 12016
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_tiger_shaped( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.tiger_shaped = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_booming 用户繁荣度 12017
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_booming( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.booming = npos(list)		-- 当前繁荣度
	_ED.user_info.forage = npos(list)		-- 最大繁荣度
	state_machine.excute("adventure_mine_update_user_city", 0, nil)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_credit 用户声望 12018
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_credit( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.credit_level = npos(list) 	-- 声望等级
	_ED.user_info.credit = npos(list)		-- 当前声望
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_credit_buy_state 用户声望购买状态 12019
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_credit_buy_state( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.credit_buy_state = npos(list) 	-- 声望购买状态，0：未购买，1：已购买
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_war_industry 返回用户军功信息 12020
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_war_industry( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.current_war_industry = npos(list)		--今日军功
	_ED.user_info.total_war_industry = npos(list)		--累积军功
	_ED.user_info.war_industry_level = npos(list)		--军功等级
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_command_level 返回用户统率升级信息 12021
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_command_level( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.command_state = npos(list)	--是否失败(0:成功 1:失败)
	_ED.user_info.command_level = npos(list)	--统率等级
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_famtion 返回用户带兵量信息 12022
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_famtion( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.last_soldier = _ED.user_info.soldier
	_ED.user_info.soldier = npos(list)	   -- 带兵量
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_formation_info 返回用户阵型信息 12023
-- ---------------------------------------------------------------------------------------------------------
function parse_return_formation_info( interpreter,datas,pos,strDatas,list,count )
	local count = npos(list)
	_ED.formation = {}
	for i=1,tonumber(count) do
		local ntype = npos(list)
		if _ED.formation[""..ntype] == nil then
			_ED.formation[""..ntype] = {}
		end
		local formation = {}
		for i=1,6 do
			local info = {}
			info.ship_id = npos(list)
			info.count = npos(list)
			info.leader_id = npos(list)
			table.insert(formation, info)
		end
		table.insert(_ED.formation[""..ntype], formation)
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_fighter_capacity 返回用户战力信息 12024
-- ---------------------------------------------------------------------------------------------------------
function parse_return_fighter_capacity( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.fighter_capacity = zstring.tonumber(npos(list))
	if _ED.tank_draw_lottery == true then
		return
	end	
	showFightUpOrDown()
	state_machine.excute("main_window_update_fighting", 0, nil)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_factor_info 返回用户限时增益信息 12025
-- ---------------------------------------------------------------------------------------------------------
function parse_return_factor_info( interpreter,datas,pos,strDatas,list,count )
	_ED.factor_info = {}
	_ED.factor_permanent = {}
	local count = tonumber(npos(list))
	for i=1, count do
		local info = {}
		info.id = npos(list)           -- 增益实例id
		info.mould_id = npos(list) 		-- 增益模板id
		info.factor_type = npos(list) 		-- 增益类型
		info.factor_obj = npos(list)		-- 增益对象
		info.factor_start_time = math.floor(zstring.tonumber(npos(list))/1000)		-- 增益开始时间
		info.factor_cd_time = math.floor(zstring.tonumber(npos(list))/1000)		-- 增益cd时间

		info.build_buff_id = 0 			-- 索引建筑增益光环模板id
		local build_ids = zstring.split(dms.string(dms["talent_mould"], info.mould_id, talent_mould.build_buff_id), ",")
		if #build_ids == 1 then 
			info.build_buff_id = tonumber(build_ids[1])
		else
			info.build_buff_id = tonumber(info.factor_obj)
		end
		
		_ED.factor_info[""..info.id] = info
		--永久增益
		if info.factor_cd_time == -1 then
			_ED.factor_permanent[""..info.id] = info
		end
	end
	_ED.factor_info_changed = true
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_the_user_avatar_activation_status 返回用户头像激活状态 12026
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_the_user_avatar_activation_status( interpreter,datas,pos,strDatas,list,count )
	_ED.user_head_activation = npos(list) --激活状态下标集合(0,0,0,0,0)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_the_user_avatar_information 返回用户头像信息 12027
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_the_user_avatar_information( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.user_head_id = npos(list) --激活状态下标集合(0,0,0,0,0)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_the_user_attribute_addition_information 返回用户属性加成信息 12028
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_the_user_attribute_addition_information( interpreter,datas,pos,strDatas,list,count )
	_ED.user_attributes_addition = {}
	local arms1 = {}
	local arms2 = {}
	local arms3 = {}
	local arms4 = {}
	--血量
	arms1.HPAdditionRatio = npos(list)
	arms2.HPAdditionRatio = npos(list)
	arms3.HPAdditionRatio = npos(list)
	arms4.HPAdditionRatio = npos(list)
	--攻击
	arms1.AttackAdditionRatio = npos(list)
	arms2.AttackAdditionRatio = npos(list)
	arms3.AttackAdditionRatio = npos(list)
	arms4.AttackAdditionRatio = npos(list)
	--命中
	arms1.Hit = npos(list)
	arms2.Hit = npos(list)
	arms3.Hit = npos(list)
	arms4.Hit = npos(list)
	--闪避
	arms1.Dodge = npos(list)
	arms2.Dodge = npos(list)
	arms3.Dodge = npos(list)
	arms4.Dodge = npos(list)
	--暴击
	arms1.Crit = npos(list)
	arms2.Crit = npos(list)
	arms3.Crit = npos(list)
	arms4.Crit = npos(list)
	--抗暴
	arms1.Anti = npos(list)
	arms2.Anti = npos(list)
	arms3.Anti = npos(list)
	arms4.Anti = npos(list)
	--穿透
	arms1.penetrate = npos(list)
	arms2.penetrate = npos(list)
	arms3.penetrate = npos(list)
	arms4.penetrate = npos(list)
	--防护
	arms1.shelter = npos(list)
	arms2.shelter = npos(list)
	arms3.shelter = npos(list)
	arms4.shelter = npos(list)
	_ED.user_attributes_addition[1] = arms1
	_ED.user_attributes_addition[2] = arms2
	_ED.user_attributes_addition[3] = arms3
	_ED.user_attributes_addition[4] = arms4

	-- debug.print_r(_ED.user_attributes_addition)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_user_function_push_info 返回初始化用户推送信息（12029）
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_user_function_push_info( interpreter,datas,pos,strDatas,list,count )
	_ED.mould_function_push_info = _ED.mould_function_push_info or {}
	--(1:战地争霸 2:远征 3:学霸 4:敌军来袭 5:叛军出没 6:极限挑战 11:兄弟同享 12:任务 13:守卫战 14:城市战
	-- 15:城市战商店 16:中立工厂 17:战力榜第一名)
	local push_info = {}
	push_info.nType = npos(list)
	push_info.state = npos(list)
	push_info.params = npos(list)
	push_info.start_time = os.time() + _ED.time_add_or_sub
	_ED.mould_function_push_info[""..push_info.nType] = push_info
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_mine_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_in_box_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_attack")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_defense")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_scout")
		state_machine.excute("notification_center_update", 0, "push_notification_campaign_cell")
		state_machine.excute("notification_center_update", 0, "push_notification_all_daily_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_all_linited_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_all_inter_service_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_campaign_expedition")
		state_machine.excute("notification_center_update", 0, "push_notification_brothers_personal")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_treasure_push")
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_task")
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_complete_function_push_info 返回全服推送信息（12030）
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_complete_function_push_info( interpreter,datas,pos,strDatas,list,count )
	_ED.mould_function_push_info = _ED.mould_function_push_info or {}
	local nType = npos(list)
	local state = npos(list)	
	local params = npos(list)
	local start_time = os.time() + _ED.time_add_or_sub

	local last_state = nil
	if _ED.mould_function_push_info[""..nType] ~= nil then
		last_state = _ED.mould_function_push_info[""..nType].state
		_ED.mould_function_push_info[""..nType].state = state
		_ED.mould_function_push_info[""..nType].nType = nType
		_ED.mould_function_push_info[""..nType].params = params
		_ED.mould_function_push_info[""..nType].start_time = start_time
	else
		local push_info = {}
		push_info.nType = nType
		push_info.state = state
		push_info.params = params
		push_info.start_time = start_time
		_ED.mould_function_push_info[""..nType] = push_info
	end
	state_machine.excute("campaign_change_update_state", 0, nil)
	if tonumber(nType) == 1 then
		state_machine.excute("home_map_change_home_build_top_info", 0, nil)
	elseif tonumber(nType) == 3 
		or tonumber(nType) == 5 
		or tonumber(nType) == 9
		then
		state_machine.excute("home_map_update_prodcution_state", 0, {5})
		if tonumber(nType) == 9 then
			if last_state ~= _ED.mould_function_push_info[""..nType].state then
				if _ED.union.union_hegemony_info ~= nil then
					_ED.union.union_hegemony_info.state = tonumber(state)
				end
				state_machine.excute("legion_hegemony_update_state", 0, {tonumber(state)})
			end
		end
	elseif tonumber(nType) == 4 then
		if last_state ~= _ED.mould_function_push_info[""..nType].state then
			if zstring.tonumber(_ED.mould_function_push_info[""..nType].state) == 1 then
				state_machine.excute("adventure_mine_enemy_boss_change_state", 0, nil)
				state_machine.excute("enemy_strike_world_box_request_init", 0, nil)
			end
		end
		state_machine.excute("home_map_update_prodcution_state", 0, {5})
	elseif tonumber(nType) == 10 then
		if last_state ~= _ED.mould_function_push_info[""..nType].state then
			if _ED.camp_pk_info ~= nil then
				_ED.camp_pk_info.state = tonumber(state)
			end
			state_machine.excute("camp_pk_challge_change_state_request", 0, nil)
		end
		state_machine.excute("home_map_update_prodcution_state", 0, {5})
	elseif tonumber(nType) == 12 then	
		getRedAlertTimeTaskTip()
		if fwin:find("TaskClass") ~= nil then
			state_machine.excute("task_window_close", 0, nil)
		end
	elseif tonumber(nType) == 13 then
		if last_state ~= _ED.mould_function_push_info[""..nType].state then
			if _ED.guard_battle_stronghold_info ~= nil then
				_ED.guard_battle_stronghold_info.state = tonumber(state)
			end
			state_machine.excute("guard_battle_update_state", 0, {tonumber(state)})	
		end
		state_machine.excute("home_map_update_prodcution_state", 0, {5})
	elseif tonumber(nType) == 14 then
		-- 城市战
		state_machine.excute("legion_city_request_init", 0, "")
		state_machine.excute("home_map_update_prodcution_state", 0, {5})
		state_machine.excute("red_alert_time_mine_update_city_energy_info", 0, nil)
		state_machine.excute("main_window_update_city_energy_info", 0, nil)
	elseif tonumber(nType) == 15 then
		-- 城市战商店状态刷新
		state_machine.excute("legion_city_shop_change_state", 0, {tonumber(state)})
		state_machine.excute("main_window_update_city_energy_info", 0, "")
		state_machine.excute("red_alert_time_mine_update_city_energy_info", 0, "")
	elseif tonumber(nType) == 16 then
		-- 中立工厂状态刷新
		state_machine.excute("legion_city_request_init", 0, "")
	elseif tonumber(nType) == 17 then
		-- 战力榜第一名显示
		state_machine.excute("home_map_update_prodcution_state", 0, {55})
	end

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_mine_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_in_box_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_attack")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_defense")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_scout")
		state_machine.excute("notification_center_update", 0, "push_notification_campaign_cell")
		state_machine.excute("notification_center_update", 0, "push_notification_all_daily_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_all_linited_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_all_inter_service_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_campaign_expedition")
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_task")
	end
end	
-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_mission_skip_info 返回用户事件跳过记录（12031）
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_mission_skip_info( interpreter,datas,pos,strDatas,list,count )
	local arrs = zstring.split(npos(list), "|")
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
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_booming_info 返回繁荣度恢复信息(12032)
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_booming_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_info.booming_time = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_change_user_name 返回用户昵称信息(12033)
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_change_user_name( interpreter,datas,pos,strDatas,list,count )
	local user_id = npos(list)
	local user_name = npos(list)
	if tonumber(_ED.user_info.user_id) == tonumber(user_id) then
		_ED.user_info.user_name = user_name
		state_machine.excute("main_window_update_head_info", 0, nil)
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_data_combine 返回用户跨服数据合并中(12034)
-- ---------------------------------------------------------------------------------------------------------
function parse_user_data_combine( interpreter,datas,pos,strDatas,list,count )
	_ED.wait_user_data_combine = true
	state_machine.excute("connecting_view_window_open", 0, 0)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_remove_factor_info 返回移除用户增益 12035
-- ---------------------------------------------------------------------------------------------------------
function parse_return_remove_factor_info( interpreter,datas,pos,strDatas,list,count )
	_ED.factor_info = _ED.factor_info or {}
	_ED.factor_permanent = _ED.factor_info or {}
	local id = npos(list)
	_ED.factor_info[""..id] = nil
	_ED.factor_permanent[""..id] = nil
	_ED.factor_info_changed = true
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_update_factor_info 返回更新用户增益 12036
-- ---------------------------------------------------------------------------------------------------------
function parse_return_update_factor_info( interpreter,datas,pos,strDatas,list,count )
	_ED.factor_info = _ED.factor_info or {}
	_ED.factor_permanent = _ED.factor_info or {}

	local info = {}
	info.id = npos(list)           -- 增益实例id
	info.mould_id = npos(list) 		-- 增益模板id
	info.factor_type = npos(list) 		-- 增益类型
	info.factor_obj = npos(list)		-- 增益对象
	info.factor_start_time = math.floor(zstring.tonumber(npos(list))/1000)		-- 增益开始时间
	info.factor_cd_time = math.floor(zstring.tonumber(npos(list))/1000)		-- 增益cd时间

	info.build_buff_id = 0 			-- 索引建筑增益光环模板id
	local build_ids = zstring.split(dms.string(dms["talent_mould"], info.mould_id, talent_mould.build_buff_id), ",")
	if #build_ids == 1 then 
		info.build_buff_id = tonumber(build_ids[1])
	else
		info.build_buff_id = tonumber(info.factor_obj)
	end
	
	_ED.factor_info[""..info.id] = info
	--永久增益
	if info.factor_cd_time == -1 then
		_ED.factor_permanent[""..info.id] = info
	end

	_ED.factor_info_changed = true
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_info_level_up 返回用户等级变更 12037
-- ---------------------------------------------------------------------------------------------------------
function parse_user_info_level_up( interpreter,datas,pos,strDatas,list,count )
	local level = npos(list)
	state_machine.excute("platform_the_role_upgrade", 0, "platform_the_role_upgrade.")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_title_info 返回用户称号信息 12038
-- ---------------------------------------------------------------------------------------------------------
function parse_user_title_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_title_info = {}
	local count = tonumber(npos(list))
	for i = 1,count do
		local title_id = npos(list)
		local end_time = tonumber(npos(list))/1000
		_ED.user_title_info[title_id] = end_time
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_system_base_time 同步系统时区时间 12039
-- ---------------------------------------------------------------------------------------------------------
function parse_system_base_time( interpreter,datas,pos,strDatas,list,count )
	local server_zero_time = npos(list)
	local server_time = tonumber(npos(list))/1000
	server_zero_time = zstring.split(server_zero_time, "|")
	local data = {
		year = tonumber(server_zero_time[1]),
	    month = tonumber(server_zero_time[2]),
	    day = tonumber(server_zero_time[3]),
	    hour = 0,
	    min = 0,
	    sec = 0
	}
	local client_time = os.time(data)
	_ED.GTM_Time = server_time - client_time
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_gems 返回宝石信息（12200）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_gems( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	for i = 1 ,count do
		local id = npos(list)
		local mould_id = npos(list)
		local exp = tonumber(npos(list))
		local equip_id = npos(list)
        local level = dms.int(dms["gems_mould"],mould_id,gems_mould.level)
        local name = dms.string(dms["gems_mould"],mould_id,gems_mould.name)
        local init_exp = dms.int(dms["gems_mould"],mould_id,gems_mould.have_exp)
        local up_need_exp = dms.int(dms["gems_mould"],mould_id,gems_mould.up_need_exp)
        local gem_type = dms.int(dms["gems_mould"],mould_id,gems_mould.gem_type)
        
		_ED.user_gems[""..id] = _ED.user_gems[""..id] or {}
		_ED.user_gems[""..id].id = id
		_ED.user_gems[""..id].mould_id = mould_id
		_ED.user_gems[""..id].exp = exp
		_ED.user_gems[""..id].equip_id = equip_id
		_ED.user_gems[""..id].level = level
		_ED.user_gems[""..id].name = name
		_ED.user_gems[""..id].init_exp = init_exp
		_ED.user_gems[""..id].give_exp = init_exp + exp
		_ED.user_gems[""..id].up_need_exp = up_need_exp
		_ED.user_gems[""..id].gem_type = gem_type
		
		
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_remove_user_gems 返回宝石信息（12201）
-- ---------------------------------------------------------------------------------------------------------
function parse_remove_user_gems( interpreter,datas,pos,strDatas,list,count )
	local id = npos(list)
	_ED.user_gems[""..id] = nil
end	


-- ---------------------------------------------------------------------------------------------------------
-- parse_return_other_user_gems 返回其他用户宝石信息（12202）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_other_user_gems( interpreter,datas,pos,strDatas,list,count )
	_ED.other_user_gems = _ED.other_user_gems or {}
	local count = tonumber(npos(list))
	for i = 1 ,count do
		local id = npos(list)
		local mould_id = npos(list)
		local exp = npos(list)
		local equip_id = npos(list)
        local level = dms.int(dms["gems_mould"],mould_id,gems_mould.level)
        local name = dms.string(dms["gems_mould"],mould_id,gems_mould.name)
		_ED.other_user_gems[""..id] = _ED.other_user_gems[""..id] or {}
		_ED.other_user_gems[""..id].id = id
		_ED.other_user_gems[""..id].mould_id = mould_id
		_ED.other_user_gems[""..id].exp = exp
		_ED.other_user_gems[""..id].equip_id = equip_id
		_ED.other_user_gems[""..id].level = level
		_ED.other_user_gems[""..id].name = name
		
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_horses 返回战马信息（12300）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_horses( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	for i = 1 ,count do
		local id = npos(list)
		_ED.horses[""..id] = _ED.horses[""..id] or {}
		local mould_id = npos(list)
		local ship_id = npos(list)
		local attribute = npos(list)
		_ED.horses[""..id].horse_spirits = _ED.horses[""..id].horse_spirits or {}
		for j = 1 ,6 do 
			_ED.horses[""..id].horse_spirits[j] = npos(list)
		end

		_ED.horses[""..id].id = id
		_ED.horses[""..id].mould_id = mould_id
		_ED.horses[""..id].ship_id = ship_id
		_ED.horses[""..id].attribute = attribute
	end
end	

-- 
-- function parse_return_all_user_weapon_book( interpreter,datas,pos,strDatas,list,count )
-- 	_ED.weapon_book_number=5--npos(list)							--用户兵符数量
-- 	_ED.weapon_book = {}	
-- 	for n=1,tonumber(_ED.weapon_book_number) do
-- 		local equip_id = n--npos(list)
-- 		local equipment_mould_id = 73 + n--npos(list)
-- 		local equip_data = dms.element(dms["equipment_mould"],equipment_mould_id)
-- 		local equipment_name = dms.atos(equip_data,equipment_mould.equipment_name)
-- 		local equip_type = dms.atoi(equip_data,equipment_mould.equipment_type)
-- 		local equip_quality = dms.atoi(equip_data,equipment_mould.grow_level)
-- 		local equip_rank_level = dms.atoi(equip_data,equipment_mould.rank_level)
-- 		local equipment_gem_numbers = dms.atoi(equip_data,equipment_mould.equipment_gem_numbers) 		-- 技能槽数
-- 		local weapon_book_attr_ids = dms.atos(equip_data,equipment_mould.weapon_book_attr_ids) 			-- 技能id
-- 		local icon = dms.atoi(equip_data, equipment_mould.All_icon) 			-- 图标id

-- 		local weapon_book = _ED.weapon_book[equip_id] or {}
		
-- 		weapon_book.user_equiment_id = equip_id						--用户兵符ID号
-- 		weapon_book.user_equiment_template = equipment_mould_id				--用户兵符模版ID号
-- 		weapon_book.user_equiment_name = equipment_name					--用户兵符名称
-- 		weapon_book.equipment_type = equip_type						--装备类型
-- 		weapon_book.ship_id = "0"--npos(list)								--绑定战船id
-- 		weapon_book.user_equiment_grade = 1					--用户兵符等级
-- 		weapon_book.quality = equip_quality						-- 品质
-- 		weapon_book.rank_level = equip_rank_level 					-- 品级
-- 		weapon_book.gem_numbers = equipment_gem_numbers
-- 		weapon_book.attr_ids = zstring.split(weapon_book_attr_ids, ",")
-- 		weapon_book.icon = icon
		
-- 		weapon_book.weapon_book_levels =  							-- 兵符技能等级
-- 			{
-- 				1 + 10 * n - 10,--zstring.tonumber(npos(list)),     -- -1 没解锁  0 解锁了 未穿戴  1 穿戴了
-- 				2 + 10 * n - 10,--zstring.tonumber(npos(list)),
-- 				3 + 10 * n - 10,--zstring.tonumber(npos(list)),
-- 				4 + 10 * n - 10,--zstring.tonumber(npos(list)),
-- 				5 + 10 * n - 10,--zstring.tonumber(npos(list)),
-- 				6 + 10 * n - 10,--zstring.tonumber(npos(list)),
-- 			}
-- 		-- weapon_book.rela_state = npos(list)   -- 0 没有， 1 shipid
-- 		-- weapon_book.equip_fight = npos(list)
		
-- 		_ED.weapon_book[""..weapon_book.user_equiment_id] = weapon_book
-- 		-- _ED.weapon_book[""..weapon_book.user_equiment_id].equip_fight = 	getEquipmentFight(weapon_book,0)
-- 	end
-- end

-- ---------------------------------------------------------------------------------------------------------
-- parse_remove_user_horse 返回战马移除（12301）
-- ---------------------------------------------------------------------------------------------------------
function parse_remove_user_horse( interpreter,datas,pos,strDatas,list,count )
	local id = npos(list)
	_ED.horses[""..id] = nil
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_server_open_day_count_info 返回服务器开服天数（12303）
-- ---------------------------------------------------------------------------------------------------------
function parse_server_open_day_count_info( interpreter,datas,pos,strDatas,list,count )
	_ED.m_open_service_number = npos(list)		--开服的天数
	_ED.m_open_service_times = npos(list)		--开服的时间点的毫秋数
	_ED.m_the_day_times = npos(list)			--开服当天零点的毫秋数
end	


-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_horse_spirits 返回马魂信息（12320）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_horse_spirits( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	for i = 1 ,count do
		local id = npos(list)
		local mould_id = npos(list)
		local now_exp = npos(list)
		local horse_id = npos(list)

		_ED.horse_spirits[""..id] = _ED.horse_spirits[""..id] or {}
		_ED.horse_spirits[""..id].id = id
		_ED.horse_spirits[""..id].mould_id = mould_id
		_ED.horse_spirits[""..id].now_exp = now_exp
		_ED.horse_spirits[""..id].horse_id = horse_id
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_remove_user_horse_spirits 马魂移除（12321）
-- ---------------------------------------------------------------------------------------------------------
function parse_remove_user_horse_spirits( interpreter,datas,pos,strDatas,list,count )
	local id = npos(list)
	_ED.horse_spirits[""..id] = nil
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_horse_recuit_info 战马招募信息 12340
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_horse_recuit_info( interpreter,datas,pos,strDatas,list,count )
	
	_ED.horse_normal_number = npos(list)
	_ED.horse_specil_number = npos(list)
	_ED.normal_recuit_times = npos(list)
	_ED.specil_recuit_times = npos(list)
	_ED.specil_recuit_free_times = npos(list)
	_ED.specil_recuit_value = npos(list)
	_ED.last_out_put_horse_time = tonumber(npos(list))/1000
	_ED.last_out_put_horse_os_time = os.time()
	_ED.horse_specil_drop_value = npos(list)
	_ED.coming_horse_value = npos(list)
	-- print("===普通野马数量=",_ED.horse_normal_number)
	-- print("===高级野马数量=",_ED.horse_specil_number)
	-- print("===普通招募次数=",_ED.normal_recuit_times)
	-- print("===高级招募次数=",_ED.specil_recuit_times)
	-- print("===免费高级招募次数=",_ED.specil_recuit_free_times)
	-- print("===高级招募累计值=",_ED.specil_recuit_value)
	-- print("===上一次产出野马时间=",_ED.last_out_put_horse_time)
	-- print("===相马特殊掉落累积值=",_ED.horse_specil_drop_value)
	-- print("===龙马合成次数累积值=",_ED.coming_horse_value)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_other_user_horses 返回其他用户珍兽信息（12342）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_other_user_horses( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	for i = 1 ,count do
		local id = npos(list)
		_ED.other_horses[""..id] = _ED.other_horses[""..id] or {}
		local mould_id = npos(list)
		local ship_id = npos(list)
		local attribute = npos(list)
		_ED.other_horses[""..id].horse_spirits = _ED.other_horses[""..id].horse_spirits or {}
		for j = 1 ,6 do 
			_ED.other_horses[""..id].horse_spirits[j] = npos(list)
		end

		_ED.other_horses[""..id].id = id
		_ED.other_horses[""..id].mould_id = mould_id
		_ED.other_horses[""..id].ship_id = ship_id
		_ED.other_horses[""..id].attribute = attribute
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_other_user_horse_spirits 返回其他用户兽魂信息（12343）
-- ---------------------------------------------------------------------------------------------------------
function parse_return_other_user_horse_spirits( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	for i = 1 ,count do
		local id = npos(list)
		local mould_id = npos(list)
		local now_exp = npos(list)
		local horse_id = npos(list)

		_ED.other_horse_spirits[""..id] = _ED.other_horse_spirits[""..id] or {}
		_ED.other_horse_spirits[""..id].id = id
		_ED.other_horse_spirits[""..id].mould_id = mould_id
		_ED.other_horse_spirits[""..id].now_exp = now_exp
		_ED.other_horse_spirits[""..id].horse_id = horse_id
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_three_kings_info 三国无双信息12400
-- ---------------------------------------------------------------------------------------------------------
function parse_return_three_kings_info( interpreter,datas,pos,strDatas,list,count )
	_ED.three_kings_now_floor = zstring.tonumber(npos(list))  + 1--当前层数 //服务器返回的是当前通过的  前端要显示将要通过的所以 加1
	_ED.three_kings_max_floor = zstring.tonumber(npos(list)) --最大层数
	_ED.three_kings_reset_times = zstring.tonumber(npos(list)) -- 当前已用重置次数
	_ED.three_kings_sweeping = zstring.tonumber(npos(list)) -- 是否可以扫荡 (0不能扫荡，1可以扫荡)
	-- print("========",_ED.three_kings_now_floor,_ED.three_kings_max_floor,_ED.three_kings_reset_times)
end

-------------------------------------------------------------------------------------------------------
-- parse_return_three_kings_rank_info 返回三国无双排行信息 12401
---------------------------------------------------------------------------------------------------------
function parse_return_three_kings_rank_info( interpreter,datas,pos,strDatas,list,count )
    
    _ED.trialtower_ranking_info =  _ED.trialtower_ranking_info or {}

    _ED.trialtower_ranking_info.my_rank = zstring.tonumber(npos(list))
    _ED.trialtower_ranking_info.last_rank = zstring.tonumber(npos(list))
    _ED.trialtower_ranking_info.max_floor = zstring.tonumber(npos(list))
    local count = zstring.tonumber(npos(list))

    _ED.trialtower_ranking_info.other_info = _ED.trialtower_ranking_info.other_info or {}
    for i = 1,count do
	    _ED.trialtower_ranking_info.other_info[i] = _ED.trialtower_ranking_info.other_info[i] or {}
	    _ED.trialtower_ranking_info.other_info[i].user_id = npos(list)
	    _ED.trialtower_ranking_info.other_info[i].user_name = npos(list)
	    _ED.trialtower_ranking_info.other_info[i].user_camp = npos(list)
	    _ED.trialtower_ranking_info.other_info[i].user_rank = zstring.tonumber(npos(list))
	    _ED.trialtower_ranking_info.other_info[i].user_sex =  zstring.tonumber(npos(list))
	    -- TODO...
	    _ED.trialtower_ranking_info.other_info[i].user_head_id =  zstring.tonumber(npos(list))
	    _ED.trialtower_ranking_info.other_info[i].user_level = zstring.tonumber(npos(list))
	    _ED.trialtower_ranking_info.other_info[i].user_official = zstring.tonumber(npos(list))
	    _ED.trialtower_ranking_info.other_info[i].user_process = zstring.tonumber(npos(list))
        _ED.trialtower_ranking_info.other_info[i].user_union_name = npos(list)
        _ED.trialtower_ranking_info.other_info[i].user_union_id = zstring.tonumber(npos(list))
    end

    
    for i = count + 1,50 do
    	_ED.trialtower_ranking_info.other_info[i] = nil
    end

    -- debug.print_r(_ED.trialtower_ranking_info)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_open_new_scene 返回场景开启信息 12402
-- ---------------------------------------------------------------------------------------------------------
function parse_open_new_scene( interpreter,datas,pos,strDatas,list,count )
	local count = npos(list)
	if fwin:find("DuplicateManagerClass") ~= nil then
		_ED._open_new_scene = true 
	else
		_ED._open_new_scene = false 
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_god_weaponry_dup_info 返回神兵副本战斗次数 12403
-- ---------------------------------------------------------------------------------------------------------
function parse_god_weaponry_dup_info( interpreter,datas,pos,strDatas,list,count )
	_ED.weaponry_attack_times = npos(list)
	_ED.weaponry_buy_attack_times = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_the_number_of_elapsed_copies_of_the_elite 返回精英副本重置次数 12404
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_the_number_of_elapsed_copies_of_the_elite( interpreter,datas,pos,strDatas,list,count )
	_ED.parts_supply_remakes_times = tonumber(npos(list))
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_scene_info_battle_state 返回用户副本战斗状态 12405
-- ---------------------------------------------------------------------------------------------------------
function parse_user_scene_info_battle_state( interpreter,datas,pos,strDatas,list,count )
	local infos = zstring.splits(npos(list), "|", ",")
	for i, v in pairs(infos) do
		if tonumber(v[1]) == 51 then
			_ED.activity_pve_times[349] = v[2]
		elseif tonumber(v[1]) == 52 then
			_ED.activity_pve_times[350] = v[2]
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_copy_clear_user_info 返回副本通关用户信息 12406
-- ---------------------------------------------------------------------------------------------------------
function parse_copy_clear_user_info( interpreter,datas,pos,strDatas,list,count )
	_ED.copy_clear_user_info = _ED.copy_clear_user_info or {}
	local npcId = npos(list)
	if tonumber(npcId) > 0 then
		local userInfo = _ED.copy_clear_user_info[npcId] or {}
		userInfo.userId = tonumber(npos(list))
		userInfo.userName = npos(list)
		userInfo.userFighting = npos(list)
		userInfo.formationCount = tonumber(npos(list))
		userInfo.formationInfo = {}
		for i=1, userInfo.formationCount do
			local info = zstring.split(npos(list), ":")
			local _skin_id = 0
			if info[11] and info[11] ~= "" then
				_skin_id = info[11]
			end
			table.insert(userInfo.formationInfo, {ship_template_id = info[1], ship_grade = info[2], 
				evolution_status = info[3], StarRating = info[4], Order = info[5], 
				hero_fight = info[6], ship_id = info[7], ship_wisdom = info[8], 
				soul = info[9], skillLevel = info[10], skin_id = _skin_id})
		end
		_ED.copy_clear_user_info[npcId] = userInfo
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_copy_clear_user_info 返回噩梦副本阵型信息 12407
-- ---------------------------------------------------------------------------------------------------------
function parse_seq_hard_copy_user_formation( interpreter,datas,pos,strDatas,list,count )
	_ED.em_user_ship = _ED.em_user_ship or {}
	local user_formation = npos(list)
	if zstring.tonumber(user_formation) == -1 then
		for i = 1, 6 do
			if _ED.user_formetion_status[i] and _ED.user_formetion_status[i] ~= "" then
				table.insert(_ED.em_user_ship, _ED.user_formetion_status[i])
			else
				table.insert(_ED.em_user_ship, -1)
			end
		end
	else
		if user_formation and user_formation ~= "" then
			local user_infos = zstring.split(user_formation, ",")
			for i = 1, 6 do
				if user_infos[i] then
					_ED.em_user_ship[i] = user_infos[i]
				else
					_ED.em_user_ship[i] = -1
				end
			end
		end
	end
	
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_reward_all_npcs_ex 返回所有领取过3星宝箱的NPC 12408
-- ---------------------------------------------------------------------------------------------------------
function parse_reward_all_npcs_ex( interpreter,datas,pos,strDatas,list,count )
	_ED.scene_draw_sx_chest_npcs = {}
	local tempNpsIdList = zstring.split(npos(list), ",")
	for i, v in pairs(tempNpsIdList) do
		_ED.scene_draw_sx_chest_npcs[v] = 1
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_reward_all_npcs_ex 返回所有领取过3星宝箱的NPC 12409
-- ---------------------------------------------------------------------------------------------------------
function parse_reward_npcs_ex( interpreter,datas,pos,strDatas,list,count )
	local drawNpcId = npos(list)
	_ED.scene_draw_sx_chest_npcs[drawNpcId] = 1
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_raiders_cut 返回斩将夺宝信息 12500
-- ---------------------------------------------------------------------------------------------------------
function parse_return_raiders_cut( interpreter,datas,pos,strDatas,list,count )
	_ED.raiders_cut_attack_times = zstring.tonumber(npos(list)) --当前已经攻击次数
	_ED.raiders_cut_reset_times = zstring.tonumber(npos(list)) --当前刷新次数	  
end

---------------------------------------------------------------------------------------------------------
-- parse_return_raiders_cut_other_info 返回斩将夺宝用户信息 12501
---------------------------------------------------------------------------------------------------------
function parse_return_raiders_cut_other_info( interpreter,datas,pos,strDatas,list,count )
	_ED.raiders_user_info = _ED.raiders_user_info or {}
	local user_info_numbers = zstring.tonumber(npos(list)) --可挑战用户数量
	for i = 1,user_info_numbers do
		_ED.raiders_user_info[i] = _ED.raiders_user_info[i] or {}
		_ED.raiders_user_info[i].user_id = npos(list)
		_ED.raiders_user_info[i].user_name = npos(list)
        _ED.raiders_user_info[i].user_fight = npos(list)
        _ED.raiders_user_info[i].user_level = npos(list)
        _ED.raiders_user_info[i].user_camp = npos(list)
        _ED.raiders_user_info[i].user_sex = npos(list)
        -- TODO...
        _ED.raiders_user_info[i].user_head_id = npos(list)
        _ED.raiders_user_info[i].star_numbers = npos(list)
        _ED.raiders_user_info[i].quality = npos(list)
        _ED.raiders_user_info[i].reward_data = {
            item_value = npos(list),
            prop_type = npos(list),
            prop_item = npos(list)
        }
        _ED.raiders_user_info[i].raider_id = npos(list)
        _ED.raiders_user_info[i].npc_id = npos(list)
        _ED.raiders_user_info[i].pos_index = npos(list)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_soul_my_info 返回用户英魂副本信息 12502
---------------------------------------------------------------------------------------------------------
function parse_return_soul_my_info( interpreter,datas,pos,strDatas,list,count )
	_ED.soul_duplicate.my_damage = math.min(zstring.tonumber(npos(list)),100)
	_ED.soul_duplicate.my_rank = zstring.tonumber(npos(list))
	_ED.soul_duplicate.attack_count = zstring.tonumber(npos(list))
	_ED.soul_duplicate.npc_id = zstring.tonumber(npos(list))

	-- debug.print_r(_ED.soul_duplicate)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_soul_rank_info 返回英魂副本排行信息 12503
---------------------------------------------------------------------------------------------------------
function parse_return_soul_rank_info( interpreter,datas,pos,strDatas,list,count )
	local count = zstring.tonumber(npos(list))
	_ED.soul_duplicate.rank_info = _ED.soul_duplicate.rank_info or {}
	for i = 1,count do
        _ED.soul_duplicate.rank_info[i] = _ED.soul_duplicate.rank_info[i] or {}
        _ED.soul_duplicate.rank_info[i].user_id = npos(list)
        _ED.soul_duplicate.rank_info[i].user_name = npos(list)
        _ED.soul_duplicate.rank_info[i].user_camp = npos(list)
        _ED.soul_duplicate.rank_info[i].user_rank = npos(list)
        _ED.soul_duplicate.rank_info[i].user_damage = math.min(zstring.tonumber(npos(list)),100)
        _ED.soul_duplicate.rank_info[i].user_arena_id = zstring.tonumber(npos(list))
        _ED.soul_duplicate.rank_info[i].user_official = dms.int(dms["arena_reward_param"],_ED.soul_duplicate.rank_info[i].user_arena_id,arena_reward_param.arena_official)

    end
    -- debug.print_r(_ED.soul_duplicate)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_ship_military_info 返回用户运送军资信息 12504
---------------------------------------------------------------------------------------------------------
function parse_return_user_ship_military_info( interpreter,datas,pos,strDatas,list,count )

	local max_free_refush_times = dms.int(dms["ship_military_config"],4,ship_military_config.param)
	local max_transport_times =  dms.int(dms["base_consume"],70,base_consume.vip_0_value + tonumber(_ED.vip_grade))
	local max_rob_times =  dms.int(dms["base_consume"],71,base_consume.vip_0_value + tonumber(_ED.vip_grade))
	
    _ED.transport_resouce_info = _ED.transport_resouce_info or {}
    _ED.transport_resouce_info.leave_attack_times = zstring.tonumber(npos(list))-- 剩余抢劫次数
    _ED.transport_resouce_info.free_refrush_time = max_free_refush_times - zstring.tonumber(npos(list))--剩余免费刷新次数
    _ED.transport_resouce_info.leave_tran_times = max_transport_times - zstring.tonumber(npos(list))-- 剩余运送次数
    _ED.transport_resouce_info.is_transport = zstring.tonumber(npos(list)) -- 0 没有运送 1 正在运送
    _ED.transport_resouce_info.now_leave_time = zstring.tonumber(npos(list))--本次运送结束剩余时间
    _ED.transport_resouce_info.now_leave_time_os_times = os.time()
    _ED.transport_resouce_info.resource_quality = math.max(zstring.tonumber(npos(list)),1) --运送品质
    _ED.transport_resouce_info.cd_time = zstring.tonumber(npos(list)) --掠夺冷却时间
    _ED.transport_resouce_info.buy_count = zstring.tonumber(npos(list))
    _ED.transport_resouce_info.is_lucky_time = zstring.tonumber(npos(list)) --是否在良辰吉时 0 不是 1 是
end

    
---------------------------------------------------------------------------------------------------------
-- parse_return_other_user_ship_military_info 返回其他所有用户运送军资信息 12505
---------------------------------------------------------------------------------------------------------
function parse_return_other_user_ship_military_info( interpreter,datas,pos,strDatas,list,count )
	_ED.transport_resouce_user_infos = _ED.transport_resouce_user_infos or {}
	local count = tonumber(npos(list))
    for i = 1 , count do
        _ED.transport_resouce_user_infos[i] = _ED.transport_resouce_user_infos[i] or {}
        _ED.transport_resouce_user_infos[i].user_id = npos(list)
        _ED.transport_resouce_user_infos[i].user_name = npos(list)
        _ED.transport_resouce_user_infos[i].user_fight = zstring.tonumber(npos(list))
        _ED.transport_resouce_user_infos[i].user_level = zstring.tonumber(npos(list))
        _ED.transport_resouce_user_infos[i].user_camp = zstring.tonumber(npos(list))
        _ED.transport_resouce_user_infos[i].user_sex = zstring.tonumber(npos(list))
        -- TODO...
        _ED.transport_resouce_user_infos[i].user_head_id = zstring.tonumber(npos(list))
        _ED.transport_resouce_user_infos[i].resource_quality = math.max(zstring.tonumber(npos(list)),1) --运送品质
        _ED.transport_resouce_user_infos[i].ready_attack_times = zstring.tonumber(npos(list))
        _ED.transport_resouce_user_infos[i].leave_time = zstring.tonumber(npos(list))
        _ED.transport_resouce_user_infos[i].leave_time_os_time = os.time()
        _ED.transport_resouce_user_infos[i].reward_silver = zstring.tonumber(npos(list))
    end

    for i = count + 1,9 do
    	_ED.transport_resouce_user_infos[i] = nil
    end

    -- debug.print_r(_ED.transport_resouce_user_infos)
end

---------------------------------------------------------------------------------------------------------
-- parse_user_buff_shop_buy_state 返回商店购买次数 12506
---------------------------------------------------------------------------------------------------------
function parse_user_buff_shop_buy_state( interpreter,datas,pos,strDatas,list,count )
	local str_buy = npos(list)
	if str_buy == "" then
		return
	end
	local buy_count = zstring.split(str_buy,"|")
	 _ED.shop_buy_count = _ED.shop_buy_count or {}
	 for i,v in pairs(buy_count) do
	 	local data_table = zstring.split(v,",")
	 	_ED.shop_buy_count[""..data_table[1]] = tonumber(data_table[2])
	 end

end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_hold_init 返回攻城拔寨初始化 12507
---------------------------------------------------------------------------------------------------------
function parse_city_resource_hold_init( interpreter,datas,pos,strDatas,list,count )
	_ED.city_activity_status = npos(list)   --活动状态1开0关
	local map_city_info = npos(list)				--数量
	local cityInfo = {}
	for i=1, zstring.tonumber(map_city_info) do
		item={
			city_world_map_id = npos(list),--id
			city_world_map_quality = npos(list),--品质
			city_Resource_points = npos(list),-- 城附近的资源点
			city_Resource_points_mould = npos(list),-- 城附近的资源点模板id
		}
		cityInfo[item.city_world_map_id] = item
	end
	_ED.city_map_info = {}
	_ED.city_map_info = cityInfo
	state_machine.excute("national_city_update_map_resource_cells", 0, nil)
end


---------------------------------------------------------------------------------------------------------
-- parse_city_resource_hold_notificate_city_change 返回攻城拔寨推送城池信息变更 12508
---------------------------------------------------------------------------------------------------------
function parse_city_resource_hold_notificate_city_change( interpreter,datas,pos,strDatas,list,count )
	local map_city_info = npos(list)				--数量
	local cityInfo = {}
	for i=1, zstring.tonumber(map_city_info) do
		item={
			city_world_map_id = npos(list),--id
			city_world_map_quality = npos(list),--品质
			city_Resource_points = npos(list),-- 城附近的资源点实例id
			city_Resource_points_mould = npos(list),-- 城附近的资源点模板id
		}
		cityInfo[item.city_world_map_id] = item
	end
	_ED.city_map_info = {}
	_ED.city_map_info = cityInfo
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_hold_notificate_user_position 返回攻城拔寨推送用户的坐标 12509
---------------------------------------------------------------------------------------------------------
function parse_city_resource_hold_notificate_user_position( interpreter,datas,pos,strDatas,list,count )
	_ED.city_world_map_move_event = _ED.city_world_map_move_event or {}
	-- local user_id = npos(list)	--用户id
	-- _ED.old_city_world_npc_map_id = tonumber(npos(list))	--上一个城池id
	-- _ED.city_world_npc_map_id = tonumber(npos(list))	--现在城池id
	-- _ED.city_world_npc_map_gender = tonumber(npos(list))--性别
	-- _ED.city_world_npc_map_name = npos(list)--名称
	-- _ED.city_world_npc_map_union_name = npos(list)--工会
	local move_event = {
		user_id = npos(list),
		last_city_id = tonumber(npos(list)),
		curr_city_id = tonumber(npos(list)),
		union_name = npos(list),
		gender = npos(list),
		nickname = npos(list),
	}
	-- if move_event.last_city_id ~= move_event.curr_city_id then
		if zstring.tonumber(move_event.user_id) ~= zstring.tonumber(_ED.user_info.user_id) then
			local player_move_event = _ED.city_world_map_move_event[move_event.user_id]
			if player_move_event == nil then
				player_move_event = {_move_events = {}}
				_ED.city_world_map_move_event[move_event.user_id] = player_move_event
			end
			table.insert(player_move_event._move_events, move_event)
			state_machine.excute("national_city_world_player_map_move_to", 0, move_event.user_id)
			-- _ED.city_world_map_id_backup = move_event.curr_city_id
		else
			_ED.city_world_map_id_backup = tonumber(move_event.curr_city_id)
			-- _ED.city_user_move_event = move_event
		end
	-- end
	-- debug.print_r(move_event)
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_hold_resource 返回城池资源信息 12510
---------------------------------------------------------------------------------------------------------
function parse_city_resource_hold_resource( interpreter,datas,pos,strDatas,list,count )
	local city_id = npos(list)
	local count = npos(list)
	_ED.city_resource_hold_resource_infos = {}
	for i=1,tonumber(count) do
		local info = {
			city_id = city_id,
			id = npos(list),
			mould_id = npos(list),
			start_time = tonumber(npos(list)),
			end_time = tonumber(npos(list)),
			leave_time = tonumber(npos(list)),
			inspire_times = npos(list),
			open_state = npos(list),
			user_name = npos(list),
			union_name = npos(list),
		}
		info.use_os_time = info.leave_time - (os.time() - info.start_time/1000 )
		table.insert(_ED.city_resource_hold_resource_infos, info)
	end

	local allUserCity = npos(list)
	local useUserCity = npos(list)
	local meInThisCity = npos(list)

	for i,v in pairs(_ED.city_resource_hold_resource_infos) do
		v.allUserCity = allUserCity
		v.useUserCity = useUserCity
		v.meInThisCity = meInThisCity
	end
	-- debug.print_r(_ED.city_resource_hold_resource_infos)
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_hold_resource_users 返回某城池某资源信息 12511
---------------------------------------------------------------------------------------------------------
function parse_city_resource_hold_resource_users( interpreter,datas,pos,strDatas,list,count )
	local city_id = npos(list)
	local count = npos(list)
	_ED.city_resource_hold_resource_user_infos = {}
	local _open_state = npos(list)
	local result = {}
	for i=1,tonumber(count) do
		local info = {
			city_id = city_id,
			id = npos(list),
			user_id = npos(list),
			resource_id = npos(list),
			start_time = npos(list),
			master_id = npos(list),
			resource_level = npos(list),
			resource_mould_id = npos(list),
			end_time = npos(list),
			userName = npos(list),
			unionName = npos(list),
			userGender = npos(list),
			unionId = npos(list),
			open_state = _open_state,
		}
		if tonumber(info.resource_level) == 1 then
			table.insert(_ED.city_resource_hold_resource_user_infos, info)
		else
			table.insert(result, info)
		end
	end
	for k,v in pairs(result) do
		table.insert(_ED.city_resource_hold_resource_user_infos, v)
	end
	result = {}
	-- debug.print_r(_ED.city_resource_hold_resource_user_infos)
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_users_position 返回某城池某资源信息 12512
---------------------------------------------------------------------------------------------------------
function parse_city_resource_users_position( interpreter,datas,pos,strDatas,list,count )
	_ED.city_resource_user_position_info = _ED.city_resource_user_position_info or {}
	_ED.city_resource_user_position_info.userId = npos(list)
	_ED.city_resource_user_position_info.userName = npos(list)
	_ED.city_resource_user_position_info.userFighting = npos(list)
	_ED.city_resource_user_position_info.unionName = npos(list)
	_ED.city_resource_user_position_info.userInfoOfferId = npos(list)
	_ED.city_resource_user_position_info.canGetResource = npos(list)
	_ED.city_resource_user_position_info.shipMouldIds = npos(list)
	_ED.city_resource_user_position_info.userGender = npos(list)
	_ED.city_resource_user_position_info.userCamp = npos(list)
	_ED.city_resource_user_position_info.userLevel = npos(list)
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_users_info 返回玩家资源信息 12513
---------------------------------------------------------------------------------------------------------
function parse_city_resource_users_info( interpreter,datas,pos,strDatas,list,count )
	_ED.city_resource_user_info = _ED.city_resource_user_info or {}
	_ED.city_resource_user_info.my_city_id = npos(list)			-- 占领城市id
	_ED.city_resource_user_info.resource_id = npos(list)		-- 占领资源实例id
	_ED.city_resource_user_info.resource_hold_id = npos(list)	-- 占领点实例id
	_ED.city_resource_user_info.robotCount = npos(list)			-- 掠夺次数
	_ED.city_resource_user_info.encourageCount = npos(list)		-- 鼓舞次数
	_ED.city_resource_user_info.buyRobotCount = npos(list)		-- 已经购买
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_hold_get_invites 返回邀请信息 12514
---------------------------------------------------------------------------------------------------------
function parse_city_resource_hold_get_invites( interpreter,datas,pos,strDatas,list,count )
	_ED.city_resource_invites = {}
	local count = npos(list)
	for i=1,tonumber(count) do
		local info = {}
		info.userId = npos(list)
		info.userHeadPic = npos(list)
		info.userGender = npos(list)
		info.userLevel = npos(list)
		info.userCamp = npos(list)
		info.userOfficialRankId = npos(list)
		info.userName = npos(list)
		info.userFighting = npos(list)
		info.param = npos(list)
		-- info.resourceType = npos(list)
		info.time = npos(list)
		table.insert(_ED.city_resource_invites, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_hold_add_invites 新增邀请信息 12515
---------------------------------------------------------------------------------------------------------
function parse_city_resource_hold_add_invites( interpreter,datas,pos,strDatas,list,count )
	_ED.city_resource_invites = _ED.city_resource_invites or {}
	local info = {}
	info.userId = npos(list)
	info.userHeadPic = npos(list)
	info.userGender = npos(list)
	info.userLevel = npos(list)
	info.userCamp = npos(list)
	info.userOfficialRankId = npos(list)
	info.userName = npos(list)
	info.userFighting = npos(list)
	info.param = npos(list)
	-- info.resourceType = npos(list)
	info.time = npos(list)
	table.insert(_ED.city_resource_invites, info)
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_robot 机器人信息 12516
---------------------------------------------------------------------------------------------------------
function parse_city_resource_robot( interpreter,datas,pos,strDatas,list,count )
	_ED.city_resource_robot = {}
	local count = npos(list)
	for i=1,tonumber(count) do
		local info = {}
		info.id = npos(list)
		info.gender = npos(list)
		info.name = npos(list)
		info.unionName = npos(list)
		table.insert(_ED.city_resource_robot, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_rank_list 资源占领点排行信息 12517
---------------------------------------------------------------------------------------------------------
function parse_city_resource_rank_list( interpreter,datas,pos,strDatas,list,count )
	_ED.city_resource_rank_page = npos(list)
	_ED.city_resource_rank_info = {}
	-- _ED.city_resource_rank_info[tonumber(_ED.city_resource_rank_page)] = {}
	local count = npos(list)
	for i=1,tonumber(count) do
		local info = {}
		info.city_id = npos(list)
		info.resource_point_id = npos(list)
		info.start_time = tonumber(npos(list))
		info.end_time = tonumber(npos(list))
		info.id = npos(list)
		info.user_id = npos(list)
		info.resource_id = npos(list)
		info.null_time = npos(list)
		info.master_id = npos(list)
		info.resource_level = npos(list)
		info.resource_mould_id = npos(list)
		info.userName = npos(list)
		info.userFighting = npos(list)
		info.unionName = npos(list)
		info.userInfoOfferId = npos(list)
		info.canGetResource = npos(list)
		info.shipMouldIds = npos(list)
		info.userGender = npos(list)
		info.userCamp = npos(list)
		info.userLevel = npos(list)
		table.insert(_ED.city_resource_rank_info, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_presonal_fighting_map_info 返回个人据点掠夺信息 12518
---------------------------------------------------------------------------------------------------------
function parse_presonal_fighting_map_info( interpreter,datas,pos,strDatas,list,count )
	_ED.presonal_fighting_map_info = {}
	local count = npos(list)
	for i=1,tonumber(count) do
		local info = {}
		info.user_id = npos(list)
		info.user_name = npos(list)
		info.user_level = npos(list)
		info.user_gender = npos(list)
		info.user_head = npos(list)
		info.user_fighting = npos(list)
		info.user_arena_id = npos(list)
		info.user_official = dms.int(dms["arena_reward_param"], info.user_arena_id, arena_reward_param.arena_official)
		info.user_score = npos(list)
		info.user_state = npos(list)		--（-1已掠夺，>=0掠夺次数）
		info.is_have_info = npos(list)		--（0未查看 1已经查看）
		info.be_attack_times = npos(list)	    -- (-1已复仇，>=0复仇次数)
		info.user_server_number = npos(list)		--（用户区服编号）
		info.current_server_number = npos(list)		--（当前所属于服务器编号）
		table.insert(_ED.presonal_fighting_map_info, info)
	end
	-- debug.print_r(_ED.presonal_fighting_map_info)
end

---------------------------------------------------------------------------------------------------------
-- parse_presonal_fighting_user_info 返回个人据点掠夺详细信息 12519
---------------------------------------------------------------------------------------------------------
function parse_presonal_fighting_user_info( interpreter,datas,pos,strDatas,list,count )
	_ED.presonal_fighting_infomation = {}
	local user_id = npos(list)
	local tcount = npos(list)
	local result = {}
	result.user_id = user_id
	result.formation_list = {}
	result.resource_list = {}
	for i=1,tonumber(tcount) do
		local info = {}
		info.shipid = npos(list)
		info.lessHp = npos(list)
		info.maxHp = npos(list)
		info.ship_template_id = info.shipid
		info.ship_type = dms.int(dms["ship_mould"], info.shipid, ship_mould.ship_type)
		table.insert(result.formation_list, info)
	end
	
	-- 仓库信息
	result.storage_build_mould_id = npos(list)
	result.storage_build_mould_level = npos(list)

	for i=1,4 do
		local info = {}
		info.resource_id = npos(list)
		info.resource_level = npos(list)
		info.resource_time = tonumber(npos(list))/1000
		info.output_deviation = tonumber(npos(list))
		table.insert(result.resource_list, info)
	end
	_ED.presonal_fighting_infomation[""..user_id] = result
	-- debug.print_r(_ED.presonal_fighting_infomation)
end

---------------------------------------------------------------------------------------------------------
-- parse_presonal_fighting_my_hp 返回个人据点自己血量 12520
---------------------------------------------------------------------------------------------------------
function parse_presonal_fighting_my_hp( interpreter,datas,pos,strDatas,list,count )
	local tcount = npos(list)
	for i=1,tonumber(tcount) do
		local ship_id = npos(list)
		local current_hp = tonumber(npos(list))
		local review_hp = tonumber(npos(list))
		local review_time = tonumber(npos(list))
		local ship = _ED.user_ship[""..ship_id]
		if ship ~= nil then
			ship.current_hp = current_hp
			ship.review_hp = review_hp
			ship.review_time = review_time/1000
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_presonal_fighting_other_hp 返回个人据点其他方血量 12521
---------------------------------------------------------------------------------------------------------
function parse_presonal_fighting_other_hp( interpreter,datas,pos,strDatas,list,count )
	local tcount = npos(list)
	for i=1,tonumber(tcount) do
		local ship_id = npos(list)
		local current_hp = tonumber(npos(list))
		local ship = _ED.other_user_info.ship_list[""..ship_id]
		if ship ~= nil then
			ship.current_hp = current_hp
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_presonal_fighting_lose_info 返回个人战失败信息 12522
---------------------------------------------------------------------------------------------------------
function parse_presonal_fighting_lose_info( interpreter,datas,pos,strDatas,list,count )
	_ED.personal_fighting_lose_state = tonumber(npos(list)) 			-- 0：没有被战败，非0：被战败
	local lose_cd = dms.int(dms["user_stronghold_config"], 14, user_stronghold_config.info)
	_ED.personal_fighting_lose_cd = lose_cd * 60
end

---------------------------------------------------------------------------------------------------------
-- parse_presonal_fighting_add_hp_cd 返回个人战恢复血量cd 12523
---------------------------------------------------------------------------------------------------------
function parse_presonal_fighting_add_hp_cd( interpreter,datas,pos,strDatas,list,count )
	local start_time = tonumber(npos(list))
	local end_time = tonumber(npos(list))
	_ED.personal_add_hp_cd_time = (end_time - start_time)/1000
	_ED.personal_add_hp_cd_time_end = tonumber(end_time)/1000
end

---------------------------------------------------------------------------------------------------------
-- parse_presonal_fighting_user_score 返回个人战自己的当前积分 12524
---------------------------------------------------------------------------------------------------------
function parse_presonal_fighting_user_score( interpreter,datas,pos,strDatas,list,count )
	_ED.personal_user_score = tonumber(npos(list))
	_ED.personal_user_refresh_times = tonumber(npos(list))
end

---------------------------------------------------------------------------------------------------------
-- parse_presonal_fighting_other_user_info 返回查看其他玩家个人战信息 12525
---------------------------------------------------------------------------------------------------------
function parse_presonal_fighting_other_user_info( interpreter,datas,pos,strDatas,list,count )
	_ED.presonal_fighting_map_other_info = _ED.presonal_fighting_map_other_info or {}
	local info = {}
	info.user_id = npos(list)
	info.user_name = npos(list)
	info.user_level = npos(list)
	info.user_gender = npos(list)
	info.user_head = npos(list)
	info.user_camp = npos(list)
	info.user_fighting = npos(list)
	info.user_arena_id = npos(list)
	info.user_official = dms.int(dms["arena_reward_param"], info.user_arena_id, arena_reward_param.arena_official)
	info.user_score = npos(list)
	info.user_state = "-1"--npos(list)		--（-1已掠夺，>=0掠夺次数）
	info.is_have_info = "1"--npos(list)		--（0未查看 1已经查看）
	info.be_attack_times = npos(list)	    -- (-1已复仇，>=0复仇次数)
	info.user_server_number = npos(list)		--（用户区服编号）
	info.current_server_number = npos(list)		--（当前所属于服务器编号）
	_ED.presonal_fighting_map_other_info = info
end

---------------------------------------------------------------------------------------------------------
-- parse_return_answer_player_list 返回学霸用户列表 12526
---------------------------------------------------------------------------------------------------------
function parse_return_answer_player_list( interpreter,datas,pos,strDatas,list,count )
	_ED.answer_rank_list_info = {}
	local count = npos(list)
	for i = 1, tonumber(count) do
		local info = {
			user_id = npos(list),
			name = npos(list),
			level = npos(list),
			score = npos(list),
			choose_answer = npos(list),
			right_count = npos(list),
			error_count = npos(list),
			reward_state = npos(list),
			rank = npos(list),
		}
		table.insert(_ED.answer_rank_list_info, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_answer_update_player_list 返回学霸用户列表 12527
---------------------------------------------------------------------------------------------------------
function parse_return_answer_update_player_list( interpreter,datas,pos,strDatas,list,count )
	_ED.answer_user_info = {
		user_id = npos(list),
		name = npos(list),
		level = npos(list),
		score = npos(list),
		choose_answer = npos(list),
		right_count = npos(list),
		error_count = npos(list),
		reward_state = npos(list),
		rank = npos(list),
	}
end

---------------------------------------------------------------------------------------------------------
-- parse_return_answer_question_info 返回学霸答题信息 12528
---------------------------------------------------------------------------------------------------------
function parse_return_answer_question_info( interpreter,datas,pos,strDatas,list,count )
	_ED.answer_question_info = {}
	_ED.answer_question_info.state = npos(list)
	_ED.answer_question_info.cd_time = math.floor(zstring.tonumber(npos(list))/1000)
	_ED.answer_question_info.start_time = os.time() + _ED.time_add_or_sub
	if tonumber(_ED.answer_question_info.state) > 0 then
		_ED.answer_question_info.question_id = npos(list)
		_ED.answer_question_info.current_count = npos(list)
		_ED.answer_question_info.question = npos(list)
		_ED.answer_question_info.question_type_name = npos(list)
		_ED.answer_question_info.answer_a = npos(list)
		_ED.answer_question_info.answer_b = npos(list)
		_ED.answer_question_info.answer_c = npos(list)
		_ED.answer_question_info.right_answer = npos(list)
	end
	
	if tonumber(_ED.answer_question_info.state) == 0 and _ED.mould_function_push_info["3"] ~= nil then
		_ED.mould_function_push_info["3"].state = 0
	else
		_ED.mould_function_push_info["3"].state = 1
	end
	state_machine.excute("super_scholar_answer_update_question", 0, "")
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_mine_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_in_box_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_attack")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_defense")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_scout")
		state_machine.excute("notification_center_update", 0, "push_notification_campaign_cell")
		state_machine.excute("notification_center_update", 0, "push_notification_all_daily_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_all_linited_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_all_inter_service_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_campaign_expedition")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_answer_choose_info 返回玩家答题信息 12529
---------------------------------------------------------------------------------------------------------
function parse_return_answer_choose_info( interpreter,datas,pos,strDatas,list,count )
	_ED.answer_choose_info = {}
	local count_a = npos(list)
	local info_a = {}
	for i = 1, tonumber(count_a) do
		local name = npos(list)
		table.insert(info_a, name)
	end
	table.insert(_ED.answer_choose_info, info_a)

	local count_b = npos(list)
	local info_b = {}
	for i = 1, tonumber(count_b) do
		local name = npos(list)
		table.insert(info_b, name)
	end
	table.insert(_ED.answer_choose_info, info_b)

	local count_c = npos(list)
	local info_c = {}
	for i = 1, tonumber(count_c) do
		local name = npos(list)
		table.insert(info_c, name)
	end
	table.insert(_ED.answer_choose_info, info_c)

	state_machine.excute("super_scholar_answer_update_player", 0, "")
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_expedition_info 返回用户远征信息 12530
---------------------------------------------------------------------------------------------------------
function parse_return_user_expedition_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_expedition_info = {
		current_nicknames = npos(list),    			-- 敌军昵称集合
		current_state = npos(list),					-- 状态集合
		max_state = npos(list),						-- 最大进度
		current_score = tonumber(npos(list)),		-- 积分
		reset_enemy_count = npos(list),				-- 已重置次数
		current_enemy_formation = npos(list),		-- 当前敌军阵容
		max_enemy_formation = npos(list),			-- 当前敌军最大阵容
	}
	-- debug.print_r(_ED.user_expedition_info)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_expedition_shop_info 返回用户远征商店信息 12531
---------------------------------------------------------------------------------------------------------
function parse_return_user_expedition_shop_info( interpreter,datas,pos,strDatas,list,count )
	_ED.expedition_shop_info = {
		item_list = npos(list),    			        -- 商品id集合
		exchange_state = npos(list),				-- 兑换状态集合
		reset_shop_count = npos(list),				-- 刷新次数
	}
	-- debug.print_r(_ED.expedition_shop_info)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_expedition_integral 返回用户远征积分更新 12532
---------------------------------------------------------------------------------------------------------
function parse_return_user_expedition_integral( interpreter,datas,pos,strDatas,list,count )
	_ED.user_expedition_info.current_score = tonumber(npos(list))
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_extreme_info 返回用户极限挑战信息 12533
---------------------------------------------------------------------------------------------------------
function parse_return_user_extreme_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_extreme_info = {}
	_ED.user_extreme_info.current_npc_count = tonumber(npos(list))
	_ED.user_extreme_info.current_star_count = tonumber(npos(list))
	_ED.user_extreme_info.surplus_star_count = tonumber(npos(list))
	_ED.user_extreme_info.best_npc_count = tonumber(npos(list))
	_ED.user_extreme_info.best_star_count = tonumber(npos(list))
	_ED.user_extreme_info.reset_times = tonumber(npos(list))
	_ED.user_extreme_info.add_buff_info = npos(list)				--(类型,加成值|类型,加成值....没有就-1)
	_ED.user_extreme_info.formation_info = npos(list)
	_ED.user_extreme_info.buy_buff_info = npos(list)				--(-1,-1,-1)
	_ED.user_extreme_info.quick_battle = tonumber(npos(list))		--(0不可 1:可以)
	_ED.user_extreme_info.challge_count = tonumber(npos(list))
	_ED.user_extreme_info.challge_info = {}
	for i=1,_ED.user_extreme_info.challge_count do
		local info = {}
		info.formation_info = npos(list)
		info.vs_info = npos(list)
		info.reward_state = tonumber(npos(list))					--(0:没有 1:有)
		table.insert(_ED.user_extreme_info.challge_info, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_extreme_rank_info 返回用户极限挑战排行信息 12534
---------------------------------------------------------------------------------------------------------
function parse_return_user_extreme_rank_info( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	_ED.user_extreme_rank_info = {}
	for i=1, count do
		local info = {}
		info.rank = tonumber(npos(list))
		info.user_id = tonumber(npos(list))
		info.user_name = npos(list)
		info.npc_count = tonumber(npos(list))
		info.star_count = tonumber(npos(list))
		table.insert(_ED.user_extreme_rank_info, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_extreme_reward 返回用户极限挑战奖励结算 12535
---------------------------------------------------------------------------------------------------------
function parse_return_user_extreme_reward( interpreter,datas,pos,strDatas,list,count )
	_ED.user_extreme_reward_info = npos(list)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_enemy_strike_user_info 返回用户敌军来袭信息（12536）
---------------------------------------------------------------------------------------------------------
function parse_return_enemy_strike_user_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_enemy_strike_info = _ED.user_enemy_strike_info or {}
	local lastHurt = 0
	if _ED.user_enemy_strike_info.hurt_value ~= nil then
		lastHurt = _ED.user_enemy_strike_info.hurt_value
	end
	_ED.user_enemy_strike_info.hurt_rank = tonumber(npos(list))
	_ED.user_enemy_strike_info.hurt_value = tonumber(npos(list))
	_ED.user_enemy_strike_info.current_hurt = _ED.user_enemy_strike_info.hurt_value - lastHurt
	_ED.user_enemy_strike_info.double = tonumber(npos(list))			--是否翻倍(0:否 1:是)
	_ED.user_enemy_strike_info.reward_info = npos(list)
	_ED.user_enemy_strike_info.join_rank = tonumber(npos(list))
	_ED.user_enemy_strike_info.join_times = tonumber(npos(list))
	_ED.user_enemy_strike_info.five_attack_cd = tonumber(npos(list))
	_ED.user_enemy_strike_info.once_attack_cd = tonumber(npos(list))
	_ED.user_enemy_strike_info.formation_info = npos(list)
	_ED.user_enemy_strike_info.break_count = tonumber(npos(list)) 		-- 破坏部位数量

	state_machine.excute("enemy_strike_fight_update_user_fight_info", 0, "")

	if _ED.last_enemy_strke_join_times == nil or _ED.last_enemy_strke_join_times > _ED.user_enemy_strike_info.join_times then
        _ED.last_enemy_strke_join_times = _ED.user_enemy_strike_info.join_times
    end
    state_machine.excute("notification_center_update", 0, "push_notification_enemy_strike_reward")

    local time_info = zstring.split(dms.string(dms["enemy_boss_config"], 2, enemy_boss_config.param), ",")
    local onceTickTime = _ED.user_enemy_strike_info.once_attack_cd/1000 + tonumber(time_info[1]) - (os.time() + _ED.time_add_or_sub)
    if onceTickTime > 0 then
        state_machine.excute("adventure_mine_enemy_boss_user_path", 0, {1})
    else
    	state_machine.excute("adventure_mine_enemy_boss_user_path", 0, {0})
    end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_enemy_strike_boss_info 返回敌军来袭boss信息（12537）
---------------------------------------------------------------------------------------------------------
function parse_return_enemy_strike_boss_info( interpreter,datas,pos,strDatas,list,count )
	local last_state = -1
	if _ED.user_enemy_strike_boss_info ~= nil then
		last_state = _ED.user_enemy_strike_boss_info.state
	end
	_ED.user_enemy_strike_boss_info = _ED.user_enemy_strike_boss_info or {}
	_ED.user_enemy_strike_boss_info.state = tonumber(npos(list))			--(0:未开启 1:开启中) 
	_ED.user_enemy_strike_boss_info.npc_id = tonumber(npos(list))
	local count = tonumber(npos(list))
	_ED.user_enemy_strike_boss_info.boss_info = {}
	for i=1,count do
		local info = {}
		info.index = tonumber(npos(list))
		info.total_hp = tonumber(npos(list))
		info.current_hp = tonumber(npos(list))
		table.insert(_ED.user_enemy_strike_boss_info.boss_info, info)
	end
	local count = tonumber(npos(list))
	_ED.user_enemy_strike_boss_info.hurt_list = {}
	for i=1, count do
		local info = {}
		info.user_id = tonumber(npos(list))
		info.user_name = npos(list)
		info.total_hurt = tonumber(npos(list))
		table.insert(_ED.user_enemy_strike_boss_info.hurt_list, info)
	end
	count = tonumber(npos(list))
	_ED.user_enemy_strike_boss_info.join_list = {}
	for i=1, count do
		local info = {}
		info.user_id = tonumber(npos(list))
		info.user_name = npos(list)
		info.total_times = tonumber(npos(list))
		table.insert(_ED.user_enemy_strike_boss_info.join_list, info)
	end
	if last_state ~= _ED.user_enemy_strike_boss_info.state then
		state_machine.excute("enemy_strike_update_state_info", 0, nil)
		state_machine.excute("enemy_strike_world_box_update_state_info", 0, nil)
		state_machine.excute("adventure_mine_enemy_boss_change_state", 0, nil)
		if last_state == 0 then 		-- 开启新的敌军来袭
			-- 清除奖励数据
			_ED.enemy_strike_reward_list = {}
			_ED.last_enemy_strke_join_times = 0
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_enemy_strike_rank_info 返回敌军来袭排行榜信息（12538）
---------------------------------------------------------------------------------------------------------
function parse_return_enemy_strike_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_enemy_strike_rank_info = _ED.user_enemy_strike_rank_info or {}
	_ED.user_enemy_strike_rank_info.nType = tonumber(npos(list))			--(0:伤害 1:次数) 
	_ED.user_enemy_strike_rank_info.boss_kill_name = npos(list)
	_ED.user_enemy_strike_rank_info.count = tonumber(npos(list))
	if _ED.user_enemy_strike_rank_info.nType == 0 then
		_ED.user_enemy_strike_rank_info.rank_hurt_list = {}
	else
		_ED.user_enemy_strike_rank_info.rank_times_list = {}
	end
	for i=1, _ED.user_enemy_strike_rank_info.count do
		local info = {}
		info.user_id = tonumber(npos(list))
		info.total_value = tonumber(npos(list))
		info.user_name = npos(list)
		info.rank = tonumber(npos(list))
		info.level = tonumber(npos(list))
		if _ED.user_enemy_strike_rank_info.nType == 0 then
			table.insert(_ED.user_enemy_strike_rank_info.rank_hurt_list, info)
		else
			table.insert(_ED.user_enemy_strike_rank_info.rank_times_list, info)
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_enemy_strike_change_hp 返回敌军来袭boss血量变化（12539）
---------------------------------------------------------------------------------------------------------
function parse_return_enemy_strike_change_hp( interpreter,datas,pos,strDatas,list,count )
	local index = tonumber(npos(list))
	if _ED.user_enemy_strike_boss_info ~= nil and _ED.user_enemy_strike_boss_info.boss_info ~= nil then
		_ED.user_enemy_strike_boss_info.boss_info[index + 1].current_hp = tonumber(npos(list))
		state_machine.excute("enemy_strike_fight_update_hp_info", 0, nil)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_enemy_strike_hurt_info 返回敌军来袭伤害变化（12540）
---------------------------------------------------------------------------------------------------------
function parse_return_enemy_strike_hurt_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_enemy_strike_update_info = {}
	_ED.user_enemy_strike_update_info.is_show = false
	_ED.user_enemy_strike_update_info.hurt_value = tonumber(npos(list))
	_ED.user_enemy_strike_update_info.hurt_type = tonumber(npos(list))		--(0:普通 1:五连击 2:最强一击 3:boss死亡)
	_ED.user_enemy_strike_update_info.boss_index = tonumber(npos(list))		--部位损伤用boss下标(从0开始)
	_ED.user_enemy_strike_update_info.user_id = tonumber(npos(list))
	_ED.user_enemy_strike_update_info.user_name = npos(list)
	_ED.user_enemy_strike_update_info.total_hurt = tonumber(npos(list))
	_ED.user_enemy_strike_update_info.total_times = tonumber(npos(list))
	
	_ED.user_enemy_strike_boss_info.hurt_list = _ED.user_enemy_strike_boss_info.hurt_list or {}
	_ED.user_enemy_strike_boss_info.join_list = _ED.user_enemy_strike_boss_info.join_list or {}
	local isUpdate = false
	for k,v in pairs(_ED.user_enemy_strike_boss_info.hurt_list) do
		if tonumber(v.user_id) == _ED.user_enemy_strike_update_info.user_id then
			isUpdate = true
			v.total_hurt = _ED.user_enemy_strike_update_info.total_hurt
			break
		end
	end
	if isUpdate == false then
		local info = {}
		info.user_id = _ED.user_enemy_strike_update_info.user_id
		info.user_name = _ED.user_enemy_strike_update_info.user_name
		info.total_hurt = _ED.user_enemy_strike_update_info.total_hurt
		table.insert(_ED.user_enemy_strike_boss_info.hurt_list, info)
	end

	isUpdate = false
	for k,v in pairs(_ED.user_enemy_strike_boss_info.join_list) do
		if tonumber(v.user_id) == _ED.user_enemy_strike_update_info.user_id then
			isUpdate = true
			v.total_times = _ED.user_enemy_strike_update_info.total_times
			break
		end
	end
	if isUpdate == false then
		local info = {}
		info.user_id = _ED.user_enemy_strike_update_info.user_id
		info.user_name = _ED.user_enemy_strike_update_info.user_name
		info.total_times = _ED.user_enemy_strike_update_info.total_times
		table.insert(_ED.user_enemy_strike_boss_info.join_list, info)
	end

	state_machine.excute("enemy_strike_fight_update_fight_info", 0, nil)
	state_machine.excute("enemy_strike_fight_update_rank_list", 0, "")
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_info 返回阵营对决信息 12541
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_info( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_info = {}
	local last_state = 0
	if _ED.camp_pk_info ~= nil then
		last_state = _ED.camp_pk_info.state
	end
	_ED.camp_pk_info.state = tonumber(npos(list))			--(0:未开启 1:报名中 2:准备中 3:开战中)
	_ED.camp_pk_info.win_info = tonumber(npos(list))		--胜利方(-1:无 0:蓝方1:红方)
	_ED.camp_pk_info.join_number = tonumber(npos(list))		--报名人数
	_ED.camp_pk_info.end_time = tonumber(npos(list))		--状态结束时间(时间段)
	state_machine.excute("camp_pk_challge_update_info", 0, nil)
	state_machine.excute("camp_pk_battle_update_info", 0, nil)
	-- debug.print_r(_ED.camp_pk_info)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_user_info 返回用户阵营对决信息 12542
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_user_info( interpreter,datas,pos,strDatas,list,count )
	local last_join_times = 0
	if _ED.camp_pk_user_info ~= nil then
		last_join_times = _ED.camp_pk_user_info.join_times
	end
	_ED.camp_pk_user_info = {}
	_ED.camp_pk_user_info.state = tonumber(npos(list))			--是否报名(0:未报名 1:已报名)
	_ED.camp_pk_user_info.formation_info = npos(list)		--报名的阵容
	_ED.camp_pk_user_info.fighting = tonumber(npos(list))		--报名的战力
	_ED.camp_pk_user_info.camp_state = tonumber(npos(list))		--所在阵营(-1:无 0:蓝方 1:红方)
	_ED.camp_pk_user_info.current_con = tonumber(npos(list))	--当前功勋
	_ED.camp_pk_user_info.total_con = tonumber(npos(list))		--总功勋
	_ED.camp_pk_user_info.win_times = tonumber(npos(list))		--当前连胜次数
	_ED.camp_pk_user_info.join_times = tonumber(npos(list))		--活跃次数
	if zstring.tonumber(last_join_times) > 0 
		and _ED.camp_pk_user_info.join_times > zstring.tonumber(last_join_times)
		and _ED.camp_pk_battle_user_move_info ~= nil then
		local stronghold_id_type = dms.int(dms["camp_duel_mould"], _ED.camp_pk_battle_user_move_info.current_stronghold_id, camp_duel_mould.ntype)
		local camp = dms.int(dms["camp_duel_mould"], _ED.camp_pk_battle_user_move_info.current_stronghold_id, camp_duel_mould.camp)
		if stronghold_id_type == 1 and camp == _ED.camp_pk_user_info.camp_state then
			state_machine.excute("camp_pk_battle_show_prompt_info", 0, {0, 0})
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_shop_info 返回阵营对决商店信息 12543
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_shop_info( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_shop_info = {}
	_ED.camp_pk_shop_info.prop_ids = npos(list)			         --商店id集合
	_ED.camp_pk_shop_info.recharge_states = npos(list)		     --兑换状态集合
	_ED.camp_pk_shop_info.refresh_times = tonumber(npos(list))	 --已刷新次数
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_rank_info 返回阵营对决排行榜 12544
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_rank_info = _ED.camp_pk_rank_info or {}
	local ntype = npos(list)		--类型(0:功勋 1:连胜)
	_ED.camp_pk_rank_info[ntype] = {}
	local count = tonumber(npos(list))
	for i=1,count do
		local info = {}
		info.user_id = tonumber(npos(list))
		info.user_name = npos(list)
		info.fighting = tonumber(npos(list))
		info.camp_state = tonumber(npos(list))		--阵营(0:蓝方 1:红方)
		info.con = tonumber(npos(list))
		info.win_times = tonumber(npos(list))
		table.insert(_ED.camp_pk_rank_info[ntype], info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_battle_info 返回阵营对决战场初始化 12545
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_battle_info( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_battle_stronghold_info = {}
	local count = tonumber(npos(list))
	for i=1,count do
		local info = {}
		info.stronghold_id = tonumber(npos(list))
		info.blue_count = tonumber(npos(list))
		info.red_count = tonumber(npos(list))
		info.npc_count = tonumber(npos(list))
		info.state = tonumber(npos(list))			--据点状态(0:无 1:修整中 2:交战中)
		info.start_time = tonumber(npos(list))
		_ED.camp_pk_battle_stronghold_info[""..info.stronghold_id] = info
	end
	state_machine.excute("camp_pk_battle_update_battle_state_info", 0, nil)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_battle_stronghold_info 返回阵营对决战场据点信息 12546
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_battle_stronghold_info( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_battle_stronghold_info = _ED.camp_pk_battle_stronghold_info or {}
	local info = {}
	info.stronghold_id = tonumber(npos(list))
	info.blue_count = tonumber(npos(list))
	info.red_count = tonumber(npos(list))
	info.npc_count = tonumber(npos(list))
	info.state = tonumber(npos(list))			--据点状态(0:无 1:修整中 2:交战中)
	info.start_time = tonumber(npos(list))
	_ED.camp_pk_battle_stronghold_info[""..info.stronghold_id] = info
	state_machine.excute("camp_pk_battle_update_battle_state_info", 0, {info})
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_battle_move_info 返回阵营对决用户战场移动信息 12547
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_battle_move_info( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_battle_user_move_info = {}
	_ED.camp_pk_battle_user_move_info.road_line = tonumber(npos(list))			--选择的路线(-1:未选择 0:上路 1:中路 2:下路)
	_ED.camp_pk_battle_user_move_info.current_stronghold_id = tonumber(npos(list))	--所在据点id
	_ED.camp_pk_battle_user_move_info.target_stronghold_id = tonumber(npos(list))	--目标据点id(>0:移动中)
	_ED.camp_pk_battle_user_move_info.begin_time = tonumber(npos(list))	--移动起始时间
	_ED.camp_pk_battle_user_move_info.need_time = tonumber(npos(list))	--需要的时间
	state_machine.excute("camp_pk_battle_update_role_move_info", 0, 0)
	-- debug.print_r(_ED.camp_pk_battle_user_move_info)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_battle_user_info 返回阵营对决用户战场基本信息 12548
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_battle_user_info( interpreter,datas,pos,strDatas,list,count )
	local last_con = -1
	local last_score = -1
	if _ED.camp_pk_battle_user_info ~= nil then
		last_con = _ED.camp_pk_battle_user_info.get_con
		last_score = _ED.camp_pk_battle_user_info.get_score
	end
	_ED.camp_pk_battle_user_info = {}
	_ED.camp_pk_battle_user_info.live_percent = tonumber(npos(list))		--当前部队存活百分比
	_ED.camp_pk_battle_user_info.get_con = tonumber(npos(list))		--获得功勋
	_ED.camp_pk_battle_user_info.get_score = tonumber(npos(list))		--获得积分
	_ED.camp_pk_battle_user_info.win_times = tonumber(npos(list))		--胜利场次
	_ED.camp_pk_battle_user_info.max_straight_times = tonumber(npos(list))		--最高连胜
	local add_con = _ED.camp_pk_battle_user_info.get_con - zstring.tonumber(last_con)
	local add_score = _ED.camp_pk_battle_user_info.get_score - zstring.tonumber(last_score)
	state_machine.excute("camp_pk_battle_my_info_update", 0, nil)
	state_machine.excute("camp_pk_battle_show_prompt_info", 0, {add_con, add_score})
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_battle_score_info 返回阵营对决战场积分人数信息 12549
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_battle_score_info( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_battle_score_info = {}
	_ED.camp_pk_battle_score_info.blue_count = tonumber(npos(list))
	_ED.camp_pk_battle_score_info.blue_score = tonumber(npos(list))
	_ED.camp_pk_battle_score_info.red_count = tonumber(npos(list))
	_ED.camp_pk_battle_score_info.red_score = tonumber(npos(list))
	state_machine.excute("camp_pk_battle_update_info", 0, nil)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_battle_event_info 返回阵营对决战场事件列表 12550
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_battle_event_info( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_battle_event_info = _ED.camp_pk_battle_event_info or {}
	local ntype = npos(list)
	_ED.camp_pk_battle_event_info[""..ntype] = {}
	local count = tonumber(npos(list))
	for i=1,count do
		local info = {}
		info.channel_type = tonumber(npos(list))	--信息类型(0:阵营蓝 1:阵营红 2:个人)
		info.event_id = tonumber(npos(list))		--事件id
		info.params = npos(list)					--事件参数
		--如果是npc的话名字读本地表
		local arry = zstring.split(info.params, ",")
		for k, v in pairs(arry) do
			local arryData = zstring.split(v, "-")
			if #arryData > 1 then
				local mouldId = zstring.tonumber(arryData[2])
				local currNpcData = dms.element(dms["camp_duel_npc"], mouldId)
				if currNpcData ~= nil then
					local npcNme = zstring.exchangeFrom(dms.atos(currNpcData, camp_duel_npc.npc_name))
					arry[k] = npcNme
				end
			end
		end
		info.params = zstring.concat(arry, ",")

		_ED.camp_pk_battle_event_info[""..info.channel_type] = _ED.camp_pk_battle_event_info[""..info.channel_type] or {}
		table.insert(_ED.camp_pk_battle_event_info[""..info.channel_type], info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_battle_event_info_update 返回阵营对决战场事件信息推送 12551
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_battle_event_info_update( interpreter,datas,pos,strDatas,list,count )
	_ED.camp_pk_battle_event_info = _ED.camp_pk_battle_event_info or {}
	local info = {}
	info.channel_type = tonumber(npos(list))	--信息类型(0:阵营蓝 1:阵营红 2:个人)
	info.event_id = tonumber(npos(list))		--事件id
	info.params = npos(list)					--事件参数
	--如果是npc的话名字读本地表
	local arry = zstring.split(info.params, ",")
		for k, v in pairs(arry) do
			local arryData = zstring.split(v, "-")
			if #arryData > 1 then
				local mouldId = zstring.tonumber(arryData[2])
				local currNpcData = dms.element(dms["camp_duel_npc"], mouldId)
				if currNpcData ~= nil then
					local npcNme = zstring.exchangeFrom(dms.atos(currNpcData, camp_duel_npc.npc_name))
					arry[k] = npcNme
				end
			end
		end
	info.params = zstring.concat(arry, ",")
	_ED.camp_pk_battle_event_info[""..info.channel_type] = _ED.camp_pk_battle_event_info[""..info.channel_type] or {}
	-- if table.getn(_ED.camp_pk_battle_event_info[""..info.channel_type]) > 20 then
	-- 	table.remove(_ED.camp_pk_battle_event_info[""..info.channel_type], 1, 1)
	-- end
	table.insert(_ED.camp_pk_battle_event_info[""..info.channel_type], info)
	state_machine.excute("camp_pk_battle_update_list_info", 0, nil)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_answer_reward_state 返回学霸之战奖励领取状态 12552
---------------------------------------------------------------------------------------------------------
function parse_return_answer_reward_state( interpreter,datas,pos,strDatas,list,count )
	if _ED.answer_user_info ~= nil then
		_ED.answer_user_info.reward_state = npos(list)
		state_machine.excute("super_scholar_reward_update_rank_info", 0, "")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_camp_pk_enter_battle 返回阵营战进入战斗场景 12553
---------------------------------------------------------------------------------------------------------
function parse_return_camp_pk_enter_battle( interpreter,datas,pos,strDatas,list,count )
	npos(list)
	state_machine.excute("camp_pk_battle_enter_fight", 0, nil)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_limit_dekaron_enter_battle 返回极限挑战快速战斗进入战斗场景 12554
---------------------------------------------------------------------------------------------------------
function parse_return_limit_dekaron_enter_battle( interpreter,datas,pos,strDatas,list,count )
	npos(list)
	state_machine.excute("limit_dekaron_enter_fight", 0, nil)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_enemy_strike_reward_list 返回敌军来袭奖励列表 12555
---------------------------------------------------------------------------------------------------------
function parse_return_enemy_strike_reward_list( interpreter,datas,pos,strDatas,list,count )
	_ED.enemy_strike_reward_list = _ED.enemy_strike_reward_list or {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.times = tonumber(npos(list))
		info.rewards = npos(list)
		_ED.enemy_strike_reward_list[""..info.times] = info
	end
	state_machine.excute("red_alert_time_mine_update_players_resources", 0, "")
	state_machine.excute("main_window_update_resource", 0, "")
	state_machine.excute("enemy_strike_reward_list_update_info", 0, "")

	local scene_reward_type = 7
	for k, v in pairs(_ED.show_reward_list_group_ex) do
		if scene_reward_type == v.show_reward_type then
			table.remove(_ED.show_reward_list_group_ex, k, 1)
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_ship_purify_init_info 返回武将净化初始化信息 12556
---------------------------------------------------------------------------------------------------------
function parse_ship_purify_init_info( interpreter,datas,pos,strDatas,list,count )
	_ED.digital_purify_info = {_heros = {}, _team_info = {}}
	_ED.digital_purify_info._heros = zstring.splits(npos(list), "|", ",")
end

---------------------------------------------------------------------------------------------------------
-- parse_ship_purify_team_info 返回武将净化队伍信息 12557
---------------------------------------------------------------------------------------------------------
function parse_ship_purify_team_info( interpreter,datas,pos,strDatas,list,count )
	_ED.digital_purify_info = _ED.digital_purify_info or {_heros = {}, _team_info = {}}
	
	local team_info = _ED.digital_purify_info._team_info
	local last_Team_type = team_info.team_type
	
	team_info.team_key = npos(list)
	team_info.team_type = tonumber(npos(list))
	team_info.digital_purify_param_id = npos(list)
	team_info.join_state = tonumber(npos(list))

	team_info.members = {}

	local nCount = tonumber(npos(list))
	for i = 1, nCount do
		local memberInfo = {}
		memberInfo.user_id = tonumber(npos(list))
		if memberInfo.user_id > 0 then
			memberInfo.member_type = tonumber(npos(list)) -- -1:无队伍 0:成员 1:队长
			memberInfo.member_key = npos(list)  -- 用户ID 或 队伍中的位置索引
			memberInfo.nickname = npos(list)
			memberInfo.head_pic = npos(list)
			memberInfo.level = npos(list)
			memberInfo.vip_level = npos(list)
			memberInfo.union_name = npos(list)
			memberInfo.formation_info = npos(list)
			memberInfo.reward_info = npos(list)
			memberInfo.complete_count = tonumber(npos(list))	
			--生命,攻击,防御,暴击率,暴击加成,抗暴率,格挡率,格挡加成,破格挡率,伤害加成,伤害减免
			memberInfo.ship_attributes = npos(list)					--卡牌属性
		end

		team_info.members[i] = memberInfo
	end
	-- if last_Team_type ~= nil and last_Team_type >= 0 and team_info.team_type < 0 then
		state_machine.excute("purify_team_window_update_draw", 0, nil)
	-- end
	state_machine.excute("notification_center_update",0,"push_notification_center_sm_special_duplicate_all")
	state_machine.excute("notification_center_update",0,"push_notification_center_sm_purify_duplicate")
end

---------------------------------------------------------------------------------------------------------
-- parse_seq_digital_trial_init_info 返回数码试炼初始化信息 12558
---------------------------------------------------------------------------------------------------------
function parse_seq_digital_trial_init_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_try_to_score_points = npos(list) 			--试炼积分
	_ED.user_try_highest_integral = tonumber(npos(list))			--历史最高积分
	_ED.user_try_total_highest_integral = tonumber(npos(list))			--总积分
	local datas = zstring.split(npos(list), ",")			--积分奖励领取状态
	_ED.user_try_highest_score_reward_state = {}
	for i, v in pairs(datas) do
		if #v > 0 then
			_ED.user_try_highest_score_reward_state[""..v] = v
		end
	end
	_ED.user_try_highest_floor_time = npos(list)		--最高的挑战时间
	_ED.user_try_ship_infos = {}
	local ship_infos = ""
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		_ED.user_try_ship_datas = npos(list)
		ship_infos = zstring.split(_ED.user_try_ship_datas,"-")[1]
	else
		ship_infos = npos(list)				--阵型信息,血啊，蓝啊
	end
	if ship_infos ~= "" then
		local datas = zstring.split(ship_infos,"|")
		for i, v in pairs(datas) do
			local infos = zstring.split(v,":")
			local infos_data = zstring.split(infos[2],",")
			local ships = {}
			ships.newHp = zstring.tonumber(_ED.user_ship[""..infos[1]].ship_health)*(zstring.tonumber(infos_data[3])/100)
			ships.maxHp = zstring.tonumber(infos_data[3])
			ships.newanger = infos_data[2]
			ships.id = infos[1]
			_ED.user_try_ship_infos[""..infos[1]] = ships
		end
	end
	_ED.three_kingdoms_npc_formation_infos = npos(list)
	_ED.user_info.all_glories = npos(list) 				--试炼币
	_ED.three_kings_vip_sweep_state = npos(list) 				--一键扫荡状态
	_ED.three_kings_vip_sweep_buff_info = npos(list) 				--buff购买状态
	_ED.three_kings_vip_sweep_reward_info = npos(list) 				--宝箱购买状态
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		--武将强化推送
		setHeroDevelopAllShipPushState(3)
		state_machine.excute("hero_list_view_update_cell_strength_button_push",0,"hero_list_view_update_cell_strength_button_push.")
		state_machine.excute("hero_list_view_update_cell_equip_button_push",0,"hero_list_view_update_cell_equip_button_push.")
       	state_machine.excute("notification_center_update",0,"push_notification_center_ship_warehouse_all")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_home_hero_icon")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_duplicate_formation")
       	state_machine.excute("notification_center_update",0,"push_notification_center_sm_special_duplicate_all")
       	state_machine.excute("notification_center_update",0,"push_notification_center_sm_trial_tower_reward")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_digital_talent_state_info 返回数码天赋状态信息 12559
---------------------------------------------------------------------------------------------------------
function parse_digital_talent_state_info( interpreter,datas,pos,strDatas,list,count )
	_ED.digital_talent_state_info = nil
	_ED.digital_talent_already_add = {}
	_ED.digital_talent_page_use_point_array = {0,0,0,0}
	_ED.digital_talent_page_is_lock = {false,true,true,true} 
	local datas = npos(list)
	if datas == "null" or datas == "" then
		return
	end
	--datas里的内容是“数码天赋Id:等级,附加参数|....”
	_ED.digital_talent_state_info = datas
	--格式化字符串
	local data = zstring.split(_ED.digital_talent_state_info , "|")
	for i , v in pairs(data) do
		local talentData = zstring.split(v , ",")
		local talentLv = zstring.split(talentData[1] , ":")
		_ED.digital_talent_already_add[""..talentLv[1]] = {}
		local data = {
			level = tonumber(talentLv[2]),
			params = talentData[2],
		}
		_ED.digital_talent_already_add[""..talentLv[1]] = data
	end
	-- 记录每页消耗的天赋点
	if _ED.digital_talent_state_info ~= nil and _ED.digital_talent_state_info ~= "" then
		local data = zstring.split(_ED.digital_talent_state_info , "|")
		for i , v in pairs(data) do
			local talentData = zstring.split(v , ",")
			local talentLv = zstring.split(talentData[1] , ":")
			local needGroup = dms.searchs(dms["ship_talent_param"], ship_talent_param.need_mould, talentLv[1])
			for j , k in pairs(needGroup) do
				if tonumber(k[3]) <= tonumber(talentLv[2]) then
					local needData = zstring.split( k[4] , "|")
					for o , p in pairs(needData) do
						local needType = zstring.split(p , ",")
						if tonumber(needType[1]) == 34 then
							if tonumber(talentLv[1]) < 8 then
								_ED.digital_talent_page_use_point_array[1] = _ED.digital_talent_page_use_point_array[1] + tonumber(needType[3])
							elseif tonumber(talentLv[1]) < 18 then
								_ED.digital_talent_page_use_point_array[2] = _ED.digital_talent_page_use_point_array[2] + tonumber(needType[3])
							elseif tonumber(talentLv[1]) < 28 then
								_ED.digital_talent_page_use_point_array[3] = _ED.digital_talent_page_use_point_array[3] + tonumber(needType[3])
							else
								_ED.digital_talent_page_use_point_array[4] = _ED.digital_talent_page_use_point_array[4] + tonumber(needType[3])
							end
						end
					end
				end
			end
		end
	end
	_ED.digital_talent_page_is_lock = {false,false,false,false} 
	--记录每页是否解锁
	for i = 1 , 4 do
		local unLockData = zstring.split(dms.string(dms["ship_talent_group"],i,ship_talent_group.unlock_lv),"|")
        for j , v in pairs(unLockData) do
            local needData = zstring.split(v , ",")
            if tonumber(needData[1]) == 1 then --等级判定
                if tonumber(_ED.user_info.user_grade) < tonumber(needData[2]) then
                    _ED.digital_talent_page_is_lock[i] = true
                    break
                end
            else 
                local haveUsePoint = _ED.digital_talent_page_use_point_array[tonumber(needData[2])]
                if haveUsePoint < tonumber(needData[3]) then
                    _ED.digital_talent_page_is_lock[i] = true
                    break
                end
            end
        end
	end
	state_machine.excute("sm_talent_main_window_updata", 0, nil)
end

---------------------------------------------------------------------------------------------------------
-- parse_digital_spirit_state_info 返回数码神精状态信息 12560
---------------------------------------------------------------------------------------------------------
function parse_digital_spirit_state_info( interpreter,datas,pos,strDatas,list,count )
	local datas = npos(list)
	--datas里的内容是“武将id:等级，好感度，档位|...”
	if datas ~= "" then
		local data = zstring.split(datas,"|")
		for i,v in pairs(data) do
			local info = zstring.split(datas,":")
			local spirit = zstring.split(info[2],",")
			local spirit_info = {}
			spirit_info.level = spirit[1]
			spirit_info.good_opinion = spirit[2]
			spirit_info.stalls = spirit[3]

			if _ED.digital_spirit_state_info[info[1]] == nil then
				_ED.digital_spirit_state_info[info[1]] = {}
			end
			_ED.digital_spirit_state_info[info[1]] = spirit_info
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_every_day_online_reward_times 返回天降好礼领取次数 12561
---------------------------------------------------------------------------------------------------------
function parse_every_day_online_reward_times( interpreter,datas,pos,strDatas,list,count )
	_ED.every_day_online_reward_times = tonumber(npos(list))
	_ED.every_day_online_reward_next_time = tonumber(npos(list))
end

---------------------------------------------------------------------------------------------------------
-- parse_every_day_online_reward_double 返回天降好礼领取双倍 12562
---------------------------------------------------------------------------------------------------------
function parse_every_day_online_reward_double( interpreter,datas,pos,strDatas,list,count )
	_ED.every_day_online_reward_double = tonumber(npos(list)) -- 1普通 2双倍
end

---------------------------------------------------------------------------------------------------------
-- parse_artifact_info 返回神器信息 12563
---------------------------------------------------------------------------------------------------------
function parse_artifact_info( interpreter,datas,pos,strDatas,list,count )
	local lockStates = zstring.split(npos(list), "|")
	local attributes = zstring.split(npos(list), "|")
	_ED.user_artifact_info = {}
	_ED.user_artifact_attributes = {}
	for k,v in pairs(lockStates) do
		local info = zstring.split(v, ":")
		_ED.user_artifact_info[""..info[1]] = _ED.user_artifact_info[""..info[1]] or {}
		_ED.user_artifact_info[""..info[1]].id = tonumber(info[1])
		_ED.user_artifact_info[""..info[1]].state = tonumber(info[2])
	end
	for k,v in pairs(attributes) do
		local info = zstring.split(v, "=")
		local attr = zstring.split(info[2], ",")
		local artifact_info = {}
		for k1,v1 in pairs(attr) do
			local obj = {}
			v1 = zstring.split(v1, ":")
			obj.key = tonumber(v1[1])
			obj.value = tonumber(v1[2])
            -- result[""..v1[1]] = zstring.tonumber(result[""..v1[1]]) + tonumber(v1[2])
            table.insert(artifact_info, obj)
		end
		_ED.user_artifact_attributes[""..info[1]] = artifact_info
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_artifact_culture_info 返回神器培养信息 12564
---------------------------------------------------------------------------------------------------------
function parse_artifact_culture_info( interpreter,datas,pos,strDatas,list,count )
	local attributes = zstring.split(npos(list), "=")
	_ED.user_artifact_culture_info = {}
	local info = zstring.split(attributes[2], "|")
	for k,v in pairs(info) do
		v = zstring.split(v, ",")
		local result = {}
		for k1,v1 in pairs(v) do
			v1 = zstring.split(v1, ":")
			local obj = {}
			obj.key = tonumber(v1[1])
			obj.value = tonumber(v1[2])
			table.insert(result, obj)
		end
		table.insert(_ED.user_artifact_culture_info, result)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_artifact_achieve_info 返回成就信息 12565
---------------------------------------------------------------------------------------------------------
function parse_artifact_achieve_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_artifact_achieve_all_sorce = npos(list)
	_ED.user_artifact_achieve_info = {}
	local achieves = zstring.split(npos(list), ",")
	for k,v in pairs(achieves) do
		v = zstring.split(v, ":")
		local result = {}
		result.id = v[1]
		result.speed = v[2]
		table.insert(_ED.user_artifact_achieve_info, result)
	end
	state_machine.excute("notification_center_update",0,"push_notification_cultivate_achieve")
	state_machine.excute("notification_center_update",0,"push_notification_cultivate_achieve_Button_maoxian")
	state_machine.excute("notification_center_update",0,"push_notification_cultivate_achieve_Button_yangcheng")
	state_machine.excute("notification_center_update",0,"push_notification_cultivate_achieve_Button_huodong")
	state_machine.excute("notification_center_update",0,"push_notification_home_cultivate")
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_battle_reports_init 返回战报信息 14700
---------------------------------------------------------------------------------------------------------
function parse_city_resource_battle_reports_init( interpreter,datas,pos,strDatas,list,count )
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		--需要改成二维数组，添加战报类型。
		_ED.city_resource_battle_report = _ED.city_resource_battle_report or {}
		local count = npos(list)
		for i=1,tonumber(count) do
			parse_resource_battle_report_element(interpreter,datas,pos,strDatas,list,count)
		end
	else
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.city_resource_battle_push_info = false
			--需要改成二维数组，添加战报类型。
			_ED.city_resource_battle_report = _ED.city_resource_battle_report or {}
		else
			_ED.city_resource_battle_report = {}
		end
		local count = npos(list)
		for i=1,tonumber(count) do
			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				parse_resource_battle_report_element(interpreter,datas,pos,strDatas,list,count)
			else
				local info = {}
				info.userId = npos(list)				--是我的id就说明我是防守方否则是攻击方
				info.userHeadPic = npos(list)			--头像
				info.userGender = npos(list)			
				info.userLevel = npos(list)				--等级
				info.userCamp = npos(list)
				info.userOfficialRankId = npos(list)
				info.userName = npos(list)
				info.userFighting = npos(list)
				info.result = npos(list)				--胜利失败
				info.param = npos(list)					--附加信息
				info.nType = npos(list)					
				info.time = npos(list)					--时间
				table.insert(_ED.city_resource_battle_report, info)
			end
		end

		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			state_machine.excute("notification_center_update", 0, "push_notification_arena_record")
			state_machine.excute("mail_update_mail_count_info", 0, "")
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_city_resource_battle_report 返回战报信息 14701
---------------------------------------------------------------------------------------------------------
function parse_city_resource_battle_report( interpreter,datas,pos,strDatas,list,count )
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		parse_resource_battle_report_element(interpreter,datas,pos,strDatas,list,count)
	else
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.city_resource_battle_push_info = true
			parse_resource_battle_report_element(interpreter,datas,pos,strDatas,list,count)
			if fwin:find("ArenaRecordClass")~= nil then
				state_machine.excute("arena_my_record_tab_update_draw", 0, 0)
			end
			if fwin:find("MailPresentationAttackClass")~= nil then
				state_machine.excute("mail_presentation_attack_update_draw", 0, 0)
			end
			if fwin:find("MailPresentationDefensiveClass")~= nil then
				state_machine.excute("mail_presentation_defensive_update_draw", 0, 0)
			end
			if fwin:find("MailPresentationInvestigationClass")~= nil then
				state_machine.excute("mail_presentation_investigation_update_draw", 0, 0)
			end
			state_machine.excute("legion_hegemony_report_update_draw", 0, 0)
			state_machine.excute("guard_battle_record_update_draw", 0, 0)
			state_machine.excute("legion_pk_record_update_list_info", 0, 0)
			state_machine.excute("expedition_record_update_list_info", 0, 0)
			
			if _ED.mould_function_push_info["7"] == nil then
				local push_info = {}
				push_info.nType = 7
				push_info.state = 0
				push_info.params = "0,0,0"
				_ED.mould_function_push_info["7"] = push_info
			end

			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				state_machine.excute("notification_center_update", 0, "push_notification_mine_push")
				state_machine.excute("notification_center_update", 0, "push_notification_mine_in_box_push")
				state_machine.excute("notification_center_update", 0, "push_notification_mine_report_push")
				state_machine.excute("notification_center_update", 0, "push_notification_mine_report_attack")
				state_machine.excute("notification_center_update", 0, "push_notification_mine_report_defense")
				state_machine.excute("notification_center_update", 0, "push_notification_mine_report_scout")
				state_machine.excute("notification_center_update", 0, "push_notification_campaign_cell")
				state_machine.excute("notification_center_update", 0, "push_notification_all_daily_campaign")
				state_machine.excute("notification_center_update", 0, "push_notification_all_linited_campaign")
				state_machine.excute("notification_center_update", 0, "push_notification_all_inter_service_campaign")
				state_machine.excute("notification_center_update", 0, "push_notification_campaign_expedition")
				state_machine.excute("notification_center_update", 0, "push_notification_arena_record")

				state_machine.excute("mail_update_mail_count_info", 0, "")
			end
		else
			_ED.city_resource_battle_report = _ED.city_resource_battle_report or {}
			local info = {}
			info.userId = npos(list)
			info.userHeadPic = npos(list)
			info.userGender = npos(list)
			info.userLevel = npos(list)
			info.userCamp = npos(list)
			info.userOfficialRankId = npos(list)
			info.userName = npos(list)
			info.userFighting = npos(list)
			info.result = npos(list)
			info.param = npos(list)
			info.nType = npos(list)
			info.time = npos(list)
			table.insert(_ED.city_resource_battle_report, info)
		end
	end
end

function parse_resource_battle_report_element(interpreter,datas,pos,strDatas,list,count)
	local info = {}
	info.userId = npos(list)				--是我的id就说明我是防守方否则是攻击方
	info.userHeadPic = npos(list)			--头像
	info.userGender = npos(list)			
	info.userLevel = npos(list)				--等级
	info.userCamp = npos(list)
	info.userOfficialRankId = npos(list)
	info.userName = npos(list)
	info.userFighting = npos(list)
	info.result = npos(list)				--胜利失败
	info.param = npos(list)					--附加信息
	info.nType = zstring.tonumber(npos(list))					
	info.time = npos(list)					--时间
	info.read_type = npos(list)				--阅读状态
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon 
		or __lua_project_id == __lua_project_l_naruto 
		then
		info.userSpeed = npos(list)				--附加属性
	end
	--如果有npc,读表
	if info.nType == 200 or info.nType == 209 or info.nType == 10006 then
		local arry = zstring.split(info.param, "|")
		if #arry > 3 and arry[3] ~= nil and arry[3] ~= "" then 
			local arryData = zstring.split(arry[3], ",")
			local nameinfo = arryData[1]
			local nameinfos = zstring.split(nameinfo, "-")
			if #nameinfos > 1 then
				local mouldId = zstring.tonumber(nameinfos[2])
				local currNpcData = nil
				if info.nType == 200 then
					currNpcData = dms.string(dms["npc"], mouldId ,npc.npc_name)
				else
					currNpcData = dms.string(dms["guard_npc"], mouldId , guard_npc.name)
				end
				if currNpcData ~= nil and currNpcData ~= "" then
					arryData[1] = zstring.exchangeFrom(currNpcData)
					info.npc_moud_id = mouldId
					info.isNpc = true
				end
			end
			arry[3] = zstring.concat(arryData, ",")
			info.param = zstring.concat(arry, "|")
		end
	end

	local index = 0
	_ED.city_resource_battle_report = _ED.city_resource_battle_report or {}
	_ED.city_resource_battle_report[tonumber(info.nType)] = _ED.city_resource_battle_report[tonumber(info.nType)] or {}
	local isSame = false
	for i, v in pairs(_ED.city_resource_battle_report[tonumber(info.nType)]) do
		if tonumber(info.time) == tonumber(v.time) and tonumber(info.nType) == tonumber(v.nType) then
			_ED.city_resource_battle_report[tonumber(info.nType)][i] = info
			isSame = true
		end
	end
	if isSame == false then
		table.insert(_ED.city_resource_battle_report[tonumber(info.nType)], info)
		index = #_ED.city_resource_battle_report[tonumber(info.nType)]
	end
	-- debug.print_r(_ED.city_resource_battle_report)
	
	if _ED.city_resource_battle_push_info == true then
		local types = 0
		local isShow = false
		-- local nType = 0
		if tonumber(info.nType) == 200 then
			-- nType = 200
			types = 1
			isShow = true
		elseif tonumber(info.nType) == 1200 then
			-- nType = 1200
			types = 2
			isShow = true
		elseif tonumber(info.nType) == 10002 then
			-- nType = 10002
			types = 3
			isShow = true
		end
		if _ED.mould_function_push_info["7"] == nil then
			local push_info = {}
			push_info.nType = 7
			push_info.state = 0
			push_info.params = "0,0,0"
			_ED.mould_function_push_info["7"] = push_info
		end
		if isShow == true then
			if _ED.city_resource_battle_report[tonumber(info.nType)][index] ~= nil then
				local datas = zstring.split(_ED.mould_function_push_info["7"].params, ",")
				if tonumber(_ED.city_resource_battle_report[tonumber(info.nType)][index].read_type) < 1 then
					datas[types] = ""..tonumber(datas[types])+1
				end
				_ED.mould_function_push_info["7"].params = ""..zstring.tonumber(datas[1])..","..zstring.tonumber(datas[2])..","..zstring.tonumber(datas[3])
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_combat_force_loss 返回战斗兵力损失 14702
---------------------------------------------------------------------------------------------------------
function parse_return_combat_force_loss( interpreter,datas,pos,strDatas,list,count )
	--我方损失
	_ED.fighting_loss = {}
	_ED.fighting_loss.our_side = npos(list)
	_ED.fighting_loss.our_side_percentage = npos(list)
	--敌方损失
	_ED.fighting_loss.the_enemy = npos(list)
	_ED.fighting_loss.the_enemy_percentage = npos(list)
end

---------------------------------------------------------------------------------------------------------
-- parse_back_to_the_report_details_reward_info 返回战报奖励详细信息 14703
---------------------------------------------------------------------------------------------------------
function parse_back_to_the_report_details_reward_info(interpreter,datas,pos,strDatas,list,count )
	local reward_info = npos(list)
	-- _ED.report_reward_info = reward_info
	_ED.report_reward_info = {}
	local reportInfo = zstring.split(reward_info, "!")
	for i=1,#reportInfo do
		_ED.report_reward_info[i] = reportInfo[i]
	end
	
	-- //!奖励
	-- //！配件强度（攻）|配件强度（守）
	-- //！装甲强度（攻）|装甲强度（守）
	-- //！阵容（守）
	-- //! 阵容（攻）
	-- //!先攻状态（0攻击方先攻，1攻击方后攻）
	-- //! 将领强度，将领等级|...（攻）
	-- //! 将领强度，将领等级|...（守）
	-- 例：
	

end

---------------------------------------------------------------------------------------------------------
-- parse_return_to_the_battlefield_to_save_the_information 返回战报奖励详细信息 14704
---------------------------------------------------------------------------------------------------------
function parse_return_to_the_battlefield_to_save_the_information(interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	for i=1,tonumber(count) do
		local info = {}
		info.userId = npos(list)				--是我的id就说明我是防守方否则是攻击方
		info.userHeadPic = npos(list)			--头像
		info.userGender = npos(list)			
		info.userLevel = npos(list)				--等级
		info.userCamp = npos(list)
		info.userOfficialRankId = npos(list)
		info.userName = npos(list)
		info.userFighting = npos(list)
		info.result = npos(list)				--胜利失败
		info.param = npos(list)					--附加信息
		info.nType = zstring.tonumber(npos(list))					
		info.time = npos(list)					--时间
		info.read_type = npos(list)				--阅读状态
		if __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon 
			or __lua_project_id == __lua_project_l_naruto 
			then
			info.userSpeed = npos(list)				--附加属性
		end
		--如果有npc,读表
		if info.nType == 200 then
			local arry = zstring.split(info.param, "|")
			if #arry > 3 and arry[3] ~= nil and arry[3] ~= "" then 
				local arryData = zstring.split(arry[3], ",")
				local nameinfo = arryData[1]
				local nameinfos = zstring.split(nameinfo, "-")
				if #nameinfos > 1 then
					local mouldId = zstring.tonumber(nameinfos[2])
					local currNpcData = dms.element(dms["npc"], mouldId)
					if currNpcData ~= nil then
						local npcNme = zstring.exchangeFrom(dms.atos(currNpcData, npc.npc_name))
						arryData[1] = npcNme
					end
				end
				arry[3] = zstring.concat(arryData, ",")
				info.param = zstring.concat(arry, "|")
			end
		end
		
		_ED.city_resource_battle_save_report = _ED.city_resource_battle_save_report or {}
		local isSame = false
		for i, v in pairs(_ED.city_resource_battle_save_report) do
			if tonumber(info.time) == tonumber(v.time) and tonumber(info.nType) == tonumber(v.nType) then
				_ED.city_resource_battle_save_report[i] = info
				isSame = true
			end
		end
		if isSame == false then
			table.insert(_ED.city_resource_battle_save_report, info)
		end
	end
	-- debug.print_r(_ED.city_resource_battle_save_report)
end

---------------------------------------------------------------------------------------------------------
-- parse_fight_round_begin_talent_attack_all 返回战斗回合开始攻击所有角色 14706
---------------------------------------------------------------------------------------------------------
function parse_fight_round_begin_talent_attack_all( interpreter,datas,pos,strDatas,list,count )
	_ED.fight_round_begin_talent_attack_all = _ED.fight_round_begin_talent_attack_all or {}
	local roundCount = tonumber(npos(list))
	local defendCount = tonumber(npos(list))
	local round_begin_talent_attacks = {}
	_ED.fight_round_begin_talent_attack_all[roundCount] = round_begin_talent_attacks
	for i = 1, defendCount do
		local info = {
			pos = tonumber(npos(list)),
			damage = tonumber(npos(list))
		}
		table.insert(round_begin_talent_attacks, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_to_battle_result_star_info 返回战斗星数 14707
---------------------------------------------------------------------------------------------------------
function parse_return_to_battle_result_star_info(interpreter,datas,pos,strDatas,list,count )
	_ED.battle_result_star_count = zstring.tonumber(npos(list))
end

---------------------------------------------------------------------------------------------------------
-- parse_return_seq_battlefield_report_info_delete 返回战报信息删除 14708
---------------------------------------------------------------------------------------------------------
function parse_return_seq_battlefield_report_info_delete(interpreter,datas,pos,strDatas,list,count )
	local nType = zstring.tonumber(npos(list))			--战报类型
	local read_type = zstring.tonumber(npos(list))		--阅读状态
	if tonumber(nType) == 200 then
		nType = 1
	elseif tonumber(nType) == 1200 then
		nType = 2
	elseif tonumber(nType) == 10002 then
		nType = 3
	end
	if _ED.mould_function_push_info["7"] ~= nil then
		local datas = zstring.split(_ED.mould_function_push_info["7"].params, ",")
		for k,v in pairs(datas) do
			datas[k] = v or "0"
		end
		if read_type < 1 and zstring.tonumber(datas[nType]) > 0 then
			datas[nType] = ""..(zstring.tonumber(datas[nType])-1)
		end
		_ED.mould_function_push_info["7"].params = ""..zstring.tonumber(datas[1])..","..zstring.tonumber(datas[2])..","..zstring.tonumber(datas[3])
	end
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_mine_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_attack")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_defense")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_scout")

		state_machine.excute("mail_update_mail_count_info", 0, "")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_arena_battle_data_report 返回竞技场战斗数据 14709
---------------------------------------------------------------------------------------------------------
function parse_arena_battle_data_report( interpreter,datas,pos,strDatas,list,count )
	_ED.arena_battle_data = {}
	for i=1,2 do
		local info = {}
		info.name = npos(list)
		info.rank = npos(list)
		info.battle_object = npos(list)
		_ED.arena_battle_data[i] = {}
		_ED.arena_battle_data[i] = info
	end
end

function parse_environment_fight_battle_influence_info( interpreter,datas,pos,strDatas,list,count, _skf )
	_skf.defenderCount = zstring.tonumber(npos(list))		-- 效用承受数量
	_skf._defenders = {}
	for w = 1, _skf.defenderCount do
		local _def = {}
		_def.defender = npos(list)  		--承受方1的标识(0:我方 1:对方)
		_def.defenderPos = npos(list)	 	--承受方1的位置

		_def.restrainState = npos(list) 		-- 相克状态(0,无克制 1,有克制,2被克制)
		if _def.restrainState == "1" then
			attData.restrainState = "1"
		end
		_def.defenderST = npos(list)	 	--承受方1的作用效果
		_def.stValue = npos(list) 		--承受方1的作用值
		_def.stVisible = npos(list) 		--是否显示伤害值
		_def.stRound = npos(list)			--承受方1的持续回合数
		_def.defState = npos(list)			--承受方1的承受状态(0:命中 1:闪避 2:暴击 3:格挡 4:暴击加挡格)
		_def.defAState = npos(list)			--承受方1生存状态(0:存活 1:死亡 2:反击)
		if _def.defAState == "1" then
			_def.dropType = npos(list)		--道具、战魂、装备
			_def.dropCount = npos(list)		--(死亡时传)掉落数量
			_ED.battleData._deaths["" .. _def.defender .. "-" .. _def.defenderPos] = true
		elseif _def.defAState == "2" then 
		--[[
			_def.fightBackFlag = npos(list)	-- (反击时传)反击承受方的标识 
			_def.fightBackPos = npos(list)	-- 反击承受方的位置 
			_def.fightBackSkf = npos(list)	-- 反击承受方的作用效果 
			_def.fightBackValue = npos(list)	-- 反击承受方的作用值 
			_def.fightBackRound = npos(list)	-- 反击承受方的持续回合
			_def.fightBackDefState = npos(list)	-- 反击承受方的承受状态 (0:存活 1:死亡)
			_def.fightBackLiveState = npos(list)--反击承受方生存状态 
			if _def.fightBackLiveState == "1" then
				_def.fightBackDropCardCount = npos(list)			-- (死亡时传)掉落卡片数量
			end
			--]]
		end
		_def.aliveHP = npos(list)		--hp
		_def.aliveSP = npos(list)		--sp
		table.insert(_skf._defenders, _def)
	end
end
---------------------------------------------------------------------------------------------------------
-- parse_environment_fight_battle_start_influence_info 返回战斗开始前的信息 14710
---------------------------------------------------------------------------------------------------------
function parse_environment_fight_battle_start_influence_info( interpreter,datas,pos,strDatas,list,count )
	local _skf = {}
	parse_environment_fight_battle_influence_info(interpreter,datas,pos,strDatas,list,count, _skf)
	_ED.battleData._battle_start_influence_info = _skf
	-- debug.print_r(_ED.battleData._battle_start_influence_info)
	debug.print_r(_ED.battleData._camp_change_influence_infos, "返回战斗开始前的信息")
end

---------------------------------------------------------------------------------------------------------
-- parse_environment_fight_round_start_influence_info 返回战斗每个回合前的信息 14711
---------------------------------------------------------------------------------------------------------
function parse_environment_fight_round_start_influence_info( interpreter,datas,pos,strDatas,list,count )
	_ED.battleData._battle_round_influence_infos = _ED.battleData._battle_round_influence_infos or {}
	local defenderCount = zstring.tonumber(npos(list))
	local _skf = {}
	parse_environment_fight_battle_influence_info(interpreter,datas,pos,strDatas,list,count, _skf)
	_ED.battleData._battle_round_influence_infos[defenderCount] = _skf
	-- debug.print_r(_skf)

	debug.print_r(_ED.battleData._camp_change_influence_infos, "返回战斗每个回合前的信息")
end

---------------------------------------------------------------------------------------------------------
-- parse_environment_fight_battle_camp_change_influence_info 返回战斗每个回合内的攻击方切换的信息 14712
---------------------------------------------------------------------------------------------------------
function parse_environment_fight_battle_camp_change_influence_info( interpreter,datas,pos,strDatas,list,count )
	_ED.battleData._camp_change_influence_infos = _ED.battleData._camp_change_influence_infos or {}
	local roundCount = npos(list)
	local defenderTag = npos(list)
	local _skf = {}
	parse_environment_fight_battle_influence_info(interpreter,datas,pos,strDatas,list,count, _skf)
	_ED.battleData._camp_change_influence_info = _skf
	_ED.battleData._camp_change_influence_infos[roundCount .. "-" .. defenderTag] = _skf

	debug.print_r(_ED.battleData._camp_change_influence_infos, "返回战斗每个回合内的攻击方切换的信息")

end

---------------------------------------------------------------------------------------------------------
-- parse_environment_fight_battle_init_object_info 返回战场对象的基础属性 14713
---------------------------------------------------------------------------------------------------------
function parse_environment_fight_battle_init_object_info( interpreter,datas,pos,strDatas,list,count )
	local currentRoundIndex = tonumber(npos(list))
	local roleCount = tonumber(npos(list))
	-- print("返回战场对象的基础属性:", currentRoundIndex, roleCount)
	for i = 1, roleCount do
		local battleTag = npos(list)
		local coordinate = npos(list)
		local role = nil
		if battleTag == "0" then
			role = _ED.battleData._heros[coordinate]
		else
			role = _ED.battleData._armys[currentRoundIndex]._data[coordinate]
		end

		-- if nil ~= role then
			npos(list)
			npos(list)
			npos(list)
			-- role._hp = tonumber(npos(list))
			-- role._max_hp = tonumber(npos(list))
			-- role._sp = tonumber(npos(list))
			-- -- print(battleTag, coordinate, role._hp, role._max_hp, role._sp)
		-- end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_fight_rank_info 返回战力排行 12600
---------------------------------------------------------------------------------------------------------
function parse_return_user_fight_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.fight_ranks = _ED.fight_ranks or {}
	_ED.fight_ranks.my_info = _ED.fight_ranks.my_info or {}
	_ED.fight_ranks.my_info.now_rank = zstring.tonumber(npos(list))
	_ED.fight_ranks.my_info.last_rank = zstring.tonumber(npos(list))
	_ED.fight_ranks.my_info.fight_number = zstring.tonumber(npos(list))

	_ED.fight_ranks.other_user = _ED.fight_ranks.other_user or {}
	local count = tonumber(npos(list))
    for i = 1 ,count do 
        _ED.fight_ranks.other_user[i] = _ED.fight_ranks.other_user[i] or {}
        _ED.fight_ranks.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.fight_ranks.other_user[i].user_name = npos(list)
        _ED.fight_ranks.other_user[i].user_rank_title_name = npos(list)
        _ED.fight_ranks.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.fight_ranks.other_user[i].user_rank = zstring.tonumber(npos(list))
        _ED.fight_ranks.other_user[i].user_last_rank = zstring.tonumber(npos(list))
        _ED.fight_ranks.other_user[i].user_sex = zstring.tonumber(npos(list))
        -- TODO...
        _ED.fight_ranks.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.fight_ranks.other_user[i].user_level = zstring.tonumber(npos(list))
        if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
	        _ED.fight_ranks.other_user[i].user_vip_level = zstring.tonumber(npos(list))
	    end
        _ED.fight_ranks.other_user[i].user_official = zstring.tonumber(npos(list))
        _ED.fight_ranks.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.fight_ranks.other_user[i].user_union_name = npos(list)
        _ED.fight_ranks.other_user[i].user_union_id = zstring.tonumber(npos(list))
    end
    if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
    else
	    for i = count+1,9 do
	    	_ED.fight_ranks.other_user[i] = nil
	    end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_user_level_rank_info 12601 返回角色等级排行
---------------------------------------------------------------------------------------------------------
function parse_user_level_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.level_rank =  _ED.level_rank or {}
	_ED.level_rank.my_info = _ED.level_rank.my_info or {}
	_ED.level_rank.other_user = _ED.level_rank.other_user or {}
	
	_ED.level_rank.my_info.user_rank = npos(list)
	_ED.level_rank.my_info.user_arena_id = npos(list)
	_ED.level_rank.my_info.user_official = dms.int(dms["arena_reward_param"],_ED.level_rank.my_info.user_arena_id,arena_reward_param.arena_official)
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.level_rank.other_user[i] = _ED.level_rank.other_user[i] or {}
		_ED.level_rank.other_user[i].user_rank = i
        _ED.level_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.level_rank.other_user[i].user_name = npos(list)
        _ED.level_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.level_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.level_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.level_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.level_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.level_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
		_ED.level_rank.other_user[i].user_official = dms.int(dms["arena_reward_param"],_ED.level_rank.other_user[i].user_arena_id,arena_reward_param.arena_official)
        _ED.level_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.level_rank.other_user[i].user_union_name = npos(list)
        _ED.level_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
        	npos(list)
        	npos(list)
    	end 
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_npc_rank_info 返回关卡排行 12602
---------------------------------------------------------------------------------------------------------
function parse_return_user_npc_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.npc_rank = _ED.npc_rank or {}
	_ED.npc_rank.my_info = _ED.npc_rank.my_info or {}
	_ED.npc_rank.other_user = {}
	
	_ED.npc_rank.my_info.user_rank = npos(list)
	_ED.npc_rank.my_info.user_arena_id = npos(list)
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		_ED.npc_rank.my_info.npc_count = npos(list)
	end
	-- _ED.npc_rank.my_info.user_official = dms.int(dms["arena_reward_param"],_ED.npc_rank.my_info.user_arena_id,arena_reward_param.arena_official)
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.npc_rank.other_user[i] = _ED.npc_rank.other_user[i] or {}
		_ED.npc_rank.other_user[i].user_rank = i
        _ED.npc_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].user_name = npos(list)
        _ED.npc_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
		-- _ED.npc_rank.other_user[i].user_official = dms.int(dms["arena_reward_param"],_ED.npc_rank.other_user[i].user_arena_id,arena_reward_param.arena_official)
        _ED.npc_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].user_union_name = npos(list)
        _ED.npc_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].npc_count = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].exploit = zstring.tonumber(npos(list))
        _ED.npc_rank.other_user[i].user_rank_title_name = npos(list)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_exploit_rank_info 返回军功排行 12603
---------------------------------------------------------------------------------------------------------
function parse_return_user_exploit_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.exploit_rank = _ED.exploit_rank or {}
	_ED.exploit_rank.my_info = _ED.exploit_rank.my_info or {}
	_ED.exploit_rank.other_user = {}
	
	_ED.exploit_rank.my_info.user_rank = npos(list)
	_ED.exploit_rank.my_info.user_arena_id = npos(list)
	-- _ED.exploit_rank.my_info.user_official = dms.int(dms["arena_reward_param"],_ED.exploit_rank.my_info.user_arena_id,arena_reward_param.arena_official)
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.exploit_rank.other_user[i] = _ED.exploit_rank.other_user[i] or {}
		_ED.exploit_rank.other_user[i].user_rank = i
        _ED.exploit_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].user_name = npos(list)
        _ED.exploit_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
		-- _ED.exploit_rank.other_user[i].user_official = dms.int(dms["arena_reward_param"],_ED.npc_rank.other_user[i].user_arena_id,arena_reward_param.arena_official)
        _ED.exploit_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].user_union_name = npos(list)
        _ED.exploit_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].npc_count = zstring.tonumber(npos(list))
        _ED.exploit_rank.other_user[i].exploit = zstring.tonumber(npos(list))
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_to_the_user_own_ranking 返回用户自己排行 12604
---------------------------------------------------------------------------------------------------------
function parse_return_to_the_user_own_ranking( interpreter,datas,pos,strDatas,list,count )
	local p_type = zstring.tonumber(npos(list))	--类型
	local ranking = zstring.tonumber(npos(list))	--排行(无排行为0) 
	_ED.user_ranking_act = _ED.user_ranking_act or {}
	_ED.user_ranking_act[p_type] = _ED.user_ranking_act[p_type] or {}
	_ED.user_ranking_act[p_type].ranking = ranking
	-- debug.print_r(_ED.user_ranking_act)
end


---------------------------------------------------------------------------------------------------------
-- parse_return_the_number_of_cards 返回卡牌数量 12605
---------------------------------------------------------------------------------------------------------
function parse_return_the_number_of_cards( interpreter,datas,pos,strDatas,list,count )
	_ED.card_number_rank = _ED.card_number_rank or {}
	_ED.card_number_rank.my_info = _ED.card_number_rank.my_info or {}
	_ED.card_number_rank.other_user = {}
	
	_ED.card_number_rank.my_info.user_rank = npos(list)
	_ED.card_number_rank.my_info.user_arena_id = npos(list)
	_ED.card_number_rank.my_info.user_speed = npos(list)
	_ED.card_number_rank.my_info.card_count = npos(list)
	-- _ED.npc_rank.my_info.user_official = dms.int(dms["arena_reward_param"],_ED.npc_rank.my_info.user_arena_id,arena_reward_param.arena_official)
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.card_number_rank.other_user[i] = _ED.card_number_rank.other_user[i] or {}
		_ED.card_number_rank.other_user[i].user_rank = i
        _ED.card_number_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].user_name = npos(list)
        _ED.card_number_rank.other_user[i].user_rank_title_name = npos(list)
        _ED.card_number_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
		-- _ED.npc_rank.other_user[i].user_official = dms.int(dms["arena_reward_param"],_ED.npc_rank.other_user[i].user_arena_id,arena_reward_param.arena_official)
        _ED.card_number_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].user_union_name = npos(list)
        _ED.card_number_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].npc_count = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].exploit = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].card_count = zstring.tonumber(npos(list))
        _ED.card_number_rank.other_user[i].user_speed = zstring.tonumber(npos(list))
	end
end


---------------------------------------------------------------------------------------------------------
-- parse_return_to_the_strongest_card_list 返回最强数码兽排行 12606
---------------------------------------------------------------------------------------------------------
function parse_return_to_the_strongest_card_list( interpreter,datas,pos,strDatas,list,count )
	_ED.strongest_card_rank = _ED.strongest_card_rank or {}
	_ED.strongest_card_rank.my_info = _ED.strongest_card_rank.my_info or {}
	_ED.strongest_card_rank.other_user = {}
	
	_ED.strongest_card_rank.my_info.ship_id = npos(list)
	if tonumber(_ED.strongest_card_rank.my_info.ship_id) > 0 then
		_ED.strongest_card_rank.my_info.user_rank = npos(list)
		_ED.strongest_card_rank.my_info.ship_info = npos(list)
		_ED.strongest_card_rank.my_info.ship_fight = npos(list)
	end
	-- _ED.npc_rank.my_info.user_official = dms.int(dms["arena_reward_param"],_ED.npc_rank.my_info.user_arena_id,arena_reward_param.arena_official)
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.strongest_card_rank.other_user[i] = _ED.strongest_card_rank.other_user[i] or {}
		_ED.strongest_card_rank.other_user[i].user_rank = i
        _ED.strongest_card_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].user_name = npos(list)
        _ED.strongest_card_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
		-- _ED.npc_rank.other_user[i].user_official = dms.int(dms["arena_reward_param"],_ED.npc_rank.other_user[i].user_arena_id,arena_reward_param.arena_official)
        _ED.strongest_card_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].user_union_name = npos(list)
        _ED.strongest_card_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].npc_count = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].exploit = zstring.tonumber(npos(list))
        _ED.strongest_card_rank.other_user[i].user_rank_title_name = npos(list)
        _ED.strongest_card_rank.other_user[i].ship_id = zstring.tonumber(npos(list)) --武将实例id
        _ED.strongest_card_rank.other_user[i].ship_info = npos(list)--武将数据
        _ED.strongest_card_rank.other_user[i].ship_fight = zstring.tonumber(npos(list))--武将战力
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_user_three_kingdoms_score_rank_info 返回用户数码试炼排行 12607
---------------------------------------------------------------------------------------------------------
function parse_user_three_kingdoms_score_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.three_kingdoms_score_rank = _ED.three_kingdoms_score_rank or {}
	_ED.three_kingdoms_score_rank.my_info = _ED.three_kingdoms_score_rank.my_info or {}
	_ED.three_kingdoms_score_rank.other_user = {}
	
	_ED.three_kingdoms_score_rank.my_info.user_rank = zstring.tonumber(npos(list))
	_ED.three_kingdoms_score_rank.my_info.score = npos(list)
	_ED.three_kingdoms_score_rank.my_info.layer_count = npos(list)
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.three_kingdoms_score_rank.other_user[i] = _ED.three_kingdoms_score_rank.other_user[i] or {}
		_ED.three_kingdoms_score_rank.other_user[i].user_rank = i
        _ED.three_kingdoms_score_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].user_name = npos(list)
        _ED.three_kingdoms_score_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].user_union_name = npos(list)
        _ED.three_kingdoms_score_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].score = zstring.tonumber(npos(list))
        _ED.three_kingdoms_score_rank.other_user[i].layer_count = zstring.tonumber(npos(list))
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_user_union_stick_crazy_adventure_progress_rank_info 返回用户比利的棍子排行榜排行 12608
---------------------------------------------------------------------------------------------------------
function parse_user_union_stick_crazy_adventure_progress_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.union_stick_crazy_adventure_progress_rank = _ED.union_stick_crazy_adventure_progress_rank or {}
	_ED.union_stick_crazy_adventure_progress_rank.my_info = _ED.union_stick_crazy_adventure_progress_rank.my_info or {}
	_ED.union_stick_crazy_adventure_progress_rank.other_user = {}
	
	_ED.union_stick_crazy_adventure_progress_rank.my_info.user_rank = zstring.tonumber(npos(list))
	_ED.union_stick_crazy_adventure_progress_rank.my_info.number = npos(list)
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.union_stick_crazy_adventure_progress_rank.other_user[i] = _ED.union_stick_crazy_adventure_progress_rank.other_user[i] or {}
		_ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_rank = i
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_name = npos(list)
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_union_name = npos(list)
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        _ED.union_stick_crazy_adventure_progress_rank.other_user[i].number = zstring.tonumber(npos(list))
	end
end


---------------------------------------------------------------------------------------------------------
-- parse_user_the_kings_battle_score_rank_info 返回用户王者之战排行榜排行 12609
---------------------------------------------------------------------------------------------------------
function parse_user_the_kings_battle_score_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.battle_kings_score_rank = _ED.battle_kings_score_rank or {}
	_ED.battle_kings_score_rank.my_info = _ED.battle_kings_score_rank.my_info or {}
	_ED.battle_kings_score_rank.other_user = {}
	
	_ED.battle_kings_score_rank.my_info.user_rank = zstring.tonumber(npos(list))
	_ED.battle_kings_score_rank.my_info.score = npos(list)					--积分
	_ED.battle_kings_score_rank.my_info.layer_count = npos(list)			--胜利次数
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.battle_kings_score_rank.other_user[i] = _ED.battle_kings_score_rank.other_user[i] or {}
		_ED.battle_kings_score_rank.other_user[i].user_rank = i
        _ED.battle_kings_score_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].user_name = npos(list)
        _ED.battle_kings_score_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].user_union_name = npos(list)
        _ED.battle_kings_score_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        _ED.battle_kings_score_rank.other_user[i].score = zstring.tonumber(npos(list))			--积分
        _ED.battle_kings_score_rank.other_user[i].layer_count = zstring.tonumber(npos(list))	--胜利次数
        _ED.battle_kings_score_rank.other_user[i].betting_count = zstring.tonumber(npos(list))	--下注次数
        _ED.battle_kings_score_rank.other_user[i].total_gold = zstring.tonumber(npos(list))	--总金额
        _ED.battle_kings_score_rank.other_user[i].current_gold = zstring.tonumber(npos(list))	--池内金额
        _ED.battle_kings_score_rank.other_user[i].percent = math.floor(zstring.tonumber(npos(list))*100)/100	--赔率
        _ED.battle_kings_score_rank.other_user[i].user_rank_title_name = npos(list)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_user_achieve_score_rank_info 返回用户成就积分排行榜排行 12610
---------------------------------------------------------------------------------------------------------
function parse_user_achieve_score_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_achieve_score_rank = _ED.user_achieve_score_rank or {}
	_ED.user_achieve_score_rank.my_info = _ED.user_achieve_score_rank.my_info or {}
	_ED.user_achieve_score_rank.other_user = {}
	
	_ED.user_achieve_score_rank.my_info.user_rank = zstring.tonumber(npos(list))
	_ED.user_achieve_score_rank.my_info.score = npos(list)					--积分
	
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.user_achieve_score_rank.other_user[i] = _ED.user_achieve_score_rank.other_user[i] or {}
		_ED.user_achieve_score_rank.other_user[i].user_rank = i
        _ED.user_achieve_score_rank.other_user[i].user_id = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].user_name = npos(list)
        _ED.user_achieve_score_rank.other_user[i].user_sex = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].user_head_id = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].user_camp = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].user_level = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].user_vip_level = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].user_arena_id = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].user_fight = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].user_union_name = npos(list)
        _ED.user_achieve_score_rank.other_user[i].user_union_id = zstring.tonumber(npos(list))
        _ED.user_achieve_score_rank.other_user[i].score = zstring.tonumber(npos(list))			--积分
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_arena_user_info 12700 返回竞技场初始化
---------------------------------------------------------------------------------------------------------
function parse_return_arena_user_info( interpreter,datas,pos,strDatas,list,count )
	-- 官阶id
	-- 排名
	-- 剩余攻击次数
	local arena_id = npos(list)
	local formation = nil
	local integral = nil --积分
	local state_group = nil --状态组（0未，1已）
	local settlement_rankings = nil --结算排名
	local settlement_state = nil --结算排名奖励领取状态（0未，1已）
	local lucky_state = nil --幸运排名奖励领取状态（0未，1已）
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		formation = npos(list)
	end
	local rank = npos(list)
	local leave_attack_count = npos(list)
	local buy_attack_count = npos(list)
	--战斗冷却时间
	local fight_cooling_time = nil
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		fight_cooling_time = math.floor(zstring.tonumber(npos(list)) / 1000)
		integral = npos(list)
		state_group = npos(list)
		settlement_rankings = npos(list)
		settlement_state = npos(list)
		lucky_state = npos(list)
	end
	
	_ED.arena_info.arena_id = tonumber(arena_id)
	_ED.arena_info.rank = tonumber(rank)
	_ED.arena_info.leave_attack_count = tonumber(leave_attack_count)
	_ED.arena_info.buy_attack_count = tonumber(buy_attack_count)
	_ED.arena_info.user_official = dms.int(dms["arena_reward_param"],_ED.arena_info.arena_id,arena_reward_param.arena_official)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		_ED.arena_info.arena_formation = formation
		_ED.arena_info.fight_cooling_time = fight_cooling_time
		_ED.arena_info.integral = integral
		_ED.arena_info.state_group = state_group
		_ED.arena_info.settlement_rankings = settlement_rankings
		_ED.arena_info.settlement_state = settlement_state
		_ED.arena_info.lucky_state = lucky_state
	end
	-- print("======",arena_id,rank,leave_attack_count,buy_attack_count)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_arena_all_reward")
		state_machine.excute("notification_center_update", 0, "push_notification_arena_integral_reward")
		state_machine.excute("notification_center_update", 0, "push_notification_arena_rank_reward")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_arena_user_info 12701 返回竞技场角色列表刷新
---------------------------------------------------------------------------------------------------------
function parse_return_arena_user_change_info( interpreter,datas,pos,strDatas,list,count )
	--print("1111111111111111111111")
	--数量 用户ID  用户昵称 阵营 性别 头像 等级 战力 排名 官阶id 阵容 工会名称 工会id 连胜次数
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		_ED.arena_info.user_info = {}
	end
	_ED.arena_info.user_info = _ED.arena_info.user_info or {}
	local count = zstring.tonumber(npos(list))
	for i = 1,count do
		_ED.arena_info.user_info[i] = _ED.arena_info.user_info[i] or {}
        _ED.arena_info.user_info[i].user_id = zstring.tonumber(npos(list))
        _ED.arena_info.user_info[i].user_name = npos(list)
        _ED.arena_info.user_info[i].user_camp = zstring.tonumber(npos(list))
        _ED.arena_info.user_info[i].user_sex = zstring.tonumber(npos(list))
        -- TODO...
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.arena_info.user_info[i].user_head_id = npos(list)
		else
			_ED.arena_info.user_info[i].user_head_id = zstring.tonumber(npos(list))
		end
        
        _ED.arena_info.user_info[i].user_level = zstring.tonumber(npos(list))
        _ED.arena_info.user_info[i].user_fight = zstring.tonumber(npos(list))
        _ED.arena_info.user_info[i].user_rank = zstring.tonumber(npos(list))
        _ED.arena_info.user_info[i].user_arena_id = zstring.tonumber(npos(list))
        _ED.arena_info.user_info[i].user_official = dms.int(dms["arena_reward_param"],_ED.arena_info.user_info[i].user_arena_id,arena_reward_param.arena_official)
        local ship_moulds_str = npos(list)
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.arena_info.user_info[i].ship_moulds = ship_moulds_str
		else
			ship_moulds_str = zstring.split(ship_moulds_str,",")
			local ship_moulds = {}
			-- print("===========",ship_moulds_str)
			for k,v in pairs(ship_moulds_str) do
				if zstring.tonumber(v) > 0 then
					table.insert(ship_moulds,v)
				end
			end
			_ED.arena_info.user_info[i].ship_moulds = ship_moulds
		end

        _ED.arena_info.user_info[i].user_union_name = npos(list)
        _ED.arena_info.user_info[i].user_union_id = zstring.tonumber(npos(list))
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.arena_info.user_info[i].win_streak_number = zstring.tonumber(npos(list))
		end
	end

	for i = count+1,9 do
    	_ED.arena_info.user_info[i] = nil
    end
	-- local achieve_string = ""
	-- for i,v in pairs(_ED.arena_info.user_info) do
		-- if i == 1 then

		-- else
			
		-- end
	-- end	
	-- cc.UserDefault:getInstance():setStringForKey("arena_info_user_info", )
	-- cc.UserDefault:getInstance():flush()
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_arena_all_reward")
		state_machine.excute("notification_center_update", 0, "push_notification_arena_integral_reward")
		state_machine.excute("notification_center_update", 0, "push_notification_arena_rank_reward")
	end
end
		
---------------------------------------------------------------------------------------------------------
-- parse_return_arena_rank_info 12702 返回排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_arena_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.city_rank =  _ED.city_rank or {}

	_ED.city_rank.my_info = _ED.city_rank.my_info or {}

	local back_type = zstring.tonumber(npos(list))
	if back_type == 1 then
	    _ED.city_rank.my_info.user_id = zstring.tonumber(npos(list))
	    _ED.city_rank.my_info.user_name = npos(list)
	    _ED.city_rank.my_info.user_camp = zstring.tonumber(npos(list))
	    _ED.city_rank.my_info.user_sex = zstring.tonumber(npos(list))
	    -- TODO...
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.city_rank.my_info.user_head_id = npos(list)
		else
			_ED.city_rank.my_info.user_head_id = zstring.tonumber(npos(list))
		end
	    _ED.city_rank.my_info.user_level = zstring.tonumber(npos(list))
	    _ED.city_rank.my_info.user_fight = zstring.tonumber(npos(list))
	    _ED.city_rank.my_info.user_rank = zstring.tonumber(npos(list))
	    _ED.city_rank.my_info.user_arena_id = zstring.tonumber(npos(list))
	    _ED.city_rank.my_info.user_official = dms.int(dms["arena_reward_param"],_ED.city_rank.my_info.user_arena_id,arena_reward_param.arena_official)
	    local ship_moulds_str_my = npos(list)
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.city_rank.my_info.ship_moulds = ship_moulds_str_my
		else
			ship_moulds_str_my = zstring.split(ship_moulds_str_my,",")
			local ship_moulds_my = {}
			-- print("===========",ship_moulds_str)
			for k,v in pairs(ship_moulds_str_my) do
				if zstring.tonumber(v) > 0 then
					table.insert(ship_moulds_my,v)
				end
			end
			_ED.city_rank.my_info.ship_moulds = ship_moulds
		end

        _ED.city_rank.my_info.user_union_name = npos(list)
        _ED.city_rank.my_info.user_union_id = zstring.tonumber(npos(list))
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.city_rank.my_info.win_streak_number = zstring.tonumber(npos(list))
		end
	else
  		_ED.city_rank.my_info.user_id = _ED.user_info.user_id
	    _ED.city_rank.my_info.user_name = _ED.user_info.user_name
	    _ED.city_rank.my_info.user_camp = _ED.user_info.user_force
	    _ED.city_rank.my_info.user_sex = _ED.user_info.user_gender
	    -- TODO...
	    _ED.city_rank.my_info.user_head_id = _ED.user_info.user_head_id
	    _ED.city_rank.my_info.user_level = _ED.user_info.user_grade
	    _ED.city_rank.my_info.user_fight = _ED.user_info.user_fight
	    _ED.city_rank.my_info.user_rank = 10000
	    _ED.city_rank.my_info.user_arena_id = 33
	    _ED.city_rank.my_info.user_official = dms.int(dms["arena_reward_param"],_ED.city_rank.my_info.user_arena_id,arena_reward_param.arena_official)
	    _ED.city_rank.my_info.ship_moulds = ""
	end

	local camp_count = zstring.tonumber(npos(list))
	_ED.city_rank.other_user = _ED.city_rank.other_user or {}
	for i = 1,camp_count do
		local camp = zstring.tonumber(npos(list))
		_ED.city_rank.other_user[camp] = _ED.city_rank.other_user[camp] or {}
		local user_count = zstring.tonumber(npos(list))
		for k = 1 ,user_count do
			local info = {}
			-- _ED.city_rank.other_user[camp][k] = _ED.city_rank.other_user[camp][k] or {}
	        info.user_id = zstring.tonumber(npos(list))
	        info.user_name = npos(list)
	        info.user_camp = zstring.tonumber(npos(list))
	        info.user_sex = zstring.tonumber(npos(list))
	        -- TODO...
			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				info.user_head_id = npos(list)
			else
				info.user_head_id = zstring.tonumber(npos(list))
			end
	        info.user_level = zstring.tonumber(npos(list))
	        info.user_fight = zstring.tonumber(npos(list))
	        info.user_rank = zstring.tonumber(npos(list))
	        info.user_arena_id = zstring.tonumber(npos(list))
	        info.user_official = dms.int(dms["arena_reward_param"],info.user_arena_id,arena_reward_param.arena_official)
	       
	        local ship_moulds_str = npos(list)
			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				info.ship_moulds = ship_moulds_str
			else	
				ship_moulds_str = zstring.split(ship_moulds_str,",")
				local ship_moulds = {}
				-- print("===========",ship_moulds_str)
				for k,v in pairs(ship_moulds_str) do
					if zstring.tonumber(v) > 0 then
						table.insert(ship_moulds,v)
					end
				end
				info.ship_moulds = ship_moulds
			end

	        info.user_union_name = npos(list)
	        info.user_union_id = zstring.tonumber(npos(list))
			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				info.win_streak_number = zstring.tonumber(npos(list))
			end
			_ED.city_rank.other_user[camp][info.user_rank] = info
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_arena_lounch 12703  返回竞技场战斗请求
---------------------------------------------------------------------------------------------------------
function parse_return_arena_lounch( interpreter,datas,pos,strDatas,list,count )

end

---------------------------------------------------------------------------------------------------------
-- parse_back_to_the_arena_store 12706  返回竞技场商店
---------------------------------------------------------------------------------------------------------
function parse_back_to_the_arena_store( interpreter,datas,pos,strDatas,list,count )
	local shop_item_id = npos(list)			--商店id集合  
	local exchange_status = npos(list)		--兑换状态集合
	local refresh_times = npos(list)		--已刷新次数
	_ED.arena_info.shop_id_clump = shop_item_id
	_ED.arena_info.status_clump = exchange_status
	_ED.arena_info.refresh_times = refresh_times
end

---------------------------------------------------------------------------------------------------------
-- parse_return_to_the_arena_lucky_information 12707  返回战地争霸幸运排名信息
---------------------------------------------------------------------------------------------------------
function parse_return_to_the_arena_lucky_information( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	for i=1,count do
		_ED.arena_lucky_ranking[i] = {}
		_ED.arena_lucky_ranking[i].lucky_mould_id = npos(list)		--幸运模板id
		_ED.arena_lucky_ranking[i].this_period_lucky_rank = npos(list)		--本期幸运排名
		_ED.arena_lucky_ranking[i].previous_period_lucky_rank_id = npos(list)	--上期幸运玩家id
		_ED.arena_lucky_ranking[i].previous_period_lucky_rank_name = npos(list)	--上期幸运玩家昵称
		_ED.arena_lucky_ranking[i].previous_period_lucky_rand = npos(list)		--上期幸运排名
	end
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_arena_all_reward")
		state_machine.excute("notification_center_update", 0, "push_notification_arena_lucky_reward")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_the_kings_battle_init_info 12710  返回王者之战的初始化信息
---------------------------------------------------------------------------------------------------------
function parse_the_kings_battle_init_info( interpreter,datas,pos,strDatas,list,count )
	-- 王者之战的开启状态：
	-- 0:关闭
	-- 1:报名中
	-- 2:vip报名
	-- 3:等待比赛开启
	-- 4:比赛中
	_ED.kings_battle.kings_battle_open_type = npos(list)
	-- 王者之战下一个状态的时间点
	_ED.kings_battle.kings_battle_next_time = npos(list)
	-- 王者之战下一个状态的剩余CD
	_ED.kings_battle.time_now = os.time()
	-- _ED.kings_battle.kings_battle_next_time_cd = npos(list)
	-- 王者之战的开启时间
	_ED.kings_battle.activity_on_time = npos(list)
	-- 王者之战的剩余CD
	_ED.kings_battle.activity_remaining_cd = npos(list)
	--战斗单场结束cd时间
	_ED.kings_battle.single_field_end_cd = npos(list)
	--参加人数
	_ED.kings_battle.add_number = npos(list)

	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_arena_all")
	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_battle_of_kings_all")
	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_battle_of_kings_betting")
end

---------------------------------------------------------------------------------------------------------
-- parse_the_kings_battle_user_info 12711  返回王者之战的用户信息
---------------------------------------------------------------------------------------------------------
function parse_the_kings_battle_user_info( interpreter,datas,pos,strDatas,list,count )
	--王者之战的参战状态
	_ED.kings_battle.kings_battle_type = npos(list)
	-- 	0:未报名
	--	1:报名中
	--	2:比赛中
	--	3:被淘汰

	--下注信息:下注类型，下注的实例ID
	_ED.kings_battle.kings_battle_betting = npos(list)
	--参战的阵型信息:武将信息1！武将信息2！...
	_ED.kings_battle.kings_battle_user_formation = npos(list) -- 模板ID：等级：进化状态：星级:品阶:战力:实例ID:速度:斗魂:技能等级：皮肤id
	--比赛结果：结果，战报文件名，对决的人|
	_ED.kings_battle.kings_battle_result = npos(list)
	--	结果：
	--		0:失败
	--		1:胜利

	--比赛排名
	_ED.kings_battle.kings_battle_user_ranking = npos(list)
	--胜利次数
	_ED.kings_battle.my_win_number = npos(list)
	--失败次数
	_ED.kings_battle.my_lose_number = npos(list)
	--积分
	_ED.kings_battle.integral = npos(list)

	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_arena_all")
	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_battle_of_kings_all")
	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_battle_of_kings_betting")
end

---------------------------------------------------------------------------------------------------------
-- parse_the_kings_battle_peakedness_duel_info 12712  返回王者之战的巅峰对决的信息
---------------------------------------------------------------------------------------------------------
function parse_the_kings_battle_peakedness_duel_info( interpreter,datas,pos,strDatas,list,count )
	_ED.kings_battle.peak_list = {}
	--数量
	_ED.kings_battle.peak_number = npos(list)
	for i=1,tonumber(_ED.kings_battle.peak_number) do
		--用户ID
		local user_id = npos(list)
		--名称
		local user_name = npos(list)
		--上一次的参战的阵型信息:武将信息1！武将信息2！...
		local kings_battle_last_formation = npos(list) --模板ID：等级：进化状态：星级:品阶:战力:实例ID:速度:斗魂:技能等级：皮肤id
		 -- * 决赛比赛结果：结果，战报文件名，对决的人，UI显示的位置（如下图）|
		 -- * 
		 -- * 			*   *    *   *
		 -- * 			  *		   *
		 -- * 			*   *    *   *
		 -- * 
		 -- * 			1   2    3   4
		 -- * 			  9	  11   10
		 -- * 			5   6    7   8
		 -- * 
		 -- * 	0:失败
		 -- * 	1:胜利
		 local kings_battle_last_result = npos(list)

		--上一次比赛排名
		local kings_battle_last_ranking = npos(list)

		local kings_battle_last_integral = npos(list)

		local is_offline = npos(list) 		-- 0在线，1不在线
		local peak_list = {}
		peak_list.id = user_id
		peak_list.name = user_name
		peak_list.formation = kings_battle_last_formation
		peak_list.result = kings_battle_last_result
		peak_list.ranking = kings_battle_last_ranking
		peak_list.integral = kings_battle_last_integral
		peak_list.is_offline = is_offline
		if _ED.kings_battle.peak_list[user_id] == nil then
			_ED.kings_battle.peak_list[user_id] = {}
		end
		_ED.kings_battle.peak_list[user_id] = peak_list
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_the_kings_battle_battle_report_info 12713  返回王者之战的战报推送信息
---------------------------------------------------------------------------------------------------------
function parse_the_kings_battle_battle_report_info( interpreter,datas,pos,strDatas,list,count )
	--数量
	_ED.kings_battle.war_report_number = npos(list)
	_ED.kings_battle.new_event = npos(list)
	_ED.kings_battle.war_report_info = _ED.kings_battle.war_report_info or {}
	for i=1,tonumber(_ED.kings_battle.war_report_number) do
		local text_info = npos(list) 
		local text_data = zstring.split(text_info, ",")
		if _ED.kings_battle.war_report_info[tonumber(text_data[1])] == nil then
			_ED.kings_battle.war_report_info[tonumber(text_data[1])] = text_info
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_the_kings_battle_match_info 12714  返回王者之战的战半匹配信息
---------------------------------------------------------------------------------------------------------
function parse_the_kings_battle_match_info( interpreter,datas,pos,strDatas,list,count )
	-- 数量
	_ED.kings_battle.match_number = npos(list)
	_ED.kings_battle.battle_match_info = _ED.kings_battle.battle_match_info or {} 
	for i=1, tonumber(_ED.kings_battle.match_number) do
		-- 用户昵称，用户等级，用户战力@战斗场次索引@我方阵型@敌方阵型
		local battle_match = npos(list)
		local match_info = {}
		local datas = zstring.split(battle_match,"@")
		local datas_user_info = zstring.split(datas[1],",")
		match_info.name = datas_user_info[1]
		match_info.lv = datas_user_info[2] 
		match_info.fight = datas_user_info[3] 
		match_info.index = datas[2]
		match_info.my_formation = datas[3]
		match_info.other_side_formation = datas[4]
		_ED.kings_battle.battle_match_info[tonumber(match_info.index)+1] = match_info
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_arena_statistics 12715  返回竞技场战斗次数
---------------------------------------------------------------------------------------------------------
function parse_arena_statistics( interpreter,datas,pos,strDatas,list,count )
	-- 数量
	local arena_battle_number = npos(list)
	if app.configJson.OperatorName == "cayenne" then
		local arena_battle = cc.UserDefault:getInstance():getStringForKey(getKey("arena_battle"))
		if tonumber(arena_battle) ~= 10 and tonumber(arena_battle) ~= 50 and tonumber(arena_battle) ~= 100 then
			if tonumber(arena_battle_number) == 10 then
				jttd.facebookAPPeventSlogger("11|".._ED.all_servers[_ED.selected_server].server_number.."_".._ED.user_info.user_id.."|10")
			end
			if tonumber(arena_battle_number) == 50 then
				jttd.facebookAPPeventSlogger("11|".._ED.all_servers[_ED.selected_server].server_number.."_".._ED.user_info.user_id.."|50")
			end
			if tonumber(arena_battle_number) == 100 then
				jttd.facebookAPPeventSlogger("11|".._ED.all_servers[_ED.selected_server].server_number.."_".._ED.user_info.user_id.."|100")
			end
		end
		cc.UserDefault:getInstance():setStringForKey(getKey("arena_battle"), arena_battle_number)
		cc.UserDefault:getInstance():flush()
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_arena_all_rank_info 总排行榜预览信息 14704
---------------------------------------------------------------------------------------------------------
function parse_return_arena_all_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.all_rank =  _ED.all_rank or {}

	_ED.all_rank.my_info = _ED.all_rank.my_info or {}

	local count = tonumber(npos(list))
    for i = 1 ,count do 
	    _ED.all_rank.my_info[i] = _ED.all_rank.my_info[i] or {}
	    _ED.all_rank.my_info[i].user_id = zstring.tonumber(npos(list))
	    _ED.all_rank.my_info[i].user_name = npos(list)
	    _ED.all_rank.my_info[i].user_camp = zstring.tonumber(npos(list))
	    _ED.all_rank.my_info[i].user_sex = zstring.tonumber(npos(list))
	    _ED.all_rank.my_info[i].user_head_id = zstring.tonumber(npos(list))
	    _ED.all_rank.my_info[i].user_level = zstring.tonumber(npos(list))
	    _ED.all_rank.my_info[i].user_fight = zstring.tonumber(npos(list))
	    _ED.all_rank.my_info[i].user_rank = zstring.tonumber(npos(list))
	    _ED.all_rank.my_info[i].user_arena_id = zstring.tonumber(npos(list))
	    _ED.all_rank.my_info[i].user_official = dms.int(dms["arena_reward_param"],_ED.all_rank.my_info[i].user_arena_id,arena_reward_param.arena_official)
    	local ship_moulds_str = npos(list)
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.all_rank.my_info[i].ship_moulds = ship_moulds_str
		else		
			ship_moulds_str = zstring.split(ship_moulds_str,",")
			local ship_moulds = {}
			-- print("===========",ship_moulds_str)
			for k,v in pairs(ship_moulds_str) do
				if zstring.tonumber(v) > 0 then
					table.insert(ship_moulds,v)
				end
			end
			_ED.all_rank.my_info[i].ship_moulds = ship_moulds
		end

        _ED.all_rank.my_info[i].user_union_name = npos(list)
        _ED.all_rank.my_info[i].user_union_id = zstring.tonumber(npos(list))
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.all_rank.my_info[i].win_streak_number = zstring.tonumber(npos(list))
		end	
    end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_mail_info 12800  返回邮件信息
---------------------------------------------------------------------------------------------------------
function parse_return_mail_info( interpreter,datas,pos,strDatas,list,count )
	local count = zstring.tonumber(npos(list))
	for i=1,count do
		local mail_id = zstring.tonumber(npos(list))
		local mail_channel_id = zstring.tonumber(npos(list))			--邮件类型2系统频道
		local mail_channel_type = zstring.tonumber(npos(list)) + 1
		local mail_channel_child_type = zstring.tonumber(npos(list))
		local mail_title = npos(list)
		local mail_dec = npos(list)
		local mail_item_type = npos(list)			--副件类型0空1奖励2url
		local mail_item = npos(list)
		local mail_date_time = npos(list)
		local mail_box_type = nil
		local mail_name = nil
		local mail_level = nil
		local mail_vip_level = nil
		local mail_vip_level = nil
		local mail_Read = nil
		if __lua_project_id == __lua_project_red_alert_time 
			or __lua_project_id == __lua_project_pacific_rim 
			or __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
			then
			mail_box_type = npos(list)  --1发，0收
			mail_name = npos(list)  --收件人或者发件人的名称
			mail_level = npos(list)  --收件人或者发件人的等级
			mail_vip_level = npos(list)  --收件人或者发件人的vip等级
			mail_Read = npos(list)  --邮件读取状态
		end

		local prop_data = {}
		mail_item = zstring.split(mail_item,"|")
		for k,v in pairs(mail_item) do
			local data_str = v
			if data_str ~= "" then
				local data = nil
				data_str = zstring.split(data_str,",")
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					data = {
						prop_type 	= tonumber(data_str[1]),	-- 物品1类型(1:银币 2:金币 3:声望 4:将魂 5:魂玉 6:道具 7:装备 8:武将) 
						prop_item 	= tonumber(data_str[2]),	-- 物品1模板ID(没有则为-1)
						item_value 	= tonumber(data_str[3]),		-- 物品1数量
						ship_star = zstring.tonumber(data_str[4]), 	-- 数码兽星级
					}
				else
					data = {
						prop_item 	= tonumber(data_str[1]),	-- 物品1模板ID(没有则为-1)
						prop_type 	= tonumber(data_str[2]),	-- 物品1类型(1:银币 2:金币 3:声望 4:将魂 5:魂玉 6:道具 7:装备 8:武将) 
						item_value 	= tonumber(data_str[3])		-- 物品1数量
					}
				end
				table.insert(prop_data,data)
			end
		end

		_ED.mail_system[""..mail_id] = _ED.mail_system[""..mail_id]  or {}
		_ED.mail_system[""..mail_id].mail_id = mail_id
		_ED.mail_system[""..mail_id].mail_channel_id = mail_channel_id
		_ED.mail_system[""..mail_id].mail_channel_type = mail_channel_type
		_ED.mail_system[""..mail_id].mail_channel_child_type = mail_channel_child_type
		_ED.mail_system[""..mail_id].mail_type = mail_type
		_ED.mail_system[""..mail_id].mail_title = mail_title
		_ED.mail_system[""..mail_id].mail_dec = mail_dec
		_ED.mail_system[""..mail_id].mail_item_type = mail_item_type
		_ED.mail_system[""..mail_id].mail_items = prop_data
		_ED.mail_system[""..mail_id].mail_date_time = mail_date_time
		--数据结构合并到_ED._reward_centre中
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			local reward_view = {}
			reward_view._reward_centre_id = mail_id
			reward_view._reward_type = mail_channel_child_type
			reward_view._reward_time = math.floor(zstring.tonumber(mail_date_time)/1000)
			reward_view._reward_describe = mail_dec
			reward_view._reward_item_count = #prop_data
			reward_view._reward_list = prop_data
			reward_view.read_type = 0 -- 0 未读， 1 已读
	    	reward_view.draw_state = 0 -- 0 未领奖，1已领奖

	    	if tonumber(mail_Read) == 0 then
	    		reward_view.read_type = 0
	    		reward_view.draw_state = 0
    		elseif tonumber(mail_Read) == 1 then
    			if reward_view._reward_item_count == 0 then
    				reward_view.read_type = 1
    			else
    				reward_view.read_type = 0
    			end
    			reward_view.draw_state = 0
    		else
    			reward_view.read_type = 1
    			reward_view.draw_state = 1
    		end

	    	local data = {}
		    if tonumber(reward_view._reward_type) == 30 then 
				data = dms.element(dms["mail_content_info"] , 3)
			elseif tonumber(reward_view._reward_type) == 2 then--维护补偿
				data = dms.element(dms["mail_content_info"] , 2)
			elseif tonumber(reward_view._reward_type) == 14 then--公会副本伤害排行奖励
				data = dms.element(dms["mail_content_info"] , 4)
			elseif tonumber(reward_view._reward_type) == 17 then --新手奖励
				data = dms.element(dms["mail_content_info"] , 1)
			elseif tonumber(reward_view._reward_type) >= 18 
				and tonumber(reward_view._reward_type) <= 29 
				then
				data = dms.element(dms["mail_content_info"] , tonumber(reward_view._reward_type) - 13)
			elseif tonumber(reward_view._reward_type) >= 31 
				and tonumber(reward_view._reward_type) <= 38 
				then
				data = dms.element(dms["mail_content_info"] , tonumber(reward_view._reward_type) - 14)
			elseif tonumber(reward_view._reward_type) == 39 then
				data = dms.element(dms["mail_content_info"] , 25)
			elseif tonumber(reward_view._reward_type) == 40 then
				data = dms.element(dms["mail_content_info"] , 26)
			elseif tonumber(reward_view._reward_type) == 41 then
				data = dms.element(dms["mail_content_info"] , 27)
			elseif tonumber(reward_view._reward_type) == 42 then
				data = dms.element(dms["mail_content_info"] , 28)
			elseif tonumber(reward_view._reward_type) == 43 then
				data = dms.element(dms["mail_content_info"] , 29)
			elseif tonumber(reward_view._reward_type) == 44 then
				data = dms.element(dms["mail_content_info"] , 30)
			else
				data = dms.element(dms["mail_content_info"] , 2)
			end
			reward_view.title = dms.atos(data , mail_content_info.title) -- 标题
			reward_view.form = dms.atos(data , mail_content_info.form)	--发件人
			reward_view.text_info = dms.atos(data , mail_content_info.descript) --描述
			reward_view.head = dms.atoi(data , mail_content_info.head) -- 头像
			reward_view.data_type = 2 -- 1 表示210协议结构 ，2表示12800协议结构 ,与id 一起组成主键
			reward_view.mail_item_type = mail_item_type
			local dec_info = zstring.split(reward_view._reward_describe , ",")
			if dec_info[1] ~= nil and dec_info[1] ~= "" then
				if tonumber(reward_view._reward_type) == 14
					or tonumber(reward_view._reward_type) == 28 
					then
					local npcName = dms.string(dms["npc"], dec_info[1], npc.npc_name)
					local name = dms.string(dms["word_mould"], npcName, word_mould.text_info)
					reward_view.text_info = string.gsub(reward_view.text_info, "!x@", name)
				elseif tonumber(reward_view._reward_type) == 40
					or tonumber(reward_view._reward_type) == 41 then
					local name = _title_param_mail[tonumber(dec_info[1])]
					reward_view.text_info = string.gsub(reward_view.text_info, "!x@", name)
				else
					reward_view.text_info = string.gsub(reward_view.text_info, "!x@", dec_info[1])
				end
			end
			if dec_info[2] ~= nil and dec_info[2] ~= "" then
				if tonumber(reward_view._reward_type) == 40 or tonumber(reward_view._reward_type) == 41 then
					local name = _title_param_mail[tonumber(dec_info[2])+4]
					reward_view.text_info = string.gsub(reward_view.text_info, "!y@", name)
				else
					reward_view.text_info = string.gsub(reward_view.text_info, "!y@", dec_info[2])
				end
			end
			if dec_info[3] ~= nil and dec_info[3] ~= "" then
				reward_view.text_info = string.gsub(reward_view.text_info, "!z@", dec_info[3])
			end

			if tonumber(reward_view._reward_type) == 29 then
				reward_view.form = mail_name
			elseif tonumber(reward_view._reward_type) == 2 then
				reward_view.text_info = mail_dec
				reward_view.title = mail_title
				reward_view.form = mail_name
			end
			reward_view.text_info = zstring.exchangeFrom(reward_view.text_info)
			--如果本地存在此邮件标记已读
			-- local max_config = tonumber(zstring.split(dms.string(dms["mail_config"] , 1 , mail_config.param),",")[2])
			-- for i = 1 , max_config do 
			-- 	local emailLocal = cc.UserDefault:getInstance():getStringForKey(getKey("sm_email_"..i))
			-- 	if emailLocal == "" then
			-- 		break
			-- 	else
			-- 		local email_info = zstring.split(emailLocal , "|")
			-- 		if tonumber(reward_view._reward_centre_id) == tonumber(email_info[1])
			-- 			and tonumber(reward_view.data_type) == tonumber(email_info[2])
			-- 			then
			-- 			reward_view.read_type = 1
			-- 		end
			-- 	end
			-- end
			-- 检查该奖励ID 是否存在,在就跳过
		    local _isHas = false   -- 判定对象是否存在
		    local _index = 1
		    for _index, _item in pairs(_ED._reward_centre) do
		        if tonumber(_item._reward_centre_id) == tonumber(reward_view._reward_centre_id) 
		        	and tonumber(_item.data_type) == tonumber(reward_view.data_type)
		        	then
		            _isHas = true
		            break
		        end
		    end
		    if not _isHas then
		        local sgnindex = 0
		        for sgn, v in pairs(_ED._reward_centre) do
		            if sgn > sgnindex then
		                sgnindex = sgn
		            end
		        end
		        sgnindex = sgnindex + 1
		        _ED._reward_centre[sgnindex] = nil
		        _ED._reward_centre[sgnindex] = reward_view
		    end
		elseif __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			_ED.mail_system[""..mail_id].mail_box_type = mail_box_type
			_ED.mail_system[""..mail_id].mail_name = mail_name
			_ED.mail_system[""..mail_id].mail_level = mail_level
			_ED.mail_system[""..mail_id].mail_vip_level = mail_vip_level
			_ED.mail_system[""..mail_id].mail_Read = mail_Read

			if _ED._email_is_open == false then
				local count = 0
				if tonumber(_ED.mail_system[""..mail_id].mail_box_type) == 0 then
					if tonumber(_ED.mail_system[""..mail_id].mail_item_type) == 1 then
						if #_ED.mail_system[""..mail_id].mail_items > 0 then
							if tonumber(_ED.mail_system[""..mail_id].mail_Read) < 2 then
								count = count + 1
							end
						else
							if tonumber(_ED.mail_system[""..mail_id].mail_Read) == 0 then
								count = count + 1
							end
						end
					else
						if tonumber(_ED.mail_system[""..mail_id].mail_Read) < 1 then
							count = count + 1
						end		
					end
				end	
				if _ED.mould_function_push_info["8"] ~= nil then
					_ED.mould_function_push_info["8"].params = tonumber(_ED.mould_function_push_info["8"].params) + count
				else
					local push_info = {}
					push_info.nType = 8
					push_info.state = 0
					push_info.params = ""..count
					_ED.mould_function_push_info["8"] = push_info
				end
			end
		end
	end
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		if _ED._email_is_open == true then
			local count = 0
			for i,v in pairs(_ED.mail_system) do
				if tonumber(v.mail_box_type) == 0 then
					if tonumber(v.mail_item_type) == 1 then
						if #v.mail_items > 0 then
							if tonumber(v.mail_Read) < 2 then
								count = count + 1
							end
						else
							if tonumber(v.mail_Read) == 0 then
								count = count + 1
							end
						end
					else
						if tonumber(v.mail_Read) < 1 then
							count = count + 1
						end	
					end
					-- elseif tonumber(v.mail_box_type) == 0 then
					-- 	if tonumber(v.mail_Read) < 1 then
					-- 		count = count + 1
					-- 	end
				end
			end
			if _ED.mould_function_push_info["8"] ~= nil then
				_ED.mould_function_push_info["8"].params = ""..count
			else
				local push_info = {}
				push_info.nType = 8
				push_info.state = 0
				push_info.params = ""..count
				_ED.mould_function_push_info["8"] = push_info
			end
		end
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			state_machine.excute("notification_center_update", 0, "push_notification_mine_push")
			state_machine.excute("notification_center_update", 0, "push_notification_mine_in_box_push")
			state_machine.excute("notification_center_update", 0, "push_notification_mine_report_push")
			state_machine.excute("notification_center_update", 0, "push_notification_mine_report_attack")
			state_machine.excute("notification_center_update", 0, "push_notification_mine_report_defense")
			state_machine.excute("notification_center_update", 0, "push_notification_mine_report_scout")
			state_machine.excute("notification_center_update", 0, "push_notification_campaign_cell")
			state_machine.excute("notification_center_update", 0, "push_notification_all_daily_campaign")
			state_machine.excute("notification_center_update", 0, "push_notification_all_linited_campaign")
			state_machine.excute("notification_center_update", 0, "push_notification_all_inter_service_campaign")
			state_machine.excute("notification_center_update", 0, "push_notification_campaign_expedition")

			state_machine.excute("mail_update_mail_count_info", 0, "")
		end
	end
	if fwin:find("MailInBoxClass")~= nil then
		state_machine.excute("mail_in_box_update_draw", 0, 0)
	end
	if fwin:find("MailOutBoxClass")~= nil then
		state_machine.excute("mail_out_box_update_draw", 0, 0)
	end
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
    	state_machine.excute("notification_center_update", 0, "push_notification_center_mall_all")
    end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_mail_delete 12801  返回邮件删除
---------------------------------------------------------------------------------------------------------
function parse_return_mail_delete( interpreter,datas,pos,strDatas,list,count )
	local mail_id = zstring.tonumber(npos(list))		--邮件id
	local mail_item_type = zstring.tonumber(npos(list))	--附件类型
	local mail_box_type = zstring.tonumber(npos(list))	--收发类型
	local mail_Read = zstring.tonumber(npos(list))		--阅读状态
	_ED.mail_system[""..mail_id] = nil

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		if mail_box_type == 0 then
			if (mail_item_type == 1 and mail_Read < 2) or (mail_item_type == 0 and  mail_Read < 1) then		
				if _ED.mould_function_push_info["8"] ~= nil then
					_ED.mould_function_push_info["8"].params = tonumber(_ED.mould_function_push_info["8"].params) - 1
				end
			end
		end
		state_machine.excute("notification_center_update", 0, "push_notification_mine_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_in_box_push")

		state_machine.excute("mail_update_mail_count_info", 0, "")
	elseif __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon 
		or __lua_project_id == __lua_project_l_naruto 
		then
		for k,v in pairs(_ED._reward_centre) do
			if tonumber(v._reward_centre_id) == mail_id then
				table.remove(_ED._reward_centre, k, 1)
				break
			end
		end
    	state_machine.excute("notification_center_update", 0, "push_notification_center_mall_all")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_mail_have_new 12802  返回有新邮件了
---------------------------------------------------------------------------------------------------------
function parse_return_mail_have_new( interpreter,datas,pos,strDatas,list,count )
	local count = zstring.tonumber(npos(list))
	if count > 0 then
		_ED.mail_system_have_new = true
	else
		_ED.mail_system_have_new = false
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_user_tacks_info 12900  成就
---------------------------------------------------------------------------------------------------------
function parse_return_user_tacks_info( interpreter,datas,pos,strDatas,list,count )
	local user_type = npos(list)
	local user_type_temp = user_type
	-- print("========11===",user_type_temp)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
	else
		if tonumber(user_type) == 3 then
			user_type = "1"
		end
	end
	
	_ED.user_task_infos = _ED.user_task_infos or {}
	_ED.user_task_infos[user_type] = _ED.user_task_infos[user_type] or {}
	local count = zstring.tonumber(npos(list))
	for i = 1, count do
		local task_id = npos(list)
		local task_mould_id = npos(list)
		local task_complete_count = npos(list)
		_ED.user_task_infos[user_type][task_id] = _ED.user_task_infos[user_type][task_id] or {}
		_ED.user_task_infos[user_type][task_id].task_id = task_id
		_ED.user_task_infos[user_type][task_id].task_mould_id = task_mould_id
		_ED.user_task_infos[user_type][task_id].task_complete_count = task_complete_count
		local task_data = dms.element(dms["task_mould"],task_mould_id)
		_ED.user_task_infos[user_type][task_id].task_pic = dms.atoi(task_data,task_mould.task_pic)
		_ED.user_task_infos[user_type][task_id].achieve_mould_id = dms.atoi(task_data,task_mould.achieve_mould_id)

		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			local task_state = npos(list)
			_ED.user_task_infos[user_type][task_id].task_state = task_state
			_ED.user_task_infos[user_type][task_id].little_type = dms.atoi(task_data,task_mould.little_type)
			_ED.user_task_infos[user_type][task_id].sort_index = dms.atoi(task_data,task_mould.sort_index)
			local task_time = dms.int(dms["task_config"], 3, task_config.param)
			_ED.user_task_infos[user_type][task_id].task_end_time = tonumber(npos(list))/1000 + task_time
			_ED.user_task_infos[user_type][task_id].show_urgent = true
		end

		local achieve_data = dms.element(dms["achievement_mould"],_ED.user_task_infos[user_type][task_id].achieve_mould_id)
		local achievement_finish_need_info = dms.atos(achieve_data,achievement_mould.achievement_finish_need_info)
	    achievement_finish_need_info = zstring.split(achievement_finish_need_info,",")
	    local need_complete_count = 0
	    if #achievement_finish_need_info == 1 then
	        need_complete_count = tonumber(achievement_finish_need_info[1])
	    elseif #achievement_finish_need_info == 2 then
	        need_complete_count = tonumber(achievement_finish_need_info[2])
	    elseif #achievement_finish_need_info == 3 then
	        need_complete_count = tonumber(achievement_finish_need_info[3])
	    end

	    _ED.user_task_infos[user_type][task_id].achievement_finish_type = dms.atoi(achieve_data,achievement_mould.achievement_finish_type) 
	    _ED.user_task_infos[user_type][task_id].need_complete_count = need_complete_count

	    if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
	    else
		    if tonumber(user_type_temp) == 3 then
		    	if tonumber(task_complete_count) == 0 then
		    		_ED.user_task_infos[user_type][task_id] = nil
		    	end
		    end
		end
	end
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
    	if tonumber(user_type) == 0 or tonumber(user_type) == 5 then
    		_ED.user_frist_task = getFristTaskInfo()
    		state_machine.excute("main_window_update_task_info", 0, "")
    	end
    	state_machine.excute("notification_center_update", 0, "push_notification_home_button_task")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_main")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_daily")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_fight")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_legion")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_grow")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_privilege")
    	if tonumber(user_type) == 3 then
    		if fwin:find("WonderfulClass") ~= nil and fwin:find("RedAlertTimeReceiveEnergyClass") ~= nil then
	    		state_machine.excute("red_alert_time_receive_rnergy_update", 0, "")
	    	end
	    	state_machine.excute("red_alert_time_wonderful_update_push", 0, 59)
    	end
	else
		if tonumber(user_type) == 0 then
			state_machine.excute("home_button_for_action_update_task_info", 0, nil)
		elseif tonumber(user_type) == 6 then
			state_machine.excute("hero_main_god_hero_update_task", 0, nil)
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_change_user_tacks_info 12901  任务改变
---------------------------------------------------------------------------------------------------------
function parse_return_change_user_tacks_info( interpreter,datas,pos,strDatas,list,count )
	local task_id = npos(list)
	local task_mould_id = npos(list)
	local task_complete_count = npos(list)
	local task_data = dms.element(dms["task_mould"],task_mould_id)
	local user_type = dms.atos(task_data,task_mould.task_type)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
	else
		if tonumber(user_type) == 3 then
			user_type = "1"
		end
	end
	_ED.user_task_infos = _ED.user_task_infos or {}
	_ED.user_task_infos[user_type] = _ED.user_task_infos[user_type] or {}
	_ED.user_task_infos[user_type][task_id] = _ED.user_task_infos[user_type][task_id] or {}
	_ED.user_task_infos[user_type][task_id].task_id = task_id
	_ED.user_task_infos[user_type][task_id].task_mould_id = task_mould_id
	_ED.user_task_infos[user_type][task_id].task_complete_count = task_complete_count
	_ED.user_task_infos[user_type][task_id].task_pic = dms.atoi(task_data,task_mould.task_pic)
	_ED.user_task_infos[user_type][task_id].achieve_mould_id = dms.atoi(task_data,task_mould.achieve_mould_id)

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		local task_state = npos(list)
		_ED.user_task_infos[user_type][task_id].task_state = task_state
		_ED.user_task_infos[user_type][task_id].little_type = dms.atoi(task_data,task_mould.little_type)
		_ED.user_task_infos[user_type][task_id].sort_index = dms.atoi(task_data,task_mould.sort_index)
		local task_time = dms.int(dms["task_config"], 3, task_config.param)
		_ED.user_task_infos[user_type][task_id].task_end_time = tonumber(npos(list))/1000 + task_time
		_ED.user_task_infos[user_type][task_id].show_urgent = _ED.user_task_infos[user_type][task_id].show_urgent
	end

	local achieve_data = dms.element(dms["achievement_mould"],_ED.user_task_infos[user_type][task_id].achieve_mould_id)
	_ED.user_task_infos[user_type][task_id].achievement_finish_type = dms.atoi(achieve_data,achievement_mould.achievement_finish_type) 
	local achievement_finish_need_info = dms.atos(achieve_data,achievement_mould.achievement_finish_need_info)
    achievement_finish_need_info = zstring.split(achievement_finish_need_info,",")
    local need_complete_count = 0
    if #achievement_finish_need_info == 1 then
        need_complete_count = tonumber(achievement_finish_need_info[1])
    elseif #achievement_finish_need_info == 2 then
        need_complete_count = tonumber(achievement_finish_need_info[2])
    elseif #achievement_finish_need_info == 3 then
        need_complete_count = tonumber(achievement_finish_need_info[3])
    end
    _ED.user_task_infos[user_type][task_id].need_complete_count = need_complete_count

    if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
    	if tonumber(user_type) == 0 or tonumber(user_type) == 5 then
    		_ED.user_frist_task = getFristTaskInfo()
    		state_machine.excute("main_window_update_task_info", 0, "")
    		if tonumber(user_type) == 5 and _ED.user_task_infos[user_type][task_id].show_urgent ~= true then
    			_ED.user_task_infos[user_type][task_id].show_urgent = true
    			state_machine.excute("task_urgent_open", 0, {_ED.user_task_infos[user_type][task_id]})
    		end
    	elseif tonumber(user_type) == 3 then
    		if fwin:find("WonderfulClass") ~= nil and fwin:find("RedAlertTimeReceiveEnergyClass") ~= nil then
	    		state_machine.excute("red_alert_time_receive_rnergy_update", 0, "")
	    	end
	    	state_machine.excute("red_alert_time_wonderful_update_push", 0, 59)
    	end
    	getRedAlertTimeTaskTip()
    	state_machine.excute("task_main_update_task_state", 0, nil)
    	state_machine.excute("notification_center_update", 0, "push_notification_home_button_task")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_main")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_daily")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_fight")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_legion")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_grow")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_privilege")
    else
		if tonumber(user_type) == 0 then
			state_machine.excute("home_button_for_action_update_task_info", 0, nil)
		elseif tonumber(user_type) == 6 then
			state_machine.excute("hero_main_god_hero_update_task", 0, nil)
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_remove_user_tacks_info 12902 移除
---------------------------------------------------------------------------------------------------------
function parse_return_remove_user_tacks_info( interpreter,datas,pos,strDatas,list,count )
	local task_mould_id = npos(list)
	local task_id = npos(list)
	local task_data = dms.element(dms["task_mould"],task_mould_id)
	local user_type = dms.atos(task_data,task_mould.task_type)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
	else
		if tonumber(user_type) == 3 then
			user_type = "1"
		end
	end

	_ED.user_task_infos[user_type][task_id] = nil

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
    	if tonumber(user_type) == 0 or tonumber(user_type) == 5 then
    		_ED.user_frist_task = getFristTaskInfo()
    		state_machine.excute("main_window_update_task_info", 0, "")
    		if tonumber(user_type) == 5 then
    			state_machine.excute("task_urgent_close", 0, "")
    		end
    	end
    	getRedAlertTimeTaskTip()
    	state_machine.excute("task_main_update_task_state", 0, nil)
    	state_machine.excute("notification_center_update", 0, "push_notification_home_button_task")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_main")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_daily")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_fight")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_legion")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_grow")
    	state_machine.excute("notification_center_update", 0, "push_notification_task_button_privilege")
	else
		if tonumber(user_type) == 0 then
			state_machine.excute("home_button_for_action_update_task_info", 0, nil)
		elseif tonumber(user_type) == 6 then
			state_machine.excute("hero_main_god_hero_update_task", 0, nil)
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_activity_info 13000活动信息
---------------------------------------------------------------------------------------------------------
function parse_return_activity_info( interpreter,datas,pos,strDatas,list,count )
	local activity_id = npos(list)
	local activity_title = npos(list)
	local activity_dec = npos(list)
	local activity_pic = nil 
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		activity_pic = npos(list)
	end
	local activity_type = npos(list)
	local activity_state = npos(list)
	local activity_add_state = npos(list)
	local group_count = zstring.tonumber(npos(list))
	_ED.activity_info = _ED.activity_info or {}
	_ED.activity_info[activity_type] = _ED.activity_info[activity_type] or {}
	_ED.activity_info[activity_type].activity_type = activity_type
	_ED.activity_info[activity_type].activity_id = activity_id
	_ED.activity_info[activity_type].activity_title = activity_title
	_ED.activity_info[activity_type].activity_dec = activity_dec
	_ED.activity_info[activity_type].activity_type = activity_type
	_ED.activity_info[activity_type].activity_state = activity_state
	_ED.activity_info[activity_type].activity_add_state = activity_add_state
	_ED.activity_info[activity_type].start_time = os.time()
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		_ED.activity_info[activity_type].activity_pic = activity_pic
	end
	_ED.activity_info[activity_type].activity_data = _ED.activity_info[activity_type].activity_data or {}
	for i = 1,group_count do
		_ED.activity_info[activity_type].activity_data[i] = _ED.activity_info[activity_type].activity_data[i] or {}
		local group_one_count = zstring.tonumber(npos(list))
		for j=1,group_one_count do
			local achieve_mould_name = npos(list)
			local achieve_mould_dec = npos(list)
			local achieve_complete_count = npos(list)
			local achieve_state = npos(list)
			local achieve_reward = npos(list)
			local achieve_other_info = npos(list)
			_ED.activity_info[activity_type].activity_data[i][j] = _ED.activity_info[activity_type].activity_data[i][j] or {}
			_ED.activity_info[activity_type].activity_data[i][j].achieve_index = j
			_ED.activity_info[activity_type].activity_data[i][j].achieve_mould_name = achieve_mould_name
			_ED.activity_info[activity_type].activity_data[i][j].achieve_mould_dec = achieve_mould_dec
			_ED.activity_info[activity_type].activity_data[i][j].achieve_complete_count = achieve_complete_count
			_ED.activity_info[activity_type].activity_data[i][j].achieve_state = achieve_state -- 0进行中 1 完成 2领取
			_ED.activity_info[activity_type].activity_data[i][j].achieve_reward = achieve_reward
			_ED.activity_info[activity_type].activity_data[i][j].achieve_other_info = achieve_other_info
			-- debug.print_r(_ED.activity_info[activity_type])
		end
	end

	if tonumber(activity_type) == 68 then -- 刷新配件进化活动加层
		state_machine.excute("equipment_strengthen_tab_update_activity_add_draw",0,"")
		state_machine.excute("equipment_reform_tab_update_activity_add_draw",0,"")
	end
	if tonumber(activity_type) == 85 then--刷新科技升级状态
        state_machine.excute("build_up_scientific_to_update_draw",0,"")
        state_machine.excute("build_up_scientific_info_update_draw",0,"")
    end
    if tonumber(activity_type) == 91 then--刷新攻击或重置次数
        state_machine.excute("expedition_update_draw",0,"") --远征
        state_machine.excute("pve_parts_supply_tab_activity_end_updata",0,"")--配件
        state_machine.excute("arena_dearon_tab_update", 0, "") --竞技场
    end
	state_machine.excute("home_button_activity_update_button_state", 0, nil)
	if fwin:find("WonderfulClass") ~= nil then
		state_machine.excute("red_alert_time_wonderful_update_new_activity", 0, nil)	
		state_machine.excute("red_alert_time_wonderful_update_push", 0, activity_type)
		state_machine.excute("red_alert_time_online_reward_activity_codes", 0, nil)
	end
	if fwin:find("RedAlertTimeCenterClass") ~= nil then
		state_machine.excute("red_alert_time_center_new_activity", 0, nil)	
		state_machine.excute("red_alert_time_center_update_push", 0, activity_type)
	end

	-- 活动结束刷新
	state_machine.excute("red_alert_time_rank_activity_update_draw", 0, "")--充值排行刷新
    state_machine.excute("red_alert_time_leader_recruit_activity_update_draw", 0, "")--英雄招募刷新
    state_machine.excute("red_alert_time_achievements_reached_update_draw", 0, "")
    state_machine.excute("red_alert_time_legion_series_update_draw", 0, "")

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		if fwin:find("MainWindowClass") ~= nil then
			state_machine.excute("main_window_push_activity",0,0)
			state_machine.excute("main_window_push_treasure",0,0)
			state_machine.excute("main_window_update_top_button", 0, nil)
		end
    	-- state_machine.excute("notification_center_update", 0, "push_notification_mine_activity_push")
    	-- state_machine.excute("notification_center_update", 0, "push_notification_mine_treasure_push")
    	state_machine.excute("notification_center_update", 0, "push_notification_mine_lottery_push")
    	state_machine.excute("notification_center_update", 0, "push_notification_mine_ordinary_lottery_push")
    	state_machine.excute("notification_center_update", 0, "push_notification_mine_advanced_lottery_push")
	    if tonumber(activity_type) == 100 then --七日狂欢
	    	state_machine.excute("red_alert_time_seven_day_activity_update_draw",0,{0, 0})
	        state_machine.excute("notification_center_update", 0, "push_notification_seven_day_activity_type")
	    	state_machine.excute("notification_center_update", 0, "push_notification_seven_day_activity")
	    end

	    if tonumber(activity_type) == 130 then 	-- 狂欢时刻
			state_machine.excute("red_alert_time_carnival_hour_update_draw", 0, "")
		end
		if tonumber(activity_type) == 131 then --特权福利
	    	state_machine.excute("red_alert_time_vip_gift_update_draw", 0, "")
		    state_machine.excute("notification_center_update", 0, "push_notification_vip_privilege_gift")
		    state_machine.excute("notification_center_update", 0, "push_notification_privilege_packs")
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_activity_push_new_activity 13001活动推送状态
---------------------------------------------------------------------------------------------------------
function parse_return_activity_push_new_activity( interpreter,datas,pos,strDatas,list,count )
	local count = npos(list)
	_ED.activity_have_new = true
end

---------------------------------------------------------------------------------------------------------
-- parse_return_activity_info_change 13002活动推送状态
---------------------------------------------------------------------------------------------------------
function parse_return_activity_info_change( interpreter,datas,pos,strDatas,list,count )
	local activity_id = npos(list)
	local activity_type = npos(list)
	local activity_state = npos(list)
	local activity_add_state = npos(list)
	local group_group_index = tonumber(npos(list)) + 1
	local group_one_index = tonumber(npos(list)) + 1
	local achieve_complete_count = npos(list)
	local achieve_state = npos(list)
	local achieve_other_info = npos(list)
	if _ED.activity_info == nil or _ED.activity_info[activity_type] == nil then
		return
	end
	_ED.activity_info[activity_type].activity_add_state = activity_add_state
	_ED.activity_info[activity_type].activity_state = activity_state
	_ED.activity_info[activity_type].start_time = os.time()
	if _ED.activity_info[activity_type].activity_data[group_group_index] ~= nil 
		and _ED.activity_info[activity_type].activity_data[group_group_index][group_one_index] ~= nil
		then
		_ED.activity_info[activity_type].activity_data[group_group_index][group_one_index].achieve_state = achieve_state
		_ED.activity_info[activity_type].activity_data[group_group_index][group_one_index].achieve_other_info = achieve_other_info
		_ED.activity_info[activity_type].activity_data[group_group_index][group_one_index].achieve_complete_count = achieve_complete_count
	end
	state_machine.excute("special_gift_update",0,"")
	state_machine.excute("special_gift_high_update",0,"")
	state_machine.excute("luxury_sign_set_positiony",0,"")
	state_machine.excute("nowday_topup_reward_set_positiony",0,"")
    state_machine.excute("one_recharge_set_positiony",0,"")
    state_machine.excute("one_recharge_two_set_positiony",0,"")
    state_machine.excute("red_alert_time_base_level_activity_codes",0,"")--添加基地冲级刷新
    state_machine.excute("main_window_update_top_button", 0, nil)
    state_machine.excute("red_alert_time_online_reward_activity_codes", 0, nil)
    state_machine.excute("red_alert_time_gift_packs_update_draw", 0, nil)
    state_machine.excute("red_alert_time_leveling_vip_update_draw", 0, "")--军备竞赛刷新
    state_machine.excute("red_alert_time_recharge_red_bag_activity_update", 0, "")--将领进阶刷新
    state_machine.excute("red_alert_time_troops_assembled_activity_codes", 0, "")--将领进化刷新
    state_machine.excute("red_alert_time_three_day_recharge_updata", 0, "")--将领进化刷新
    state_machine.excute("red_alert_time_first_recharge_updata", 0, "")--首次充值活动刷新
    state_machine.excute("red_alert_time_consume_back_goods_updata", 0, "")--消费返利活动刷新
    state_machine.excute("red_alert_time_military_exploit_transfer_updata", 0, "")--摧枯拉朽活动刷新
    state_machine.excute("red_alert_time_winding_up_plan_updata", 0, "")--清盘计划活动刷新
    state_machine.excute("red_alert_time_leader_senior_updata_isFree", 0, "")--火线将领活动刷新
    state_machine.excute("red_alert_time_military_pulpit_transfer_updata", 0, "")--军事讲坛活动刷新
    state_machine.excute("first_charge_update_draw",0,"") -- 首充刷新
    state_machine.excute("red_alert_time_leader_senior_legend_update_draw", 0, "")--传奇名将活动刷新
    state_machine.excute("red_alert_time_spring_package_updata", 0, "")--春天好礼动刷新
    state_machine.excute("red_alert_time_recharge_send_leader_update_draw", 0, "")--充值送将领刷新
    state_machine.excute("red_alert_time_rank_activity_update_draw", 0, "")--充值排行刷新
    state_machine.excute("red_alert_time_leader_recruit_activity_update_draw", 0, "")--英雄招募刷新
    state_machine.excute("red_alert_time_discount_store_reward_update_gold_info", 0, "")
    
    if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
    	-- state_machine.excute("notification_center_update", 0, "push_notification_mine_activity_push")
    	-- state_machine.excute("notification_center_update", 0, "push_notification_mine_treasure_push")
    	state_machine.excute("notification_center_update", 0, "push_notification_mine_lottery_push")
    	state_machine.excute("notification_center_update", 0, "push_notification_mine_ordinary_lottery_push")
    	state_machine.excute("notification_center_update", 0, "push_notification_mine_advanced_lottery_push")
    	if fwin:find("WonderfulClass") ~= nil then
			state_machine.excute("red_alert_time_wonderful_update_push", 0, activity_type)
		end
		if fwin:find("RedAlertTimeCenterClass") ~= nil then
			state_machine.excute("red_alert_time_center_update_push", 0, activity_type)
		end
		if fwin:find("MainWindowClass") ~= nil then
			state_machine.excute("main_window_push_activity",0,0)
			state_machine.excute("main_window_push_treasure",0,0)
		end
		if tonumber(activity_type) == 100 then --七日狂欢
			state_machine.excute("red_alert_time_seven_day_activity_update_draw",0,{group_group_index, group_one_index})
	        state_machine.excute("notification_center_update", 0, "push_notification_seven_day_activity_type")
	    	state_machine.excute("notification_center_update", 0, "push_notification_seven_day_activity")
	    end
	    if tonumber(activity_type) == 118 then --慷慨红包
	    	state_machine.excute("red_alert_time_largesse_give_hot_buy_update", 0, "")
		    state_machine.excute("notification_center_update", 0, "push_notification_largesse_get_reward")
		end
		if tonumber(activity_type) == 127 then --火力全开
	    	state_machine.excute("red_alert_time_full_vitality_transfer_updata", 0, "")--火力全开活动刷新
		    state_machine.excute("notification_center_update", 0, "push_notification_treasurehouse_full_vitality_get_reward")
		end
		if tonumber(activity_type) == 130 then --狂欢时刻
	    	state_machine.excute("red_alert_time_carnival_hour_recharge_update_draw", 0, "")
		    state_machine.excute("notification_center_update", 0, "push_notification_canival_hour")
		end
		if tonumber(activity_type) == 131 then --特权福利
	    	state_machine.excute("red_alert_time_vip_gift_update_draw", 0, "")
		    state_machine.excute("notification_center_update", 0, "push_notification_vip_privilege_gift")
		    state_machine.excute("notification_center_update", 0, "push_notification_privilege_packs")
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_activity_rotary_info 13003转盘奖励
---------------------------------------------------------------------------------------------------------
function parse_return_activity_rotary_info( interpreter,datas,pos,strDatas,list,count )
	_ED.activity_rotary_index = npos(list)
	-- print("==========",_ED.activity_rotary_index)
end

---------------------------------------------------------------------------------------------------------
-- parse_return__server_rank_info 13004 开服top
---------------------------------------------------------------------------------------------------------
function parse_return_server_rank_info( interpreter,datas,pos,strDatas,list,count )
	_ED.server_rank_info_three = _ED.server_rank_info_three or {}
	_ED.server_rank_info_seven = _ED.server_rank_info_seven or {}
	_ED.server_rank_info_fourteen = _ED.server_rank_info_fourteen or {}
	_ED.server_rank_info_level = npos(list)
	_ED.server_rank_info_power = npos(list)
	_ED.server_rank_info_checkpoint = npos(list)
	_ED.server_rank_info_stars = npos(list)

	
	local count = npos(list)
	for i=1,tonumber(count) do
		_ED.server_rank_info_three[i] =  _ED.server_rank_info_three[i] or {}
		local temp_count = zstring.tonumber(npos(list))
		for j=1 , zstring.tonumber(temp_count) do
			_ED.server_rank_info_three[i][j] = _ED.server_rank_info_three[i][j] or {}
			_ED.server_rank_info_three[i][j].name = npos(list)
			_ED.server_rank_info_three[i][j].power = npos(list)
			_ED.server_rank_info_three[i][j].rank = j
		end
	end

	for i=1,tonumber(count) do
		_ED.server_rank_info_seven[i] =  _ED.server_rank_info_seven[i] or {}
		local temp_count = tonumber(npos(list))
		for j=1 , zstring.tonumber(temp_count) do
			_ED.server_rank_info_seven[i][j] = _ED.server_rank_info_seven[i][j] or {}
			_ED.server_rank_info_seven[i][j].name = npos(list)
			_ED.server_rank_info_seven[i][j].power = npos(list)
			_ED.server_rank_info_seven[i][j].rank = j
		end
	end

	for i=1,tonumber(count) do
		_ED.server_rank_info_fourteen[i] =  _ED.server_rank_info_fourteen[i] or {}
		local temp_count = tonumber(npos(list))
		for j=1 , zstring.tonumber(temp_count) do
			_ED.server_rank_info_fourteen[i][j] = _ED.server_rank_info_fourteen[i][j] or {}
			_ED.server_rank_info_fourteen[i][j].name = npos(list)
			_ED.server_rank_info_fourteen[i][j].power = npos(list)
			_ED.server_rank_info_fourteen[i][j].rank = j
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_activity_over_info 13005 活动状态
---------------------------------------------------------------------------------------------------------
function parse_return_activity_over_info( interpreter,datas,pos,strDatas,list,count )
	local activity_over_index = npos(list)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		for i, v in pairs(_ED.activity_info) do
			if v ~= nil and tonumber(v.activity_id) == tonumber(activity_over_index) then
				if tonumber(v.activity_type) == 7 then
					_ED.activity_info[""..v.activity_type] = nil
				elseif tonumber(v.activity_type) == 57 then
					_ED.mould_function_push_info["11"] = nil
					_ED.list_of_activities_brothers = {}
				elseif tonumber(v.activity_type) == 67 then
					_ED.accessories_points_ranking = {}
				elseif tonumber(v.activity_type) == 78 then
					_ED.activity_to_full_service = 0
				elseif tonumber(v.activity_type) == 97 then
					_ED.military_exploit_points_ranking = {}
				elseif tonumber(v.activity_type) == 99 then
					_ED.leader_senior_points_ranking = {}
				elseif tonumber(v.activity_type) == 100 then
					_ED.activity_info[""..v.activity_type] = nil
					state_machine.excute("main_window_update_top_button", 0, nil)
					state_machine.excute("red_alert_time_seven_day_activity_update_state", 0, nil)
				end
				if fwin:find("WonderfulClass") ~= nil then
					state_machine.excute("red_alert_time_wonderful_update_first",0,v.activity_type)
				else
					if tonumber(v.activity_type) == 68 then -- 刷新配件进化活动加层
						state_machine.excute("equipment_strengthen_tab_update_activity_add_draw",0,"")
						state_machine.excute("equipment_reform_tab_update_activity_add_draw",0,"")
					end
					if tonumber(v.activity_type) == 85 then--刷新科技升级状态
						_ED.activity_info[""..v.activity_type] = nil
				        state_machine.excute("build_up_scientific_to_update_draw",0,"")
				        state_machine.excute("build_up_scientific_info_update_draw",0,"")
				    end
				    if tonumber(v.activity_type) == 91 then--刷新攻击或重置次数
				    	_ED.activity_info[""..v.activity_type] = nil
				        state_machine.excute("expedition_update_draw",0,"") --远征
				        state_machine.excute("pve_parts_supply_tab_activity_end_updata",0,"")--配件
				        state_machine.excute("arena_dearon_tab_update", 0, "") --竞技场
				    end
				end
				if fwin:find("RedAlertTimeCenterClass") ~= nil then
					state_machine.excute("red_alert_time_center_update_first",0,v.activity_type)
				end
				return
			end
		end
	else
		-- 十连抽送碎片活动结束移除该活动
		if _ED.activity_info["38"] ~= nil and tonumber(_ED.activity_info["38"].activity_id) == tonumber(activity_over_index) then
			_ED.activity_info["38"] = nil
			state_machine.excute("hero_recruit_update_activity",0,"")
			state_machine.excute("wonderful_remove_page",0,{38})
		-- 超值兑换活动结束移除该活动
		elseif _ED.activity_info["17"] ~= nil and tonumber(_ED.activity_info["17"].activity_id) == tonumber(activity_over_index) then
			_ED.activity_info["17"] = nil
			state_machine.excute("wonderful_remove_page",0,{17})
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_activity_cost_ratory_rank_message 13006 返回累计消费积分转盘活动消息
---------------------------------------------------------------------------------------------------------
function parse_return_activity_cost_ratory_rank_message( interpreter,datas,pos,strDatas,list,count )
	local count = npos(list)
	_ED.activity_cost_ratory_rank_messages = {}
	for i=1,tonumber(count) do
		local message_info = npos(list)
		local message = zstring.split(message_info, ",")
		local info = {}
		info.user_server_number = tonumber(message[1])
		info.name = message[2]
		info.times = message[3]
		info.rewardInfo = {}
		info.rewardInfo.prop_item = tonumber(message[4])
		info.rewardInfo.prop_type = tonumber(message[5])
		info.rewardInfo.item_value = tonumber(message[6])
		table.insert(_ED.activity_cost_ratory_rank_messages, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_activity_cost_ratory_rank_info 13007 返回累计消费积分转盘活动积分排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_activity_cost_ratory_rank_info( interpreter,datas,pos,strDatas,list,count )
	local count = npos(list)
	_ED.activity_cost_ratory_rank_info = {}
	_ED.activity_cost_ratory_rank_my_info = {}
	_ED.activity_cost_ratory_rank_prev_info = {}
	_ED.activity_cost_ratory_rank_next_info = {}
	for i=1,tonumber(count) do
		local info = {}
		info.id = npos(list)
		info.name = npos(list)
		info.user_server_number = npos(list)
		info.current_server_number = npos(list)
		info.score = npos(list)
		info.rank = npos(list)
		table.insert(_ED.activity_cost_ratory_rank_info, info)
	end
	-- 自己的排名信息
	_ED.activity_cost_ratory_rank_my_info.id = npos(list)
	if tonumber(_ED.activity_cost_ratory_rank_my_info.id) > 0 then
		_ED.activity_cost_ratory_rank_my_info.name = npos(list)
		_ED.activity_cost_ratory_rank_my_info.user_server_number = npos(list)
		_ED.activity_cost_ratory_rank_my_info.current_server_number = npos(list)
		_ED.activity_cost_ratory_rank_my_info.score = npos(list)
		_ED.activity_cost_ratory_rank_my_info.rank = npos(list)
	end

	-- 前一名
	_ED.activity_cost_ratory_rank_prev_info.id = npos(list)
	if tonumber(_ED.activity_cost_ratory_rank_prev_info.id) > 0 then
		_ED.activity_cost_ratory_rank_prev_info.name = npos(list)
		_ED.activity_cost_ratory_rank_prev_info.user_server_number = npos(list)
		_ED.activity_cost_ratory_rank_prev_info.current_server_number = npos(list)
		_ED.activity_cost_ratory_rank_prev_info.score = npos(list)
		_ED.activity_cost_ratory_rank_prev_info.rank = npos(list)
	end

	-- 后一名
	_ED.activity_cost_ratory_rank_next_info.id = npos(list)
	if tonumber(_ED.activity_cost_ratory_rank_next_info.id) > 0 then
		_ED.activity_cost_ratory_rank_next_info.name = npos(list)
		_ED.activity_cost_ratory_rank_next_info.user_server_number = npos(list)
		_ED.activity_cost_ratory_rank_next_info.current_server_number = npos(list)
		_ED.activity_cost_ratory_rank_next_info.score = npos(list)
		_ED.activity_cost_ratory_rank_next_info.rank = npos(list)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_to_the_list_of_activities 13008 返回活动宝箱列表
---------------------------------------------------------------------------------------------------------
function parse_return_to_the_list_of_activities( interpreter,datas,pos,strDatas,list,count )
	_ED.list_of_activities_brothers = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].reward = npos(list)					-- local 奖励
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].receiveNumber = tonumber(npos(list))	-- local 领取人数
		datasInfo[i].maxNumber = tonumber(npos(list))		-- local 可领取最大数
		datasInfo[i].status = tonumber(npos(list))			-- local 领取状态
		datasInfo[i].enTime = tonumber(npos(list))			--local 结束时间
	end
	_ED.list_of_activities_brothers = datasInfo
	-- debug.print_r(_ED.list_of_activities_brothers)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_to_the_accessories_activity_ranking 13009 返回科威特秘密的排行
---------------------------------------------------------------------------------------------------------
function parse_return_to_the_accessories_activity_ranking( interpreter,datas,pos,strDatas,list,count )
	_ED.accessories_points_ranking = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))				-- local 排名
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].integral = tonumber(npos(list))	-- local 积分
	end
	_ED.accessories_points_ranking = datasInfo
	-- debug.print_r(_ED.accessories_points_ranking)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_to_full_service 13010 返回全服总军资
---------------------------------------------------------------------------------------------------------
function parse_return_to_full_service( interpreter,datas,pos,strDatas,list,count )
	_ED.activity_to_full_service = tonumber(npos(list))
	if fwin:find("RedAlertTimeFundingFullServiceClass") ~= nil then
		state_machine.excute("red_alert_time_funding_full_service_update_military", 0, "red_alert_time_funding_full_service_update_military.")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_to_the_integral_carousel 13011 返回积分排行转盘
---------------------------------------------------------------------------------------------------------
function parse_return_to_the_integral_carousel( interpreter,datas,pos,strDatas,list,count )
	_ED.integral_carousel_ranking = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))		-- local 排名
		datasInfo[i].name = npos(list)					-- local 昵称
		datasInfo[i].integral = tonumber(npos(list))	-- local 积分
	end
	_ED.integral_carousel_ranking = datasInfo
end

---------------------------------------------------------------------------------------------------------
-- parse_return_a_copy_of_the_legion 13012 返回军团副本击破数
---------------------------------------------------------------------------------------------------------
function parse_return_a_copy_of_the_legion( interpreter,datas,pos,strDatas,list,count )
	_ED.activity_legion_copy = {}
	_ED.activity_legion_copy.rank = tonumber(npos(list))	--排行
	_ED.activity_legion_copy.c_break = tonumber(npos(list))	--击破数
	
end

---------------------------------------------------------------------------------------------------------
-- parse_return_all_rank_of_rankings 13013 返回所有军团副本排行
---------------------------------------------------------------------------------------------------------
function parse_return_all_rank_of_rankings( interpreter,datas,pos,strDatas,list,count )
	_ED.activity_all_legion_copy = {}
	local counts  = tonumber(npos(list))	--数量
	local legion = {}
	for i=1, counts do
		legion[i] = {}	
		legion[i].name = npos(list)			--军团名字
		legion[i].c_break = npos(list)		--击破数
		legion[i].index = i
	end
	_ED.activity_all_legion_copy = legion
end

---------------------------------------------------------------------------------------------------------
-- parse_return_union_total_contribute 13014 返回军团总贡献
---------------------------------------------------------------------------------------------------------
function parse_return_union_total_contribute( interpreter,datas,pos,strDatas,list,count )
	_ED.union_total_contribute = npos(list)
	local RedAlertTimeLegionSeriesWin = fwin:find("RedAlertTimeLegionSeriesClass")
	if RedAlertTimeLegionSeriesWin ~= nil and tonumber(RedAlertTimeLegionSeriesWin.activity_type) == 93 then
		state_machine.excute("red_alert_time_activity_updata_total_union_contribute",0,"")
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_spectral_decay_rank_exploits_order 13015 返回摧枯拉朽军功排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_spectral_decay_rank_exploits_order( interpreter,datas,pos,strDatas,list,count )
	_ED.military_exploit_points_ranking = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))				-- local 排名
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].integral = tonumber(npos(list))	-- local 积分
	end
	_ED.military_exploit_points_ranking = datasInfo
	-- debug.print_r(_ED.military_exploit_points_ranking)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_fire_line_general_rank_score_order 13016 返回火线将领招募积分排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_fire_line_general_rank_score_order( interpreter,datas,pos,strDatas,list,count )
	_ED.leader_senior_points_ranking = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))				-- local 排名
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].integral = tonumber(npos(list))	-- local 积分
	end
	_ED.leader_senior_points_ranking = datasInfo
	-- debug.print_r(_ED.leader_senior_points_ranking)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_military_pulpit_rank_score_order 13017 返回军事讲坛学分排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_military_pulpit_rank_score_order( interpreter,datas,pos,strDatas,list,count )
	_ED.military_pulpit_points_ranking = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))				-- local 排名
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].integral = tonumber(npos(list))	-- local 积分
	end
	_ED.military_pulpit_points_ranking = datasInfo
	state_machine.excute("red_alert_time_military_pulpit_transfer_rank_updata",0,"")
	-- debug.print_r(_ED.military_pulpit_points_ranking)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_treasure_discount_store_info 13018 返回折扣卖场信息
---------------------------------------------------------------------------------------------------------
function parse_return_treasure_discount_store_info( interpreter,datas,pos,strDatas,list,count )
	local info = {}
	info.page = zstring.tonumber(npos(list))
	_ED.treasure_discount_store_info[info.page] = {}
	info.reset_times = npos(list)
	info.number = zstring.tonumber(npos(list))
	info.reward = {}
	for i = 1 , info.number do
		local curr_reward = {}
		curr_reward.index = npos(list) -- 下标
		curr_reward.remain_number = npos(list) -- 剩余数量
		info.reward[i] = curr_reward
	end
	info.time = os.time()
	_ED.treasure_discount_store_info[info.page] = info
	--debug.print_r(_ED.treasure_discount_store_info)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_discount_store_transfer_number_change 13019 返回折扣卖场推送
---------------------------------------------------------------------------------------------------------
function parse_return_discount_store_transfer_number_change( interpreter,datas,pos,strDatas,list,count )
	local reward_index = tonumber(npos(list))
	local index = tonumber(npos(list))
	local number = tonumber(npos(list))
	if _ED.treasure_discount_store_info ~= nil and _ED.treasure_discount_store_info[0] ~= nil then
		if _ED.treasure_discount_store_info[0].reward[reward_index + 1] ~= nil 
			and tonumber(_ED.treasure_discount_store_info[0].reward[reward_index + 1].index) == index
			then
			_ED.treasure_discount_store_info[0].reward[reward_index + 1].remain_number = number
			state_machine.excute("red_alert_time_discount_store_transfer_update", 0 ,1)
		end
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_largesse_give_rank_score_order 13020 返回慷慨馈赠积分排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_largesse_give_rank_score_order( interpreter,datas,pos,strDatas,list,count )
	_ED.largesse_give_points_ranking = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))				-- local 排名
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].integral = tonumber(npos(list))	-- local 积分
	end
	_ED.largesse_give_points_ranking = datasInfo
	-- debug.print_r(_ED.leader_senior_points_ranking)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_recharge_activity_rank 13021 返回充值排行排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_recharge_activity_rank( interpreter,datas,pos,strDatas,list,count )
	_ED.recharge_activity_rank = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))				-- local 排名
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].gold = tonumber(npos(list))	-- local 充值金币
	end
	_ED.recharge_activity_rank = datasInfo
end

---------------------------------------------------------------------------------------------------------
-- parse_return_consume_activity_rank 13022 返回消费排行排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_consume_activity_rank( interpreter,datas,pos,strDatas,list,count )
	_ED.consume_activity_rank = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))				-- local 排名
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].gold = tonumber(npos(list))	-- local 消费金币
	end
	_ED.consume_activity_rank = datasInfo
end

---------------------------------------------------------------------------------------------------------
-- parse_return_activity_params 13023 返回活动附加状态
---------------------------------------------------------------------------------------------------------
function parse_return_activity_params( interpreter,datas,pos,strDatas,list,count )
	local m_type = tonumber(npos(list))
	local activity_id = tonumber(npos(list))
	local activity_params = npos(list)
	_ED.active_activity[m_type].activity_params = activity_params
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_all")
		if tonumber(m_type) == 77 then
			state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_one_day_recharge")
		elseif tonumber(m_type) == 81 then
			state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_compage_count_1")
		elseif tonumber(m_type) == 82 then
			state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_compage_count_2")
		elseif tonumber(m_type) == 83 then
			state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_compage_count_3")
		elseif tonumber(m_type) == 17
			or tonumber(m_type) == 102
			or tonumber(m_type) == 103
			or tonumber(m_type) == 104
			or tonumber(m_type) == 106
			or tonumber(m_type) == 109
			or tonumber(m_type) == 110
			or tonumber(m_type) == 113
			or tonumber(m_type) == 115
			or tonumber(m_type) == 116
			or tonumber(m_type) == 117
			or tonumber(m_type) == 118
			or tonumber(m_type) == 119
			then
			state_machine.excute("activity_window_update_activity_info_by_type", 0, m_type)
		end

		state_machine.excute("push_notification_center_activity_the_center_sm_activity_update", 0, m_type)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_full_vitality_activity_rank 13024 返回火力全开排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_full_vitality_activity_rank( interpreter,datas,pos,strDatas,list,count )
	_ED.full_vitality_activity_rank = {}
	local count = tonumber(npos(list))
	local datasInfo = {}
	for i=1, count do
		datasInfo[i] = {}
		datasInfo[i].rank = tonumber(npos(list))				-- local 排名
		datasInfo[i].name = npos(list)						-- local 昵称
		datasInfo[i].integral = tonumber(npos(list))	-- local 积分
	end
	_ED.full_vitality_activity_rank = datasInfo
end

---------------------------------------------------------------------------------------------------------
-- parse_return_happy_buy_all_count_info 13025 返回欢乐团购商品全服剩余数量
---------------------------------------------------------------------------------------------------------
function parse_return_happy_buy_all_count_info( interpreter,datas,pos,strDatas,list,count )
	_ED.happy_buy_activity_info = _ED.happy_buy_activity_info or {}
	_ED.happy_buy_activity_info.all_count = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.leave_count = tonumber(npos(list))
		info.discount = tonumber(npos(list))
		table.insert(_ED.happy_buy_activity_info.all_count, info)
	end

	state_machine.excute("red_alert_time_happy_buy_gift_update", 0, "")
	state_machine.excute("red_alert_time_happy_buy_record_update", 0, "")
	state_machine.excute("notification_center_update", 0, "push_notification_happy_buy_record_push")
end

---------------------------------------------------------------------------------------------------------
-- parse_return_happy_buy_record_info 13026 返回欢乐团购购买记录
---------------------------------------------------------------------------------------------------------
function parse_return_happy_buy_record_info( interpreter,datas,pos,strDatas,list,count )
	_ED.happy_buy_activity_info = _ED.happy_buy_activity_info or {}
	_ED.happy_buy_activity_info.record_list = _ED.happy_buy_activity_info.record_list or {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.data_index = tonumber(npos(list)) + 1
		info.count = tonumber(npos(list))
		info.cost_gold = tonumber(npos(list))
		info.rebate_gold = tonumber(npos(list))

		local is_new = true
		for j = 1, #_ED.happy_buy_activity_info.record_list do
			local record_info = _ED.happy_buy_activity_info.record_list[j]
			if record_info.data_index == info.data_index and record_info.cost_gold == info.cost_gold then
				_ED.happy_buy_activity_info.record_list[j] = info
				is_new = false
				break
			end
		end

		if is_new == true then
			table.insert(_ED.happy_buy_activity_info.record_list, info)
		end
	end

	state_machine.excute("red_alert_time_happy_buy_record_update", 0, "")
	state_machine.excute("notification_center_update", 0, "push_notification_happy_buy_record_push")
end

---------------------------------------------------------------------------------------------------------
-- parse_return_carnival_hour_shop_list 13027 返回狂欢时刻兑换下标
---------------------------------------------------------------------------------------------------------
function parse_return_carnival_hour_shop_list( interpreter,datas,pos,strDatas,list,count )
	_ED.carnival_hour_shop_list = {}
	_ED.carnival_hour_shop_reset_time = tonumber(npos(list)) / 1000
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local index = tonumber(npos(list))
		table.insert(_ED.carnival_hour_shop_list, index)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_leagion_online_reward_record 13028 返回军团在线奖励幸运记录
---------------------------------------------------------------------------------------------------------
function parse_return_leagion_online_reward_record( interpreter,datas,pos,strDatas,list,count )
	_ED.leagion_online_reward_record = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.time = tonumber(npos(list)) / 1000
		info.name = npos(list)
		info.reward = npos(list)
		table.insert(_ED.leagion_online_reward_record, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_festival_bless_activity_record 13029 返回节日祝福集福记录
---------------------------------------------------------------------------------------------------------
function parse_return_festival_bless_activity_record( interpreter,datas,pos,strDatas,list,count )
	_ED.festival_bless_activity_record = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.time = tonumber(npos(list)) / 1000
		info.use_gold = tonumber(npos(list))
		info.get_gold = tonumber(npos(list))
		table.insert(_ED.festival_bless_activity_record, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_smoked_eggs_push_info 13030 返回砸金蛋推送信息
---------------------------------------------------------------------------------------------------------
function parse_return_smoked_eggs_push_info( interpreter,datas,pos,strDatas,list,count )
	local info = {}
	info.name = npos(list)
	info.sliver_count = npos(list) 		-- 获得金币数
	info.gold_count = npos(list)		-- 获得钻石数
	info.factor = npos(list)			-- 倍数
	state_machine.excute("sm_smoked_eggs_window_update_play_info", 0, {info})
end

---------------------------------------------------------------------------------------------------------
-- parse_return_limited_time_box_score_rank 13031 返回限时宝箱积分排行榜
---------------------------------------------------------------------------------------------------------
function parse_return_limited_time_box_score_rank( interpreter,datas,pos,strDatas,list,count )
	_ED.sm_limited_time_box_score_rank = {}
	local count = tonumber(npos(list))
	for i=1, count do
		local info = {}
		info.rank = tonumber(npos(list))				-- local 排名
		info.name = npos(list)						-- local 昵称
		info.integral = tonumber(npos(list))	-- local 积分
		table.insert(_ED.sm_limited_time_box_score_rank, info)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_remove_activity_by_type 13032 返回移除活动
---------------------------------------------------------------------------------------------------------
function parse_return_remove_activity_by_type( interpreter,datas,pos,strDatas,list,count )
	local activity_type = tonumber(npos(list))
	_ED.active_activity[tonumber(activity_type)] = nil
	state_machine.excute("notification_center_update", 0, "push_notification_center_activity_all")
   	if tonumber(activityType) == 38 then
   		state_machine.excute("notification_center_update", 0, "push_notification_center_every_day_sign_all")
   	elseif tonumber(activityType) == 27 then
   		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_open_server_activity")
   		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_open_server_activity_buy")
   	elseif tonumber(activityType) == 24 then
   		state_machine.excute("notification_center_update", 0, "push_notification_activity_login_reward")
   	elseif tonumber(activityType) == 42 then
   		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_main_page_seven_days_activity")
		state_machine.excute("notification_center_update", 0, "push_notification_activity_everydays_all_target")
		state_machine.excute("notification_center_update", 0, "push_notification_activity_everydays_page_push")
		state_machine.excute("notification_center_update", 0, "push_notification_new_everydays_recharge")
	elseif tonumber(activityType) == 7 then
		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_accumlate_rechargeable")
	elseif tonumber(activityType) == 77 then
		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_one_day_recharge")	
	elseif tonumber(activityType) == 17 then
		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_accumlate_consumption")
	elseif tonumber(activityType) == 81 then
		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_compage_count_1")
	elseif tonumber(activityType) == 82 then
		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_compage_count_2")
	elseif tonumber(activityType) == 83 then
		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_compage_count_3")
	elseif tonumber(activityType) == 89 then
		state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_limited_time_box")
   	end
	state_machine.excute("activity_window_remove_activity_info", 0, activity_type)
	state_machine.excute("home_update_top_activity_info_state", 0, nil)

	state_machine.excute("push_notification_center_activity_the_center_sm_activity_update", 0, activityType)
end

---------------------------------------------------------------------------------------------------------
-- parse_return_update_activity_day_discount_info 13033 返回每日折扣信息
---------------------------------------------------------------------------------------------------------
function parse_return_update_activity_day_discount_info( interpreter,datas,pos,strDatas,list,count )
	local activity_info = npos(list)
	if _ED.active_activity[93] ~= nil then
		activity_info = zstring.split(activity_info, ",")
		for k,v in pairs(_ED.active_activity[93].activity_Info) do
			local info = zstring.split(v.activityInfo_need_day, ",")
			v.activityInfo_need_day = info[1]..","..info[2]..","..info[3]..","..info[4]..","..info[5]..","..info[6]..","..activity_info[k]
		end
		state_machine.excute("sm_day_discount_window_update_info", 0, nil)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_recruit_activity_reward 13034 机械邪龙兽来袭
---------------------------------------------------------------------------------------------------------
function parse_return_recruit_activity_reward( interpreter,datas,pos,strDatas,list,count )
	_ED.sm_activity_other_recruit_reward = {}
	local count = tonumber(npos(list))
	for i=1,count do
		local rewardCount = tonumber(npos(list))
		local infoList = {}
		for j=1,tonumber(rewardCount) do
			local info = npos(list)
			local isChange = tonumber(npos(list)) == 1
			local baseInfo = zstring.split(info, "|")
			if #baseInfo > 1 then
				local total_count = 0
				info = baseInfo[1]
				for k,v in pairs(baseInfo) do
					local reward = zstring.split(v, ",")
					total_count = total_count + tonumber(reward[3])
				end
				local totalReward = zstring.split(info, ",")
				local star = zstring.tonumber(totalReward[4])
				info = ""
				info = totalReward[1]..","..totalReward[2]..","..total_count..","..star
			end
			table.insert(infoList, {reward = info, isChange = isChange})
		end
		table.insert(_ED.sm_activity_other_recruit_reward, infoList)
	end
end

---------------------------------------------------------------------------------------------------------
-- parse_return_all_activity_banner_info 13035 返回活动弹窗信息
---------------------------------------------------------------------------------------------------------
function parse_return_all_activity_banner_info( interpreter,datas,pos,strDatas,list,count )
	local info = {}
	info.activity_type = tonumber(npos(list))
	info.activity_priority = tonumber(npos(list))
	info.activity_pic_id = tonumber(npos(list))
	if _ED.activity_push_banner_info == nil then
		_ED.activity_push_banner_info = {}
	end
	_ED.activity_push_banner_info[""..info.activity_type] = info
end

---------------------------------------------------------------------------------------------------------
-- parse_return_all_chat_info 14000聊天信息
---------------------------------------------------------------------------------------------------------
function parse_return_all_chat_info( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))
	_ED.send_information_system = _ED.send_information_system or {}
	_ED.send_information_horn = _ED.send_information_horn or {} 
  	_ED.send_information = _ED.send_information or {}
  	_ED.send_chat_view_information = _ED.send_chat_view_information or {}
  	_ED.red_envelopes_information = _ED.red_envelopes_information or {}
  	_ED.send_enemy_strike_information = _ED.enemy_strike_information or {}
  	_ED.legion_chat_view_information = _ED.legion_chat_view_information or {}
  	_ED.home_chat_view_information = _ED.home_chat_view_information or {}
  	_ED.team_chat_view_information = _ED.team_chat_view_information or {}
	local sendInformationAll = {}

	_ED.privateChatSaveToXml = _ED.privateChatSaveToXml or {}

    for i=1,count do
		local sendInformation = {}
		local temp = {}
		sendInformation = {
		    send_to_user_id = npos(list),
			information_type = tonumber(npos(list)), --信息类型（0:系统；1:世界；2 国家, 3:军团；4:私聊 ; 5:GM 6:公会战系统 ;7:公会战倒计时; 8:红包; 9:敌军来袭）
			vip_level = npos(list),
			send_information_camp = npos(list),--阵营 
			send_information_sex = npos(list),--性别
			send_information_id = npos(list),--发送信息人ID
			send_information_name = npos(list),--发送信息人名称
			send_information_rank_title_name = npos(list),--头衔
			send_information_quality = npos(list),--发送信息人品质
			-- TODO...
			send_information_head = npos(list),--发送信息人头像
			send_information_arena_id = npos(list),--发送信息人官阶id
			send_information_user_level = npos(list),--发送信息人等级
			union_name = npos(list), -- 军团名
			union_post = npos(list), -- 军团职位id
			information_content = zstring.exchangeFrom(npos(list)),--信息内容
			send_information_time = npos(list),--信息发布时间
			union_id =  npos(list)
		}

		sendInformation.timestamp = sendInformation.send_information_time

		if sendInformation.information_type == 4 then
			temp.send_information_id = sendInformation.send_information_id
			temp.send_information_time = sendInformation.timestamp
			table.insert(_ED.privateChatSaveToXml, temp)
		end

		if tonumber(sendInformation.information_type) ~= 1 
			and tonumber(sendInformation.information_type) ~= 3 
			and tonumber(sendInformation.information_type) ~= 4 
			and tonumber(sendInformation.information_type) ~= 9 
			then
			if _ED._chat_first_time_to_enter == true and sendInformation.isShow == nil then
				sendInformation.isShow = true
			else
				sendInformation.isShow = false
			end
		else
			sendInformation.isShow = true	
		end

		if __lua_project_id == __lua_project_red_alert_time 
			or __lua_project_id == __lua_project_pacific_rim 
			or __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
			then
			sendInformation.isShow = true
			if sendInformation.information_type == 4 then
				sendInformation.receiver_nickname = npos(list) -- 玩家名称
				sendInformation.receiver_rank_title_name = npos(list) -- 头衔
				sendInformation.receiver_title_name = npos(list) -- 荣誉称号
				sendInformation.receiver_union_name = npos(list) -- 目标军团名
				sendInformation.receiver_union_post = npos(list) -- 目标军团职位id
				sendInformation.receiver_vip_level = npos(list)	-- 目标VIP
				sendInformation.receiver_arena_id = npos(list) --目标人官阶id
			elseif sendInformation.information_type == 8 
				or sendInformation.information_type >= 10 
				then
				sendInformation.system_info_id = npos(list) -- 系统推送id
				sendInformation.system_info_params = npos(list) -- 系统推送参数
			end
		end
		local private_chat = 0
		local chat_union = 0
		local isBlackUser = false
		if __lua_project_id == __lua_project_red_alert_time 
			or __lua_project_id == __lua_project_pacific_rim 
			or __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
			then
			private_chat = 4
			chat_union = 3
			for i, v in pairs(_ED.black_user) do
				if v~=nil and v~="" then
					if tonumber(v.shield_user_id) == tonumber(sendInformation.send_information_id) then
						isBlackUser = true
						break
					end
				end
			end
		else
			private_chat = 3
			chat_union = 4
			if sendInformation.information_type ~= private_chat then
				for i, v in pairs(_ED.black_user) do
					if v~=nil and v~="" then
						if tonumber(v.shield_user_id) == tonumber(sendInformation.send_information_id) then
							return
						end
					end
				end
			end
		end
		local can_insert = false
		local can_insert_view = false
		if sendInformation.information_type == 0 then
			if __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
				then
				table.insert(_ED.send_information_system , sendInformation)
			else
				can_insert = true
				can_insert_view = true
			end
		elseif sendInformation.information_type == 1 then
			can_insert = true
			if __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
				then
			else
				can_insert_view = true
				table.insert(_ED.send_information_system, sendInformation)
			end
		elseif sendInformation.information_type == 2 then
			if __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
				then
				table.insert(_ED.legion_chat_view_information, sendInformation)
			else
				if _ED.union ~= nil 
					and _ED.union.user_union_info ~= nil 
					and zstring.tonumber(_ED.union.user_union_info.union_id) == tonumber(sendInformation.union_id) then
					can_insert = true
					can_insert_view = true
					-- table.insert(_ED.legion_chat_view_information , sendInformation)
				end
			end
		elseif sendInformation.information_type == 3 then
			if __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
				then
				table.insert(_ED.legion_chat_view_information, sendInformation)
			else
				if _ED.union ~= nil 
					and _ED.union.user_union_info ~= nil 
					and zstring.tonumber(_ED.union.user_union_info.union_id) == tonumber(sendInformation.union_id) then
					can_insert = true
					can_insert_view = true
				end
			end
		elseif sendInformation.information_type == private_chat then
			if sendInformation.send_to_user_id == _ED.user_info.user_id 
				or sendInformation.send_information_id == _ED.user_info.user_id 
				then
				can_insert_view = true
				if __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
					then
				else
					can_insert = true
				end
			end
		elseif sendInformation.information_type == chat_union then
			if tonumber(sendInformation.send_information_camp) == tonumber(_ED.user_info.user_force) then
				can_insert = true
				can_insert_view = true
			end
		elseif sendInformation.information_type == 6 
			or sendInformation.information_type == 7 then
			state_machine.excute("union_fighting_notice_open", 0, {sendInformation.information_type, sendInformation.information_content})
		elseif sendInformation.information_type == 8 then
			can_insert = true
			can_insert_view = true
			sendInformation.send_information_id = 0
			local params = zstring.split(sendInformation.system_info_params, ",")
			local title = dms.string(dms["message_share"], sendInformation.system_info_id, message_share.title)
			local content = dms.string(dms["message_share"], sendInformation.system_info_id, message_share.content)
			if tonumber(title) ~= nil and tonumber(title) < 0 then
	            title = ""
	        else
	            title = title.."\r\n"
	        end
	        if params[1] ~= nil and params[1] ~= "" then
	            content = string.gsub(content, "!x@", params[1])
	        end
	        if params[2] ~= nil and params[2] ~= "" then
	            content = string.gsub(content, "!y@", params[2])
	        end
	        if params[3] ~= nil and params[3] ~= "" then
	            content = string.gsub(content, "!z@", params[3])
	        end
	        if params[4] ~= nil and params[4] ~= "" then
	            content = string.gsub(content, "!s@", params[4])
	        end
	        if params[5] ~= nil and params[5] ~= "" then
	            content = string.gsub(content, "!a@", params[5])
	        end
	        sendInformation.information_content = title..content..sendInformation.information_content
	        sendInformation.red_send_time = tonumber(sendInformation.send_information_time)
	        for k, v in pairs(_ED.send_information) do
	        	if v.red_send_time == sendInformation.red_send_time then
	        		sendInformation.send_information_time = (os.time() + _ED.time_add_or_sub) * 1000
	        		break
		        end
	        end

			table.insert(_ED.red_envelopes_information, sendInformation)
			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				if fwin:find("MainWindowClass") == nil then
		            _ED.red_envelopes_information = {}
		        end
		        if _ED.redEnvelopesIsPlaying == nil or _ED.redEnvelopesIsPlaying == false then
		        	redEnvelopesPlay()
		       	end
			end
		elseif sendInformation.information_type == 9 then
			can_insert = true
			can_insert_view = true
			table.insert(_ED.send_enemy_strike_information , sendInformation)
			state_machine.excute("enemy_strike_fight_send_message", 0, sendInformation)
			state_machine.excute("enemy_strike_challge_send_message", 0, sendInformation)
		elseif sendInformation.information_type == 10 then
			sendInformation.information_type = 3
			sendInformation.send_information_id = 0
			if _ED.union ~= nil 
				and _ED.union.user_union_info ~= nil 
				and zstring.tonumber(_ED.union.user_union_info.union_id) == tonumber(sendInformation.union_id) then
				can_insert = true
				can_insert_view = true
				local params = zstring.split(sendInformation.system_info_params, "|")
				local info = dms.string(dms["message_notification_param"], sendInformation.system_info_id, message_notification_param.content)
				local show_type = dms.int(dms["message_notification_param"], sendInformation.system_info_id, message_notification_param.show_type)
				local message_type = dms.int(dms["message_notification_param"], sendInformation.system_info_id, message_notification_param.message_type)
	            local jump_info =""
	            if params[1] ~= nil and params[1] ~= "" then
	            	if message_type == 177 
	            		or message_type == 189 
	            		then
	            		local world_city_name = dms.string(dms["world_city_mould"], params[1], world_city_mould.name)
	            		info = string.gsub(info, "!x@", world_city_name)
            		elseif message_type == 184 then
            			local name_info = zstring.split(params[1], "_")
            			info = string.gsub(info, "!x@", name_info[1])
            			jump_info = chat_section[1].."14|"..name_info[2]
	            	else
		                info = string.gsub(info, "!x@", params[1])
		            end
	            end

	            if params[2] ~= nil and params[2] ~= "" then
	            	if message_type == 176
	            		or message_type == 178
	            		or message_type == 188
	            		or message_type == 190
	            	 	then
	            		local world_city_name = dms.string(dms["world_city_mould"], params[2], world_city_mould.name)
	            		info = string.gsub(info, "!y@", world_city_name)
	            	elseif message_type == 183
	            		or message_type == 184
	            		or message_type == 185
	            		or message_type == 186
	            		then
	            		if tonumber(params[2]) ~= nil and tonumber(params[2]) == -1 then
	            			info = string.gsub(info, "!y@", "")
	            		else
		            		info = string.gsub(info, "!y@", "["..params[2].."]")
		            	end
	            	else
		                info = string.gsub(info, "!y@", params[2])
		            end
	            end
	            if params[3] ~= nil and params[3] ~= "" then
	            	if message_type == 183 then
            			local name_info = zstring.split(params[3], "_")
            			info = string.gsub(info, "!z@", name_info[1])
            			jump_info = chat_section[1].."14|"..name_info[2]
	            	else
		                info = string.gsub(info, "!z@", params[3])
		            end
	            end
	            if message_type == 186 then
	            	local res_count = 0
	            	if params[4] ~= nil and params[4] ~= "" then
	            		for i = 4, #params do
	                		local res_info = zstring.split(params[i], ",")
	                		res_count = res_count + tonumber(res_info[3])
	                	end
	                end
                	info = string.gsub(info, "!s@", exChangeNumToString(res_count))
	            else
	            	if params[4] ~= nil and params[4] ~= "" then
	            		info = string.gsub(info, "!s@", params[4])
	            	end
	            end
	            if params[5] ~= nil and params[5] ~= "" then
	                info = string.gsub(info, "!a@", params[5])
	            end
	            sendInformation.information_content = info..jump_info

				table.insert(_ED.legion_chat_view_information, sendInformation)
			end
		elseif sendInformation.information_type == 11 then
			can_insert = true
			can_insert_view = true

			local params = zstring.split(sendInformation.system_info_params, ",")
			local title = dms.string(dms["message_share"], sendInformation.system_info_id, message_share.title)
			local content = dms.string(dms["message_share"], sendInformation.system_info_id, message_share.content)
			if tonumber(title) ~= nil and tonumber(title) < 0 then
	            title = ""
	        else
	            title = title.."\r\n"
	        end
	        if params[1] ~= nil and params[1] ~= "" then
	            content = string.gsub(content, "!x@", params[1])
	        end
	        if params[2] ~= nil and params[2] ~= "" then
	            content = string.gsub(content, "!y@", params[2])
	        end
	        if params[3] ~= nil and params[3] ~= "" then
	            content = string.gsub(content, "!z@", params[3])
	        end
	        if params[4] ~= nil and params[4] ~= "" then
	            content = string.gsub(content, "!s@", params[4])
	        end
	        if params[5] ~= nil and params[5] ~= "" then
	            content = string.gsub(content, "!a@", params[5])
	        end
	        sendInformation.information_content = title..content..sendInformation.information_content
	        sendInformation.red_send_time = tonumber(sendInformation.send_information_time)
	        for k, v in pairs(_ED.send_information) do
	        	if v.red_send_time == sendInformation.red_send_time then
	        		sendInformation.send_information_time = (os.time() + _ED.time_add_or_sub) * 1000
	        		break
		        end
	        end

			table.insert(_ED.red_envelopes_information, sendInformation)

			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
				if fwin:find("MainWindowClass") == nil then
		            _ED.red_envelopes_information = {}
		        end
		        if _ED.redEnvelopesIsPlaying == nil or _ED.redEnvelopesIsPlaying == false then
		        	redEnvelopesPlay()
		       	end
			end
			sendInformation.information_type = 3
			sendInformation.send_information_id = 0
			if _ED.union ~= nil 
				and _ED.union.user_union_info ~= nil 
				and zstring.tonumber(_ED.union.user_union_info.union_id) == tonumber(sendInformation.union_id) then
				table.insert(_ED.legion_chat_view_information, sendInformation)
			end
		elseif sendInformation.information_type == 12 then
			sendInformation.information_type = 0
			can_insert = true
			can_insert_view = true
			local params = zstring.split(sendInformation.system_info_params, "|")
			local info = dms.string(dms["message_notification_param"], sendInformation.system_info_id, message_notification_param.content)
			local message_type = dms.int(dms["message_notification_param"], sendInformation.system_info_id, message_notification_param.message_type)
			local show_type = dms.int(dms["message_notification_param"], sendInformation.system_info_id, message_notification_param.show_type)
	        if params[1] ~= nil and params[1] ~= "" then
	            if message_type == 180 then
            		local world_city_name = dms.string(dms["world_city_mould"], params[1], world_city_mould.name)
            		info = string.gsub(info, "!x@", world_city_name)
            	else
	                info = string.gsub(info, "!x@", params[1])
	            end
	        end
	        if params[2] ~= nil and params[2] ~= "" then
	        	if message_type == 105 then
	        		local name = dms.string(dms["avatar_mould"], params[2], avatar_mould.name)
	        		info = string.gsub(info, "!y@", name)
	    		elseif message_type == 106 
	    			or message_type == 107
	    			or message_type == 116
	    			then
	    			local name = dms.string(dms["equipment_mould"], params[2], equipment_mould.equipment_name)
	    			local quality = dms.int(dms["equipment_mould"], params[2], equipment_mould.grow_level)
	    			name = "|"..quality.."|"..name
	        		info = string.gsub(info, "!y@", name)
	        	elseif message_type == 108 
	        		or message_type == 187 
	        		then
	        		local propInfo = zstring.split(params[2], ",")
	        		local prop_id = propInfo[1]
	        		if tonumber(propInfo[1]) == -1 then
	        			prop_id = propInfo[2]
	        		end
	        		local name = dms.string(dms["prop_mould"], prop_id, prop_mould.prop_name)
	    			local quality = dms.int(dms["prop_mould"], prop_id, prop_mould.prop_quality)
	    			name = "|"..quality.."|"..name.."x"..propInfo[3]
	        		info = string.gsub(info, "!y@", name)
				elseif message_type == 110 
					or message_type == 111 
					then
					local name = dms.string(dms["ship_mould"], params[2], ship_mould.captain_name)
	            	local quality = dms.int(dms["ship_mould"], params[2], ship_mould.ship_type)
	            	name = "|"..quality.."|"..name
	        		info = string.gsub(info, "!y@", name)
	        	elseif message_type == 127 then
	        		local name = dms.string(dms["npc"], params[2], npc.npc_name)
	        		info = string.gsub(info, "!y@", name)
	        	elseif message_type == 137 
	        		or message_type == 139 
	        		or message_type == 140 
	        		or message_type == 170
	        		or message_type == 171
	        		or message_type == 172
	        		or message_type == 173
	        		or message_type == 174 
	        		or message_type == 175  
	        		then
	        		local name = ""
	        		if _ED.activity_info[""..params[2]] ~= nil then
	        			name = _ED.activity_info[""..params[2]].activity_title
	        		else
	        			name = dms.string(dms["activity_param"], params[2], activity_param.name)
	        		end
	        		info = string.gsub(info, "!y@", name)
	        	elseif message_type == 138 then
	        		local name = dms.string(dms["prop_mould"], params[2], prop_mould.prop_name)
	    			local quality = dms.int(dms["prop_mould"], params[2], prop_mould.prop_quality)
	    			name = "|"..quality.."|"..name
	        		info = string.gsub(info, "!y@", name)
	        	elseif message_type == 141 then
	        		local shipInfo = zstring.split(params[2], ",")
	        		local name = dms.string(dms["ship_mould"], shipInfo[1], ship_mould.captain_name)
	            	local quality = dms.int(dms["ship_mould"], shipInfo[1], ship_mould.ship_type)
	            	name = "|"..quality.."|"..name.."x"..shipInfo[3]
	        		info = string.gsub(info, "!y@", name)
	        	elseif message_type == 179 
	        		or message_type == 181
	        		or message_type == 191
	        		then
	        		local world_city_name = dms.string(dms["world_city_mould"], params[2], world_city_mould.name)
	            	info = string.gsub(info, "!y@", world_city_name)
				else
	            	info = string.gsub(info, "!y@", params[2])
	            end
	        end
	        if params[3] ~= nil and params[3] ~= "" then
	        	if message_type == 109 then
	        		local name = dms.string(dms["talent_mould"], params[3], talent_mould.talent_name)
	        		info = string.gsub(info, "!z@", name)
	        	elseif message_type == 137 
	        		or message_type == 140 
	        		or message_type == 170
	        		or message_type == 171
	        		or message_type == 172 
	        		then
	        		local shipInfo = zstring.split(params[3], ",")
	        		local name = dms.string(dms["ship_mould"], shipInfo[1], ship_mould.captain_name)
	            	local quality = dms.int(dms["ship_mould"], shipInfo[1], ship_mould.ship_type)
	            	name = "|"..quality.."|"..name.."x"..shipInfo[3]
	        		info = string.gsub(info, "!z@", name)
	        	elseif message_type == 138 
	        		or message_type == 150
	        		or message_type == 175
	        		then
	        		local propInfo = zstring.split(params[3], ",")
	        		local name = dms.string(dms["prop_mould"], propInfo[1], prop_mould.prop_name)
	    			local quality = dms.int(dms["prop_mould"], propInfo[1], prop_mould.prop_quality)
	    			name = "|"..quality.."|"..name.."x"..propInfo[3]
	        		info = string.gsub(info, "!z@", name)
	        	elseif message_type == 139 then
	        		local propInfo = zstring.split(params[3], ",")
	        		local name = ""
	        		if tonumber(propInfo[2]) == 6 then
	            		name = dms.string(dms["prop_mould"], propInfo[1], prop_mould.prop_name)
	        			local quality = dms.int(dms["prop_mould"], propInfo[1], prop_mould.prop_quality)
	        			name = "|"..quality.."|"..name.."x"..propInfo[3]
	        		else
	            		name = dms.string(dms["ship_mould"], propInfo[1], ship_mould.captain_name)
	                	local quality = dms.int(dms["ship_mould"], propInfo[1], ship_mould.ship_type)
	                	name = "|"..quality.."|"..name.."x"..propInfo[3]
	        		end
	        		info = string.gsub(info, "!z@", name)
	        	elseif message_type == 174 then
	        		local shipInfo = zstring.split(params[3], ",")
	            	local quality = dms.int(dms["ship_mould"], shipInfo[1], ship_mould.ship_type)
	            	local name = dms.string(dms["ship_mould"], shipInfo[1], ship_mould.captain_name)
	        		info = string.gsub(info, "!z@", quality)
	        		name = "|"..quality.."|"..name
	        		info = string.gsub(info, "!s@", name)
	        	else
	            	info = string.gsub(info, "!z@", params[3])
	            end
	        end
	        if params[4] ~= nil and params[4] ~= "" then
	            info = string.gsub(info, "!s@", params[4])
	        end
	        if params[5] ~= nil and params[5] ~= "" then
	            info = string.gsub(info, "!a@", params[5])
	        end
	        if message_type == 114 then
	        	local legion_info = zstring.split(sendInformation.information_content, "|||")
	        	sendInformation.information_content = info.."|||"..legion_info[2]
	        else
	        	sendInformation.information_content = info
	        end
	        if show_type == 1 then
				table.insert(_ED.send_information_system, sendInformation)
			end
		elseif sendInformation.information_type == 13 
			or sendInformation.information_type == 14 
			then
			local params = zstring.split(sendInformation.system_info_params, ",")
			if params[1] ~= nil and params[1] ~= "" then
				local replaceIndex, result = parseMessageParams(zstring.split(params[1], "-"))
				if zstring.tonumber(replaceIndex) > 0 then
					params[replaceIndex + 1] = result
				end
			end
			local title = dms.string(dms["message_share"], sendInformation.system_info_id, message_share.title)
			local content = dms.string(dms["message_share"], sendInformation.system_info_id, message_share.content)
			if tonumber(title) ~= nil and tonumber(title) < 0 then
	            title = ""
	        else
	            title = title.."\r\n"
	        end
	        if params[2] ~= nil and params[2] ~= "" then
	        	if tonumber(sendInformation.system_info_id) == 84 or tonumber(sendInformation.system_info_id) == 85 then
	        		local info = zstring.split(params[2], "_")
	        		if #info > 2 and tonumber(info[2]) ~= nil and tonumber(info[2]) > 0 then
	        			local npc_name = dms.string(dms["npc"], info[2],npc.npc_name)
	        			params[2] = ""..npc_name.." "..friends_tip_string[12]..info[3]
	        		end
		        end
	            content = string.gsub(content, "!x@", params[2])
	        end
	        if params[3] ~= nil and params[3] ~= "" then
	            content = string.gsub(content, "!y@", params[3])
	        end
	        if params[4] ~= nil and params[4] ~= "" then
	            content = string.gsub(content, "!z@", params[4])
	        end
	        if params[5] ~= nil and params[5] ~= "" then
	            content = string.gsub(content, "!s@", params[5])
	        end
	        if params[6] ~= nil and params[6] ~= "" then
	            content = string.gsub(content, "!a@", params[6])
	        end
	        sendInformation.information_content = title..content..sendInformation.information_content

	        if sendInformation.information_type == 14 then
	        	sendInformation.information_type = 3
	            if _ED.union ~= nil 
					and _ED.union.user_union_info ~= nil 
					and zstring.tonumber(_ED.union.user_union_info.union_id) == tonumber(sendInformation.union_id) then
					can_insert = true
					can_insert_view = true
					table.insert(_ED.legion_chat_view_information, sendInformation)
				end
			else
				local info = zstring.split(sendInformation.information_content, "|||")
				if #info >= 2 then
					sendInformation.information_type = 0
					sendInformation.send_information_id = 0
				else
					sendInformation.information_type = 1
				end
				can_insert = true
				can_insert_view = true
	    	end
		elseif sendInformation.information_type == 15 then
			if tonumber(sendInformation.system_info_params) == 0 then
				can_insert = true
				can_insert_view = true
			end
			sendInformation.information_type = 1
			table.insert(_ED.send_information_horn, sendInformation)
			if fwin:find("MainWindowClass") == nil then
	            _ED.send_information_horn = {}
	        end
	        if _ED.hornIsPlaying == nil or _ED.hornIsPlaying == false then
	        	redHornPlay()
	       	end
       	elseif sendInformation.information_type == 16 then
       		parseNotificationMessageParams(sendInformation)
			table.insert(_ED.send_information_system, sendInformation)
			sendInformation.information_type = 0
		elseif sendInformation.information_type == 17 then
			parseNotificationMessageParams(sendInformation)
			can_insert = true
			sendInformation.information_type = 1
		elseif sendInformation.information_type == 18 then
			parseNotificationMessageParams(sendInformation)
			table.insert(_ED.legion_chat_view_information, sendInformation)
			sendInformation.information_type = 2
			sendInformation.send_information_id = 0
		elseif sendInformation.information_type == 19 then
			parseNotificationMessageParams(sendInformation)
			table.insert(_ED.team_chat_view_information, sendInformation)
			sendInformation.send_information_id = 0
			sendInformation.information_type = 3
		elseif sendInformation.information_type == 20 then
			sendInformation.information_type = 2
			parseNotificationMessageParams(sendInformation)
			sendInformation.send_information_id = 0
			table.insert(_ED.legion_chat_view_information, sendInformation)
		end
		local string_time = os.date("%H"..":".."%M", zstring.exchangeFrom(zstring.tonumber(sendInformation.send_information_time)/1000 - _ED.GTM_Time))
		sendInformation.send_information_time = string_time
		sendInformation.user_official = dms.int(dms["arena_reward_param"],sendInformation.send_information_arena_id,arena_reward_param.arena_official)
		if isBlackUser == true then
			can_insert = false
			can_insert_view = false
		else
			table.insert(_ED.home_chat_view_information, sendInformation)
		end
		if can_insert == true then
			table.insert(_ED.send_information, sendInformation)
		end
		if can_insert_view == true then
			local privateChatFromXml = cc.UserDefault:getInstance():getStringForKey("privateChatSaveToXml", "")

			local bFindSame = false
			if privateChatFromXml ~= nil and privateChatFromXml ~= "" then
				local cache = json.decode(privateChatFromXml)
				if cache then
					for i = 1, #cache do
						local data = cache[i]
						if tonumber(data.send_information_id) == tonumber(sendInformation.send_information_id) 
							and tonumber(sendInformation.timestamp) == tonumber(data.send_information_time)	then
							bFindSame = true
							break
						end
					end
				end
			end

			-- 如果在本地没有找到相同消息的缓存，则表示有新消息
			if bFindSame == false and tonumber(sendInformation.send_information_id) ~= tonumber(_ED.user_info.user_id) then
				_ED.findNewWhisper = 1
			end

			table.insert(_ED.send_chat_view_information, sendInformation)
		end
    end
	if __lua_project_id == __lua_project_red_alert_time 
		or __lua_project_id == __lua_project_pacific_rim 
		then
		state_machine.excute("red_alert_time_button_update_chat_info", 0, "")
		state_machine.excute("legion_chats_view_update_draw", 0, "")
		_ED._chat_first_time_to_enter = true
	elseif __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
    	state_machine.excute("sm_chat_view_updata",0,"sm_chat_view_updata.")
    	state_machine.excute("sm_chat_view_update_all_info",0,"sm_chat_view_update_all_inf.")
    	state_machine.excute("notification_center_update", 0, "push_notification_center_chat_all")
    	state_machine.excute("notification_center_update", 0, "push_notification_center_whisper_chat")
    else
		state_machine.excute("chat_view_update_chat_info", 0, "")
	end

end

---------------------------------------------------------------------------------------------------------
-- parse_return_all_chat_info 14001 GM推送信息
---------------------------------------------------------------------------------------------------------
function parse_return_game_message_info( interpreter,datas,pos,strDatas,list,count )
	local count = 1
  	_ED.send_information = _ED.send_information or {}
  	_ED.send_chat_view_information = _ED.send_chat_view_information or {}
    for i=1,count do
		local sendInformation = {}
		sendInformation = {
		    send_to_user_id = "-1",
			information_type = 5, --信息类型（0:系统；1:世界 2:军团；3:私聊 4 国家, 5 GM）
			vip_level = "0",
			send_information_camp = "0",--阵营 
			send_information_sex = "0",--性别
			send_information_id = "0",--发送信息人ID
			send_information_name = "0",--发送信息人名称
			send_information_quality = "0",--发送信息人品质
			-- TODO...
			send_information_head = "0",--发送信息人头像
			send_information_arena_id = "0",--发送信息人官阶id
			send_information_user_level = "0",--发送信息人等级
			information_content = zstring.exchangeFrom(npos(list)),--信息内容
			send_information_time = (_ED.system_time + os.time() * 1000),--信息发布时间
			union_id = "0",
		}

		local can_insert = false
		local can_insert_view = false
		if sendInformation.information_type == 0 then
			can_insert = true
		elseif sendInformation.information_type == 1 then
			can_insert = true
			can_insert_view = true
		elseif sendInformation.information_type == 2 then
			if _ED.union ~= nil 
				and _ED.union.user_union_info ~= nil 
				and zstring.tonumber(_ED.union.user_union_info.union_id) == tonumber(sendInformation.union_id) then
				can_insert = true
				can_insert_view = true
			end
		elseif sendInformation.information_type == 3 then
			if sendInformation.send_to_user_id == _ED.user_info.user_id 
			or sendInformation.send_information_id == _ED.user_info.user_id then
				can_insert = true
				can_insert_view = true
			end
		elseif sendInformation.information_type == 4 then
			if tonumber(sendInformation.send_information_camp) == tonumber(_ED.user_info.user_force) then
				can_insert = true
				can_insert_view = true
			end
		elseif sendInformation.information_type == 5 then
			can_insert = true
			can_insert_view = true
		end

		local string_time = os.date("%H"..":".."%M", zstring.exchangeFrom(zstring.tonumber(sendInformation.send_information_time)/1000))
		sendInformation.send_information_time = string_time
		sendInformation.user_official = dms.int(dms["arena_reward_param"],sendInformation.send_information_arena_id,arena_reward_param.arena_official)
		if can_insert == true then
			table.insert(_ED.send_information , sendInformation)
		end
		if can_insert_view == true then
			table.insert(_ED.send_chat_view_information, sendInformation)
		end
    end
   
    state_machine.excute("chat_view_update_chat_info",0,"")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_red_envelopes_info 14002 --返回红包信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_red_envelopes_info( interpreter,datas,pos,strDatas,list, count )
	_ED.send_red_envelopes_name = npos(list)
	_ED.red_envelopes_id = tonumber(npos(list))
	_ED.red_envelopes_template_id = tonumber(npos(list))
	_ED.red_envelopes_max_times = tonumber(npos(list))
	_ED.red_envelopes_max_gold = tonumber(npos(list))
	_ED.red_envelopes_make_times = tonumber(npos(list))
	_ED.get_red_envelopes_info = {}
	for i=1,_ED.red_envelopes_make_times do
		local data_info = {}
		data_info.name = npos(list)
		data_info.gold = npos(list)
		_ED.get_red_envelopes_info[i] = data_info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_system_push_info 14003 --返回系统推送状态
-- ---------------------------------------------------------------------------------------------------------
function parse_return_system_push_info( interpreter,datas,pos,strDatas,list, count )
	_ED.push_system_notice_info = _ED.push_system_notice_info or {}
	local push_mould_type = tonumber(npos(list))
	local open_state = tonumber(npos(list))			-- 0未开启，1开启
	if push_mould_type == 1 then
        local server_time = getCurrentGTM8Time()
        if tonumber(server_time.hour) >= 15 then
        	push_mould_type = 20
        end
	end
	if open_state == 0 then
		_ED.push_system_notice_info[""..push_mould_type] = nil
	else
		_ED.push_system_notice_info[""..push_mould_type] = push_mould_type
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_resource_update_tips 14004 --返回资源更新提示
-- ---------------------------------------------------------------------------------------------------------
function parse_return_resource_update_tips( interpreter,datas,pos,strDatas,list, count )
	--打开资源更新客户端提示界面
	app.load("client.utils.ResourceUpdateTips")
	local tip = ResourceUpdateTips:new()
	tip:init(1,_new_interface_text[232],_new_interface_text[233])
	fwin:open(tip,fwin._border)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_system_special_tips 14005 --返回系统特殊提示
-- ---------------------------------------------------------------------------------------------------------
function parse_return_system_special_tips( interpreter,datas,pos,strDatas,list, count )
	_ED.user_reset_is = true
	if missionIsOver() == true then
		app.load("client.utils.ResourceUpdateTips")
		local tip = ResourceUpdateTips:new()
		tip:init(2,_new_interface_text[234],_new_interface_text[235])
		fwin:open(tip,fwin._border)
	end
end



---------------------------------------------------------------------------------------------------------
-- parse_read_all_other_ship_info 14100 其他用户英雄信息
---------------------------------------------------------------------------------------------------------
function parse_read_all_other_ship_info(interpreter,datas,pos,strDatas,list,count )
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		_ED.other_user_ship = {}
		local count = npos(list)
		local usership ={
			ship_id=npos(list),									--用户战船1ID
			ship_template_id=npos(list),						--战船模版ID
			skin_id = npos(list),						-- 皮肤
			ship_base_template_id=npos(list),				--战船基础模板ID
			ship_place	=npos(list),							--战船位置
			captain_type=npos(list),							--船长类型
			ship_type=npos(list),								--战船类型
			captain_name=npos(list),							--船长名称
			ship_name=npos(list),								--战船名称
			ship_grade=npos(list),								--战船等级
			ship_health=npos(list),							--战船体力值 
			ship_courage=npos(list),							--战船勇气值
			ship_intellect=npos(list),							--战船智力值
			ship_quick=npos(list),								--战船敏捷值
			ship_picture=npos(list),							--战船图标
			hero_fight=npos(list),								--英雄战斗力
			crit_add = math.floor(tonumber(npos(list))*100)/100, --暴击率
			uncrit_add = math.floor(tonumber(npos(list))*100)/100,	 --抗暴率
			parry_add = math.floor(tonumber(npos(list))*100)/100, 	--格挡率
			unparry_add = math.floor(tonumber(npos(list))*100)/100,       --破格挡率
			hurt_add = math.floor(tonumber(npos(list))*100)/100,          --伤害加成
			unhurt_add = math.floor(tonumber(npos(list))*100)/100,        --伤害减免
			crit_hurt_add = math.floor(tonumber(npos(list))*100)/100,     --暴击加成
			parry_unhurt_add = math.floor(tonumber(npos(list))*100)/100,  --格挡加成
			ship_leader = npos(list),								--统帅
			ship_force = npos(list),									--武力
			ship_wisdom = npos(list),								--智慧
			health_growup_type=npos(list),				--体力成长类型
			courage_grade_type=npos(list),				--勇气成长类型
			intellect_grade_type=npos(list),				--智力成长类型
			quick_grade_type=npos(list),					--敏捷成长类型
			skill_mould=npos(list),								-- 普攻技能模板id
			skill_name=npos(list),								--技能名称
			skill_describe=npos(list),							--技能描述
			deadly_skill_mould=npos(list),					--怒气技能模板id
			deadly_skill_name=npos(list),					--怒气技能名称
			deadly_skill_describe=npos(list),				--怒气技能描述
			exprience=npos(list),								--当前经验
			grade_need_exprience=npos(list),				--当前级别所需经验
			train=npos(list),										--是否训练
			train_endtime=npos(list),							--训练结束时间
			ship_growup_exprience=npos(list),			--船只成长经验值
			evolution_status = npos(list),			--进化进度当前进化到几|关卡进度，关卡进度，关卡进度，关卡进度
            Order = npos(list),
            StarRating = npos(list),
			skillLevel = npos(list),			--技能等级(1,2,1,0,0,0)
			equipInfo = npos(list),
		}

		usership.ship_base_health = usership.ship_health
		-- print("身体4 " .. usership.ship_base_health)
		usership.ship_health = math.floor(tonumber(usership.ship_health))
		usership.ship_base_courage = usership.ship_courage
		usership.ship_courage = math.floor(tonumber(usership.ship_courage))
		usership.ship_base_intellect = usership.ship_intellect
		usership.ship_intellect = math.floor(tonumber(usership.ship_intellect))

		usership.equipment = {}
		for i=1, 8 do
			local battery_id = npos(list)
			local equipmentinfo = {}
			equipmentinfo.user_equiment_id  = battery_id
			equipmentinfo.ship_id = "0"
			if tonumber(battery_id)~= 0 then
				--[[
				--]]
				equipmentinfo.user_equiment_template=npos(list)		--装备模版ID号
				equipmentinfo.user_equiment_name=npos(list)					--装备名称
				equipmentinfo.sell_price=npos(list)			--装备出售价格
				equipmentinfo.user_equiment_influence_type=npos(list)	--装备影响类型
				equipmentinfo.equipment_type=npos(list)					--装备类型
				equipmentinfo.user_equiment_ability=npos(list)				--装备能力值
				equipmentinfo.user_equiment_grade=npos(list)				--装备等级
				equipmentinfo.user_equiment_exprience=npos(list)				--装备经验
				equipmentinfo.user_equiment_growup_grade=npos(list)	--装备成长等级
				equipmentinfo.growup_value=npos(list)				--装备成长值
				equipmentinfo.adorn_need_ship=npos(list)			--佩戴所需战船等级
				equipmentinfo.equiment_picture=npos(list)				--装备图片标识
				equipmentinfo.equiment_track_remark=npos(list)			--追踪备注
				equipmentinfo.equiment_track_scene=npos(list)			--追踪场景
				equipmentinfo.equiment_track_npc=npos(list)				--追踪NPC
				equipmentinfo.equiment_track_npc_index=npos(list)		--追踪NPC下标
				equipmentinfo.equiment_refine_level = npos(list)
				equipmentinfo.equiment_refine_param = npos(list)
				equipmentinfo.refining_times = npos(list)				--洗练次数
				equipmentinfo.refining_value_life = npos(list)			--int		洗练生命值
				equipmentinfo.refining_value_temp_life = npos(list)		--int		洗练生命临时值
				equipmentinfo.refining_value_attack = npos(list)				--int		洗练攻击值
				equipmentinfo.refining_value_temp_attack = npos(list)			--int		洗练攻击临时值
				equipmentinfo.refining_value_physical_defence = npos(list)			--int		洗练物防值
				equipmentinfo.refining_value_temp_physical_defence = npos(list)	--int		洗练物防临时值
				equipmentinfo.refining_value_skill_defence = npos(list)			--int		洗练法防值
				equipmentinfo.refining_value_temp_skill_defence = npos(list)		--int		洗练法防临时值
				equipmentinfo.refining_value_final_damange = npos(list)			--int		洗练终伤值
				equipmentinfo.refining_value_temp_final_damange = npos(list)		--int		洗练终伤临时值
				equipmentinfo.refining_value_final_lessen_damange = npos(list)		--	int		洗练终减伤值
				equipmentinfo.refining_value_temp_final_lessen_damange = npos(list)			--int		洗练终减伤临时值
				equipmentinfo.ship_id = usership.ship_id
				
				-- equipmentinfo = _ED.user_equiment[equipmentinfo.user_equiment_id]
				--升星属性
				equipmentinfo.current_star_level = npos(list)
				equipmentinfo.current_star_exp = npos(list)
				equipmentinfo.add_attribute = npos(list)
				equipmentinfo.luck_value = npos(list)
			end
			
			equipmentinfo.grow_level = dms.int(dms["equipment_mould"], equipmentinfo.user_equiment_template, equipment_mould.grow_level)
			if equipmentinfo.user_equiment_name ~= nil and equipmentinfo.user_equiment_name ~= "" then
				local splitEquipmentName = zstring.split(equipmentinfo.user_equiment_name, "|")
				if splitEquipmentName ~= nil and #splitEquipmentName > 1 and splitEquipmentName[_ED.user_info.user_gender] ~= nil then
					equipmentinfo.user_equiment_name = splitEquipmentName[_ED.user_info.user_gender]
				end
			end
			usership.equipment[i]= equipmentinfo
			
		end
		
		usership.relationship_count=npos(list)						--羁绊数量
		usership.relationship = {}
		for r = 1, tonumber(usership.relationship_count) do
			trelationship = {
				relationship_id=npos(list),-- 羁绊1名称 
				is_activited=npos(list),	-- 是否激活 羁绊说明
			}
			usership.relationship[r] = trelationship
		end
			
		usership.talent_count=npos(list)--天赋数量
		usership.talents = {}
		for r = 1, tonumber(usership.talent_count) do
			ttalent = {
				talent_id=npos(list),-- 天赋1id
				is_activited=npos(list),	-- 是否激活
			}
			usership.talents[r] = ttalent
		end
		
		usership.cart_describe=npos(list)--卡牌简介
		
		usership.ship_train_info = {
			train_life = npos(list),					-- 培养生命值 
			train_life_temp = npos(list),				-- 培养生命临时值 
			train_attack = npos(list),					-- 培养攻击值  
			train_attack_temp = npos(list),				-- 培养攻击临时值   
			train_physical_defence = npos(list),		-- 培养物防值    
			train_physical_defence_temp = npos(list),	-- 培养物防值临时值     
			train_skill_defence = npos(list),			-- 培养法防值    
			train_skill_defence_temp = npos(list),		-- 培养法防值临时值   
		}
		
		usership.ship_skillstren = {
			skill_level = npos(list), -- 天命等级 
			skill_value = npos(list), -- 天命值
		}
		--
		usership.awakenLevel = zstring.tonumber(npos(list)) -- 觉醒等级
		usership.awakenstates = npos(list) -- 觉醒状态 
		usership.ship_list = zstring.split(npos(list), ",") -- 拥有战船
		_ED.other_user_ship = usership
	else
		_ED.other_user_ship = _ED.other_user_ship or {}
		local count = tonumber(npos(list))
		for n=1,tonumber(count) do
			local ship_id_temp = npos(list)	
			local usership = _ED.other_user_ship[ship_id_temp] or {}
			usership.ship_id=ship_id_temp
			usership.ship_template_id=npos(list)						--战船模版ID
			usership.ship_base_template_id = dms.int(dms["ship_mould"],usership.ship_template_id,ship_mould.base_mould)
			usership.hero_fight=npos(list)								--英雄战斗力
			usership.ship_health=npos(list)							    --战船体力值 
			usership.key_ship_health = aeslua.encrypt("jar-world", usership.ship_health, aeslua.AES128, aeslua.ECBMODE)
			usership.ship_courage=npos(list)							--战船勇气值
			usership.attack_speed = npos(list)						    --攻速
			usership.gas_gather = npos(list)							--聚气
			usership.key_gas_gather = aeslua.encrypt("jar-world", usership.gas_gather, aeslua.AES128, aeslua.ECBMODE)
			usership.ship_quick = npos(list)							--物防
			usership.ship_intellect = npos(list)						--法防
			usership.hit = npos(list)								    --命中
			usership.dodge = npos(list)								    --闪躲
			usership.crit = npos(list)								    --暴击
			usership.toughness = npos(list)								--韧性
			usership.block = npos(list)								    --格挡
			usership.wreck = npos(list)								    --破击
			usership.add_damage = npos(list)							--加伤
			usership.lessen_damage = npos(list)							--减伤
			usership.deadly_strike_persent = tonumber(npos(list))/100		--必杀百分比
			usership.strong_persent = tonumber(npos(list))/100				--强韧百分比
			usership.by_cure_persent = tonumber(npos(list))/100				--疗效百分比
			usership.damage_add_persent = tonumber(npos(list))/100			--加伤百分比
			usership.damage_sub_persent = tonumber(npos(list))/100			--减伤百分比
			usership.final_damage_add_persent = tonumber(npos(list))/100	--伤害增加百分比
			usership.final_damage_sub_persent = tonumber(npos(list))/100	--伤害减少百分比

			usership.equipment = 
				{
					{user_equiment_id = npos(list)},
					{user_equiment_id = npos(list)},
					{user_equiment_id = npos(list)},
					{user_equiment_id = npos(list)},
					{user_equiment_id = npos(list)},
					{user_equiment_id = npos(list)},
				}
			usership.talent_state = npos(list)						--天赋激活状态
			usership.fetters_state = npos(list)							--羁绊激活状态
			usership.is_have_fetters = false
			local stars_state_str = npos(list)	
			local star_id_str = dms.string(dms["ship_mould"],usership.ship_template_id,ship_mould.star_id_tab)
			local stars_state_tab = zstring.split(stars_state_str,",")
			local star_id_tab = zstring.split(star_id_str,",")
			usership.stars_state = {						--当前星格点亮状态
				{star_id = star_id_tab[1],state = stars_state_tab[1]},
				{star_id = star_id_tab[2],state = stars_state_tab[2]},
				{star_id = star_id_tab[3],state = stars_state_tab[3]},
				{star_id = star_id_tab[4],state = stars_state_tab[4]},
				{star_id = star_id_tab[5],state = stars_state_tab[5]},
				{star_id = star_id_tab[6],state = stars_state_tab[6]},
			}
			usership.little_partner_formation_index = npos(list) --被绑定id
			usership.rider_horse_id = npos(list) --骑乘战马id
			usership.ship_level = npos(list)	 --英雄等级
			usership.skill_grow_up_states = zstring.split(npos(list),",")--英雄技能突破等级
			usership.god_weaponry = npos(list) --神兵
			usership.god_weaponry_task_id = npos(list) --神兵开启任务id
			usership.skill_grow_up_level = 0
			for i, v in pairs(usership.skill_grow_up_states) do
				if v == "1" then
					usership.skill_grow_up_level = i
				end
			end
			usership.talents = {}
			usership.relationship = {}
			usership.camp_preference = 0
			usership.capacity = 0
			usership.talent_count = 0
			local ship_mould_id = usership.ship_template_id
			local ship_data = dms.element(dms["ship_mould"], ship_mould_id)
			local captain_name = nil
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--进化形象
				local evo_image = dms.string(dms["ship_mould"], ship_mould_id, ship_mould.fitSkillTwo)
				local evo_info = zstring.split(evo_image, ",")
				--进化模板id
				local ship_evo = zstring.split(usership.evolution_status, "|")
				local evo_mould_id = evo_info[tonumber(ship_evo[1])]
				local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
				local word_info = dms.element(dms["word_mould"], name_mould_id)
				captain_name = word_info[3]
			else
				captain_name = dms.atos(ship_data,ship_mould.captain_name)
			end
			local ship_type = dms.atoi(ship_data,ship_mould.ship_type)
			local camp_preference = dms.atoi(ship_data,ship_mould.camp_preference)
			local capacity = dms.atoi(ship_data,ship_mould.capacity)
			local talent_str = dms.atos(ship_data,ship_mould.talent_id)
			local talent_tab = zstring.split(talent_str,"|")
			local talent_state_tab = zstring.split(usership.talent_state,",")
			for i,v in pairs(talent_tab) do
				local talent_id_tab = zstring.split(v,",")
				local talent_id_t = talent_id_tab[3]	
				usership.talents[i] = 
				{
					talent_id = talent_id_t,
					is_activited = talent_state_tab[i]
				}
			end

			usership.talent_count = #talent_tab
			local relationship_id_str = dms.atos(ship_data,ship_mould.relationship_id)
			local relationship_id_tab = zstring.split(relationship_id_str,",")
			local relationship_state_tab = zstring.split(usership.fetters_state,"|")
			-- print("===========fetters_state=====",usership.fetters_state)
			for j,k in pairs(relationship_id_tab) do
				usership.relationship[j] =  usership.relationship[j] or {}
				-- print("================",j,relationship_state_tab[j],relationship_id_str,k)
				if relationship_state_tab[j] ~= nil then
					local relationship_state =zstring.split(relationship_state_tab[j],",")
					usership.relationship[j].relationship_id = k
					usership.relationship[j].is_activited = {}

					for i,v in pairs(relationship_state) do
						if v ~= "" then
							usership.relationship[j].is_activited[i] = v
							if zstring.tonumber(v) > 0 then
								usership.is_have_fetters = true
							end
						end
					end
				end
			end
			usership.relationship_count = #relationship_id_tab
			usership.captain_name = captain_name
			usership.ship_type = ship_type
			usership.camp_preference = camp_preference
			usership.capacity = capacity
			usership.current_hp = usership.current_hp or 0

			_ED.other_user_ship[usership.ship_id] = usership
			_ED.other_user_ship[usership.ship_id].hero_fight = getShipFight(usership)
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_all_other_user_equip 14200 --返回其他用户装备信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_all_other_user_equip( interpreter,datas,pos,strDatas,list,count )
	local count = tonumber(npos(list))							--用户装备数量
	_ED.other_user_equiment = _ED.other_user_equiment or {}	
	for n=1,count do
		local equip_id = npos(list)
		local equipment_mould_id = npos(list)
		local equip_data = dms.element(dms["equipment_mould"],equipment_mould_id)
		local equipment_name = dms.atos(equip_data,equipment_mould.equipment_name)
		local silver_price = dms.atoi(equip_data,equipment_mould.silver_price)
		local influence_type = dms.atoi(equip_data,equipment_mould.influence_type)
		local equip_type = dms.atoi(equip_data,equipment_mould.equipment_type)
		local growup_value_data = dms.atos(equip_data,equipment_mould.grow_value) 
		local equip_quality = dms.atoi(equip_data,equipment_mould.grow_level)
		local userequiment ={
			user_equiment_id=equip_id,						--用户装备ID号
			user_equiment_template=equipment_mould_id,					--用户装备模版ID号
			user_equiment_name=equipment_name,						--用户装备名称
			sell_price=silver_price,								--出售价格
			user_equiment_influence_type=influence_type,			--用户装备影响类型
			equipment_type=equip_type,							--装备类型
			ship_id = npos(list),								--绑定战船id
			user_equiment_ability=npos(list),					--用户装备能力值
			user_equiment_grade=npos(list),					--用户装备等级
			growup_value=growup_value_data,								--成长值
			quality = equip_quality,
			jewelrys = 
			{
				npos(list),     -- -1 没解锁  0 解锁了 未穿戴  1 穿戴了
				npos(list),
				npos(list),
				npos(list),
				npos(list),
				npos(list)	
			},
			rela_state = npos(list),   -- 0 没有， 1 shipid
			equip_fight = npos(list)
		}
		_ED.other_user_equiment[""..userequiment.user_equiment_id] = userequiment
		_ED.other_user_equiment[""..userequiment.user_equiment_id].equip_fight = 	getEquipmentFight(userequiment,1)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_equip_clear_info 14201 --返回装备洗练信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_equip_clear_info( interpreter,datas,pos,strDatas,list, count )
	_ED.user_equiment_clear_info = _ED.user_equiment_clear_info or {}
	local equipment_clear_info = {}
	equipment_clear_info.equipment_id = npos(list)
	equipment_clear_info.equipment_mould_id = npos(list)
	equipment_clear_info.first_clear_attr = {}
	equipment_clear_info.last_clear_attr = {}
	local frist_info = npos(list)
	if frist_info ~= "-1" then
		equipment_clear_info.first_clear_attr = zstring.split(frist_info, ",")
	end
	local last_info = npos(list)
	if last_info ~= "-1" then
		equipment_clear_info.last_clear_attr = zstring.split(last_info, ",")
	end
	_ED.user_equiment_clear_info[""..equipment_clear_info.equipment_id] = equipment_clear_info
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_all_equip_clear_info 14202 --返回初始化装备洗练信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_all_equip_clear_info( interpreter,datas,pos,strDatas,list, count )
	_ED.user_equiment_clear_info = _ED.user_equiment_clear_info or {}
	local count = npos(list)
	for i=1,tonumber(count) do
		parse_return_user_equip_clear_info(interpreter,datas,pos,strDatas,list, count)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_equipment_strength_result 14203 --返回装备强化结果信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_equipment_strength_result( interpreter,datas,pos,strDatas,list, count )
	_ED.equip_strength_result = {}
	local count = npos(list) 
	for i=1,tonumber(count) do
		local info = {}
		info.result = zstring.tonumber(npos(list))
		if info.result == 0 then 		-- 强化成功
			info.equip_id = npos(list) 	-- 装备实例id
			info.equipment_mould_id = npos(list) 	-- 模板id
			info.is_equiped = npos(list)  -- 是否穿戴
			info.attr = npos(list) 		-- 属性值
			info.upgrade_level = npos(list) -- 强化等级
			info.rank_up_level = npos(list) -- 改造等级
			info.strength = npos(list) 	-- 强度
			info.formation_type = tonumber(npos(list)) 
			info.experience = tonumber(npos(list))
		end
		table.insert(_ED.equip_strength_result, info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_armor_info 14204 --返回装甲基础信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_armor_info( interpreter,datas,pos,strDatas,list,count )
	_ED.user_armor_info = {}

	_ED.user_armor_info.armor_capacity = npos(list)					                -- 仓库容量
	_ED.user_armor_info.enlarge_count = npos(list) 										-- 已经扩容次数
	_ED.user_armor_info.free_times_info = {}
	for i = 1, 3 do
		local info = {}
		info.free_end_time = math.floor(tonumber(npos(list)) / 1000) 			-- 免费生产结束时间
		info.free_times = npos(list)				-- 免费生产次数
		if i == 3 then
			info.need_times = npos(list)			-- 高级生产剩余必得紫色装甲次数
		end
		_ED.user_armor_info.free_times_info[""..i] = info
	end
	state_machine.excute("home_map_update_prodcution_state", 0, {54})
	state_machine.excute("notification_center_update", 0, "push_notification_armor_production")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_armor_pve_info 14205 --返回装甲副本信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_armor_pve_info( interpreter,datas,pos,strDatas,list,count )
	_ED.armor_pve_attack_times = npos(list) 		-- 装甲副本攻打次数
	_ED.armor_pve_buy_times = npos(list) 			-- 装甲副本已购买次数

	state_machine.excute("notification_center_update", 0, "push_notification_home_button_pve")
	state_machine.excute("notification_center_update", 0, "push_notification_pve_armor")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_new_equip_batch_add 14206 --返回新的装备批量增加
-- ---------------------------------------------------------------------------------------------------------
function parse_return_new_equip_batch_add( interpreter,datas,pos,strDatas,list,count )
	local number = tonumber(npos(list))
	for i=1,number do
		local instanceId = npos(list)					--用户装备ID号
		-- local currentAccount = _ED.user_platform[_ED.default_user].platform_account
		-- local currentServerNumber = _ED.all_servers[_ED.selected_server].server_number
		-- local newEquipTag = currentAccount..currentServerNumber.."newEquip"
		-- local newEquip = cc.UserDefault:getInstance():getStringForKey(newEquipTag)
		-- if newEquip == "" then 
		-- 	newEquip = instanceId
		-- else
		-- 	newEquip = newEquip .. "!" .. instanceId
		-- end
		-- cc.UserDefault:getInstance():setStringForKey(newEquipTag, newEquip)
		local equipItme = {
			user_equiment_id=instanceId,						--用户装备ID号
			user_equiment_template=npos(list),					--用户装备模版ID号
			user_equiment_name=npos(list),						--用户装备名称
			sell_price=npos(list),								--出售价格
			user_equiment_influence_type=npos(list),			--用户装备影响类型
			equipment_type=npos(list),							--装备类型
			user_equiment_ability=npos(list),					--用户装备能力值
			user_equiment_grade=npos(list),					--用户装备等级
			user_equiment_exprience=npos(list),					--用户装备经验
			user_equiment_growup_grade=npos(list),				--用户装备成长等级
			growup_value=npos(list),								--成长值
			adorn_need_ship=npos(list),								--佩戴所需战船等级
			equiment_picture=npos(list),							--装备图片标识
			equiment_track_remark=npos(list),					--追踪备注
			equiment_track_scene=npos(list),						--追踪场景
			equiment_track_npc=npos(list),						--追踪NPC
			equiment_track_npc_index=npos(list),				--追踪NPC下标
			equiment_refine_level = npos(list),				--精炼等级
			equiment_refine_param = npos(list),				--精炼属性
			refining_times = npos(list),				--洗练次数
			refining_value_life = npos(list),			--int		洗练生命值
			refining_value_temp_life = npos(list),		--int		洗练生命临时值
			refining_value_attack = npos(list),				--int		洗练攻击值
			refining_value_temp_attack = npos(list),			--int		洗练攻击临时值
			refining_value_physical_defence = npos(list),			--int		洗练物防值
			refining_value_temp_physical_defence = npos(list),	--int		洗练物防临时值
			refining_value_skill_defence = npos(list),			--int		洗练法防值
			refining_value_temp_skill_defence = npos(list),			--int		洗练法防临时值
			refining_value_final_damange = npos(list),			--int		洗练终伤值
			refining_value_temp_final_damange = npos(list),			--int		洗练终伤临时值
			refining_value_final_lessen_damange = npos(list),		--	int		洗练终减伤值
			refining_value_temp_final_lessen_damange = npos(list),			--int		洗练终减伤临时值
			
			ship_id = "0",
		}
		if equipItme.user_equiment_name ~= nil and equipItme.user_equiment_name ~= "" then
			local splitEquipmentName = zstring.split(equipItme.user_equiment_name, "|")
			if splitEquipmentName ~= nil and table.getn(splitEquipmentName) > 1 and splitEquipmentName[_ED.user_info.user_gender] ~= nil then
				equipItme.user_equiment_name = splitEquipmentName[_ED.user_info.user_gender]
			end
		end
		equipItme.grow_level = dms.int(dms["equipment_mould"], equipItme.user_equiment_template, equipment_mould.grow_level)
		--升星属性
		if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto 
			or __lua_project_id == __lua_project_warship_girl_b 
			or __lua_project_id == __lua_project_yugioh
			or __lua_project_id == __lua_project_pokemon 
			or __lua_project_id == __lua_project_rouge
			or __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			then 
			equipItme.current_star_level = npos(list)
			equipItme.current_star_exp = npos(list)
			equipItme.add_attribute = npos(list)
			equipItme.luck_value = zstring.tonumber(npos(list))
		end
		_ED.user_equiment[instanceId] = equipItme	
		_ED.new_equip_get = instanceId
		-- jttd.equipNumericalInfo(equip_numerical_info_params.acquire,instanceId,1)
		-- deliver_trim_equip_action_info(list[2], instanceId, 1, true)
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			--招募到的装备会记录在这，每次进来前数组是会被清空的
			if _ED.prop_chest_store_recruiting == true then
				local obtainSilver = {}
				obtainSilver.number = 1
				obtainSilver.mould_id = instanceId
				obtainSilver.m_type = 7
				table.insert(_ED.new_reward_object, obtainSilver)
			else
				_ED.new_reward_object = {}
			end
		end
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			--武将强化推送
			for i,v in pairs(_ED.user_ship) do
				toViewShipPushData(v.ship_id,false,7,_ED.user_equiment[instanceId].user_equiment_template)
			end
		end
	end
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		state_machine.excute("hero_list_view_update_cell_equip_button_push",0,"hero_list_view_update_cell_equip_button_push.")
       	state_machine.excute("notification_center_update",0,"push_notification_center_ship_warehouse_all")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_home_hero_icon")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_duplicate_formation")
       	state_machine.excute("formation_update_equip_icon_push",0,"formation_update_equip_icon_push.")
	end
end



-- ---------------------------------------------------------------------------------------------------------
-- parse_get_socket_service_url 14300 --返回socket service URL
-- ---------------------------------------------------------------------------------------------------------
function parse_get_socket_service_url( interpreter,datas,pos,strDatas,list, count )
	local url = npos(list)
	local info = zstring.split(url, ":")
    local urlinfo = zstring.split(info[1], "|")

    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        url = urlinfo[1] .. ":" .. info[2]
    else
        if #urlinfo > 1 then
            url = urlinfo[2] .. ":" .. info[2]
        else
            url = urlinfo[1] .. ":" .. info[2]
        end
    end

	NetworkAdaptor.LuaSocket.url = url
	-- NetworkAdaptor.socketInit(url)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_init_user_socket_service 14301 --返回长连成功信息
-- ---------------------------------------------------------------------------------------------------------
function parse_init_user_socket_service( interpreter,datas,pos,strDatas,list, count )
	state_machine.excute("connecting_view_window_close", 0, 0)
	NetworkAdaptor.LuaSocket.reconnect = false
	_ED.world_map = nil
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_reconnect_socket 14302 --断线重新连接网络
-- ---------------------------------------------------------------------------------------------------------
function parse_reconnect_socket( interpreter,datas,pos,strDatas,list, count )
	NetworkAdaptor:restartSocket()
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_shop_info 15000 --返回parse_shop_info
-- ---------------------------------------------------------------------------------------------------------
function parse_shop_info( interpreter,datas,pos,strDatas,list, count )
	_ED.all_shop_info = _ED.all_shop_info or {}
	local total_count = npos(list)
	for i=1, tonumber(total_count) do
		local returnProp = {
			shop_type = npos(list),					--商店类型
			goods_type = npos(list),				--物品类型
			goods_id = npos(list),					--道具模版ID号
			sell_tag = npos(list),					--出售标签(0正常 1打折 2限量 3 超值)
			goods_case_id = npos(list),			--商店道具实例
			sell_type = npos(list),					--出售类型(0:宝石 1:精铁 2:徽章 3:贝里)
			buy_times = npos(list),					--已购买次数 
			VIP_buy_times = npos(list),				--vip对应购买次数
			price_increase = npos(list),			--价格递增参数 
			sell_price = npos(list),				--原价
			original_cost = npos(list),					--折后价
			sell_percentage = npos(list),				--打折率
			sell_count = npos(list),					--叠加数量
			entire_purchase_count_limit = npos(list),	--限定购买次数
			open_info = npos(list)	--开启条件 (0,1     1,1) 0 玩家等级  1 公会商店等级 2 vip等级 
		}

		if tonumber(returnProp.goods_type) == 0 then
			local propData = dms.element(dms["prop_mould"], returnProp.goods_id)
			-- assert(propData ~= nil, "15000 propData can't no-nil, id = "..returnProp.goods_id)
			returnProp.mould_name = dms.atos(propData, prop_mould.prop_name)
			returnProp.mould_remarks = dms.atos(propData, prop_mould.remarks)
			returnProp.prop_quality = dms.atoi(propData, prop_mould.prop_quality)
			returnProp.pic_index = dms.atoi(propData, prop_mould.pic_index)
			returnProp.VIP_can_buy = dms.atoi(propData, prop_mould.sell_of_vip_level) > 0
			returnProp.remain_times = returnProp.entire_purchase_count_limit - zstring.tonumber(_ED.shop_buy_count[""..returnProp.goods_case_id])
			returnProp.recommend = false
		elseif tonumber(returnProp.goods_type) == 1 then  --- 装备
			local equipmentData = dms.element(dms["equipment_mould"], returnProp.goods_id)
			returnProp.mould_name = dms.atos(equipmentData, equipment_mould.equipment_name)
			returnProp.mould_remarks = ""--dms.atos(equipmentData, equipment_mould.remarks)
			returnProp.prop_quality = dms.atoi(equipmentData, equipment_mould.grow_level)
			returnProp.pic_index = dms.atoi(equipmentData, equipment_mould.pic_index)
			returnProp.VIP_can_buy = false--dms.atoi(equipmentData, equipment_mould.sell_of_vip_level) > 0
			returnProp.remain_times = returnProp.entire_purchase_count_limit - zstring.tonumber(_ED.shop_buy_count[""..returnProp.goods_case_id])
			returnProp.recommend = false
		elseif tonumber(returnProp.goods_type) == 6 then 	-- 马魂
			local horseSpiritData = dms.element(dms["horse_spirit_mould"], returnProp.goods_id)
			returnProp.mould_name = dms.atos(horseSpiritData, horse_spirit_mould.horse_spirit_name)
			returnProp.mould_remarks = dms.atos(horseSpiritData, horse_spirit_mould.desc)
			returnProp.prop_quality = dms.atoi(horseSpiritData, horse_spirit_mould.quality)
			returnProp.pic_index = dms.atoi(horseSpiritData, horse_spirit_mould.icon)
			returnProp.VIP_can_buy = false--dms.atoi(horseSpiritData, equipment_mould.sell_of_vip_level) > 0
			returnProp.remain_times = returnProp.entire_purchase_count_limit - zstring.tonumber(_ED.shop_buy_count[""..returnProp.goods_case_id])
			returnProp.recommend = false
		elseif tonumber(returnProp.goods_type) == 7 then 	-- 马魂碎片
			returnProp.mould_name = _All_tip_string_info._horse
			returnProp.mould_remarks = _All_tip_string_info_description._horseSoulDescription
			returnProp.prop_quality = 4
			returnProp.pic_index = 4021
			returnProp.VIP_can_buy = false
			returnProp.remain_times = returnProp.entire_purchase_count_limit - zstring.tonumber(_ED.shop_buy_count[""..returnProp.goods_case_id])
			returnProp.recommend = false
		elseif tonumber(returnProp.goods_type) == 8 then 	-- 龙马碎片
			returnProp.mould_name = _All_tip_string_info._horse_spirit
			returnProp.mould_remarks = _All_tip_string_info_description._horseDescription
			returnProp.prop_quality = 4
			returnProp.pic_index = 4021
			returnProp.VIP_can_buy = false
			returnProp.remain_times = returnProp.entire_purchase_count_limit - zstring.tonumber(_ED.shop_buy_count[""..returnProp.goods_case_id])
			returnProp.recommend = false
		end

		_ED.all_shop_info[returnProp.shop_type] = _ED.all_shop_info[returnProp.shop_type] or {}
		local isChange = false
		for k,v in pairs(_ED.all_shop_info[returnProp.shop_type]) do
			if tonumber(v.goods_case_id) == tonumber(returnProp.goods_case_id) then
				_ED.all_shop_info[returnProp.shop_type][k] = returnProp
				isChange = true
			end
		end
		if isChange == false then
			table.insert(_ED.all_shop_info[returnProp.shop_type], returnProp)
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_shop_frags_info 15001 --返回碎片兑换商店信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_shop_frags_info( interpreter,datas,pos,strDatas,list, count )
	_ED.shop_frags_info = {}
	_ED.shop_frags_info.last_refresh_time = tonumber(npos(list)) / 1000

	_ED.shop_frags_info.shop_list = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.good_id = tonumber(npos(list))
		info.buy_times = tonumber(npos(list))
		info.good_index = dms.int(dms["avatar_shop"], info.good_id, avatar_shop.good_index)
		info.max_buy_times = dms.int(dms["avatar_shop"], info.good_id, avatar_shop.max_buy_times)
		table.insert(_ED.shop_frags_info.shop_list, info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_secret_shop_info 15002 --返回神秘商店信息
-- ---------------------------------------------------------------------------------------------------------
function parse_secret_shop_info( interpreter,datas,pos,strDatas,list, count )
	_ED.secret_shop_info = {
		refresh_count = tonumber(npos(list)),	-- 已刷新次数
		end_time = _ED.system_time + tonumber(npos(list)) / 1000,		-- 剩余关闭时间
		items = zstring.splits(npos(list), "|", ","),						-- 商品信息(商店商品id,已购买次数|商店商品id,已购买次数|....)
	}
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_secret_shop_open_event 15003 --返回神秘商店出现
-- ---------------------------------------------------------------------------------------------------------
function parse_secret_shop_open_event( interpreter,datas,pos,strDatas,list, count )
	_ED.secret_shop_open = true

	-- app.load("client.shop.SecretShopOpenTip")
	-- state_machine.excute("secret_shop_open_tip_window_open", 0, 0)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_list 14600 --返回工会列表
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_list(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_list_sum = npos(list)			--公会数量
	_ED.union.union_list_info = _ED.union.union_list_info or {}
	local length = #_ED.union.union_list_info
	for n= 1 ,tonumber(_ED.union.union_list_sum) do
		local info={
			union_rank = npos(list), -- 排名
			union_id = npos(list),	-- 公会id
			union_name = npos(list),	--公会名称 
			union_level = npos(list),	--等级 
			union_president_name = npos(list), -- 会长名称
			union_member = npos(list),	--成员数 
			union_watchword = zstring.exchangeFrom(npos(list)),	--公告
			union_camp = npos(list),	--工会阵营
			union_appiy = npos(list),	--申请状态 
		}
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			info.need_verify = npos(list)		    -- 是否需要验证(0:不需要 1:需要)
			info.need_level = npos(list)		    -- 加入等级
			info.need_combat_force = npos(list)		-- 加入战力
			info.union_fight = npos(list)	-- 战力
		end
		_ED.union.union_list_info[length+n] = info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_rank 14601 --返回工会排行
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_rank(interpreter,datas,pos,strDatas,list,count)
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		local union_type = tonumber(npos(list))
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			_ED.my_union_id = npos(list)			--公会id
			if tonumber(_ED.my_union_id) > 0 then
				_ED.my_union_rank = npos(list)			--公会排名
				_ED.my_union_iocn = npos(list)			--公会图标
				_ED.my_union_level = npos(list)			--公会等级
				_ED.my_union_name = npos(list)			--公会名称
				_ED.my_union_chairman = npos(list)		--会长名称
				_ED.my_union_fight = npos(list)			--公会战力
			end
		end
		
		_ED.union.rank_union_list_page_count = npos(list)	-- 数量
		_ED.union.rank_union_list_info = _ED.union.rank_union_list_info or {}
		_ED.union.rank_union_level_list = _ED.union.rank_union_level_list or {}
		_ED.union.rank_union_con_list = _ED.union.rank_union_con_list or {}
		_ED.activity_legion_all_contribute = _ED.activity_legion_all_contribute or {}
		if union_type == 0 then
			_ED.union.rank_union_list_info = {}
		elseif union_type == 1 then
			_ED.union.rank_union_level_list = {}
		elseif union_type == 11 then
			_ED.activity_legion_all_contribute = {}
		else
			_ED.union.rank_union_con_list = {}
		end
		for n = 1 ,tonumber(_ED.union.rank_union_list_page_count) do
			local info={
				union_rank = npos(list), -- 排名
				union_last_rank = npos(list), -- 上次排名
				union_id = npos(list),	--公会id
				union_name = npos(list),	--公会名称 
				union_level = npos(list),	--等级 
				union_contribution = npos(list),	--贡献
				union_camp = npos(list),	--工会阵营

				union_president_name = npos(list), -- 会长名称
				union_member = npos(list),	   --成员数 
				union_build_number = npos(list),		--领地数
				watchword = npos(list),			--宣言
			}
			if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				info.need_verify = npos(list)		    -- 是否需要验证(0:不需要 1:需要)
				info.need_level = npos(list)		    -- 加入等级
				info.need_combat_force = npos(list)		-- 加入战力
				info.union_fight = npos(list)	-- 战力
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					info.nuion_icon = npos(list)	-- 公会图标
					info.union_science_num = npos(list) -- 工会研究院增加人数
				end
			end
			if union_type == 0 then
				_ED.union.rank_union_list_info[n] = info
			elseif union_type == 1 then
				_ED.union.rank_union_level_list[n] = info
			elseif union_type == 11 then
				_ED.activity_legion_all_contribute[n] = info
			else
				_ED.union.rank_union_con_list[n] = info
			end
		end
	else
		_ED.union.rank_union_list_page_count = npos(list)	-- 数量
		_ED.union.rank_union_list_info = {}
		for n = 1 ,tonumber(_ED.union.rank_union_list_page_count) do
			local info={
				union_rank = npos(list), -- 排名
				union_last_rank = npos(list), -- 上次排名
				union_id = npos(list),	--公会id
				union_name = npos(list),	--公会名称 
				union_level = npos(list),	--等级 
				union_contribution = npos(list),	--贡献
				union_camp = npos(list),	--工会阵营

				union_president_name = npos(list), -- 会长名称
				union_member = npos(list),	   --成员数 
				union_build_number = npos(list),		--领地数
				watchword = npos(list),			--宣言
			}
			_ED.union.rank_union_list_info[n] = info
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_user_union 14602 --返回用户工会信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_user_union(interpreter,datas,pos,strDatas,list,count)
	if _ED.union.user_union_info == nil then
		_ED.union.user_union_info = {}
	end
	_ED.union.user_union_info.union_id = npos(list)	--工会id
	_ED.union.user_union_info.union_post = npos(list)	--职务：1:公会会长2:副会长3:普通成员
	_ED.union.user_union_info.rest_contribution = npos(list)	--剩余贡献--个人
	_ED.union.user_union_info.build_count = npos(list)		--祭天状态
	_ED.union.user_union_info.build_type = npos(list)		--祭天类型

	_ED.union.user_union_info.team_fight_floor = npos(list)		--组队争霸层数
	_ED.union.user_union_info.team_fight_team_ids = npos(list)	--组队争霸参加队伍id
	_ED.union.user_union_info.team_fight_use_ships = npos(list) --组队争霸使用过的战船

	_ED.union.user_union_info.getPhysical_fight_npc = npos(list)	--阿拉希之战npc

	_ED.union.user_union_info.team_fight_use_state = npos(list)	--组队争霸是否参加的状态

	_ED.union.user_union_info.union_city_reward_info = npos(list)	--奖励城池id

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		_ED.union.user_union_info.play_formation_info = npos(list) 		-- 军团切磋阵容信息
		_ED.union.user_union_info.shop_library_exchange = npos(list) 		-- 珍品道具兑换状态
		_ED.union.user_union_info.formation_capactity = npos(list) 		-- 军团切磋阵容战力
		_ED.union.user_union_info.weak_activity_con = npos(list) 		-- 周活动贡献
		_ED.union.user_union_info.weak_activity_join_times = npos(list) -- 周活动参与次数
	end

	if zstring.tonumber(_ED.union.user_union_info.union_id) == 0 then
        -- TipDlg.drawTextDailog(tipStringInfo_union_str[52])
        state_machine.excute("legion_clean_all_data", 0, "")
		state_machine.excute("union_the_meeting_place_clean_all_data", 0, "")
	else
		state_machine.excute("legion_infomation_update_draw", 0, nil)
		state_machine.excute("home_map_change_home_build_legion_info", 0, nil)
		state_machine.excute("main_window_update_top_button", 0, "")
	end

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_center_legion_apply")
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_info 14603 --返回工会信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_info = {
		union_id   = zstring.tonumber(npos(list)),   --军团id
		union_grade = zstring.tonumber(npos(list)),  -- 军团等级
		union_name = zstring.exchangeFrom(npos(list)),	--公会名称
		bulletin = zstring.exchangeFrom(npos(list)),	--公告
		watchword = zstring.exchangeFrom(npos(list)),	--宣言
		union_worship = npos(list),				--祭天进度 --经验
		union_contribution = npos(list),		--公会贡献度
		members = npos(list),				    --当前成员数
		union_camp = npos(list),				--工会阵营
	}
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		_ED.union.union_info.union_head_name = npos(list) 	    -- 团长名字
		_ED.union.union_info.combat_force = npos(list)		    -- 总战力
		_ED.union.union_info.ranking = npos(list) 			    -- 排名
		_ED.union.union_info.need_verify = npos(list)		    -- 是否需要验证(0:不需要 1:需要)
		_ED.union.union_info.need_level = npos(list)		    -- 加入等级
		_ED.union.union_info.need_combat_force = npos(list)		-- 加入战力
		state_machine.excute("legion_infomation_update_draw", 0, nil)
		state_machine.excute("main_window_update_push",0,1000)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_member_info 14604 --返回工会成员信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_member_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_member_list_sum = tonumber(npos(list))
	_ED.union.union_member_list_info = {}
	for n= 1, tonumber(_ED.union.union_member_list_sum) do
		local info={}
		info={
			id = npos(list),		--成员ID  
			level = npos(list),		--等级 
			post = tonumber(npos(list)),		--职务 
			name = npos(list),		--名称 
			capactity = npos(list),	--战力 
			user_sex = npos(list),	--性别
			-- TODO...
			user_head_id = npos(list),	--头像
			offline_time = npos(list),	--离线时间 
			gold_card = npos(list),	-- 金卡开启状态
			diamond_card = npos(list),	-- 钻卡开启状态
			is_online = tonumber(npos(list)) == 1,	--是否在线
		}
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			info.vip_level = tonumber(npos(list))	        -- VIP等级
			info.have_devote = npos(list)	    -- 贡献
			info.week_devote = npos(list)	    -- 周贡献
			info.industry_level = npos(list)	-- 军衔等级
			info.play_formation_info = npos(list) 	-- 军团切磋阵容信息
			info.daily_active = npos(list) 		-- 日活跃
			info.formation_capactity = npos(list) 	-- 成员切磋阵容战力
			info.weak_activity_con = npos(list) 		-- 周活动贡献
			info.weak_activity_join_times = npos(list) -- 周活动参与次数
		end
		_ED.union.union_member_list_info[n] = info
	end
end		

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_apply_list 14605 --返回工会申请列表
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_apply_list(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_examine_list_sum = npos(list)
	_ED.union.union_examine_list_info = {}
	for n = 1 ,tonumber(_ED.union.union_examine_list_sum) do
		local info={
			id = npos(list),		--成员ID  
			name = npos(list),		--名称 
			level = npos(list),		--等级 
			user_sex = npos(list),	--性别
			-- TODO...
			user_head_id = npos(list),	--头像
			capactity = npos(list),	--战力 
			applyTime = npos(list),	--申请时间
			-- join_state = npos(list),	--加入状态
			vip_level = 0, -- npos(list),	-- VIP等级
		}
		_ED.union.union_examine_list_info[n] = info
	end
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("legion_application_confirmation_update_draw", 0, "")
		state_machine.excute("notification_center_update", 0, "push_notification_center_legion_apply")
		state_machine.excute("home_map_update_prodcution_state", 0, {2})
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_message_info 14606 --返回工会动态信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_message_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_message_info_list = {}
	_ED.union.union_welfare_info_list = {}
	_ED.union.union_reward_info_list = {}
	_ED.union.union_message_number = 0
	_ED.union.union_welfare_number = 0
	_ED.union.union_reward_number = 0
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {
			ntype = npos(list),		--类型
			name = npos(list),	    --名称
			time = npos(list),	    --时间
			param = npos(list),	    --参数
		}
		local name_info = zstring.split(info.name,"_")
		if #name_info > 1 and tonumber(name_info[2]) ~= nil then
			info.name = name_info[1]
			info.post_1 = tonumber(name_info[2])
		end
		local param_info = zstring.split(info.param,",")
		local name_info_2 = zstring.split(param_info[1],"_")
		if #name_info_2 > 1 and tonumber(name_info_2[2]) ~= nil then
			info.post_2 = tonumber(name_info_2[2])
			param_info[1] = name_info_2[1]
		end
		info.param = zstring.concat(param_info, ",")

		if tonumber(info.ntype) < 20 or tonumber(info.ntype) >= 40 then
			_ED.union.union_message_number = _ED.union.union_message_number + 1
			table.insert(_ED.union.union_message_info_list, info)
		elseif tonumber(info.ntype) >= 30 then
			_ED.union.union_reward_number = _ED.union.union_reward_number + 1
			table.insert(_ED.union.union_reward_info_list, info)
		else
			_ED.union.union_welfare_number = _ED.union.union_welfare_number + 1
			table.insert(_ED.union.union_welfare_info_list, info)
		end
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_team_fight_info 14607 --返回组队争霸信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_team_fight_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_team_fight_ship_info = {}
	_ED.union.union_team_fight_info_list = {}
	_ED.union.union_team_fight_number = npos(list)
	for i = 1, zstring.tonumber(_ED.union.union_team_fight_number) do
		local team_info = {}
		local team_id = npos(list)	       --队伍id
		local member_nums = npos(list)	   --成员数量
		team_info.member_info = {}
		for j=1, tonumber(member_nums) do
			local info = {
				id = npos(list),
				ship_id = npos(list),
				ship_mould_id = npos(list),
				level = npos(list),
				sex = npos(list),
				-- TODO...
				user_head_id = npos(list),
				name = npos(list),
			}
			table.insert(team_info.member_info, info)
		end
		team_info.team_id = team_id
		team_info.member_nums = member_nums
		table.insert(_ED.union.union_team_fight_info_list, team_info)
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_team_fight_ship_info 14101 --返回组队争霸战斗战船信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_team_fight_ship_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_team_fight_ship_info = _ED.union.union_team_fight_ship_info or {}
	_ED.union.union_team_fight_ship_counts = npos(list)
	for n=1,tonumber(_ED.union.union_team_fight_ship_counts) do
		local ship_id_temp = npos(list)
		local usership = _ED.union.union_team_fight_ship_info[ship_id_temp] or {}
		usership.ship_id = ship_id_temp
		parse_read_all_ship_info(list, usership)
		usership.hero_fight = getShipFight(usership)
		usership.isUnionPartner = true
		_ED.union.union_team_fight_ship_info[usership.ship_id] = usership
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_time_ship_count_change 14103 --返回坦克数量减少信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_time_ship_count_change(interpreter,datas,pos,strDatas,list,count)
	local count = tonumber(npos(list))
	for i=1, count do
		local id = npos(list)
		local usership = _ED.user_ship[id] or {}
		usership.ship_count = npos(list) --战船总数量
		usership.lose_ship_count = npos(list) --战船战损数量
		usership.battle_ship_count = npos(list) --战船出征的数量
		usership.expedition_lose_count = npos(list) -- 远征损失的数量
		usership.current_count = zstring.tonumber(usership.ship_count) - zstring.tonumber(usership.lose_ship_count) - zstring.tonumber(usership.battle_ship_count)
		if usership.current_count < 0 then
			usership.current_count = 0
		end
		usership.city_ship_count = npos(list) 		-- 拥有的城市战部队数量
		usership.city_battle_ship_count = npos(list) 		-- 出征的城市战部队数量
		usership.city_current_count = zstring.tonumber(usership.city_ship_count) - zstring.tonumber(usership.city_battle_ship_count)
		if usership.city_current_count < 0 then
			usership.city_current_count = 0
		end
	end
	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("home_map_update_tanke_info", 0, "")
		state_machine.excute("formation_repair_update_info",0,0)
		state_machine.excute("notification_center_update", 0, "push_notification_home_button_formation")
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_seq_user_ship_evolution_status_info 14104 --返回玩家英雄进化信息
-- ---------------------------------------------------------------------------------------------------------
function parse_seq_user_ship_evolution_status_info(interpreter,datas,pos,strDatas,list,count)
	local ship_id = npos(list)					--武将ID
	local evolution_status = npos(list)			--进化状态
	_ED.user_ship[ship_id].evolution_status = evolution_status
	local Order = npos(list)			--品阶
	_ED.user_ship[ship_id].Order = Order
	local StarRating = npos(list)			--星级
	local old_StarRating = _ED.user_ship[ship_id].StarRating
	_ED.user_ship[ship_id].StarRating = StarRating
	local skillLevel = npos(list)			--技能等级(1,2,1,0,0,0)
	_ED.user_ship[ship_id].skillLevel = skillLevel
	local equipInfo = npos(list)			--装备信息（武将装备的等级,2,3,4,5,6|品级,2,3,4,5,6|经验,2,3,4,5,6|星级,2,3,4,5,6）
	_ED.user_ship[ship_id].equipInfo = equipInfo
	
	getUserSpeedSum()
	if _ED.push_user_ship_info ~= nil and _ED.push_user_ship_info[""..ship_id] == nil then
		setShipPushData(ship_id,0,-1)
	end

	if _ED.push_user_ship_info ~= nil and _ED.push_user_ship_info[""..ship_id] ~= nil then
		toViewShipPushData(ship_id,true,14,-1)
		toViewShipPushData(ship_id,true,15,-1)
	end
	if _ED.push_user_ship_info ~= nil and _ED.push_user_ship_info[""..ship_id] ~= nil then
		if zstring.tonumber(old_StarRating) < zstring.tonumber(StarRating) then
			toViewShipPushData(ship_id,false,4,-1)
		end
	end
	--state_machine.excute("notification_center_update",0,"push_notification_center_formation_replacement_equipment")
	state_machine.excute("sm_equipment_qianghua_update_equip_icon_push",0,"sm_equipment_qianghua_update_equip_icon_push.")
	state_machine.excute("notification_center_update",0,"push_notification_center_formation_equipment_awakening_page_tips")
	state_machine.excute("notification_center_update",0,"push_notification_center_formation_equipment_up_grade_page_tips")
	state_machine.excute("notification_center_update",0,"push_notification_center_formation_equipment_awakening")
	--state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_equip_strength_icon")
	-- state_machine.excute("sm_equipment_qianghua_update_hero_icon_push",0,"sm_equipment_qianghua_update_hero_icon_push.")
	-- setHeroDevelopAllShipPushState(1)
	
	state_machine.excute("hero_list_view_update_cell_strength_button_push",0,"hero_list_view_update_cell_strength_button_push.")
	state_machine.excute("hero_list_view_update_cell_equip_button_push",0,"hero_list_view_update_cell_equip_button_push.")
   	state_machine.excute("notification_center_update",0,"push_notification_center_ship_warehouse_all")
   	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_home_hero_icon")
   	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_duplicate_formation")

   	--state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_ship_strength_icon")
   	-- state_machine.excute("hero_develop_page_updata_hero_icon_push",0,"hero_develop_page_updata_hero_icon_push.")
   	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_evolution_page_tip")
   	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_up_grade_star_page_tip")
   	state_machine.excute("notification_center_update",0,"push_notification_center_hero_strength_evolution_button")
   	state_machine.excute("notification_center_update",0,"push_notification_center_hero_strength_up_grade_button")
   	state_machine.excute("sm_equipment_qianghua_update_hero_icon_push",0,"sm_equipment_qianghua_update_hero_icon_push.")
    state_machine.excute("hero_develop_page_updata_hero_icon_push",0,"hero_develop_page_updata_hero_icon_push.")
    state_machine.excute("hero_icon_listview_icon_push_updata",0,"hero_icon_listview_icon_push_updata.")
    state_machine.excute("notification_center_update",0,"push_notification_center_formation_ship_evo")
	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_ship_evo")
	state_machine.excute("notification_center_update",0,"push_notification_center_formation_ship_formation")
    state_machine.excute("notification_center_update",0,"push_notification_center_formation_equip_upgrade")
    state_machine.excute("notification_center_update",0,"push_notification_center_formation_equip_awake")
    state_machine.excute("formation_update_equip_icon_push",0,"formation_update_equip_icon_push.")
    if fwin:find("HeroStorageClass") ~= nil then
    	state_machine.excute("notification_center_update",0,"push_notification_center_develop_equip_upgrade")
    	state_machine.excute("notification_center_update",0,"push_notification_center_develop_equip_awake")
    end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_ship_experience_change 14105 --返回武将经验变更信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_ship_experience_change(interpreter,datas,pos,strDatas,list,count)
	local shipid = npos(list) 
	local change_experience = npos(list)
	local ship = fundShipWidthId(shipid)
	ship.change_experience = change_experience
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_ship_soul_state_info_change 14106 --返回武将斗魂信息变更
-- ---------------------------------------------------------------------------------------------------------
function parse_user_ship_soul_state_info_change(interpreter,datas,pos,strDatas,list,count)
	local ship_id = npos(list)		--卡牌实例id
	local infos = npos(list)
	_ED.user_ship[""..ship_id].ship_fighting_spirit = infos
	-- 等级，经验值|等级，经验值|等级，经验值|等级，经验值
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_rebirth_ship_reward_info 14107 --返回武将重生初始化
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_rebirth_ship_reward_info(interpreter,datas,pos,strDatas,list,count)
	_ED.user_rebirth_info = {}
	_ED.user_rebirth_info.normal_cost_info = npos(list)
	_ED.user_rebirth_info.normal_reward_info = npos(list)
	_ED.user_rebirth_info.high_cost_info = npos(list)
	_ED.user_rebirth_info.high_reward_info = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_ship_change_ex 14108 --返回战船批量属性变更
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_ship_change_ex(interpreter,datas,pos,strDatas,list,count)
	local count = tonumber(npos(list))
	for i=1, count do
		local changeShipId = npos(list)							-- 用户战船ID
		local old_ship_grade = 0
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			old_ship_grade = _ED.user_ship[changeShipId].ship_grade 
		end
		local usership = _ED.user_ship[changeShipId]
		local isVerity = true
		if isVerity == true and usership ~= nil and usership.history_info ~= nil then
			local history_info = aeslua.decrypt("jar-world", usership.history_info, aeslua.AES128, aeslua.ECBMODE)
			local old_history_info = usership.ship_health 
				.. usership.ship_wisdom 
				.. usership.ship_leader 
				.. usership.ship_courage
				.. usership.ship_intellect
				.. usership.ship_quick
			if history_info ~= old_history_info then
				isVerity = false
			end
		end

		_ED.user_ship[changeShipId].ship_template_id = npos(list)	--战船模板id
		_ED.user_ship[changeShipId].ship_grade = npos(list)	--战船等级
		_ED.user_ship[changeShipId].ship_leader = npos(list) --统帅
		_ED.user_ship[changeShipId].ship_force = npos(list) --武力
		_ED.user_ship[changeShipId].ship_wisdom = npos(list) --智慧(数码:速度)
		_ED.user_ship[changeShipId].ship_health = npos(list)--战船体力值
		_ED.user_ship[changeShipId].ship_courage = npos(list)--战船勇气值
		_ED.user_ship[changeShipId].ship_intellect = npos(list)--战船智力值
		_ED.user_ship[changeShipId].ship_base_health=_ED.user_ship[changeShipId].ship_health		
		-- print("身体334 " .. _ED.user_ship[changeShipId].ship_base_health)				
		_ED.user_ship[changeShipId].ship_health = math.floor(tonumber(_ED.user_ship[changeShipId].ship_health))
		_ED.user_ship[changeShipId].ship_base_courage=_ED.user_ship[changeShipId].ship_courage						
		_ED.user_ship[changeShipId].ship_courage = math.floor(tonumber(_ED.user_ship[changeShipId].ship_courage))
		_ED.user_ship[changeShipId].ship_base_intellect=_ED.user_ship[changeShipId].ship_intellect						
		_ED.user_ship[changeShipId].ship_intellect = math.floor(tonumber(_ED.user_ship[changeShipId].ship_intellect))

		_ED.user_ship[changeShipId].ship_quick = npos(list)		--战船敏捷值
		if __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon 
			or __lua_project_id == __lua_project_l_naruto 
			then
			_ED.user_ship[changeShipId].initial_sp_increase = tonumber(npos(list))	--战船初始怒气值
			_ED.user_ship[changeShipId].property_values = npos(list)	--战船动态属性值
		end
		_ED.user_ship[changeShipId].ship_picture = npos(list)	--战船图标
		_ED.user_ship[changeShipId].exprience = npos(list)		--当前经验
		_ED.user_ship[changeShipId].grade_need_exprience = npos(list)--当前级别所需经验
		_ED.user_ship[changeShipId].train = npos(list)			--是否训练
		_ED.user_ship[changeShipId].train_endtime = npos(list)	--训练结束时间
		if __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon 
			or __lua_project_id == __lua_project_l_naruto 
			then
			_ED.user_ship[changeShipId].shipSpirit = npos(list)		--战船速度
			_ED.user_ship[changeShipId].ship_fighting_spirit = npos(list)	--斗魂
			_ED.user_ship[changeShipId].ship_skin_info = npos(list)	--皮肤
		end
		_ED.user_ship[changeShipId].ship_type = npos(list)		--战船类型(品质)
		if __lua_project_id == __lua_project_red_alert 
			or __lua_project_id == __lua_project_red_alert_time 
			or __lua_project_id == __lua_project_pacific_rim
			then
			_ED.user_ship[changeShipId].star_open_state = npos(list)		--星格开启状态
		end

		 deliver_trim_fighter_action_info(list[2], changeShipId) 

		_ED.baseFightingCount = calcTotalFormationFight()
		if __lua_project_id == __lua_project_warship_girl_b 
			or __lua_project_id == __lua_project_digimon_adventure 
			or __lua_project_id == __lua_project_naruto 
			or __lua_project_id == __lua_project_pokemon 
			or __lua_project_id == __lua_project_rouge 
			or __lua_project_id == __lua_project_yugioh 
			or __lua_project_id == __lua_project_gragon_tiger_gate 
			or __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon 
			or __lua_project_id == __lua_project_l_naruto 
			then
			_ED.user_ship[changeShipId].captain_name = 	dms.string(dms["ship_mould"], _ED.user_ship[changeShipId].ship_template_id, ship_mould.captain_name)	
		end

	    if tonumber(old_ship_grade) ~= tonumber(_ED.user_ship[changeShipId].ship_grade) then
	    	toViewShipPushData(_ED.user_ship[changeShipId].ship_id,false,2,-1)
	    end
    	if isVerity == false then
			if fwin:find("ReconnectViewClass") == nil then
				fwin:open(ReconnectView:new():init(_string_piece_info[420]), fwin._system)
			end
			return false
		else
			usership.history_info = aeslua.encrypt("jar-world", 
				usership.ship_health 
				.. usership.ship_wisdom 
				.. usership.ship_leader 
				.. usership.ship_courage
				.. usership.ship_intellect
				.. usership.ship_quick
				, 
				aeslua.AES128, aeslua.ECBMODE)
			-- print("更新武将信息：", usership.history_info)
		end
	end
	
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon 
		or __lua_project_id == __lua_project_l_naruto 
		then
	    _ED.user_info.fight_capacity = getUserTotalFight()
	    --武将强化推送
	    -- setHeroDevelopAllShipPushState(1)
		state_machine.excute("hero_list_view_update_cell_strength_button_push",0,"hero_list_view_update_cell_strength_button_push.")
		state_machine.excute("hero_list_view_update_cell_equip_button_push",0,"hero_list_view_update_cell_equip_button_push.")
       	state_machine.excute("notification_center_update",0,"push_notification_center_ship_warehouse_all")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_home_hero_icon")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_duplicate_formation")

       	--state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_ship_strength_icon")
       	-- state_machine.excute("hero_develop_page_updata_hero_icon_push",0,"hero_develop_page_updata_hero_icon_push.")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_evolution_page_tip")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_up_grade_star_page_tip")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_strength_evolution_button")
       	state_machine.excute("notification_center_update",0,"push_notification_center_hero_strength_up_grade_button")
       	state_machine.excute("sm_equipment_qianghua_update_hero_icon_push",0,"sm_equipment_qianghua_update_hero_icon_push.")
       	state_machine.excute("hero_develop_page_updata_hero_icon_push",0,"hero_develop_page_updata_hero_icon_push.")
       	state_machine.excute("hero_icon_listview_icon_push_updata",0,"hero_icon_listview_icon_push_updata.")
       	state_machine.excute("notification_center_update",0,"push_notification_center_formation_ship_evo")
	    state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_ship_evo")
		state_machine.excute("notification_center_update",0,"push_notification_center_formation_ship_formation")
	    state_machine.excute("notification_center_update",0,"push_notification_center_formation_equip_upgrade")
	    state_machine.excute("notification_center_update",0,"push_notification_center_formation_equip_awake")
	    state_machine.excute("formation_update_equip_icon_push",0,"formation_update_equip_icon_push.")
	    if fwin:find("HeroStorageClass") ~= nil then
	    	state_machine.excute("notification_center_update",0,"push_notification_center_develop_equip_upgrade")
	    	state_machine.excute("notification_center_update",0,"push_notification_center_develop_equip_awake")
	    end
       	getUserSpeedSum()
    end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_ship_praise_state 14109 --返回自己的点赞状态
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_ship_praise_state(interpreter,datas,pos,strDatas,list,count)
	_ED.user_ship_praise_state_info = zstring.split(npos(list), ",")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_ship_praise_rank_info 14110 --返回武将点赞排行信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_ship_praise_rank_info(interpreter,datas,pos,strDatas,list,count)
	_ED.user_ship_praise_rank_count = npos(list)	-- 数量
	_ED.user_ship_praise_rank_list = {}
	for n = 1, tonumber(_ED.user_ship_praise_rank_count) do
		local info = {
			rank = npos(list),		--排行
			shipMouldId = npos(list),	-- 模板id
			count = npos(list),		-- 数量
		}
		if tonumber(info.count) > 9999 then
			info.count = 9999
		end
		-- table.insert(_ED.user_ship_praise_rank_list, info)
		_ED.user_ship_praise_rank_list[info.shipMouldId] = info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_other_member 14608 --返回其他工会成员
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_other_member(interpreter,datas,pos,strDatas,list,count)
	_ED.union.rank_union_other_member_page_count = npos(list)	-- 数量
	_ED.union.rank_union_other_member_list = {}
	for n = 1 ,tonumber(_ED.union.rank_union_other_member_page_count) do
		local info={
			user_id = npos(list),		--用户id
			user_level = npos(list),	--用户等级
			user_name = npos(list),		--用户名称 
			user_fighting = npos(list),	--用户战力
			user_sex = npos(list),		--用户性别
			-- TODO...
			user_head_id = npos(list),	--用户头像
			user_post = npos(list),		--用户职位
			union_camp = npos(list),	--用户阵营
		}
		_ED.union.rank_union_other_member_list[n] = info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_get_physical_info 14609 --返回阿希拉之战信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_get_physical_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_get_physical_info_list = {}
	_ED.union.union_get_physical_my_team_id = 0
	_ED.union.union_get_physical_number = npos(list)
	for i = 1, zstring.tonumber(_ED.union.union_get_physical_number) do
		local team_info = {}
		local team_id = npos(list)	       --队伍id
		local member_nums = npos(list)	   --成员数量
		team_info.member_info = {}
		for j=1, tonumber(member_nums) do
			local info = {
				ntype = npos(list),
				id = npos(list),
				level = npos(list),
				name = npos(list),
				sex = npos(list),
				-- TODO...
				user_head_id = npos(list),
			}
			if tonumber(info.id) == tonumber(_ED.user_info.user_id) then
				_ED.union.union_get_physical_my_team_id = team_id
			end
			team_info.team_type = info.ntype
			table.insert(team_info.member_info, info)
		end
		team_info.team_id = team_id
		team_info.member_nums = member_nums
		table.insert(_ED.union.union_get_physical_info_list, team_info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_stronghold_info 14610 --公会据点占领信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_stronghold_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union_stronghold_info_list = _ED.union_stronghold_info_list or {}
	local info = {
		city_id = npos(list),
		union_id = npos(list),
		union_name = npos(list),
		union_level = npos(list),
		wait_attack_time = npos(list),
		attack_time_cd = npos(list),
		attack_union_id = npos(list),
		attack_union_name = npos(list),
		attack_union_level = npos(list),
		protect_cd_time = npos(list),
		reward_id = npos(list),
	}

	_ED.union_stronghold_info_list[""..info.city_id] = info

	-- debug.print_r(info)
	state_machine.excute("national_city_refresh_union_city_map_info", 0, info)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_city_info 14611 --单个公会城池据点初始化
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_city_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_info = {}

	_ED.union_fight_city_info.begin_cd_time = npos(list)
	_ED.union_fight_city_info.attack_cd_time = npos(list)
	_ED.union_fight_city_info.defend_score = npos(list)
	_ED.union_fight_city_info.defend_nums = npos(list)
	_ED.union_fight_city_info.defend_list = {}
	for i=1,tonumber(_ED.union_fight_city_info.defend_nums) do
		local info = {
			user_id = npos(list),
			user_name = npos(list),
			user_gender = npos(list),
			user_level = npos(list),
			user_vip = npos(list),
			user_fighting = npos(list),
			user_hp = npos(list),
			user_arena_rank = npos(list),
			win_times = npos(list),
			attack_cd = npos(list),
			union_id = npos(list),
			union_name = npos(list),
			attack_state = npos(list),
		}
		table.insert(_ED.union_fight_city_info.defend_list, info)
	end
	_ED.union_fight_city_info.defend_npc_nums = npos(list)
	_ED.union_fight_city_info.defend_npc_list = {}
	for i=1,tonumber(_ED.union_fight_city_info.defend_npc_nums) do
		local info = {
			user_id = npos(list),
			user_name = npos(list),
			user_gender = npos(list),
			user_level = npos(list),
			user_vip = npos(list),
			user_fighting = npos(list),
			user_hp = npos(list),
			user_arena_rank = npos(list),
			win_times = npos(list),
			attack_cd = npos(list),
			union_id = npos(list),
			union_name = npos(list),
			attack_state = npos(list),
		}
		table.insert(_ED.union_fight_city_info.defend_list, info)
	end
	_ED.union_fight_city_info.attacker_score = npos(list)
	_ED.union_fight_city_info.attacker_nums = npos(list)
	_ED.union_fight_city_info.attacker_list = {}
	for i=1,tonumber(_ED.union_fight_city_info.attacker_nums) do
		local info = {
			user_id = npos(list),
			user_name = npos(list),
			user_gender = npos(list),
			user_level = npos(list),
			user_vip = npos(list),
			user_fighting = npos(list),
			user_hp = npos(list),
			user_arena_rank = npos(list),
			win_times = npos(list),
			attack_cd = npos(list),
			union_id = npos(list),
			union_name = npos(list),
			attack_state = npos(list),
		}
		table.insert(_ED.union_fight_city_info.attacker_list, info)
	end
	-- debug.print_r(_ED.union_fight_city_info)
	state_machine.excute("union_fighting_main_update_info", 0, nil)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_owner_union_fight_city_info 14612 --返回个人公会据点信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_owner_union_fight_city_info(interpreter,datas,pos,strDatas,list,count)
	local user_id = npos(list)
	if tonumber(user_id) == tonumber(_ED.user_info.user_id) then
		local lastDeathState = nil
		if _ED.union_fight_city_user_info ~= nil then
			lastDeathState = _ED.union_fight_city_user_info.is_death
		end
		_ED.union_fight_city_user_info = {}
		_ED.union_fight_city_user_info.is_death = npos(list)		--(0:正常 1:死亡)
		_ED.union_fight_city_user_info.review_cd_time = tonumber(npos(list))/1000
		_ED.union_fight_city_user_info.review_times = tonumber(npos(list))
		_ED.union_fight_city_user_info.user_hp = npos(list)
		_ED.union_fight_city_user_info.total_kill_nums = tonumber(npos(list))
		_ED.union_fight_city_user_info.mach_wait_cd = tonumber(npos(list))/1000
		_ED.union_fight_city_user_info.attack_wait_cd = tonumber(npos(list))/1000
		_ED.union_fight_city_user_info.clear_attack_cd_times = tonumber(npos(list))
		-- debug.print_r(_ED.union_fight_city_user_info)
		if tonumber(_ED.union_fight_city_user_info.is_death) == 1 then
			state_machine.excute("national_city_open_union_role_death", 0, nil)
		end
	else
		npos(list)
		npos(list)
		npos(list)
		npos(list)
		npos(list)
		npos(list)
		npos(list)
		npos(list)
	end
	-- debug.print_r(_ED.union_fight_city_user_info)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_city_one_battle_result	14613 --返回公会据点战斗信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_city_one_battle_result(interpreter,datas,pos,strDatas,list,count)
	local count = npos(list)
	local isMyBattle = false
	_ED.union_fight_city_round_battle_info = {}
	local myBattleInfo = nil
	for i=1,tonumber(count) do
		local info = {}
		info.result = npos(list)	--(0:失败 1:胜利)
		info.attacker_id = npos(list)
		info.attacker_name = npos(list)
		info.attacker_gender = npos(list)
		info.attacker_hp = npos(list)
		info.attacker_union_id = npos(list)
		info.attacker_union_name = npos(list)
		info.attacker_arena_id = npos(list)
		info.attacker_score = npos(list)
		info.attacker_official = dms.int(dms["arena_reward_param"], info.attacker_arena_id, arena_reward_param.arena_official)

		info.defender_id = npos(list)
		info.defender_name = npos(list)
		info.defender_gender = npos(list)
		info.defender_hp = npos(list)
		info.defender_union_id = npos(list)
		info.defender_union_name = npos(list)
		info.defender_arena_id = npos(list)
		info.defender_score = npos(list)
		info.defender_official = dms.int(dms["arena_reward_param"], info.attacker_arena_id, arena_reward_param.arena_official)

		info.defender_npc_id = npos(list)

		info.isMyBattle = false
		info.owerIsAttacker = false
	    if tonumber(info.attacker_id) == tonumber(_ED.user_info.user_id)
	        or tonumber(info.defender_id) == tonumber(_ED.user_info.user_id) then
	    	info.isMyBattle = true
	    	isMyBattle = true
	    end
    	if tonumber(info.attacker_id) == tonumber(_ED.user_info.user_id) then
    		info.owerIsAttacker = true
    	end
    	if info.isMyBattle == true then
    		myBattleInfo = info
    	else
    		if tonumber(info.attacker_union_id) == tonumber(_ED.union.union_info.union_id)
	        	or tonumber(info.defender_union_id) == tonumber(_ED.union.union_info.union_id) then
	    		table.insert(_ED.union_fight_city_round_battle_info, info)
	    	end
    	end

		local battleInfo = _ED.union_fight_city_attack_result_list[info.attacker_id.."v"..info.defender_id]
        if nil ~= battleInfo then
            info.attacker_damage = battleInfo._attacker_damage
            info.defencer_damage = battleInfo._defencer_damage
        else
            battleInfo = _ED.union_fight_city_attack_result_list[info.attacker_id.."v"..info.defender_npc_id]
            if battleInfo ~= nil then
            	info.attacker_damage = battleInfo._attacker_damage
				info.defencer_damage = battleInfo._defencer_damage
            end
        end
	end
	if myBattleInfo ~= nil then
		if _ED.union_fighting_wait_attack == true or true then
			_ED.union_fighting_wait_attack = false
			local result = {myBattleInfo}
			for k,v in pairs(_ED.union_fight_city_round_battle_info) do
				table.insert(result, v)
			end
			_ED.union_fight_city_round_battle_info = result
		-- else
			local owerIsDeath = false
			if tonumber(myBattleInfo.result) == 0 then
                if tonumber(myBattleInfo.attacker_id) == tonumber(_ED.user_info.user_id) then
                    owerIsDeath = true
                end
            elseif tonumber(myBattleInfo.result) == 1 then
                if tonumber(myBattleInfo.defender_id) == tonumber(_ED.user_info.user_id) then
                    owerIsDeath = true
                end
            end
            if owerIsDeath == true then
            	state_machine.excute("union_fighting_main_close", 0, nil)
            	state_machine.excute("union_fighting_fail_open", 0, nil)
            	state_machine.excute("union_fighting_one_battle_result_close", 0, nil)
            -- else
            -- 	state_machine.excute("union_fighting_main_city_update_kill_nums", 0, nil)
            end
		end
	end
	-- debug.print_r(_ED.union_fight_city_round_battle_info)
	if #_ED.union_fight_city_round_battle_info > 0 then
		state_machine.excute("union_fighting_main_update_one_result", 0, isMyBattle)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_city_result	14614 --返回公会最终结算
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_city_result(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_result = npos(list)			--(0:攻占成功 1: 攻占失败) 
	_ED.union_fight_city_attack_union_id = npos(list)
	_ED.union_fight_city_attack_union_name = npos(list)
	_ED.union_fight_city_defend_union_id = npos(list)
	_ED.union_fight_city_defend_union_name = npos(list)
	-- print("....", _ED.union_fight_city_result)
	state_machine.excute("union_fighting_main_city_result", 0, nil)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_city_report_add	14615 --返回公会战报推送
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_city_report_add(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_report_list = _ED.union_fight_city_report_list or {}
	parse_union_fight_report_info(interpreter,datas,pos,strDatas,list,count)
	-- debug.print_r(_ED.union_fight_city_report_list)
	state_machine.excute("union_fighting_main_city_update_report", 0, nil)
end

---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_move_city 返回工会战用户移动坐标 14616
---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_move_city( interpreter,datas,pos,strDatas,list,count )
	local move_event = {
		user_id = npos(list),
		last_city_id = tonumber(npos(list)),
		curr_city_id = tonumber(npos(list)),
		union_name = npos(list),
		gender = npos(list),
		nickname = npos(list),
	}
	if zstring.tonumber(move_event.user_id) ~= zstring.tonumber(_ED.user_info.user_id) then
		state_machine.excute("national_city_update_union_city_user_pos", 0, {zstring.tonumber(move_event.curr_city_id), false})
	else
		_ED.city_world_map_id_backup = tonumber(move_event.curr_city_id)
		state_machine.excute("national_city_update_union_city_user_pos",0,{zstring.tonumber(move_event.curr_city_id), true})
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_city_report_init	14617 --返回初始化公会战报
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_city_report_init(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_report_list = {}
	local count = tonumber(npos(list))
	for i=1,count do
		parse_union_fight_report_info(interpreter,datas,pos,strDatas,list,count)
	end
	-- debug.print_r(_ED.union_fight_city_report_list)
	state_machine.excute("union_fighting_main_city_update_report", 0, nil)
end

function parse_union_fight_report_info( interpreter,datas,pos,strDatas,list,count )
	local nType = tonumber(npos(list))
	local report_info = {}
	report_info.nType = nType
	if nType == 0 then
		report_info.attack_union_name = npos(list)
		report_info.attack_user_name = npos(list)
		report_info.defend_union_name = npos(list)
		report_info.defend_user_name = npos(list)
	elseif nType == 1 then
		report_info.attack_union_name = npos(list)
		report_info.attack_user_name = npos(list)
		report_info.kill_num = npos(list)
	elseif nType == 2 
		or nType == 6 then
		report_info.attack_union_name = npos(list)
		report_info.attack_user_name = npos(list)
	elseif nType == 3 then
		report_info.attack_union_name = npos(list)
		report_info.attack_user_name = npos(list)
		report_info.defend_union_name = npos(list)
		report_info.defend_user_name = npos(list)
		report_info.kill_num = npos(list)
	elseif nType == 4 
		or nType == 5 then
		report_info.attack_union_name = npos(list)
		report_info.attack_score = npos(list)
		report_info.city_name = npos(list)
	elseif nType == 7 then
		report_info.cd_time = npos(list)
	end
	table.insert(_ED.union_fight_city_report_list, report_info)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_city_state	14618 --返回工会战状态
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_city_state(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_last_state = _ED.union_fight_city_state
	_ED.union_fight_city_state = tonumber(npos(list))
	state_machine.excute("union_update_fight_state", 0, nil)
	state_machine.excute("union_fighting_main_city_update_state", 0, nil)
	if _ED.union_fight_city_state == 3 then
		state_machine.excute("national_city_open_union_add_fighting_begin_effect", 0, nil)
	end
	if _ED.union_fight_city_state == 0 
		and (_ED.union_fight_city_last_state == nil or _ED.union_fight_city_last_state == 3) then
		state_machine.excute("national_city_open_union_add_fighting_end_effect", 0, nil)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_attack_rank_list 14619 --返回工会战城池竞价初始化
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_attack_rank_list(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_attack_rank_list = {}
	local count = tonumber(npos(list))
	for i=1,count do
		local info = {}
		info.city_id = npos(list)
		info.attack_union_id = npos(list)
		info.attack_leader_name = npos(list)
		info.attack_union_name = npos(list)
		info.attack_member_nums = npos(list)
		info.defend_union_id = npos(list)
		info.defend_leader_name = npos(list)
		info.defend_union_name = npos(list)
		info.defend_member_nums = npos(list)
		info.cost = npos(list)
		info.join_cost_union_id = npos(list)
		_ED.union_fight_city_attack_rank_list[""..info.city_id] = info
	end
	-- debug.print_r(_ED.union_fight_city_attack_rank_list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_fight_attack_rank_info 14620 --返回工会战城池竞价信息变更
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_fight_attack_rank_info(interpreter,datas,pos,strDatas,list,count)
	local info = {}
	info.city_id = npos(list)
	info.attack_union_id = npos(list)
	info.attack_leader_name = npos(list)
	info.attack_union_name = npos(list)
	info.attack_member_nums = npos(list)
	info.defend_union_id = npos(list)
	info.defend_leader_name = npos(list)
	info.defend_union_name = npos(list)
	info.defend_member_nums = npos(list)
	info.cost = npos(list)
	info.join_cost_union_id = npos(list)

	_ED.union_fight_city_attack_rank_list[""..info.city_id] = info
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_union_stronghold_battle_result 14621 --返回公会战单场战斗结果信息
-- ---------------------------------------------------------------------------------------------------------
function parse_union_stronghold_battle_result(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_attack_result_list = _ED.union_fight_city_attack_result_list or {}
	local info = {}
	info.battle_key = npos(list)-- attacker id V defender id eg:1v2
	info.attacker_id = npos(list)
	info.attacker_gender = npos(list)
	info.attacker_name = npos(list)
	info.attacker_level = npos(list)
	info.attacker_head_pic = npos(list)
	info.attacker_combat_force = npos(list)
	info.attacker_ships = {}
	local nCount = tonumber(npos(list))
	for i=1, nCount do
		local usership = {
			ship_template_id = npos(list),
			maxHp = npos(list),
			lessHp = npos(list),
			loseHp = npos(list)
		}
		local ship_mould_id = usership.ship_template_id
		local ship_data = dms.element(dms["ship_mould"], ship_mould_id)
		local ship_type = dms.atoi(ship_data,ship_mould.ship_type)
		usership.ship_type = ship_type
		table.insert(info.attacker_ships, usership)
	end

	info.defender_id = npos(list)
	info.defender_gender = npos(list)
	info.defender_name = npos(list)
	info.defender_level = npos(list)
	info.defender_head_pic = npos(list)
	info.defender_combat_force = npos(list)
	info.defender_ships = {}
	nCount = tonumber(npos(list))
	for i=1, nCount do
		local usership = {
			ship_template_id = npos(list),
			maxHp = npos(list),
			lessHp = npos(list),
			loseHp = npos(list)
		}
		local ship_mould_id = usership.ship_template_id
		local ship_data = dms.element(dms["ship_mould"], ship_mould_id)
		local ship_type = dms.atoi(ship_data,ship_mould.ship_type)
		usership.ship_type = ship_type
		table.insert(info.defender_ships, usership)
	end
	info._is_win = tonumber(npos(list))
	info._attacker_damage = npos(list)
	info._defencer_damage = npos(list)
	_ED.union_fight_city_attack_result_list[info.battle_key] = info
	-- debug.print_r(_ED.union_fight_city_attack_result_list)

	if 0 == info._is_win then
		for i, v in pairs(_ED.union_fight_city_info.attacker_list) do
			if v.user_id == info.attacker_id and v.user_name == info.attacker_name then
				table.remove(_ED.union_fight_city_info.attacker_list, i, 1)
			end
		end
		for i, v in pairs(_ED.union_fight_city_info.defend_list) do
			if v.user_id == info.attacker_id and v.user_name == info.attacker_name then
				table.remove(_ED.union_fight_city_info.defend_list, i, 1)
			end
		end
	end

	if 1 == info._is_win then
		for i, v in pairs(_ED.union_fight_city_info.attacker_list) do
			if v.user_id == info.defender_id and v.user_name == info.defender_name then
				table.remove(_ED.union_fight_city_info.attacker_list, i, 1)
			end
		end
		for i, v in pairs(_ED.union_fight_city_info.defend_list) do
			if v.user_id == info.defender_id and v.user_name == info.defender_name then
				table.remove(_ED.union_fight_city_info.defend_list, i, 1)
			end
		end
	end
	state_machine.excute("union_fighting_main_update_info", 0, nil)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_union_stronghold_battle_details 14622 --返回公会战城池据点信息
-- ---------------------------------------------------------------------------------------------------------
function parse_union_stronghold_battle_details( interpreter,datas,pos,strDatas,list,count )
	_ED.union_fight_other_city_info = {}
	_ED.union_fight_other_city_info.begin_cd_time = npos(list)
	_ED.union_fight_other_city_info.attack_cd_time = npos(list)
	_ED.union_fight_other_city_info.defend_score = npos(list)
	_ED.union_fight_other_city_info.defend_nums = npos(list)
	_ED.union_fight_other_city_info.defend_list = {}
	for i=1,tonumber(_ED.union_fight_other_city_info.defend_nums) do
		local info = {
			user_id = npos(list),
			user_name = npos(list),
			user_gender = npos(list),
			user_level = npos(list),
			user_vip = npos(list),
			user_fighting = npos(list),
			user_hp = npos(list),
			user_arena_rank = npos(list),
			win_times = npos(list),
			attack_cd = npos(list),
			union_id = npos(list),
			union_name = npos(list),
			attack_state = npos(list),
		}
		table.insert(_ED.union_fight_other_city_info.defend_list, info)
	end
	_ED.union_fight_other_city_info.defend_npc_nums = npos(list)
	_ED.union_fight_other_city_info.defend_npc_list = {}
	for i=1,tonumber(_ED.union_fight_other_city_info.defend_npc_nums) do
		local info = {
			user_id = npos(list),
			user_name = npos(list),
			user_gender = npos(list),
			user_level = npos(list),
			user_vip = npos(list),
			user_fighting = npos(list),
			user_hp = npos(list),
			user_arena_rank = npos(list),
			win_times = npos(list),
			attack_cd = npos(list),
			union_id = npos(list),
			union_name = npos(list),
			attack_state = npos(list),
		}
		table.insert(_ED.union_fight_other_city_info.defend_list, info)
	end
	_ED.union_fight_other_city_info.attacker_score = npos(list)
	_ED.union_fight_other_city_info.attacker_nums = npos(list)
	_ED.union_fight_other_city_info.attacker_list = {}
	for i=1,tonumber(_ED.union_fight_other_city_info.attacker_nums) do
		local info = {
			user_id = npos(list),
			user_name = npos(list),
			user_gender = npos(list),
			user_level = npos(list),
			user_vip = npos(list),
			user_fighting = npos(list),
			user_hp = npos(list),
			user_arena_rank = npos(list),
			win_times = npos(list),
			attack_cd = npos(list),
			union_id = npos(list),
			union_name = npos(list),
			attack_state = npos(list),
		}
		table.insert(_ED.union_fight_other_city_info.attacker_list, info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_union_stronghold_battle_result 14623 --返回公会战城池阵容信息
-- ---------------------------------------------------------------------------------------------------------
function parse_union_stronghold_formation_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_my_formations = {}
	local nCount = tonumber(npos(list))
	for i=1, nCount do
		local usership = {
			ship_template_id = npos(list),
			lessHp = npos(list),
			maxHp = npos(list),
		}
		local ship_mould_id = usership.ship_template_id
		local ship_data = dms.element(dms["ship_mould"], ship_mould_id)
		local ship_type = dms.atoi(ship_data,ship_mould.ship_type)
		usership.ship_type = ship_type
		usership.shipid = shipid
		table.insert(_ED.union_fight_city_my_formations, usership)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_union_stronghold_user_hp_info 14624 --返回公会战个人血量信息
-- ---------------------------------------------------------------------------------------------------------
function parse_union_stronghold_user_hp_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union_fight_city_user_hp_info = {}
	_ED.union_fight_city_user_hp_info.kill_count = npos(list)
	_ED.union_fight_city_user_hp_info.total_hurt = npos(list)
	_ED.union_fight_city_user_hp_info.win_times = npos(list)
	_ED.union_fight_city_user_hp_info.union_resource = npos(list)
	_ED.union_fight_city_user_hp_info.city_id = npos(list)
	_ED.union_fight_city_user_hp_info.user_name = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_stronghold_reward 14625 --公会据点奖励信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_stronghold_reward(interpreter,datas,pos,strDatas,list,count)
	_ED.union_stronghold_reward_list = {}
	local count = npos(list)
	for i=1,tonumber(count) do
		local info = {
			city_id = npos(list),
			reward_id = npos(list),
		}
		table.insert(_ED.union_stronghold_reward_list, info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_first_join_reward 14626 --返回军团首次加入奖励状态
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_first_join_reward(interpreter,datas,pos,strDatas,list,count)
	_ED.union_first_join_reward = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_science_info 14627 --返回军团科技状态列表
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_science_info(interpreter,datas,pos,strDatas,list,count)
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		local union_science_info = npos(list)
		local my_science_info = npos(list)
		_ED.union_science_info = nil
		local unionData = zstring.split(union_science_info,"|")
		local myData = zstring.split(my_science_info,"|")
		for i=1, #unionData do
			local allData = unionData[i]..","..myData[i]
			if i==1 then
				_ED.union_science_info = allData
			else
				_ED.union_science_info = _ED.union_science_info.."|"..allData
			end
		end
		--9个科技													（科技3的时候）免费使用的次数，收费使用的次数
		-- 当前等级，当前经验，今天获得的总经验，（第一个科技表示全部科技使用次数）已经使用的次数，改变次数|

		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_adventure")--工会大冒险
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_research_institute")--研究院
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_slot_machine")--老虎机
		state_machine.excute("notification_center_update", 0, "push_notification_center_union_all")--主界面工会按钮
	else
		_ED.union_science_donate_times = npos(list)
		_ED.union_science_info = _ED.union_science_info or {} 		-- 军团科技
		local count = npos(list)
		for n = 1, tonumber(count) do
			local info = {
				science_id = npos(list),
				level = npos(list),
				current_exp = npos(list),
				need_exp = npos(list),
			}
			info.name = dms.string(dms["union_science_mould"], tonumber(info.science_id), union_science_mould.name)
			_ED.union_science_info[""..info.science_id] = info
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_shop_info 14628 --返回军团商店列表
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_shop_info(interpreter,datas,pos,strDatas,list,count)
	local nType = npos(list)
	_ED.union_shop_info = _ED.union_shop_info or {}
	_ED.union_shop_info[""..nType] = {}

	local count = npos(list)
	for n = 1, tonumber(count) do
		local info = {
			shop_id = npos(list),
			exchange_count = npos(list),
		}
		info.order = dms.int(dms["union_shop_mould"], info.shop_id, union_shop_mould.order),
		table.insert(_ED.union_shop_info[""..nType], info)
	end

	nType = npos(list)
	_ED.union_shop_info[""..nType] = {}

	local count = npos(list)
	for n = 1, tonumber(count) do
		local info = {
			shop_id = npos(list),
			exchange_count = npos(list),
		}
		info.order = dms.int(dms["union_shop_mould"], info.shop_id, union_shop_mould.order),
		table.insert(_ED.union_shop_info[""..nType], info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_active_info 14629 --返回军团活跃信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_active_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union_active_info = {
		active_level = npos(list), 				-- 活动等级
		active_point = npos(list), 				-- 活跃点数
		active_task_count = npos(list), 	        -- 活跃任务完成次数
		share_reward = npos(list), 	            -- 今日共享的资源集合
		daily_active = npos(list),				-- 日活跃
		get_reward = npos(list), 		        -- 今日已领取的资源集合
	}
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_union_copy_init 14630 --返回军团副本初始化
-- ---------------------------------------------------------------------------------------------------------
function parse_union_copy_init(interpreter,datas,pos,strDatas,list,count)
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		_ED.union_pve_attribute_bonus = tonumber(npos(list))
	else
		_ED.union_pve_attack_times = tonumber(npos(list))
		_ED.union_pve_is_receive = zstring.split(npos(list), "|")
		_ED.union_pve_npc_state = zstring.split(npos(list), "|")

		_ED.union_pve_info = {}
		
		local receive_count = tonumber(npos(list))
		for i=1,receive_count do
			local npc_info = {}
			local scene_npc_state = zstring.split(_ED.union_pve_npc_state[i], ",")
			local npc_count = tonumber(npos(list))
			for j=1,npc_count do
				local info = {	
					npc_state = tonumber(scene_npc_state[j]), 		-- npc状态(-1:未开启 0:开启 1:已击败)
					is_battle = tonumber(npos(list)), 	    -- 是否交战中(0:未交战需要客户端自行读取npc阵型信息 1:后续传递敌方阵容)
					formation_info = 0, 			        -- 阵容信息(部队实例ID,部队模板ID,战斗数量,单位载重,出战数量,将领实例ID,将领模板ID,出战血量|…)
				}
				if info.is_battle == 1 then
					info.formation_info = npos(list)
				end
				npc_info[""..j] = info
			end
			_ED.union_pve_info[""..i] = npc_info
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_event_add 14631 --返回军团事件增加
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_event_add(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_message_info_list = _ED.union.union_message_info_list or {}
	_ED.union.union_welfare_info_list = _ED.union.union_welfare_info_list or {}
	_ED.union.union_reward_info_list = _ED.union.union_reward_info_list or {}
	local info = {
		ntype = npos(list),		--类型
		name = npos(list),	    --名称
		time = npos(list),	    --时间
		param = npos(list),	    --参数
	}
	local name_info = zstring.split(info.name,"_")
	if #name_info > 1 and tonumber(name_info[2]) ~= nil then
		info.name = name_info[1]
		info.post_1 = tonumber(name_info[2])
	end
	local param_info = zstring.split(info.param,",")
	local name_info_2 = zstring.split(param_info[1],"_")
	if #name_info_2 > 1 and tonumber(name_info_2[2]) ~= nil then
		info.post_2 = tonumber(name_info_2[2])
		param_info[1] = name_info_2[1]
	end
	info.param = zstring.concat(param_info, ",")
	if tonumber(info.ntype) < 20 then
		_ED.union.union_message_number = zstring.tonumber(_ED.union.union_message_number) + 1
		table.insert(_ED.union.union_message_info_list, info)
	elseif tonumber(info.ntype) >= 30 then
		_ED.union.union_reward_number = zstring.tonumber(_ED.union.union_reward_number) + 1
		table.insert(_ED.union.union_reward_info_list, info)
	else
		_ED.union.union_welfare_number = zstring.tonumber(_ED.union.union_welfare_number) + 1
		table.insert(_ED.union.union_welfare_info_list, info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_hegemony_info 14632 --返回军团争霸信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_hegemony_info(interpreter,datas,pos,strDatas,list,count)
	local last_state = 0
	if _ED.union.union_hegemony_info ~= nil then
		last_state = zstring.tonumber(_ED.union.union_hegemony_info.state)
	end

	_ED.union.union_hegemony_info = {}
    _ED.union.union_hegemony_info.state = npos(list)	--(0:未开启 1:报名中 2:等待中 3:开战中 4:结束)
    _ED.union.union_hegemony_info.formation_info = npos(list)
    _ED.union.union_hegemony_sign_up_list = {}
	_ED.union.union_hegemony_sign_up_number = npos(list)
	for i = 1, zstring.tonumber(_ED.union.union_hegemony_sign_up_number) do
		local info = {
			user_id = npos(list),
			name = npos(list),
			level = npos(list),
			fight_number = npos(list),
		}
		table.insert(_ED.union.union_hegemony_sign_up_list, info)
	end
    _ED.union.union_hegemony_all_union_sign_up_list = {}
	_ED.union.union_hegemony_all_union_sign_up_number = npos(list)
	for i = 1, zstring.tonumber(_ED.union.union_hegemony_all_union_sign_up_number) do
		local info = {
			union_id = npos(list),
			name = npos(list),
			level = npos(list),
			person_number = npos(list),
			fight_number = npos(list),
		}
		table.insert(_ED.union.union_hegemony_all_union_sign_up_list, info)
	end

	if _ED.mould_function_push_info["9"] ~= nil then
		_ED.mould_function_push_info["9"].state = _ED.union.union_hegemony_info.state
    end

	state_machine.excute("legion_hegemony_update_state", 0, {tonumber(_ED.union.union_hegemony_info.state)})
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_hegemony_rank_info 14633 --返回军团争霸排行榜信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_hegemony_rank_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_union_hegemony_rank_list = _ED.union.union_union_hegemony_rank_list or {}
	-- 连胜排行
    _ED.union.union_union_hegemony_rank_list["0"] = {}
	local craft_count = npos(list)
	for i = 1, zstring.tonumber(craft_count) do
		local info = {
			id = npos(list),
			name = npos(list),
			number = npos(list),
			fight_number = npos(list),
			rank = i,
		}
		table.insert(_ED.union.union_union_hegemony_rank_list["0"], info)
	end

	-- 军团排行
    _ED.union.union_union_hegemony_rank_list["1"] = {}
	local legion_count = npos(list)
	for i = 1, zstring.tonumber(legion_count) do
		local info = {
			id = npos(list),
			name = npos(list),
			number = npos(list),
			fight_number = npos(list),
			rank = i,
		}
		table.insert(_ED.union.union_union_hegemony_rank_list["1"], info)
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_pack_reward_info 14634 --返回军团仓库列表
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_pack_reward_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_pack_reward_info = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_member_info_change 14635 --返回工会成员信息变更
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_member_info_change(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_member_list_sum = tonumber(_ED.union.union_member_list_sum) or 0
	_ED.union.union_member_list_info = _ED.union.union_member_list_info or {}
	local info={
		id = npos(list),		--成员ID  
		level = npos(list),		--等级 
		post = tonumber(npos(list)),		--职务 
		name = npos(list),		--名称 
		capactity = npos(list),	--战力 
		user_sex = npos(list),	--性别
		user_head_id = npos(list),	--头像
		offline_time = npos(list),	--离线时间 
		gold_card = npos(list),	-- 金卡开启状态
		diamond_card = npos(list),	-- 钻卡开启状态
		is_online = tonumber(npos(list)) == 1,	--是否在线
		vip_level = tonumber(npos(list)),	        -- VIP等级
		have_devote = npos(list),	    -- 贡献
		week_devote = npos(list),	    -- 周贡献
		industry_level = npos(list),	-- 军衔等级
		play_formation_info = npos(list), 	-- 军团切磋阵容信息
		daily_active = npos(list), 		-- 日活跃
		formation_capactity = npos(list), 	-- 成员切磋阵容战力
		weak_activity_con = npos(list), 		-- 周活动贡献
		weak_activity_join_times = npos(list), -- 周活动参与次数
	}
	local isAdd = true
	for k,v in pairs(_ED.union.union_member_list_info) do
		if tonumber(v.id) == tonumber(info.id) then
			_ED.union.union_member_list_info[k] = info
			isAdd = false
			break
		end
	end
	if isAdd == true then
		_ED.union.union_member_list_sum = _ED.union.union_member_list_sum + 1
		_ED.union.union_member_list_info[_ED.union.union_member_list_sum] = info
	end
	state_machine.excute("legion_infomation_update_draw", 0, nil)
	state_machine.excute("legion_member_update_draw", 0, "")
	state_machine.excute("legion_con_ranks_update_draw", 0, "")
	state_machine.excute("legion_pk_list_update_list_info", 0, "")

	if tonumber(info.id) == tonumber(_ED.user_info.user_id) then
		state_machine.excute("legion_manage_update_button", 0, "")
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_member_info_delete 14636 --返回工会成员删除
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_member_info_delete(interpreter,datas,pos,strDatas,list,count)
	local id = npos(list)		--成员ID
	if tonumber(id) == tonumber(_ED.user_info.user_id) then
		_ED.union.user_union_info.union_id = 0
		state_machine.excute("legion_clean_all_data", 0, "")
	else
		_ED.union.union_member_list_info = _ED.union.union_member_list_info or {}
		_ED.union.union_member_list_sum = zstring.tonumber(_ED.union.union_member_list_sum) - 1
		for k,v in pairs(_ED.union.union_member_list_info) do
			if tonumber(v.id) == tonumber(id) then
				_ED.union.union_member_list_info[k] = nil
				break
			end
		end
		state_machine.excute("legion_infomation_update_draw", 0, nil)
		state_machine.excute("legion_member_update_draw", 0, nil)
		state_machine.excute("legion_con_ranks_update_draw", 0, "")
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_union_frist_enter_legion 14637 --返回军团成员首次被同意进入工会
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_union_frist_enter_legion(interpreter,datas,pos,strDatas,list,count)
	NetworkManager:register(protocol_command.union_init.code, nil, nil, nil, nil, nil, false, nil)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_science_info_update 14638 --返回军团科技信息变更
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_science_info_update(interpreter,datas,pos,strDatas,list,count)
	_ED.union_science_info = _ED.union_science_info or {} 		-- 军团科技
	local info = {
		science_id = npos(list),
		level = npos(list),
		current_exp = npos(list),
		need_exp = npos(list),
	}
	info.name = dms.string(dms["union_science_mould"], tonumber(info.science_id), union_science_mould.name)
	_ED.union_science_info[""..info.science_id] = info
	state_machine.excute("legion_technology_donate_update_draw", 0, nil)
	state_machine.excute("legion_technology_infor_update_draw", 0, nil)
	state_machine.excute("legion_technology_up_update_draw", 0, nil)
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_adventure")--工会大冒险
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_research_institute")--研究院
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_slot_machine")--老虎机
		state_machine.excute("notification_center_update", 0, "push_notification_center_union_all")--主界面工会按钮
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_science_info_times 14639 --返回军团科技信息次数变更
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_science_info_times(interpreter,datas,pos,strDatas,list,count)
	_ED.union_science_donate_times = npos(list)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_pve_info_update 14640 --返回军团副本状态更新信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_pve_info_update(interpreter,datas,pos,strDatas,list,count)
	_ED.union_pve_info = _ED.union_pve_info or {}
	local scene_id = tonumber(npos(list)) + 1
	local npc_id = tonumber(npos(list)) + 1
	local info = {	
		npc_state = tonumber(npos(list)),
		is_battle = tonumber(npos(list)), 	    -- 是否交战中(0:未交战需要客户端自行读取npc阵型信息 1:后续传递敌方阵容)
		formation_info = 0, 			        -- 阵容信息(部队实例ID,部队模板ID,战斗数量,单位载重,出战数量,将领实例ID,将领模板ID,出战血量|…)
	}
	if info.is_battle == 1 then
		info.formation_info = npos(list)
	end

	_ED.union_pve_info[""..scene_id] = _ED.union_pve_info[""..scene_id] or {}
	_ED.union_pve_info[""..scene_id][""..npc_id] = info
	state_machine.excute("legion_pve_update_draw", 0, "")
	state_machine.excute("pve_map_update_draw", 0, "")
	state_machine.excute("notification_center_update", 0, "push_notification_legion_pve_receive")
	getLegionPveCanReceiveCount()
	state_machine.excute("home_map_update_prodcution_state", 0, {2})
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_user_union_pve_info_update 14641 --返回用户军团副本状态更新信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_user_union_pve_info_update(interpreter,datas,pos,strDatas,list,count)
	_ED.union_pve_attack_times = tonumber(npos(list))
	_ED.union_pve_is_receive = zstring.split(npos(list), "|")			-- 领取状态(0:未领取 1:已领取)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_hegemony_sign_info 14642 --返回用户军团争霸报名信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_hegemony_sign_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_hegemony_sign_up_list = _ED.union.union_hegemony_sign_up_list or {}
	local info = {
		user_id = npos(list),
		name = npos(list),
		level = npos(list),
		fight_number = npos(list),
	}
	local isAdd = true
	for k,v in pairs(_ED.union.union_hegemony_sign_up_list) do
		if tonumber(info.user_id) == tonumber(v.user_id) then
			isAdd = false
			v.name = info.name
			v.level = info.level
			v.fight_number = info.fight_number
		end
	end
	if isAdd == true then
		table.insert(_ED.union.union_hegemony_sign_up_list, info)
	end
	state_machine.excute("legion_hegemony_join_update_draw", 0, nil)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_hegemony_sign_union_info 14643 --返回用户军团争霸军团信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_hegemony_sign_union_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_hegemony_all_union_sign_up_list = _ED.union.union_hegemony_all_union_sign_up_list or {}
	local info = {
		union_id = npos(list),
		name = npos(list),
		level = npos(list),
		person_number = npos(list),
		fight_number = npos(list),
	}
	local isAdd = true
	for k,v in pairs(_ED.union.union_hegemony_all_union_sign_up_list) do
		if tonumber(info.union_id) == tonumber(v.union_id) then
			isAdd = false
			v.name = info.name
			v.level = info.level
			v.person_number = info.person_number
			v.fight_number = info.fight_number
		end
	end
	if isAdd == true then
		table.insert(_ED.union.union_hegemony_all_union_sign_up_list, info)
	end
	state_machine.excute("legion_hegemony_join_update_draw", 0, nil)
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_level_info 14644 --返回用户军团等级信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_level_info(interpreter,datas,pos,strDatas,list,count)
	local union_grade = tonumber(npos(list))
	local last_union_grade = union_grade
	if _ED.union ~= nil and _ED.union.union_info ~= nil then
		last_union_grade = tonumber(_ED.union.union_info.union_grade)
		_ED.union.union_info.union_grade = union_grade
	end

	if last_union_grade < union_grade then
		state_machine.excute("home_map_change_home_build_legion_info", 0, "")
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_guard_battle_stronghold_info 14645 --返回守卫战据点信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_guard_battle_stronghold_info(interpreter,datas,pos,strDatas,list,count)
	_ED.guard_battle_stronghold_info = _ED.guard_battle_stronghold_info or {}
	_ED.guard_battle_stronghold_info.current_hp = npos(list) 		-- 据点当前耐久
	_ED.guard_battle_stronghold_info.max_hp = npos(list) 		-- 据点最大耐久
	_ED.guard_battle_stronghold_info.state = npos(list) 		-- 活动状态(0:未开启 1:准备 2:开战) 
	_ED.guard_battle_stronghold_info.result = npos(list) 			-- 胜利方(-1:无 0:守方 1:攻方) 
	_ED.guard_battle_stronghold_info.top_legion = npos(list) 			-- 第一军团名(-1:无)

	state_machine.excute("guard_battle_update_state", 0, {_ED.guard_battle_stronghold_info.state})
	state_machine.excute("guard_battle_update_stronghold_info", 0, "")
	state_machine.excute("guard_battle_guard_list_update_draw", 0, "")
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_guard_list_info 14646 --返回守卫战防守列表信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_guard_list_info(interpreter,datas,pos,strDatas,list,count)
	_ED.guard_battle_list_info = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.id = npos(list) 			-- 用户id 
		info.head_pic = npos(list) 		-- 用户头像
		info.name = npos(list)			-- 昵称
		info.level = npos(list) 		-- 等级
		info.fight_number = npos(list) 		-- 部队战力
		info.formation_info = npos(list) 	-- 部队阵容
		info.user_type = npos(list) 		-- 用户类型(0:用户 -1:npc)
		info.mould_id = npos(list) 		-- npc模板id
		if zstring.tonumber(info.user_type) == -1 then
			local currName = dms.string(dms["guard_npc"],tonumber(info.mould_id),guard_npc.name)
			if currName ~= nil and currName ~= "" then
				info.name = currName
			end
		end

		_ED.guard_battle_list_info[""..info.id] = info
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_guard_update_list_info 14647 --返回守卫战防守列表信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_guard_update_list_info(interpreter,datas,pos,strDatas,list,count)
	_ED.guard_battle_list_info = _ED.guard_battle_list_info or {}

	local info = {}
	info.id = npos(list) 			-- 用户id 
	info.head_pic = npos(list) 		-- 用户头像
	info.name = npos(list)			-- 昵称
	info.level = npos(list) 		-- 等级
	info.fight_number = npos(list) 		-- 部队战力
	info.formation_info = npos(list) 	-- 部队阵容
	info.user_type = npos(list) 		-- 用户类型(0:用户 -1:npc)
	info.mould_id = npos(list)		-- npc模板id
	if zstring.tonumber(info.user_type) == -1 then
		local currName = dms.string(dms["guard_npc"],tonumber(info.mould_id),guard_npc.name)
		if currName ~= nil and currName ~= "" then
			info.name = currName
		end
	end

	_ED.guard_battle_list_info[""..info.id] = info
	state_machine.excute("guard_battle_guard_list_update_list", 0, "")
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_guard_battle_user_info 14648 --返回守卫战个人信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_guard_battle_user_info(interpreter,datas,pos,strDatas,list,count)
	_ED.guard_battle_user_info = _ED.guard_battle_user_info or {}
	_ED.guard_battle_user_info.contribution = npos(list) 			-- 个人贡献
	_ED.guard_battle_user_info.fight_count = npos(list) 				-- 战斗次数
	_ED.guard_battle_user_info.auto_clear_cd = npos(list) 				-- 是否设置自动清除冷却
	_ED.guard_battle_user_info.cd_end_time =  tonumber(npos(list)) / 1000                -- 冷却结束时间
	_ED.guard_battle_user_info.factor_info = npos(list) 				-- 增益购买次数(0,0,0)
	_ED.guard_battle_user_info.factor_list = zstring.split(_ED.guard_battle_user_info.factor_info, ",")
	_ED.guard_battle_user_info.battle_type = npos(list) 		-- 所在阵营(0:守方 1:攻方)
	_ED.guard_battle_user_info.hegemony_rank = npos(list) 		-- 军团争霸排名

	state_machine.excute("guard_battle_update_user_info", 0, "")
	state_machine.excute("guard_battle_guard_list_update_draw", 0, "")

	if tonumber(_ED.guard_battle_user_info.battle_type) == 0 then
		state_machine.excute("guard_battle_show_battle_result", 0, "")
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_guard_battle_rank_info 14649 --返回守卫战排行榜信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_guard_battle_rank_info(interpreter,datas,pos,strDatas,list,count)
	_ED.guard_battle_rank_list = _ED.guard_battle_rank_list or {}
	local nType = npos(list) 		-- 类型(0:个人 1:军团)
    _ED.guard_battle_rank_list[""..nType] = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {
			id = npos(list),
			rank = npos(list),
			name = npos(list),
			contribution = npos(list),
		}
		table.insert(_ED.guard_battle_rank_list[""..nType], info)
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_guard_battle_list_info_delete 14650 --返回守卫战防守列表消失
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_guard_battle_list_info_delete(interpreter,datas,pos,strDatas,list,count)
	_ED.guard_battle_list_info = _ED.guard_battle_list_info or {}
	local id = npos(list)
	_ED.guard_battle_list_info[""..id] = nil
	state_machine.excute("guard_battle_guard_list_update_list", 0, "")
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_guard_battle_factor_info 14651 --返回守卫战胜利方增益列表
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_guard_battle_factor_info(interpreter,datas,pos,strDatas,list,count)
	_ED.factor_info = _ED.factor_info or {}
	local count = tonumber(npos(list))
	for i=1, count do
		local info = {}
		info.id = npos(list)				-- 增益实例id
		info.mould_id = npos(list) 		    -- 增益模板id
		info.factor_type = npos(list) 		-- 增益类型
		info.factor_obj = npos(list)		-- 增益对象
		info.factor_start_time = math.floor(zstring.tonumber(npos(list))/1000)		-- 增益开始时间
		info.factor_cd_time = math.floor(zstring.tonumber(npos(list))/1000)		-- 增益cd时间

		info.build_buff_id = 0 			-- 索引建筑增益光环模板id
		local build_ids = zstring.split(dms.string(dms["talent_mould"], info.mould_id, talent_mould.build_buff_id), ",")
		if #build_ids == 1 then 
			info.build_buff_id = tonumber(build_ids[1])
		else
			info.build_buff_id = tonumber(info.factor_obj)
		end
		
		_ED.factor_info[""..info.id] = info
	end
	_ED.factor_info_changed = true
	state_machine.excute("base_reserve_update_draw_page", 0, "")
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_energy_house_is_initialized 14652 --返回能量屋初始化信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_energy_house_is_initialized(interpreter,datas,pos,strDatas,list,count)
	_ED.union_member_energy_info = {}
	_ED.union_accelerate_energy_info = {}
	local memberNumber = tonumber(npos(list))
	for i=1, memberNumber do
		--加速次数,被加速次数|所有位置的开启状态|训练模板ID,训练上次结算时间,SHIP实例ID,实例模板ID,实例等级,实例当前经验,实例当前品级,实例进化编号|...
		local member_id = npos(list)
		local member_data = npos(list)
		_ED.union_member_energy_info[i] = {}
		_ED.union_member_energy_info[i].member_id = member_id
		_ED.union_member_energy_info[i].member_data = member_data
	end
	local accelerateNumber = tonumber(npos(list))
	for i=1, accelerateNumber do
		local accelerate_data = npos(list)
		_ED.union_accelerate_energy_info[i] = accelerate_data
	end
	-- state_machine.excute("sm_union_all_campsite_update",0,"sm_union_all_campsite_update.")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_energy_house_is_initialized_personal 14653 --返回个人能量屋初始化信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_energy_house_is_initialized_personal(interpreter,datas,pos,strDatas,list,count)
	_ED.old_union_personal_energy_info = _ED.union_personal_energy_info
	_ED.union_personal_energy_info = npos(list)
	--加速次数,被加速次数|所有位置的开启状态|训练模板ID,训练上次结算时间,SHIP实例ID,实例模板ID,实例等级,实例当前经验,实例当前品级,实例进化编号|...
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_power_house")--能量屋
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_camping_ground")--工会营地按钮
		state_machine.excute("notification_center_update", 0, "push_notification_center_union_all")--主界面工会按钮
	end
	state_machine.excute("sm_union_all_campsite_update",0,"sm_union_all_campsite_update.")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_the_public_copy_of_the_injury_list 14654 --返回公会副本NPC的伤害排行榜信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_the_public_copy_of_the_injury_list(interpreter,datas,pos,strDatas,list,count)
	local number = tonumber(npos(list))
	_ED.union_battle_rank_list = {}
	for i=1, number do
		local rank = {}
		rank.union_id = npos(list)		--公会id
		rank.union_name = npos(list)	--公会名称
		rank.union_icon = npos(list)	--公会图标
		rank.new_hp = npos(list)	--当前血量
		rank.max_hp = npos(list)	--总血量
		rank.union_AllHurt = npos(list) --公会总伤害
		rank.kill_time = npos(list) --通关时间
		_ED.union_battle_rank_list[i] = {}
		_ED.union_battle_rank_list[i] = rank
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_returns_the_slot_machine_data 14655 --返回老虎机数据
-- ---------------------------------------------------------------------------------------------------------
function parse_returns_the_slot_machine_data(interpreter,datas,pos,strDatas,list,count)
	_ED.union_slot_machine_data = npos(list)
	local datas = zstring.split(_ED.union_slot_machine_data ,",")
	table.sort(datas, function(c1, c2)
		if c1 ~= nil 
            and c2 ~= nil 
            and zstring.tonumber(c1) > zstring.tonumber(c2) then
			return true
		end
		return false
	end)
	_ED.union_slot_machine_data = ""
	for i,v in pairs(datas) do
		if i == 1 then
			_ED.union_slot_machine_data = v
		else
			_ED.union_slot_machine_data = _ED.union_slot_machine_data..","..v
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_to_the_guild_slot_list 14656 --返回公会老虎机的排行榜
-- ---------------------------------------------------------------------------------------------------------
function parse_return_to_the_guild_slot_list(interpreter,datas,pos,strDatas,list,count)
	local number = tonumber(npos(list))	--数量
	_ED.union_slot_machine_rank_list = {}
	for i=1, number do
		local info = {}
		info.user_id = npos(list)	--用户的id
		info.user_head = npos(list)	--用户的头像
		info.user_name = npos(list)	--用户的昵称
		info.vipLevel = npos(list)	--用户的vip
		info.max_number = npos(list)	--火神兽数
		info.get_number = npos(list)	--获得次数
		_ED.union_slot_machine_rank_list[i] = {}
		_ED.union_slot_machine_rank_list[i] = info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_member_copy_damage_ranking_information 14657 --返回公会成员副本NPC的伤害排行榜信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_member_copy_damage_ranking_information(interpreter,datas,pos,strDatas,list,count)
	local number = tonumber(npos(list))	--数量
	_ED.union_member_npc_rank_hurt_list = {}
	for i=1, number do
		local info = {}
		info.user_id = npos(list)	--用户的id
		info.user_name = npos(list)	--用户的昵称
		info.user_hurt = npos(list)	--伤害
		_ED.union_member_npc_rank_hurt_list[i] = {}
		_ED.union_member_npc_rank_hurt_list[i] = info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_the_guild_copy_lucky_reward_information 14658 --返回公会副本NPC战斗幸运奖励信息数量
-- ---------------------------------------------------------------------------------------------------------
function parse_return_the_guild_copy_lucky_reward_information(interpreter,datas,pos,strDatas,list,count)
	local number = tonumber(npos(list))	--数量
	_ED.union_battle_lucky_reworld = {}
	for i=1, number do
		local data = zstring.split(npos(list), "!")
		local info = {}
		info.user_id = data[1]	--用户的id
		info.user_name = data[2]	--用户的昵称
		info.user_reward = data[3]	--奖励参数（类型,id,数量）
		info.user_time = data[4]	--奖励时间
		_ED.union_battle_lucky_reworld[i] = {}
		_ED.union_battle_lucky_reworld[i] = info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_pve_info 14659 --返回军团副本NPC信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_pve_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union_pve_info = _ED.union_pve_info or {}
	
	local receive_count = tonumber(npos(list))	--数量
	for i=1,receive_count do
		local npc_info = {}
		npc_info.index = tonumber(npos(list)) --编号
		npc_info.id = npos(list) 			--npc的id
		npc_info.status = npos(list)		--npc的状态（0未被击杀过，1已经被击杀过）
		npc_info.current_hp = npos(list)	--当前的HP
		npc_info.max_hp = npos(list)	    --最大的HP
		npc_info.reworld_status = npos(list)--奖励领取状态
		npc_info.kill_times = npos(list)--击杀次数
		_ED.union_pve_info[tonumber(npc_info.index)]= npc_info
	end
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_duplicate")
		state_machine.excute("notification_center_update", 0, "push_notification_center_union_all")--主界面工会按钮
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_duplicate_npc_status")
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_duplicate_challenge")--挑战按钮
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_duplicate_reward")--领取按钮
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_union_red_packet_info 14660 --返回军团红包信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_union_red_packet_info(interpreter,datas,pos,strDatas,list,count)
	--总额1，当前剩余1，红包数量，红包剩余，最高人名，最高的额度|...
	_ED.union_red_envelopes_info = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_red_envelopes_grab_the_list_of_information 14661 --返回军团红包抢夺的榜单信息数量 
-- ---------------------------------------------------------------------------------------------------------
function parse_return_red_envelopes_grab_the_list_of_information(interpreter,datas,pos,strDatas,list,count)
	_ED.union_red_envelopes_snatch_list = {}
	local number = tonumber(npos(list))
	for i=1,number do
		local info = {}
		info.id = npos(list) 			--用户id
		info.user_head = npos(list)		--头像
		info.name = npos(list)			--昵称
		info.snatch_number = npos(list)	    --抢红包数量
		info.snatch_quota = npos(list)  --抢到的总金额
		info.snatch_value = npos(list)  --抢到的价值
		_ED.union_red_envelopes_snatch_list[""..info.id]= info
	end
-- 	数量 
-- 用户id 头像 昵称 抢红包数量 抢到的总金额
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_red_packet_personal_message_preview_info 14662 --返回军团红包抢夺的个人预览信息 
-- ---------------------------------------------------------------------------------------------------------
function parse_return_red_packet_personal_message_preview_info(interpreter,datas,pos,strDatas,list,count)
	local number = tonumber(npos(list))
	_ED.union_red_envelopes_my_info = {}
	for i=1, number do
		_ED.union_red_envelopes_my_info[i] = npos(list)
	end
-- 抢夺到的消息数量
-- sender id, sender nickname, reward,time
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_red_packet_personal_rap_list_info 14663 --返回军团红包抢夺的列表
-- ---------------------------------------------------------------------------------------------------------
function parse_return_red_packet_personal_rap_list_info(interpreter,datas,pos,strDatas,list,count)
	local number = tonumber(npos(list))
	_ED.union_red_envelopes_can_be_snatched = {}
	for i=1, number do
		local info = {}
		info.id = npos(list)	--发送者的ID
		info.user_head = npos(list)	--发送者的头像
		info.name = npos(list)	--发送者的昵称
		info.remain_number = npos(list)	--红包剩余数量
		info.mould_id = npos(list)	--红包模板ID
		info.times = npos(list)	--发送的时间
		_ED.union_red_envelopes_can_be_snatched[""..info.times]= info
	end
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_red_envelopes_snatched")--工会抢红包界面抢红包推送
		state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_red_envelopes")--工会主界面红包推送
		state_machine.excute("notification_center_update", 0, "push_notification_center_union_all")--主界面工会按钮
	end
-- 公会当前的红包数量
-- 发送者的ID 发送者的头像 发送者的昵称 红包剩余数量 红包模板ID 发送的时间
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_push_legion_info 14664 --返回军团创建信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_push_legion_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union_push_legion_info = {
		union_rank = npos(list), -- 排名
		union_id = npos(list),	-- 公会id
		union_name = npos(list),	--公会名称 
		union_level = npos(list),	--等级 
		union_president_name = npos(list), -- 会长名称
		union_president_head = npos(list), -- 会长头像
		union_member = npos(list),	--成员数 
		union_watchword = zstring.exchangeFrom(npos(list)),	--公告
		union_appiy = 0,	--申请状态 
		need_verify = npos(list),		    -- 是否需要验证(0:不需要 1:需要)
		need_level = npos(list),		    -- 加入等级
		need_combat_force = npos(list),		-- 加入战力
		union_fight = npos(list),	-- 战力
	}

	-- 弹出窗口
	state_machine.excute("legion_add_push_window_open", 0, "")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_legion_factory_buff_info 14665 --返回军团工厂buff信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_legion_factory_buff_info(interpreter,datas,pos,strDatas,list,count)
	_ED.legion_factory_buff_info = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local buff_type = npos(list)
		local attr = npos(list)
		_ED.legion_factory_buff_info[""..buff_type] = attr
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_legion_occupy_factory_info 14666 --返回军团工厂信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_legion_occupy_factory_info(interpreter,datas,pos,strDatas,list,count)
	_ED.legion_occupy_factory_info = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.factory_id = tonumber(npos(list))
		info.factory_level = tonumber(npos(list))
		_ED.legion_occupy_factory_info[""..info.factory_id] = info
	end

	state_machine.excute("base_reserve_update_draw_page", 0, "")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_union_stick_crazy_adventure_state_info 14667 --返回比利的棍子游戏状态
-- ---------------------------------------------------------------------------------------------------------
function parse_union_stick_crazy_adventure_state_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union_adventure_state_info = npos(list)
	--比利的棍子游戏状态：今日最佳,历史最佳!上次的奖励信息
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_recommend_union_list 14668 --返回推荐工会列表
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_recommend_union_list(interpreter,datas,pos,strDatas,list,count)
	_ED.union.recommend_union_list_sum = npos(list)			--公会数量
	_ED.union.recommend_union_list_info = {}
	for n= 1 ,tonumber(_ED.union.recommend_union_list_sum) do
		local info={
			union_rank = npos(list), -- 排名
			union_id = npos(list),	-- 公会id
			union_name = npos(list),	--公会名称 
			union_level = npos(list),	--等级 
			union_president_name = npos(list), -- 会长名称
			union_member = npos(list),	--成员数 
			union_watchword = zstring.exchangeFrom(npos(list)),	--公告
			union_camp = npos(list),	--工会阵营
			union_appiy = npos(list),	--申请状态 
		}
		if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
			info.need_verify = npos(list)		    -- 是否需要验证(0:不需要 1:需要)
			info.need_level = npos(list)		    -- 加入等级
			info.need_combat_force = npos(list)		-- 加入战力
			info.union_fight = npos(list)	-- 战力
		end
		table.insert(_ED.union.recommend_union_list_info, info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_user_init_info 14669 --返回公会战的用户信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_user_init_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_fight_user_info = {}
	_ED.union.union_fight_user_info.join_state = npos(list)				-- 0:未报名 1:报名中 2:比赛中 3:被淘汰
	_ED.union.union_fight_user_info.bet_info = npos(list)				-- 下注信息
	--预选赛1&预选赛2&预选赛3...
	--1队！2队...
	--模块ID:等级:进化状态:星级:品阶:战力:实例ID:速度:斗魂@下一个武将...
	_ED.union.union_fight_user_info.formation_info = npos(list)
	_ED.union.union_fight_user_info.rank = npos(list)
	_ED.union.union_fight_user_info.win_times = npos(list)
	_ED.union.union_fight_user_info.lose_times = npos(list)
	_ED.union.union_fight_user_info.score = npos(list)
	-- debug.print_r(_ED.union.union_fight_user_info)
	state_machine.excute("union_fighting_join_update_join_state", 0, nil)
	state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_battle_stake")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_battle_init_info 14670 --返回公会战初始化信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_battle_init_info(interpreter,datas,pos,strDatas,list,count)
	local lastState = 0
	if _ED.union.union_fight_battle_info ~= nil then
		lastState = _ED.union.union_fight_battle_info.state
	end
	_ED.union.union_fight_battle_info = {}
	_ED.union.union_fight_battle_info.battle_times = npos(list)		-- -1：非公会战 1：预选赛1 2：预选赛2 3：预选赛3 4：复赛 5：决赛
	_ED.union.union_fight_battle_info.state = npos(list)			--0:未开启 1:报名 2:VIP报名 3:等待比赛开启 4:比赛中 5:结束
	_ED.union.union_fight_battle_info.time = npos(list)
	-- debug.print_r(_ED.union.union_fight_battle_info)
	if lastState ~= _ED.union.union_fight_battle_info.state then
		if tonumber(_ED.union.union_fight_battle_info.state) == 3 then
			_ED.union.union_fight_reports = {}
		end
		state_machine.excute("union_fight_main_update_state", 0, nil)
	end
	state_machine.excute("union_fighting_join_update_join_state", 0, nil)
	state_machine.excute("notification_center_update", 0, "sm_push_notification_center_union_main_window_union_battle")
	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_arena_all")
	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_union_battle")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_union_info 14671 --返回公会战的工会信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_union_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_fight_union_info = {}
	_ED.union.union_fight_union_info.total_score = npos(list)
	_ED.union.union_fight_union_info.current_score = npos(list)
	_ED.union.union_fight_union_info.current_rank = npos(list)
	_ED.union.union_fight_union_info.max_win_name = npos(list)
	_ED.union.union_fight_union_info.max_win_times = npos(list)
	-- debug.print_r(_ED.union.union_fight_union_info)
	state_machine.excute("union_fighting_info_update_info", 0, true)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_union_member_info 14672 --返回公会战的工会信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_union_member_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_fight_member_info = {}
	local count = tonumber(npos(list))
	for i=1,count do
		local info = {
			union_id = npos(list),
			union_name = npos(list),
			total_num = npos(list),
			join_num = npos(list),
			current_num = npos(list),
		}
		table.insert(_ED.union.union_fight_member_info, info)
	end
	-- debug.print_r(_ED.union.union_fight_member_info)
	state_machine.excute("union_fighting_info_update_info", 0, true)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_union_report_info 14673 --返回公会战的战报信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_union_report_info(interpreter,datas,pos,strDatas,list,count)
-- 轮数
-- 胜负,战报id@id,昵称,公会名,头像,等级,队伍,当前血量,最大血量,连胜数@昵称,公会名,头像,等级,队伍,当前血量,最大血量,连胜数|
-- 胜负,战报id@id,昵称,公会名,头像,等级,队伍,当前血量,最大血量,连胜数@昵称,公会名,头像,等级,队伍,当前血量,最大血量,连胜数
-- 下轮的时间点
	_ED.union.union_fight_reports = _ED.union.union_fight_reports or {}
	local round = npos(list)
	local round_info = npos(list)
	local next_begin_time = npos(list)
	local reportInfo = {}
	reportInfo.report_list = {}
	reportInfo.round = tonumber(round)
	reportInfo.next_begin_time = tonumber(next_begin_time)
	round_info = zstring.split(round_info, "|")
	for k,v in pairs(round_info) do
		table.insert(reportInfo.report_list, v)
	end
	_ED.union.union_fight_reports[reportInfo.round] = reportInfo
	state_machine.excute("union_fighting_join_update_draw", 0, nil)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_union_rank_info 14674 --返回公会战的排行信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_union_rank_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_fight_rank_info = _ED.union.union_fight_rank_info or {}
	local rank_count = npos(list)
	for j = 1, zstring.tonumber(rank_count) do
		local rank_type = npos(list)		-- -1：总排行，1：预选赛1, 2：预选赛2, 3：预选赛3, 4：复赛,
		if tonumber(rank_type) == -1 then
			rank_type = 0 					-- 0:总排行
		end
		_ED.union.union_fight_rank_info[""..rank_type] = _ED.union.union_fight_rank_info[""..rank_type] or {}
		-- 公会排行
		_ED.union.union_fight_rank_info[""..rank_type].union_rank = {}
		local count = npos(list)
		for i = 1, zstring.tonumber(count) do
			local info = {}
			info.rank = tonumber(npos(list))
			info.union_id = tonumber(npos(list))
			info.union_name = npos(list)
			info.score = tonumber(npos(list))					-- 积分

			table.insert(_ED.union.union_fight_rank_info[""..rank_type].union_rank, info)
		end
		-- 个人排行
		_ED.union.union_fight_rank_info[""..rank_type].person_rank = {}
		count = npos(list)
		for i = 1, zstring.tonumber(count) do
			local info = {}
			info.rank = tonumber(npos(list))
			info.user_id = tonumber(npos(list))
			info.user_name = npos(list)
			info.union_id = tonumber(npos(list))
			info.union_name = npos(list)
			info.win_times = tonumber(npos(list))				-- 连胜次数
			table.insert(_ED.union.union_fight_rank_info[""..rank_type].person_rank, info)
		end

		_ED.union.union_fight_rank_info[""..rank_type].user_rank = tonumber(npos(list))
		_ED.union.union_fight_rank_info[""..rank_type].win_times = tonumber(npos(list))
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_bet_info 14675 --返回公会战下注信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_bet_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_fight_betting_info = {}
	local count = npos(list)
	for j = 1, zstring.tonumber(count) do
		local info = {}
		info.rank = tonumber(npos(list)) 					-- 公会排名
		info.union_pic = npos(list)							-- 公会图标
		info.union_id = tonumber(npos(list))				-- 公会id
		info.union_name = npos(list)						-- 公会名
		info.union_level = npos(list)						-- 公会等级
		info.percent = math.floor(zstring.tonumber(npos(list))*100)/100	--赔率
		info.betting_count = zstring.tonumber(npos(list))	--下注次数

		table.insert(_ED.union.union_fight_betting_info, info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_duel_info 14676 --返回公会战决赛信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_duel_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_fight_duel_info = _ED.union.union_fight_duel_info or {}
	_ED.union.union_fight_duel_info.next_begin_time = tonumber(npos(list)) / 1000 	-- 距离下场赛次时间间隔

	_ED.union.union_fight_duel_info.battle_info = _ED.union.union_fight_duel_info.battle_info or {}
	_ED.union.union_fight_duel_info.current_battle_type = 0
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local battle_type = tonumber(npos(list)) 		-- 赛次(0:四强赛 1:半决赛 1:决赛)
		_ED.union.union_fight_duel_info.battle_info[""..battle_type] = {}
		local union_count = npos(list)
		for j = 1, zstring.tonumber(union_count) do
			local info = {}
			info.position = tonumber(npos(list)) 	-- 位置
			info.union_id = tonumber(npos(list))	-- 公会id
			info.union_name = npos(list) 			-- 公会名
			info.union_pic = tonumber(npos(list)) 	-- 公会图标
			info.current_num = tonumber(npos(list))	-- 剩余人数
			info.join_num = tonumber(npos(list))	-- 报名人数
			info.win_times = tonumber(npos(list))	-- 胜利场次

			local last_info = _ED.union.union_fight_duel_info.battle_info[""..battle_type][""..info.position]
			if last_info == nil or last_info.win_times < info.win_times then
				_ED.union.union_fight_duel_info.battle_info[""..battle_type][""..info.position] = info 		-- 胜利公会
			end

			if battle_type == 1 then
				local position = 0
				local last_battle_type = 0
				local last_battle_info = _ED.union.union_fight_duel_info.battle_info[""..last_battle_type]
				for k, v in pairs(last_battle_info) do
					if v.union_id == info.union_id then
						position = v.position
						break
					end
				end
				_ED.union.union_fight_duel_info.battle_info[""..battle_type][""..position] = info
			end

			if info.union_id == tonumber(_ED.union.union_info.union_id) then
				_ED.union.union_fight_duel_info.user_battle_type = battle_type 		-- 玩家所在公会匹配信息
				_ED.union.union_fight_duel_info.user_position = info.position 		
			end
		end
		if tonumber(union_count) > 0 then
			_ED.union.union_fight_duel_info.current_battle_type = battle_type
		end
	end
	-- debug.print_r(_ED.union.union_fight_duel_info)
	state_machine.excute("union_fighting_dule_update_draw", 0, "")
	state_machine.excute("union_fighting_dule_info_request_refresh", 0, nil)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_fighting_duel_match_info 14677 --返回公会战决赛匹配信息
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_fighting_duel_match_info(interpreter,datas,pos,strDatas,list,count)
	_ED.union.union_fight_duel_match_info = {}

	_ED.union.union_fight_duel_match_info.battle_type = tonumber(npos(list)) 		-- 赛次(0:四强赛 1:半决赛 2:决赛)
	_ED.union.union_fight_duel_match_info.match_pos = npos(list) 			-- 匹配位置(1,2)
	_ED.union.union_fight_duel_match_info.battle_list = {}
	_ED.union.union_fight_duel_match_info.current_nums = npos(list)
	local count = npos(list) 						-- 战场数量
	for i = 1, zstring.tonumber(count) do
		local battle_num = tonumber(npos(list)) 	-- 战场(1 2 3)
		local info = {}
		info.current_num_info = npos(list)     		-- 当前存活数量(1,2)
		info.union_num_info = npos(list)     		-- 数量对应工会Id(1,2)
		info.report_info_list = {} 					

		local report_info = npos(list)				-- 战报
		if report_info ~= "" then
			report_info = zstring.split(report_info, "!")
			for k, v in pairs(report_info) do
				local round_info = zstring.split(v, "|")
				local report_list_info = {}
				report_list_info.round = k
				report_list_info.report_list = {}
				report_list_info.next_begin_time = 0
				for k1, v1 in pairs(round_info) do
					table.insert(report_list_info.report_list, v1)
				end
				table.insert(info.report_info_list, report_list_info)
			end
		end
		info.total_round = #info.report_info_list 		-- 总轮数
		table.insert(_ED.union.union_fight_duel_match_info.battle_list, info)
	end
	state_machine.excute("union_fighting_dule_info_update_info", 0, nil)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_sm_union_energyhouse_exp_up 14678 --返回公会能量屋经验增加动画的显示
-- ---------------------------------------------------------------------------------------------------------
function parse_sm_union_energyhouse_exp_up(interpreter, datas, pos, strDatas, list, count)
	local data = zstring.split(npos(list), ",")
	_ED.union.union_energyhouse_exp_up = data
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_stronghold_view_score_rank 14800 --返回个人战积分排行榜
-- ---------------------------------------------------------------------------------------------------------
function parse_user_stronghold_view_score_rank(interpreter,datas,pos,strDatas,list,count)
	_ED.user_stronghold_view_score_ranks = _ED.user_stronghold_view_score_ranks or {} -- 0 全服  1 当前服 2 同帮派
	_ED.user_stronghold_rank = _ED.user_stronghold_rank or {} 						  -- 自己的排名
	local nType = npos(list)
	_ED.user_stronghold_rank[""..nType] = npos(list)
	local user_stronghold_view_score_rank = {}
	local nCount = tonumber(npos(list))
	for i=1, nCount do
		local info = {
			user_rank = i,
			user_id = npos(list),
			user_name = npos(list),
			user_gender = npos(list),
			user_head_pic = npos(list),
			user_level = npos(list),
			user_vip = npos(list),
			user_fighting = npos(list),
			user_official_level = npos(list),
			user_score = npos(list),
			user_server_number = npos(list),
			current_server_number = npos(list),
		}
		table.insert(user_stronghold_view_score_rank, info)
	end
	_ED.user_stronghold_view_score_ranks[""..nType] = user_stronghold_view_score_rank
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_user_open_server_recharge_rebate_info 14900 --返回个人开服充值返利信息
-- ---------------------------------------------------------------------------------------------------------
function parse_user_open_server_recharge_rebate_info(interpreter,datas,pos,strDatas,list,count)
	_ED.user_open_server_recharge_rebate_info = _ED.user_open_server_recharge_rebate_info or {}
	_ED.user_open_server_recharge_rebate_info.recharge_money = npos(list)
	_ED.user_open_server_recharge_rebate_info.vip_exp = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_red_alert_time_facebook_reward_info 14901 --返回facebook状态信息
-- ---------------------------------------------------------------------------------------------------------
function parse_red_alert_time_facebook_reward_info(interpreter,datas,pos,strDatas,list,count)
	_ED.redAlertTime_fb_info = _ED.redAlertTime_fb_info or {}
	local count = tonumber(npos(list))
	for i = 1 , count do
		local info = {
			reward_mouldID = npos(list), --模版id
			completeProgress = npos(list),--进度
			reward_state = npos(list), --领奖状态
		}
		_ED.redAlertTime_fb_info[info.reward_mouldID] = info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_a_single_buddy_message 15200 --返回单个好友信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_a_single_buddy_message(interpreter,datas,pos,strDatas,list,count)
	local news_type = tonumber(npos(list)) -- 0添加好友，1删除好友，2刷新好友
	local friendInfo = {
			user_id=npos(list),								--好友ID
			vip_grade=npos(list),	--VIP等级
			head_pic = npos(list),	--头像
			lead_mould_id=npos(list),--废弃
			title=npos(list),		--废弃
			name=npos(list),		--名字
			grade=npos(list),		--等级
			fighting=npos(list),	--战力
			army=npos(list),		--军团
			is_send=npos(list),		--精力赠送
			is_receive = npos(list), --领取状态0不可见,1可见可领取,2可见已领取
			leave_time=npos(list)/1000,	--离线时间
			is_delete=npos(list),	--是否已经删除
			
		}
	local is_index = 1
	if news_type == 1 then
		for i, v in pairs(_ED.friend_info) do
			if v.user_id ~= "" and v.user_id ~= nil and tonumber(v.user_id) == tonumber(friendInfo.user_id) then
				_ED.friend_info[i] = nil
			end
		end
		if fwin:find("SocialFriendTagClass")~= nil then
			state_machine.excute("game_social_friend_tag_delete_friend", 0, friendInfo.user_id)
		end
	elseif news_type == 0 then
		for i, v in pairs(_ED.friend_info) do
			is_index = is_index + 1
		end
		_ED.friend_info[is_index] = friendInfo
		if fwin:find("SocialFriendTagClass")~= nil then
			state_machine.excute("game_social_friend_tag_add_update_friend", 0, friendInfo)
		end
	elseif news_type == 2 then 	
		for i, v in pairs(_ED.friend_info) do
			if v.user_id ~= "" and v.user_id ~= nil and tonumber(v.user_id) == tonumber(friendInfo.user_id) then
				_ED.friend_info[i] = friendInfo
			end
		end
		if tonumber(friendInfo.is_receive) == 1 then
			if fwin:find("SocialFriendEnergeTagClass")~= nil then
				state_machine.excute("game_social_friend_energe_tag_update_draw", 0, "")
			end
			if fwin:find("SocialFriendTagClass")~= nil then
				state_machine.excute("game_social_friend_tag_update_draw", 0, "")
			end
		end
	end
    state_machine.excute("notification_center_update", 0, "push_notification_friend_give_energy")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_friend_receive_the_number_of_information 15201 返回好友耐力领取次数信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_friend_receive_the_number_of_information(interpreter,datas,pos,strDatas,list,count)
	_ED.friendRecipientsNumber = tonumber(npos(list))				--已领取次数
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_to_increase_the_masking_information 15202 返回增加屏蔽信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_to_increase_the_masking_information(interpreter,datas,pos,strDatas,list,count)
	local black_users = {
				user_id = npos(list),		--屏蔽id
				shield_user_id = npos(list),--用户
				vip_grade = npos(list),		--vip等级
				head_pic = npos(list),		--头像
				lead_mould_id = npos(list),	--废弃
				title = npos(list),			--废弃
				name = npos(list),			--昵称
				grade = npos(list),			--等级
				fighting  = npos(list),		--战力
				army = npos(list),			--军团
				leave_time = npos(list),	--最后登录时间
			}
	local index = 1
	for i, v in pairs(_ED.black_user) do
		if v ~= nil and v~="" then
			index = index + 1
		end	
	end
	_ED.black_user[index] = black_users
end


-- ---------------------------------------------------------------------------------------------------------
-- parse_return_the_masked_information 15203 返回解除屏蔽信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_the_masked_information(interpreter,datas,pos,strDatas,list,count)
	local user_id = tonumber(npos(list))				--用户id 
	for i, v in pairs(_ED.black_user) do
		if tonumber(v.shield_user_id) == user_id then
			_ED.black_user[i] = nil
		end
	end
end



-- ---------------------------------------------------------------------------------------------------------
-- parse_world_info_request 15100 返回世界信息初始化
-- ---------------------------------------------------------------------------------------------------------
function parse_world_info_request(interpreter,datas,pos,strDatas,list,count)
	-- _ED.world_map = _ED.world_map or {}
	-- _ED.world_map.world_level = npos(list)				--世界等级
	_ED.world_level = npos(list)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_map_arena_info_refresh_request 15101 返回世界地图区域信息刷新
-- ---------------------------------------------------------------------------------------------------------
function parse_world_map_arena_info_refresh_request(interpreter,datas,pos,strDatas,list,count)
	_ED.world_map = _ED.world_map or {}
	_ED.world_map.world_map_info_list = _ED.world_map.world_map_info_list or {}
	local nCount = tonumber(npos(list))
	for i = 1, nCount do
		-- local info = {
		-- 	_x = tonumber(npos(list)),
		-- 	_y = tonumber(npos(list)),
		-- 	_type = tonumber(npos(list)),
		-- 	_id = tonumber(npos(list))
		-- }
		-- if info._type > 0 then
		-- 	info._mould_id = npos(list)
		-- 	info._quality = tonumber(npos(list))
		-- else
		-- 	info._nickname = npos(list)
		-- 	info._level = npos(list)
		-- 	info._union_name = tonumber(npos(list))
		-- 	info._glories = tonumber(npos(list))
		-- 	info._max_boom = tonumber(npos(list))
		-- end
		-- _ED.world_map.world_map_info_list[info._x .. "," .. info._y] = info
		parse_world_map_arena_info_element(interpreter,datas,pos,strDatas,list,count)
	end
	-- debug.print_r(_ED.world_map)
	state_machine.excute("adventure_mine_update_map_draw", 0, 0)
end

function parse_world_map_arena_info_element(interpreter,datas,pos,strDatas,list,count)
	local _x = tonumber(npos(list))
	local _y = tonumber(npos(list))
	local info = _ED.world_map.world_map_info_list[_x .. "," .. _y]
	local quality = -1
	local user_id = -1
	local old_glories = -1
	local old_max_boom = -1
	local old_boom_restore_time = -1
	local old_online_state = -1
	local old_shield_end_time = -1
	local old_type = -1
	local old_x = -1
	local old_y = -1
	local old_level = -1
	local old_talent_id = -1
	local old_now_hp = -1
	local old_total_num = -1
	local old_progress = -1
	local old_progress_tick_time = -1
	local old_capture_start_time = -1
	local old_city_state = -1
	local old_add_time_speed = -1
	local old_union_name = ""
	local old_progress_union_name = ""
	local old_factory_level = -1

	if nil == info then
		info = {}
	else
		quality = info._quality
		user_id = info._userId
		old_glories = info._glories
		old_max_boom = info._max_boom
		old_boom_restore_time = info._boom_restore_time
		old_online_state = info._online_state
		old_shield_end_time = info._shield_end_time
		old_type = info._type
		old_x = info._x
		old_y = info._y
		old_level = info._level
		old_talent_id = info.talent
		old_now_hp = info._now_hp
		old_total_num = info._total_num
		old_progress = info._progress
		old_progress_tick_time = info._progress_tick_time
		old_capture_start_time = info._capture_start_time
		old_city_state = info._city_state
		old_add_time_speed = info._add_time_speed
		old_union_name = info._union_name
		old_progress_union_name = info._progress_union_name
		old_factory_level = info._factory_level
	end

	info._x = _x
	info._y = _y
	info._type = tonumber(npos(list))

	local userId = -1
	if info._type >= 0 then
		info._id = tonumber(npos(list))
		
		userId = tonumber(npos(list))
		info._userId = userId
		if info._type > 0 then
			info._mould_id = npos(list)
			info._quality = tonumber(npos(list))
			info._mining_time = tonumber(npos(list))
			info._quality_level_up_exp = tonumber(npos(list))
			info._union_id = 0
			if info._type == 1000 then
				info._now_hp = tonumber(npos(list))
				info._max_hp = tonumber(npos(list))
				if info._now_hp <= 0 then
					if info._death == true then
						info._type = -1
					end
				elseif info._now_hp > 0 then
					info._death = nil
				end
			elseif info._type == 2000 then
				info.boss_info = {}
				for i=1,5 do
					local bossInfo = {}
					bossInfo.index = tonumber(npos(list))
					bossInfo.total_hp = tonumber(npos(list))
					bossInfo.current_hp = tonumber(npos(list))
					table.insert(info.boss_info, bossInfo)
				end
			elseif info._type == 3000
				or info._type == 3001
				or info._type == 3002
				then
				info._total_num = tonumber(npos(list))
				info._progress = tonumber(npos(list))/1000
				info._progress_tick_time = tonumber(npos(list))
				info._progress_start_time = os.time()
				info._progress_union_name = npos(list)
				info._union_name = npos(list)
				info._capture_start_time = tonumber(npos(list)) / 1000
				info._capture_cd_time = tonumber(npos(list)) / 1000
				info._city_state = tonumber(npos(list))
				info._add_time_speed = (100 + tonumber(npos(list)))/100
				info._factory_level = tonumber(npos(list))
				info._factory_start_time = tonumber(npos(list)) / 1000
			else
				info.talent = npos(list)	--"天赋id,天赋类型,天赋起始时间,天赋结束时间|天赋id,天赋类型,天赋起始时间,天赋结束时间"
				info._talent_id = {}
				info._talent_end_time = {}
				info._talent_sta_time = {}
				if info.talent~="" and info.talent ~= nil then
					local m_talent_data = zstring.split(info.talent, "|")
					for i, v in pairs(m_talent_data) do
						local datas = zstring.split(v, ",")
						info._talent_id[datas[2]] = datas[1]
						info._talent_end_time[datas[2]] = datas[4]
						info._talent_sta_time[datas[2]] = datas[3]
					end
				end
				info._union_id = tonumber(npos(list))
			end
		else
			info._nickname = npos(list)
			info._level = npos(list)
			info._combat_force = npos(list)
			info._union_id = tonumber(npos(list))
			info._union_name = npos(list)
			info._shield_end_time = tonumber(npos(list))
			info._talent_id = {}
			info._talent_end_time = {}
			info._talent_sta_time = {}
			info.talent = npos(list)	--"天赋id,天赋类型,天赋起始时间,天赋结束时间|天赋id,天赋类型,天赋起始时间,天赋结束时间"
			if info.talent~="" and info.talent ~= nil then
				local m_talent_data = zstring.split(info.talent, "|")
				for i, v in pairs(m_talent_data) do
					local datas = zstring.split(v, ",")
					info._talent_id[datas[2]] = datas[1]
					info._talent_end_time[datas[2]] = datas[4]
					info._talent_sta_time[datas[2]] = datas[3]
				end
			end
			info._ruin_name = npos(list)--暂时屏蔽
			info._glories = tonumber(npos(list))
			info._max_boom = tonumber(npos(list))
			info._boom_restore_time = tonumber(npos(list))
			info._online_state = tonumber(npos(list))
		end
	end
	info._bg_pix = npos(list)
	info._free_end_time = tonumber(npos(list)) / 1000
	if old_x ~= info._x 
		or old_y ~= info._y 
		or old_type ~= info._type 
		or userId ~= user_id 
		or info._quality ~= quality 
		or old_glories ~= info._glories 
		or old_boom_restore_time ~= info._boom_restore_time
		or old_online_state ~= info._online_state
		or old_shield_end_time ~= info._shield_end_time
		or old_shield_end_time ~= info._shield_end_time 
		or old_level ~= info._level 
		or old_talent_id ~= info.talent
		or old_now_hp ~= info._now_hp
		or old_total_num ~= info._total_num
		or old_progress ~= info._progress
		or old_progress_tick_time ~= info._progress_tick_time
		or old_capture_start_time ~= info._capture_start_time
		or old_city_state ~= info._city_state
		or old_add_time_speed ~= info._add_time_speed
		or old_union_name ~= info._union_name
		or old_progress_union_name ~= info._progress_union_name
		or old_factory_level ~= info._factory_level
		or info._type == 2000
		then
		info._need_update = true
	end

	if old_type == 0 and user_id > 0 then

	end
	if info._type == 0 and userId > 0 then
	
	end

	if info._type == 0 and userId > 0 then
		_ED.world_map.world_map_user_list = _ED.world_map.world_map_user_list or {}
		local tinfos = _ED.world_map.world_map_user_list[userId]
		if tinfos == nil then
			tinfos = {}
			_ED.world_map.world_map_user_list[userId] = tinfos
		end
		tinfos[info._x .. "," .. info._y] = info
		for i, v in pairs(tinfos) do
			if nil ~= v and v ~= info 
				and v._userId == userId
				then
				tinfos[i] = nil
				v._type = -1 			-- 清除之前的基地信息
				v._need_update = true
			end
		end
	end

	_ED.world_map.world_map_info_list[info._x .. "," .. info._y] = info
end


-- ---------------------------------------------------------------------------------------------------------
-- parse_world_map_personal_information_request 15102 返回世界地图个人信息
-- ---------------------------------------------------------------------------------------------------------
function parse_world_map_personal_information_request(interpreter,datas,pos,strDatas,list,count)
	_ED.world_map = _ED.world_map or {}
	-- _ED.world_map.personal_exp_bonus = npos(list)		--当前个人经验加成
	_ED.world_map.city_id = npos(list)					--城池实例ID
	local position_x = tonumber(npos(list))	--坐标X
	local position_y = tonumber(npos(list))	--坐标Y
	local isUpdate = false
	if zstring.tonumber(_ED.world_map.position_coordinates_x) == 0 and zstring.tonumber(_ED.world_map.position_coordinates_y) == 0 then
		isUpdate = false
	else
		if zstring.tonumber(_ED.world_map.position_coordinates_x) ~= position_x or zstring.tonumber(_ED.world_map.position_coordinates_y)~=position_y then
			isUpdate = true
		end
	end	
	_ED.world_map.position_coordinates_x = position_x	--坐标X
	_ED.world_map.position_coordinates_y = position_y	--坐标Y
	if isUpdate == true then
		state_machine.excute("adventure_mine_record_view_position", 0, {_ED.world_map.position_coordinates_x,_ED.world_map.position_coordinates_y})
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_search_info 15103 返回世界地图搜索信息
-- ---------------------------------------------------------------------------------------------------------
function parse_world_search_info(interpreter,datas,pos,strDatas,list,count)
	_ED.world_map = _ED.world_map or {}
	_ED.world_map.search_info = _ED.world_map.search_info or {}
	_ED.world_map.search_info = {}
	local nCount = tonumber(npos(list))
	for i = 1, nCount do
		local info = {
			_id = npos(list),
			_type = tonumber(npos(list)),
			_x = tonumber(npos(list)),
			_y = tonumber(npos(list)),
			_times = npos(list),
			_free_end_time = tonumber(npos(list)) / 1000,
		}
		if info._type > 0 then
			info._mould_id = npos(list)
			info._user_info = npos(list)
			info._talent_id = {}
			info._talent_end_time = {}
			info._talent_sta_time = {}
			info.talent = npos(list)	--"天赋id,天赋类型,天赋起始时间,天赋结束时间|天赋id,天赋类型,天赋起始时间,天赋结束时间"
			if info.talent~="" and info.talent ~= nil then
				local m_talent_data = zstring.split(info.talent, "|")
				for i, v in pairs(m_talent_data) do
					local datas = zstring.split(v, ",")
					info._talent_id[datas[2]] = datas[1]
					info._talent_end_time[datas[2]] = datas[4]
					info._talent_sta_time[datas[2]] = datas[3]
				end
			end
			info._quality = tonumber(npos(list))
			info._mining_time = tonumber(npos(list))
			info._quality_level_up_exp = tonumber(npos(list))
		else
			info._user_info = npos(list)
			info._nickname = npos(list)
			info._level = npos(list)
			info._vip_level = npos(list)
			info._combat_force = npos(list)
			info._head_pic = npos(list)
			info._head_orn = npos(list)
			info._glories = tonumber(npos(list))
			info._max_boom = tonumber(npos(list))
			info._boom_restore_time = tonumber(npos(list))
			info._online_state = tonumber(npos(list))
		end
		_ED.world_map.search_info[info._id] = info
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_coord_collect_info 15104 返回世界地图收藏信息
-- ---------------------------------------------------------------------------------------------------------
function parse_world_coord_collect_info(interpreter,datas,pos,strDatas,list,count)
	_ED.world_map = _ED.world_map or {}
	_ED.world_map.coord_collent = _ED.world_map.coord_collent or {}
	local nCount = tonumber(npos(list))
	for i = 1, nCount do
		-- key1 = colletType   key2 = objectType,id  eg:0-0,39484
		local keys = zstring.split(npos(list), "-")
		local value = zstring.split(npos(list), "|")
		local info = {
			name = value[1],
			level = value[2],
			coords = value[3],
		}
		if _ED.world_map.coord_collent == nil then
			_ED.world_map.coord_collent = {}
		end
		local valueList = _ED.world_map.coord_collent[keys[1]]
		if nil == valueList then
			 valueList = {}
			 _ED.world_map.coord_collent[keys[1]] = valueList
		end
		valueList[keys[2]] = info
		--判断是人还是矿,矿名字读表
		local curr_data = zstring.split(keys[2], ",")
		if tonumber(curr_data[1]) > 0 then
			local element = dms.element(dms["world_mine_mould"], tonumber(valueList[keys[2]].name))
			if element ~= nil then
				valueList[keys[2]].name = dms.atos(element, world_mine_mould.name)
			end
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_map_remove_tile_info 15105 返回世界地图地图信息清除
-- ---------------------------------------------------------------------------------------------------------
function parse_world_map_remove_tile_info(interpreter,datas,pos,strDatas,list,count)
	local removeX = tonumber(npos(list))	--坐标X
	local removeY = tonumber(npos(list))	--坐标Y
	local info = _ED.world_map.world_map_info_list[removeX .. "," .. removeY]
	if nil ~= info then
		info._type = -1
		info._need_update = true
	end
	state_machine.excute("adventure_mine_update_map_draw", 0, 0)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_map_arena_info_chnage 15106 返回世界地图区域信息变更
-- ---------------------------------------------------------------------------------------------------------
function parse_world_map_arena_info_chnage(interpreter,datas,pos,strDatas,list,count)
	_ED.world_map = _ED.world_map or {}
	_ED.world_map.world_map_info_list = _ED.world_map.world_map_info_list or {}
	_ED.world_map.investigate_info = _ED.world_map.investigate_info or {}
	parse_world_map_arena_info_element(interpreter,datas,pos,strDatas,list,count)
	state_machine.excute("adventure_mine_update_map_draw", 0, 0)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_map_investigate_info 15107 返回世界地图侦查信息
-- ---------------------------------------------------------------------------------------------------------
function parse_world_map_investigate_info(interpreter,datas,pos,strDatas,list,count)
	-- _ED.world_map.investigate_info = _ED.world_map.investigate_info or {}
	_ED.world_map = _ED.world_map or {}
	local investigate_info = {}
	investigate_info._id = npos(list)
	investigate_info._type = tonumber(npos(list))
	investigate_info._x = tonumber(npos(list))
	investigate_info._y = tonumber(npos(list))
	investigate_info._times = npos(list)
	investigate_info._free_end_time = tonumber(npos(list)) / 1000
	if 1000 == investigate_info._type then
		local info = zstring.split(npos(list), ",")
		investigate_info._rebel_mould_id = tonumber(info[1])
		investigate_info._npc_id = dms.int(dms["rebel_haunt_mould"], investigate_info._rebel_mould_id, rebel_haunt_mould.npc_mould_id)
		investigate_info.formation_count = {} 		-- 
		for i = 1, 6 do
			table.insert(investigate_info.formation_count, tonumber(info[i+1]))
		end
	elseif 0 == investigate_info._type then
		investigate_info._union_name = npos(list)
		investigate_info._nickname = npos(list)
		investigate_info._level = npos(list)
		investigate_info._formation_info = npos(list)
		investigate_info._rob_iron_count = npos(list)
		investigate_info._rob_oil_count = npos(list)
		investigate_info._rob_lead_count = npos(list)
		investigate_info._rob_titanium_count = npos(list)
		investigate_info._rob_store_count = npos(list)
	else
		investigate_info._user_id = tonumber(npos(list))
		if investigate_info._user_id > 0 then
			investigate_info._union_name = npos(list)
			investigate_info._nickname = npos(list)
			investigate_info._level = npos(list)
			investigate_info._formation_info = npos(list)
		end
		investigate_info._mould_id = npos(list)
		investigate_info._quality = tonumber(npos(list))
		investigate_info._npc_id = npos(list)
		investigate_info._rob_count = npos(list)
	end
	_ED.world_map.investigate_info = investigate_info
end


-- ---------------------------------------------------------------------------------------------------------
-- parse_world_target_event_info 15108 返回世界地图事件信息
-- ---------------------------------------------------------------------------------------------------------
function parse_world_target_event_info(interpreter,datas,pos,strDatas,list,count)
	_ED.world_map = _ED.world_map or {}
	_ED.world_map.target_event_info = _ED.world_map.target_event_info or {}
	local nCount = tonumber(npos(list))
	local isUpdateReward = false
	local isUpdateTank = false
	local isUpdateBoom = false
	local isUpdateResource = false
	for i = 1, nCount do
		local _user_info = npos(list)
		local _time = tonumber(npos(list))
		local _event_type = tonumber(npos(list))
		local _sx = tonumber(npos(list))
		local _sy = tonumber(npos(list))
		local _dx = tonumber(npos(list))
		local _dy = tonumber(npos(list))
		
		local last_state = -1
		local key = "" .. _user_info .. "," .. _time .. "," .. _dx .. "," .. _dy
		local info = _ED.world_map.target_event_info[key]
		if nil == info then
			info = {}
			_ED.world_map.target_event_info[key] = info
		else
			last_state = info._event_type
		end
		info._last_state = last_state
		info._user_info = _user_info
		info._time = _time
		info._event_type = _event_type
		info._sx = _sx
		info._sy = _sy
		info._dx = _dx
		info._dy = _dy
		info._start_time = tonumber(npos(list))
		info._complete_time = tonumber(npos(list))
		info._target_type = tonumber(npos(list))
		info._target_id = tonumber(npos(list))
		info._quality = tonumber(npos(list))
		info._world_mine_mould_id = tonumber(npos(list))
		info._prev_out_put = tonumber(npos(list))
		info._max_out_put = tonumber(npos(list))
		info._formation_info = npos(list)
		-- if 0 == info._target_type or info._target_type >= 6 then
		info._nickname = npos(list)
		info._level = npos(list)
		info._help_defend_state = tonumber(npos(list)) -- 部队协防状态 0：待命， 1：协防中
		info._combat_force = tonumber(npos(list)) -- 部队战力
		info._bonus_value = tonumber(npos(list))	--加成值
		info._attack_union_id = tonumber(npos(list))	--攻击者军团id
		info._beAttack_union_id = tonumber(npos(list))	--目标者军团id
		npos(list)

		-- end
		if info._event_type == 10 then
			checkRewardObtainDraw()
			info._update = true
			state_machine.excute("red_alert_time_mine_event_queue_march_update_two", 0, info._event_type)
			if info._event_cell~= nil then
				state_machine.excute("world_event_struck_list_cell_update_list_info", 0, {info._event_cell, info._event_type})
			end
			if info._event_defense_cell ~= nil then
				state_machine.excute("world_event_defense_list_cell_update_list_info", 0, {info._event_defense_cell, info._event_type})
			end
		else
			info._update = false
			if info._event_type == 11 then
				state_machine.excute("red_alert_time_mine_event_queue_refresh_the_interface_list", 0, 0)
				state_machine.excute("red_alert_time_mine_event_queue_struck_update_two", 0, info)
			elseif info._event_type == 13 or info._event_type == 14 then
				--协防
				state_machine.excute("red_alert_time_mine_event_queue_refresh_the_interface_list", 0, 0)
				state_machine.excute("red_alert_time_mine_event_queue_defense_update_two", 0, info)
			elseif info._event_type == 18 then
				state_machine.excute("world_nearby_list_cell_update_list_info", 0, {info._event_cell, info._event_type})		
			end
		end
		
		if info._event_type > 10 and info._event_type < 13 then
			info.struck_index = 1
			info.march_index = 0
			info.defense_index = 0
		elseif info._event_type < 10 or info._event_type == 18 then
			info.march_index = 1
			info.struck_index = 0
			info.defense_index = 0
		elseif info._event_type >= 13 and info._event_type < 18 then
			info.march_index = 0
			info.struck_index = 0
			info.defense_index = 1
		end

		if last_state < 13 then
			if info._event_type == 1 then
				if last_state == 0 then
					isUpdateReward = true
					isUpdateTank = true
				end
			elseif info._event_type == 5 then
				if last_state == 0 then
					isUpdateReward = true
				end
			elseif info._event_type == 10 then
				if last_state == 11 then
					isUpdateReward = true
					isUpdateTank = true
					isUpdateBoom = true
					isUpdateResource = true
				elseif last_state == 1 
					or last_state == 4
					or last_state == 5 
					then
					isUpdateReward = true
					isUpdateResource = true
					isUpdateTank = true
					isUpdateBoom = true
				end
			end
		elseif last_state == 18
			or last_state == 23
			then
			isUpdateTank = true
		elseif last_state == 19 then
			isUpdateReward = true
			isUpdateResource = true
		end
	end

	fwin:addService({
		callback = function ( params )
			if params[1] == true then
				checkRewardObtainDraw()
				checkEffectLevelUp()
			end
			if params[2] == true then
				state_machine.excute("main_window_update_resource", 0, nil)
				state_machine.excute("red_alert_time_mine_update_players_resources", 0, nil)
			end
			if params[3] == true then
				state_machine.excute("home_map_update_tanke_info", 0, "")
			end
			if params[4] == true then
				state_machine.excute("main_window_update_boom_info", 0, nil)
			end
		end,
		delay = 0.4,
		params = {isUpdateReward, isUpdateResource, isUpdateTank, isUpdateBoom}
	})

	state_machine.excute("red_alert_time_mine_event_queue_set_event_type_show", 0, 0)
	-- state_machine.excute("notification_center_update", 0, "push_notification_queue_march")
	-- state_machine.excute("notification_center_update", 0, "push_notification_queue_struck")
	state_machine.excute("world_battle_event_info_update_draw", 0, nil)
	state_machine.excute("world_battle_path_manager_update_path", 0, nil)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_by_rob_update_user_info 15109 返回玩家被掠夺后的资源信息
-- ---------------------------------------------------------------------------------------------------------
function parse_world_by_rob_update_user_info(interpreter,datas,pos,strDatas,list,count)
	local iron = npos(list)
	local oil = npos(list)
	local lead = npos(list)
	local titanium = npos(list)
	local silver = npos(list)
	local glories = npos(list)

	_ED.user_info.user_iron = tonumber(iron)
	_ED.user_info.oil_field = tonumber(oil)
	_ED.user_info.exploits = tonumber(lead)
	_ED.user_info.tiger_shaped = tonumber(titanium)
	_ED.user_info.user_silver = tonumber(silver)
	_ED.user_info.booming = tonumber(glories)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_rebel_haunt_state_info 15110 返回叛军活动状态
-- ---------------------------------------------------------------------------------------------------------
function parse_rebel_haunt_state_info(interpreter,datas,pos,strDatas,list,count)
	_ED.user_rebel_haunt_last_state = _ED.user_rebel_haunt_state
	_ED.user_rebel_haunt_state = tonumber(npos(list))		--(0结束，1开启)
	_ED.user_rebel_haunt_open_list_state = tonumber(npos(list))		--(0小兵，1佣兵，2头领)
	if _ED.mould_function_push_info["5"] ~= nil then
		_ED.mould_function_push_info["5"].state = _ED.user_rebel_haunt_state
	end
    local function responseCallback(response)
        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
			state_machine.excute("rebel_haunt_list_update", 0, nil)
        end
    end
    if _ED.user_rebel_haunt_state == 0 then
    	state_machine.excute("rebel_haunt_list_update", 0, nil)
    else
	    protocol_command.rebel_haunt_list_init.param_list = ""
	    NetworkManager:register(protocol_command.rebel_haunt_list_init.code, nil, nil, nil, nil, responseCallback, false, nil)
	end
	state_machine.excute("main_window_update_rebels_window",0,0)
	state_machine.excute("red_alert_time_mine_update_rebels_state", 0, nil)

	if __lua_project_id == __lua_project_red_alert_time or __lua_project_id == __lua_project_pacific_rim then
		state_machine.excute("notification_center_update", 0, "push_notification_mine_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_in_box_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_push")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_attack")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_defense")
		state_machine.excute("notification_center_update", 0, "push_notification_mine_report_scout")
		state_machine.excute("notification_center_update", 0, "push_notification_campaign_cell")
		state_machine.excute("notification_center_update", 0, "push_notification_all_daily_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_all_linited_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_all_inter_service_campaign")
		state_machine.excute("notification_center_update", 0, "push_notification_campaign_expedition")
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_rebel_haunt_list_info 15111 返回叛军列表
-- ---------------------------------------------------------------------------------------------------------
function parse_rebel_haunt_list_info(interpreter,datas,pos,strDatas,list,count)
	_ED.user_rebel_haunt_list_info = _ED.user_rebel_haunt_list_info or {}
	local nType = npos(list)				--(0小兵，1佣兵，2头领)
	local count = tonumber(npos(list))
	_ED.user_rebel_haunt_list_info[""..nType] = {}
	for i=1, count do
		local info = {}
		info._id = tonumber(npos(list))
		info._type = tonumber(npos(list))
		info._x = tonumber(npos(list))
		info._y = tonumber(npos(list))
		info._current_time = math.floor(tonumber(npos(list)) / 1000)
		info._free_end_time = math.floor(tonumber(npos(list)) / 1000)
		info._mould_id = tonumber(npos(list))
		info._kill_name = npos(list)
		info._hp = tonumber(npos(list))
		info._max_hp = tonumber(npos(list))
		table.insert(_ED.user_rebel_haunt_list_info[""..nType], info)
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_rebel_haunt_user_info 15112 返回用户叛军信息
-- ---------------------------------------------------------------------------------------------------------
function parse_rebel_haunt_user_info(interpreter,datas,pos,strDatas,list,count)
	_ED.user_rebel_haunt_user_info = {}
	_ED.user_rebel_haunt_user_info.today_kill_count = tonumber(npos(list))
	_ED.user_rebel_haunt_user_info.weak_kill_info = npos(list)
	_ED.user_rebel_haunt_user_info.weak_score = tonumber(npos(list))
	_ED.user_rebel_haunt_user_info.last_weak_rank = tonumber(npos(list))
	_ED.user_rebel_haunt_user_info.total_kill_info = npos(list)
	_ED.user_rebel_haunt_user_info.total_score = tonumber(npos(list))
	_ED.user_rebel_haunt_user_info.get_reward_state = tonumber(npos(list))	--(0不可,1可领,2已领)
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_rebel_haunt_rank_info 15113 返回叛军排行信息
-- ---------------------------------------------------------------------------------------------------------
function parse_rebel_haunt_rank_info(interpreter,datas,pos,strDatas,list,count)
	local nType = tonumber(npos(list))
	local count = tonumber(npos(list))
	if nType == 0 then
		_ED.user_rebel_haunt_weak_rank_info = {}
	else
		_ED.user_rebel_haunt_total_rank_info = {}
	end
	for i=1, count do
		local info = {}
		info.rank = i
		info.user_id = tonumber(npos(list))
		info.user_name = npos(list)
		info.kill_info = npos(list)
		info.score = tonumber(npos(list))
		if nType == 0 then
			table.insert(_ED.user_rebel_haunt_weak_rank_info, info)
		else
			table.insert(_ED.user_rebel_haunt_total_rank_info, info)
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_rebel_map_haunt_info 15114 返回地图叛军信息
-- ---------------------------------------------------------------------------------------------------------
function parse_rebel_map_haunt_info(interpreter,datas,pos,strDatas,list,count)
	local info = {}
	info._id = tonumber(npos(list))
	info._type = tonumber(npos(list))
	info._x = tonumber(npos(list))
	info._y = tonumber(npos(list))
	info._mould_id = tonumber(npos(list))
	info._kill_name = npos(list)
	info._hp = tonumber(npos(list))
	info._max_hp = tonumber(npos(list))

	for k,list_info in pairs(_ED.user_rebel_haunt_list_info) do
		for k1,v1 in pairs(list_info) do
			if tonumber(info._x) == tonumber(v1._x) and tonumber(info._y) == tonumber(v1._y) then
				v1 = info
			end
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_reconnaissance 15115 返回道具侦察定位
-- ---------------------------------------------------------------------------------------------------------
function parse_return_reconnaissance(interpreter,datas,pos,strDatas,list,count)
	local positioning_x = tonumber(npos(list))
	local positioning_y = tonumber(npos(list))
	state_machine.excute("adventure_mine_record_view_position", 0, {positioning_x,positioning_y})
	state_machine.excute("adventure_mine_manager_props_reconnaissance", 0, "")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_haunt_factor_info 返回用户叛军限时增益信息 15116
-- ---------------------------------------------------------------------------------------------------------
function parse_return_haunt_factor_info( interpreter,datas,pos,strDatas,list,count )
	_ED.factor_info = _ED.factor_info or {}
	local count = tonumber(npos(list))
	if count == 0 then
		_ED.factor_info["0"] = nil
	end
	for i=1, count do
		local info = {}
		info.id = "0"				-- 增益实例id
		info.mould_id = npos(list) 		    -- 增益模板id
		info.factor_type = npos(list) 		-- 增益类型
		info.factor_obj = npos(list)		-- 增益对象
		info.factor_start_time = math.floor(zstring.tonumber(npos(list))/1000)		-- 增益开始时间
		info.factor_cd_time = math.floor(zstring.tonumber(npos(list))/1000)		-- 增益cd时间

		-- info.build_buff_id = 0 			-- 索引建筑增益光环模板id
		-- local build_ids = zstring.split(dms.string(dms["talent_mould"], info.mould_id, talent_mould.build_buff_id), ",")
		-- if #build_ids == 1 then 
		-- 	info.build_buff_id = tonumber(build_ids[1])
		-- else
			info.build_buff_id = tonumber(info.factor_obj)
		-- end
		
		_ED.factor_info[""..info.id] = info
	end
	_ED.factor_info_changed = true
	state_machine.excute("base_reserve_update_draw_page", 0, "")
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_rebel_haunt_list_info_update 15117 返回叛军活动变更
-- ---------------------------------------------------------------------------------------------------------
function parse_rebel_haunt_list_info_update(interpreter,datas,pos,strDatas,list,count)
	local info = {}
	info._id = tonumber(npos(list))
	info._type = tonumber(npos(list))
	info._x = tonumber(npos(list))
	info._y = tonumber(npos(list))
	info._current_time = math.floor(tonumber(npos(list)) / 1000)
	info._mould_id = tonumber(npos(list))
	info._kill_name = npos(list)
	info._hp = tonumber(npos(list))
	info._max_hp = tonumber(npos(list))

	for k,rebelHauntList in pairs(_ED.user_rebel_haunt_list_info) do
		for k1,v in pairs(rebelHauntList) do
			if tonumber(v._mould_id) == tonumber(info._mould_id) then
				_ED.user_rebel_haunt_list_info[k][k1] = info
				state_machine.excute("rebel_haunt_list_update", 0, nil)
				return
			end
		end
	end
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_to_defense_settings 15118 返回协防设置
-- ---------------------------------------------------------------------------------------------------------
function parse_return_to_defense_settings(interpreter,datas,pos,strDatas,list,count)
	_ED.legion_world_defense_type = tonumber(npos(list))	--军团世界协防类型
end

---------------------------------------------------------------------------------------------------------
--parse_world_map_help_defence_investigate_info 15119 返回世界地图协防侦查信息
---------------------------------------------------------------------------------------------------------
function parse_world_map_help_defence_investigate_info(interpreter,datas,pos,strDatas,list,count)
	_ED.world_map.investigate_info._formation_info = npos(list)
	local name_info = zstring.split(npos(list), ",")
	_ED._help_defence_name = name_info[1]
	_ED._help_defence_level = name_info[2]
end

---------------------------------------------------------------------------------------------------------
--parse_world_map_refresh_all_info 15121 返回刷新世界地图信息
---------------------------------------------------------------------------------------------------------
function parse_world_map_refresh_all_info(interpreter,datas,pos,strDatas,list,count)
	state_machine.excute("red_alert_time_mine_event_queue_reset_all_lists", 0, nil)
	state_machine.excute("world_battle_event_info_update_draw", 0, nil)
    fwin:addService({
		callback = function ( params )
			checkRewardObtainDraw()
		    checkEffectLevelUp()
		    state_machine.excute("main_window_update_resource", 0, nil)
		    state_machine.excute("main_window_update_boom_info", 0, nil)
		    state_machine.excute("home_map_update_tanke_info", 0, "")
		    state_machine.excute("red_alert_time_mine_update_players_resources", 0, nil)
		end,
		delay = 0.4,
		params = nil
	})
end

---------------------------------------------------------------------------------------------------------
--parse_world_all_attack_event_path_info 15122 返回世界行军路径信息
---------------------------------------------------------------------------------------------------------
function parse_world_all_attack_event_path_info(interpreter,datas,pos,strDatas,list,count)
	if nil ~= _ED.world_map then
		_ED.world_map.all_target_event_info = _ED.world_map.all_target_event_info or {}
	end
	local nCount = tonumber(npos(list))
	local isUpdateReward = false
	local isUpdateTank = false
	local isUpdateBoom = false
	local isUpdateResource = false
	for i = 1, nCount do
		local _user_info = npos(list)
		local _time = tonumber(npos(list))
		local _event_type = tonumber(npos(list))
		local _sx = tonumber(npos(list))
		local _sy = tonumber(npos(list))
		local _dx = tonumber(npos(list))
		local _dy = tonumber(npos(list))
		
		local last_state = -1
		local key = "" .. _user_info .. "," .. _time .. "," .. _dx .. "," .. _dy
		local info = nil
		if nil == _ED.world_map or _user_info == _ED.user_info.user_id then
			info = {}
		else
			info = _ED.world_map.all_target_event_info[key]
			if nil == info then
				info = {}
				_ED.world_map.all_target_event_info[key] = info
			else
				last_state = info._event_type
			end
		end
		info._key = key
		info._last_state = last_state
		info._user_info = _user_info
		info._time = _time
		info._event_type = _event_type
		info._sx = _sx
		info._sy = _sy
		info._dx = _dx
		info._dy = _dy
		info._start_time = tonumber(npos(list))
		info._complete_time = tonumber(npos(list))
		info._target_type = tonumber(npos(list))
		info._target_id = tonumber(npos(list))
		info._quality = tonumber(npos(list))
		info._world_mine_mould_id = tonumber(npos(list))
		info._prev_out_put = tonumber(npos(list))
		info._max_out_put = tonumber(npos(list))
		info._formation_info = npos(list)
		-- if 0 == info._target_type or info._target_type >= 6 then
		info._nickname = npos(list)
		info._level = npos(list)
		info._help_defend_state = tonumber(npos(list)) -- 部队协防状态 0：待命， 1：协防中
		info._combat_force = tonumber(npos(list)) -- 部队战力
		info._bonus_value = tonumber(npos(list))	--加成值
		info._attack_union_id = tonumber(npos(list))	--攻击者军团id
		info._beAttack_union_id = tonumber(npos(list))	--目标者军团id
		local targetId = tonumber(npos(list))	--目标id

		if zstring.tonumber(_user_info) == zstring.tonumber(_ED.user_info.user_id)
			or (targetId == zstring.tonumber(_ED.user_info.user_id)
			and info._target_type ~= 3002)
			then
			_ED.world_map.all_target_event_info[key] = nil
		else
			if _user_info ~= _ED.user_info.user_id
				and nil ~= _ED.world_map
				then
				if (tonumber(info._event_type) == 0) then
					if (_ED.world_map.position_coordinates_x == _sx and _ED.world_map.position_coordinates_y == _sy)
						or (_ED.world_map.position_coordinates_x == _dx and _ED.world_map.position_coordinates_y == _dy)
						then
						return
					end
				end
				if tonumber(info._event_type) == 1 
					or tonumber(info._event_type) == 18 
					or tonumber(info._event_type) == 23
					then
					state_machine.excute("adventure_mine_world_all_attack_event_path_info", 0, {info, 1, info._dx, info._dy, info._sx, info._sy})
				else
					state_machine.excute("adventure_mine_world_all_attack_event_path_info", 0, {info, 1, info._sx, info._sy, info._dx, info._dy})
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------
--parse_user_world_city_info 15123 返回城市战用户信息
---------------------------------------------------------------------------------------------------------
function parse_user_world_city_info(interpreter,datas,pos,strDatas,list,count)
	_ED.world_city_info = _ED.world_city_info or {}
	_ED.world_city_info.my_info = {}
	_ED.world_city_info.my_info.energy = tonumber(npos(list))
	_ED.world_city_info.my_info.buy_boom_times = tonumber(npos(list))
	_ED.world_city_info.my_info.resource_info = npos(list)
	_ED.world_city_info.my_info.post = tonumber(npos(list))
	_ED.world_city_info.my_info.reward_state = tonumber(npos(list))		--0不可领取，1可领取，2已领取
	_ED.world_city_info.my_info.buy_energy_times = tonumber(npos(list))		--能量购买次数

	state_machine.excute("main_window_update_city_energy_info", 0, "")
	state_machine.excute("red_alert_time_mine_update_city_energy_info", 0, "")

	state_machine.excute("notification_center_update", 0, "push_notification_legion_city_reward")
end

---------------------------------------------------------------------------------------------------------
--parse_world_city_list_info 15124 返回城市战城市列表
---------------------------------------------------------------------------------------------------------
function parse_world_city_list_info(interpreter,datas,pos,strDatas,list,count)
	_ED.world_city_info = _ED.world_city_info or {}
	_ED.world_city_info.city_info = {}
	local nCount = tonumber(npos(list))
	for i = 1, nCount do
		local info = {}
		info.city_id = npos(list)
		info.boom = tonumber(npos(list))
		info.state = tonumber(npos(list))		--(-1:未达到开服天数 0:未开启1:开启未被占领2:开启已被占领)
		info.union_id = tonumber(npos(list))
		info.union_name = npos(list)
		info.progress = npos(list)
		info.progress_union_id = tonumber(npos(list))
		info.capture_start_time = tonumber(npos(list)) / 1000 	-- 保护罩起始时间
		info.capture_cd_time = tonumber(npos(list)) / 1000 		-- 保护罩持续时间
		
		info.city_type = dms.int(dms["world_city_mould"], info.city_id, world_city_mould.city_type)
		_ED.world_city_info.city_info[info.city_id] = info
	end
end

---------------------------------------------------------------------------------------------------------
--parse_world_city_detail_info 15125 返回城市战城市详情
---------------------------------------------------------------------------------------------------------
function parse_world_city_detail_info(interpreter,datas,pos,strDatas,list,count)
	_ED.world_city_info = _ED.world_city_info or {}
	_ED.world_city_info.detail_info = _ED.world_city_info.detail_info or {}
	local detail_info = {}
	detail_info.city_id = tonumber(npos(list))
	detail_info.boom = tonumber(npos(list))
	detail_info.state = tonumber(npos(list))		--(-1开服天数为到0:未开启1:开启未被占领2:开启已被占领)
	detail_info.union_id = tonumber(npos(list))
	detail_info.union_name = npos(list)
	detail_info.progress = tonumber(npos(list))/1000
	detail_info.progress_union_id = tonumber(npos(list))
	npos(list) 		-- 
	npos(list)
	detail_info.progress_union_name = npos(list)
	detail_info.progress_tick_time = tonumber(npos(list))
	detail_info.progress_start_time = os.time()
	detail_info.resource_info = npos(list)
	detail_info.defencer_count = tonumber(npos(list))
	detail_info.defencer_list = {}
	for i = 1, detail_info.defencer_count do
		local defencer_info = {}
		defencer_info.nType = tonumber(npos(list))		--(-1npc 0:玩家)
		defencer_info.user_id = tonumber(npos(list))
		defencer_info.user_name = npos(list)
		if defencer_info.nType == -1 then
			defencer_info.user_name = dms.string(dms["npc"], defencer_info.user_id, npc.npc_name)
		end
		defencer_info.user_level = tonumber(npos(list))
		defencer_info.head_pic = npos(list)
		defencer_info.union_name = npos(list)
		table.insert(detail_info.defencer_list, defencer_info)
	end
	detail_info.add_time_speed = (100 + tonumber(npos(list)))/100
	detail_info.factory_level = tonumber(npos(list)) 			-- 当前工厂等级
	detail_info.factory_start_time = tonumber(npos(list)) / 1000 	-- 工厂升级开始时间
	detail_info.capture_start_time = tonumber(npos(list)) / 1000 	-- 保护罩起始时间
	detail_info.capture_cd_time = tonumber(npos(list)) / 1000 		-- 保护罩持续时间
	detail_info.reward_start_time = tonumber(npos(list)) / 1000 		-- 分红起始时间
	detail_info.reward_cd_time = tonumber(npos(list)) / 1000 		-- 分红已累计时间
	detail_info.reward_get_count = tonumber(npos(list)) 		-- 分红已领取份数
	detail_info.city_type = dms.int(dms["world_city_mould"], detail_info.city_id, world_city_mould.city_type)
	_ED.world_city_info.detail_info[""..detail_info.city_id] = detail_info
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_city_rank_list_info 15126 --返回城市战排行榜信息
-- ---------------------------------------------------------------------------------------------------------
function parse_world_city_rank_list_info(interpreter,datas,pos,strDatas,list,count)
	_ED.world_city_info = _ED.world_city_info or {}
	_ED.world_city_info.rank_list = _ED.world_city_info.rank_list or {}
	local nType = npos(list) 		-- 类型(0:全服 1:军团)
    _ED.world_city_info.rank_list[""..nType] = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {
			rank = npos(list),
			name = npos(list),
			fight_number = npos(list),
			merit = npos(list),
		}
		table.insert(_ED.world_city_info.rank_list[""..nType], info)
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_city_open_state 15127 --返回城市战城市开启状态
-- ---------------------------------------------------------------------------------------------------------
function parse_world_city_open_state( interpreter,datas,pos,strDatas,list,count )
	_ED.world_city_auto_open_state = tonumber(npos(list)) -- （0自动，1手动）
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_city_shop_list_info 15128 --返回城市战商店列表
-- ---------------------------------------------------------------------------------------------------------
function parse_world_city_shop_list_info( interpreter,datas,pos,strDatas,list,count )
	_ED.world_city_shop_info = _ED.world_city_shop_info or {}
	_ED.world_city_shop_info.shop_list = {}
	local count = npos(list)
	for i = 1, zstring.tonumber(count) do
		local info = {}
		info.index = i
		info.id = npos(list)
		info.prop_info = npos(list)
		info.cost_info = npos(list)
		info.max_buy_times = tonumber(npos(list))
		table.insert(_ED.world_city_shop_info.shop_list, info)
	end
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_city_shop_user_info 15129 --返回城市战用户商店信息
-- ---------------------------------------------------------------------------------------------------------
function parse_world_city_shop_user_info( interpreter,datas,pos,strDatas,list,count )
	_ED.world_city_shop_info = _ED.world_city_shop_info or {}
	_ED.world_city_shop_info.my_rank = tonumber(npos(list))
	_ED.world_city_shop_info.discount = tonumber(npos(list))
	_ED.world_city_shop_info.buy_times = zstring.split(npos(list), ",")
end	

-- ---------------------------------------------------------------------------------------------------------
-- parse_world_investigate_end_time 15130 --返回地块侦查时间
-- ---------------------------------------------------------------------------------------------------------
function parse_world_investigate_end_time( interpreter,datas,pos,strDatas,list,count )
	_ED.world_investigate_start_time = os.time()
	_ED.world_investigate_end_time = tonumber(npos(list)) / 1000
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_maintenance_info	15300 返回维护服务器信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_server_maintenance_info(interpreter,datas,pos,strDatas,list,count)
	_ED.server_maintenance_title = npos(list)
	_ED.server_maintenance_info = npos(list)
	_ED.server_maintenance_time = tonumber(npos(list))/1000
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_open_info	15301 返回开服服务器信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_server_open_info(interpreter,datas,pos,strDatas,list,count)
	_ED.server_open_title = npos(list)
	_ED.server_open_info = npos(list)
	_ED.server_open_time = tonumber(npos(list))/1000
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_return_server_list_time_info	15302 返回服务器列表时间信息
-- ---------------------------------------------------------------------------------------------------------
function parse_return_server_list_time_info(interpreter,datas,pos,strDatas,list,count)
	local count = npos(list)
	for i=1,tonumber(count) do
		local server_number = npos(list)
		local time = npos(list)
		if _ED.all_servers[server_number] ~= nil then
			_ED.all_servers[server_number].server_open_time = time
		end
	end
end

-- -------------------------------------------------------------------------------------------------------
-- parse_return_reduce_some_props       16000
-- -------------------------------------------------------------------------------------------------------
function parse_return_reduce_some_props(interpreter,datas,pos,strDatas,list,count)
	local count = npos(list)
	local prop_list_mouldid = {}
	for i=1,tonumber(count) do
		local reducePropId = npos(list)							--需要删除的道具实例ID
		local propData = fundUserPropWidthId(reducePropId)			--找到当前道具的信息记录
		table.insert(prop_list_mouldid, propData.user_prop_template)
		local current_number = zstring.tonumber(propData.prop_number)
		propData.prop_number = npos(list)							--剩余的道具数量

		if tonumber(propData.prop_number) > 0 then
			_ED.push_user_prop[""..propData.user_prop_template].prop_number = propData.prop_number
		else
			_ED.push_user_prop[""..propData.user_prop_template] = nil
		end

		if tonumber(propData.prop_number) <= 0 then
			_ED.user_prop[reducePropId] = nil						--删除道具
		end
	end

	for i,v in pairs(_ED.user_ship) do
		for j, w in pairs(prop_list_mouldid) do
			toViewShipPushData(v.ship_id,true,6,w)
		end
	end
	state_machine.excute("notification_center_update", 0, "push_notification_center_new_shop") 
	state_machine.excute("notification_center_update", 0, "push_notification_center_sm_chest_store")
	state_machine.excute("hero_list_view_update_cell_strength_button_push",0,"hero_list_view_update_cell_strength_button_push.")
	state_machine.excute("hero_list_view_update_cell_equip_button_push",0,"hero_list_view_update_cell_equip_button_push.")
   	state_machine.excute("notification_center_update",0,"push_notification_center_ship_warehouse_all")
   	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_home_hero_icon")
   	state_machine.excute("notification_center_update",0,"push_notification_center_hero_develop_duplicate_formation")
   	state_machine.excute("formation_update_equip_icon_push",0,"formation_update_equip_icon_push.")
end

-- ---------------------------------------------------------------------------------------------------------
-- parse_heartbeat
-- ---------------------------------------------------------------------------------------------------------
function parse_heartbeat(interpreter,datas,pos,strDatas,list,count)
end
-- ---------------------------------------------------------------------------------------------------------
-- parse_closed
-- ---------------------------------------------------------------------------------------------------------
function parse_closed(interpreter,datas,pos,strDatas,list,count)
end

