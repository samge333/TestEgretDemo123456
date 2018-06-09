-- ------------------------------------------------------------------------------------------------------------
SmRoleFashion = class("SmRoleFashionClass", Window)

local sm_role_fashion_window_open_terminal = {
    _name = "sm_role_fashion_window_open",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        if funOpenDrawTip(176) == true then
            return
        end
        if fwin:find("SmRoleFashionClass") == nil then
            fwin:open(SmRoleFashion:new():init(params), fwin._ui)
        end
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local sm_role_fashion_window_close_terminal = {
    _name = "sm_role_fashion_window_close",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        fwin:close(fwin:find("SmRoleFashionClass"))
        return true
    end,
    _terminal = nil,
    _terminals = nil
}
state_machine.add(sm_role_fashion_window_open_terminal)
state_machine.add(sm_role_fashion_window_close_terminal)
state_machine.init()

function SmRoleFashion:ctor()
    self.super:ctor()
    self.roots = {}
    self.actions = {}

    self._choose_ship = nil
    self._choose_fashion_cell = nil

    app.load("client.packs.hero.SmRoleFashionCard")
    app.load("client.cells.ship.hero_icon_list_cell")

    local function init_sm_role_fashion_terminal()
        local sm_role_fashion_update_terminal = {
            _name = "sm_role_fashion_update",
            _init = function (terminal) 
            
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
                    instance._choose_ship = params
                    instance:onUpdateDraw()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_role_fashion_choose_ship_terminal = {
            _name = "sm_role_fashion_choose_ship",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:setIndex(params)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_role_fashion_choose_fashion_terminal = {
            _name = "sm_role_fashion_choose_fashion",
            _init = function (terminal) 
            
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
                    local cell = params
                    instance:skinIconChange(cell)
                    instance:updateFashionInfo(cell.ship_evo_id, cell.ship_skin_id, cell.is_unlock)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_role_fashion_use_terminal = {
            _name = "sm_role_fashion_use",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local _choose_ship = params._datas._choose_ship
                local _price = params._datas._price
                local _ship_skin_id = params._datas._ship_skin_id
                local _ship_evo_id = params._datas._ship_evo_id
                if not _price or not _choose_ship.ship_id or not _ship_evo_id or zstring.tonumber(_ship_evo_id) == -1 then
                    return 
                end
                instance.params = params._datas
                _ship_skin_id = _ship_skin_id == 0 and -1 or _ship_skin_id
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            response.node:onUpdateDraw()
                            local ship_id = response.node._choose_ship.ship_id
                            local ListView_list = ccui.Helper:seekWidgetByName(response.node.roots[1], "ListView_role")
                            local cell = nil
                            for i,v in pairs(ListView_list:getItems()) do
                                if tonumber(v.ship_skin_id) == tonumber(response.node.params._ship_skin_id) then
                                    cell = v
                                end
                            end

                            if cell then
                                response.node:skinIconChange(cell)
                                response.node:updateFashionInfo(response.node.params._ship_evo_id, response.node.params._ship_skin_id, true)
                            end
                            response.node:updateIconList()
                            TipDlg.drawTextDailog(tipStringInfo_evolution_status_tips[7])
                            --response.node:updateFashionInfo(response.node.params._ship_evo_id, response.node.params._ship_skin_id, true)
                            if fwin:find("HeroDevelopClass") ~= nil then
                                state_machine.excute("hero_develop_page_strength_to_update_ship", 0, 1)
                                state_machine.excute("hero_develop_page_strength_to_update_all_icon", 0, "")
                                state_machine.excute("home_hero_refresh_draw", 0, "")
                            else
                                for i, v in pairs(_ED.user_formetion_status) do
                                    if tonumber(v) == tonumber(ship_id) then
                                        state_machine.excute("hero_icon_listview_update_all_icon", 0, 1)
                                        state_machine.excute("formation_set_ship", 0, 1)
                                        break
                                    end
                                end
                            end
                            -- state_machine.excute("sm_role_strengthen_tab_up_stop_update", 0, "")
                            -- state_machine.excute("sm_role_strengthen_tab_up_grade_update_draw", 0, nil)
                            -- setShipPushData(ship_id, -1, -1)
                            -- state_machine.excute("sm_auto_upgrade_window_close", 0, nil)
                        end
                    end
                end

                protocol_command.ship_skin_use.param_list = _choose_ship.ship_id.."\r\n".._ship_skin_id
                NetworkManager:register(protocol_command.ship_skin_use.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_role_fashion_buy_terminal = {
            _name = "sm_role_fashion_buy",
            _init = function (terminal) 
                app.load("client.utils.BuyConfirmTip")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                   local _choose_ship = params._datas._choose_ship
                   local _price = params._datas._price
                   local _ship_skin_id = params._datas._ship_skin_id
                   local _ship_evo_id = params._datas._ship_evo_id
                   if not _price or not _choose_ship or not _ship_skin_id or zstring.tonumber(_ship_skin_id) == 0 then
                        return 
                   end
                   local callback = "sm_role_fashion_buy_confirm"
                   state_machine.excute("buy_confirm_tip_open", 0, {1, _price, tipStringInfo_evolution_status_tips[6], callback, params._datas})
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_role_fashion_buy_confirm_terminal = {
            _name = "sm_role_fashion_buy_confirm",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
               local _choose_ship = params._datas._choose_ship
               local _price = params._datas._price
               local _ship_skin_id = params._datas._ship_skin_id
               local _ship_evo_id = params._datas._ship_evo_id
               if not _price or not _choose_ship.ship_id or not _ship_skin_id or zstring.tonumber(_ship_skin_id) == 0 then
                    return 
               end
               instance.params = params._datas
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            TipDlg.drawTextDailog(_string_piece_info[76])
                            local ship_id = response.node._choose_ship.ship_id
                            response.node:updateFashionInfo(response.node.params._ship_evo_id, response.node.params._ship_skin_id, true)
                            smFightingChange()
                            if fwin:find("HeroStorageClass") ~= nil then
                                state_machine.excute("hero_develop_page_strength_to_update_ship", 0, 1)
                            else
                                for i, v in pairs(_ED.user_formetion_status) do
                                    if tonumber(v) == tonumber(ship_id) then
                                        state_machine.excute("formation_set_ship", 0, 1)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
                protocol_command.ship_skin_buy.param_list = _choose_ship.ship_id.."\r\n".._ship_skin_id
                NetworkManager:register(protocol_command.ship_skin_buy.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_role_fashion_go_to_terminal = {
            _name = "sm_role_fashion_go_to",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                TipDlg.drawTextDailog("该皮肤尚无购买途径，请关注相关活动")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_role_fashion_update_terminal)
        state_machine.add(sm_role_fashion_choose_ship_terminal)
        state_machine.add(sm_role_fashion_choose_fashion_terminal)
        state_machine.add(sm_role_fashion_use_terminal)
        state_machine.add(sm_role_fashion_buy_terminal)
        state_machine.add(sm_role_fashion_go_to_terminal)
        state_machine.add(sm_role_fashion_buy_confirm_terminal)
        state_machine.init()
    end
    init_sm_role_fashion_terminal()
end

function SmRoleFashion:firstIconIndex(ship)
    local root = self.roots[1]
    local ListView_list = ccui.Helper:seekWidgetByName(root, "ListView_list")
    local index = 1
    local height = 0
    for i,v in pairs(ListView_list:getItems()) do
        if v.ship.ship_id == ship.ship_id then
            v:setSelected(true)
            v.ishow = true
            self.lastcell = v
            v:onUpdateDraw()
            index = i
            height = v:getContentSize().height
            break
        end
    end
    listviewPositioningMoves(ListView_list, index, 0)
end

function SmRoleFashion:setIndex(cell)
    if self.lastcell ~= nil then
        self.lastcell.ishow = false
        if self.lastcell.setSelected ~= nil then
            self.lastcell:setSelected(false)
        end
    end
    cell:setSelected(true)
    cell.ishow = true
    self.lastcell = cell
end

function SmRoleFashion:skinIconChange(cell)
    local root = self.roots[1]
    local ListView_list = ccui.Helper:seekWidgetByName(root, "ListView_role")
    for i,v in pairs(ListView_list:getItems()) do
        if v and v._index == cell._index then
            v._isChoose = true
            v:updateChooseState(v._isChoose)
        else
            v._isChoose = false
            v:updateChooseState(v._isChoose)
        end
    end
end

function SmRoleFashion:updateFashionInfo( ship_evo_id , ship_skin_id, is_unlock)
    local root = self.roots[1]
    local Panel_props = ccui.Helper:seekWidgetByName(root, "Panel_props")
    local Panel_props_box = ccui.Helper:seekWidgetByName(root, "Panel_props_box")
    local Panel_props_quality = ccui.Helper:seekWidgetByName(root, "Panel_props_quality")
    
    local Text_tips = ccui.Helper:seekWidgetByName(root, "Text_tips")

    local Panel_time = ccui.Helper:seekWidgetByName(root, "Panel_time")
    local Text_time = ccui.Helper:seekWidgetByName(root, "Text_time")
    local Text_time_0 = ccui.Helper:seekWidgetByName(root, "Text_time_0")
    local Image_use = ccui.Helper:seekWidgetByName(root, "Image_use")
    local Text_time_1 = ccui.Helper:seekWidgetByName(root, "Text_time_1")

    local Text_buy = ccui.Helper:seekWidgetByName(root, "Text_buy")
    local Image_2_0 = ccui.Helper:seekWidgetByName(root, "Image_2_0")
    local Button_buy = ccui.Helper:seekWidgetByName(root, "Button_buy")
    local Button_use = ccui.Helper:seekWidgetByName(root, "Button_use")
    local Button_obtain = ccui.Helper:seekWidgetByName(root, "Button_obtain")
    Panel_props:removeAllChildren(true)
    Panel_props_box:removeAllChildren(true)
    Panel_props_quality:removeAllChildren(true)
    Panel_props:removeBackGroundImage()
    Panel_props_box:removeBackGroundImage()
    Panel_props_quality:removeBackGroundImage()
    Text_tips:setString("")

    Panel_time:setVisible(true)
    Text_buy:setVisible(false)
    Image_2_0:setVisible(false)
    Button_buy:setVisible(false)
    Button_use:setVisible(false)
    Button_obtain:setVisible(false)
    Image_use:setVisible(false)


    local price = 0
    -- 更新文字信息
    if ship_evo_id ~= -1 then
        local picIndex = dms.int(dms["ship_evo_mould"], ship_evo_id, ship_evo_mould.form_id)
        local quality = tonumber(self._choose_ship.Order)
        Panel_props:setBackGroundImage(string.format("images/ui/props/props_%d.png", picIndex))

        if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then
            Panel_props_box:setBackGroundImage(string.format("images/ui/quality/icon_ditu_%d.png", quality))
        else
            if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                Panel_props_box:setBackGroundImage(string.format("images/ui/quality/quality_frame_%d.png", quality+1))
                Panel_props_quality:setBackGroundImage(string.format("images/ui/quality/icon_enemy_%d.png", shipOrEquipSetColour(quality)))
            else
                Panel_props_box:setBackGroundImage(string.format("images/ui/quality/icon_bigkuang_%d.png", quality))
            end
        end

        local des_index = dms.int(dms["ship_evo_mould"], ship_evo_id, ship_evo_mould.describe_index)
        local des = dms.element(dms["word_mould"], des_index)[3]
        Text_tips:setString(des)

        -- 不是默认形象
        if ship_skin_id ~= 0 then
            local is_have = false
            local limit_time_index  = dms.int(dms["ship_skin_mould"], ship_skin_id, ship_skin_mould.duration)
            if self._choose_ship.ship_skin_info and self._choose_ship.ship_skin_info ~= "" then
                local skin_info = zstring.split(self._choose_ship.ship_skin_info, "|")
                for i,v in ipairs(zstring.split(skin_info[2], ",")) do
                    local have_id = zstring.split(v, ":")[1]
                    if zstring.tonumber(have_id) == zstring.tonumber(ship_skin_id) then
                        is_have = true
                        limit_time_index = zstring.split(v, ":")[2]
                    end
                end
            end
            price = dms.int(dms["ship_skin_mould"], ship_skin_id, ship_skin_mould.unlock_price)
            
            local des = zstring.tonumber(limit_time_index) == -1 and tipStringInfo_evolution_status_tips[4] or limit_time_index .. tipStringInfo_evolution_status_tips[5]
            Text_buy:setString(price)
            Text_time_0:setString(des)

            Text_time:setVisible(is_unlock and is_have)
            Text_time_0:setVisible(is_unlock and is_have)
            Button_use:setVisible((is_unlock and is_have and self.current_skin_id ~= tonumber(ship_skin_id)))
            Text_time_1:setVisible(not is_unlock and ship_skin_id ~= 0)
            Image_2_0:setVisible(is_unlock and not is_have)
            Text_buy:setVisible(is_unlock and not is_have)
            Button_buy:setVisible(is_unlock and not is_have)
        else
            local limit_time_index = tipStringInfo_evolution_status_tips[4]
            Text_time_0:setString(limit_time_index)
            Text_time:setVisible(true)
            Text_time_0:setVisible(true)
            Button_use:setVisible(self.current_skin_id ~= 0)
            Text_time_1:setVisible(false)
            Text_buy:setVisible(false)
            Button_buy:setVisible(false)
        end
        
        Image_use:setVisible(self.current_skin_id == tonumber(ship_skin_id))
    end
    fwin:addTouchEventListener(Button_buy, nil, 
    {
        terminal_name = "sm_role_fashion_buy",
        terminal_state = 0,
        _choose_ship = self._choose_ship,
        _price = price,
        _ship_skin_id = ship_skin_id,
        _ship_evo_id = ship_evo_id,
        isPressedActionEnabled = true,
    }, nil, 1)

    fwin:addTouchEventListener(Button_use, nil, 
    {
        terminal_name = "sm_role_fashion_use",
        terminal_state = 0,
        _choose_ship = self._choose_ship,
        _price = price,
        _ship_skin_id = ship_skin_id,
        _ship_evo_id = ship_evo_id,
        isPressedActionEnabled = true,
    }, nil, 1)

    fwin:addTouchEventListener(Button_obtain, nil, 
    {
        terminal_name = "sm_role_fashion_go_to",
        terminal_state = 0,
        _self = self,
        isPressedActionEnabled = true,
    }, nil, 1)

end

function SmRoleFashion:onUpdateDraw()
    local root = self.roots[1]
    local ListView_role = ccui.Helper:seekWidgetByName(root, "ListView_role")

    ListView_role:removeAllItems()
    --进化形象
    local evo_image = dms.string(dms["ship_mould"], self._choose_ship.ship_template_id, ship_mould.fitSkillTwo)
    local evo_info = zstring.split(evo_image, ",")
   
    local ship_evo = zstring.split(self._choose_ship.evolution_status, "|")
    --默认形象的进化形态
    local default_evolution_status = tonumber(ship_evo[1])
    --默认形象的进化模板id
    local default_evo_id = evo_info[tonumber(ship_evo[1])]

    local skin_mould_rows = dms.searchs(dms["ship_skin_mould"], ship_skin_mould.ship_mould_id, self._choose_ship.ship_template_id)
    local skin_mould_ids = {}
    


    --当前皮肤形象
    self.current_skin_id = 0
    if self._choose_ship.ship_skin_info and self._choose_ship.ship_skin_info ~= "" then
        local skin_info = zstring.splits(self._choose_ship.ship_skin_info, "|", ":")
        local temp = zstring.split(skin_info[1][1], ",")
        self.current_skin_id = zstring.tonumber(temp[1])
    end
    
    --默认形象（永远在第一个）
    local default_skin_evo_id = {}
    default_skin_evo_id.evo_mould_id = default_evo_id
    default_skin_evo_id.skin_mould_id = 0
    table.insert(skin_mould_ids,default_skin_evo_id)
    
    for i, v in ipairs(skin_mould_rows) do
        if v[1] and v[3] then
            local skin_evo_id = {}
            skin_evo_id.skin_mould_id = v[1]
            skin_evo_id.evo_mould_id = v[3]
            table.insert(skin_mould_ids, skin_evo_id)
        end
    end

    table.insert(skin_mould_ids, {skin_mould_id = -1 , evo_mould_id = -1})

    for i, v in ipairs(skin_mould_ids) do
        local cell = state_machine.excute("sm_role_fashion_card_cell", 0, {i, v, default_evolution_status, self.current_skin_id})
        ListView_role:addChild(cell)
    end
    ListView_role:jumpToLeft()
    ListView_role:requestRefreshView()
    
    self:updateFashionInfo(default_skin_evo_id.evo_mould_id, default_skin_evo_id.skin_mould_id, true)
end

function SmRoleFashion:updateIconList()
    local function fightingCapacity(a,b)
        return tonumber(a.hero_fight) > tonumber(b.hero_fight)
    end

    local tSortedHeroes = {}
    local arrBusyHeroes = {}
    for i, ship in pairs(_ED.user_ship) do
        if ship.ship_id ~= nil then
            if zstring.tonumber(ship.formation_index) > 0 then
                table.insert(arrBusyHeroes, ship)
            else
                table.insert(tSortedHeroes, ship)
            end
        end
    end

    table.sort(arrBusyHeroes, fightingCapacity)
    table.sort(tSortedHeroes, fightingCapacity)
    local root = self.roots[1]
    local ListView_list = ccui.Helper:seekWidgetByName(root, "ListView_list")
    ListView_list:removeAllItems()

    local index = 0
    for k,v in pairs(arrBusyHeroes) do
        index = index + 1
        local cell = HeroIconListCell:createCell()
        cell:init(v, index, true, 100, false, true)
        ListView_list:addChild(cell)
    end

    for k,v in pairs(tSortedHeroes) do
        index = index + 1
        local cell = HeroIconListCell:createCell()
        cell:init(v, index, false, 100, false, true)
        ListView_list:addChild(cell)
    end

    ListView_list:refreshView()
    self:firstIconIndex(self._choose_ship)
end

function SmRoleFashion:onInit()
    local csbItem = csb.createNode("packs/HeroStorage/generals_fashion.csb")
    self:addChild(csbItem)
    local root = csbItem:getChildByName("root")
    table.insert(self.roots, root)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_fanhui_lwj"), nil, 
    {
        terminal_name = "sm_role_fashion_window_close",
        terminal_state = 0,
        isPressedActionEnabled = true,
    }, nil, 3)
    
    self:onUpdateDraw()
    self:updateIconList()
end

function SmRoleFashion:init(params)
    self._choose_ship = params[1]
    self:onInit()
    return self
end

function SmRoleFashion:onExit()
    state_machine.remove("sm_role_fashion_update")
    state_machine.remove("sm_role_fashion_choose_ship")
    state_machine.remove("sm_role_fashion_choose_fashion")
    state_machine.remove("sm_role_fashion_use")
    state_machine.remove("sm_role_fashion_buy")
    state_machine.remove("sm_role_fashion_go_to")
    state_machine.remove("sm_role_fashion_buy_confirm")
end