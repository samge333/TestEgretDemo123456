--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
SmActivityRechargeReturnRewardCell = class("SmActivityRechargeReturnRewardCellClass", Window)
SmActivityRechargeReturnRewardCell.__size = nil

local sm_activity_recharge_return_reward_cell_create_terminal = {
    _name = "sm_activity_recharge_return_reward_cell_create",
    _init = function (terminal)
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        local cell = SmActivityRechargeReturnRewardCell:new()
        cell:init(params)
        cell:registerOnNodeEvent(cell)
        return cell
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_activity_recharge_return_reward_cell_create_terminal)
state_machine.init()

function SmActivityRechargeReturnRewardCell:ctor()
	self.super:ctor()
	self.roots = {}

    self._info = nil
    self.reworld_sorting = {}

    app.load("client.cells.utils.resources_icon_cell")
    app.load("client.cells.equip.equip_icon_cell")
    app.load("client.cells.prop.prop_icon_cell")
    app.load("client.shop.recharge.RechargeDialog")
    app.load("client.reward.DrawRareReward")
    app.load("client.cells.prop.prop_money_icon")
    local function init_sm_activity_recharge_return_reward_cell_terminal()
        local sm_activity_recharge_return_reward_cell_choose_terminal = {
            _name = "sm_activity_recharge_return_reward_cell_choose",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local cell = params._datas.cell
                if cell.isComplete then
                    local function responseGetServerListCallback(response)
                        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                            local rewardinfo = nil
                            if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                                rewardinfo = response.node.reworld_sorting
                            end
                            local getRewardWnd = DrawRareReward:new()
                            getRewardWnd:init(7, nil, rewardinfo)
                            fwin:open(getRewardWnd, fwin._ui)
                            state_machine.excute("sm_recharge_return_reward_update_draw", 0, nil)
                        end
                    end
                    local activityId = _ED.active_activity[107].activity_id   
                    protocol_command.get_activity_reward.param_list = activityId.."\r\n"..(tonumber(cell._info.index)-1).."\r\n1"
                    NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, cell, responseGetServerListCallback, false, nil)
                    return true
                else
                    state_machine.excute("shortcut_open_recharge_window", 0, "")
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_activity_recharge_return_reward_cell_choose_terminal)
        state_machine.init()
    end
    init_sm_activity_recharge_return_reward_cell_terminal()
end

function SmActivityRechargeReturnRewardCell:updateDraw()
    local root = self.roots[1]
    self.isComplete = false
    local Text_11 = ccui.Helper:seekWidgetByName(root, "Text_11")
    local Button_12 = ccui.Helper:seekWidgetByName(root, "Button_12")
    local ListView_11 = ccui.Helper:seekWidgetByName(root, "ListView_11")

    local activity_info = _ED.active_activity[107]
    local activity_params = zstring.split(activity_info.activity_params, ",")
    Text_11:setString(self._info.activityInfo_name)
    if tonumber(self._info.activityInfo_isReward) == 0 then
        if tonumber(activity_params[tonumber(self._info.index)]) == 1 then
            Button_12:setTouchEnabled(true)
            Button_12:setBright(true)
            Button_12:setTitleText(_new_interface_text[247])
            self.isComplete = true
        else
            if __lua_project_id == __lua_project_l_digital then
                Button_12:setTitleText(red_alert_all_str[169])
            end
            Button_12:setTouchEnabled(true)
            Button_12:setBright(true)
            self.isComplete = false
        end
    else
        Button_12:setTitleText(_new_interface_text[199])
        Button_12:setTouchEnabled(false)
        Button_12:setBright(false)
    end

    local index = 1
    self.reworld_sorting = {}
    if tonumber(self._info.activityInfo_silver) > 0 then--可领取银币数量
        local cell = ResourcesIconCell:createCell()
        cell:init(1, tonumber(self._info.activityInfo_silver), -1,nil,nil,true,true)
        ListView_11:addChild(cell)
        local rewardinfo = {}
        rewardinfo.type = 1
        rewardinfo.id = -1
        rewardinfo.number = tonumber(self._info.activityInfo_silver)
        self.reworld_sorting[index] = rewardinfo
        index = index + 1
    end
    if tonumber(self._info.activityInfo_gold) > 0 then--奖励1可领取金币数量
        local cell = ResourcesIconCell:createCell()
        cell:init(2, tonumber(self._info.activityInfo_gold), -1,nil,nil,true,true)
        ListView_11:addChild(cell)
        local rewardinfo = {}
        rewardinfo.type = 2
        rewardinfo.id = -1
        rewardinfo.number = tonumber(self._info.activityInfo_gold)
        self.reworld_sorting[index] = rewardinfo
        index = index + 1
    end
    if tonumber(self._info.activityInfo_food) > 0 then--奖励1可领取体力数量
        local cell = ResourcesIconCell:createCell()
        cell:init(12, tonumber(self._info.activityInfo_food), -1,nil,nil,true,true)
        ListView_11:addChild(cell)
        local rewardinfo = {}
        rewardinfo.type = 12
        rewardinfo.id = -1
        rewardinfo.number = tonumber(self._info.activityInfo_food)
        self.reworld_sorting[index] = rewardinfo
        index = index + 1
    end
    if tonumber(self._info.activityInfo_honour) > 0 then--奖励1可领取声望数量
        local cell = ResourcesIconCell:createCell()
        cell:init(3, tonumber(self._info.activityInfo_honour), -1,nil,nil,true,true)
        ListView_11:addChild(cell)
        local rewardinfo = {}
        rewardinfo.type = 3
        rewardinfo.id = -1
        rewardinfo.number = tonumber(self._info.activityInfo_honour)
        self.reworld_sorting[index] = rewardinfo
        index = index + 1
    end
    if tonumber(self._info.activityInfo_equip_count) > 0 then   --可领取装备种类数量
        for n, v in pairs(self._info.activityInfo_equip_info) do
            local cell = ResourcesIconCell:createCell()
            cell:init(7, tonumber(v.equipMouldCount), v.equipMould,nil,nil,true,true)
            ListView_11:addChild(cell)
            local rewardinfo = {}
            rewardinfo.type = 7
            rewardinfo.id = v.equipMould
            rewardinfo.number = tonumber(v.equipMouldCount)
            self.reworld_sorting[index] = rewardinfo
            index = index + 1
        end
    end
    if tonumber(self._info.activityInfo_prop_count) > 0 then--可领取道具种类数量
        for n, v in pairs(self._info.activityInfo_prop_info) do
            local cell = ResourcesIconCell:createCell()
            cell:init(6, tonumber(v.propMouldCount), v.propMould,nil,nil,true,true)
            ListView_11:addChild(cell)
            local rewardinfo = {}
            rewardinfo.type = 6
            rewardinfo.id = v.propMould
            rewardinfo.number = tonumber(v.propMouldCount)
            self.reworld_sorting[index] = rewardinfo
            index = index + 1
        end
    end
    if tonumber(self._info.activityInfo_general_soul) > 0 then  --可领取水雷魂种类数量
        local cell = ResourcesIconCell:createCell()
        cell:init(5, tonumber(self._info.activityInfo_general_soul), -1,nil,nil,true,true)
        ListView_11:addChild(cell)
        local rewardinfo = {}
        rewardinfo.type = 5
        rewardinfo.id = -1
        rewardinfo.number = tonumber(self._info.activityInfo_general_soul)
        self.reworld_sorting[index] = rewardinfo
        index = index + 1
    end

    local otherRewards = zstring.splits(self._info.activityInfo_reward_select, "|", ",")
    if #otherRewards > 0 then
        for i, v in pairs(otherRewards) do
            -- 类型、ID、数量、星级
            if #v >= 3 then
                local cell = ResourcesIconCell:createCell()
                local rewardType = tonumber(v[1])
                if 13 == rewardType then
                    local table = {}
                    if v[4] ~= nil and tonumber(v[4]) ~= -1 then
                        table.shipStar = tonumber(v[4])
                    end
                    cell:init(rewardType, tonumber(v[3]), tonumber(v[2]),nil,nil,true,true,1,table)
                    local ships = fundShipWidthTemplateId(tonumber(v[2]))
                    if ships == nil then
                        local rewardinfo = {}
                        rewardinfo.type = rewardType
                        rewardinfo.id = tonumber(v[2])
                        rewardinfo.number = tonumber(v[3])
                        self.reworld_sorting[index] = rewardinfo
                        index = index + 1
                    else
                        local prop_mlds = dms.int(dms["ship_mould"], tonumber(v[2]), ship_mould.fitSkillOne)
                        local number_info = zstring.split(dms.string(dms["ship_config"], 13, ship_config.param),"!")[tonumber(v[4])]
                        local ability = dms.int(dms["ship_mould"], tonumber(v[2]), ship_mould.ability)
                        local number_data = zstring.split(number_info,"|")[ability-13+1]
                        local m_number = tonumber(zstring.split(number_data,",")[2])
                        local rewardinfo = {}
                        rewardinfo.type = 6
                        rewardinfo.id = prop_mlds
                        rewardinfo.number = m_number
                        self.reworld_sorting[index] = rewardinfo
                        index = index + 1
                    end
                elseif 18 == rewardType then
                    cell:init(rewardType, tonumber(v[3]), tonumber(v[2]),nil,nil,true,true,1)
                    local rewardinfo = {}
                    rewardinfo.type = rewardType
                    rewardinfo.id = tonumber(v[2])
                    rewardinfo.number = tonumber(v[3])
                    self.reworld_sorting[index] = rewardinfo
                    index = index + 1
                else
                    cell:init(rewardType, tonumber(v[3]), tonumber(v[2]),nil,nil,true,true,1)
                    local rewardinfo = {}
                    rewardinfo.type = rewardType
                    rewardinfo.id = tonumber(v[2])
                    rewardinfo.number = tonumber(v[3])
                    self.reworld_sorting[index] = rewardinfo
                    index = index + 1
                end
                ListView_11:addChild(cell)
            end
        end
    end
    ListView_11:requestRefreshView()
end

function SmActivityRechargeReturnRewardCell:onInit()
    local csbActivityDiscount = csb.createNode("activity/wonderful/limited_time_chongzhi_list.csb")
    local root = csbActivityDiscount:getChildByName("root")
    table.insert(self.roots, root)
    root:removeFromParent(false)
    self:addChild(root)

    if SmActivityRechargeReturnRewardCell.__size == nil then
        SmActivityRechargeReturnRewardCell.__size = ccui.Helper:seekWidgetByName(root, "Panel_land_list"):getContentSize()
    end

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_12"), nil, 
    {
        terminal_name = "sm_activity_recharge_return_reward_cell_choose", 
        terminal_state = 0,
        isPressedActionEnabled = true,
        cell = self,
    },
    nil,0)

	self:updateDraw()
end

function SmActivityRechargeReturnRewardCell:onEnterTransitionFinish()
end

function SmActivityRechargeReturnRewardCell:init(params)
    self._info = params[1]
	self:onInit()
    self:setContentSize(SmActivityRechargeReturnRewardCell.__size)
    return self
end

function SmActivityRechargeReturnRewardCell:onExit()
end