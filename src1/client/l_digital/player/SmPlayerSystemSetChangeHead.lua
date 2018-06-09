-- ----------------------------------------------------------------------------------------------------
-- 说明：数码系统修改头像
-------------------------------------------------------------------------------------------------------
SmPlayerSystemSetChangeHead = class("SmPlayerSystemSetChangeHeadClass", Window)
local sm_player_system_set_change_head_open_terminal = {
    _name = "sm_player_system_set_change_head_open",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
        local _window = fwin:find("SmPlayerSystemSetChangeHeadClass")
        if _window == nil then
            fwin:open(SmPlayerSystemSetChangeHead:new(),fwin._ui)
        end
    	return true
    end,
    _terminal = nil,
    _terminals = nil
}

local sm_player_system_set_change_head_close_terminal = {
    _name = "sm_player_system_set_change_head_close",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
        fwin:close(fwin:find("SmPlayerSystemSetChangeHeadClass"))
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_player_system_set_change_head_open_terminal)
state_machine.add(sm_player_system_set_change_head_close_terminal)
state_machine.init()
    
function SmPlayerSystemSetChangeHead:ctor()
    self.super:ctor()
   	self.actions = {}
	self.roots = {}

    self._scroll_view = nil
    self._scroll_view_posy = 0
    self._page_one_offsety = 0

    app.load("client.l_digital.player.SmPlayerSystemSetChangeHeadPageOne")
    app.load("client.l_digital.player.SmPlayerSystemSetChangeHeadPageTwo")
end

function SmPlayerSystemSetChangeHead:onUpdataDraw()
	local root = self.roots[1]
    local ScrollView_head = ccui.Helper:seekWidgetByName(root, "ScrollView_head")
    ScrollView_head:removeAllChildren(true)
    local height = 0
    local pageOne = state_machine.excute("sm_player_system_set_change_head_page_one_open",0,"")
    ScrollView_head:addChild(pageOne)
    height = height + pageOne:getContentSize().height
    local pageTwo = state_machine.excute("sm_player_system_set_change_head_page_two_open",0,"")
    ScrollView_head:addChild(pageTwo)
    height = height + pageTwo:getContentSize().height
    height = math.max(height , ScrollView_head:getContentSize().height)
    pageOne:setPositionY(pageTwo:getContentSize().height)
    ScrollView_head:getInnerContainer():setContentSize(cc.size(ScrollView_head:getContentSize().width, height))
    ScrollView_head:getInnerContainer():setPositionY(ScrollView_head:getContentSize().height - height)

    self._scroll_view = ScrollView_head
    self._scroll_view_posy = ScrollView_head:getInnerContainer():getPositionY() + 1
    self._page_one_offsety = pageTwo:getContentSize().height
end

function SmPlayerSystemSetChangeHead:onUpdate(dt)
    if self._scroll_view ~= nil then
        local posY = self._scroll_view:getInnerContainer():getPositionY()
        if posY == self._scroll_view_posy then
            return
        end
        self._scroll_view_posy = posY

        local size = self._scroll_view:getContentSize()
        state_machine.excute("sm_player_change_head_page_one_update_cells", 0, {posY + self._page_one_offsety, size})
        state_machine.excute("sm_player_change_head_page_two_update_cells", 0, {posY, size})
    end
end

function SmPlayerSystemSetChangeHead:onEnterTransitionFinish()
	local csbUserInfo = csb.createNode("player/role_information_change_head.csb")
	self:addChild(csbUserInfo)
	local root = csbUserInfo:getChildByName("root")
	table.insert(self.roots, root)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_closed"),nil, 
    {
        terminal_name = "sm_player_system_set_change_head_close",     
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, 
    nil, 0)
	self:onUpdataDraw()
end

function SmPlayerSystemSetChangeHead:onExit()
    
end
