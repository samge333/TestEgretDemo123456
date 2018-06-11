
SmFriendWindow = class("SmFriendWindowClass", Window)

local sm_friend_window_open_terminal = {
    _name = "sm_friend_window_open",
    _init = function (terminal) 
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        local function responseCallback(response)
            if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                if nil == fwin:find("SmFriendWindowClass") then
                    fwin:open(SmFriendWindow:new():init(params), fwin._ui)
                end
            end
        end
        if table.nums(_ED.friend_find) == 0 then
            NetworkManager:register(protocol_command.random_user_list.code, nil, nil, nil, nil, responseCallback, false, nil)
        else
            responseCallback({RESPONSE_SUCCESS = true, PROTOCOL_STATUS = 0})
        end
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local sm_friend_window_close_terminal = {
    _name = "sm_friend_window_close",
    _init = function (terminal) 
    
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        fwin:close(fwin:find("SmFriendWindowClass"))
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_friend_window_open_terminal)
state_machine.add(sm_friend_window_close_terminal)
state_machine.init()
    
function SmFriendWindow:ctor()
    self.super:ctor()
    self.roots = {}

    self.choose_page = 0
    self._friend_panel = nil
    self._other_panel = nil
    self._apply_panel = nil

    app.load("client.chat.ChatFriendInfo")
    app.load("client.l_digital.friend.SmFriendList")
    app.load("client.l_digital.friend.SmFriendOther")
    app.load("client.l_digital.friend.SmFriendApply")
    app.load("client.l_digital.cells.friend.sm_friend_cell")

    local function init_sm_friend_window_terminal()
        local sm_friend_window_choose_page_terminal = {
            _name = "sm_friend_window_choose_page",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:changePage(params._datas.page)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        
        state_machine.add(sm_friend_window_choose_page_terminal)
        state_machine.init()
    end
    init_sm_friend_window_terminal()
end

function SmFriendWindow:changePage( page )
    local root = self.roots[1]
    local Panel_1320 = ccui.Helper:seekWidgetByName(root, "Panel_1320")
    local Button_01 = ccui.Helper:seekWidgetByName(root, "Button_01")
    local Button_friend_2 = ccui.Helper:seekWidgetByName(root, "Button_friend_2")
    local Button_04 = ccui.Helper:seekWidgetByName(root, "Button_04")
    if page == self.choose_page then
        if page == 1 then
            Button_01:setHighlighted(true)
        elseif page == 2 then
            Button_friend_2:setHighlighted(true)
        else
            Button_04:setHighlighted(true)
        end
        return
    end
    self.choose_page = page
    Button_01:setHighlighted(false)
    Button_friend_2:setHighlighted(false)
    Button_04:setHighlighted(false)
    state_machine.excute("sm_friend_list_hide", 0, nil)
    state_machine.excute("sm_friend_other_hide", 0, nil)
    state_machine.excute("sm_friend_apply_hide", 0, nil)
    if page == 1 then
        Button_01:setHighlighted(true)
        if self._friend_panel == nil then
            self._friend_panel = state_machine.excute("sm_friend_list_open", 0, {Panel_1320})
        else
            state_machine.excute("sm_friend_list_show", 0, nil)
        end
    elseif page == 2 then
        Button_friend_2:setHighlighted(true)
        if self._other_panel == nil then
            self._other_panel = state_machine.excute("sm_friend_other_open", 0, {Panel_1320})
        else
            state_machine.excute("sm_friend_other_show", 0, nil)
        end
    else
        Button_04:setHighlighted(true)
        if self._apply_panel == nil then
            self._apply_panel = state_machine.excute("sm_friend_apply_open", 0, {Panel_1320})
        else
            state_machine.excute("sm_friend_apply_show", 0, nil)
        end
    end
end

function SmFriendWindow:onInit()
    local csbFriend = csb.createNode("friend/friend.csb")
    local root = csbFriend:getChildByName("root")
    table.insert(self.roots, root)
    self:addChild(csbFriend)
    
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_01"), nil, 
    {
        terminal_name = "sm_friend_window_choose_page",
        terminal_state = 0,
        page = 1,
    },
    nil,3)
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_friend_endurance",
    _widget = ccui.Helper:seekWidgetByName(root,"Button_01"),
    _invoke = nil,
    _interval = 0.5,})

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_friend_2"), nil, 
    {
        terminal_name = "sm_friend_window_choose_page",
        terminal_state = 0,
        page = 2,
    },
    nil,3)
    
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_04"), nil, 
    {
        terminal_name = "sm_friend_window_choose_page",
        terminal_state = 0,
        page = 3,
    },
    nil,3)
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_friend_apply",
    _widget = ccui.Helper:seekWidgetByName(root,"Button_04"),
    _invoke = nil,
    _interval = 0.5,})

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_05"), nil, 
    {
        terminal_name = "sm_friend_window_close",
        terminal_state = 0,
    },
    nil,3)
    
    self:changePage(2)

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

function SmFriendWindow:init(params)
    self:onInit()
    return self
end

function SmFriendWindow:close( ... )
    local Panel_effec = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_effec")
    if Panel_effec ~= nil then
        Panel_effec:removeAllChildren(true)
    end
end

function SmFriendWindow:onExit()
    state_machine.remove("sm_friend_window_choose_page")
end