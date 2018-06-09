-----------------------------
-- 仓库主界面
-----------------------------
SmPropWarehouse = class("SmPropWarehouseClass", Window)

--打开界面
local prop_warehouse_window_open_terminal = {
	_name = "prop_warehouse_window_open",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if fwin:find("SmPropWarehouseClass") == nil then
			fwin:open(SmPropWarehouse:new():init(), fwin._background)		
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

--关闭界面
local prop_warehouse_window_close_terminal = {
	_name = "prop_warehouse_window_close",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
        fwin:close(fwin:find("UserTopInfoAClass"))
        state_machine.excute("menu_back_home_page", 0, "") 
		fwin:close(fwin:find("SmPropWarehouseClass"))
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

state_machine.add(prop_warehouse_window_open_terminal)
state_machine.add(prop_warehouse_window_close_terminal)
state_machine.init()

function SmPropWarehouse:ctor()
	self.super:ctor()
	self.roots = {}

    self._current_page = 0
    self._all = nil
    self._equip = nil
    self._material = nil
    self._debris = nil
    self._consumables= nil
    self.propType = 0

    app.load("client.packs.prop.SmAllWarehouse")
    app.load("client.packs.prop.SmConsumablesWarehouse")
    app.load("client.packs.prop.SmDebrisWarehouse")
    app.load("client.packs.prop.SmEquipWarehouse")
    app.load("client.packs.prop.SmMaterialWarehouse")
    app.load("client.cells.prop.sm_packs_cell")
    app.load("client.packs.prop.SmPropWarehouseBatchUse")
    app.load("client.packs.prop.SmPropWarehouseBatchSell")
    app.load("client.packs.prop.SmPropWarehouseSellTip")
    app.load("client.packs.prop.SmPropWarehouseSellAll")


    local function init_prop_warehouse_terminal()
        local prop_warehouse_change_page_terminal = {
            _name = "prop_warehouse_change_page",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	instance:changeSelectPage(params._datas._page)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local prop_warehouse_update_data_info_terminal = {
            _name = "prop_warehouse_update_data_info",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
                    instance.prop = params[1]
                    instance.propType = params[2]
                    instance:drawPageDataUpdate(instance.prop , instance.propType)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --显示信息界面
        local prop_warehouse_show_data_interface_terminal = {
            _name = "prop_warehouse_show_data_interface",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_28"):setVisible(true)
                ccui.Helper:seekWidgetByName(instance.roots[1], "Text_packs_props_info_0"):setVisible(false)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --隐藏信息界面
        local prop_warehouse_hide_data_interface_terminal = {
            _name = "prop_warehouse_hide_data_interface",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_28"):setVisible(false)
                ccui.Helper:seekWidgetByName(instance.roots[1], "Text_packs_props_info_0"):setVisible(true)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --出售道具
        local prop_warehouse_sell_prop_terminal = {
            _name = "prop_warehouse_sell_prop",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:propSellUpdate()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --使用道具
        local prop_warehouse_use_prop_terminal = {
            _name = "prop_warehouse_use_prop",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:propUseOrJump()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --使用道具
        local prop_warehouse_use_prop_update_terminal = {
            _name = "prop_warehouse_use_prop_update",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:propUseRequest(tonumber(params))
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --出售道具
        local prop_warehouse_sell_prop_update_terminal = {
            _name = "prop_warehouse_sell_prop_update",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:propSellRequest(tonumber(params))
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --刷新界面
        local prop_warehouse_update_draw_page_terminal = {
            _name = "prop_warehouse_update_draw_page",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance._current_page == 1 then
                    state_machine.excute("sm_all_warehouse_update_draw",0,"")
                elseif instance._current_page == 2 then
                    state_machine.excute("sm_equip_warehouse_update_draw",0,"")
                elseif instance._current_page == 3 then
                    state_machine.excute("sm_material_warehouse_update_draw",0,"")
                elseif instance._current_page == 4 then
                    state_machine.excute("sm_debris_warehouse_update_draw",0,"")
                elseif instance._current_page == 5 then
                    state_machine.excute("sm_consumables_warehouse_update_draw",0,"")
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

		
        state_machine.add(prop_warehouse_change_page_terminal)
        state_machine.add(prop_warehouse_update_data_info_terminal)
        state_machine.add(prop_warehouse_show_data_interface_terminal)
        state_machine.add(prop_warehouse_hide_data_interface_terminal)
        state_machine.add(prop_warehouse_sell_prop_terminal)
        state_machine.add(prop_warehouse_use_prop_terminal)
        state_machine.add(prop_warehouse_use_prop_update_terminal)
        state_machine.add(prop_warehouse_sell_prop_update_terminal)
        state_machine.add(prop_warehouse_update_draw_page_terminal)
        state_machine.init()
    end
    init_prop_warehouse_terminal()
end

function SmPropWarehouse:propSellUpdate()
    local propMouldId = self.prop.user_prop_template
    if tonumber(self.prop.prop_number) > 1 then
        state_machine.excute("prop_warehouse_batch_sell_open",0,self.prop)
    else
        -- self:propSellRequest(1)
        state_machine.excute("prop_warehouse_sell_tip_open",0,self.prop)
    end
end

function SmPropWarehouse:propSellRequest(number)
    local function responseSellMagicCardCallback(response)
        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then  --网络连接判断
            if response.node == nil or response.node.roots == nil then 
                return
            end
            if fwin:find("SmPropWarehouseBatchSellClass")~= nil then
                state_machine.excute("prop_warehouse_batch_sell_close",0,"")
            end
            if fwin:find("SmPropWarehouseSellTipClass")~= nil then
                state_machine.excute("prop_warehouse_sell_tip_close",0,"")
            end
            TipDlg.drawTextDailog(_new_interface_text[11])
            if self._current_page == 1 then
                state_machine.excute("sm_all_warehouse_update_draw",0,"")
            elseif self._current_page == 2 then
                state_machine.excute("sm_equip_warehouse_update_draw",0,"")
            elseif self._current_page == 3 then
                state_machine.excute("sm_material_warehouse_update_draw",0,"")
            elseif self._current_page == 4 then
                state_machine.excute("sm_debris_warehouse_update_draw",0,"")
            elseif self._current_page == 5 then
                state_machine.excute("sm_consumables_warehouse_update_draw",0,"")
            end
        end
    end
    protocol_command.prop_sell.param_list = self.prop.user_prop_id.."\r\n" .. number
    NetworkManager:register(protocol_command.prop_sell.code, nil, nil, nil, self, responseSellMagicCardCallback, false, nil)
end

function SmPropWarehouse:propUseOrJump()
    local propMouldId = 1
    local use_type = 0
    if tonumber(self.propType) == 7 then
        propMouldId = tonumber(self.prop.user_equiment_template)
        local equipment_type = dms.int(dms["equipment_mould"], propMouldId, equipment_mould.equipment_type)
        local equipIndex = 1
        if equipment_type == 4 then
            equipIndex = 5
        elseif equipment_type == 5 then
            equipIndex = 6
        end
        if tonumber(equipIndex) > 4 then
            if funOpenDrawTip(159) == true then
                return
            end
        else
            if funOpenDrawTip(96) == true then
                return
            end
        end
        self:openEquipDevelop(equipIndex)
        return
    else
        propMouldId = self.prop.user_prop_template
        use_type = dms.int(dms["prop_mould"], propMouldId, prop_mould.use_type)
    end
    if use_type == 3 
        or use_type == 4 
        or use_type == 5 
        or use_type == 7 
        or use_type == 9 
        or use_type == 11 
        or use_type == 12 
        or use_type == 14 
        or use_type == 15
        or use_type == 16
        then
        --跳转
        if use_type == 3 then
            --跳升星
            if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                if funOpenDrawTip(102) == true then
                    return
                end
                local shipMouldId = dms.int(dms["prop_mould"], propMouldId, prop_mould.use_of_ship)
                if shipMouldId == 0 or fundShipWidthTemplateId(shipMouldId) == nil then
                    state_machine.excute("home_click_generals",0,"home_click_generals.")
                else
                    self:openHeroDevelop()
                    -- state_machine.excute("hero_develop_page_open_train_page",0,"")
                    state_machine.excute("hero_develop_page_manager",0,{_datas = {
                        next_terminal_name = "hero_develop_page_open_train_page",           
                        current_button_name = "Button_peiyang",     
                        but_image = "",     
                        shipId = self.shipId,
                        terminal_state = 0, 
                        openWinId = 3,
                        isPressedActionEnabled = tempIsPressedActionEnabled
                    }})
                end
            else
                self:openHeroDevelop()
                -- state_machine.excute("hero_develop_page_open_train_page",0,"")
                state_machine.excute("hero_develop_page_manager",0,{_datas = {
                    next_terminal_name = "hero_develop_page_open_train_page",           
                    current_button_name = "Button_peiyang",     
                    but_image = "",     
                    shipId = self.shipId,
                    terminal_state = 0, 
                    openWinId = 3,
                    isPressedActionEnabled = tempIsPressedActionEnabled
                }})
            end
        elseif use_type == 4 then
            if funOpenDrawTip(101) == true then
                return
            end
            --跳升级
            self:openHeroDevelop()
            -- state_machine.excute("hero_develop_page_open_advanced",0,"")
            state_machine.excute("hero_develop_page_manager",0,{_datas = {
                next_terminal_name = "hero_develop_page_open_advanced",             
                current_button_name = "Button_tupo",    
                but_image = "",     
                shipId = self.shipId,
                terminal_state = 0, 
                openWinId = 34,
                isPressedActionEnabled = tempIsPressedActionEnabled
            }})
        elseif use_type == 5 then
            --跳升品
            self:openHeroDevelop()
            -- state_machine.excute("hero_develop_page_open_strengthen_page",0,"")
            state_machine.excute("hero_develop_page_manager",0,{_datas = {
                next_terminal_name = "hero_develop_page_open_strengthen_page",          
                current_button_name = "Button_shengji",     
                but_image = "",     
                shipId = self.shipId,
                terminal_state = 0, 
                openWinId = 33,
                isPressedActionEnabled = tempIsPressedActionEnabled
            }})
        elseif use_type == 7 then
            --跳装备强化
            if funOpenDrawTip(96) == true then
                return
            end
            self:openEquipDevelop()
        elseif use_type == 9 then    
            --跳转招募
            state_machine.excute("menu_show_shop", 0, {_datas = {shop_type = "zhaomu"}})
        elseif use_type == 11 then
            --跳转装备宝箱
            state_machine.excute("menu_show_shop", 0, {_datas = {shop_type = "shop"}})
        elseif use_type == 12 then
            --跳转数码精神
            app.load("client.l_digital.cultivate.SmCultivateSpiritWindow")
            state_machine.excute("sm_cultivate_spirit_window_open", 0, "")
        elseif use_type == 14 then
            app.load("client.l_digital.campaign.arena.Arena")
            state_machine.excute("arena_window_open", 0, "")
        elseif use_type == 15 then
            if funOpenDrawTip(104) == true then
                return
            end
            self:openHeroDevelop()
            -- state_machine.excute("hero_develop_page_open_train_page",0,"")
            state_machine.excute("hero_develop_page_manager",0,{_datas = {
                next_terminal_name = "hero_develop_page_open_fighting_spirit",           
                current_button_name = "Button_douhun",     
                but_image = "",     
                shipId = self.shipId,
                terminal_state = 0, 
                openWinId = 104,
                isPressedActionEnabled = tempIsPressedActionEnabled
            }})
        elseif use_type == 16 then
            --跳转神器
            app.load("client.l_digital.cultivate.artifact.SmCultivateArtifactWindow")
            state_machine.excute("sm_cultivate_artifact_window_open", 0, "")
        end
    elseif use_type == 0 then
        --使用
        local props_type = dms.int(dms["prop_mould"], propMouldId, prop_mould.props_type)
        if props_type == 7 then
            app.load("client.packs.prop.SmPropChoose")
            state_machine.excute("sm_prop_choose_window_open",0,self.prop)
        elseif tonumber(self.prop.prop_number) > 1 then
            --批量使用的界面
            if dms.int(dms["prop_mould"], self.prop.user_prop_template, prop_mould.is_batch_use) == -1 then
                self:propUseRequest(1)
            elseif dms.int(dms["prop_mould"], self.prop.user_prop_template, prop_mould.is_batch_use) == 1 then
                state_machine.excute("prop_warehouse_batch_use_open",0,self.prop)
            end
        else
            --直接使用
            self:propUseRequest(1)
        end
    end

end

function SmPropWarehouse:propUseRequest(number, chooseCount)
    local function responseUsePropCallback(response)
        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then  --网络连接判断
            if response.node == nil or response.node.roots == nil then 
                return
            end
            if fwin:find("SmPropWarehouseBatchUseClass")~= nil then
                state_machine.excute("prop_warehouse_batch_use_close",0,"")
            end
            --使用之后
            local rewardList = getSceneReward(4)--获取奖励物品实例
            app.load("client.reward.DrawRareReward")
            local getRewardWnd = DrawRareReward:new()
            getRewardWnd:init(nil, rewardList)
            fwin:open(getRewardWnd,fwin._ui)
            if self._current_page == 1 then
                state_machine.excute("sm_all_warehouse_update_draw",0,"")
            elseif self._current_page == 2 then
                state_machine.excute("sm_equip_warehouse_update_draw",0,"")
            elseif self._current_page == 3 then
                state_machine.excute("sm_material_warehouse_update_draw",0,"")
            elseif self._current_page == 4 then
                state_machine.excute("sm_debris_warehouse_update_draw",0,"")
            elseif self._current_page == 5 then
                state_machine.excute("sm_consumables_warehouse_update_draw",0,"")
            end
        end
    end
    protocol_command.prop_use.param_list = self.prop.user_prop_id.."\r\n" .. number.."\r\n"..zstring.tonumber(chooseCount)
    NetworkManager:register(protocol_command.prop_use.code, nil, nil, nil, self, responseUsePropCallback,false, nil)
end

function SmPropWarehouse:openEquipDevelop( m_index )
    local index = 0
    for i=1, #_ED.user_formetion_status do
        if tonumber(_ED.user_formetion_status[i]) > 0 then
            index = i
            break
        end
    end
    local ship = _ED.user_ship[_ED.user_formetion_status[index]]
    if fwin:find("HeroIconListViewClass") ~= nil then
        app.load("client.packs.hero.HeroIconListView")
        state_machine.excute("hero_icon_listview_open",0,ship)
        fwin:find("HeroIconListViewClass"):setVisible(false)
    end
    local _index = 1
    if m_index ~= nil then
        _index = m_index
    end

    --武将装备数据(等级|品质|经验|星级|模板)
    local shipEquip = zstring.split(ship.equipInfo, "|")
    local equipData = zstring.split(shipEquip[5], ",")
    local equipStar = zstring.split(shipEquip[4], ",")
    local equipMouldId = equipData[_index]
    local equip = {}
    --装备模板id
    --初始装备
    local equipAll = dms.string(dms["ship_mould"], ship.ship_template_id, ship_mould.treasureSkill)
    if tonumber(equipStar[_index]) == 0 then
        local equipMouldData = zstring.split(equipAll, ",")
        equip.user_equiment_template = equipMouldData[1]
    else
        equip.user_equiment_template = equipMouldId
    end
    --装备等级
    local equipLevelData = zstring.split(shipEquip[1], ",")
    equip.user_equiment_grade = equipLevelData[_index]
    --所属战船
    equip.ship_id = ship.ship_id
    equip.m_index = _index

    app.load("client.packs.equipment.SmEquipmentQianghua")
    state_machine.excute("sm_equipment_qianghua_open",0,equip)
end

function SmPropWarehouse:openHeroDevelop()
    local index = 0
    for i=1, #_ED.user_formetion_status do
        if tonumber(_ED.user_formetion_status[i]) > 0 then
            index = i
            break
        end
    end
    local ship = _ED.user_ship[_ED.user_formetion_status[index]]
    enter_type = "learn"
    if fwin:find("HeroIconListViewClass") ~= nil then
        app.load("client.packs.hero.HeroIconListView")
        state_machine.excute("hero_icon_listview_open",0,ship)
        fwin:find("HeroIconListViewClass"):setVisible(false)
    end
    app.load("client.packs.hero.HeroDevelop")
    if fwin:find("HeroDevelopClass") ~= nil then
        for i, v in pairs(_ED.user_formetion_status) do
            if tonumber(v) == tonumber(ship.ship_id) then
                 state_machine.excute("formation_set_ship",0,ship)
                break
            end
        end
        return
        -- fwin:close(fwin:find("HeroDevelopClass"))
    end
    local heroDevelopWindow = HeroDevelop:new()
    if __lua_project_id == __lua_project_gragon_tiger_gate 
        or __lua_project_id == __lua_project_l_digital
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
        ship.shengming = zstring.tonumber(ship.ship_health)
        ship.gongji = zstring.tonumber(ship.ship_courage)
        ship.waigong = zstring.tonumber(ship.ship_intellect)
        ship.neigong = zstring.tonumber(ship.ship_quick)
    end
    -- print("=======11=====",enter_type)
    if enter_type ~= "learn" and enter_type ~= "pack" then
        enter_type = "formation"
    end
    for i,v in pairs(_ED.user_formetion_status) do
        if zstring.tonumber(v) == tonumber(ship.ship_id) then
            enter_type = "formation"
        end
    end
    heroDevelopWindow:init(ship.ship_id, enter_type)
    fwin:open(heroDevelopWindow, fwin._viewdialog)
end

function SmPropWarehouse:drawPageDataUpdate(prop , _type)
    local root = self.roots[1]
    --图标
    _type = tonumber(_type)
    local Panel_packs_props_icon = ccui.Helper:seekWidgetByName(root, "Panel_packs_props_icon")
    Panel_packs_props_icon:removeAllChildren(true)
    local cell = state_machine.excute("sm_packs_cell",0,{prop,1,nil,_type})
    Panel_packs_props_icon:addChild(cell)
    --名称
    local propMouldId = 1
    if _type == 7 then
        propMouldId = tonumber(prop.user_equiment_template)
    else
        propMouldId = tonumber(prop.user_prop_template)
    end
    local Text_packs_props_name = ccui.Helper:seekWidgetByName(root, "Text_packs_props_name")
    local Text_packs_have_n = ccui.Helper:seekWidgetByName(root, "Text_packs_have_n")
    local Text_packs_props_info =  ccui.Helper:seekWidgetByName(root, "Text_packs_props_info")
    local name = ""
    local quality = 0
    local propNumber = 0
    local description = ""
    if _type == 7 then
        name = smEquipWordlFundByIndex(propMouldId,1)
        quality = dms.int(dms["equipment_mould"], propMouldId, equipment_mould.trace_npc_index)+1
        for i , v in pairs(_ED.user_equiment) do
            if tonumber(v.user_equiment_template) == propMouldId then
                propNumber = propNumber + 1
            end
        end
        description = smEquipWordlFundByIndex(propMouldId,2)
    else 
        name = setThePropsIcon(prop.user_prop_template)[2]
        quality = dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_quality)+1
        propNumber = prop.prop_number
        description = dms.string(dms["prop_mould"], prop.user_prop_template, prop_mould.remarks)
        if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
            description = drawPropsDescription(prop.user_prop_template)
        end
    end
    Text_packs_props_name:setString(name)
    Text_packs_props_name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))
    --数量
    Text_packs_have_n:setString(propNumber)
    --描述
    -- Text_packs_props_info:setString(description)
    Text_packs_props_info:removeAllChildren(true)
    local _richText2 = ccui.RichText:create()
    _richText2:ignoreContentAdaptWithSize(false)

    local richTextWidth = Text_packs_props_info:getContentSize().width
    if richTextWidth == 0 then
        richTextWidth = Text_packs_props_info:getFontSize() * 6
    end
                
    _richText2:setContentSize(cc.size(richTextWidth, 0))
    _richText2:setAnchorPoint(cc.p(0, 0))

    local rt, count, text = draw.richTextCollectionMethod(_richText2, 
    description, 
    cc.c3b(255, 255, 255),
    cc.c3b(255, 255, 255),
    0, 
    0, 
    Text_packs_props_info:getFontName(), 
    Text_packs_props_info:getFontSize(),
    chat_rich_text_color)

    _richText2:formatTextExt()
    local rsize = _richText2:getContentSize()
    _richText2:setPositionY(Text_packs_props_info:getContentSize().height)
    _richText2:setPositionX(0)
    Text_packs_props_info:addChild(_richText2)


    --出售价格
    if _type == 7 then

    else
        if dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.silver_price) == 0 then
            ccui.Helper:seekWidgetByName(root,"Button_sell"):setBright(false)
            ccui.Helper:seekWidgetByName(root,"Button_sell"):setTouchEnabled(false)
            ccui.Helper:seekWidgetByName(root,"Panel_sell_price"):setVisible(false)
        else
            ccui.Helper:seekWidgetByName(root,"Button_sell"):setBright(true)
            ccui.Helper:seekWidgetByName(root,"Button_sell"):setTouchEnabled(true)
            ccui.Helper:seekWidgetByName(root,"Panel_sell_price"):setVisible(true)
        end
        local price = dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.silver_price)
        ccui.Helper:seekWidgetByName(root,"Text_packs_sell_price_n"):setString(price)

        --能否使用
        local use_type = dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.use_type)
        if use_type == 0 
            or use_type == 3 
            or use_type == 4 
            or use_type == 5 
            or use_type == 7 
            or use_type == 9 
            or use_type == 11 
            or use_type == 12 
            or use_type == 14 
            or use_type == 15 
            then
            ccui.Helper:seekWidgetByName(root,"Button_use"):setBright(true)
            ccui.Helper:seekWidgetByName(root,"Button_use"):setTouchEnabled(true)
            ccui.Helper:seekWidgetByName(root,"Button_open"):setBright(true)
            ccui.Helper:seekWidgetByName(root,"Button_open"):setTouchEnabled(true)
        elseif use_type == 16 then
            if not funOpenDrawTip(123, false) then
                ccui.Helper:seekWidgetByName(root,"Button_use"):setBright(true)
                ccui.Helper:seekWidgetByName(root,"Button_use"):setTouchEnabled(true)
                ccui.Helper:seekWidgetByName(root,"Button_open"):setBright(true)
                ccui.Helper:seekWidgetByName(root,"Button_open"):setTouchEnabled(true)
            else
                ccui.Helper:seekWidgetByName(root,"Button_use"):setBright(false)
                ccui.Helper:seekWidgetByName(root,"Button_use"):setTouchEnabled(false)
                ccui.Helper:seekWidgetByName(root,"Button_open"):setBright(false)
                ccui.Helper:seekWidgetByName(root,"Button_open"):setTouchEnabled(false)
            end
        else
            ccui.Helper:seekWidgetByName(root,"Button_use"):setBright(false)
            ccui.Helper:seekWidgetByName(root,"Button_use"):setTouchEnabled(false)
            ccui.Helper:seekWidgetByName(root,"Button_open"):setBright(false)
            ccui.Helper:seekWidgetByName(root,"Button_open"):setTouchEnabled(false)
        end

        --是否宝箱
        local props_type = dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.props_type)
        if props_type == 3 
            or props_type == 4 
            or props_type == 7 
            or props_type == 17 
            then
            ccui.Helper:seekWidgetByName(root,"Button_use"):setVisible(false)
            ccui.Helper:seekWidgetByName(root,"Button_open"):setVisible(true)
        else
            ccui.Helper:seekWidgetByName(root,"Button_use"):setVisible(true)
            ccui.Helper:seekWidgetByName(root,"Button_open"):setVisible(false)
        end

        if use_type == 12 then
            if true == funOpenDrawTip(122,false) then
                ccui.Helper:seekWidgetByName(root,"Button_use"):setBright(false)
                ccui.Helper:seekWidgetByName(root,"Button_use"):setTouchEnabled(false)
                ccui.Helper:seekWidgetByName(root,"Button_open"):setBright(false)
                ccui.Helper:seekWidgetByName(root,"Button_open"):setTouchEnabled(false)
            end
        end
    end
end

function SmPropWarehouse:changeSelectPage( page )
    local root = self.roots[1]

    local Panel_packs_props = ccui.Helper:seekWidgetByName(root, "Panel_packs_props")
    local Button_daoju_0 = ccui.Helper:seekWidgetByName(root, "Button_daoju_0")
    local Button_zhuangbei = ccui.Helper:seekWidgetByName(root, "Button_zhuangbei")
    local Button_xinfa = ccui.Helper:seekWidgetByName(root, "Button_xinfa")
    local Button_zhuangbeisuipin = ccui.Helper:seekWidgetByName(root, "Button_zhuangbeisuipin")
    local Button_daoju = ccui.Helper:seekWidgetByName(root, "Button_daoju")
    if page == self._current_page then
        if page == 1 then
            Button_daoju_0:setHighlighted(true)
        elseif page == 2 then
            Button_zhuangbei:setHighlighted(true)
        elseif page == 3 then
            Button_xinfa:setHighlighted(true)
        elseif page == 4 then
            Button_zhuangbeisuipin:setHighlighted(true)
        elseif page == 5 then    
            Button_daoju:setHighlighted(true)
        end
        return
    end
    self._current_page = page
    Button_daoju_0:setHighlighted(false)
    Button_zhuangbei:setHighlighted(false)
    Button_xinfa:setHighlighted(false)
    Button_zhuangbeisuipin:setHighlighted(false)
    Button_daoju:setHighlighted(false)
    state_machine.excute("sm_all_warehouse_hide", 0, nil)
    state_machine.excute("sm_equip_warehouse_hide", 0, nil)
    state_machine.excute("sm_material_warehouse_hide", 0, nil)
    state_machine.excute("sm_debris_warehouse_hide", 0, nil)
    state_machine.excute("sm_consumables_warehouse_hide", 0, nil)
    
    if page == 1 then
        Button_daoju_0:setHighlighted(true)
        if self._all == nil then
            self._all = state_machine.excute("sm_all_warehouse_window_open", 0, {Panel_packs_props})
        else
            state_machine.excute("sm_all_warehouse_show", 0, nil)
        end
	elseif page == 2 then
		Button_zhuangbei:setHighlighted(true)
		if self._equip == nil then
            self._equip = state_machine.excute("sm_equip_warehouse_window_open", 0, {Panel_packs_props})
        else
            state_machine.excute("sm_equip_warehouse_show", 0, nil)
        end
	elseif page == 3 then
		Button_xinfa:setHighlighted(true)
		if self._material == nil then
            self._material = state_machine.excute("sm_material_warehouse_window_open", 0, {Panel_packs_props})
        else
            state_machine.excute("sm_material_warehouse_show", 0, nil)
        end
    elseif page == 4 then
		Button_zhuangbeisuipin:setHighlighted(true)
        if self._debris == nil then
            self._debris = state_machine.excute("sm_debris_warehouse_window_open", 0, {Panel_packs_props})
        else
            state_machine.excute("sm_debris_warehouse_show", 0, nil)
        end
    else
        Button_daoju:setHighlighted(true)
        if self._consumables == nil then
            self._consumables = state_machine.excute("sm_consumables_warehouse_window_open", 0, {Panel_packs_props})
        else
            state_machine.excute("sm_consumables_warehouse_show", 0, nil)
        end   
	end
end

function SmPropWarehouse:init()
    self:setTouchEnabled(true)
	self:onInit()
    return self
end

function SmPropWarehouse:onInit()
    local csbItem = csb.createNode("packs/warehouse_list.csb")
    local root = csbItem:getChildByName("root")
    self:addChild(csbItem)
    table.insert(self.roots, root)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_daoju_back"), nil, 
    {
        terminal_name = "prop_warehouse_window_close", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 3)

    --全部
   	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_daoju_0"), nil, 
    {
        terminal_name = "prop_warehouse_change_page", 
        terminal_state = 0, 
        _page = 1,
    }, nil, 1)
	
    --装备
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_zhuangbei"), nil, 
    {
        terminal_name = "prop_warehouse_change_page", 
        terminal_state = 0, 
        _page = 2,
    }, nil, 1)

    --材料
   	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_xinfa"), nil, 
    {
        terminal_name = "prop_warehouse_change_page", 
        terminal_state = 0, 
        _page = 3,
    }, nil, 1)

    --碎片
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_zhuangbeisuipin"), nil, 
    {
        terminal_name = "prop_warehouse_change_page", 
        terminal_state = 0, 
        _page = 4,
    }, nil, 1)

    --消耗品
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_daoju"), nil, 
    {
        terminal_name = "prop_warehouse_change_page", 
        terminal_state = 0, 
        _page = 5,
    }, nil, 1)

    --出售
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_sell"), nil, 
    {
        terminal_name = "prop_warehouse_sell_prop", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 1)

    --使用
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_use"), nil, 
    {
        terminal_name = "prop_warehouse_use_prop", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 1)

    --打开
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_open"), nil, 
    {
        terminal_name = "prop_warehouse_use_prop", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 1)

    self:changeSelectPage(1)

    local sellPropList = {}
    for i, prop in pairs(_ED.user_prop) do
        if dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.silver_price) > 0 then
            table.insert(sellPropList, prop)
        end
    end
    if #sellPropList > 0 then
        self:runAction(cc.Sequence:create({cc.DelayTime:create(0.1), cc.CallFunc:create(function ( sender )
            state_machine.excute("prop_warehouse_sell_all_open", 0, sellPropList)
        end)}))
    end

    local userinfo = UserTopInfoA:new()
    local info = fwin:open(userinfo,fwin._view)

    local Panel_effec = ccui.Helper:seekWidgetByName(root, "Panel_effec")
    if Panel_effec ~= nil then
        Panel_effec:removeAllChildren(true)
        local jsonFile = "images/ui/effice/effect_chixu/effect_chixu.json"
        local atlasFile = "images/ui/effice/effect_chixu/effect_chixu.atlas"
        local animation2 = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
        animation2:setPosition(cc.p(Panel_effec:getContentSize().width/2,0))
        Panel_effec:addChild(animation2)
    end
end

function SmPropWarehouse:onEnterTransitionFinish()
    
end

function SmPropWarehouse:close( ... )
    local Panel_effec = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_effec")
    if Panel_effec ~= nil then
        Panel_effec:removeAllChildren(true)
    end
end

function SmPropWarehouse:onExit()
    state_machine.remove("prop_warehouse_change_page")
    state_machine.remove("prop_warehouse_update_data_info")
    state_machine.remove("prop_warehouse_show_data_interface")
    state_machine.remove("prop_warehouse_hide_data_interface")
    state_machine.remove("prop_warehouse_sell_prop")
    state_machine.remove("prop_warehouse_use_prop")
    state_machine.remove("prop_warehouse_use_prop_update")
    state_machine.remove("prop_warehouse_sell_prop_update")
    state_machine.remove("prop_warehouse_update_draw_page")
end

