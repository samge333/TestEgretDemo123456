SmFriendList = class("SmFriendListClass", Window)

local sm_friend_list_open_terminal = {
    _name = "sm_friend_list_open",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        local panel = SmFriendList:new():init(params)
        fwin:open(panel)
        return panel
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_friend_list_open_terminal)
state_machine.init()

function SmFriendList:ctor()
    self.super:ctor()
    self.roots = {}

    self.currPage = 0
    self.maxPage = 0

    self._list_view = nil
    self._list_view_poy = nil
    self._list_view_height = 0

    local function init_sm_friend_list_terminal()
        local sm_friend_list_show_terminal = {
            _name = "sm_friend_list_show",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                instance:setVisible(true)
                instance:onUpdateDraw()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_friend_list_hide_terminal = {
            _name = "sm_friend_list_hide",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                local root = instance.roots[1]
                local ListView_01 = ccui.Helper:seekWidgetByName(root,"ListView_01")
                ListView_01:jumpToTop()
                ListView_01:removeAllItems()
                instance:setVisible(false)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_friend_list_update_terminal = {
            _name = "sm_friend_list_update",
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

        local sm_friend_list_request_refresh_terminal = {
            _name = "sm_friend_list_request_refresh",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then 
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            response.node.currPage = 1
                            response.node:onUpdateDraw()
                        end
                    end
                end
                NetworkManager:register(protocol_command.friend_update.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_friend_list_auto_give_food_terminal = {
            _name = "sm_friend_list_auto_give_food",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local function responeCallBack(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            TipDlg.drawTextDailog(_new_interface_text[54])
                            response.node:onUpdateDraw()
                        end
                    else
                        state_machine.excute("sm_friend_list_request_refresh", 0, nil)
                    end
                end
                local str = ""
                for i, v in pairs(_ED.friend_info) do
                    if tonumber(v.is_send) == 0 then
                        str = str .. v.user_id..","
                    end
                end
                if str ~= "" then
                    str = string.sub(str,1,-2)
                    protocol_command.present_endurance.param_list = str .."\r\n".."1"
                    NetworkManager:register(protocol_command.present_endurance.code, nil, nil, nil, instance, responeCallBack, false, nil)
                else
                    TipDlg.drawTextDailog(_new_interface_text[53])
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_friend_list_auto_recive_food_terminal = {
            _name = "sm_friend_list_auto_recive_food",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                local function responeCallBack(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if response.node ~= nil and response.node.roots ~= nil and response.node.roots[1] ~= nil then
                            TipDlg.drawTextDailog(_new_interface_text[52])
                            response.node:onUpdateDraw()
                        end
                        state_machine.excute("notification_center_update", 0, "push_notification_center_friend_all")
                        state_machine.excute("notification_center_update", 0, "push_notification_center_friend_endurance")
                    else
                        state_machine.excute("sm_friend_list_request_refresh", 0, nil)
                    end
                end
                local draw_number = 0
                for i, v in pairs(_ED.endurance_init_info.get_info) do
                    if tonumber(v.draw_state) == 1 then
                        draw_number = draw_number + 1
                    end
                end
                local max_draw_strength = zstring.split(dms.string(dms["friend_config"], 4, friend_config.param), ",")
                max_draw_strength = tonumber(max_draw_strength[1])
                if draw_number >= max_draw_strength then
                    TipDlg.drawTextDailog(_string_piece_info[326])
                    return
                end
                local last_draw_number = max_draw_strength - draw_number
                local str = ""
                local can_draw_number = 0
                for k, v1 in pairs(_ED.endurance_init_info.get_info) do
                    if can_draw_number >= last_draw_number then
                        break
                    end
                    if tonumber(v1.draw_state) == 0 then
                        str = str .. v1.id..","
                        can_draw_number = can_draw_number + 1
                    end
                end
                
                if str ~= "" then
                    str = string.sub(str, 1, -2)
                    protocol_command.draw_endurance.param_list = str .."\r\n".."1"
                    NetworkManager:register(protocol_command.draw_endurance.code, nil, nil, nil, instance, responeCallBack, false, nil)
                else
                    TipDlg.drawTextDailog(_string_piece_info[325])
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_friend_list_change_page_terminal = {
            _name = "sm_friend_list_change_page",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                local currType = params._datas._type
                local page = instance.currPage + currType
                if page < 1 then
                    return
                end
                if page > instance.maxPage then
                    return
                end
                instance.currPage = page
                instance:onUpdateDraw()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_friend_list_update_other_info_terminal = {
            _name = "sm_friend_list_update_other_info",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:updateOtherInfo()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_friend_list_show_terminal)   
        state_machine.add(sm_friend_list_hide_terminal)
        state_machine.add(sm_friend_list_update_terminal)
        state_machine.add(sm_friend_list_request_refresh_terminal)
        state_machine.add(sm_friend_list_auto_give_food_terminal)
        state_machine.add(sm_friend_list_auto_recive_food_terminal)
        state_machine.add(sm_friend_list_change_page_terminal)
        state_machine.add(sm_friend_list_update_other_info_terminal)
        state_machine.init()
    end
    init_sm_friend_list_terminal()
end

function SmFriendList:onUpdateDraw()
    local root = self.roots[1]
    local ListView_01 = ccui.Helper:seekWidgetByName(root,"ListView_01")
    local Image_tip = ccui.Helper:seekWidgetByName(root,"Image_tip")
    ListView_01:jumpToTop()
    ListView_01:removeAllItems()
    local onePageNumber = dms.int(dms["friend_config"], 5, friend_config.param)
    for i, v in pairs(_ED.friend_info) do
        if i <= onePageNumber * self.currPage and i > onePageNumber * (self.currPage - 1) then
            local cell = state_machine.excute("sm_friend_cell", 0, {1, v})
            ListView_01:addChild(cell)
        end
    end
    ListView_01:requestRefreshView()

    Image_tip:setVisible(true)
    if tonumber(_ED.friend_number) > 0 then
        Image_tip:setVisible(false)
    end
    self:updateOtherInfo()
end

function SmFriendList:updateOtherInfo( ... )
    local root = self.roots[1]
    local Text_06_4 = ccui.Helper:seekWidgetByName(root,"Text_06_4")
    local Text_tili_receive_n = ccui.Helper:seekWidgetByName(root,"Text_tili_receive_n")
    local Text_page_n = ccui.Helper:seekWidgetByName(root,"Text_page_n")

    local onePageNumber = dms.int(dms["friend_config"], 5, friend_config.param)
    local max_friend_number = dms.int(dms["friend_config"], 1, friend_config.param)
    local max_draw_strength = zstring.split(dms.string(dms["friend_config"], 4, friend_config.param), ",")

    max_draw_strength = tonumber(max_draw_strength[1])
    self.maxPage = math.ceil(tonumber(_ED.friend_number)/onePageNumber)
    self.maxPage = math.max(self.maxPage, 1)
    Text_page_n:setString(self.currPage.."/"..self.maxPage)
    
    Text_tili_receive_n:setString((max_draw_strength - _ED.endurance_init_info.remain_times) .. "/" .. max_draw_strength)
    Text_06_4:setString(_ED.friend_number.."/"..max_friend_number)
end

function SmFriendList:onUpdate( dt )
    if self._list_view ~= nil then
        local size = self._list_view:getContentSize()
        local posY = self._list_view:getInnerContainer():getPositionY()
        if self._list_view_height == 0 then
            self._list_view_height = posY
        end
        if self._list_view_poy <= -30 then
            self._Image_arrow_down:setVisible(true)
        else
            self._Image_arrow_down:setVisible(false)
        end
        if self._list_view_poy >= self._list_view_height + 30 then
            self._Image_arrow_up:setVisible(true)
        else
            self._Image_arrow_up:setVisible(false)
        end
        if self._list_view_poy == posY then
            return
        end
        self._list_view_poy = posY
        local items = self._list_view:getItems()
        if items[1] == nil then
            return
        end
        local itemSize = items[1]:getContentSize()
        for i, v in pairs(items) do
            local tempY = v:getPositionY() + posY
            if tempY + itemSize.height * 2 < 0 or tempY > size.height + itemSize.height * 2 then
                v:unload()
            else
                v:reload()
            end
        end
    end
end

function SmFriendList:onInit(params)
    local csbItem = csb.createNode("friend/friend_friend.csb")
    self:addChild(csbItem)
    local root = csbItem:getChildByName("root")
    table.insert(self.roots, root)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_refresh"), nil, 
    {
        terminal_name = "sm_friend_list_request_refresh", 
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, nil, 1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_quickly_receive"), nil, 
    {
        terminal_name = "sm_friend_list_auto_recive_food", 
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, nil, 1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_quickly_give"), nil, 
    {
        terminal_name = "sm_friend_list_auto_give_food", 
        terminal_state = 0, 
        isPressedActionEnabled = true
    }, nil, 1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_flip_left"), nil, 
    {
        terminal_name = "sm_friend_list_change_page", 
        terminal_state = 0, 
        _type = -1,
        isPressedActionEnabled = true
    }, nil, 1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_flip_right"), nil, 
    {
        terminal_name = "sm_friend_list_change_page", 
        terminal_state = 0, 
        _type = 1,
        isPressedActionEnabled = true
    }, nil, 1)

    self.currPage = 1
    self:onUpdateDraw()
end

function SmFriendList:onEnterTransitionFinish()
end

function SmFriendList:init(params)
    self._rootWindows = params[1]
    self:onInit()
    return self
end

function SmFriendList:onExit()
    state_machine.remove("sm_friend_list_show")
    state_machine.remove("sm_friend_list_hide")
    state_machine.remove("sm_friend_list_update")
    state_machine.remove("sm_friend_list_request_refresh")
    state_machine.remove("sm_friend_list_auto_give_food")
    state_machine.remove("sm_friend_list_auto_recive_food")
    state_machine.remove("sm_friend_list_change_page")
    state_machine.remove("sm_friend_list_update_other_info")
end