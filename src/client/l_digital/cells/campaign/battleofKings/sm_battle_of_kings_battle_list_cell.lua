--------------------------------------------------------------------------------------------------------------
--  说明：王者之战战斗列表控件
--------------------------------------------------------------------------------------------------------------
SmBattleOfKingsBattleListCell = class("SmBattleOfKingsBattleListCellClass", Window)
SmBattleOfKingsBattleListCell.__size = nil

--创建cell
local sm_battle_of_kings_battle_list_cell_terminal = {
    _name = "sm_battle_of_kings_battle_list_cell",
    _init = function (terminal)
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        local cell = SmBattleOfKingsBattleListCell:new()
        cell:init(params)
        cell:registerOnNodeEvent(cell)
        cell:registerOnNoteUpdate(cell)
        return cell
    end,
    _terminal = nil,
    _terminals = nil
}


state_machine.add(sm_battle_of_kings_battle_list_cell_terminal)
state_machine.init()

function SmBattleOfKingsBattleListCell:ctor()
	self.super:ctor()
	self.roots = {}
    app.load("client.cells.utils.resources_icon_cell")
    self.cd_time = 0
    self.m_overs = false
    self.isSettlement = false
	 -- Initialize sm_battle_of_kings_battle_list_cell state machine.
    local function init_sm_battle_of_kings_battle_list_cell_terminal()
        --
        local sm_battle_of_kings_battle_list_cell_look_formation_terminal = {
            _name = "sm_battle_of_kings_battle_list_cell_look_formation",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)          
                local cell = params._datas.cell
                if _ED.kings_battle.battle_match_info ~= nil and #_ED.kings_battle.battle_match_info > 0 then
                    state_machine.excute("sm_battleof_kings_view_general_formation_open", 0, {_ED.kings_battle.battle_match_info[tonumber(cell.index)].other_side_formation})
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_battle_of_kings_battle_list_cell_play_back_terminal = {
            _name = "sm_battle_of_kings_battle_list_cell_play_back",
            _init = function (terminal) 
                app.load("client.battle.BattleStartEffect")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)          
                local cell = params._datas.cell
                local fighting_results = zstring.split(_ED.kings_battle.kings_battle_result, "|")
                local results = zstring.split(fighting_results[tonumber(cell.index)], ",")
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            _ED.battle_playback_arena.playback = true
                            _ED.battle_playback_arena.nType = 211
                            _ED.battle_playback_arena.time = results[2]
                            
                            if _ED.user_info.last_user_grade ~= _ED.user_info.user_grade then
                                _ED.user_is_level_up = true
                                _ED.arena_is_level_up = true
                                _ED.last_grade = _ED.user_info.last_user_grade
                                _ED.last_food = _ED.user_info.last_user_food
                                _ED.last_endurance = _ED.user_info.last_endurance           
                            end
                            -- 胜利了,记录当前.requestArenaFightDatas
                            -- if tonumber(_ED.attackData.isWin) == 1 then
                                
                            -- end
                            fwin:close(self.userInformationHeroStorage)
                            fwin:cleanView(fwin._windows)
                            fwin:freeAllMemeryPool()
                            local bse = BattleStartEffect:new()
                            bse:init(_enum_fight_type._fight_type_211)
                            fwin:open(bse, fwin._windows)
                        end 
                    end
                end
                protocol_command.battlefield_report_battle_info_get.param_list = "211".."\r\n"..results[2]
                NetworkManager:register(protocol_command.battlefield_report_battle_info_get.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }


        state_machine.add(sm_battle_of_kings_battle_list_cell_look_formation_terminal)
        state_machine.add(sm_battle_of_kings_battle_list_cell_play_back_terminal)
        state_machine.init()
    end 
    -- call func sm_battle_of_kings_battle_list_cell create state machine.
    init_sm_battle_of_kings_battle_list_cell_terminal()

end

function SmBattleOfKingsBattleListCell:updateDraw(isSettlement)
    local root = self.roots[1]
    --我的名字
    local Text_name_lv_1 = ccui.Helper:seekWidgetByName(root, "Text_name_lv_1")
    Text_name_lv_1:setString(_ED.user_info.user_name.." Lv.".._ED.user_info.user_grade)
    --对方的名字
    local Text_name_lv_2 = ccui.Helper:seekWidgetByName(root, "Text_name_lv_2")
    if tonumber(_ED.kings_battle.kings_battle_open_type) ~= 4 then
        Text_name_lv_2:setString("??????")
    else
        Text_name_lv_2:setString(_ED.kings_battle.battle_match_info[tonumber(self.index)].name.." Lv.".._ED.kings_battle.battle_match_info[tonumber(self.index)].lv)
    end

    local fighting_results = zstring.split(_ED.kings_battle.kings_battle_result, "|")
    local results = zstring.split(fighting_results[tonumber(self.index)], ",")
    local isOver = false
    if tonumber(results[1]) < 0 then
        isOver = false
    else
        isOver = true
    end
    --战斗cd
    local Text_time = ccui.Helper:seekWidgetByName(root, "Text_time")
    if tonumber(_ED.kings_battle.kings_battle_open_type) ~= 4 then
        self.cd_time = tonumber(_ED.kings_battle.kings_battle_next_time)/1000 - (tonumber(_ED.system_time)+os.time()-tonumber(_ED.native_time))
    else
        if tonumber(_ED.kings_battle.peak_number) > 0 or tonumber(_ED.kings_battle.my_lose_number) >= 3 then
            self.cd_time = 0
            isSettlement = true
        else
            if isOver == false then
                self.cd_time = tonumber(_ED.kings_battle.single_field_end_cd)/1000 - (tonumber(_ED.system_time)+os.time()-tonumber(_ED.native_time))
            else
                if tonumber(self.index) == tonumber(self.max_index) then
                    self.cd_time = tonumber(_ED.kings_battle.single_field_end_cd)/1000 - (tonumber(_ED.system_time)+os.time()-tonumber(_ED.native_time))
                else
                    self.cd_time = 0
                    isSettlement = true
                end
            end
        end
    end

    ccui.Helper:seekWidgetByName(root, "Image_list_vs"):setVisible(true)

    --宝箱名称
    local Text_box_name = ccui.Helper:seekWidgetByName(root, "Text_box_name") 
    --宝箱图标
    local Panel_box = ccui.Helper:seekWidgetByName(root, "Panel_box") 

    local Panel_time = ccui.Helper:seekWidgetByName(root, "Panel_time") 
    if tonumber(_ED.kings_battle.kings_battle_open_type) ~= 4 then
        Text_box_name:setVisible(false)
        Panel_box:setVisible(false)
        Panel_time:setVisible(true)
    else
        if isOver == false then
            Text_box_name:setVisible(false)
            Panel_box:setVisible(false)
            Panel_time:setVisible(true)
        else
            if isSettlement == true then
                if self.cd_time <= 60 then
                    Text_box_name:setVisible(true)
                    Panel_box:setVisible(true)
                    Panel_time:setVisible(false)
                    if Panel_box:getChildByTag(500) ~= nil then
                        Panel_box:removeChildByTag(500)
                    end
                    if tonumber(results[1]) == 0 then
                        local jsonFile = "sprite/sprite_wzzz_bx.json"
                        local atlasFile = "sprite/sprite_wzzz_bx.atlas"
                        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "box_2", true, nil)
                        -- animation:setPosition(cc.p(Panel_icon:getContentSize().width/2,Panel_icon:getContentSize().height/2))
                        animation:setTag(500)
                        Panel_box:addChild(animation)
                        -- Panel_box:removeAllChildren(true)
                        --画宝箱银的
                        -- local cell = ResourcesIconCell:createCell()
                        local reworld = zstring.split(dms.string(dms["play_config"], 48, pirates_config.param), ",")
                        -- cell:init(reworld[1], tonumber(reworld[3]), reworld[2],nil,nil,true,true)
                        -- Panel_box:addChild(cell)
                        Text_box_name:setString(setThePropsIcon(reworld[2])[2])
                    else
                        --画宝箱金的
                        local jsonFile = "sprite/sprite_wzzz_bx.json"
                        local atlasFile = "sprite/sprite_wzzz_bx.atlas"
                        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "box_1", true, nil)
                        -- animation:setPosition(cc.p(Panel_icon:getContentSize().width/2,Panel_icon:getContentSize().height/2))
                        animation:setTag(500)
                        Panel_box:addChild(animation)
                        -- Panel_box:removeAllChildren(true)
                        -- local cell = ResourcesIconCell:createCell()
                        local reworld = zstring.split(dms.string(dms["play_config"], 47, pirates_config.param), ",")
                        -- cell:init(reworld[1], tonumber(reworld[3]), reworld[2],nil,nil,true,true)
                        -- Panel_box:addChild(cell)
                        Text_box_name:setString(setThePropsIcon(reworld[2])[2])
                    end
                else
                    Text_box_name:setVisible(false)
                    Panel_box:setVisible(false)
                    Panel_time:setVisible(true)
                end
            else
                Text_box_name:setVisible(false)
                Panel_box:setVisible(false)
                Panel_time:setVisible(true)
            end
        end
    end
    --第几场
    local Panel_cc = ccui.Helper:seekWidgetByName(root, "Panel_cc") 
    Panel_cc:removeBackGroundImage()
    Panel_cc:setBackGroundImage(string.format("images/ui/text/SMZB_res/cc/cc_%d.png", tonumber(self.index)))

    --我方的战船
    local Panel_digimon_icon_1 = ccui.Helper:seekWidgetByName(root, "Panel_digimon_icon_1") 
    Panel_digimon_icon_1:removeAllChildren(true)
    if tonumber(_ED.kings_battle.kings_battle_open_type) ~= 4 then
        local formation_info = zstring.split(_ED.kings_battle.kings_battle_user_formation, "!")
        local datas = zstring.split(formation_info[tonumber(self.index)],":")
        local cell = ShipIconCell:createCell()
        cell:init(_ED.user_ship[datas[7]],12)
        Panel_digimon_icon_1:addChild(cell)
    else
        local formation_info = zstring.split(_ED.kings_battle.battle_match_info[tonumber(self.index)].my_formation, "!")
        local datas = zstring.split(formation_info[tonumber(self.index)],":")
        local cell = ShipIconCell:createCell()
        cell:init(_ED.user_ship[datas[7]],12)
        Panel_digimon_icon_1:addChild(cell)
    end
    --我方胜利
    local Image_win_1 = ccui.Helper:seekWidgetByName(root, "Image_win_1")  
    --我方失败
    local Image_lose_1 = ccui.Helper:seekWidgetByName(root, "Image_lose_1")  

    local Panel_dh = ccui.Helper:seekWidgetByName(root, "Panel_dh")  
    local Panel_dh_2 = ccui.Helper:seekWidgetByName(root, "Panel_dh_2")  
    if Panel_dh_2:getChildByTag(500) ~= nil then
        Panel_dh_2:removeChildByTag(500)
    end

    if tonumber(_ED.kings_battle.kings_battle_open_type) ~= 4 then
        Image_win_1:setVisible(false)
        Image_lose_1:setVisible(false)
    else
        if isOver == false then
            Image_win_1:setVisible(false)
            Image_lose_1:setVisible(false)
            local jsonFile = "sprite/sprite_wzzz_bzz.json"
            local atlasFile = "sprite/sprite_wzzz_bzz.atlas"
            local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
            -- animation:setPosition(cc.p(Panel_icon:getContentSize().width/2,Panel_icon:getContentSize().height/2))
            animation:setTag(500)
            Panel_dh_2:addChild(animation)
        else
            if isSettlement == true then
                if self.cd_time <= 60 then
                    if Panel_dh:getChildByTag(500) ~= nil then
                        Panel_dh:removeChildByTag(500)
                    end
                    if Panel_dh_2:getChildByTag(500) ~= nil then
                        Panel_dh_2:removeChildByTag(500)
                    end
                    if tonumber(results[1]) == 0 then
                        Image_win_1:setVisible(false)
                        Image_lose_1:setVisible(true)
                    else
                        Image_win_1:setVisible(true)
                        Image_lose_1:setVisible(false)
                    end
                else
                    Image_win_1:setVisible(false)
                    Image_lose_1:setVisible(false)
                end
            else
                Image_win_1:setVisible(false)
                Image_lose_1:setVisible(false)
            end
        end
    end

    --对方的战船
    local Panel_digimon_icon_2 = ccui.Helper:seekWidgetByName(root, "Panel_digimon_icon_2")  
    --敌方胜利
    local Image_win_2 = ccui.Helper:seekWidgetByName(root, "Image_win_2")  
    --敌方失败
    local Image_lose_2 = ccui.Helper:seekWidgetByName(root, "Image_lose_2")  
    --回放按钮
    local Button_replay = ccui.Helper:seekWidgetByName(root, "Button_replay") 
    if tonumber(_ED.kings_battle.kings_battle_open_type) ~= 4 then
        Panel_digimon_icon_2:removeAllChildren(true)
        Image_win_2:setVisible(false)
        Image_lose_2:setVisible(false)
        Button_replay:setVisible(false)
    else
        Panel_digimon_icon_2:removeAllChildren(true)
        local formation_info = zstring.split(_ED.kings_battle.battle_match_info[tonumber(self.index)].other_side_formation, "!")
        local datas = zstring.split(formation_info[tonumber(self.index)],":")
        local cell = ShipIconCell:createCell()
         local ships = {}
        ships.ship_template_id = datas[1]
        ships.evolution_status = datas[3]
        ships.Order = datas[5]
        ships.ship_grade = datas[2]
        ships.StarRating = datas[4]
        cell:init(ships,12)
        Panel_digimon_icon_2:addChild(cell)
        if isSettlement == true then
            Button_replay:setVisible(true)
        else
            Button_replay:setVisible(false)
        end
    end
end

function SmBattleOfKingsBattleListCell:getTimeDesByInterval( timeInt )
    if timeInt <= 0 then
        timeInt = 0
    end
    local result = ""
    local oh     = math.floor(timeInt/3600)
    local om     = math.floor((timeInt - oh*3600)/60)
    local os     = math.floor(timeInt - oh*3600 - om*60)
    local hour = oh
    local day  = 0
    if(oh>=24) then
        day  = math.floor(hour/24)
        hour = oh - day*24
    end
    if(hour ~= 0) then
    end
    if(om ~= 0) then
        if(hour ~= 0) then
            om = om + hour*60
        end
        if om < 10 then
            om = "0"..om
        end
        result = result .. om .. ":"
    else
        if(hour ~= 0) then
            om = om + hour*60
            if om < 10 then
                om = "0"..om
            end
        else
            om = "00"
        end
        result = result .. om .. ":"     
    end
    if(os ~= 0) then
        if os < 10 then
            os = "0"..os
        end
        result = result .. os
    else
        result = result .. "00"
    end
    return result
end

function SmBattleOfKingsBattleListCell:onUpdate(dt)
    if self.m_overs == true then
        return
    end
    if (tonumber(_ED.kings_battle.peak_number) > 0 or tonumber(_ED.kings_battle.my_lose_number) >= 3) and self.cd_time == 0 then
        self.m_overs = true
        return
    end
    if self.cd_time >= 0 and tonumber(self.index) == tonumber(self.max_index) then
        self.cd_time = self.cd_time - dt
        ccui.Helper:seekWidgetByName(self.roots[1], "Text_time"):setString(self:getTimeDesByInterval(self.cd_time))
        if tonumber(_ED.kings_battle.kings_battle_open_type) == 4 then
            if self.cd_time <= 60 then
                if self.isSettlement == false then
                    protocol_command.the_kings_battle_manager.param_list = "4"
                    NetworkManager:register(protocol_command.the_kings_battle_manager.code, nil, nil, nil, self, nil, false, nil)  
                    local Panel_dh_2 = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_dh_2")  
                    if Panel_dh_2:getChildByTag(500) ~= nil then
                        Panel_dh_2:removeChildByTag(500)
                    end
                    local Panel_dh = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_dh")  
                    if Panel_dh:getChildByTag(500) ~= nil then
                        Panel_dh:removeChildByTag(500)
                    end
                    local jsonFile = "sprite/sprite_wzzz_jxz.json"
                    local atlasFile = "sprite/sprite_wzzz_jxz.atlas"
                    local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
                    -- animation:setPosition(cc.p(Panel_icon:getContentSize().width/2,Panel_icon:getContentSize().height/2))
                    animation:setTag(500)
                    Panel_dh:addChild(animation)
                    ccui.Helper:seekWidgetByName(self.roots[1], "Image_list_vs"):setVisible(false)
                    self.isSettlement = true
                end
            else

            end
            if self.cd_time <= 0.1 then
                ccui.Helper:seekWidgetByName(self.roots[1], "Text_time"):setString("")
                local function requesrDefendCheck(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots[1] ~= nil then
                            if tonumber(self.index) < 10 and tonumber(_ED.kings_battle.my_lose_number) < 3 then
                                state_machine.excute("sm_battleof_kings_prepare_for_the_game_update_draw_list", 0, "")
                                -- self.cd_time = tonumber(_ED.kings_battle.single_field_end_cd)/1000 - (tonumber(_ED.system_time)+os.time()-tonumber(_ED.native_time))
                            else
                                self.m_overs = true
                                state_machine.excute("sm_battleof_kings_prepare_for_the_game_update_draw", 0, "")
                            end
                            -- ccui.Helper:seekWidgetByName(self.roots[1], "Text_time"):setString("")
                            -- self:updateDraw(true)
                        end
                    else
                        fwin:addService({
                            callback = function ( params )
                                if params ~= nil and params.roots ~= nil and params.roots[1] ~= nil then
                                    protocol_command.the_kings_battle_manager.param_list = "4"
                                    NetworkManager:register(protocol_command.the_kings_battle_manager.code, nil, nil, nil, params, requesrDefendCheck, false, nil) 
                                end 
                            end,
                            delay = 1,
                            params = response.node
                        })
                    end
                end
                fwin:addService({
                    callback = function ( params )
                        if params ~= nil and params.roots ~= nil and params.roots[1] ~= nil then
                            protocol_command.the_kings_battle_manager.param_list = "4"
                            NetworkManager:register(protocol_command.the_kings_battle_manager.code, nil, nil, nil, params, requesrDefendCheck, false, nil) 
                        end 
                    end,
                    delay = 1,
                    params = self
                })
                -- protocol_command.the_kings_battle_manager.param_list = "4"
                -- NetworkManager:register(protocol_command.the_kings_battle_manager.code, nil, nil, nil, self, requesrDefendCheck, false, nil)  
            end
        end
    end
end

function SmBattleOfKingsBattleListCell:onInit()
    local root = cacher.createUIRef("campaign/BattleofKings/battle_of_kings_tab_2_list_1.csb", "root")
    table.insert(self.roots, root)
    self:addChild(root)

    if SmBattleOfKingsBattleListCell.__size == nil then
        SmBattleOfKingsBattleListCell.__size = root:getContentSize()
    end

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_digimon_icon_1"), nil, 
    {
        terminal_name = "sm_battleof_kings_my_general_formation_open", 
        terminal_state = 0, 
    }, nil, 1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_digimon_icon_2"), nil, 
    {
        terminal_name = "sm_battle_of_kings_battle_list_cell_look_formation", 
        terminal_state = 0, 
        cell = self
    }, nil, 1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_replay"), nil, 
    {
        terminal_name = "sm_battle_of_kings_battle_list_cell_play_back", 
        terminal_state = 0, 
        cell = self
    }, nil, 1)

	self:updateDraw(false)
end

function SmBattleOfKingsBattleListCell:onEnterTransitionFinish()
    local root = self.roots[1]
   
end

function SmBattleOfKingsBattleListCell:clearUIInfo( ... )
    local root = self.roots[1]
    local Panel_dh_2 = ccui.Helper:seekWidgetByName(root, "Panel_dh_2")
    local Panel_dh = ccui.Helper:seekWidgetByName(roots, "Panel_dh")
    local Panel_box = ccui.Helper:seekWidgetByName(root, "Panel_box")
    local Panel_digimon_icon_1 = ccui.Helper:seekWidgetByName(root, "Panel_digimon_icon_1") 
    local Panel_digimon_icon_2 = ccui.Helper:seekWidgetByName(root, "Panel_digimon_icon_2")
    local Image_win_1 = ccui.Helper:seekWidgetByName(root, "Image_win_1")
    local Image_lose_1 = ccui.Helper:seekWidgetByName(root, "Image_lose_1")
    local Image_win_2 = ccui.Helper:seekWidgetByName(root, "Image_win_2")
    local Image_lose_2 = ccui.Helper:seekWidgetByName(root, "Image_lose_2")
    local Button_replay = ccui.Helper:seekWidgetByName(root, "Button_replay")
    local Text_time = ccui.Helper:seekWidgetByName(root, "Text_time")
    if Panel_dh ~= nil then
        Panel_dh:removeAllChildren(true)
        Panel_dh_2:removeAllChildren(true)
        Panel_box:removeAllChildren(true)
        Panel_digimon_icon_1:removeAllChildren(true)
        Panel_digimon_icon_2:removeAllChildren(true)
        Image_win_1:setVisible(false)
        Image_lose_1:setVisible(false)
        Image_win_2:setVisible(false)
        Image_lose_2:setVisible(false)
        Button_replay:setVisible(false)
        Text_time:setString("")
    end
    self.cd_time = 0
    self.isSettlement = false
end

function SmBattleOfKingsBattleListCell:reload()
    local root = self.roots[1]
    if root ~= nil then
        return
    end
    self:registerOnNoteUpdate(self)
    self:onInit()
end

function SmBattleOfKingsBattleListCell:unload()
    local root = self.roots[1]
    if root == nil then
        return
    end
	self:clearUIInfo()
    cacher.freeRef("campaign/BattleofKings/battle_of_kings_tab_2_list_1.csb", root)
    root:stopAllActions()
    self:unregisterOnNoteUpdate(self)
    root:removeFromParent(false)
    self.roots = {}
end

function SmBattleOfKingsBattleListCell:init(params)
    self.index = params[1]
    self.max_index = params[2]
	self:onInit()

    self:setContentSize(SmBattleOfKingsBattleListCell.__size)
    return self
end

function SmBattleOfKingsBattleListCell:onExit()
	self:clearUIInfo()
    cacher.freeRef("campaign/BattleofKings/battle_of_kings_tab_2_list_1.csb", self.roots[1])
end