-----------------------------
--充值返钻
-----------------------------
SmRechargeReturnReward = class("SmRechargeReturnRewardClass", Window)

local sm_recharge_return_reward_open_terminal = {
	_name = "sm_recharge_return_reward_open",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if fwin:find("SmRechargeReturnRewardClass") == nil then
			fwin:open(SmRechargeReturnReward:new():init(params), fwin._ui)		
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

local sm_recharge_return_reward_close_terminal = {
	_name = "sm_recharge_return_reward_close",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		fwin:close(fwin:find("SmRechargeReturnRewardClass"))
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

state_machine.add(sm_recharge_return_reward_open_terminal)
state_machine.add(sm_recharge_return_reward_close_terminal)
state_machine.init()

function SmRechargeReturnReward:ctor()
	self.super:ctor()
	self.roots = {}
    
    self._tick_time = 0
    self._text_time = nil

    app.load("client.l_digital.cells.activity.wonderful.sm_activity_recharge_return_reward_cell")
    local function init_sm_recharge_return_reward_terminal()
        local sm_recharge_return_reward_update_draw_terminal = {
            _name = "sm_recharge_return_reward_update_draw",
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

        state_machine.add(sm_recharge_return_reward_update_draw_terminal)
        state_machine.init()
    end
    init_sm_recharge_return_reward_terminal()
end

function SmRechargeReturnReward:onUpdateDraw()
    local root = self.roots[1]
    local ListView_tab_1 = ccui.Helper:seekWidgetByName(root, "ListView_tab_1")
    self._text_time = ccui.Helper:seekWidgetByName(root,"Text_time_1")
    ListView_tab_1:removeAllItems()

    local activity_info = _ED.active_activity[107]
    local activity_params = zstring.split(activity_info.activity_params, ",")
    local result = {}
    for i, v in pairs(activity_info.activity_Info) do
        table.insert(result, v)
    end
    local closeItems = {}       -- 已完成
    local drawItems = {}            -- 可领取
    local uncompItems = {}      -- 未完成
    for k, v in pairs(result) do
        if tonumber(v.activityInfo_isReward) == 1 then
            table.insert(closeItems, v)
        elseif tonumber(activity_params[k]) == 1 then
            table.insert(drawItems, v)
        else
            table.insert(uncompItems, v)
        end
    end
    result = {}
    for k, v in pairs(drawItems) do
        table.insert(result, v)
    end
    for k, v in pairs(uncompItems) do
        table.insert(result, v)
    end
    for k, v in pairs(closeItems) do
        table.insert(result, v)
    end

    for k, v in pairs(result) do
        local cell = state_machine.excute("sm_activity_recharge_return_reward_cell_create", 0, {v})
        ListView_tab_1:addChild(cell)
    end
    ListView_tab_1:requestRefreshView()

    self._tick_time =  (tonumber(activity_info.end_time) - (os.time() + _ED.time_add_or_sub) * 1000) / 1000
    self._text_time:setString(getRedAlertTimeActivityFormat(self._tick_time))
end

function SmRechargeReturnReward:onUpdate(dt)
    if self._text_time ~= nil and self._tick_time > 0 then 
        self._tick_time = self._tick_time - dt
        self._text_time:setString(getRedAlertTimeActivityFormat(self._tick_time))
        if self._tick_time <= 0 then
            self._tick_time = nil
        end
    end
end

function SmRechargeReturnReward:init(params)
	self:onInit()
    return self
end

function SmRechargeReturnReward:onInit()
    local csbItem = csb.createNode("activity/wonderful/limited_time_chongzhi.csb")
    local root = csbItem:getChildByName("root")
    self:addChild(csbItem)
    table.insert(self.roots, root)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_7day_back"), nil, 
    {
        terminal_name = "sm_recharge_return_reward_close", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 3)

    self:onUpdateDraw()
end

function SmRechargeReturnReward:onEnterTransitionFinish()
end

function SmRechargeReturnReward:onExit()
	state_machine.remove("sm_recharge_return_reward_update_draw")
end

