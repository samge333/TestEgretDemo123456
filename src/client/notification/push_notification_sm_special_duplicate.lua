-- Initialize push notification center state machine.
local function init_push_notification_center_sm_special_duplicate_terminal()
	--数码首页特殊副本推送
    local push_notification_center_sm_special_duplicate_all_terminal = {
        _name = "push_notification_center_sm_special_duplicate_all",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSmSpecialDuplicateAllTips(params) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(1, 1))
					ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
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
    --数码净化推送
    local push_notification_center_sm_purify_duplicate_terminal = {
        _name = "push_notification_center_sm_purify_duplicate",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSmPurifyDuplicateTips(params) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.5))
					ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
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

    --数码试炼奖励
    local push_notification_center_sm_trial_tower_reward_terminal = {
        _name = "push_notification_center_sm_trial_tower_reward",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSmTrialTowerRewardTips(params) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.5))
					ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
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
    
    state_machine.add(push_notification_center_sm_special_duplicate_all_terminal)
    state_machine.add(push_notification_center_sm_purify_duplicate_terminal)
    state_machine.add(push_notification_center_sm_trial_tower_reward_terminal)
    state_machine.init()
end
init_push_notification_center_sm_special_duplicate_terminal()

function getSmSpecialDuplicateAllTips(notificationer)
	if getSmPurifyDuplicateTips() == true then
		return true
	end
	if getSmTrialTowerRewardTips() == true then
		return true
	end
	return false
end

function getSmPurifyDuplicateTips(notificationer)
    if funOpenDrawTip(93, false) == true then
    	return false
    end

    if _ED.digital_purify_info == nil then
    	protocol_command.ship_purify_init.param_list = ""
        NetworkManager:register(protocol_command.ship_purify_init.code, nil, nil, nil, nil, nil, false, nil)
    	return false
    end	
    if _ED.digital_purify_info ~= nil 
        and _ED.digital_purify_info._team_info ~= nil 
        and next(_ED.digital_purify_info._team_info) == nil
        then
        return true
    end
    if _ED.digital_purify_info ~= nil 
    	and _ED.digital_purify_info._team_info ~= nil 
    	and _ED.digital_purify_info._team_info.team_type ~= nil
    	and _ED.digital_purify_info._team_info.team_type >= 0 
    	then
    	local user_info = nil
    	for k, v in pairs(_ED.digital_purify_info._team_info.members) do
    		if tonumber(v.user_id) == tonumber(_ED.user_info.user_id) then
    			user_info = v
    			break
    		end
    	end
    	if user_info ~= nil then
    		local complete_count = tonumber(user_info.complete_count)
    		local max_count = tonumber(zstring.split(dms.string(dms["play_config"], 20, play_config.param), ",")[2])
    		if complete_count < max_count then
    			return true
    		end
    	end
    end
    return false
end

function getSmTrialTowerRewardTips(notificationer)
	if funOpenDrawTip(92, false) == true then
    	return false
    end
    if _ED.user_try_highest_score_reward_state == nil then
    	protocol_command.three_kingdoms_init.param_list = ""
        NetworkManager:register(protocol_command.three_kingdoms_init.code, nil, nil, nil, nil, nil, false, nil)
    	return false
    end	

	if _ED.user_try_highest_score_reward_state ~= nil then
		for i = 1, dms.count(dms["three_kingdoms_score_reward_param"]) do
			if _ED.user_try_highest_score_reward_state[""..i] == nil then
				local integral = dms.int(dms["three_kingdoms_score_reward_param"], i, three_kingdoms_score_reward_param.need_integral)
				if integral <= zstring.tonumber(_ED.user_try_highest_integral) then
					return true
				else
					return false
				end
			end
		end
	end
    return false
end
