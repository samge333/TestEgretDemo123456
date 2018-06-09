-----------------------------
--限时宝箱活动
-----------------------------
SmLimitedTimeEquipBox = class("SmLimitedTimeEquipBoxClass", Window)

--打开界面
local sm_limited_time_equip_box_open_terminal = {
	_name = "sm_limited_time_equip_box_open",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if fwin:find("SmLimitedTimeEquipBoxClass") == nil then
			fwin:open(SmLimitedTimeEquipBox:new():init(params), fwin._ui)		
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

--关闭界面
local sm_limited_time_equip_box_close_terminal = {
	_name = "sm_limited_time_equip_box_close",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		fwin:close(fwin:find("SmLimitedTimeEquipBoxClass"))
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

state_machine.add(sm_limited_time_equip_box_open_terminal)
state_machine.add(sm_limited_time_equip_box_close_terminal)
state_machine.init()

function SmLimitedTimeEquipBox:ctor()
	self.super:ctor()
	self.roots = {}

    self._activity_type = 0         

    self._ship_mould_id = 0
    self._ship_evo_info = nil
    self._current_index = 1

    self._text_time = nil

    self.play_types = 0
    self.hero_state = false

    self._is_free = false
    self._is_end = false
    self._end_time = 0

    self.currentListView = nil
    self.currentInnerContainer = nil
    self.currentInnerContainerPosY = 0

    app.load("client.l_digital.activity.wonderful.SmLimitedTimeEquipBoxHelp")
    app.load("client.l_digital.activity.wonderful.SmLimitedTimeEquipBoxWindow")

    app.load("client.l_digital.cells.activity.wonderful.sm_limited_time_equip_box_reward_cell")
    app.load("client.l_digital.cells.activity.wonderful.sm_limited_time_equip_box_rank_cell")

    app.load("client.packs.hero.GeneralsEvoChainWindow")
    app.load("client.battle.fight.FightEnum")
    app.load("client.shop.recruit.HeroRecruitSuccess")
    app.load("client.shop.recruit.HeroRecruitSuccessTen")

    local function init_sm_limited_time_equip_box_terminal()
        local sm_limited_time_equip_box_update_draw_terminal = {
            _name = "sm_limited_time_equip_box_update_draw",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
            	   instance:onUpdateDraw()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 开启宝箱
        local sm_limited_time_equip_box_get_reward_terminal = {
            _name = "sm_limited_time_equip_box_get_reward",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)

                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_limited_time_equip_box_change_digimon_terminal = {
            _name = "sm_limited_time_equip_box_change_digimon",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local index = instance._current_index + params._datas.turn_type
                instance:onUpdateDigimonInfo(index)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_limited_time_equip_box_hero_evolution_terminal = {
            _name = "sm_limited_time_equip_box_hero_evolution",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("generals_evo_chain_window_open",0,{""..instance._ship_mould_id})
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --播放攻击动画
        local sm_limited_time_equip_box_play_hero_animation_terminal = {
            _name = "sm_limited_time_equip_box_play_hero_animation",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil then
                    instance:changeHeroAnimation(params)
                end
            end,
            _terminal = nil,
            _terminals = nil
        }

        --一次招募
        local sm_limited_time_equip_box_a_recruiting_terminal = {
            _name = "sm_limited_time_equip_box_a_recruiting",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.lock("sm_limited_time_equip_box_a_recruiting")
                state_machine.lock("sm_limited_time_equip_box_ten_recruiting")
                local activity = _ED.active_activity[instance._activity_type]
                local m_type = 3
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            if fwin:find("HeroRecruitSuccessClass") ~= nil then
                                fwin:close(fwin:find("HeroRecruitSuccessClass"))
                            end
                            if __lua_project_id == __lua_project_l_digital 
                                or __lua_project_id == __lua_project_l_pokemon 
                                or __lua_project_id == __lua_project_l_naruto 
                                then
                                getSceneReward(7)
                                _ED.show_reward_list_group_ex = {}
                            end
                            local obj = HeroRecruitSuccess:new()
                            obj:setRanking(herorIndex,m_type,false)
                            fwin:open(obj,fwin._ui)

                            state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                            -- state_machine.excute("hero_recruit_shop_twopage_close",0,"")

                            state_machine.excute("sm_limited_time_equip_box_update_draw", 0, "")
                            state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_limited_time_box")
                        end
                        -- fwin:addService({
                        --     callback = function ( params )
                        --         state_machine.unlock("sm_limited_time_equip_box_a_recruiting")
                        --         state_machine.unlock("sm_limited_time_equip_box_ten_recruiting")
                        --     end,
                        --     delay = 0.1,
                        --     params = response.node
                        -- })
                    else
                        state_machine.unlock("sm_limited_time_equip_box_a_recruiting")
                        state_machine.unlock("sm_limited_time_equip_box_ten_recruiting")
                    end
                    _ED.prop_chest_store_recruiting = false
                end      

                _ED.new_prop_object = {}
                _ED.recruit_success_ship_id = nil
                _ED.new_reward_object = {}
                _ED.prop_chest_store_recruiting = true

                protocol_command.get_activity_reward.param_list = ""..activity.activity_id.."\r\n".."0".."\r\n".."0".."\r\n"..instance._activity_type.."\r\n".."0".."\r\n".."0"
                NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --十次招募
        local sm_limited_time_equip_box_ten_recruiting_terminal = {
            _name = "sm_limited_time_equip_box_ten_recruiting",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                -- if instance._is_free == true then
                --     TipDlg.drawTextDailog(_new_interface_text[172])
                --     return
                -- end
                state_machine.lock("sm_limited_time_equip_box_a_recruiting")
                state_machine.lock("sm_limited_time_equip_box_ten_recruiting")
                local activity = _ED.active_activity[instance._activity_type]
                local m_type = 3
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            if __lua_project_id == __lua_project_l_digital 
                                or __lua_project_id == __lua_project_l_pokemon 
                                or __lua_project_id == __lua_project_l_naruto 
                                then
                                getSceneReward(7)
                                _ED.show_reward_list_group_ex = {}
                            end
                            local obj = HeroRecruitSuccessTen:new()
                            obj:setRanking(herorIndex,m_type,false)
                            fwin:open(obj,fwin._ui)
                            state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                            
                            -- state_machine.excute("hero_recruit_shop_twopage_close",0,"")
                            state_machine.excute("sm_limited_time_equip_box_update_draw", 0, "")
                        end
                        -- fwin:addService({
                        --     callback = function ( params )
                        --         state_machine.unlock("sm_limited_time_equip_box_a_recruiting")
                        --         state_machine.unlock("sm_limited_time_equip_box_ten_recruiting")
                        --     end,
                        --     delay = 0.1,
                        --     params = response.node
                        -- })
                    else
                        state_machine.unlock("sm_limited_time_equip_box_a_recruiting")
                        state_machine.unlock("sm_limited_time_equip_box_ten_recruiting")
                    end
                    _ED.prop_chest_store_recruiting = false
                end

                _ED.new_prop_object = {}
                _ED.recruit_success_ship_id = nil
                _ED.new_reward_object = {}
                _ED.prop_chest_store_recruiting = true

                protocol_command.get_activity_reward.param_list = ""..activity.activity_id.."\r\n".."0".."\r\n".."0".."\r\n"..instance._activity_type.."\r\n".."0".."\r\n".."1"
                NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 规则
        local sm_limited_time_equip_box_rule_infor_terminal = {
            _name = "sm_limited_time_equip_box_rule_infor",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("sm_limited_time_equip_box_help_open", 0, {instance._activity_type})
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 刷新
        local sm_limited_time_equip_box_update_rank_terminal = {
            _name = "sm_limited_time_equip_box_update_rank",
            _init = function (terminal)
                app.load("client.packs.hero.GeneralsEvoChainWindow")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local activity = _ED.active_activity[instance._activity_type]
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            response.node:onUpdateRankInfo()
                        end
                    end
                end

                protocol_command.get_activity_reward.param_list = ""..activity.activity_id.."\r\n".."0".."\r\n".."0".."\r\n"..instance._activity_type.."\r\n".."2".."\r\n".."0"
                NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_limited_time_equip_box_update_draw_terminal)
        state_machine.add(sm_limited_time_equip_box_get_reward_terminal)
        state_machine.add(sm_limited_time_equip_box_change_digimon_terminal)
        state_machine.add(sm_limited_time_equip_box_hero_evolution_terminal)
        state_machine.add(sm_limited_time_equip_box_play_hero_animation_terminal)
        state_machine.add(sm_limited_time_equip_box_a_recruiting_terminal)
        state_machine.add(sm_limited_time_equip_box_ten_recruiting_terminal)
        state_machine.add(sm_limited_time_equip_box_rule_infor_terminal)
        state_machine.add(sm_limited_time_equip_box_update_rank_terminal)
        state_machine.init()
    end
    init_sm_limited_time_equip_box_terminal()
end

function SmLimitedTimeEquipBox:onUpdateDraw()
    local root = self.roots[1]

    -- activity_params = "免费状态,积分!80,680|1,2,3,4,5,6,7,8,9,10!奖励1:1-1:7000$奖励2:2-3:7000$奖励3:4-6:7000$奖励4:7-10:7000$奖励5:11-20:7000$奖励6:21-30:7000!数码兽id!领奖时间"
    local activity_info = _ED.active_activity[self._activity_type]
    local activity_params = zstring.split(activity_info.activity_params, "!")

    -- 按钮状态
    local Text_zs_n_1 = ccui.Helper:seekWidgetByName(root, "Text_zs_n_1")   -- 开启一次
    local Text_zs_n_2 = ccui.Helper:seekWidgetByName(root, "Text_zs_n_2")   -- 开启10次
    local Text_free = ccui.Helper:seekWidgetByName(root, "Text_free")           -- 是否免费

    local is_free = tonumber(zstring.split(activity_params[1], ",")[1])
    if is_free == 0 then
        Text_free:setVisible(true)
        self._is_free = true
    else
        Text_free:setVisible(false)
        self._is_free = false
    end

    local cost_info = zstring.split(zstring.split(activity_params[2], "|")[1], ",")
    Text_zs_n_1:setString(cost_info[1])
    Text_zs_n_2:setString(cost_info[2])

    local Text_zs_n_3 = ccui.Helper:seekWidgetByName(root, "Text_zs_n_3")       -- 钻石数量
    Text_zs_n_3:setString(_ED.user_info.user_gold)

    local Text_time = ccui.Helper:seekWidgetByName(root, "Text_time")
    local Button_open_1 = ccui.Helper:seekWidgetByName(root,"Button_open_1")
    local Button_open_2 = ccui.Helper:seekWidgetByName(root,"Button_open_2")

    local Image_djs = ccui.Helper:seekWidgetByName(root,"Image_djs")
    local Text_time = ccui.Helper:seekWidgetByName(root,"Text_time")
    local Image_djs_0 = ccui.Helper:seekWidgetByName(root,"Image_djs_0")
    local Text_time_0 = ccui.Helper:seekWidgetByName(root,"Text_time_0")
    Image_djs:setVisible(true)
    Text_time:setVisible(true)
    if Image_djs_0 ~= nil then
        Image_djs_0:setVisible(false)
    end
    if Text_time_0 ~= nil then
        Text_time_0:setVisible(false)
    end

    local end_time = tonumber(activity_params[6])

    if (os.time() + _ED.time_add_or_sub) > end_time / 1000 then         -- 抽奖结束
        self._tick_time = tonumber(activity_info.end_time) / 1000 - (os.time() + _ED.time_add_or_sub)
        self._is_end = true
    else
        self._tick_time = end_time / 1000 - (os.time() + _ED.time_add_or_sub)
        self._is_end = false
    end
    self._text_time = nil
    if self._is_end == false then
        Button_open_1:setTouchEnabled(true)
        Button_open_1:setBright(true)
        Button_open_2:setTouchEnabled(true)
        Button_open_2:setBright(true)

        Text_time:setString(getRedAlertTimeActivityFormat(self._tick_time))

        self._text_time = Text_time
    else
        Button_open_1:setTouchEnabled(false)
        Button_open_1:setBright(false)
        Button_open_2:setTouchEnabled(false)
        Button_open_2:setBright(false)

        Text_time:setString(_string_piece_info[305])
    end

    self:onUpdateRankInfo()
    self:onUpdateScoreInfo()
end

function SmLimitedTimeEquipBox:onUpdateScoreInfo()
    local root = self.roots[1]
    local activity_info = _ED.active_activity[self._activity_type]
    local activity_params = zstring.split(activity_info.activity_params, "!")

    local Text_jf_n = ccui.Helper:seekWidgetByName(root, "Text_jf_n")       -- 积分
    local current_score = tonumber(zstring.split(activity_params[1], ",")[2])       -- 当前积分
    Text_jf_n:setString(current_score)

    local result = activity_info.activity_Info
    
    local LoadingBar_jfjd = ccui.Helper:seekWidgetByName(root, "LoadingBar_jfjd")
    local loading_size = LoadingBar_jfjd:getContentSize()
    local base_posX = LoadingBar_jfjd:getPositionX()
    
    local percent = 0
    local reward_count = #result
    local get_count = 0
    local last_score = 0

    -- 积分奖励
    for k, v in pairs(result) do
        local Panel_reward_box = ccui.Helper:seekWidgetByName(root, "Panel_reward_box_"..k)
        Panel_reward_box:removeAllChildren(true)
        local cell = state_machine.excute("sm_limited_time_equip_box_reward_cell_create", 0, {self._activity_type, v})
        Panel_reward_box:addChild(cell)
        
        local posX = base_posX + loading_size.width * k / reward_count - Panel_reward_box:getContentSize().width * Panel_reward_box:getScale() / 2
        Panel_reward_box:setPositionX(posX)
        
        if current_score > tonumber(v.activityInfo_need_day) then
            get_count = get_count + 1
        elseif current_score > last_score then
            percent = (current_score - last_score) / (tonumber(v.activityInfo_need_day) - last_score)
        end
        last_score = tonumber(v.activityInfo_need_day)
    end
    
    percent = (get_count + percent) * 100 / reward_count
    LoadingBar_jfjd:setPercent(percent)
end

function SmLimitedTimeEquipBox:changeHeroAnimation(play_types)
    self.play_types = play_types
    csb.animationChangeToAction(self.hero_animation, play_types, play_types, false)
end

function SmLimitedTimeEquipBox:onUpdateDigimonInfo(index)
    self._current_index = math.min(4, math.max(1, index))
    index = self._current_index

    local root = self.roots[1]
    local Panel_digimon = ccui.Helper:seekWidgetByName(root, "Panel_digimon")
    local Panel_role_up_text = ccui.Helper:seekWidgetByName(root, "Panel_role_up_text")
    local Text_digimon_name = ccui.Helper:seekWidgetByName(root, "Text_digimon_name")

    Panel_digimon:removeAllChildren(true)

    local evo_mould_id = self._ship_evo_info[index]

    local temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)
    draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), Panel_digimon, nil, nil, cc.p(0.5, 0))

    local hero_animation = sp.spine_sprite(Panel_digimon, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
    hero_animation:setScaleX(-1)
    self.hero_animation = hero_animation

    hero_animation.animationNameList = spineAnimations
    sp.initArmature(hero_animation, true)
    hero_animation._self = self
    local function changeActionCallback( armatureBack ) 
        state_machine.excute("sm_limited_time_equip_box_play_hero_animation",0,38)
    end
    hero_animation._invoke = changeActionCallback
    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
    csb.animationChangeToAction(hero_animation, 0, 0, false)

    local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
    local word_info = dms.element(dms["word_mould"], name_mould_id)
    local name = word_info[3]
    Text_digimon_name:setString(name)

    Panel_role_up_text:removeBackGroundImage()
    local level_groun_icon = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.level_groun_icon)
    Panel_role_up_text:setBackGroundImage(string.format("images/ui/text/sm_role_up_%d.png", level_groun_icon))

    local Button_arrow_change_left = ccui.Helper:seekWidgetByName(root, "Button_arrow_change_left")
    local Button_arrow_change_right = ccui.Helper:seekWidgetByName(root, "Button_arrow_change_right")
    Button_arrow_change_left:setVisible(true)
    Button_arrow_change_right:setVisible(true)

    if index == 1 then
        Button_arrow_change_left:setVisible(false)
    elseif index == 4 then
        Button_arrow_change_right:setVisible(false)
    end
end

function SmLimitedTimeEquipBox:onUpdateRankRewardInfo()
    local root = self.roots[1]
    local activity_info = _ED.active_activity[self._activity_type]
    local activity_params = zstring.split(activity_info.activity_params, "!")
    local rank_reward_info = zstring.split(activity_params[3], "%$")

    -- 如果是繁体处理方式不一样，csd不一样
    -- if verifySupportLanguage(_lua_release_language_zh_TW) == true then

    -- 还原，不做特殊处理
    if false then
        local listview = root:getChildByName("Panel_add_s"):getChildByName("Panel_1103"):getChildByName("ListView_phjl")
        listview:setItemModel(listview:getItem(0))
        listview:removeAllItems()

        local numstr = {"1", "2-3", "4-6", "7-10", "11-20", "21-30"}
        local color = {
            cc.c3b(255, 255, 0),
            cc.c3b(255, 0, 255),
            cc.c3b(0, 255, 255),
            cc.c3b(30, 144, 255),
            cc.c3b(30, 144, 255),
            cc.c3b(30, 144, 255),
        }

        for i = 1, 6 do
            listview:pushBackDefaultItem()
            local panel = listview:getItem(i - 1)

            local Text_phjl = panel:getChildByName("Text_phjl")

            local reward_info = zstring.split(zstring.split(rank_reward_info[i], ":")[1], "|")
            -- 显示奖励名称
            local ship_name = nil         -- 获得数码兽信息
            local ship_star = 0           -- 数码兽星级
            local prop_name = nil         -- 获得碎片信息
            local prop_count = 0          -- 碎片数量

            for k, v in pairs(reward_info) do
                local info = zstring.split(v, ",")
                if tonumber(info[1]) == 13 then
                    local ship_id = tonumber(info[2])
                     --进化形象
                    local evo_image = dms.string(dms["ship_mould"], ship_id, ship_mould.fitSkillTwo)
                    local evo_info = zstring.split(evo_image, ",")
                    --进化模板id
                    -- local ship_evo = zstring.split(hero.evolution_status, "|")
                    local evo_mould_id = evo_info[dms.int(dms["ship_mould"], ship_id, ship_mould.captain_name)]
                    local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
                    ship_name = dms.string(dms["word_mould"], name_mould_id, word_mould.text_info)
                    ship_star = zstring.tonumber(info[4])
                elseif tonumber(info[1]) == 6 then
                    local prop_id = tonumber(info[2])
                    local prop_ship = dms.int(dms["prop_mould"], prop_id, prop_mould.use_of_ship)
                    if zstring.tonumber(prop_ship) > 0 and zstring.tonumber(prop_ship) == self._ship_mould_id then
                        local name_mould_id = dms.int(dms["prop_mould"], prop_id, prop_mould.prop_name)
                        prop_name = dms.string(dms["word_mould"], name_mould_id, word_mould.text_info)
                        prop_count = zstring.tonumber(info[3])
                    end
                end
            end

            local info_str = ""
            if ship_name ~= nil and ship_star > 0 then
                info_str = ""..ship_name..string.format(_new_interface_text[171], ship_star)
                if prop_name ~= nil and prop_count > 0 then
                    -- info_str = info_str.."\r\n".."+".._string_piece_info[63].."*"..prop_count
                    info_str = info_str .. "+" .. _string_piece_info[63] .. "*" .. prop_count
                end
            elseif prop_name ~= nil and prop_count > 0 then
                info_str = ""..prop_name.."*"..prop_count
            end

            local richtext = ccui.RichText:create()
            richtext:ignoreContentAdaptWithSize(true)
            local ele1 = ccui.RichElementText:create(1, cc.c3b(255, 255, 255), 255, _string_piece_info[2], Text_phjl:getFontName(), 20)
            richtext:pushBackElement(ele1)

            local ele2 = ccui.RichElementText:create(2, color[i], 255, numstr[i], Text_phjl:getFontName(), 20)
            richtext:pushBackElement(ele2)

            local ele3 = ccui.RichElementText:create(3, cc.c3b(255, 255, 255), 255, _string_piece_info[317], Text_phjl:getFontName(), 20)
            richtext:pushBackElement(ele3)

            local ele4 = ccui.RichElementText:create(4, color[i], 255, "   ", Text_phjl:getFontName(), 20)
            richtext:pushBackElement(ele4)

            local ele5 = ccui.RichElementText:create(5, color[i], 255, info_str, Text_phjl:getFontName(), 20)
            richtext:pushBackElement(ele5)

            richtext:formatText()

            richtext:setPosition(cc.p(richtext:getVirtualRendererSize().width / 2, panel:getContentSize().height / 2))
            panel:addChild(richtext)

        
        end

    else
        for i = 1, 6 do
            local Text_reward_info = ccui.Helper:seekWidgetByName(root, "Text_reward_info_"..i)
            local reward_info = zstring.split(zstring.split(rank_reward_info[i], ":")[1], "|")
            -- 显示奖励名称
            local ship_name = nil         -- 获得数码兽信息
            local ship_star = 0           -- 数码兽星级
            local prop_name = nil         -- 获得碎片信息
            local prop_count = 0          -- 碎片数量

            for k, v in pairs(reward_info) do
                local info = zstring.split(v, ",")
                if tonumber(info[1]) == 13 then
                    local ship_id = tonumber(info[2])
                     --进化形象
                    local evo_image = dms.string(dms["ship_mould"], ship_id, ship_mould.fitSkillTwo)
                    local evo_info = zstring.split(evo_image, ",")
                    --进化模板id
                    -- local ship_evo = zstring.split(hero.evolution_status, "|")
                    local evo_mould_id = evo_info[dms.int(dms["ship_mould"], ship_id, ship_mould.captain_name)]
                    local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
                    ship_name = dms.string(dms["word_mould"], name_mould_id, word_mould.text_info)
                    ship_star = zstring.tonumber(info[4])
                elseif tonumber(info[1]) == 6 then
                    local prop_id = tonumber(info[2])
                    local prop_ship = dms.int(dms["prop_mould"], prop_id, prop_mould.use_of_ship)
                    if zstring.tonumber(prop_ship) > 0 and zstring.tonumber(prop_ship) == self._ship_mould_id then
                        local name_mould_id = dms.int(dms["prop_mould"], prop_id, prop_mould.prop_name)
                        prop_name = dms.string(dms["word_mould"], name_mould_id, word_mould.text_info)
                        prop_count = zstring.tonumber(info[3])
                    end
                end
            end

            local info_str = ""
            if ship_name ~= nil and ship_star > 0 then
                info_str = ""..ship_name..string.format(_new_interface_text[171], ship_star)
                if prop_name ~= nil and prop_count > 0 then
                    info_str = info_str.."\r\n".."+".._string_piece_info[63].."*"..prop_count
                end
            elseif prop_name ~= nil and prop_count > 0 then
                info_str = ""..prop_name.."*"..prop_count
            end

            Text_reward_info:setString(info_str)
        end
    end

end

function SmLimitedTimeEquipBox:onUpdateRankInfo()
    local root = self.roots[1]
    local activity_info = _ED.active_activity[self._activity_type]

    local Text_pm_n = ccui.Helper:seekWidgetByName(root, "Text_pm_n")       -- 排名
    local my_rank = 0

    local result = {}
    if _ED.sm_limited_time_box_score_rank ~= nil then
        result = _ED.sm_limited_time_box_score_rank
    end
    local function sortFunction(a, b)
        return a.rank < b.rank
    end
    table.sort(result, sortFunction)

    local ListView_phb = ccui.Helper:seekWidgetByName(root, "ListView_phb")
    ListView_phb:removeAllItems()

    -- 排行榜名单
    for k, v in pairs(result) do
        local cell = state_machine.excute("sm_limited_time_equip_box_rank_cell_create", 0, {k, v})
        ListView_phb:addChild(cell)

        if _ED.user_info.user_name == v.name then
            my_rank = v.rank
        end
    end
    
    ListView_phb:refreshView()
    self.currentListView = ListView_phb
    self.currentInnerContainer = self.currentListView:getInnerContainer()
    self.currentInnerContainerPosY = self.currentInnerContainer:getPositionY()

    -- self.currentListView:jumpToTop()

    if my_rank > 0 then
        Text_pm_n:setString(my_rank)
    else
        Text_pm_n:setString(_string_piece_info[34])
    end
end


function SmLimitedTimeEquipBox:onUpdate(dt)
    if self._text_time ~= nil and self._tick_time > 0 then 
        self._tick_time = self._tick_time - dt
        self._text_time:setString(getRedAlertTimeActivityFormat(self._tick_time))
        if self._tick_time <= 0 then
            self._tick_time = nil
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_the_center_sm_limited_time_box",
            _widget = ccui.Helper:seekWidgetByName(self.roots[1],"Button_open_1"),
            _invoke = nil,
            _interval = 0.5,})
            state_machine.excute("push_notification_center_activity_the_center_sm_activity_update", 0, self._activity_type)
            state_machine.excute("home_update_top_activity_info_state", 0, nil)
            if self._is_end == false then
                self:onUpdateDraw()
            end
        end
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
                v:unload()
            else
                v:reload()
            end
        end
    end
end

function SmLimitedTimeEquipBox:init(params)
    self._activity_type = params[1]
    self:setTouchEnabled(true)
	self:onInit()
    return self
end

function SmLimitedTimeEquipBox:onInit()
    local csbItem = csb.createNode("activity/wonderful/sm_limited_time_equip_box.csb")
    local root = csbItem:getChildByName("root")
    self:addChild(csbItem)
    table.insert(self.roots, root)

    -- activity_params = "免费状态,积分!80,680|1,2,3,4,5,6,7,8,9,10!奖励1:1-1:7000$奖励2:2-3:7000$奖励3:4-6:7000$奖励4:7-10:7000$奖励5:11-20:7000$奖励6:21-30:7000!数码兽id"
    local activity_info = _ED.active_activity[self._activity_type]
    local activity_params = zstring.split(activity_info.activity_params, "!")
    self._ship_mould_id = tonumber(activity_params[4])         -- 展示数码兽id
    self._ship_evo_info = zstring.split(dms.string(dms["ship_mould"], self._ship_mould_id, ship_mould.fitSkillTwo), ",")

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_closed"), nil, 
    {
        terminal_name = "sm_limited_time_equip_box_close", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 3)

    -- 开启1次
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_open_1"), nil, 
    {
        terminal_name = "sm_limited_time_equip_box_a_recruiting",
        terminal_state = 0,
        touch_black = true,
        _type = 1,
    },
    nil,1)
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_the_center_sm_limited_time_box",
        _widget = ccui.Helper:seekWidgetByName(root,"Button_open_1"),
        _invoke = nil,
        _interval = 0.5,})

    -- 开启10次
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_open_2"), nil, 
    {
        terminal_name = "sm_limited_time_equip_box_ten_recruiting",
        terminal_state = 0,
        touch_black = true,
        _type = 2,
    },
    nil,1)

    -- 进化链
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_evo"), nil, 
    {
        terminal_name = "sm_limited_time_equip_box_hero_evolution",
        terminal_state = 0,
        touch_black = true,
    },
    nil,1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_arrow_change_left"), nil, 
    {
        terminal_name = "sm_limited_time_equip_box_change_digimon",
        terminal_state = 0,
        touch_black = true,
        turn_type = -1,
    },
    nil,1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_arrow_change_right"), nil, 
    {
        terminal_name = "sm_limited_time_equip_box_change_digimon",
        terminal_state = 0,
        touch_black = true,
        turn_type = 1,
    },
    nil,1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_help"), nil, 
    {
        terminal_name = "sm_limited_time_equip_box_rule_infor",
        terminal_state = 0,
        touch_black = true,
    },
    nil,1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_shuaxin"), nil, 
    {
        terminal_name = "sm_limited_time_equip_box_update_rank",
        terminal_state = 0,
        touch_black = true,
    },
    nil,1)

    self:onUpdateDraw()
    self:onUpdateDigimonInfo(4)
    self:onUpdateRankRewardInfo()

    state_machine.excute("sm_limited_time_equip_box_update_rank", 0, "")
end

function SmLimitedTimeEquipBox:onEnterTransitionFinish()
    
end


function SmLimitedTimeEquipBox:onExit()
	state_machine.remove("sm_limited_time_equip_box_update_draw")
    state_machine.remove("sm_limited_time_equip_box_get_reward")
    state_machine.remove("sm_limited_time_equip_box_change_digimon")
    state_machine.remove("sm_limited_time_equip_box_hero_evolution")
    state_machine.remove("sm_limited_time_equip_box_a_recruiting")
    state_machine.remove("sm_limited_time_equip_box_ten_recruiting")
    state_machine.remove("sm_limited_time_equip_box_rule_infor")
    state_machine.remove("sm_limited_time_equip_box_update_rank")
    state_machine.remove("sm_limited_time_equip_box_play_hero_animation")
end

