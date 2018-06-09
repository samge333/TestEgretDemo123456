-- ----------------------------------------------------------------------------------------------------
-- 说明：角色升星
-------------------------------------------------------------------------------------------------------
SmRoleStrengthenTabRisingStar = class("SmRoleStrengthenTabRisingStarClass", Window)

local sm_role_strengthen_tab_rising_star_open_terminal = {
    _name = "sm_role_strengthen_tab_rising_star_open",
    _init = function (terminal) 
    
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
		local _homeWindow = fwin:find("SmRoleStrengthenTabRisingStarClass")
        if nil == _homeWindow then
            local panel = SmRoleStrengthenTabRisingStar:new():init(params)
            fwin:open(panel)
        else
            fwin:close(fwin:find("SmRoleStrengthenTabRisingStarClass"))
            local panel = SmRoleStrengthenTabRisingStar:new():init(params)
            fwin:open(panel)
        end
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local sm_role_strengthen_tab_rising_star_close_terminal = {
    _name = "sm_role_strengthen_tab_rising_star_close",
    _init = function (terminal) 
    
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
		local _homeWindow = fwin:find("SmRoleStrengthenTabRisingStarClass")
        if nil ~= _homeWindow then
    		fwin:close(fwin:find("SmRoleStrengthenTabRisingStarClass"))
        end
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_role_strengthen_tab_rising_star_open_terminal)
state_machine.add(sm_role_strengthen_tab_rising_star_close_terminal)
state_machine.init()
    
function SmRoleStrengthenTabRisingStar:ctor()
    self.super:ctor()
    self.roots = {}
    self.currentCount = 0
    self.prop_scrap_mould_id = 0

    app.load("client.cells.equip.equip_icon_new_cell")
    app.load("client.cells.ship.ship_head_new_cell")
    app.load("client.cells.prop.prop_icon_new_cell")
    local function init_sm_role_strengthen_tab_rising_star_terminal()
        -- 显示界面
        local sm_role_strengthen_tab_rising_star_display_terminal = {
            _name = "sm_role_strengthen_tab_rising_star_display",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local SmRoleStrengthenTabRisingStarWindow = fwin:find("SmRoleStrengthenTabRisingStarClass")
                if SmRoleStrengthenTabRisingStarWindow ~= nil then
                    SmRoleStrengthenTabRisingStarWindow:setVisible(true)
                    instance:onUpdateDraw()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 隐藏界面
        local sm_role_strengthen_tab_rising_star_hide_terminal = {
            _name = "sm_role_strengthen_tab_rising_star_hide",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local SmRoleStrengthenTabRisingStarWindow = fwin:find("SmRoleStrengthenTabRisingStarClass")
                if SmRoleStrengthenTabRisingStarWindow ~= nil then
                    SmRoleStrengthenTabRisingStarWindow:setVisible(false)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 刷新
        local sm_role_strengthen_tab_rising_star_update_draw_terminal = {
            _name = "sm_role_strengthen_tab_rising_star_update_draw",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:onUpdateDraw()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 改变id
        local sm_role_strengthen_tab_rising_star_change_ship_terminal = {
            _name = "sm_role_strengthen_tab_rising_star_change_ship",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance.ship_id = params
                state_machine.excute("notification_center_update",0,"push_notification_center_hero_strength_up_grade_button")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 请求升星
        local sm_role_strengthen_tab_rising_star_request_terminal = {
            _name = "sm_role_strengthen_tab_rising_star_request",
            _init = function (terminal) 
                app.load("client.packs.hero.GeneralsStarUpSuccessWindow")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.lock("sm_role_strengthen_tab_rising_star_request")
                local ship_id = instance.ship_id
                if tonumber(instance.currentCount) < tonumber(instance.demandCount) then
                    local material = dms.searchs(dms["prop_mould"], prop_mould.use_of_ship, tonumber(_ED.user_ship[ship_id].ship_template_id))
                    if material ~= nil then
                        for i=1, #material do
                            if tonumber(material[i][9]) == 1 then
                                local prop = material[i][1] --道具模板id
                                app.load("client.packs.hero.HeroPatchInformationPageGetWay")
                                local cell = HeroPatchInformationPageGetWay:createCell()
                                cell:init(prop,5)
                                fwin:open(cell, fwin._windows)
                                state_machine.unlock("sm_role_strengthen_tab_rising_star_request")
                                return
                            end
                        end
                    end
                    return
                end
                local currShip = getShipByTalent(_ED.user_ship[ship_id])
                local oldshipInfo = {
                    Order = currShip.Order,
                    hero_fight = currShip.hero_fight,
                    StarRating = currShip.StarRating,
                    ship_template_id = currShip.ship_template_id,
                    evolution_status = currShip.evolution_status,
                    ship_wisdom = currShip.ship_wisdom,
                }
                local function responseWearCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            if __lua_project_id == __lua_project_l_digital 
                                or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                                then
                                setShipPushData(ship_id,3,-1)
                            end
                            response.node:onUpdateDraw()
                            local currShip = getShipByTalent(_ED.user_ship[ship_id])
                            local StarRating = tonumber(currShip.StarRating)
                            local Image_star = ccui.Helper:seekWidgetByName(instance.roots[1], "Image_star_"..StarRating)
                            Image_star:setVisible(false)
                            
                            state_machine.excute("generals_star_up_success_window_open",0,{oldshipInfo,currShip,2})
                            if fwin:find("HeroDevelopClass") ~= nil then
                                state_machine.excute("sm_role_strengthen_tab_update_ship_info",0,{ship_id})
                                state_machine.excute("hero_develop_page_strength_to_update_all_icon",0,currShip)
                            else
                                state_machine.excute("hero_icon_listview_update_all_icon",0,currShip)
                            end

                            if __lua_project_id == __lua_project_l_digital 
                                or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                                then
                                state_machine.excute("sm_role_strengthen_tab_skill_update_draw") -- 刷新技能解锁情况
                                -- state_machine.excute("sm_role_strengthen_tab_play_control_effect", 0, 0)
                                state_machine.excute("notification_center_update",0,"push_notification_center_formation_ship_evo")
                            end
                        end
                        state_machine.excute("user_info_hero_storage_update", 0, "user_info_hero_storage_update.") -- 刷新顶部信息
                        state_machine.unlock("formation_back_to_home_activity", 0, "")
                    else
                        state_machine.unlock("formation_back_to_home_activity", 0, "")
                        state_machine.unlock("sm_role_strengthen_tab_rising_star_request")
                    end
                end
                state_machine.lock("formation_back_to_home_activity", 0, "")
                protocol_command.ship_awaken.param_list = ship_id
                NetworkManager:register(protocol_command.ship_awaken.code, nil, nil, nil, instance, responseWearCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 万能碎片兑换
        local sm_role_strengthen_tab_rising_star_all_exchange_terminal = {
            _name = "sm_role_strengthen_tab_rising_star_all_exchange",
            _init = function (terminal) 
                app.load("client.packs.hero.SmRoleStrengthenUniversal")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance.prop_scrap_mould_id == 0 then
                    return
                end
                state_machine.excute("sm_role_strengthen_tab_universal_open" , 0 , { instance.prop_scrap_mould_id, instance.currentCount })
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 升星的星星下落动画
        local sm_role_strengthen_tab_rising_the_stars_fall_terminal = {
            _name = "sm_role_strengthen_tab_rising_the_stars_fall",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local StarRating = tonumber(_ED.user_ship[instance.ship_id].StarRating)
                local Image_star = ccui.Helper:seekWidgetByName(instance.roots[1], "Image_star_"..StarRating)
                Image_star:setVisible(true)
                Image_star:setScale(4)
                Image_star:setRotation(270)
                function blinkOutCallback(sender)
                    state_machine.unlock("sm_role_strengthen_tab_rising_star_request")
                    if fwin:find("HeroDevelopClass") ~= nil then
                    else
                        for i, v in pairs(_ED.user_formetion_status) do
                            if tonumber(v) == tonumber(instance.ship_id) then
                                state_machine.excute("formation_set_ship",0,getShipByTalent(_ED.user_ship[instance.ship_id]))
                                break
                            end
                        end
                    end
                end
                local seq = cc.Sequence:create(
                    cc.Spawn:create({cc.ScaleTo:create(0.25, 1),
                        cc.RotateBy:create(0.25, 90)
                        }))

                Image_star:runAction(seq)
                Image_star:runAction(cc.Sequence:create(
                        cc.DelayTime:create(0.25),
                        cc.CallFunc:create(blinkOutCallback)
                         ))
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 刷新金币显示
        local sm_role_strengthen_tab_rising_stars_update_golds_terminal = {
            _name = "sm_role_strengthen_tab_rising_stars_update_golds",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
                    instance:showGolds()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --碎片追踪
        local sm_role_strengthen_tab_rising_stars_material_tracking_terminal = {
            _name = "sm_role_strengthen_tab_rising_stars_material_tracking",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local material = dms.searchs(dms["prop_mould"], prop_mould.use_of_ship, tonumber(_ED.user_ship[instance.ship_id].ship_template_id))
                if material ~= nil then
                    for i=1, #material do
                        if tonumber(material[i][9]) == 1 then
                            local prop = material[i][1] --道具模板id
                            app.load("client.packs.hero.HeroPatchInformationPageGetWay")
                            local cell = HeroPatchInformationPageGetWay:createCell()
                            cell:init(prop,5)
                            fwin:open(cell, fwin._windows)
                            return
                        end
                    end
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_role_strengthen_tab_rising_star_display_terminal)
        state_machine.add(sm_role_strengthen_tab_rising_star_hide_terminal)
        state_machine.add(sm_role_strengthen_tab_rising_star_update_draw_terminal)
        state_machine.add(sm_role_strengthen_tab_rising_star_change_ship_terminal)
        state_machine.add(sm_role_strengthen_tab_rising_star_request_terminal)
        state_machine.add(sm_role_strengthen_tab_rising_star_all_exchange_terminal)
        state_machine.add(sm_role_strengthen_tab_rising_the_stars_fall_terminal)
        state_machine.add(sm_role_strengthen_tab_rising_stars_update_golds_terminal)
        state_machine.add(sm_role_strengthen_tab_rising_stars_material_tracking_terminal)
        
        state_machine.init()
    end
    init_sm_role_strengthen_tab_rising_star_terminal()
end

function SmRoleStrengthenTabRisingStar:showGolds()
    local root = self.roots[1]
    local StarRating = tonumber(_ED.user_ship[self.ship_id].StarRating)
    local awakenData = dms.int(dms["awaken_requirement"], StarRating, awaken_requirement.need_silver)
    local Text_role_up_star_gold_n = ccui.Helper:seekWidgetByName(root, "Text_role_up_star_gold_n")
    if tonumber(_ED.user_ship[self.ship_id].ship_grade) < dms.int(dms["awaken_requirement"], StarRating, awaken_requirement.ship_level_limit) then
        Text_role_up_star_gold_n:setString(string.format(_new_interface_text[6],dms.int(dms["awaken_requirement"], StarRating, awaken_requirement.ship_level_limit)))
        Text_role_up_star_gold_n:setColor(cc.c3b(color_Type[6][1], color_Type[6][2], color_Type[6][3]))
        ccui.Helper:seekWidgetByName(root, "Image_gold_icon"):setVisible(false)
    else
        Text_role_up_star_gold_n:setString(awakenData)
        ccui.Helper:seekWidgetByName(root, "Image_gold_icon"):setVisible(true)
        if awakenData > tonumber(_ED.user_info.user_silver) then
            Text_role_up_star_gold_n:setColor(cc.c3b(color_Type[6][1], color_Type[6][2], color_Type[6][3]))
        else
            Text_role_up_star_gold_n:setColor(cc.c3b(color_Type[1][1], color_Type[1][2], color_Type[1][3]))
        end
    end
    if tonumber(awakenData) == -1 then
        ccui.Helper:seekWidgetByName(root, "Image_gold_icon"):setVisible(false)
        Text_role_up_star_gold_n:setString("")
    end
end

function SmRoleStrengthenTabRisingStar:onUpdateDraw()
    local root = self.roots[1]
    if root == nil then 
        return
    end
    local ship = _ED.user_ship[self.ship_id]
    
    for i=1, 7 do
        ccui.Helper:seekWidgetByName(root, "Image_star_"..i):setVisible(false)
    end
    local StarRating = tonumber(_ED.user_ship[self.ship_id].StarRating)
    if StarRating >= 7 then
        ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"):setBright(false)
        ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"):setTouchEnabled(false)
    else
        ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"):setBright(true)
        ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"):setTouchEnabled(true)
    end
    if StarRating > 0 and StarRating <= 7 then
        for i=1, StarRating do
            local Image_star = ccui.Helper:seekWidgetByName(root, "Image_star_"..i)
            Image_star:setVisible(true)
        end
    end
    self.prop_scrap_mould_id = dms.int(dms["ship_mould"], tonumber(_ED.user_ship[self.ship_id].ship_template_id), ship_mould.fitSkillOne)
    local base_mould2 = dms.int(dms["ship_mould"], tonumber(_ED.user_ship[self.ship_id].ship_template_id), ship_mould.base_mould2)
    --当前碎片
    local info = dms.searchs(dms["awaken_requirement"], awaken_requirement.group_id, base_mould2, awaken_requirement.awake_level, StarRating)
    self.currentCount = 0
    self.demandCount = info[1][awaken_requirement.need_same_card_count]
    for i, prop in pairs(_ED.user_prop) do
        if zstring.tonumber(prop.user_prop_id) > 0 then
            local propData = dms.element(dms["prop_mould"], prop.user_prop_template)
            if dms.atoi(propData, prop_mould.storage_page_index) == 18 then
                if dms.atoi(propData, prop_mould.use_of_ship) == tonumber(_ED.user_ship[self.ship_id].ship_template_id) then
                    self.currentCount = zstring.tonumber(getPropAllCountByMouldId(prop.user_prop_template))
                end
            end
        end
    end 
    self:showGolds()   
    if fwin:find("SmRoleStrengthenTabClass") ~= nil then
        state_machine.excute("sm_role_strengthen_tab_update_Loading",0,{ self.currentCount,self.demandCount,3})
    end
    if fwin:find("SmRoleStrengthenTabSpecialAttributesClass") ~= nil then
        state_machine.excute("sm_role_strengthen_tab_special_attributes_update_Loading",0,{ self.currentCount,self.demandCount,3})
    end

    
    local Text_role_up_lv_num_1 = ccui.Helper:seekWidgetByName(self.roots[1],"Text_role_up_lv_num_1")
    if Text_role_up_lv_num_1 ~= nil then
        if tonumber(self.demandCount) > 0 then
            Text_role_up_lv_num_1:setString(self.currentCount.."/"..self.demandCount)
        else
            Text_role_up_lv_num_1:setString(self.currentCount)
        end
    end

    local material = dms.searchs(dms["prop_mould"], prop_mould.use_of_ship, tonumber(_ED.user_ship[self.ship_id].ship_template_id))
    if material ~= nil then
        for i=1, #material do
            if tonumber(material[i][9]) == 1 then
                local prop = material[i][1] --道具模板id
                local Panel_role_up_lv_icon_1 = ccui.Helper:seekWidgetByName(self.roots[1],"Panel_role_up_lv_icon_1")
                if Panel_role_up_lv_icon_1 ~= nil then
                    Panel_role_up_lv_icon_1:removeAllChildren(true)
                    local cellUp = PropIconNewCell:createCell()
                    cellUp:init(cellUp.enum_type._SHOW_PROP_GETWAY_INFORMATION, prop)
                    Panel_role_up_lv_icon_1:addChild(cellUp)
                end
                return
            end
        end
    end
end

function SmRoleStrengthenTabRisingStar:init(params)
    local rootWindow = params[1]
    self._rootWindows = rootWindow    
    self.ship_id = params[2]
    self:onInit()
    return self
end

function SmRoleStrengthenTabRisingStar:onInit()
    local csbSmRoleStrengthenTabRisingStar = csb.createNode("packs/HeroStorage/sm_role_strengthen_tab_cell_3.csb")
    local root = csbSmRoleStrengthenTabRisingStar:getChildByName("root")
    table.insert(self.roots, root)
    self:addChild(csbSmRoleStrengthenTabRisingStar)

    local Panel_dh = ccui.Helper:seekWidgetByName(self.roots[1],"Panel_dh")
    Panel_dh:removeAllChildren(true)
    local jsonFile = "sprite/spirte_shengxing.json"
    local atlasFile = "sprite/spirte_shengxing.atlas"
    local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
    -- animation:setPosition(cc.p(Panel_dh:getContentSize().width/2,Panel_dh:getContentSize().height/2))
    Panel_dh:addChild(animation)


    --升星请求
    if tonumber(_ED.user_ship[self.ship_id].StarRating) >= 7 then
        ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"):setBright(false)
        ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"):setTouchEnabled(false)
    else
        ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"):setBright(true)
        ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"):setTouchEnabled(true)
    end
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_star"), nil, 
    {
        terminal_name = "sm_role_strengthen_tab_rising_star_request", 
        terminal_state = 0,
        isPressedActionEnabled = true
    }, 
    nil, 0)
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_hero_strength_up_grade_button",
        _widget = ccui.Helper:seekWidgetByName(self.roots[1], "Button_role_up_star"),
        _invoke = nil,
        _interval = 0.5,})
    --万能碎片
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1],"Button_role_up_all"), nil, 
    {
        terminal_name = "sm_role_strengthen_tab_rising_star_all_exchange", 
        terminal_state = 0,
        isPressedActionEnabled = true
    }, 
    nil, 0)
	
    self:onUpdateDraw()
end

function SmRoleStrengthenTabRisingStar:onExit()
    state_machine.remove("sm_role_strengthen_tab_rising_star_display")
    state_machine.remove("sm_role_strengthen_tab_rising_star_hide")
    state_machine.remove("sm_role_strengthen_tab_rising_star_change_ship")
	state_machine.remove("sm_role_strengthen_tab_rising_star_update_draw")
    state_machine.remove("sm_role_strengthen_tab_rising_star_request")
    state_machine.remove("sm_role_strengthen_tab_rising_star_all_exchange")
    state_machine.remove("sm_role_strengthen_tab_rising_stars_update_golds")
end