-- Initialize push notification center state machine.
push_notification_center_activity_all_push_state = {}
local function init_push_notification_center_activity_terminal()
	--首页活动按钮的推送
    local push_notification_center_activity_all_terminal = {
        _name = "push_notification_center_activity_all",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getactivityAllTip() == true then
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

    --首页日常活动按钮的推送
    local push_notification_center_activity_main_page_daily_activity_terminal = {
        _name = "push_notification_center_activity_main_page_daily_activity",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getDailyActivityTip(params) == true then
				if __lua_project_id == __lua_project_gragon_tiger_gate
					or __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					or __lua_project_id == __lua_project_red_alert 
					then
					if params._widget._nodeChild == nil or params._widget._istips == false then
						params._widget:removeChild(params._widget._nodeChild, true)
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.1))
						params._widget:addChild(ball)
						params._widget._nodeChild = ball
						params._widget._istips = true
					end					
				else
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
						params._widget:addChild(ball)
						params._widget._nodeChild = ball
						params._widget._istips = true
					end
				end
			else
				if __lua_project_id == __lua_project_gragon_tiger_gate
					-- or __lua_project_id == __lua_project_l_digital
					-- or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					or __lua_project_id == __lua_project_red_alert 
					then
					if params._widget._nodeChild == nil or params._widget._istips == true then
						params._widget:removeChild(params._widget._nodeChild, true)
						local ball = cc.Sprite:create("images/ui/bar/tuisong_wenhao.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
						params._widget:addChild(ball)
						params._widget._nodeChild = ball
						params._widget._istips = false
					end
				else
					if params._widget._istips == true then
						params._widget:removeChild(params._widget._nodeChild, true)
						params._widget._nodeChild = nil
						params._widget._istips = false
					end
				end
			end
			
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --首页七日活动按钮的推送
    local push_notification_center_activity_main_page_seven_days_activity_terminal = {
        _name = "push_notification_center_activity_main_page_seven_days_activity",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSevenDaysActivityTip(params) == true then
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

    --首页七日活动福利奖励页面按钮的推送
    local push_notification_center_activity_main_page_seven_days_activity_welfare_reward_page_tab_terminal = {
        _name = "push_notification_center_activity_main_page_seven_days_activity_welfare_reward_page_tab",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	local activity_terminal = state_machine.find("seven_days_activity_for_every_day_manager_change_day")
        	if activity_terminal ~= nil then
	        	local currentDayIndex = activity_terminal._instance.currentDayIndex
				if getSevenDaysActivityTip_welfare_dayIndex(params, currentDayIndex) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --首页七日活动成就1奖励页面按钮的推送
    local push_notification_center_activity_main_page_seven_days_activity_achievement1_reward_page_tab_terminal = {
        _name = "push_notification_center_activity_main_page_seven_days_activity_achievement1_reward_page_tab",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	local activity_terminal = state_machine.find("seven_days_activity_for_every_day_manager_change_day")
        	if activity_terminal ~= nil then
	        	local currentDayIndex = activity_terminal._instance.currentDayIndex
				if getSevenDaysActivityTip_achievement_dayIndex_page(params, currentDayIndex, 1) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --首页七日活动成就2奖励页面按钮的推送
    local push_notification_center_activity_main_page_seven_days_activity_achievement2_reward_page_tab_terminal = {
        _name = "push_notification_center_activity_main_page_seven_days_activity_achievement2_reward_page_tab",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	local activity_terminal = state_machine.find("seven_days_activity_for_every_day_manager_change_day")
        	if activity_terminal ~= nil then
	        	local currentDayIndex = activity_terminal._instance.currentDayIndex
				if getSevenDaysActivityTip_achievement_dayIndex_page(params, currentDayIndex, 2) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --首页七日活动道具购买奖励页面按钮的推送
    local push_notification_center_activity_main_page_seven_days_activity_prop_buy_reward_page_tab_terminal = {
        _name = "push_notification_center_activity_main_page_seven_days_activity_prop_buy_reward_page_tab",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	local activity_terminal = state_machine.find("seven_days_activity_for_every_day_manager_change_day")
        	if activity_terminal ~= nil then
	        	local currentDayIndex = activity_terminal._instance.currentDayIndex
				if getSevenDaysActivityTip_propBuy_dayIndex(params, currentDayIndex) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --首页七日活动每日奖励页面按钮的推送
    local push_notification_center_activity_main_page_seven_days_activity_every_day_reward_terminal = {
        _name = "push_notification_center_activity_main_page_seven_days_activity_every_day_reward",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	local activity_terminal = state_machine.find("seven_days_activity_for_every_day_manager_change_day")
        	if activity_terminal ~= nil then
	        	local currentDayIndex = params._datas._dayIndex -- activity_terminal._instance.currentDayIndex
				if getSevenDaysActivityTip_every_day(params, currentDayIndex) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width+ball:getContentSize().width/2 - params._widget:getContentSize().width, params._widget:getContentSize().height-ball:getContentSize().height/2))
						params._widget:addChild(ball, 10000)
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --首页日常活动页面按钮的推送
    local push_notification_center_activity_main_page_daily_activity_daily_page_button_terminal = {
        _name = "push_notification_center_activity_main_page_daily_activity_daily_page_button",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getDailyActivityTaskTip(params) == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.5))
					if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
						ball:setAnchorPoint(cc.p(1, 1))
					end
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

    --首页日常活动成就页面按钮的推送
    local push_notification_center_activity_main_page_daily_activity_achievement_page_button_terminal = {
        _name = "push_notification_center_activity_main_page_daily_activity_achievement_page_button",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				if getDailyActivityAchievementNewTip(params) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
							ball:setAnchorPoint(cc.p(1, 1))
						end
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
        	else
				if getDailyActivityAchievementTip(params) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
							ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))
						else
							ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))
						end
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }
	
	
    --首页日常活动成就页面各个类型按钮的推送
    local push_notification_center_activity_main_page_daily_activity_achievement_page_button_of_kinds_terminal = {
        _name = "push_notification_center_activity_main_page_daily_activity_achievement_page_button_of_kinds",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				if getDailyActivityAchievementNewKindsTip(params) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-5, params._widget:getContentSize().height-5))
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
        	end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }	
	--活动界面里的次日活动的按钮的推送
	local push_notification_activity_next_day_terminal = {
        _name = "push_notification_activity_next_day",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivityNextDayTips() == true then
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

	--活动界面里的回体力的按钮的推送
	local push_notification_center_activity_eat_manual_terminal = {
        _name = "push_notification_center_activity_eat_manual",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivityEatManualTips() == true then
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
	--活动界面内迎财神界面的按钮的推送
	local push_notification_center_activity_god_of_wealth_terminal = {
        _name = "push_notification_center_activity_god_of_wealth",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getGodOfWealthTips() == true then
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
	--活动界面内的首充礼包按钮的推送
	local push_notification_center_activity_recharge_terminal = {
        _name = "push_notification_center_activity_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getRechargeTips() == true then
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
	--活动界面内的签到按钮的推送
	local push_notification_center_activity_sign_terminal = {
        _name = "push_notification_center_activity_sign",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSigntips() == true then
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
	--签到界面内的每日签到按钮的推送
	local push_notification_center_activity_daily_attendance_terminal = {
        _name = "push_notification_center_activity_daily_attendance",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getDailyAttendanceTips() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						then
						ball:setAnchorPoint(cc.p(0.63, 0.63))
					else
						ball:setAnchorPoint(cc.p(0, 0))
					end
					
					
					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						or __lua_project_id == __lua_project_legendary_game 
						then	
						ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))
					else
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*1.5, params._widget:getContentSize().height-ball:getContentSize().height))
					end
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
	--签到界面内的豪华签到按钮的推送
	local push_notification_center_activity_luxury_sign_terminal = {
        _name = "push_notification_center_activity_luxury_sign",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getLuxurySignTips() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						then
						ball:setAnchorPoint(cc.p(0.63, 0.63))
					else
						ball:setAnchorPoint(cc.p(0, 0))
					end
					if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then	
						ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))
					else
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*1.5, params._widget:getContentSize().height-ball:getContentSize().height))
					end
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
	--首页的领奖中心的按钮推送
	local push_notification_center_activity_the_center_of_the_award_terminal = {
        _name = "push_notification_center_activity_the_center_of_the_award",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getTheCenteOfTheAward() == true then
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
	
	
	--活动界面内的叛军按钮的推送
	local push_notification_center_activity_the_center_rebel_army_attck_recharge_terminal = {
        _name = "push_notification_center_activity_the_center_rebel_army_attck_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getRebelArmyAttckRechargeTips() == true then
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
    --活动界面内的叛军按钮的推送
	local push_notification_center_activity_the_center_rebel_army_kill_recharge_terminal = {
        _name = "push_notification_center_activity_the_center_rebel_army_kill_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getRebelArmyKillRechargeTips() == true then
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
    --活动界面内的叛军按钮的推送
	local push_notification_center_activity_the_center_rebel_army_recharge_terminal = {
        _name = "push_notification_center_activity_the_center_rebel_army_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getRebelArmyRechargeTips() == true then
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
	
	
	--活动界面内的单笔累计充值礼包按钮的推送
	local push_notification_center_activity_the_center_once_recharge_terminal = {
        _name = "push_notification_center_activity_the_center_once_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getOnceRechargeTips() == true then
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
	
	--活动界面内的每日累计充值礼包按钮的推送
	local push_notification_center_activity_the_center_one_day_recharge_terminal = {
        _name = "push_notification_center_activity_the_center_one_day_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getOneDayRechargeTips() == true then
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
	
	
	--活动界面内的登陆送礼按钮的推送
	local push_notification_center_activity_the_center_login_gift_giving_terminal = {
        _name = "push_notification_center_activity_the_center_login_gift_giving",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivityLoginGiftGivingTips() == true then
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
	--活动界面内的累计充值礼包按钮的推送
	local push_notification_center_activity_the_center_accumlate_rechargeable_terminal = {
        _name = "push_notification_center_activity_the_center_accumlate_rechargeable",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getAccumlateRechargeableTips() == true then
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
	--活动界面内的累计消费按钮的推送
	local push_notification_center_activity_the_center_accumlate_consumption_terminal = {
        _name = "push_notification_center_activity_the_center_accumlate_consumption",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getAccumlateConsumptionTips() == true then
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
	--活动界面的月卡按钮的推送
	local push_notification_center_activity_the_center_month_card_terminal = {
        _name = "push_notification_center_activity_the_center_month_card",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivityMonthCardTips() == true then
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

	--活动界面里面的开服基金按钮的推送
	local push_notification_center_activity_open_server_activity_terminal = {
        _name = "push_notification_center_activity_open_server_activity",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getOpenServerAcivityTips() == true then
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

	--活动界面里面的开服基金页面按钮的推送
	local push_notification_center_activity_open_server_activity_fund_activity_terminal = {
        _name = "push_notification_center_activity_open_server_activity_fund_activity",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getOpenServerAcivityTips_FundActivity() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					
					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						then
						ball:setAnchorPoint(cc.p(0.3, 0.6))	
					else
						ball:setAnchorPoint(cc.p(0.5, 0.5))
					end
					if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
						ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))
					elseif __lua_project_id == __lua_project_legendary_game then	
						ball:setPosition(cc.p(params._widget:getContentSize().width - 30, params._widget:getContentSize().height / 2))
					else
						ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))
					end
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

	--活动界面里面的开服基金充值按钮的推送
	local push_notification_center_activity_open_server_activity_recharge_terminal = {
        _name = "push_notification_center_activity_open_server_activity_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getOpenServerAcivityTips_FundActivity_recharge() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.55))
					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						or __lua_project_id == __lua_project_legendary_game 
						then	
						ball:setPosition(cc.p(params._widget:getContentSize().width - ball:getContentSize().width*1.5 + 30, params._widget:getContentSize().height-ball:getContentSize().height * 0.5 / 3))
					elseif __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
						or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
						ball:setPosition(cc.p(params._widget:getContentSize().width - ball:getContentSize().width/2,params._widget:getContentSize().height))
					else
						ball:setPosition(cc.p(params._widget:getContentSize().width - ball:getContentSize().width*1.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
					end
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

	--活动界面里面的开服基金购买按钮的推送
	local push_notification_center_activity_open_server_activity_buy_terminal = {
        _name = "push_notification_center_activity_open_server_activity_buy",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getOpenServerAcivityTips_FundActivity_buy() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.5))
					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						or __lua_project_id == __lua_project_legendary_game 
						then	
						ball:setPosition(cc.p(params._widget:getContentSize().width - ball:getContentSize().width*1.5 + 35, params._widget:getContentSize().height-ball:getContentSize().height*0.5+10))
					else
						ball:setPosition(cc.p(params._widget:getContentSize().width - ball:getContentSize().width*1.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))
					end
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

    --活动界面里面的全民福利页面按钮的推送
	local push_notification_center_activity_open_server_activity_welfare_activity_terminal = {
        _name = "push_notification_center_activity_open_server_activity_welfare_activity",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getOpenServerAcivityTips_WelfareActivity() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.5))
					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						then
						ball:setAnchorPoint(cc.p(0.3, 0.6))
						ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))
					elseif __lua_project_id == __lua_project_legendary_game then
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width - 30, params._widget:getContentSize().height / 2))
					else
						ball:setPosition(cc.p(params._widget:getContentSize().width, params._widget:getContentSize().height))
					end
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

	--主界面神秘商店按钮的推送
	local push_notification_center_activity_click_hero_shop_terminal = {
        _name = "push_notification_center_activity_click_hero_shop",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getClickHeroShopTips() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					if __lua_project_id == __lua_project_gragon_tiger_gate
						or __lua_project_id == __lua_project_l_digital
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						or __lua_project_id == __lua_project_red_alert 
						then
						ball:setAnchorPoint(cc.p(0.5, 0.5))
					else
						ball:setAnchorPoint(cc.p(0, 0))
					end
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
	
	
	--活动界面的vip礼包按钮的推送
	local push_notification_center_activity_vip_package_terminal = {
        _name = "push_notification_center_activity_vip_package",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivityVipPackageTips() == true then
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
	
		--首页等级奖励的推送
	local push_notification_center_activity_level_packs_terminal = {
        _name = "push_notification_center_activity_level_packs",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				if getLevelPacksCanGet() == true then
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

		--新七日福利
	local push_notification_new_sevendays_welfare_terminal = {
        _name = "push_notification_new_sevendays_welfare",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				if getSevenDayWalfare() == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5+10, params._widget:getContentSize().height-ball:getContentSize().height*0.5+10))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    		--新七日充值
	local push_notification_new_sevendays_recharge_terminal = {
        _name = "push_notification_new_sevendays_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				if getSevenDayRecharge() == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5+10, params._widget:getContentSize().height-ball:getContentSize().height*0.5+10))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    		--新七日成就
	local push_notification_new_sevendays_achieve_terminal = {
        _name = "push_notification_new_sevendays_achieve",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				if getSevenDayAchieve() == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5+10, params._widget:getContentSize().height-ball:getContentSize().height*0.5+10))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    		--新七日半价
	local push_notification_new_sevendays_half_terminal = {
        _name = "push_notification_new_sevendays_half",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				if getSevenDayHalf() == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5+10, params._widget:getContentSize().height-ball:getContentSize().height*0.5+10))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    		--新七日福利 - 每天
	local push_notification_new_everydays_welfare_terminal = {
        _name = "push_notification_new_everydays_welfare",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
        		local dayIndex = params._datas.dayIndex
				if getEveryDayWalfare(params,dayIndex) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-210, params._widget:getContentSize().height-3))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    		--新七日充值 - 每天
	local push_notification_new_everydays_recharge_terminal = {
        _name = "push_notification_new_everydays_recharge",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
        		local dayIndex = params._datas.dayIndex
				if getEveryDayRecharge(dayIndex,true) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						if __lua_project_id == __lua_project_l_digital
							or __lua_project_id == __lua_project_l_pokemon 
							or __lua_project_id == __lua_project_l_naruto 
							then
							ball:setPosition(cc.p(params._widget:getContentSize().width-20, params._widget:getContentSize().height-3))
						else
							ball:setPosition(cc.p(params._widget:getContentSize().width-210, params._widget:getContentSize().height-3))
						end
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    		--新七日成就 - 每天
	local push_notification_new_everydays_achieve_terminal = {
        _name = "push_notification_new_everydays_achieve",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
        		local dayIndex = params._datas.dayIndex
				if getEveryDayAchieve(params,dayIndex) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-210, params._widget:getContentSize().height-3))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    		--新七日半价 - 每天
	local push_notification_new_everydays_half_terminal = {
        _name = "push_notification_new_everydays_half",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
        		local dayIndex = params._datas.dayIndex
				if getEveryDayHalf(params,dayIndex) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.5, 0.5))
						ball:setPosition(cc.p(params._widget:getContentSize().width-210, params._widget:getContentSize().height-3))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

	--迎财神
	local push_notification_welcome_money_man_terminal = {
        _name = "push_notification_welcome_money_man",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getWelcomeMan() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.5))
					ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))					params._widget:addChild(ball)
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

    --登陆奖励
	local push_notification_activity_login_reward_terminal = {
        _name = "push_notification_activity_login_reward",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getLoingReward() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.5))
					ball:setPosition(cc.p(params._widget:getContentSize().width-ball:getContentSize().width*0.5, params._widget:getContentSize().height-ball:getContentSize().height*0.5))					params._widget:addChild(ball)
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
    --数码开服狂欢标签页推送
    local push_notification_activity_everydays_page_push_terminal = {
        _name = "push_notification_activity_everydays_page_push",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
        	local pageIndex = params._datas.pageIndex
        	if params._widget:isVisible() == true then
				if getActivityEverydaysPage(pageIndex ,true) == true then
					if params._widget._istips == nil or params._widget._istips == false then
						local ball = cc.Sprite:create("images/ui/bar/tips.png")
						ball:setAnchorPoint(cc.p(0.7, 0.7))
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
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    --数码开服狂欢全目标奖励推送
    local push_notification_activity_everydays_all_target_terminal = {
        _name = "push_notification_activity_everydays_all_target",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivityEverydaysAllTarget() == true then
				if params._widget._istips == nil or params._widget._istips == false then
					local ball = cc.Sprite:create("images/ui/bar/tips.png")
					ball:setAnchorPoint(cc.p(0.5, 0.5))
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

    --抽卡活动-送拉拉兽
    local push_notification_center_activity_the_center_sm_compage_count_1_terminal = {
        _name = "push_notification_center_activity_the_center_sm_compage_count_1",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivitySmCompageCount1() == true then
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

    --抽卡活动-招募数码兽
    local push_notification_center_activity_the_center_sm_compage_count_2_terminal = {
        _name = "push_notification_center_activity_the_center_sm_compage_count_2",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivitySmCompageCount2() == true then
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

    --竞技场积分奖励
    local push_notification_center_activity_the_center_sm_compage_count_3_terminal = {
        _name = "push_notification_center_activity_the_center_sm_compage_count_3",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivitySmCompageCount3() == true then
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

    --招募武将1比多兽
    local push_notification_center_activity_the_center_sm_recruit_ship_1_terminal = {
        _name = "push_notification_center_activity_the_center_sm_recruit_ship_1",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivitySmIsNextDayPush( 78,params._widget.pagekey) == true then
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

    --招募武将2巴多拉兽
    local push_notification_center_activity_the_center_sm_recruit_ship_2_terminal = {
        _name = "push_notification_center_activity_the_center_sm_recruit_ship_2",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivitySmIsNextDayPush( 79,params._widget.pagekey) == true then
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

    --招募武将3加鲁鲁兽
    local push_notification_center_activity_the_center_sm_recruit_ship_3_terminal = {
        _name = "push_notification_center_activity_the_center_sm_recruit_ship_3",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivitySmIsNextDayPush( 80, params._widget.pagekey) == true then
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

     --碎片兑换
    local push_notification_center_activity_the_center_sm_half_price_restriction_terminal = {
        _name = "push_notification_center_activity_the_center_sm_half_price_restriction",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getActivitySmIsNextDayPush( 28, params._widget.pagekey) == true then
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

    -- 限时宝箱免费次数
    local push_notification_center_activity_the_center_sm_limited_time_box_terminal = {
        _name = "push_notification_center_activity_the_center_sm_limited_time_box",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSmActivityLimitedTimeBoxFreeTips() == true then
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

    -- 数码活动按钮推送
    local push_notification_center_activity_the_center_sm_activity_icon_cell_terminal = {
        _name = "push_notification_center_activity_the_center_sm_activity_icon_cell",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			if getSmActivityIconCellPushTips(params._datas._activity_type) == true then
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
			if tonumber(params._datas._activity_type) == 0 then
				state_machine.excute("activity_home_update_armature", 0, { params._datas.cells, params._widget._istips})
			end
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

    -- 数码活动按钮推送
    local push_notification_center_activity_the_center_sm_activity_update_terminal = {
        _name = "push_notification_center_activity_the_center_sm_activity_update",
        _init = function (terminal)
        end,
        _inited = false,
        _instance = self,
        _state = 0,
        _invoke = function(terminal, instance, params)
			local activity_type = params
			getSmActivityPushStateTips(activity_type)
			state_machine.excute("notification_center_update", 0, "push_notification_center_activity_the_center_sm_activity_icon_cell")
            return true
        end,
        _terminal = nil,
        _terminals = nil
    }

	state_machine.add(push_notification_center_activity_vip_package_terminal)
	state_machine.add(push_notification_activity_next_day_terminal)
	state_machine.add(push_notification_center_activity_the_center_rebel_army_recharge_terminal)
	state_machine.add(push_notification_center_activity_the_center_once_recharge_terminal)
	state_machine.add(push_notification_center_activity_the_center_one_day_recharge_terminal)
    state_machine.add(push_notification_center_activity_all_terminal)
    state_machine.add(push_notification_center_activity_main_page_daily_activity_terminal)
    state_machine.add(push_notification_center_activity_main_page_daily_activity_daily_page_button_terminal)
    state_machine.add(push_notification_center_activity_main_page_daily_activity_achievement_page_button_terminal)
    state_machine.add(push_notification_center_activity_main_page_daily_activity_achievement_page_button_of_kinds_terminal)

    state_machine.add(push_notification_center_activity_main_page_seven_days_activity_terminal)
    state_machine.add(push_notification_center_activity_main_page_seven_days_activity_welfare_reward_page_tab_terminal)
    state_machine.add(push_notification_center_activity_main_page_seven_days_activity_achievement1_reward_page_tab_terminal)
    state_machine.add(push_notification_center_activity_main_page_seven_days_activity_achievement2_reward_page_tab_terminal)
    state_machine.add(push_notification_center_activity_main_page_seven_days_activity_prop_buy_reward_page_tab_terminal)
    state_machine.add(push_notification_center_activity_main_page_seven_days_activity_every_day_reward_terminal)
    state_machine.add(push_notification_center_activity_eat_manual_terminal)
    state_machine.add(push_notification_center_activity_god_of_wealth_terminal)
    state_machine.add(push_notification_center_activity_recharge_terminal)
    state_machine.add(push_notification_center_activity_sign_terminal)
    state_machine.add(push_notification_center_activity_daily_attendance_terminal)
    state_machine.add(push_notification_center_activity_luxury_sign_terminal)
    state_machine.add(push_notification_center_activity_the_center_of_the_award_terminal)
    state_machine.add(push_notification_center_activity_the_center_accumlate_rechargeable_terminal)
    state_machine.add(push_notification_center_activity_the_center_accumlate_consumption_terminal)
    state_machine.add(push_notification_center_activity_the_center_month_card_terminal)
    state_machine.add(push_notification_center_activity_open_server_activity_terminal)
    state_machine.add(push_notification_center_activity_open_server_activity_fund_activity_terminal)
    state_machine.add(push_notification_center_activity_open_server_activity_recharge_terminal)
    state_machine.add(push_notification_center_activity_open_server_activity_buy_terminal)
    state_machine.add(push_notification_center_activity_open_server_activity_welfare_activity_terminal)
    state_machine.add(push_notification_center_activity_click_hero_shop_terminal)
    state_machine.add(push_notification_center_activity_the_center_login_gift_giving_terminal)
    state_machine.add(push_notification_center_activity_the_center_rebel_army_attck_recharge_terminal)
    state_machine.add(push_notification_center_activity_the_center_rebel_army_kill_recharge_terminal)
    state_machine.add(push_notification_center_activity_level_packs_terminal)

    state_machine.add(push_notification_new_sevendays_welfare_terminal)
    state_machine.add(push_notification_new_sevendays_recharge_terminal)
    state_machine.add(push_notification_new_sevendays_achieve_terminal)
    state_machine.add(push_notification_new_sevendays_half_terminal)
    state_machine.add(push_notification_new_everydays_welfare_terminal)
    state_machine.add(push_notification_new_everydays_recharge_terminal)
    state_machine.add(push_notification_new_everydays_achieve_terminal)
    state_machine.add(push_notification_new_everydays_half_terminal)
    state_machine.add(push_notification_welcome_money_man_terminal)
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
    	state_machine.add(push_notification_activity_login_reward_terminal)
    	state_machine.add(push_notification_activity_everydays_page_push_terminal)
    	state_machine.add(push_notification_activity_everydays_all_target_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_compage_count_1_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_compage_count_2_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_compage_count_3_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_recruit_ship_1_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_recruit_ship_2_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_recruit_ship_3_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_half_price_restriction_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_limited_time_box_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_activity_icon_cell_terminal)
    	state_machine.add(push_notification_center_activity_the_center_sm_activity_update_terminal)
    end
    state_machine.init()
end
init_push_notification_center_activity_terminal()

--七日活动新版推送--每日福利
function getSevenDayWalfare()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards or _ED._sevenDaysActivity_currentActivityDayCount == nil then
			return false
		end
	    for i,v in pairs(_ED.active_activity[42].seven_days_rewards) do
		    for j,k in ipairs(_ED.active_activity[42].seven_days_rewards[i].welfare) do
		    	local ty_need_gold = dms.int(dms["daily_welfare"],tonumber(k.id),daily_welfare.reward_need_gold)
		    	if ty_need_gold == 0 then
			    	if i > _ED._sevenDaysActivity_currentActivityDayCount then
			    		return false
			    	end
			        if tonumber(k.state) == 0 then 
			            return true
			        end
			    end
		    end
		end
        return false
	end
end

--七日活动新版推送--每日福利
function getEveryDayWalfare(notificationer,dayIndex)
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards or _ED._sevenDaysActivity_currentActivityDayCount == nil then
			return false
		end
	    for j,k in ipairs(_ED.active_activity[42].seven_days_rewards[dayIndex].welfare) do
	    	local ty_need_gold = dms.int(dms["daily_welfare"],tonumber(k.id),daily_welfare.reward_need_gold)
	    	if ty_need_gold == 0 then
		    	if dayIndex > _ED._sevenDaysActivity_currentActivityDayCount then
		    		return false
		    	end
		        if tonumber(k.state) == 0 then 
		            return true
		        end
		    end
	    end
        return false
	end
end

--七日活动新版推送--充值
function getSevenDayRecharge()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards or _ED._sevenDaysActivity_currentActivityDayCount == nil then
			return false
		end
	    for i,v in pairs(_ED.active_activity[42].seven_days_rewards) do
		    for j,k in ipairs(v.welfare) do
		    	local ty_need_gold = dms.int(dms["daily_welfare"],tonumber(k.id),daily_welfare.reward_need_gold)
		    	if ty_need_gold > 0 then
			    	if i > _ED._sevenDaysActivity_currentActivityDayCount then
			    		return false
			    	end
			        if tonumber(k.state) == 0 then 
			            return true
			        end
			    end
		    end
		end
        return false
	end
end

--七日活动新版推送--充值-每天
function getEveryDayRecharge(dayIndex,everyDay)
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards then
			return false
		end
		if dayIndex > tonumber(_ED.active_activity[42].activity_day_count) then
			return false
		end
		-- if everyDay == true then
		-- 	local _window = fwin:find("SevenDaysWelfareClass")
		-- 	if _window ~= nil and tonumber(_window.dayIndex) == dayIndex then
		-- 		return false
		-- 	end
		-- end
		for i ,v in pairs(_ED.active_activity[42].seven_days_rewards[dayIndex].achievement_pages) do
			for j , k in pairs(v._achievement_rewards) do
				local nowpersent = tonumber(k.complete_count)
				local mouldID = tonumber(k.id)
				local maxpersent = 0
				local dailyTaskMould = dms.element(dms["achieve"], mouldID)
				local param2 = dms.atoi(dailyTaskMould,achieve.param2)
				local param3 = dms.atoi(dailyTaskMould,achieve.param3)
				if param3 ~= -1 then
		            maxpersent = param3
		        else 
		            maxpersent = param2
		        end 
		        if dayIndex == 4 and i == 2 then
					if tonumber(k.state) == 0 and nowpersent > 0 and nowpersent <= maxpersent then
						return true
					end
				else
					if tonumber(k.state) == 0 and nowpersent >= maxpersent then
						return true
					end
				end
			end
		end
		return false
	elseif __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_red_alert 
		then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards or _ED._sevenDaysActivity_currentActivityDayCount == nil then
			return false
		end	  
	    for j,k in ipairs(_ED.active_activity[42].seven_days_rewards[dayIndex].welfare) do
	    	local ty_need_gold = dms.int(dms["daily_welfare"],tonumber(k.id),daily_welfare.reward_need_gold)
	    	if ty_need_gold > 0 then
		    	if dayIndex > _ED._sevenDaysActivity_currentActivityDayCount then
		    		return false
		    	end
		        if tonumber(k.state) == 0 then 
		            return true
		        end
		    end
	    end
        return false
	end
end

--七日活动新版推送--成就 -所有
function getSevenDayAchieve()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards or _ED._sevenDaysActivity_currentActivityDayCount == nil then
			return false
		end
		for i,v in pairs(_ED.active_activity[42].seven_days_rewards) do
	    	for j,k in ipairs(v.achievement_pages[1]._achievement_rewards) do
    			if i > _ED._sevenDaysActivity_currentActivityDayCount then
		    		return false
		    	end
		        if tonumber(k.state) == 0 then 
		        	local achieve_id = tonumber(k.id)
		        	local nowpersent = tonumber(k.complete_count)
		        	local param1 = dms.int(dms["achieve"],achieve_id,achieve.param1) 
					local param2 = dms.int(dms["achieve"],achieve_id,achieve.param2) 
		            local param3 = dms.int(dms["achieve"],achieve_id,achieve.param3)            
		            if param3 ~= -1 then
		                maxpersent = param3
		            else 
		                maxpersent = param2
		            end
					if param1 == 8 or param1 == 6 then
		            	maxpersent = param2
		            end	            
		            if nowpersent >= maxpersent and param1 ~= 7 and param1 ~= 9 then
		            	  -- print("=======11===========",param3,param2,nowpersent,maxpersent,achieve_id)
		               	return true
		            end
		           	if nowpersent <= maxpersent and param1 == 7 then
		           		 -- print("========22==========",param3,param2,nowpersent,maxpersent,achieve_id)
		           		return true
		            end 
		           	if nowpersent <= maxpersent and param1 == 9 and nowpersent ~= 0 then
		           		 -- print("========22==========",param3,param2,nowpersent,maxpersent,achieve_id)
		           		return true
		            end  
		        end
		    end
		end
        return false
	end
end

--七日活动新版推送--成就-每天
function getEveryDayAchieve(notificationer,dayIndex)
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards or _ED._sevenDaysActivity_currentActivityDayCount == nil then
			return false
		end

    	for j,k in ipairs(_ED.active_activity[42].seven_days_rewards[dayIndex].achievement_pages[1]._achievement_rewards) do
			if dayIndex > _ED._sevenDaysActivity_currentActivityDayCount then
	    		return false
	    	end
	        if tonumber(k.state) == 0 then
	        	local achieve_id = tonumber(k.id)
	        	local nowpersent = tonumber(k.complete_count)
				local param1 = dms.int(dms["achieve"],achieve_id,achieve.param1) 
				local param2 = dms.int(dms["achieve"],achieve_id,achieve.param2) 
	            local param3 = dms.int(dms["achieve"],achieve_id,achieve.param3) 

	            if param3 ~= -1 then
	                maxpersent = param3
	            else 
	                maxpersent = param2
	            end
	            if param1 == 8 or param1 == 6 then
	            	maxpersent = param2
	            end
	            -- if param1 == 9 then
	            	
	            -- 	print("=======11===========",param3,param2,nowpersent,maxpersent,achieve_id)
	            -- end
	            if nowpersent >= maxpersent and param1 ~= 7 and param1 ~= 9 then
	            	  -- print("=======11===========",param3,param2,nowpersent,maxpersent,achieve_id)
	               	return true
	            end
	           	if nowpersent <= maxpersent and param1 == 7 and nowpersent ~= 0 then
	           		 -- print("========22==========",param3,param2,nowpersent,maxpersent,achieve_id)
	           		return true
	            end 
	           	if nowpersent <= maxpersent and param1 == 9 and nowpersent ~= 0 then
	           		 -- print("========22==========",param3,param2,nowpersent,maxpersent,achieve_id)
	           		return true
	            end 	            
		    end
	    end

        return false
	end
end
--七日活动新版推送--半价-所有
function getSevenDayHalf()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards or _ED._sevenDaysActivity_currentActivityDayCount == nil then
			return false
		end

		for i,v in pairs(_ED.active_activity[42].seven_days_rewards) do
			if i > _ED._sevenDaysActivity_currentActivityDayCount then
	    		return false
	    	end
	        if tonumber(v.half_prop_buy_state) == 0 then 
	            return true
	        end
		end
        return false
	end
end
--七日活动新版推送--半价-每天
function getEveryDayHalf(notificationer,dayIndex)
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards or _ED._sevenDaysActivity_currentActivityDayCount == nil then
			return false
		end
		
		if dayIndex > _ED._sevenDaysActivity_currentActivityDayCount then
    		return false
    	end

        if tonumber(_ED.active_activity[42].seven_days_rewards[dayIndex].half_prop_buy_state) == 0 then 
            return true
        end

        return false
	end
end

--迎财神
function getWelcomeMan()
	
	if nil == _ED.active_activity[14] then 
		return false
	else
		local remainArr = zstring.split("" .._ED.active_activity[14].activity_extra_prame, ",")
		if _ED.welcome_money == nil then 
			--第一次进去初始化
			for i,v in pairs(remainArr) do
				if zstring.tonumber(v) == 0 then 
					return true
				end
			end
		else
			--点了后有数据了
			if #remainArr > zstring.tonumber(_ED.welcome_money.current_times) then 
				return true
			end
		end
	end
    return false
	
end
function getactivityAllTip()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
	else
	-- 是否可领取首充
		if _ED.active_activity[4] ~= nil and _ED.active_activity[4]~="" then
			if tonumber(_ED.recharge_rmb_number) > 0 and tonumber(_ED.active_activity[4].activity_id)==0 then
				return true
			end
		end
	end
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		if getActivitySmCompageCount1() == true then
			return true
		end
		if getActivitySmCompageCount2() == true then
			return true
		end
		if getActivitySmCompageCount3() == true then
			return true
		end
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
			if getLoingReward() == true then
				return true
			end
		end

		if getActivitySmIsNextDayPush( 28 , "HalfPriceRestriction") == true then
			return true
		end

		if getActivitySmIsNextDayPush( 78 , "SmActivityRecruitShip78") == true then
			return true
		end

		if getActivitySmIsNextDayPush( 79 , "SmActivityRecruitShip79") == true then
			return true
		end

		if getActivitySmIsNextDayPush( 80 , "SmActivityRecruitShip80") == true then
			return true
		end
	else
		-- 是否可领取体力
		if tonumber(_ED._add_enger) > 0 then
			return true
		end
		-- 是否可迎接财神
		if tonumber(_ED.welcome_mammon.welcome_time_day_yet) < tonumber(_ED.welcome_mammon.welcome_time_day_sum) then
			if os.time()- tonumber(_ED.welcome_mammon.os_time) > _ED.welcome_mammon.cooling_times/1000 then
				return true
			end
		end
		-- 是否可领取签到
		if _ED.active_activity[38] ~= nil and _ED.active_activity[38]~="" then
			if #_ED.active_activity[38].activity_Info > 0 then
				for i=1,#_ED.active_activity[38].activity_Info do
					if tonumber(_ED.active_activity[38].activity_Info[i].activityInfo_isReward) == 0 then
						if tonumber(_ED.active_activity[38].activity_login_day) >= tonumber(_ED.active_activity[38].activity_Info[i].activityInfo_need_day) then
							return true
						end
					end
				end
			end
		end
		-- 是否可领取豪华签到
		if _ED.active_activity[39] ~= nil and _ED.active_activity[39]~="" then
			if #_ED.active_activity[39].activity_Info > 0 then
				for i=1,#_ED.active_activity[39].activity_Info do
					if tonumber(_ED.active_activity[39].activity_Info[i].activityInfo_is_reach) == 1 then
						if tonumber(_ED.active_activity[39].activity_Info[i].activityInfo_isReward) == 0 then
							return true
						end
					end
				end
			end
		end
		--是否登陆送礼
		if getActivityLoginGiftGivingTips() ==true then
			return true
		end
		--是否叛军够了
		if getRebelArmyRechargeTips() ==true then
			return true
		end
		if getRebelArmyAttckRechargeTips() ==true then
			return true
		end
		if getRebelArmyKillRechargeTips() ==true then
			return true
		end
	end
	
	--是否单笔累计充值
	if getOnceRechargeTips() ==true then
		return true
	end
	
	--是否每日累计充值
	if getOneDayRechargeTips() ==true then
		return true
	end
	
	--是否累计充值
	if getAccumlateRechargeableTips() ==true then
		return true
	end
	--是否月卡
	if getActivityMonthCardTips() == true then
		return true
	end
	--是否累计消费
	if getAccumlateConsumptionTips() == true then
		return true
	end
	--是否全服基金
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_red_alert 
		then
	else
		if getOpenServerAcivityTips() == true then
			return true
		end
	end

	return false
end

function getDailyActivityTaskTip(notificationer)
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			if funOpenDrawTip(86,false) == true then
				return false
			end
			--debug.print_r(_ED.month_card)
			--月卡
			if _ED.month_card ~= nil and _ED.month_card ~= {} then
				for i ,v in pairs(_ED.month_card) do
					if tonumber(v.surplus_month_card_time) > 0 and tonumber(v.draw_month_card_state) == 0 then
						return true
					end
				end
			end
			--体力领取
			local energyData = zstring.split(dms.string(dms["activity_config"], 1, activity_config.param), "|")
        	local add_enger_info = zstring.split(_ED._add_enger_info,"|")
        	for i=1, 4 do
        		local energy_info = zstring.split(energyData[i], ",")
	            local add_enger_data = zstring.split(add_enger_info[i],",")
	            local current = _ED.system_time + (os.time() - _ED.native_time)
	            local earlyMorning1 = tonumber(zstring.split(energy_info[1], ":")[1])*3600
	            local earlyMorning2 = tonumber(zstring.split(energy_info[2], ":")[1])*3600
	            local temp = os.date("*t", getBaseGTM8Time(zstring.tonumber(current)))
	            local m_hour    = tonumber(string.format("%02d", temp.hour))
	            local m_min     = tonumber(string.format("%02d", temp.min))
	            local m_sec     = tonumber(string.format("%02d", temp.sec))
	            local newTimes = m_hour*3600+m_min*60+m_sec
		        local createUserData = os.date("*t", getBaseGTM8Time(zstring.tonumber(_ED.user_info.create_time)))
		        local createUserTimes = zstring.tonumber(string.format("%02d", createUserData.hour))*3600 + tonumber(string.format("%02d", createUserData.min))*60 + tonumber(string.format("%02d", createUserData.sec))
				if createUserData.year ~= temp.year
	                or createUserData.month ~= temp.month
	                or createUserData.day ~= temp.day
	                or createUserTimes <= earlyMorning2 then
	        		if newTimes >= earlyMorning1 and newTimes <= earlyMorning2 then
	                	if tonumber(add_enger_data[1]) == 0 then
	                		return true
	                	end
	                end
	            end
        	end
        else
			if type(_ED.daily_task_draw_index) == "number" then
				return
			end
			for i = 1 ,4 do
				if nil == _ED.daily_task_draw_index[i] then
					return
				end
				if tonumber(_ED.daily_task_draw_index[i]) == 0 and tonumber(_ED.daily_task_integral) >= i*30 then
					return true
				end
			end
		end
	end
	if zstring.tonumber(_ED.daily_task_number) > 0 then
		for i, v in pairs(_ED.daily_task_info) do
			local opened = true
			local userDailyTask = v
			local dailyTaskMould = dms.element(dms["daily_mission_param"], userDailyTask.daily_task_mould_id)
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				if dailyTaskMould == nil then
					return
				end
				local ntype = dms.atoi(dailyTaskMould, daily_mission_param.ntype)
				if ntype == 1 then
					opened = false
				else
					local dailyTaskTrace = dms.atoi(dailyTaskMould, daily_mission_param.trace_function_id)
					if dailyTaskTrace > 0 then 
		                local open_function = dms.int(dms["function_param"], dailyTaskTrace, function_param.open_function)
		                if funOpenDrawTip(open_function, false) then
		                    opened = false
		                end
		            end
		        end
			end
			if opened == true then
			    local drawRewardState = zstring.tonumber(userDailyTask.daily_task_param)
			    if drawRewardState == 0 then
					local completeCount = zstring.tonumber(userDailyTask.daily_task_complete_count)


		    		local conditionParam = zstring.split(dms.atos(dailyTaskMould, daily_mission_param.condition_param), ",") -- 商城购买道具道具ID,次数的conditionParam值为模板id,次数
		    		local needCompleteCount =  zstring.tonumber(conditionParam[#conditionParam])
		    		if completeCount >= needCompleteCount then
		    			return true
		    		end
		    	end
		    end
		end
	end
	if notificationer._need_request ~= true then
		notificationer.startTime = notificationer.startTime or os.time()
		if (notificationer.startTime  + 4) > os.time() then
			return
		end

		notificationer._need_request = true
		if __lua_project_id == __lua_project_gragon_tiger_gate
			or __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			or __lua_project_id == __lua_project_red_alert 
			then
		else
			local function responseDailyMissionInitCallback(response)
		        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
		           
		        end
		    end
			protocol_command.daily_mission_init.param_list = ""
	        NetworkManager:register(protocol_command.daily_mission_init.code, nil, nil, nil, nil, responseDailyMissionInitCallback, false, nil)
        end
        return false
	end
end

function getDailyActivityAchievementTip(notificationer)
	if _ED.daily_task_achievement ~= nil then
		for i, v in pairs(_ED.daily_task_achievement) do
			local userDailyTask = v
		    local drawRewardState = zstring.tonumber(userDailyTask.daily_task_param)
		    local completeCount = zstring.tonumber(userDailyTask.daily_task_complete_count)

		    local dailyTaskMould = dms.element(dms["achieve"], userDailyTask.daily_task_mould_id)

		    local useType = dms.atoi(dailyTaskMould, achieve.param1)
		    
		    local ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_ESCALATE_LEVE = 3            --;//全部装备强化等级
			local ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_REFINE_LEVEL = 4            --;//全部装备精炼等级
		    local needCompleteCount = 0
		    if useType == ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_ESCALATE_LEVE 
		        or useType == ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_REFINE_LEVEL
		        then
		        needCompleteCount = dms.atoi(dailyTaskMould, achieve.param3)
		    else
		        needCompleteCount = dms.atoi(dailyTaskMould, achieve.param2)
		    end   
		    needCompleteCount = needCompleteCount or 100

		    local drawState = 0
		    if drawRewardState == 0 then
		       	drawState = 0
		    elseif drawRewardState == 1 then
		        if completeCount >= needCompleteCount then
		            drawState = 1
		        else
		            drawState = 0
		        end
		    else
		        drawState = 2
		    end 

		    if drawState == 1 then
		    	return true
		    end
		end
	end
	return false
end

--新版成就的推送
function getDailyActivityAchievementNewTip(notificationer)
	if _ED.all_achieve ~= nil and _ED.all_achieve ~= "" then
		for i, v in pairs(_ED.all_achieve) do
			local nowpersent = tonumber(v)
			local param2 = dms.int(dms["achieve"],i,achieve.param2) 
            local param3 = dms.int(dms["achieve"],i,achieve.param3) 
            local ty_id = tonumber(dms.string(dms["achieve"],i,achieve.open_level))

            local is_complete = false
            if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
            	if dms.int(dms["achieve"],i,achieve.group_id) == 0 then
            		if dms.int(dms["achieve"],i,achieve.achive_type) == 0 then
            			local maxpersent = 0
            			if param3 ~= -1 then
			                maxpersent = param3
			            else 
			                maxpersent = param2
			            end
            			if ty_id ~= nil then
            				if nowpersent >= maxpersent and ty_id ~= -1 then
				               	is_complete = true
				            end
            			end
            		elseif dms.int(dms["achieve"],i,achieve.achive_type) == 1 then
            			local star = tonumber(_ED.npc_state[dms.int(dms["achieve"],i,achieve.param1)])
            			if ty_id ~= nil then
            				if nowpersent >= param2 and ty_id ~= -1 and star > 0 then
				               	is_complete = true
				            end
            			end
            		end
            	end
            else
	            if param3 ~= -1 then
	                maxpersent = param3
	            else 
	                maxpersent = param2
	            end
	            if ty_id ~= nil then
		            if nowpersent >= maxpersent and ty_id ~= -1 then
		               	is_complete = true
		            end

	 				if tonumber(ty_id) == 10 then
		            	maxpersent = param2
			            if nowpersent >= maxpersent then
			            	-- print("==================",os.clock())
			            	-- print("=======true===============")		
			               	is_complete = true
			            end
		            end
		        end
		    end

		    if is_complete == true then
		    	-- 判断前置任务是否领取
		    	local beforeId = dms.int(dms["achieve"],i,achieve.before_id)
		    	if beforeId <= 0 or _ED.all_achieve[beforeId] == nil or tonumber(_ED.all_achieve[beforeId]) == -1 then
		    		return true
		    	end
		    end
		end
	end
	return false
end
--新版成就类型按钮的推送 
function getDailyActivityAchievementNewKindsTip(notificationer)
	-- print("==================",os.clock())
	local achieve_type = notificationer._datas._achieve_type
	if _ED.all_achieve ~= nil and _ED.all_achieve ~= "" then		
		for i, v in pairs(_ED.all_achieve) do
            local ty_id = tonumber(dms.string(dms["achieve"],i,achieve.open_level))
            if ty_id == achieve_type and ty_id ~= -1  then
            	local param2 = dms.int(dms["achieve"],i,achieve.param2) 
            	local param3 = dms.int(dms["achieve"],i,achieve.param3) 
            	local nowpersent = tonumber(v)
	            if param3 ~= -1 then
	                maxpersent = param3
	            else 
	                maxpersent = param2
	            end
	            
	            if nowpersent >= maxpersent then
	            	-- print("==================",os.clock())
	            	-- print("=======true===============")		
	               	return true
	            end      
	            if tonumber(achieve_type) == 10 then
	            	maxpersent = param2
		            if nowpersent >= maxpersent then
		            	-- print("==================",os.clock())
		            	-- print("=======true===============")		
		               	return true
		            end
	            end
	        end
		end
	end
	-- print("=================false=====")
	-- print("==================",os.clock())
	return false
end


function getDailyActivityTip(notificationer)
	if getDailyActivityTaskTip(notificationer) == true then
		return true
	end
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if getDailyActivityAchievementNewTip(notificationer) == true then
			return true
		end		
	else
		if getDailyActivityAchievementTip(notificationer) == true then
			return true
		end
	end
	return false
end

function getSevenDaysActivityTip_welfare_dayIndex(notificationer, dayIndex)
	
	if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto 
		or __lua_project_id == __lua_project_pokemon 
		or __lua_project_id == __lua_project_rouge 
		or __lua_project_id == __lua_project_yugioh 
		or __lua_project_id == __lua_project_warship_girl_b 
		then
		if dayIndex > zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) then
			return false
		end
	else
		if zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) < zstring.tonumber(_ED._sevenDaysActivity_selectActivityDayCount) then
			return false
		end
	end
	local welfares = _ED.active_activity[42].seven_days_rewards[dayIndex].welfare
	for i, v in pairs(welfares) do
		local welfare = v
		local completeCount = 0
    	local needCompleteCount = 0
    	local dailyEelfareElement = dms.element(dms["daily_welfare"], welfare.id)

    	local needGold = dms.atoi(dailyEelfareElement, daily_welfare.reward_need_gold)
	    if needGold > 0 then
	        completeCount = zstring.tonumber(_ED.active_activity[42].activity_recharge_gold)
	        needCompleteCount = needGold
	    end
	    local drawRewardState = zstring.tonumber(welfare.state)
	    local drawState = 0
	    if drawRewardState == 0 then
	        if completeCount >= needCompleteCount then
	            drawState = 1
	        else
	            drawState = 0
	        end
	    else
	        drawState = 2
	    end	
	    if drawState == 1 then
		--print("...............",dayIndex,_ED._sevenDaysActivity_currentActivityDayCount,_ED._sevenDaysActivity_selectActivityDayCount,needGold,drawRewardState)
	    	return true
	    end
	end
	return false
end

function getSevenDaysActivityTip_achievement_dayIndex_page(notificationer, dayIndex, pageIndex)
	if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto 
		or __lua_project_id == __lua_project_pokemon 
		or __lua_project_id == __lua_project_rouge 
		or __lua_project_id == __lua_project_yugioh 
		or __lua_project_id == __lua_project_warship_girl_b 
		then
		if dayIndex > zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) then
			return false
		end
	else
		if zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) < zstring.tonumber(_ED._sevenDaysActivity_selectActivityDayCount) then
			return false
		end
	end
	local ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_ESCALATE_LEVE = 3            --;//全部装备强化等级
    local ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_REFINE_LEVEL = 4            --;//全部装备精炼等级
	local ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_QUALITY_LEVEL = 5            --;//全部装备品质等级
	local ACHIEVE_TYPE_USER_BY_JJC_ORDER = 7            --;//竞技场排名

	local achievement_page = _ED.active_activity[42].seven_days_rewards[dayIndex].achievement_pages[pageIndex]

	for i, v in pairs(achievement_page._achievement_rewards) do
		local achievement_reward = v
		local completeCount = zstring.tonumber(achievement_reward.complete_count)
	    local drawRewardState = zstring.tonumber(achievement_reward.state)

	    local dailyTaskMould = dms.element(dms["achieve"], achievement_reward.id)
		local useType = dms.atoi(dailyTaskMould, achieve.param1)
		
		-- 866 上阵六名舰娘全部穿戴蓝色以上舾装（包括蓝色）资金×20000 4101 0 5 2 24 1,-1,20000 -1 -1 -1 3 0
		-- 0 是类型 5 2 24 是类型组成的3个参数
		-- 0类型中的第5项,2是指定的品质,24是需求数量
		
	    local needCompleteCount = 0
	    if useType == ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_ESCALATE_LEVE 
	        or useType == ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_REFINE_LEVEL
			or useType == ACHIEVE_TYPE_USER_BY_ALL_EQUIPMENT_QUALITY_LEVEL
	        then
	        needCompleteCount = dms.atoi(dailyTaskMould, achieve.param3)
	    else
	        needCompleteCount = dms.atoi(dailyTaskMould, achieve.param2)
	    end

		local drawState = 0
		if drawRewardState == 0 then
	        if useType == ACHIEVE_TYPE_USER_BY_JJC_ORDER or useType == 9 then

	            if completeCount > 0 then
	                if completeCount <= needCompleteCount then
	                    completeCount = needCompleteCount
	                     drawState = 1
	                else
	                    drawState = 0
	                end
	            else
	                drawState = 0
	            end
	        else
	            if completeCount >= needCompleteCount then
	                drawState = 1
	            else
	               	drawState = 0
	            end
	        end
	    else
	        drawState = 2
	    end
	    if drawState == 1 then
	    	return true
	    end
	end
	return false
end

function getSevenDaysActivityTip_achievement_dayIndex(notificationer, dayIndex)
	if zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) < zstring.tonumber(_ED._sevenDaysActivity_selectActivityDayCount) then
		return false
	end
	if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards then
		return false
	end
	local achievement_pages = _ED.active_activity[42].seven_days_rewards[dayIndex].achievement_pages
	for i, v in pairs(achievement_pages) do
		if getSevenDaysActivityTip_achievement_dayIndex_page(notificationer, dayIndex, i) == true then
			return true
		end
	end
	return false
end

function getSevenDaysActivityTip_welfare(notificationer)
	if zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) < zstring.tonumber(_ED._sevenDaysActivity_selectActivityDayCount) then
		return false
	end
	if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards then
		return false
	end
	local activity = _ED.active_activity[42]
	for i, v in pairs(activity.seven_days_rewards) do
		-- 福利是否可以领取
		local currentActivityDayCount = zstring.tonumber(activity.activity_day_count)
		if i <= currentActivityDayCount and getSevenDaysActivityTip_welfare_dayIndex(notificationer, i) == true then
			return true
		end
	end
	return false
end

function getSevenDaysActivityTip_achievements(notificationer)
	if zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) < zstring.tonumber(_ED._sevenDaysActivity_selectActivityDayCount) then
		return false
	end
	if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards then
		return false
	end
	local activity = _ED.active_activity[42]
	for i, v in pairs(activity.seven_days_rewards) do
		-- 成就是否可以领取
		local currentActivityDayCount = zstring.tonumber(activity.activity_day_count)
		if i <= currentActivityDayCount and getSevenDaysActivityTip_achievement_dayIndex(notificationer, i) == true then
			return true
		end
	end
	return false
end

function getSevenDaysActivityTip_propBuy_dayIndex(notificationer, dayIndex)
	if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto 
		or __lua_project_id == __lua_project_pokemon 
		or __lua_project_id == __lua_project_rouge 
		or __lua_project_id == __lua_project_yugioh 
		or __lua_project_id == __lua_project_warship_girl_b 
		then
		if dayIndex > zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) then
			return false
		end
	else
		if zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) < zstring.tonumber(_ED._sevenDaysActivity_selectActivityDayCount) then
			return false
		end
	end
	if nil == _ED.active_activity[42] or nil == _ED.active_activity[42].seven_days_rewards then
		return false
	end
	local sevenDaysReward = _ED.active_activity[42].seven_days_rewards[dayIndex]
	local drawRewardState = zstring.tonumber(sevenDaysReward.half_prop_buy_state)
	if drawRewardState == 0 then
		return true
	end
	return false
end

function getSevenDaysActivityTip_propBuy(notificationer)
	if zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) < zstring.tonumber(_ED._sevenDaysActivity_selectActivityDayCount) then
		return false
	end
	if _ED.active_activity[42] == nil then
		return false
	end
	local activity = _ED.active_activity[42]
	for i, v in pairs(activity.seven_days_rewards) do
		-- 道具是否可以购买
		local currentActivityDayCount = zstring.tonumber(activity.activity_day_count)
		if i <= currentActivityDayCount and getSevenDaysActivityTip_propBuy_dayIndex(notificationer, i) == true then
			return true
		end
	end
	return false
end

function getSevenDaysActivityTip_every_day(notificationer, dayIndex)
	if getSevenDaysActivityTip_welfare_dayIndex(notificationer, dayIndex) == true then
		return true
	end
	if getSevenDaysActivityTip_achievement_dayIndex_page(notificationer, dayIndex, 1) == true then
		return true
	end
	if getSevenDaysActivityTip_achievement_dayIndex_page(notificationer, dayIndex, 2) == true then
		return true
	end
	if getSevenDaysActivityTip_propBuy_dayIndex(notificationer, dayIndex) == true then
		return true
	end
	--如果是未开启的那天 应该不影响前几天的推送，所以这个return false 应该在后面
	if zstring.tonumber(_ED._sevenDaysActivity_currentActivityDayCount) < zstring.tonumber(_ED._sevenDaysActivity_selectActivityDayCount) then
		return false
	end
	return false
end


function getSevenDaysActivityTip(notificationer)
	if _ED.active_activity[42] == nil then
		return false
	end
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		for i = 1 , 5 do
			if getEveryDayRecharge(i) == true then
				return true
			end 
		end
		if getActivityEverydaysAllTarget() == true then
			return true
		end
	else
		if _ED.active_activity[42].seven_days_rewards == nil then
			if notificationer._need_request ~= true then
				if __lua_project_id == __lua_project_gragon_tiger_gate
					or __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					or __lua_project_id == __lua_project_red_alert 
					then
				else
					notificationer._need_request = true
				end
				notificationer.startTime = notificationer.startTime or os.time()
				if (notificationer.startTime  + 2) > os.time() then
					return
				end
				if __lua_project_id == __lua_project_gragon_tiger_gate
					or __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					or __lua_project_id == __lua_project_red_alert 
					then
					notificationer._need_request = true
				end
				protocol_command.week_active_init.param_list = "".._ED.active_activity[42].activity_day_count
		        NetworkManager:register(protocol_command.week_active_init.code, nil, nil, nil, nil, nil, false, nil)
		    end
			return false
		end
		
		if getSevenDaysActivityTip_welfare() == true then
			return true
		end
		if getSevenDaysActivityTip_achievements() == true then
			return true
		end
		if getSevenDaysActivityTip_propBuy() == true then
			return true
		end
	end
	return false
end

function getActivityNextDayTips()
	if _ED.active_activity[48] ~= nil and tonumber(_ED.active_activity[48].activity_isReward) == 1 then
		return true
	end
	return false
end

function getActivityEatManualTips()
	if tonumber(_ED._add_enger) > 0 then
		return true
	end
	return false
end

function getGodOfWealthTips()
	if tonumber(_ED.welcome_mammon.welcome_time_day_yet) < tonumber(_ED.welcome_mammon.welcome_time_day_sum) then
		if os.time()- tonumber(_ED.welcome_mammon.os_time) > _ED.welcome_mammon.cooling_times/1000 then
			return true
		end
	end
	return false
end

function getRechargeTips()
	if _ED.active_activity[4] ~= nil and _ED.active_activity[4]~="" then
		if __lua_project_id == __lua_project_yugioh then 
			local recharge_rmb_number = 0 
			if zstring.tonumber(_game_platform_version_type) == 2 then 
				--安卓渠道月卡不算首充	
				local counts = dms.count(dms["top_up_goods"])
				local sufficientStr = zstring.split(_ED.user_sufficient_type ,",")
	   			local isFristCharge = true
				for i=1,counts do
					local types = dms.int(dms["top_up_goods"],""..i,top_up_goods.goods_type)
					local value = zstring.tonumber(sufficientStr[i])
					--每个档位的充值状态
					if types == 0 and value > 0 then 	
						recharge_rmb_number = zstring.tonumber(_ED.recharge_rmb_number)
						break
					end
				end	
			else
				recharge_rmb_number = zstring.tonumber(_ED.recharge_rmb_number)			
			end
			if tonumber(recharge_rmb_number) > 0 and tonumber(_ED.active_activity[4].activity_id)==0 then
				return true
			end	
		else
			if tonumber(_ED.recharge_rmb_number) > 0 and tonumber(_ED.active_activity[4].activity_id)==0 then
				return true
			end				
		end
	end
	return false
end
function getSigntips()
	return getEveryDaySignCenterAllTips()
	-- if getDailyAttendanceTips() == true then
	-- 	return true
	-- elseif getLuxurySignTips() == true then
	-- 	return true
	-- end
	-- return false
end

function getDailyAttendanceTips()
	-- 是否可领取每日签到
	if _ED.active_activity[38] ~= nil and _ED.active_activity[38]~="" then
		if #_ED.active_activity[38].activity_Info > 0 then
			for i=1,#_ED.active_activity[38].activity_Info do
				if tonumber(_ED.active_activity[38].activity_Info[i].activityInfo_isReward) == 0 then
					if tonumber(_ED.active_activity[38].activity_login_day) >= tonumber(_ED.active_activity[38].activity_Info[i].activityInfo_need_day) then
						return true
					end
				end
			end
		end
	end
	return false
end

function getLuxurySignTips()
	-- 是否可领取豪华签到
	if _ED.active_activity[39] ~= nil and _ED.active_activity[39]~="" then
		if #_ED.active_activity[39].activity_Info > 0 then
			for i=1,#_ED.active_activity[39].activity_Info do
				if tonumber(_ED.active_activity[39].activity_Info[i].activityInfo_is_reach) == 1 then
					if tonumber(_ED.active_activity[39].activity_Info[i].activityInfo_isReward) == 0 then
						return true
					end
				end
				if tonumber(_ED.active_activity[39].activity_Info[i].activityInfo_is_reach) == 0 then
					if tonumber(_ED.active_activity[39].activity_login_Max_day) == i then
						return true
					end
				end
			end
		end
	end
	return false
end

function getTheCenteOfTheAward()
	if #_ED._reward_centre>0 then
		for i,v in pairs(_ED._reward_centre) do
			if v~= nil then
				return true
			end
		end
		return true
	end
	return false
end

function getRebelArmyRechargeTips()
	if _ED.active_activity[47] ~= nil and _ED.active_activity[47]~="" then
		if #_ED.active_activity[47].activity_Info > 0 then
			for i=1,#_ED.active_activity[47].activity_Info do
				if tonumber(_ED.active_activity[47].activity_Info[i].activityInfo_isReward) == 0 then
					return true
				end
			end
		end
	end
	return false
end

function getRebelArmyAttckRechargeTips()
	if _ED.active_activity[67] ~= nil and _ED.active_activity[67]~="" then
		if #_ED.active_activity[67].activity_Info > 0 then
			for i=1,#_ED.active_activity[67].activity_Info do
				if tonumber(_ED.active_activity[67].activity_Info[i].activityInfo_isReward) == 0 then
					return true
				end
			end
		end
	end
	return false
end

function getRebelArmyKillRechargeTips()
	if _ED.active_activity[66] ~= nil and _ED.active_activity[66]~="" then
		if #_ED.active_activity[66].activity_Info > 0 then
			for i=1,#_ED.active_activity[66].activity_Info do
				if tonumber(_ED.active_activity[66].activity_Info[i].activityInfo_isReward) == 0 then
					return true
				end
			end
		end
	end
	return false
end


function getOnceRechargeTips()
	if _ED.active_activity[45] ~= nil and _ED.active_activity[45]~="" then
		if #_ED.active_activity[45].activity_Info > 0 then
			for i=1,#_ED.active_activity[45].activity_Info do
				if tonumber(_ED.active_activity[45].activity_Info[i].activityInfo_isReward) == 0 then
					return true
				end
			end
		end
	end
	return false
end
function getActivityLoginGiftGivingTips()
	if _ED.active_activity[24] ~= nil and _ED.active_activity[24]~="" then
		if #_ED.active_activity[24].activity_Info > 0 then
			for i=1,#_ED.active_activity[24].activity_Info do
				if tonumber(_ED.active_activity[24].activity_Info[i].activityInfo_isReward) == 0 then
					if tonumber(_ED.active_activity[24].activity_Info[i].activityInfo_need_day) <= tonumber(_ED.active_activity[24].activity_login_day) then
						return true
					end	
				end
			end
		end
	end
	return false
end

function getOneDayRechargeTips(m_type)
	local activity = ""
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		m_type = m_type or 77
		activity = _ED.active_activity[m_type]
		if activity ~= nil and activity~="" then
			local currDatas = zstring.split(activity.activity_params, "|")
			local rewardInfo = zstring.split(currDatas[1], ",")
		    local rechargeCountData = zstring.split(currDatas[2], ",")
			for i = 1 , 5 do
		        if tonumber(activity.activity_Info[i].activityInfo_need_day) <= tonumber(rechargeCountData[i]) then
		            if tonumber(rewardInfo[i]) ~= 1 then
		                return true
		            end
		        end
		    end
		end
	else
		activity = _ED.active_activity[21]
		if activity ~= nil and activity~="" then
			if #activity.activity_Info > 0 then
				for i=1,#activity.activity_Info do
					if tonumber(activity.activity_Info[i].activityInfo_isReward) == 0 then
						return true
					end
				end
			end
		end
	end
	return false
end

function getAccumlateRechargeableTips(m_type)
	local activity_type = 7
	if __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon
		or __lua_project_id == __lua_project_l_naruto
		then
		activity_type = m_type or 7
	end
	if _ED.active_activity[activity_type] ~= nil and _ED.active_activity[activity_type]~="" then
		if #_ED.active_activity[activity_type].activity_Info > 0 then
			for i=1,#_ED.active_activity[activity_type].activity_Info do
				if tonumber(_ED.active_activity[activity_type].activity_Info[i].activityInfo_isReward) == 0 then
					return true
				end
			end
		end
	end
	return false
end

function getActivityMonthCardIsNotBuy( ... )
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		local _drawMonth = dms2.searchs(dms["top_up_goods"], top_up_goods.goods_type, 1)
		if _drawMonth == nil or _drawMonth[1] == nil or _drawMonth[1][1] == nil  then
			return false
		end
		local monthCount = table.getn(_drawMonth)

		if monthCount ~= 0 then
			local monthCardDayOne = _ED.month_card[_drawMonth[1][1]].surplus_month_card_time	--第一种月卡天数
			local monthCardStateOne = _ED.month_card[_drawMonth[1][1]].draw_month_card_state		--第一种月卡领取状态
			if tonumber(monthCardDayOne) == 0 and tonumber(monthCardStateOne) == 0 then
				return true
			end
			if monthCount == 1 then
				return false
			end
			local monthCardDayTwo = _ED.month_card[_drawMonth[2][1]].surplus_month_card_time	--第二种月卡天数
			local monthCardStateTwo = _ED.month_card[_drawMonth[2][1]].draw_month_card_state		--第二种月卡领取状态
			if tonumber(monthCardDayTwo) == 0 and tonumber(monthCardStateTwo) == 0 then
				return true
			end		
		end
		return false
	end
end
function getActivityMonthCardTips()
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		return false
	end
	local _drawMonth = dms2.searchs(dms["top_up_goods"], top_up_goods.goods_type, 1)
	if _drawMonth == nil or _drawMonth[1] == nil or _drawMonth[1][1] == nil  then
		return false
	end
	local monthCount = table.getn(_drawMonth)

	if monthCount ~= 0 then
		if nil == _ED.month_card[_drawMonth[1][1]] then
			return false
		end
		local monthCardDayOne = _ED.month_card[_drawMonth[1][1]].surplus_month_card_time	--第一种月卡天数
		local monthCardStateOne = _ED.month_card[_drawMonth[1][1]].draw_month_card_state		--第一种月卡领取状态
		if tonumber(monthCardDayOne) > 0 then
			if tonumber(monthCardStateOne) == 0 then
				return true
			end
		end	
		if __lua_project_id == __lua_project_gragon_tiger_gate
			or __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			or __lua_project_id == __lua_project_red_alert
			then
			if monthCount == 1 then
				return false
			end
			local monthCardDayTwo = _ED.month_card[_drawMonth[2][1]].surplus_month_card_time	--第二种月卡天数
			local monthCardStateTwo = _ED.month_card[_drawMonth[2][1]].draw_month_card_state		--第二种月卡领取状态
			if tonumber(monthCardDayTwo) > 0 then
				if tonumber(monthCardStateTwo) == 0 then
					return true
				end
			end				
		else
			local monthCardDayTwo = _ED.month_card[_drawMonth[2][1]].surplus_month_card_time	--第二种月卡天数
			local monthCardStateTwo = _ED.month_card[_drawMonth[2][1]].draw_month_card_state		--第二种月卡领取状态
			if tonumber(monthCardDayTwo) > 0 then
				if tonumber(monthCardStateTwo) == 0 then
					return true
				end
			end	
		end
	end
	if __lua_project_id == __lua_project_gragon_tiger_gate
		--or __lua_project_id == __lua_project_l_digital
		--or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if getActivityMonthCardIsNotBuy() == true then
			return true
		end
	end
	return false
end

function getAccumlateConsumptionTips(activity_type)
	if _ED.active_activity[activity_type] ~= nil and _ED.active_activity[activity_type]~="" then
		if #_ED.active_activity[activity_type].activity_Info > 0 then
			for i=1,#_ED.active_activity[activity_type].activity_Info do
				if tonumber(_ED.active_activity[activity_type].activity_Info[i].activityInfo_isReward) == 0 then
					return true
				end
			end
		end
	end
	return false
end

--
function getOpenServerAcivityTips_FundActivity_recharge()
	-- 全服基金活动
	if tonumber(_ED.user_info.user_grade) <= dms.int(dms["fun_open_condition"], 150, fun_open_condition.level) then
		if _ED.active_activity[27] ~= nil and _ED.active_activity[27]~="" then
	        local vipLevel = zstring.tonumber(_ED.vip_grade)
	        local activity = _ED.active_activity[27]
	        local needVipLevel = zstring.tonumber(activity.limit_vip_level)
	        local needGold = zstring.tonumber(activity.price_gold)
	        if vipLevel < needVipLevel then
	        	return true
	        end
		end
	end
	return false
end

function getOpenServerAcivityTips_FundActivity_buy()
	-- 全服基金活动
	if tonumber(_ED.user_info.user_grade) <= dms.int(dms["fun_open_condition"], 150, fun_open_condition.level) then
		if _ED.active_activity[27] ~= nil and _ED.active_activity[27]~="" then
			local activity = _ED.active_activity[27]
	    	local buyed = activity.activity_isReward == "0"
	    	local vipLevel = zstring.tonumber(_ED.vip_grade)
	    	local needVipLevel = zstring.tonumber(activity.limit_vip_level)
	    	if buyed == true and vipLevel >= needVipLevel then
	    		return true
	    	end
		end
	end
	return false
end

function getOpenServerAcivityTips_FundActivity()
	-- 全服基金活动
	if _ED.active_activity[27] ~= nil and _ED.active_activity[27]~="" then
		-- local activity = _ED.active_activity[27]
  --   	local buyed = activity.activity_isReward == "0"
  --   	if buyed == true then
 		if getOpenServerAcivityTips_FundActivity_buy() == true then
    		return true
    	elseif getOpenServerAcivityTips_FundActivity_recharge() == true then
    		return true
    	else
			if #_ED.active_activity[27].activity_Info > 0 then
				for i=1,#_ED.active_activity[27].activity_Info do
					if tonumber(_ED.active_activity[27].activity_Info[i].activityInfo_isReward) == 0 then
			    		local drawRewardState = 0
						local needCompleteCount = 0
						local completeCount = -1
						local activityReward = _ED.active_activity[27].activity_Info[i]
						local needUserLevel = zstring.tonumber(activityReward.activityInfo_need_day)
						local userLevel = zstring.tonumber(_ED.user_info.user_grade)
						drawRewardState = zstring.tonumber(activityReward.activityInfo_isReward)
						needCompleteCount = needUserLevel
						completeCount = userLevel
						if completeCount >= needCompleteCount then
							return true
						end
					end
				end
			end
    	end
	end
	return false
end

function getOpenServerAcivityTips_WelfareActivity()
	if _ED.active_activity[41] ~= nil and _ED.active_activity[41]~="" then
		if #_ED.active_activity[41].activity_Info > 0 then
			for i=1,#_ED.active_activity[41].activity_Info do
				if tonumber(_ED.active_activity[41].activity_Info[i].activityInfo_isReward) == 0 then
		    		local drawRewardState = 0
					local needCompleteCount = 0
					local completeCount = -1
					local activityReward = _ED.active_activity[41].activity_Info[i]
					local needBuyCount = zstring.tonumber(activityReward.activityInfo_need_day)
					local buyCount = zstring.tonumber(_ED.active_activity[41].activity_buy_count)
					drawRewardState = zstring.tonumber(activityReward.activityInfo_isReward)
					needCompleteCount = needBuyCount
					completeCount = buyCount
					if completeCount >= needCompleteCount then
						return true
					end
				end
			end
		end
	end
	return false
end

function getOpenServerAcivityTips()
	if __lua_project_id == __lua_project_l_digital
        or __lua_project_id == __lua_project_l_pokemon 
        or __lua_project_id == __lua_project_l_naruto
        then
        if tonumber(_ED.user_info.user_grade) < dms.int(dms["fun_open_condition"], 150, fun_open_condition.level) then
        	return false
        end
        local need_vip = 0
        if _ED.active_activity[27] ~= nil then
        	need_vip = tonumber(_ED.active_activity[27].limit_vip_level)
        end
        if need_vip > tonumber(_ED.vip_grade) then
        	return false
        end
    end 
	if getOpenServerAcivityTips_FundActivity() == true then
		return true
	end

	if getOpenServerAcivityTips_WelfareActivity() == true then
		return true
	end
	return false
end

function getClickHeroShopTips()
	-- 刷新状态一直存在,则直接取刷新状态
	if _ED.secret_shop_is_refresh ~= true then
		if _ED.secret_shop_init_info.os_time ~= nil then
			local times = os.time()- tonumber(_ED.secret_shop_init_info.os_time)
			if times > _ED.secret_shop_init_info.refresh_time/1000 then -- 当前时间减去登录那一刻的时间大于服务器返回的剩余时间。就说明可以免费招了
				_ED.secret_shop_is_refresh = true
			end
		end
	end
	return _ED.secret_shop_is_refresh 
end

-- 显示vip礼包的推送
function getActivityVipPackageTips()
	local activity = _ED.active_activity[40]
	if nil ~= activity then
		if nil == _ED.vip_package_buy_state then
			local vip_data = zstring.split(activity.activity_extra_prame, "!") 	--vip礼包对应档位
			local vip_buy_state_data = activity.activity_extra_prame2 			--vip礼包对应档位购买状态
			local each_vip_buy_data = zstring.split(vip_buy_state_data, ",")
			_ED.vip_package_buy_state = each_vip_buy_data
		end
		
		local currentVIP = zstring.tonumber(_ED.vip_grade)
		for i = 1 , currentVIP+1 do
			if _ED.vip_package_buy_state[i] ~= "1" then
				return true
			end
		end
		
	end

	return false
end
--等级奖励
function getLevelPacksCanGet()
	if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_l_digital
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		then
		if _ED.active_activity[12] == nil or _ED.active_activity[12]=="" then
			return false
		end
		for i,v in pairs(_ED.active_activity[12].activity_Info) do
			local level_tabel = zstring.split(_ED.active_activity[12].activity_login_day,",")
            if v.activityInfo_isReward == "0" and tonumber(level_tabel[i]) <= tonumber(_ED.user_info.user_grade) then
				return true
            end
        end

        return false
	end
end


function getLoingReward()
	local activity = _ED.active_activity[24]
	if activity ~= nil and activity ~= "" then
		local currDay = tonumber(activity.activity_login_day)
		for i , v in pairs(activity.activity_Info) do
			if tonumber(v.activityInfo_need_day) <= currDay
				and tonumber(v.activityInfo_isReward) == 0 then
				return true
			end
		end
	end
	return false
end

--开服狂欢标签页推送
function getActivityEverydaysPage(pageIndex , _page)
	if _ED.active_activity[42] == nil or _ED.active_activity[42] == "" then
		return false
	end 
	local _window = fwin:find("SevenDaysWelfareClass")
	local dayIndex = 0
	if _window ~= nil then
		dayIndex = _window.dayIndex
		-- if _page == true then
		-- 	if pageIndex == tonumber(_window._controlers[dayIndex].selector_index) then
		-- 		return false
		-- 	end
		-- end
		for i ,v in pairs(_ED.active_activity[42].seven_days_rewards[dayIndex].achievement_pages[pageIndex]._achievement_rewards) do
			local nowpersent = tonumber(v.complete_count)
			local mouldID = tonumber(v.id)
			local maxpersent = 0
			local dailyTaskMould = dms.element(dms["achieve"], mouldID)
			local param2 = dms.atoi(dailyTaskMould,achieve.param2)
			local param3 = dms.atoi(dailyTaskMould,achieve.param3)
			if param3 ~= -1 then
	            maxpersent = param3
	        else 
	            maxpersent = param2
	        end 
	        if dayIndex == 4 and pageIndex == 2 then
				if tonumber(v.state) == 0 and nowpersent > 0 and nowpersent <= maxpersent then
					return true
				end
			else
				if tonumber(v.state) == 0 and nowpersent >= maxpersent then
					return true
				end
			end
		end
	end
	return false
end

function getActivityEverydaysAllTarget()
	local activity = _ED.active_activity[42]
	if activity == nil or activity == "" then
		return false
	end
	local overTime = activity.activity_over_time/1000 - (os.time() - activity.activity_current_time) - 24 * 3600
	if overTime > 0 then
		return false
	end
	local currProgress = activity.activity_addition_param
    if currProgress ~= nil and currProgress ~= "" then 
    	currProgress = zstring.split(currProgress , ",")
    	if tonumber(currProgress[2]) > 0 then
    		return false
    	end
    end
	local currComplete = 0
	if activity.seven_days_rewards ~= nil then
	    for i , v in pairs(activity.seven_days_rewards) do
	        if i < 6 then
	            local achieveIdS = zstring.splits(dms.string(dms["carnival_mould"] , i ,carnival_mould.achive),"|", ",")
	            for j , w in pairs(v.achievement_pages) do
	                for k , u in pairs(w._achievement_rewards) do
	                    local nowpersent = u.complete_count
	                    local maxpersent = 0
	                    local achieveId = achieveIdS[j][k]
	                    local dailyTaskMould = dms.element(dms["achieve"], achieveId)
	                    local param2 = dms.atoi(dailyTaskMould,achieve.param2) 
	                    local param3 = dms.atoi(dailyTaskMould,achieve.param3) 
	                    if param3 ~= -1 then
	                        maxpersent = param3
	                    else 
	                        maxpersent = param2
	                    end
	                    if tonumber(u.state) == 1 and tonumber(nowpersent) >= tonumber(maxpersent) then
	                        currComplete = currComplete + 1
	                    end
	                end
	            end
	        end
	    end
    end
    if currComplete >= 10 then
    	return true
    end
	return false
end

--抽卡送拉拉兽
function getActivitySmCompageCount1(activity_type)
	local activity = _ED.active_activity[activity_type]
	if activity == nil or activity == "" then
		return false
	end
	local other_info = zstring.split(activity.activity_params ,"|")
	local all_number = zstring.split(other_info[1] ,",")
	local silver_number = tonumber(all_number[1])
	local golds_number = tonumber(all_number[2])
	for i , v in pairs(activity.activity_Info) do
		if tonumber(v.activityInfo_isReward) == 0 then
			local cost_type = zstring.split(v.activityInfo_need_day ,",")
			local needNumber = 0
			if tonumber(cost_type[1]) == 0 then
				needNumber = silver_number
			else
				needNumber = golds_number
			end
			if needNumber >= tonumber(cost_type[2]) then
				return true
			end 
		end
	end
	return false
end
--招募数码兽
function getActivitySmCompageCount2()
	local activity = _ED.active_activity[82]
	if activity == nil or activity == "" then
		return false
	end
	local other_info = zstring.split(activity.activity_params ,"|")
	local activity_params = other_info[1]
	if activity_params == "" or activity_params == nil then
		return false
	end
	local getShipIds = zstring.split(activity_params, ",")
	for i , v in pairs(activity.activity_Info) do
		if tonumber(v.activityInfo_isReward) == 0 then
			local shipIds = zstring.split(v.activityInfo_need_day,",")
			local shipId = tonumber(shipIds[1])
			for j , k in pairs (getShipIds) do
				if tonumber(k) == shipId then
					return true
				end
			end
		end
	end 
	return false
end
--竞技场积分奖励
function getActivitySmCompageCount3()
	local activity = _ED.active_activity[83]
	if activity == nil or activity == "" then
		return false
	end
	if activity.activity_params == "" or tonumber(activity.activity_params) == 0 then
		return false
	end
	local currPoint = tonumber(activity.activity_params)
	for i , v in pairs(activity.activity_Info) do
		if tonumber(v.activityInfo_isReward) == 0 then
			if currPoint >= tonumber(v.activityInfo_need_day) then
				return true
			end 
		end
	end
	return false
end

--95-115活动推送集（中间部分活动不在里面）
function getActivitySmBuyGoldRewardPushInfo(activity_type)
	local activity = _ED.active_activity[activity_type]
	if activity == nil or activity == "" then
		return false
	end
	if tonumber(activity_type) == 113 then
		local other_info = zstring.split(activity.activity_params, "|")
		for i , v in pairs(activity.activity_Info) do
			local isComplete = tonumber(zstring.split(other_info[i], ",")[2])
			local max = tonumber(zstring.split(v.activityInfo_need_day, ",")[2])
			if tonumber(v.activityInfo_isReward) == 0 then
				if isComplete >= max then
					return true
				end 
			end
		end
	else
		if activity.activity_params == "" or tonumber(activity.activity_params) == 0 then
			return false
		end
		local currPoint = zstring.tonumber(zstring.split(activity.activity_params, "|")[1])
		for i , v in pairs(activity.activity_Info) do
			if tonumber(v.activityInfo_isReward) == 0 then
				if currPoint >= tonumber(v.activityInfo_need_day) then
					return true
				end 
			end
		end
	end
	return false
end

-- 充值返钻
function getRechargeReturnRewardTips( ... )
	local activity_info = _ED.active_activity[107]
	if activity_info == nil then
		return false
	end
    local activity_params = zstring.split(activity_info.activity_params, ",")
    for k, v in pairs(activity_info.activity_Info) do
        if tonumber(v.activityInfo_isReward) == 0 and tonumber(activity_params[k]) == 1 then
            return true
        end
    end
    return false
end

-- 活跃度
function getActivityActivePush( ... )
	if funOpenDrawTip(180, false) == true then
		return false
	end
	for k, v in ipairs(_ED.daily_task_info) do
		if zstring.tonumber(v.daily_task_param) == 0 then
        	local dailyTaskMould = dms.element(dms["daily_mission_param"], v.daily_task_mould_id)
        	if dailyTaskMould ~= nil then
	            local ntype = dms.atoi(dailyTaskMould, daily_mission_param.ntype)
	            if ntype == 1 then
	                local completeCount = zstring.tonumber(v.daily_task_complete_count)
	                local conditionParam = zstring.split(dms.atos(dailyTaskMould, daily_mission_param.condition_param), ",")
	                local needCompleteCount = zstring.tonumber(conditionParam[#conditionParam])
	                if completeCount >= needCompleteCount then
	                	return true
	                end
	            end
	        end
        end
    end
    if _ED.daily_task_draw_index ~= nil then
	    for k,v in pairs(_ED.daily_task_draw_index) do
	        if tonumber(v) == 0 then
	        	local needActive = dms.int(dms["active_reward"], k, active_reward.need_active)
		        if _ED.daily_task_integral >= needActive then
		            return true
		        end
	        end
	    end
	end
	return false
end

function getActivitySmRechargeMonthCard( ... )
	-- local m_isVisible = false
	-- if zstring.tonumber(_ED.server_review) ~= 1 then
 --        for i,v in pairs(_ED.month_card) do
 --            if tonumber(v.surplus_month_card_time) == 0 then
 --                m_isVisible = true
 --                break
 --            end
 --        end
 --    end
 --    if m_isVisible == false then
 --    	return false
 --    end
	return false
end

--每日一推
function getActivitySmIsNextDayPush( activity_type ,key )
	local activity = _ED.active_activity[tonumber(activity_type)]
	if tonumber(activity_type) < 1000
		and (activity == nil or activity == "")
		then
		return false
	end
	if tonumber(activity_type) == 78
		or tonumber(activity_type) == 79
		or tonumber(activity_type) == 80
		then
		if funOpenDrawTip(activity_type + 75, false) == true then
			return false
		end
	elseif tonumber(activity_type) == 93 then
		if funOpenDrawTip(152, false) == true then
			return false
		end
	elseif tonumber(activity_type) == 27 then
		if funOpenDrawTip(150, false) == true then
			return false
		end
		-- local need_vip = 0
  --       if _ED.active_activity[27] ~= nil then
  --       	need_vip = tonumber(_ED.active_activity[27].limit_vip_level)
  --       end
  --       if need_vip > tonumber(_ED.vip_grade) then
  --       	return false
  --       end
	end
	local lastReadTimes = cc.UserDefault:getInstance():getStringForKey(getKey("activity_push_"..key))
	if lastReadTimes == nil or lastReadTimes == "" then
		return true
	end
	lastReadTimes = zstring.split(lastReadTimes, "-")
	if #lastReadTimes <= 1 then
		lastReadTimes = zstring.split(os.date("%Y".."-".."%m".."-".."%d".."-".."%H", lastReadTimes[1]), "-")
	end
	lastReadTimes[4] = lastReadTimes[4] or 0
	local nowTimes = os.date("%Y".."-".."%m".."-".."%d".."-".."%H", getBaseGTM8Time(_ED.system_time + (os.time() - _ED.native_time)))
	nowTimes = zstring.split(nowTimes , "-")
	-- if tonumber(lastReadTimes[1]) < tonumber(nowTimes[1]) then
	-- 	return true
	-- end
	-- if tonumber(lastReadTimes[2]) < tonumber(nowTimes[2]) then
	-- 	return true
	-- end
	local lastTime = os.time({year=tonumber(lastReadTimes[1]), month=tonumber(lastReadTimes[2]), day=tonumber(lastReadTimes[3]), hour=tonumber(lastReadTimes[4]), min=0, sec=0})
	local nowTime = os.time({year=tonumber(nowTimes[1]), month=tonumber(nowTimes[2]), day=tonumber(nowTimes[3]), hour=tonumber(nowTimes[4]), min=0, sec=0})
	if nowTime - lastTime >= 24*3600 then
		return true
	else
		if (tonumber(lastReadTimes[3]) ~= tonumber(nowTimes[3]) and tonumber(nowTimes[4]) >= 5)
			or (tonumber(lastReadTimes[3]) == tonumber(nowTimes[3]) 
				and zstring.tonumber(lastReadTimes[4]) < 5
				and tonumber(nowTimes[4]) >= 5)
			then
			return true
		end
	end
	return false
end

-- 限时宝箱
function getSmActivityLimitedTimeBoxTips(notificationer)
	if getSmActivityLimitedTimeBoxFreeTips() == true then
		return true
	end
	if getSmActivityLimitedTimeBoxScoreRewardTips() == true then
		return true
	end
	return false
end

-- 限时宝箱免费次数
function getSmActivityLimitedTimeBoxFreeTips()
	if funOpenDrawTip(164, false) == true then
		return false
	end
	if _ED.active_activity ~= nil and _ED.active_activity[89] ~= nil then
	    local activity_params = zstring.split(_ED.active_activity[89].activity_params, "!")
    	if (os.time() + _ED.time_add_or_sub) > tonumber(activity_params[6]) / 1000 then
    		return false
		end
	    local activity_params_info = zstring.split(activity_params[1], ",")
	    local is_free = tonumber(activity_params_info[1])
	    local end_time = tonumber(activity_params[6])
	    if is_free == 0 and (os.time() + _ED.time_add_or_sub) < end_time then
	        return true
	    end
	end
	return false
end

-- 限时宝箱积分宝箱
function getSmActivityLimitedTimeBoxScoreRewardTips()
	if _ED.active_activity ~= nil and _ED.active_activity[89] ~= nil then
		local activity_params = zstring.split(_ED.active_activity[89].activity_params, "!")
    	if (os.time() + _ED.time_add_or_sub) > tonumber(activity_params[6]) / 1000 then
    		return false
		end
	    local activity_params = zstring.split(_ED.active_activity[89].activity_params, "!")
	    local activity_params_info = zstring.split(activity_params[1], ",")
	    -- 积分宝箱领取状态
	    local current_score = tonumber(activity_params_info[2])             -- 当前积分
	    for k, v in pairs(_ED.active_activity[89].activity_Info) do
	    	local need_score = tonumber(v.activityInfo_need_day)
	    	if current_score >= need_score and tonumber(v.activityInfo_isReward) == 0 then
	    		return true
	    	end
	    end
	end
	return false
end

-- 砸金蛋活动推送
function getSmSmokedEggsPushTips(activity_type)
	if _ED.active_activity ~= nil and _ED.active_activity[activity_type] ~= nil then
		local other_info = zstring.split(_ED.active_activity[activity_type].activity_params, "|")
	    local get_info = zstring.split(other_info[1], ",")
	    local leave_count = tonumber(get_info[2]) 		-- 砸金蛋剩余次数
	    if leave_count > 0 then
	    	return true
	    end
	end
    return false
end

-- 大耳有福活动推送
function getSmWelcomeMoneyManPushTips()
	if _ED.active_activity ~= nil and _ED.active_activity[14] ~= nil then
		local current_times = 0
		local remainArr = zstring.split("" .._ED.active_activity[14].activity_extra_prame, ",")
		if _ED.welcome_money == nil then 
			current_times = 0
			for i,v in pairs(remainArr) do
				if zstring.tonumber(v) == 1 then 
					current_times = i
				end
			end
		else
			current_times = zstring.tonumber(_ED.welcome_money.current_times)
		end
		local times_info = zstring.split(dms.string(dms["activity_config"], 12, pirates_config.param), "|")
		local need_vip = 0
		local totalTimes = 0
		for k, v in pairs(times_info) do
			local info = zstring.split(v, ",")
			if tonumber(_ED.vip_grade) >= tonumber(info[1]) then
				totalTimes = tonumber(info[2])
			end
		end
		if current_times < totalTimes then
			return true
		end
	end
    return false
end

-- VIP 特权礼包推送
function getSmVipGiftPushTips()
	if _ED.return_vip_prop == nil then
		return false
	end

	for k, v in pairs(_ED.return_vip_prop) do
		if k == 1 then
			if getRechargeTips() == true then
				return true
			end
		else
			if tonumber(_ED.vip_grade) >= tonumber(v.VIP_can_buy) and tonumber(v.buy_times) == 0 then
				if k >= 17 then
					if funOpenDrawTip(166 + k - 17, false) == false then
						return true
					end
				else
					return true
				end
			end
		end
	end
	return false
end

function getSmActivityEatManualShow( ... )
	local add_enger_info = zstring.split(_ED._add_enger_info,"|")
	for k,v in pairs(add_enger_info) do
		local add_enger_data = zstring.split(v, ",")
		if tonumber(add_enger_data[1]) == 0 then
			return true
		end
	end
	return false
end

-- 体力领取推送
function getSmActivityEatManualTips()
	if zstring.tonumber(_ED.user_info.create_time) == 0 then
		return false
	end
	local energyData = zstring.split(dms.string(dms["activity_config"], 1, activity_config.param), "|")
	local add_enger_info = zstring.split(_ED._add_enger_info,"|")
	-- 判断是否有可以补领的体力
	for i=1, 4 do
		local add_enger_data = zstring.split(add_enger_info[i],",")
		if tonumber(add_enger_data[1]) == 0 then
			local energy_info = zstring.split(energyData[i], ",")
			local energy_infok1 = zstring.split(energy_info[1], ":")
			local energy_infok2 = zstring.split(energy_info[2], ":")

			local current = _ED.system_time + (os.time() - _ED.native_time)
			local earlyMorning1 = tonumber(zstring.split(energy_info[1], ":")[1])*3600
			local earlyMorning2 = tonumber(zstring.split(energy_info[2], ":")[1])*3600
	        local temp = os.date("*t", getBaseGTM8Time(zstring.tonumber(current)))
	        local m_hour    = tonumber(string.format("%02d", temp.hour))
	        local m_min     = tonumber(string.format("%02d", temp.min))
	        local m_sec     = tonumber(string.format("%02d", temp.sec))
	        local createUserData = os.date("*t", getBaseGTM8Time(zstring.tonumber(_ED.user_info.create_time)))
	        local createUserTimes = zstring.tonumber(string.format("%02d", createUserData.hour))*3600 + tonumber(string.format("%02d", createUserData.min))*60 + tonumber(string.format("%02d", createUserData.sec))
			if createUserData.year ~= temp.year
                or createUserData.month ~= temp.month
                or createUserData.day ~= temp.day
                or createUserTimes <= earlyMorning2 then
		        local newTimes = m_hour*3600+m_min*60+m_sec
				if newTimes > earlyMorning2 then
					return true
				end
			end
		end
	end
	return false
end

-- 
function getRechargeForSixtyGiftActivityTips( activity_type )
	if _ED.active_activity ~= nil and _ED.active_activity[activity_type] ~= nil then
		local other_info = zstring.split(_ED.active_activity[activity_type].activity_params, "|")
	    local get_info = zstring.split(other_info[1], ",")
	    local leave_count = tonumber(get_info[1])
	    local activityRewardInfo = _ED.active_activity[activity_type].activity_Info[1]
	    if leave_count > 0 and "1" ~= activityRewardInfo.activityInfo_isReward then
	    	return true
	    end
	end
    return false
end

function getRechargeForBadgeLoginActivityTips( activity_type )
	if _ED.active_activity ~= nil and _ED.active_activity[activity_type] ~= nil then
		local activity_params = tonumber(_ED.active_activity[activity_type].activity_params)
		for i,v in pairs(_ED.active_activity[activity_type].activity_Info) do
			if i<=activity_params then
				if tonumber(v.activityInfo_isReward) == 0 then
					return true
				end
			end
		end
	end
    return false
end

function getRechargeForTimeLimitBadgeActivityTips( activity_type )
	if _ED.active_activity ~= nil and _ED.active_activity[activity_type] ~= nil then
		local other_info = zstring.split(_ED.active_activity[activity_type].activity_params, ",")
		for i,v in pairs(_ED.active_activity[activity_type].activity_Info) do
			local exchangeInfos = zstring.split(v.activityInfo_need_day, "@")
			if (tonumber(exchangeInfos[2]) - tonumber(other_info[i])) > 0 then
				local need_day = zstring.split(exchangeInfos[1], ":")
				local isNeed = true
				for i,w in pairs(need_day) do
					local needData = zstring.split(w, ",")
					if tonumber(getPropAllCountByMouldId(needData[1])) < tonumber(needData[2]) then
						isNeed = false
						break
					end
				end
				if isNeed == true then
					return true
				end
			end
		end
	end
    return false
end

function getRechargeForTaskBadgeActivityTips( activity_type )
	if _ED.active_activity ~= nil and _ED.active_activity[activity_type] ~= nil then
		local other_info = zstring.split(_ED.active_activity[activity_type].activity_params, "|")
		for i,v in pairs(_ED.active_activity[activity_type].activity_Info) do
			local get_info = zstring.split(other_info[i], ",")
			local need_day = zstring.split(v.activityInfo_need_day, ",")
			if tonumber(get_info[2]) >= tonumber(need_day[2]) then
				if tonumber(v.activityInfo_isReward) == 0 then
					return true
				end
			end
		end
	end
    return false
end

-- 数码活动推送状态
function getSmActivityPushStateTips(activity_type)
	if activity_type == nil or activity_type == 0 then
		-- 全部刷新
		push_notification_center_activity_all_push_state = {}
		return
	end
	push_notification_center_activity_all_push_state[""..activity_type] = nil
	-- 登陆奖励
	if tonumber(activity_type) == 24 then
		if getLoingReward() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	if tonumber(activity_type) == 38 then
		if getEveryDaySignCenterAllTips() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 开服基金
	if tonumber(activity_type) == 27 then
		if getOpenServerAcivityTips() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 限时宝箱
	if tonumber(activity_type) == 89 then	
		if getSmActivityLimitedTimeBoxTips() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 七日活动
	if tonumber(activity_type) == 42 then	
		if getSevenDaysActivityTip() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 金币砸金蛋
	if tonumber(activity_type) == 87 then	
		if getSmSmokedEggsPushTips(87) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 钻石砸金蛋
	if tonumber(activity_type) == 88 then	
		if getSmSmokedEggsPushTips(88) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 大耳有福
	if tonumber(activity_type) == 14 and funOpenDrawTip(163, false) == false then	
		if getSmWelcomeMoneyManPushTips() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 首冲
	if tonumber(activity_type) == 4 then	
		if getRechargeTips() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- VIP礼包
	if tonumber(activity_type) == 1002 then
		if getSmVipGiftPushTips() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end

	-- 累计充值
	if tonumber(activity_type) == 7 or tonumber(activity_type) == 92  then
		if getAccumlateRechargeableTips(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 每日充值
	if tonumber(activity_type) == 77 
		or tonumber(activity_type) == 91
		or tonumber(activity_type) == 117 
		or tonumber(activity_type) == 118
		then
		if getOneDayRechargeTips(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 领取体力
	if tonumber(activity_type) == 1001 and false == funOpenDrawTip(151, false) then
		if getSmActivityEatManualTips() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 充值送月卡
	if tonumber(activity_type) == 1000 then
		if getActivitySmRechargeMonthCard() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 累计消费
	if tonumber(activity_type) == 17 then
		if getAccumlateConsumptionTips(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	
	-- 抽卡送拉拉兽
	if tonumber(activity_type) == 81 
		or tonumber(activity_type) == 116
		then
		if getActivitySmCompageCount1(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 招募数码兽
	if tonumber(activity_type) == 82 then
		if getActivitySmCompageCount2() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	-- 竞技场积分
	if tonumber(activity_type) == 83 then
		if getActivitySmCompageCount3() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	--充值返钻
	if tonumber(activity_type) == 107 then
		if getRechargeReturnRewardTips() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end

	-- 60元充值活动活动
	if tonumber(activity_type) == 119
		then
		if getRechargeForSixtyGiftActivityTips(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	--劳动节兑换
	if tonumber(activity_type) == 121
		then
		if getRechargeForTimeLimitBadgeActivityTips(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end

	if tonumber(activity_type) == 122 
		or tonumber(activity_type) == 125 
		then
		if getRechargeForBadgeLoginActivityTips(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end

	if tonumber(activity_type) == 124 
		then
		if getRechargeForTimeLimitBadgeActivityTips(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end


	if tonumber(activity_type) == 126 
		then
		if getRechargeForTaskBadgeActivityTips(tonumber(activity_type)) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end

	if tonumber(activity_type) == 10000 then
		if getActivityActivePush() == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end
	
	if tonumber(activity_type) == 95
		or tonumber(activity_type) == 96
		or tonumber(activity_type) == 102
		or tonumber(activity_type) == 103
		or tonumber(activity_type) == 104
		or tonumber(activity_type) == 105
		or tonumber(activity_type) == 106
		or tonumber(activity_type) == 108
		or tonumber(activity_type) == 109
		or tonumber(activity_type) == 110
		or tonumber(activity_type) == 113
		or tonumber(activity_type) == 115
		then
		if getActivitySmBuyGoldRewardPushInfo(activity_type) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	end

	-- 每日一推
	if tonumber(activity_type) == 7 			-- 累计充值
		or tonumber(activity_type) == 1000 		-- 月卡福利
		or tonumber(activity_type) == 27 		-- 开服基金
		or tonumber(activity_type) == 77 		-- 每日充值
		or tonumber(activity_type) == 17 		-- 累计消费
		or tonumber(activity_type) == 28 		-- 碎片兑换
		or tonumber(activity_type) == 78 		-- 招募仙人掌
		or tonumber(activity_type) == 79 		-- 招募巴多拉
		or tonumber(activity_type) == 80 		-- 招募火神兽
		or tonumber(activity_type) == 81 		-- 抽卡送拉拉兽
		or tonumber(activity_type) == 82 		-- 招募数码兽
		or tonumber(activity_type) == 83 		-- 竞技场积分
		-- or tonumber(activity_type) == 86 		-- 战力排行
		or tonumber(activity_type) == 87 		-- 金币砸金蛋
		or tonumber(activity_type) == 88 		-- 钻石砸金蛋
		or tonumber(activity_type) == 90 		-- 点金双倍
		or tonumber(activity_type) == 91 		-- 每日充值送礼
		or tonumber(activity_type) == 92 		-- 充值送礼
		or tonumber(activity_type) == 93 		-- 每日折扣
		or tonumber(activity_type) == 94 		-- 体力购买双倍
		or tonumber(activity_type) == 97 		-- 普通关卡双倍掉落
		or tonumber(activity_type) == 98 		-- 精英关卡双倍掉落
		or tonumber(activity_type) == 99 		-- 金币关卡双倍掉落
		or tonumber(activity_type) == 100 		-- 精英副本次数增加
		or tonumber(activity_type) == 101 		-- 金币副本次数增加
		or tonumber(activity_type) == 111 		-- VIP折扣
		or tonumber(activity_type) == 112 		-- 道具折扣
		or tonumber(activity_type) == 114 		-- 机械邪龙兽来袭
		or tonumber(activity_type) == 115 		-- 115.消耗钻石送礼(建号绑定）
		or tonumber(activity_type) == 116 		-- 116.抽卡送亚古兽（建号绑定）
		or tonumber(activity_type) == 117 		-- 117.每日充值送礼-恶魔兽（建号绑定）
		or tonumber(activity_type) == 118 		-- 118.每日充值送礼-V仔兽EX（建号绑定）
		or tonumber(activity_type) == 119 		-- 119.60元充值活动活动
		or tonumber(activity_type) == 120 		-- 120节日关卡掉落
		--or tonumber(activity_type) == 121 		-- 121节日道具兑换
		or tonumber(activity_type) == 122 		-- 122节日登陆有礼
		or tonumber(activity_type) == 123 		-- 123关卡掉落徽章
		or tonumber(activity_type) == 124 		-- 124徽章限时兑换
		or tonumber(activity_type) == 125 		-- 125徽章登陆有礼
		or tonumber(activity_type) == 126 		-- 126任务赠送徽章
		or tonumber(activity_type) == 127 		-- 127徽章礼盒促销
		then
		if getActivitySmIsNextDayPush(activity_type, activity_type) == true then
			push_notification_center_activity_all_push_state[""..activity_type] = true
		end
	elseif tonumber(activity_type) == 86 then
		if funOpenDrawTip(156, false) == false then
			if getActivitySmIsNextDayPush(activity_type, activity_type) == true then
				push_notification_center_activity_all_push_state[""..activity_type] = true
			end
		else
			push_notification_center_activity_all_push_state[""..activity_type] = false
		end
	end
end

-- 数码活动推送
function getSmActivityIconCellPushTips(activity_type)
	-- 活动
	if tonumber(activity_type) == 0 then
		local update_table = {}
		for k, v in pairs(_ED.active_activity) do
			local isShow = false
			if tonumber(k) == 24
				or tonumber(k) == 38
				then
				if __lua_project_id ~= __lua_project_l_naruto then
					isShow = true
				end
			end
			if isShow == true
				or tonumber(k) == 7
				or tonumber(k) == 77
				or tonumber(k) == 27
				or tonumber(k) == 17
				or tonumber(k) == 28
				or tonumber(k) == 78
				or tonumber(k) == 79
				or tonumber(k) == 80
				or tonumber(k) == 81
				or tonumber(k) == 82
				or tonumber(k) == 83
				or tonumber(k) == 90
				or tonumber(k) == 91
				or tonumber(k) == 92
				or tonumber(k) == 95
				or tonumber(k) == 96
				or tonumber(k) == 102
				or tonumber(k) == 103
				or tonumber(k) == 104
				or tonumber(k) == 105
				or tonumber(k) == 106
				or tonumber(k) == 108
				or tonumber(k) == 109
				or tonumber(k) == 110
				or tonumber(k) == 113
				or tonumber(k) == 115
				or tonumber(k) == 116
				or tonumber(k) == 117
				or tonumber(k) == 118
				or tonumber(k) == 119
				or tonumber(k) == 120
				or tonumber(k) == 121
				or tonumber(k) == 122
				or tonumber(k) == 123
				or tonumber(k) == 124
				or tonumber(k) == 125
				or tonumber(k) == 126
				or tonumber(k) == 127
				then
				if _ED.active_activity[k] ~= nil then
					table.insert(update_table, k)
				end
			end
		end
		-- 月卡
		-- if getActivitySmRechargeMonthCard() == true then
		-- 	table.insert(update_table, 1000)
		-- end
		-- 体力领取
		if false == funOpenDrawTip(151, false) and getSmActivityEatManualTips() == true then
			table.insert(update_table, 1001)
		end

		for k, v in pairs(update_table) do
			if push_notification_center_activity_all_push_state[""..v] == nil then
				getSmActivityPushStateTips(v)
			end
			if push_notification_center_activity_all_push_state[""..v] == true then
				return true
			end
		end
	end

	if tonumber(activity_type) > 0 then
		if push_notification_center_activity_all_push_state[""..activity_type] == nil then
			getSmActivityPushStateTips(activity_type)
		end
		if push_notification_center_activity_all_push_state[""..activity_type] == true then
			return true
		end
	end

	return false
end
