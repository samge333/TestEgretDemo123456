-----------------------------
-- 试炼积分奖励界面
-----------------------------
SmTrialTowerReward = class("SmTrialTowerRewardClass", Window)

--打开界面
local sm_trial_tower_reward_open_terminal = {
	_name = "sm_trial_tower_reward_open",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if fwin:find("SmTrialTowerRewardClass") == nil then
			fwin:open(SmTrialTowerReward:new():init(params), fwin._ui)		
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

--关闭界面
local sm_trial_tower_reward_close_terminal = {
	_name = "sm_trial_tower_reward_close",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		fwin:close(fwin:find("SmTrialTowerRewardClass"))
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

state_machine.add(sm_trial_tower_reward_open_terminal)
state_machine.add(sm_trial_tower_reward_close_terminal)
state_machine.init()

function SmTrialTowerReward:ctor()
	self.super:ctor()
	self.roots = {}

    self.per = 0
    self._list_view_posY = 0
	app.load("client.l_digital.cells.campaign.sm_trial_tower_reward_list_cell")
    local function init_sm_trial_tower_reward_terminal()
        --
        local sm_trial_tower_reward_all_get_update_terminal = {
            _name = "sm_trial_tower_reward_all_get_update",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:allGetUpdate()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local sm_trial_tower_reward_show_all_info_terminal = {
            _name = "sm_trial_tower_reward_show_all_info",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:showAllInfo()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 滑动listView
        local arena_achieve_reward_slip_listView_terminal = {
            _name = "arena_achieve_reward_slip_listView",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local currType = params._datas._type
                if currType == 1 then
                    instance.per = instance.per - instance.page_per
                elseif currType == 2 then
                    instance.per = instance.per + instance.page_per  
                end
                instance.per = math.min(instance.per , 100)
                instance.per = math.max(instance.per , 0)
                if __lua_project_id == __lua_project_l_digital then
                    instance.currentListView:jumpToPercentVertical(instance.per)
                else
                    instance.currentListView:jumpToPercentHorizontal(instance.per)
                end
                instance.currentListView:refreshView()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_trial_tower_reward_all_get_update_terminal)
        state_machine.add(sm_trial_tower_reward_show_all_info_terminal)
        state_machine.add(arena_achieve_reward_slip_listView_terminal)
        state_machine.init()
    end
    init_sm_trial_tower_reward_terminal()
end

function SmTrialTowerReward:allGetUpdate( ... )
    local root = self.roots[1]
    --总收益
    local ListView_profit = ccui.Helper:seekWidgetByName(root,"ListView_profit")
    ListView_profit:removeAllItems()
    local reworldInfos = {}
    for i, v in pairs(_ED.user_try_highest_score_reward_state) do
        local reworldInfo = dms.string(dms["three_kingdoms_score_reward_param"], v, three_kingdoms_score_reward_param.rewards)
        local rewards = zstring.splits(reworldInfo, "|", ",")
        for r, m in pairs(rewards) do
            local key = m[1] .. m[2]
            if nil == reworldInfos[key] then
                reworldInfos[key] = m
            else
                local nCount = tonumber(reworldInfos[key][3]) + tonumber(m[3])
                reworldInfos[key][3] = "" .. nCount
            end
        end
    end

    for i, v in pairs(reworldInfos) do
        -- local cell = ResourcesIconCell:createCell()
        -- cell:init(v[1], v[3], v[2],nil,nil,nil,true,true)
        -- ListView_profit:addChild(cell)
        local cell = state_machine.excute("sm_item_icon_cell_create",0,{0,{v[1],v[2],v[3]},false,true,false,true})
        ListView_profit:addChild(cell)
    end
end

function SmTrialTowerReward:showAllInfo( ... )
    local root = self.roots[1]
    local Panel_chakan = ccui.Helper:seekWidgetByName(root,"Panel_chakan")
    Panel_chakan:setVisible(not Panel_chakan:isVisible())
    local Text_jifen_gs = ccui.Helper:seekWidgetByName(root,"Text_jifen_gs")
    local percent = dms.float(dms["play_config"], 54, play_config.param)
    local total = math.floor(tonumber(_ED.user_try_total_highest_integral) * percent) + tonumber(_ED.user_try_to_score_points)
    Text_jifen_gs:setString(total.."="..math.floor((tonumber(_ED.user_try_total_highest_integral) * percent)).."+".._ED.user_try_to_score_points)
end

function SmTrialTowerReward:updateDraw()
	local root = self.roots[1]
	local ListView_challenger = ccui.Helper:seekWidgetByName(root,"ListView_challenger")
	ListView_challenger:removeAllItems()
    self.cacheListView = ListView_challenger
    self.currentListView = self.cacheListView
    self.currentInnerContainer = self.cacheListView:getInnerContainer()
    self.currentInnerContainerPosX = self.currentInnerContainer:getPositionX()
    self.currentInnerContainerPosY = self.cacheListView:getInnerContainer():getPositionY()

    local rewardInfo = dms["three_kingdoms_score_reward_param"]

    local rewardIndex = 0
    local width = 0
    local height = 0
    for i = 1 , #rewardInfo do
        local cell = state_machine.excute("sm_trial_tower_reward_list_cell", 0, {i})
        if width == 0 then
            width = cell:getContentSize().width
        elseif height == 0 then
            height = cell:getContentSize().height
        end
        self.cacheListView:addChild(cell)
        if rewardIndex == 0 and _ED.user_try_highest_score_reward_state[""..i] == nil then
            rewardIndex = i
        end
    end
    self.cacheListView:requestRefreshView()
    if __lua_project_id == __lua_project_l_digital then
        if rewardIndex == #rewardInfo or rewardIndex == (#rewardInfo - 1) then
            rewardIndex = #rewardInfo - 2
        end
    end
    self.per = rewardIndex * 100 / (#rewardInfo)
    self.page_per = 2 * 100 / (#rewardInfo)

    --历史最大积分
    local Text_my_jifen = ccui.Helper:seekWidgetByName(root,"Text_my_jifen")
    local percent = dms.float(dms["play_config"], 54, play_config.param)
    local total = math.floor(tonumber(_ED.user_try_total_highest_integral) * percent) + tonumber(_ED.user_try_to_score_points)
    Text_my_jifen:setString("" .. total)

    self:allGetUpdate()

    if __lua_project_id == __lua_project_l_digital then
        self:runAction(cc.Sequence:create({cc.DelayTime:create(0.01), cc.CallFunc:create(function ( sender )
            listviewPositioningMoves(self.cacheListView, rewardIndex)
            self.cacheListView:requestRefreshView()
        end)}))
    else
        self:runAction(cc.Sequence:create({cc.DelayTime:create(0.05), cc.CallFunc:create(function ( sender )
            if rewardIndex == 1 then
                sender.currentInnerContainer:setPositionX(-1)
            else
                sender.currentInnerContainer:setPositionX(-width * (rewardIndex - 1))
            end
            sender.cacheListView:requestRefreshView()
        end)}))
    end
end

function SmTrialTowerReward:onUpdate(dt)
    if __lua_project_id == __lua_project_l_digital then
        if self.currentListView ~= nil and self.currentInnerContainer ~= nil then
            local size = self.currentListView:getContentSize()
            local posY = self.currentInnerContainer:getPositionY()
            
            if self._list_view_posY == 0 then
                self._list_view_posY = posY
            end

            if self.right_button ~= nil then
                if self._list_view_posY < -30 then 
                    self.right_button:setVisible(true)
                else
                    self.right_button:setVisible(false)
                end
                if self._list_view_posY >= size.height - self.currentListView:getInnerContainer():getContentSize().height + 30 then
                    self.left_button:setVisible(true)
                else
                    self.left_button:setVisible(false)
                end
            end
            self._list_view_posY = posY
            
            if self.currentInnerContainerPosY == posY then
                return
            end
            self.currentInnerContainerPosY = posY
            local items = self.currentListView:getItems()
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

         
    else
        if self.currentListView ~= nil and self.currentInnerContainer ~= nil then
            local size = self.currentListView:getContentSize()
            local posX = self.currentInnerContainer:getPositionX()
            if self.currentInnerContainerPosX == posX then
                return
            end
            local items = self.currentListView:getItems()
            if items[1] == nil then
                return
            end
            self.currentInnerContainerPosX = posX
            local itemSize = items[1]:getContentSize()
            for i, v in pairs(items) do
                local tempX = v:getPositionX() + posX
                if tempX + itemSize.width/2 < 0 or tempX > size.width + itemSize.width / 2 then
                    v:unload()
                else
                    v:reload()
                end
            end
        end
    end
end

function SmTrialTowerReward:init(params)
	self:onInit()
    return self
end

function SmTrialTowerReward:onInit()
    local csbItem = csb.createNode("campaign/TrialTower/sm_trial_tower_reward.csb")
    local root = csbItem:getChildByName("root")
    self:addChild(csbItem)
    table.insert(self.roots, root)

	--关闭
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_back"), nil, 
    {
        terminal_name = "sm_trial_tower_reward_close", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 3)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_chakan"), nil, 
    {
        terminal_name = "sm_trial_tower_reward_show_all_info", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 3)

    if __lua_project_id == __lua_project_l_digital then
        self.left_button = ccui.Helper:seekWidgetByName(root, "Button_arrow_l")
        self.right_button = ccui.Helper:seekWidgetByName(root, "Button_arrow_r")
        --左滑
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_arrow_l"),nil, 
        {
            terminal_name = "arena_achieve_reward_slip_listView",           
            terminal_state = 0,
            _type = 1, 
            isPressedActionEnabled = true
        }, 
        nil, 0)

        --右滑
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_arrow_r"),nil, 
        {
            terminal_name = "arena_achieve_reward_slip_listView",           
            terminal_state = 0, 
            _type = 2,
            isPressedActionEnabled = true
        }, 
        nil, 0)
    end
    
	self:updateDraw()
end

function SmTrialTowerReward:onEnterTransitionFinish()
    
end


function SmTrialTowerReward:onExit()
    state_machine.remove("sm_trial_tower_reward_all_get_update")
    state_machine.remove("sm_trial_tower_reward_show_all_info")
    state_machine.remove("arena_achieve_reward_slip_listView")
end

