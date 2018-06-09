-- ----------------------------------------------------------------------------------------------------
-- 说明：神秘商店
-------------------------------------------------------------------------------------------------------
SecretShop = class("SecretShopClass", Window)

local secret_shop_window_open_terminal = {
    _name = "secret_shop_window_open",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
    	if nil == fwin:find("SecretShopClass") then
    		fwin:open(SecretShop:new():init(params), fwin._view)
    	end
        return false
    end,
    _terminal = nil,
    _terminals = nil
}

local secret_shop_window_close_terminal = {
    _name = "secret_shop_window_close",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        fwin:close(fwin:find("SecretShopClass"))
        return false
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(secret_shop_window_open_terminal)
state_machine.add(secret_shop_window_close_terminal)
state_machine.init()

function SecretShop:ctor()
    self.super:ctor()
	self.roots = {}
	self.actions = {}

	-- var
    self.index = 6

	-- load lua files.
    app.load("client.l_digital.cells.prop.sm_secret_shop_prop_buy_list_cell")
    app.load("client.l_digital.shop.SmShopBuy")
    app.load("client.l_digital.shop.SmShopRefreshWindow")
    
	
	-- Initialize secret shop page state machine.
    local function init_secret_shop_terminal()
	
		-- 神秘商店刷新
		local secret_shop_refresh_terminal = {
            _name = "secret_shop_refresh",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("sm_shop_refresh_window_open" , 0 , instance.index)
                -- local function responseCallback(response)
                --     if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                --         if nil ~= response.node and nil ~= response.node.roots and nil ~= response.node.roots[1] then
                --             response.node:onUpdateDraw()
                --         end
                --     end
                -- end
                -- protocol_command.mystical_shop_refresh.param_list = ""
                -- NetworkManager:register(protocol_command.mystical_shop_refresh.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local secret_shop_update_draw_terminal = {
            _name = "secret_shop_update_draw",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                -- state_machine.excute("sm_shop_refresh_window_open" , 0 , instance.index)
                -- local function responseCallback(response)
                --     if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                --         if nil ~= response.node and nil ~= response.node.roots and nil ~= response.node.roots[1] then
                            instance:onUpdateDraw()
                --         end
                --     end
                -- end
                -- protocol_command.mystical_shop_refresh.param_list = ""
                -- NetworkManager:register(protocol_command.mystical_shop_refresh.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		state_machine.add(secret_shop_refresh_terminal)
        state_machine.add(secret_shop_update_draw_terminal)
        state_machine.init()
    end
    
    -- call func init secret shop state machine.
    init_secret_shop_terminal()
end

function SecretShop:formatTime(_time)
    local timeString = ""
    local _dayTime = math.floor((_time) / 86400)
    local _hourTime = math.floor((_time) % 86400 / 3600)
    local _minutesTime = math.floor((_time) % 86400 % 3600 / 60)
    local _secondsTime = math.ceil((_time) % 60)
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

function SecretShop:onUpdate(dt) 
    if nil ~= self.Text_time then
        self._time = self._time - dt
        if self._time < 0 then
            self._time = 0
        end
        self.Text_time:setString(self:formatTime(self._time))
        if 0 >= self._time then
            self.Text_time = nil
        end
    end
end

function SecretShop:onUpdateDraw()
	local root = self.roots[1]

	local ScrollView_suipian_duihuan = ccui.Helper:seekWidgetByName(root, "ScrollView_suipian_duihuan")
	ScrollView_suipian_duihuan:removeAllChildren(true)

    -- 商品信息(商店商品id,已购买次数|商店商品id,已购买次数|....)
    local items = _ED.secret_shop_info.items
    local width_n = math.ceil((#items) / 2)
    for i, v in pairs(items) do
        local cell = SmSecretShopPropBuyListCell:createCell()
        cell:init(prop, self.index, i)
        if cell_size == nil then
            cell_size = cell:getContentSize()
        end
        ScrollView_suipian_duihuan:addChild(cell)
        local pos = cc.p(((i - 1) % width_n) * cell_size.width, (2 - math.ceil(i / width_n)) * cell_size.height)
        cell:setPosition(pos)
    end

    local InnerWidth = math.max(cell_size.width * width_n , ScrollView_suipian_duihuan:getContentSize().width)
    local csize = ScrollView_suipian_duihuan:getInnerContainer():getContentSize()
    csize.width = InnerWidth
    ScrollView_suipian_duihuan:getInnerContainer():setContentSize(csize)
end

function SecretShop:onEnterTransitionFinish()
	local csbNode = csb.createNode("shop/sm_mysterious_shop.csb")
	local root = csbNode:getChildByName("root")
	table.insert(self.roots, root)
    self:addChild(csbNode)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_close"), 	nil, 
	{
		terminal_name = "secret_shop_window_close",
		terminal_state = 0,
		isPressedActionEnabled = true
	}, 
	nil, 0)

	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_refresh"), 	nil, 
	{
		terminal_name = "secret_shop_refresh",
		terminal_state = 0,
		isPressedActionEnabled = true
	}, 
	nil, 0)

    self._time = _ED.secret_shop_info.end_time - (_ED.system_time + (os.time() - _ED.native_time))
    self.Text_time = ccui.Helper:seekWidgetByName(root, "Text_time")

    self:onUpdateDraw()
end

function SecretShop:init()
	return self
end

function SecretShop:onExit()
	state_machine.remove("secret_shop_refresh")
    state_machine.remove("secret_shop_update_draw")
end

function SecretShop:destroy( window )

end