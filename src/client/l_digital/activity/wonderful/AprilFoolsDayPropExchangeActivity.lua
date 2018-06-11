--[[ ----------------------------------------------------------------------------
-- 愚人节节日道具兑换活动
--]] ----------------------------------------------------------------------------
AprilFoolsDayPropExchangeActivity = class("AprilFoolsDayPropExchangeActivityClass", Window)

-- 打开窗口
local april_fools_day_prop_exchange_activity_window_open_terminal = {
	_name = "april_fools_day_prop_exchange_activity_window_open",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if nil == fwin:find("AprilFoolsDayPropExchangeActivityClass") then
			fwin:open(AprilFoolsDayPropExchangeActivity:new():init(params), fwin._view)
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

-- 关闭窗口
local april_fools_day_prop_exchange_activity_window_close_terminal = {
	_name = "april_fools_day_prop_exchange_activity_window_close",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		fwin:close(fwin:find("AprilFoolsDayPropExchangeActivityClass"))
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

state_machine.add(april_fools_day_prop_exchange_activity_window_open_terminal)
state_machine.add(april_fools_day_prop_exchange_activity_window_close_terminal)
state_machine.init()

-- 构造器
function AprilFoolsDayPropExchangeActivity:ctor()
	self.super:ctor()
	self.roots = {}
	self.actions = {}

	-- var

	-- load lua files.
	app.load("client.cells.activity.april_fools_day_prop_exchange_cell")

	-- Initialize recharge for sixty gift activity page state machine.
	local function init_april_fools_day_prop_exchange_activity_terminal()
		-- 打开角色创建窗口
		local april_fools_day_prop_exchange_activity_open_terminal = {
			_name = "april_fools_day_prop_exchange_activity_open",
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

		-- 关闭角色创建窗口
		local april_fools_day_prop_exchange_activity_close_terminal = {
			_name = "april_fools_day_prop_exchange_activity_close",
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

		-- 显示窗口
		local april_fools_day_prop_exchange_activity_show_terminal = {
			_name = "april_fools_day_prop_exchange_activity_show",
			_init = function (terminal)
				
			end,
			_inited = false,
			_instance = self,
			_state = 0,
			_invoke = function(terminal, instance, params)
				-- 显示窗口
				if nil ~= instance then
					instance:setVisible(true)
				end
				return true
			end,
			_terminal = nil,
			_terminals = nil
		}

		-- 隐藏窗口
		local april_fools_day_prop_exchange_activity_hide_terminal = {
			_name = "april_fools_day_prop_exchange_activity_hide",
			_init = function (terminal)
				
			end,
			_inited = false,
			_instance = self,
			_state = 0,
			_invoke = function(terminal, instance, params)
				-- 隐藏窗口
				if nil ~= instance then
					instance:setVisible(false)
				end
				return true
			end,
			_terminal = nil,
			_terminals = nil
		}

		state_machine.add(april_fools_day_prop_exchange_activity_open_terminal)
		state_machine.add(april_fools_day_prop_exchange_activity_close_terminal)
		state_machine.add(april_fools_day_prop_exchange_activity_show_terminal)
		state_machine.add(april_fools_day_prop_exchange_activity_hide_terminal)
		state_machine.init()
	end
	-- call func init recharge for sixty gift activity state machine.
	init_april_fools_day_prop_exchange_activity_terminal()
end

function AprilFoolsDayPropExchangeActivity:init()
	AprilFoolsDayPropExchangeActivity.cacheListView = nil
	AprilFoolsDayPropExchangeActivity.asyncIndex = 1
	if nil ~= self.onInit then
		self:onInit()
	end
	return self
end

function AprilFoolsDayPropExchangeActivity:onInit()

end

function AprilFoolsDayPropExchangeActivity:onUpdate(dt)
    if self.Text_time == nil or nil == self.end_time then
        return
    end
    local surplus_time = (self.end_time - ((os.time() + _ED.time_add_or_sub))*1000)
    self.Text_time:setString(surplus_time < 0 and _string_piece_info[305] or self:drawTime(surplus_time))
end

function AprilFoolsDayPropExchangeActivity:drawTime(_time)
    local timeString = ""
    local _dayTime = math.floor((_time / 1000) / 86400)
    local _hourTime = math.floor((_time / 1000) % 86400 / 3600)
    local _minutesTime = math.floor((_time / 1000) % 86400 % 3600 / 60)
    local _secondsTime = math.ceil((_time / 1000) % 60)
    if _dayTime > 0 then
        timeString = timeString .. _dayTime .._string_piece_info[231]
    end
    --if _hourTime > 0 then
        if _hourTime < 10 then
    		timeString = timeString .. "0".._hourTime ..":"
    	else
    		timeString = timeString .. _hourTime ..":"
    	end
    --end
    --if _minutesTime > 0 then
        if _minutesTime < 10 then
    		timeString = timeString .. "0".._minutesTime ..":"
    	else
            timeString = timeString .. _minutesTime ..":"
        end
    --end
    --if _secondsTime > 0 then
    	if _secondsTime < 10 then
    		timeString = timeString .. "0".._secondsTime 
    	else
	        timeString = timeString .. _secondsTime 
	    end
    --end
    return timeString
end

function AprilFoolsDayPropExchangeActivity:loading_cell()
	if AprilFoolsDayPropExchangeActivity.cacheListView == nil then
		return 
	end
	local activity = _ED.active_activity[121]--
	local cell = AprilFoolsDayPropExchange:createCell()
	cell:init(activity, AprilFoolsDayPropExchangeActivity.load_indexs[AprilFoolsDayPropExchangeActivity.asyncIndex], AprilFoolsDayPropExchangeActivity.cacheListView)
	AprilFoolsDayPropExchangeActivity.cacheListView:addChild(cell)
	AprilFoolsDayPropExchangeActivity.cacheListView:requestRefreshView()
	AprilFoolsDayPropExchangeActivity.asyncIndex = AprilFoolsDayPropExchangeActivity.asyncIndex + 1
end

function AprilFoolsDayPropExchangeActivity:initListView()
	local activity = _ED.active_activity[121]

	local load_indexs1 = {}
	local load_indexs2 = {}
	for i, info in pairs(activity.activity_Info) do
		local activityInfo = info
		local countInfos = zstring.split(activity.activity_params, ",")
		local exchangeInfos = zstring.split(activityInfo.activityInfo_need_day, "@")
		local nCount = (tonumber(exchangeInfos[2]) - tonumber(countInfos[i]))
		if nCount > 0 then
			table.insert(load_indexs1, i)
		else
			table.insert(load_indexs2, i)
		end
	end

	table.add(load_indexs1, load_indexs2)
	AprilFoolsDayPropExchangeActivity.load_indexs = load_indexs1

	for i, v in pairs(activity.activity_Info) do
		cc.Director:getInstance():getTextureCache():addImageAsync(fwin._asyncImg, self.loading_cell, self)
	end
end

function AprilFoolsDayPropExchangeActivity:onUpdateDraw()
	local root = self.roots[1]
	local activityData = _ED.active_activity[121]

	local activity_params = zstring.split(activityData.activity_params, "|")

	self.end_time = tonumber(activityData.end_time)

	self.ListView_tuisong = ccui.Helper:seekWidgetByName(root, "ListView_tuisong")

	cc.Director:getInstance():getTextureCache():removeTextureForKey(fwin._asyncImg)
	AprilFoolsDayPropExchangeActivity.asyncIndex = 1
	AprilFoolsDayPropExchangeActivity.cacheListView = self.ListView_tuisong

	self:initListView()
end

function AprilFoolsDayPropExchangeActivity:onEnterTransitionFinish()
	-- 加载AprilFoolsDayPropExchangeActivityWindow界面资源.
	-- res.activity.wonderful.april_fools_day = res/activity/wonderful/april_fools_day.csb
	local csbNode = csb.createNode("activity/wonderful/april_fools_day.csb")
	local root = csbNode:getChildByName("root")
	table.insert(self.roots, root)
	self:addChild(csbNode)

	-- 关闭
	self.Button_lingqu = fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_closed"), nil,
	{
		terminal_name = "april_fools_day_prop_exchange_activity_window_close",
		terminal_state = 0,
		isPressedActionEnabled = true,
	}, nil, 0)

	self.Text_time = ccui.Helper:seekWidgetByName(root, "Text_time")

	self:onUpdateDraw()
end

function AprilFoolsDayPropExchangeActivity:onExit()
	state_machine.remove("april_fools_day_prop_exchange_activity_open")
	state_machine.remove("april_fools_day_prop_exchange_activity_close")
	state_machine.remove("april_fools_day_prop_exchange_activity_show")
	state_machine.remove("april_fools_day_prop_exchange_activity_hide")
end

function AprilFoolsDayPropExchangeActivity:close()
	-- window event : close.
	
end

function AprilFoolsDayPropExchangeActivity:destroy(window)
	-- window event : destroy.
	
end

-- ~END
-- ----------------------------------------------------------------------------
