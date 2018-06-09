--------------------------------------------------------------------------------------------------------------
--  招募奖励预览
--------------------------------------------------------------------------------------------------------------
SmRecruitPreviewWindowTab = class("SmRecruitPreviewWindowTabClass", Window)

--打开界面
local sm_recruit_preview_window_tab_open_terminal = {
    _name = "sm_recruit_preview_window_tab_open",
    _init = function (terminal)
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        local panel = fwin:open(SmRecruitPreviewWindowTab:new():init(params), fwin._ui)  
        return panel
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_recruit_preview_window_tab_open_terminal)
state_machine.init()

function SmRecruitPreviewWindowTab:ctor()
    self.super:ctor()
    self.roots = {}
    self.actions = {}

    self._cell_group = {}
    self._cell_size = nil
    self._scroll_view = nil
    self._scroll_view_posy = 0

    app.load("client.l_digital.cells.shop.sm_recruit_preview_window_ship_cell")
    app.load("client.l_digital.cells.shop.sm_recruit_preview_window_prop_cell")
    
    -- 初始化状态机
    local function init_sm_recruit_preview_window_tab_terminal()
        local sm_recruit_preview_window_tab_show_terminal = {
            _name = "sm_recruit_preview_window_tab_show",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local panel = params
                if panel ~= nil and panel.roots ~= nil and panel.roots[1] ~= nil then
                    panel:setVisible(true)
                    panel:updateDraw()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_recruit_preview_window_tab_hide_terminal = {
            _name = "sm_recruit_preview_window_tab_hide",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local panel = params
                if panel ~= nil and panel.roots ~= nil and panel.roots[1] ~= nil then
                    panel:setVisible(false)
                    local root = panel.roots[1]
                    local ScrollView_yulan_1 = ccui.Helper:seekWidgetByName(root,"ScrollView_yulan_1")
                    ScrollView_yulan_1:removeAllChildren(true)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 刷新
        local sm_recruit_preview_window_tab_update_draw_terminal = {
            _name = "sm_recruit_preview_window_tab_update_draw",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local panel = params
                if panel ~= nil and panel.roots ~= nil and panel.roots[1] ~= nil then
                    panel:updateDraw()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_recruit_preview_window_tab_update_draw_terminal)
        state_machine.add(sm_recruit_preview_window_tab_hide_terminal)
        state_machine.add(sm_recruit_preview_window_tab_show_terminal)
        state_machine.init()
    end
    
    init_sm_recruit_preview_window_tab_terminal()
end

function SmRecruitPreviewWindowTab:updateDraw()
    local root = self.roots[1]

    local ScrollView_yulan_1 = ccui.Helper:seekWidgetByName(root,"ScrollView_yulan_1")
    ScrollView_yulan_1:removeAllChildren(true)

    local result = {}
    local ship_table = {}
    local prop_table = {}
    local other_table = {}
    for k, v in pairs(self._rewards) do
        if tonumber(v.prop_type) == 13 then
            local camp_preference = dms.int(dms["ship_mould"], v.mould_id, ship_mould.camp_preference)
            if self._prop_type == 1 then
                table.insert(ship_table, v)
            elseif self._prop_type == camp_preference + 1 then
                table.insert(ship_table, v)
            end
        elseif tonumber(v.prop_type) == 6 then
            local storage_page_index = dms.int(dms["prop_mould"], v.mould_id, prop_mould.storage_page_index)
            local prop_id = tonumber(zstring.split(dms.string(dms["activity_config"], 14, activity_config.param), ",")[1])  -- 觉醒合金id
            if self._prop_type == 5 
                or self._prop_type == 6 
                or (self._prop_type == 7 and storage_page_index == 16 and v.mould_id ~= prop_id)
                or (self._prop_type == 8 and (storage_page_index ~= 16 or v.mould_id == prop_id))
                then
                table.insert(prop_table, v)
            end
        else
            if self._prop_type == 5 or self._prop_type == 6 or self._prop_type == 8 then
                table.insert(other_table, v)
            end
        end
    end

    -- 排序
    local function sortShip(a, b)
        if a.order > b.order or (a.order == b.order and tonumber(a.mould_id < b.mould_id)) then
            return true
        end
        return false 
    end

    local function sortProp(a, b)
        return a.order < b.order
    end

    table.sort(ship_table, sortShip)
    table.sort(prop_table, sortProp)

    for k, v in pairs(ship_table) do
        table.insert(result, v)
    end
    for k, v in pairs(prop_table) do
        table.insert(result, v)
    end
    for k, v in pairs(other_table) do
        table.insert(result, v)
    end

    local cell_size = nil
    local cell_group = {}

    for k, v in pairs(result) do
        local cell = nil
        if self._prop_type >= 5 then
            cell = state_machine.excute("sm_recruit_preview_window_prop_cell_create", 0, {k, v})
        else
            cell = state_machine.excute("sm_recruit_preview_window_ship_cell_create", 0, {k, v})
        end
        ScrollView_yulan_1:addChild(cell)
        table.insert(cell_group, cell)

        if cell_size == nil then
            cell_size = cell:getContentSize()
        end
    end

    local width = ScrollView_yulan_1:getContentSize().width
    local height = ScrollView_yulan_1:getContentSize().height
    local count = #result
    local row_count = 4
    if self._prop_type >= 5 then
        row_count = 5
    end
    local col_count = math.ceil(count / row_count)

    if count > 0 then
        if cell_size.height * col_count > height then
            height = cell_size.height * col_count
        end
        ScrollView_yulan_1:getInnerContainer():setContentSize(cc.size(width, height))

        for i = 1, count do
            local row = math.floor((i - 1) % row_count)
            local col = math.floor((i - 1) / row_count)
            local cell = cell_group[i]
            cell:setAnchorPoint(cc.p(0,1))
            cell:setPosition(cc.p(row * (width / row_count), height - col * cell_size.height))
        end
    end

    ScrollView_yulan_1:jumpToTop()

    self._scroll_view = ScrollView_yulan_1
    self._scroll_view_posy = self._scroll_view:getInnerContainer():getPositionY()
    self._cell_group = cell_group
    self._cell_size = cell_size
end

function SmRecruitPreviewWindowTab:onUpdate(dt)
    if self._scroll_view ~= nil then
        local posY = self._scroll_view:getInnerContainer():getPositionY()
        if posY == self._scroll_view_posy then
            return
        end
        self._scroll_view_posy = posY

        local size = self._scroll_view:getContentSize()
        local items = self._cell_group
        local itemSize = self._cell_size
        for i, v in pairs(items) do
            if v ~= nil then
                local tempY = v:getPositionY() + posY
                if tempY + itemSize.height < 0 or tempY > size.height + itemSize.height then
                    v:unload()
                else
                    v:reload()
                end
            end
        end
    end
end

--初始化
function SmRecruitPreviewWindowTab:onInit()
    local csbItem = csb.createNode("shop/sm_recruit_preview_window_tab_1.csb") 
    self:addChild(csbItem)
    local root = csbItem:getChildByName("root")
    table.insert(self.roots, root)  

    self:updateDraw()
end

function SmRecruitPreviewWindowTab:onEnterTransitionFinish()

end

function SmRecruitPreviewWindowTab:init(params)
    self._rootWindows = params[1]
    self._from_type = params[2]         -- 1:金币奖励预览，2：钻石奖励预览，3：装备宝箱
    self._prop_type = params[3]         -- 道具类型：1-4：数码兽，5,6：装备、道具,7：装备,8:道具
    self._rewards = params[4]           -- 
    self:onInit()
    return self
end

function SmRecruitPreviewWindowTab:onExit()
    -- 移除状态机
end