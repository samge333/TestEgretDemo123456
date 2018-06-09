
SmOtherRecruitActivity = class("SmOtherRecruitActivityClass", Window)

local sm_other_recruit_activity_open_terminal = {
	_name = "sm_other_recruit_activity_open",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if fwin:find("SmOtherRecruitActivityClass") == nil then
			fwin:open(SmOtherRecruitActivity:new():init(params), fwin._ui)		
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

local sm_other_recruit_activity_close_terminal = {
	_name = "sm_other_recruit_activity_close",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		fwin:close(fwin:find("SmOtherRecruitActivityClass"))
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

state_machine.add(sm_other_recruit_activity_open_terminal)
state_machine.add(sm_other_recruit_activity_close_terminal)
state_machine.init()

function SmOtherRecruitActivity:ctor()
	self.super:ctor()
	self.roots = {}
	self._text_time = nil
	self._tick_time = 0

    app.load("client.l_digital.activity.wonderful.SmOtherRecruitList")
    app.load("client.l_digital.activity.wonderful.SmOtherRecruitReward")
    app.load("client.l_digital.activity.wonderful.SmOtherRecruitSelected")
    app.load("client.shop.recruit.HeroRecruitSuccess")
    app.load("client.l_digital.cells.activity.wonderful.sm_activity_other_recruit_cell")

    local function init_sm_other_recruit_activity_terminal()
        local sm_other_recruit_activity_update_draw_terminal = {
            _name = "sm_other_recruit_activity_update_draw",
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

        local sm_other_recruit_activity_recruiting_terminal = {
            _name = "sm_other_recruit_activity_recruiting",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local index = params._datas.index
                local activity = _ED.active_activity[114]
                if activity == nil then
                    return
                end
                state_machine.lock("sm_other_recruit_activity_recruiting")
                -- local info = zstring.split(activity.need_recharge_count, ",")[index]
                -- local cost = tonumber(zstring.split(info, "-")[3])
                local function responseCallback(response)
                    if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                        if __lua_project_id == __lua_project_l_digital 
                        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                        then
                            getSceneReward(7)
                            _ED.show_reward_list_group_ex = {}
                        end
                        state_machine.excute("sm_other_recruit_reward_open", 0, {index})
                    end
                    state_machine.unlock("sm_other_recruit_activity_recruiting")
                end
                protocol_command.get_activity_reward.param_list = activity.activity_id.."\r\n"..(index - 1).."\r\n0"
                NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, instance, responseCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_other_recruit_activity_update_draw_terminal)
        state_machine.add(sm_other_recruit_activity_recruiting_terminal)
        state_machine.init()
    end
    init_sm_other_recruit_activity_terminal()
end

function SmOtherRecruitActivity:onUpdateDraw()
    local root = self.roots[1]
    local activity_info = _ED.active_activity[114]
    -- 1-11-400,12-22-2000,23-33-2000@5连保底次数@模式@需要等级,需要vip等级,图片id,卡牌1预览id,卡牌2预览id,卡牌3预览id,卡牌4预览id,卡牌n预览id
    -- 1-11-400,12-22-2000,23-33-2000@5@1@1,2,1,19,14,15,16,17,18
    local info = zstring.split(activity_info.need_recharge_count, "@")
    local mode = tonumber(info[3])
    info = zstring.split(info[4], ",")
    self._text_time = ccui.Helper:seekWidgetByName(root, "Text_time_0")
    local Panel_head = ccui.Helper:seekWidgetByName(root, "Panel_head")
    local Panel_name = ccui.Helper:seekWidgetByName(root, "Panel_name")
    Panel_head:removeBackGroundImage()
    Panel_head:setBackGroundImage(string.format("images/ui/text/sm_hd/sslx/sslx_head_%s.png", info[3]))
    Panel_name:removeBackGroundImage()
    Panel_name:setBackGroundImage(string.format("images/ui/text/sm_hd/sslx/sslx_name_%s.png", info[3]))
    local ScrollView_props = ccui.Helper:seekWidgetByName(root, "ScrollView_props")
    ScrollView_props:removeAllChildren(true)

    local total = #info - 3
    local onceWidth = ScrollView_props:getContentSize().width/total
    for i=4,#info do
    	local mouldId = tonumber(zstring.split(info[i], "-")[1])
    	local cell = ResourcesIconCell:createCell()
	    cell:init(13, 1, mouldId, nil, nil, false, false, 0)
		cell:updateStarInfo(nil)
		ScrollView_props:addChild(cell)
		cell:setPosition(cc.p((i - 4) * onceWidth + (onceWidth - cell:getContentSize().width)/2, 0))
		cell:onDrawIconPad2(5)
		if i == 4 then
			cell:setScale(1.2)
			cell:setPosition(cc.p(cell:getPositionX() - cell:getContentSize().width * 0.2, cell:getPositionY()))
		elseif (mode == 2 and i == #info) then
			-- cell:setAnchorPoint(cc.p(1, 0))
			cell:setScale(1.2)
			-- cell:setPosition(cc.p(cell:getPositionX() + cell:getContentSize().width * 1.2, cell:getPositionY()))
		end
    end
	self._tick_time = zstring.tonumber(activity_info.end_time)/1000 - (os.time() + _ED.time_add_or_sub)
	self._text_time:setString(getRedAlertTimeActivityFormat(self._tick_time))
end

function SmOtherRecruitActivity:onUpdate(dt)
    if self._text_time ~= nil and self._tick_time > 0 then 
        self._tick_time = self._tick_time - dt
        self._text_time:setString(getRedAlertTimeActivityFormat(self._tick_time))
    end
end

function SmOtherRecruitActivity:init(params)
	self:onInit()
    return self
end

function SmOtherRecruitActivity:onInit()
    local csbItem = csb.createNode("activity/wonderful/sm_vip_chouka.csb")
    local root = csbItem:getChildByName("root")
    self:addChild(csbItem)
    table.insert(self.roots, root)

    local action = csb.createTimeline("activity/wonderful/sm_vip_chouka.csb")
   	action:gotoFrameAndPlay(0, action:getDuration(), false)
    csbItem:runAction(action)

    local Panel_34 = ccui.Helper:seekWidgetByName(root,"Panel_34")
    local startAnimation = Panel_34:getChildByName("ArmatureNode_2")
    draw.initArmature(startAnimation, nil, -1, 0, 1)
    csb.animationChangeToAction(startAnimation, 0, 0, false)
    startAnimation._invoke = function(armatureBack)
        if armatureBack:getParent() ~= nil and armatureBack.setVisible ~= nil then
            armatureBack:setVisible(false)
        end
    end

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_shop_back"), nil, 
    {
        terminal_name = "sm_other_recruit_activity_close", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 3)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_yulan"), nil, 
    {
        terminal_name = "sm_other_recruit_list_open",
        terminal_state = 0,
        touch_black = true,
    },
    nil,1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_buy_5"), nil, 
    {
        terminal_name = "sm_other_recruit_activity_recruiting",
        terminal_state = 0,
        touch_black = true,
        index = 2,
    },
    nil,1)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_buy_1"), nil, 
    {
        terminal_name = "sm_other_recruit_activity_recruiting",
        terminal_state = 0,
        touch_black = true,
        index = 1,
    },
    nil,1)

    self:onUpdateDraw()
end

function SmOtherRecruitActivity:onEnterTransitionFinish()
end

function SmOtherRecruitActivity:onExit()
	state_machine.remove("sm_other_recruit_activity_update_draw")
	state_machine.remove("sm_other_recruit_activity_recruiting")
end

