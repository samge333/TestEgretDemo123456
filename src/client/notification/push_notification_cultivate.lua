-- Initialize push notification center state machine.
-- 养成的推送
push_notification_cultivate_count = 0	  -- 首页养成
push_notification_cultivate_spirit_count = 0	  -- 数码精神
push_notification_cultivate_talent_count = 0	  -- 数码天赋

local function init_push_notification_cultivate_terminal()

	local push_notification_home_cultivate_terminal = {
		_name = "push_notification_home_cultivate",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
		_invoke = function(terminal, instance, params)
			local count = 0
			count = getCultivatePush()
			local isChange = false
	        if count ~= push_notification_cultivate_count then
	        	isChange = true
	        end
	        push_notification_cultivate_count = count

	        if count > 0 or getCultivateArtifactPush() == true or getCultivateAchievePush == true then
				if isChange == true then
					if params._widget._istips == true then
						params._widget:removeChild(params._widget._nodeChild, true)
						params._widget._nodeChild = nil
						params._widget._istips = false
					end
				else
				end
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

	local push_notification_cultivate_spirit_terminal = {
		_name = "push_notification_cultivate_spirit",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
		_invoke = function(terminal, instance, params)
			local count = 0
			count = getCultivateSpiritPush()
			local isChange = false
	        if count ~= push_notification_cultivate_spirit_count then
	        	isChange = true
	        end
	        push_notification_cultivate_spirit_count = count

	        if count > 0 then
				if isChange == true then
					if params._widget._istips == true then
						params._widget:removeChild(params._widget._nodeChild, true)
						params._widget._nodeChild = nil
						params._widget._istips = false
					end
				else
				end
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

	local push_notification_cultivate_talent_terminal = {
		_name = "push_notification_cultivate_talent",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
		_invoke = function(terminal, instance, params)
			local count = 0
			count = getCultivateTalentPush()
			local isChange = false
	        if count ~= push_notification_cultivate_talent_count then
	        	isChange = true
	        end
	        push_notification_cultivate_talent_count = count

	        if count > 0 then
				if isChange == true then
					if params._widget._istips == true then
						params._widget:removeChild(params._widget._nodeChild, true)
						params._widget._nodeChild = nil
						params._widget._istips = false
					end
				else
				end
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

	local push_notification_cultivate_artifact_terminal = {
		_name = "push_notification_cultivate_artifact",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
		_invoke = function(terminal, instance, params)
	        if getCultivateArtifactPush() == true then
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

	local push_notification_cultivate_achieve_terminal = {
		_name = "push_notification_cultivate_achieve",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
		_invoke = function(terminal, instance, params)
	        if getCultivateAchievePush() == true then
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

	local push_notification_cultivate_achieve_Button_maoxian_terminal = {
		_name = "push_notification_cultivate_achieve_Button_maoxian",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
		_invoke = function(terminal, instance, params)
	        if getCultivateAchieveBtnPush(1) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(1, 1))
					ball:setPosition(cc.p(ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
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

	local push_notification_cultivate_achieve_Button_yangcheng_terminal = {
		_name = "push_notification_cultivate_achieve_Button_yangcheng",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
		_invoke = function(terminal, instance, params)
	        if getCultivateAchieveBtnPush(2) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(1, 1))
					ball:setPosition(cc.p(ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
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

	local push_notification_cultivate_achieve_Button_huodong_terminal = {
		_name = "push_notification_cultivate_achieve_Button_huodong",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
		_invoke = function(terminal, instance, params)
	        if getCultivateAchieveBtnPush(3) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(1, 1))
					ball:setPosition(cc.p(ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
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

	state_machine.add(push_notification_home_cultivate_terminal)
	state_machine.add(push_notification_cultivate_spirit_terminal)
	state_machine.add(push_notification_cultivate_talent_terminal)
	state_machine.add(push_notification_cultivate_artifact_terminal)
	state_machine.add(push_notification_cultivate_achieve_terminal)
	state_machine.add(push_notification_cultivate_achieve_Button_maoxian_terminal)
	state_machine.add(push_notification_cultivate_achieve_Button_yangcheng_terminal)
	state_machine.add(push_notification_cultivate_achieve_Button_huodong_terminal)
    state_machine.init()
end
init_push_notification_cultivate_terminal()

function getCultivatePush()
	local index = 0 
	index = index + getCultivateSpiritPush()
	index = index + getCultivateTalentPush()
	return index
end

function getCultivateSpiritPush()
	if funOpenDrawTip(122, false) == true then
		return 0
	end
	local index = 0 
	local number = #dms["ship_spirit_group"]
	for i=1, number do
		local needid = zstring.split(dms.string(dms["ship_spirit_group"], i, ship_spirit_group.ship_need_id),",")
		for j, v in pairs(needid) do
            local selected_ship = fundShipWidthTemplateId(v)
            if selected_ship ~= nil then
    			local isMax = false
    			if selected_ship.shipSpirit ~= nil and selected_ship.shipSpirit ~= "" then
					local info = zstring.split(selected_ship.shipSpirit, ":")
					local spirit = zstring.split(info[2],",")
					local infos = dms.searchs(dms["ship_spirit_param"], ship_spirit_param.stalls, spirit[3])
					if tonumber(spirit[1]) >= #infos then
						infos = dms.searchs(dms["ship_spirit_param"], ship_spirit_param.stalls, tonumber(spirit[3] + 1))
						if infos == nil then
							isMax = true
						end
					end
				end
				if isMax == false then
	            	local need_props = zstring.split(dms.string(dms["ship_spirit_group"], i, ship_spirit_group.need_props),"|")
	            	for x=1, #need_props do
		            	local props = zstring.split(need_props[x],",")
		            	if tonumber(getPropAllCountByMouldId(tonumber(props[2]))) > 0 then
		            		index = index + 1
		            	end
		            end
		        end
            end
        end
	end
	return index
end

function getCultivateTalentPush()
	if funOpenDrawTip(121, false) == true then
		return 0
	end
	local index = 0
	if _ED.digital_talent_page_is_lock ~= nil and _ED.digital_talent_page_is_lock ~= "" and _ED.user_info.talent_point ~= nil then
	else
		local function responseCallback(response)
            if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
            	if _ED.digital_talent_page_is_lock ~= nil and _ED.digital_talent_page_is_lock ~= "" and _ED.user_info.talent_point ~= nil then
            		state_machine.excute("notification_center_update", 0, "push_notification_cultivate_talent")
            	end
            end
        end
		NetworkManager:register(protocol_command.ship_talent_init.code, nil, nil, nil, nil, responseCallback, false, nil) 
	end

	for i=1, 3 do
		local number = 0 
		if i == 1 then
			number = 7
		elseif i == 2 then
			number = 10
		elseif i == 3 then
			number = 10
		end
		if _ED.digital_talent_page_is_lock[i] == false then

			local pageTalentOne = dms.int(dms["ship_talent_group"],i,ship_talent_group.first_mould)
			for j = 1 ,number do
				local talent_id = pageTalentOne - 1 + j
				local table_data = dms.element(dms["ship_talent_mould"] , talent_id)
				local is_open = true

				local lockString = dms.atos(table_data , ship_talent_mould.unlock_condition)
				if lockString ~= "3" then
					local unLockData = zstring.split(lockString ,"|")
					for i , v in pairs(unLockData) do
		                local needData = zstring.split(v , ",")
		                if tonumber(needData[1]) == 1 then -- 等级判定
		                    if tonumber(_ED.user_info.user_grade) < tonumber(needData[2]) then
		                        is_open = false
		                    end
		                else
		                	local currLv = 0
		                	local needLv = tonumber(needData[3])
		                    local needTalent = _ED.digital_talent_already_add[""..needData[2]]
		                    if needTalent == nil then
		                        is_open = false
		                    else
		                    	currLv = tonumber(needTalent.level)
		                    	if tonumber(needTalent.level) < tonumber(needData[3]) then
			                        is_open = false
			                    end
		                    end
		                end
		            end
		        end

	            if is_open == true then
					local maxLv = dms.atoi(table_data , ship_talent_mould.max_lv)
					local currLv = 0
		            local currTalent = _ED.digital_talent_already_add[""..talent_id]
		            if currTalent ~= nil then
		                currLv = zstring.tonumber(currTalent.level)
		            end
		            if currLv < maxLv then
		            	local needGroup = dms.searchs(dms["ship_talent_param"], ship_talent_param.need_mould, talent_id)
					    local virtueLv = currLv + 1
					    if virtueLv > maxLv then
					    	virtueLv = maxLv
					    end
						local nextData = {}
						for x , k in pairs(needGroup) do
							if tonumber(k[3]) == virtueLv then
								nextData = k
								break
							end
						end
						local needData = zstring.split(nextData[4] , "|")
						for z = 1 , 2 do
							local need = zstring.split(needData[z] , ",")
							if tonumber(need[1]) == 1 then
							else
								if tonumber(need[3]) <= zstring.tonumber(_ED.user_info.talent_point) then
									index = index + 1
								end
							end
						end 
		            end
		        end
			end
		end
	end
	return index
end

function getCultivateArtifactPush( ... )
	if true == funOpenDrawTip(123, false) then
        return false
    end
	local count = getPropAllCountByMouldId(242)
	if zstring.tonumber(count) >= 5 then
		return true
	end
	return false
end

function getCultivateAchievePush( ... )
	if true == funOpenDrawTip(124, false) then
        return false
    end
	for i = 1, 3 do
		if getCultivateAchieveBtnPush(i) then
			return true
		end
	end
	return false
end

function getCultivateAchieveBtnPush( index )
	local achieves = {}
	for i, v in ipairs(_ED.user_artifact_achieve_info) do
        local achievement_type = dms.int(dms["achievement"], v.id, achievement.achievement_type)
        if achievement_type and achievement_type == index then
            table.insert(achieves, v)
        end
    end
    for k, p in ipairs(achieves) do
    	local achieve_type = dms.int(dms["achievement"], p.id, 4)
    	local condition_type = dms.int(dms["achievement"], p.id, 6)
    	local condition = (condition_type == 27 and achieve_type == 2) and dms.int(dms["achievement"], p.id, 8) or dms.int(dms["achievement"], p.id, 7)
    	if condition == tonumber(p.speed) then
    		return true
    	end
    end
    return false
end