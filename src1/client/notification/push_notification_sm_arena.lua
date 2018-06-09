-- Initialize push notification center state machine.
local function init_push_notification_center_sm_arena_terminal()
	--数码首页竞技场的推送
    local push_notification_center_sm_arena_all_terminal = {
        _name = "push_notification_center_sm_arena_all",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSmCampaignAllTips(params) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(1, 1))
					ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))	
					params._widget:addChild(ball)
					params._widget._nodeChild = ball
					params._widget._istips = true
				end
			else
				if params._widget._istips == true then
					params._widget:removeChild(params._widget._nodeChild, true)
					params._widget._nodeChild = nil
					params._widget._istips = false
				end
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --数码竞技场标签页的推送
    local push_notification_center_sm_arena_page_tip_terminal = {
        _name = "push_notification_center_sm_arena_page_tip",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
            if getSmArenaAllTips(params) == true then
                if params._widget._istips == nil or params._widget._istips == false then
                    local ball = cc.Sprite:create("images/ui/bar/tips.png")
                    ball:setAnchorPoint(cc.p(1, 1))
                    ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height)) 
                    params._widget:addChild(ball)
                    params._widget._nodeChild = ball
                    params._widget._istips = true
                end
            else
                if params._widget._istips == true then
                    params._widget:removeChild(params._widget._nodeChild, true)
                    params._widget._nodeChild = nil
                    params._widget._istips = false
                end
            end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }
    --数码竞技场成就推送
    local push_notification_center_sm_arena_achieve_terminal = {
        _name = "push_notification_center_sm_arena_achieve",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSmArenaAchieveTips(params) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(1, 1))
					ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))	
					params._widget:addChild(ball)
					params._widget._nodeChild = ball
					params._widget._istips = true
				end
			else
				if params._widget._istips == true then
					params._widget:removeChild(params._widget._nodeChild, true)
					params._widget._nodeChild = nil
					params._widget._istips = false
				end
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }
    --数码竞技场积分推送
    local push_notification_center_sm_arena_point_terminal = {
        _name = "push_notification_center_sm_arena_point",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSmArenaPointTips(params) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(1, 1))
					ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))	
					params._widget:addChild(ball)
					params._widget._nodeChild = ball
					params._widget._istips = true
				end
			else
				if params._widget._istips == true then
					params._widget:removeChild(params._widget._nodeChild, true)
					params._widget._nodeChild = nil
					params._widget._istips = false
				end
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --数码竞技场战报推送
    local push_notification_center_sm_war_report_panel_terminal = {
        _name = "push_notification_center_sm_war_report_panel",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
            if getSmWarReportPanel(params) == true then
                if params._widget._istips == nil or params._widget._istips == false then
                    local ball = cc.Sprite:create("images/ui/bar/tips.png")
                    ball:setAnchorPoint(cc.p(1, 1))
                    ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))   
                    params._widget:addChild(ball)
                    params._widget._nodeChild = ball
                    params._widget._istips = true
                end
            else
                if params._widget._istips == true then
                    params._widget:removeChild(params._widget._nodeChild, true)
                    params._widget._nodeChild = nil
                    params._widget._istips = false
                end
            end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --王者之战推送
    local push_notification_center_sm_battle_of_kings_all_terminal = {
        _name = "push_notification_center_sm_battle_of_kings_all",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
            if getSmBattleOfKingsAllTips(params) == true then
                if params._widget._istips == nil or params._widget._istips == false then
                    local ball = cc.Sprite:create("images/ui/bar/tips.png")
                    ball:setAnchorPoint(cc.p(1, 1))
                    ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))   
                    params._widget:addChild(ball)
                    params._widget._nodeChild = ball
                    params._widget._istips = true
                end
            else
                if params._widget._istips == true then
                    params._widget:removeChild(params._widget._nodeChild, true)
                    params._widget._nodeChild = nil
                    params._widget._istips = false
                end
            end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --王者之战下注推送
    local push_notification_center_sm_battle_of_kings_betting_terminal = {
        _name = "push_notification_center_sm_battle_of_kings_betting",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
            if getSmBattleOfKingsBetTips(params) == true then
                if params._widget._istips == nil or params._widget._istips == false then
                    local ball = cc.Sprite:create("images/ui/bar/tips.png")
                    ball:setAnchorPoint(cc.p(1, 1))
                    ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))   
                    params._widget:addChild(ball)
                    params._widget._nodeChild = ball
                    params._widget._istips = true
                end
            else
                if params._widget._istips == true then
                    params._widget:removeChild(params._widget._nodeChild, true)
                    params._widget._nodeChild = nil
                    params._widget._istips = false
                end
            end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    -- 竞技-工会战推送
    local push_notification_center_sm_union_battle_terminal = {
        _name = "push_notification_center_sm_union_battle",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
            if smUnionPushUnionBattle() == true or smUnionPushUnionBattleStake() == true then
                if params._widget._istips == nil or params._widget._istips == false then
                    local ball = cc.Sprite:create("images/ui/bar/tips.png")
                    ball:setAnchorPoint(cc.p(1, 1))
                    ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))   
                    params._widget:addChild(ball)
                    params._widget._nodeChild = ball
                    params._widget._istips = true
                end
            else
                if params._widget._istips == true then
                    params._widget:removeChild(params._widget._nodeChild, true)
                    params._widget._nodeChild = nil
                    params._widget._istips = false
                end
            end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    state_machine.add(push_notification_center_sm_arena_all_terminal)
    state_machine.add(push_notification_center_sm_arena_achieve_terminal)
    state_machine.add(push_notification_center_sm_arena_point_terminal)
    state_machine.add(push_notification_center_sm_arena_page_tip_terminal)
    state_machine.add(push_notification_center_sm_war_report_panel_terminal)
    state_machine.add(push_notification_center_sm_battle_of_kings_all_terminal)
    state_machine.add(push_notification_center_sm_battle_of_kings_betting_terminal)
    state_machine.add(push_notification_center_sm_union_battle_terminal)
    state_machine.init()
end
init_push_notification_center_sm_arena_terminal()

function getSmCampaignAllTips()
    if getSmArenaAllTips() == true then
        return true
    end
    if getSmBattleOfKingsAllTips() == true then
        return true
    end

    if smUnionPushUnionBattle() == true then
        return true
    end

    if smUnionPushUnionBattleStake() == true then
        return true
    end

    return false
end
-- 竞技场
function getSmArenaAllTips(notificationer)
	local arena_grade=dms.int(dms["fun_open_condition"], 79, fun_open_condition.level)
    if arena_grade <= zstring.tonumber(_ED.user_info.user_grade) then
    	if _ED._is_recharge_push_expedition == false then
    		local function responseArenaInitCallTipsback(response)
				if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                    if getBattleNumber() == true then
                        return true
                    end
					if getSmArenaAchieveTips() == true then
						return true
					end
					if getSmArenaPointTips() == true then
						return true
					end
                    if getSmWarReportPanel() == true then
                        return true
                    end
				end
			end
			_ED._is_recharge_push_expedition = true
			protocol_command.arena_init.param_list = "0"
			NetworkManager:register(protocol_command.arena_init.code, nil, nil, nil, nil, responseArenaInitCallTipsback, false, nil)
        else
            if getBattleNumber() == true then
                return true
            end
            if getSmArenaAchieveTips() == true then
                return true
            end
            if getSmArenaPointTips() == true then
                return true
            end
            if getSmWarReportPanel() == true then
                return true
            end
		end
	end
	return false
end

function getBattleNumber()
    if nil ~= _ED.user_launch_battle_cd and _ED.user_launch_battle_cd > 0 then
        local interval = _ED.user_launch_battle_cd / 1000 - (_ED.system_time + (os.time() - _ED.native_time))
        if interval > 0 then
            return false
        else
            if zstring.tonumber(_ED.arena_user_remain) > 0 then
                return true
            else
                return false
            end
        end
    else
        if zstring.tonumber(_ED.arena_user_remain) > 0 then
            return true
        else
            return false
        end
    end
    return false
end

function getSmArenaAchieveTips(notificationer)
	local myMaxPoint = tonumber(_ED.user_arena_max_order)
    if myMaxPoint ~= nil then
    	local rewardInfo = dms["arena_welfare"]
    	for i = 1 , #rewardInfo do
            local reward_target = dms.atoi(rewardInfo[i],arena_welfare.rank_target)
            local haveReward = false
            if myMaxPoint <= tonumber(reward_target) then
                for j , w in pairs(_ED.user_arena_order_reward_draw_state) do 
                    if i == tonumber(w) then
                        haveReward = true
                    end
                end
                if haveReward == false then
                    return true
                end
            end
        end
    end
    return false
end
function getSmArenaPointTips(notificationer)
	local myPoint = tonumber(_ED.user_arena_score)
    if myPoint ~= nil then
    	local rewardInfo = dms["arena_score"]
    	for i = 1 , #rewardInfo do
            local reward_target = dms.atoi(rewardInfo[i] ,arena_score.point_target)
            local haveReward = false
            if myPoint >= tonumber(reward_target) then
                for j , w in pairs(_ED.user_arena_order_score_draw_state) do 
                    if i == tonumber(w) then
                        haveReward = true
                    end
                end
                if haveReward == false then
                    return true
                end
            end
        end
    end
    return false
end

function getSmWarReportPanel(notificationer)
    local isOver = false
    if _ED.city_resource_battle_report == nil or _ED.city_resource_battle_report[11] == nil then
        -- local function responseReportCallback(response)
        --     if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
        --         if _ED.city_resource_battle_report ~= nil and _ED.city_resource_battle_report[11] ~= nil then
        --             state_machine.excute("notification_center_update", 0, "push_notification_center_sm_arena_all")
        --             state_machine.excute("notification_center_update", 0, "push_notification_center_sm_war_report_panel")
        --         end
        --     else
                isOver = false
        --     end
        -- end
        -- protocol_command.battlefield_report_get.param_list = 11
        -- NetworkManager:register(protocol_command.battlefield_report_get.code, nil, nil, nil, nil, responseReportCallback, false, nil)
    else
        if _ED.city_resource_battle_report[11] ~= nil then
            local report_info = cc.UserDefault:getInstance():getStringForKey(getKey("push_sm_war_report_ids"))
            if report_info == nil then
                report_info = ""
            end
            local report_ids = zstring.split(report_info, ",")
            for i, v in pairs(_ED.city_resource_battle_report[11]) do
                local report_time = tonumber(v.time)
                local is_new_report = true
                local defendId = zstring.split(v.param, ",")[6]
                if tonumber(defendId) == tonumber(_ED.user_info.user_id) then
                    for k, w in pairs(report_ids) do
                        if w ~= "" and report_time == tonumber(w) then
                            is_new_report = false
                            break
                        end
                    end
                    if is_new_report == true then
                        isOver = true
                        break
                    end
                end
            end
        end
    end
    return isOver
end

-- 王者之战
function getSmBattleOfKingsAllTips()
    if funOpenDrawTip(81, false) == true then
        return false
    end

    if getSmBattleOfKingsBetTips() == true then
        return true
    end

    if getSmBattleOfKingsSignTips() == true then
        return true
    end

    return false
end

-- 王者之战下注推送
function getSmBattleOfKingsBetTips()
    if _ED.kings_battle == nil or _ED.kings_battle.kings_battle_open_type == nil then
        protocol_command.the_kings_battle_init.param_list = ""
        NetworkManager:register(protocol_command.the_kings_battle_init.code, nil, nil, nil, nil, nil, false, nil)
        return false
    end

    if tonumber(_ED.kings_battle.kings_battle_open_type) ~= 0
        and tonumber(_ED.kings_battle.kings_battle_open_type) ~= 4
        then

        if _ED.battle_kings_score_rank == nil or _ED.battle_kings_score_rank.other_user == nil then
            local function responseCallback(response)
                if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                    if _ED.kings_battle.kings_battle_betting == "0,0" and #_ED.battle_kings_score_rank.other_user > 1 then
                        return true
                    end
                end
            end
            protocol_command.order_get_info.param_list = "7".."\r\n".."1".."\r\n".."20"
            NetworkManager:register(protocol_command.order_get_info.code, nil, nil, nil, nil, responseCallback, false, nil)
        else
            if _ED.kings_battle.kings_battle_betting == "0,0" and #_ED.battle_kings_score_rank.other_user > 1 then
                return true
            end
        end
    end
    return false
end

-- 王者之战报名推送
function getSmBattleOfKingsSignTips()
    if _ED.kings_battle == nil or _ED.kings_battle.kings_battle_open_type == nil then
        protocol_command.the_kings_battle_init.param_list = ""
        NetworkManager:register(protocol_command.the_kings_battle_init.code, nil, nil, nil, nil, nil, false, nil)
        return false
    end

    if tonumber(_ED.kings_battle.kings_battle_open_type) ~= 0
        and tonumber(_ED.kings_battle.kings_battle_open_type) ~= 4
        then
        if tonumber(_ED.kings_battle.kings_battle_type) == 0 then
            return true
        end
    end
    return false
end
