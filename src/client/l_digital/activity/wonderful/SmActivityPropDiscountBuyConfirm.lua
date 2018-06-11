-- ------------------------------------------------------------------------------------------------------------
--  说明：数码一键升级
-- ------------------------------------------------------------------------------------------------------------
SmActivityPropDiscountBuyConfirm = class("SmActivityPropDiscountBuyConfirmClass", Window)

--打开界面
local sm_activity_auto_upgrade_window_open_terminal = {
    _name = "sm_activity_auto_upgrade_window_open",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        if fwin:find("SmActivityPropDiscountBuyConfirmClass") == nil then
            fwin:open(SmActivityPropDiscountBuyConfirm:new():init(params), fwin._ui)
        end
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_activity_auto_upgrade_window_open_terminal)
state_machine.init()

function SmActivityPropDiscountBuyConfirm:ctor()
    self.super:ctor()
    local function init_sm_auto_upgrade_terminal()
        --关闭界面
        local sm_activity_auto_upgrade_window_close_terminal = {
            _name = "sm_activity_auto_upgrade_window_close",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance.action:play("window_exit", false)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_auto_upgrade_change_times_terminal = {
            _name = "sm_auto_upgrade_change_times",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local is_max = params._datas.updateLevel == 1
                if params._datas.updateLevel == 1 then
                    instance._current_level = instance._max_current_level
                else
                    instance._current_level = 1
                end
                instance:setSelectNum(instance._current_level)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_auto_upgrade_silder_update_terminal = {
            _name = "sm_auto_upgrade_silder_update",
            _init = function (terminal) 
            
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local Slider_number = ccui.Helper:seekWidgetByName(instance.roots[1], "Slider_1")
                local select_num = math.ceil(tonumber(Slider_number:getPercent()) * (self._max_level) / 100)
                if select_num <= 0 then
                    select_num = 1
                end
                instance:setSelectNum(select_num)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_auto_upgrade_sure_terminal = {
            _name = "sm_auto_upgrade_sure",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local index = params._datas._index
                local num = instance._current_level
                local activity = _ED.active_activity[instance.activity_id]
                if activity == nil then
                    return
                end

                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        app.load("client.reward.DrawRareReward")
                        state_machine.excute("sm_activity_auto_upgrade_window_close", 0, nil)
                        local getRewardWnd = DrawRareReward:new()
                        getRewardWnd:init(7)
                        fwin:open(getRewardWnd, fwin._ui)
                        if instance.activity_id == 112 then
                            state_machine.excute("sm_activity_prop_discount_update", 0, nil)
                        elseif instance.activity_id == 127 then 
                            state_machine.excute("sm_activity_prop_gift_box_promotion_update", 0, nil)
                        end
                    end
                end
                protocol_command.get_activity_reward.param_list = activity.activity_id.."\r\n"..(index- 1).."\r\n"..num.."\r\n0"
                NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_activity_auto_upgrade_window_close_terminal)
        state_machine.add(sm_auto_upgrade_silder_update_terminal)
        state_machine.add(sm_auto_upgrade_change_times_terminal)
        state_machine.add(sm_auto_upgrade_sure_terminal)
        state_machine.init()
    end
    
    init_sm_auto_upgrade_terminal()
end

function SmActivityPropDiscountBuyConfirm:onUpdateDraw()
    local root = self.roots[1]
    local activity = _ED.active_activity[self.activity_id]
    local activityDatas = activity.activity_Info[self.index]
    local Panel_props = ccui.Helper:seekWidgetByName(root, "Panel_icon")
    local Text_prop_name = ccui.Helper:seekWidgetByName(root, "Text_1_2_2")
    local Text_prop_sell_end = ccui.Helper:seekWidgetByName(root, "Text_money")
    local Text_prop_text = ccui.Helper:seekWidgetByName(root, "Text_shuliang")
    local infos = zstring.split(activityDatas.activityInfo_need_day, ",")
    local currentTimess = zstring.split(activity.activity_params, ",")

    self.unit_price = infos[2]
    Text_prop_sell_end:setString(infos[2])
    Text_prop_text:setString(currentTimess[self.index].."/"..infos[1])

    Panel_props:removeAllChildren(true)
    local cell = ResourcesIconCell:createCell()
    if tonumber(activityDatas.activityInfo_silver) ~= 0 then
        cell:init(1, tonumber(activityDatas.activityInfo_silver), -1,nil,nil,true,true)
        Text_prop_name:setString(_All_tip_string_info._fundName)
    end
    if tonumber(activityDatas.activityInfo_gold) ~= 0 then
        cell:init(2, tonumber(activityDatas.activityInfo_gold), -1,nil,nil,true,true)
        Text_prop_name:setString(_All_tip_string_info._crystalName)
    end
    if tonumber(activityDatas.activityInfo_food) ~= 0 then
        cell:init(12, tonumber(activityDatas.activityInfo_gold), -1,nil,nil,true,true)
        Text_prop_name:setString(_All_tip_string_info._energyName)
    end
    if tonumber(activityDatas.activityInfo_equip_count) ~= 0 then
        local equip_data = activityDatas.activityInfo_equip_info[1]
        cell:init(7, tonumber(equip_data.equipMouldCount), equip_data.equipMould,nil,nil,true,true)
        local nameindex = dms.int(dms["equipment_mould"], equip_data.equipMould, equipment_mould.equipment_name)
        local word_info = dms.element(dms["word_mould"], nameindex)
        Text_prop_name:setString(word_info[3])
    end
    if tonumber(activityDatas.activityInfo_prop_count) ~= 0 then
        local prop_data = activityDatas.activityInfo_prop_info[1]
        cell:init(6, tonumber(prop_data.propMouldCount), prop_data.propMould, nil,nil,true,true)
        local name = setThePropsIcon(prop_data.propMould)[2]
        Text_prop_name:setString(name)
        if dms.int(dms["prop_mould"], prop_data.propMould, prop_mould.use_of_ship) > 0 
            and dms.int(dms["prop_mould"], prop_data.propMould, prop_mould.storage_page_index) == 18 
            then
            local jsonFile = "sprite/sprite_wzkp.json"
            local atlasFile = "sprite/sprite_wzkp.atlas"
            local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
            animation:setPosition(cc.p(cell:getContentSize().width/2,cell:getContentSize().height/2))
            cell:addChild(animation)
        end
    end
    local otherRewards = zstring.splits(activityDatas.activityInfo_reward_select, "|", ",")
    if #otherRewards > 0 then
        for i, v in pairs(otherRewards) do
            if #v >= 3 then
                local rewardType = tonumber(v[1])
                if 13 == rewardType then
                    local table = {}
                    if v[4] ~= nil and tonumber(v[4]) ~= -1 then
                        table.shipStar = tonumber(v[4])
                    end
                    cell:init(rewardType, tonumber(v[3]), tonumber(v[2]),nil,nil,true,true,1,table)
                    local evo_image = dms.string(dms["ship_mould"], v[2], ship_mould.fitSkillTwo)
                    local evo_info = zstring.split(evo_image, ",")
                    local evo_mould_id = evo_info[dms.int(dms["ship_mould"], v[2], ship_mould.captain_name)]
                    local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
                    local word_info = dms.element(dms["word_mould"], name_mould_id)
                    local name = word_info[3]
                    Text_prop_name:setString(name)
                else
                    cell:init(rewardType, tonumber(v[3]), tonumber(v[2]),nil,nil,true,true,1)
                    local types = tonumber(v[1])
                    if types == 1 then
                        name = _All_tip_string_info._fundName
                    elseif types == 2 then
                        name = _All_tip_string_info._crystalName
                    elseif types == 5 then
                        name = _All_tip_string_info._soulName
                    elseif types == 8 then
                        name = reward_prop_list[8]
                    elseif types == 18 then
                        name = _All_tip_string_info._glories
                    elseif types == 3 then
                        name = _All_tip_string_info._reputation
                    elseif types == 31 then
                        name = red_alert_resouce_tip[1][1]
                    elseif types == 33 then 
                        name = _my_gane_name[14]
                    elseif types == 34 then 
                        name = _my_gane_name[15]
                    elseif types == 4 then
                        name = _All_tip_string_info._hero
                    end
                    Text_prop_name:setString(name)
                end
            end
        end
    end
    local cost_image = {
        "images/ui/icon/jinbi.png",         -- 金币
        "images/ui/icon/zuanshi.png",           -- 钻石
        "images/ui/icon/qh_pic_jjb.png",        --竞技币
        "images/ui/icon/slb.png",           --试炼币
        "images/ui/icon/icon_ghb.png",          --公会币
    }
    
    Panel_props:setBackGroundImage(cost_image[2])

    self._max_level = tonumber(infos[1])
    self._max_current_level = tonumber(currentTimess[self.index])
    self._current_level = 1
    self:setSelectNum(self._current_level)
end

function SmActivityPropDiscountBuyConfirm:setSelectNum(select_num)
    local root = self.roots[1]
    self._current_level = select_num
    if self._current_level >= self._max_current_level then
        self._current_level = self._max_current_level
    end
    if self._current_level <= 1 then
        self._current_level = 1
    end
    local percent = math.floor((self._current_level) / (self._max_level)*100)

    local Slider_number = ccui.Helper:seekWidgetByName(root, "Slider_1")
    Slider_number:setPercent(percent)
    local Text_yjsj_1_0 = ccui.Helper:seekWidgetByName(root, "Text_shuliang")
    Text_yjsj_1_0:setString(self._current_level.."/"..self._max_level)
    local Text_prop_sell_end = ccui.Helper:seekWidgetByName(root, "Text_money")
    Text_prop_sell_end:setString(tonumber(self.unit_price)*self._current_level)
    self:updateUIInfo()
end

function SmActivityPropDiscountBuyConfirm:updateUIInfo()
    local root = self.roots[1]
    local Button_add = ccui.Helper:seekWidgetByName(root, "Button_max")
    local Button_reduce = ccui.Helper:seekWidgetByName(root, "Button_min")
    Button_add:setTouchEnabled(true)
    Button_reduce:setTouchEnabled(true)
    Button_add:setBright(true)
    Button_reduce:setBright(true)
    if self._current_level >= self._max_current_level then
        Button_add:setTouchEnabled(false)
        Button_add:setBright(false)
    end
    if self._current_level <= 1 then
        Button_reduce:setTouchEnabled(false)
        Button_reduce:setBright(false)
    end
end

function SmActivityPropDiscountBuyConfirm:onInit()
    local csbItem = csb.createNode("utils/prompt_select_0.csb")
    self:addChild(csbItem)
    local root = csbItem:getChildByName("root")
    table.insert(self.roots, root)

    self.action = csb.createTimeline("utils/prompt_select_0.csb")
    csbItem:runAction(self.action)
    self.action:setFrameEventCallFunc(function (frame)
        if nil == frame then
            return
        end
        
        local str = frame:getEvent()
        if str == "open" then
            
        elseif str == "over2" then
            fwin:close(fwin:find("SmActivityPropDiscountBuyConfirmClass"))
        end
    end)

    
    self.action:play("window_open", false)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_4_8"), nil, 
    {
        terminal_name = "sm_activity_auto_upgrade_window_close", 
        terminal_state = 0, 
        isPressedActionEnabled = true,
    }, nil, 3)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_max"), nil, 
    {
        terminal_name = "sm_auto_upgrade_change_times", 
        terminal_state = 0, 
        isPressedActionEnabled = true,
        updateLevel = 1,
    }, nil, 1)  

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_min"), nil, 
    {
        terminal_name = "sm_auto_upgrade_change_times", 
        terminal_state = 0, 
        isPressedActionEnabled = true,
        updateLevel = -1,
    }, nil, 1)  

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_3_6_2"), nil, 
    {
        terminal_name = "sm_auto_upgrade_sure", 
        terminal_state = 0,
        _index =  self.index,
        isPressedActionEnabled = true,
    }, nil, 1)

    local Slider_number = ccui.Helper:seekWidgetByName(root, "Slider_1")
    local function percentChangedEvent(sender,eventType)
        if eventType == ccui.SliderEventType.percentChanged then
            state_machine.excute("sm_auto_upgrade_silder_update", 0, {sender:getPercent()})
        end
    end
    Slider_number:addEventListener(percentChangedEvent)

    self:onUpdateDraw()
end

function SmActivityPropDiscountBuyConfirm:init(params)
    self.index = params.index
    self.activity_id = params.activity_id 
    self.roots = {}
    self:onInit()
    return self
end

function SmActivityPropDiscountBuyConfirm:onExit()
    state_machine.remove("sm_auto_upgrade_sure")
    state_machine.remove("sm_auto_upgrade_silder_update")
    state_machine.remove("sm_auto_upgrade_change_times")
end