-- ----------------------------------------------------------------------------------------------------
-- 说明：征战主界面（包含竞技场等。。。）
-------------------------------------------------------------------------------------------------------
Campaign = class("CampaignClass", Window)

local campaign_window_open_terminal = {
    _name = "campaign_window_open",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
    	fwin:open(Campaign:new(), fwin._view)
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local campaign_window_close_terminal = {
    _name = "campaign_window_close",
    _init = function (terminal) 
        
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
    	fwin:close(fwin:find("CampaignClass"))

    	if fwin:find("MenuClass") == nil then
            fwin:open(Menu:new(), fwin._taskbar)
        end
		if fwin:find("HomeClass") == nil then
        	state_machine.excute("menu_manager", 0, 
				{
					_datas = {
						terminal_name = "menu_manager", 	
						next_terminal_name = "menu_show_home_page", 
						current_button_name = "Button_home",
						but_image = "Image_home", 		
						terminal_state = 0, 
						isPressedActionEnabled = true
					}
				}
			)
        end
        state_machine.excute("menu_back_home_page", 0, "") 
		state_machine.excute("home_hero_refresh_draw", 0, "")
		state_machine.excute("menu_clean_page_state", 0, "") 
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(campaign_window_open_terminal)
state_machine.add(campaign_window_close_terminal)
state_machine.init()

function Campaign:ctor()
    self.super:ctor()
    self.roots = {}

    -- load luf file
    app.load("client.l_digital.campaign.arena.Arena")
    app.load("client.l_digital.campaign.battleofKings.SmBattleofKingsWindow")
    app.load("client.l_digital.union.unionFighting.UnionFightingMain")
    -- var
	
    -- Initialize campaign page state machine.
    local function init_campaign_terminal()

		local campaign_show_manager_terminal = {
            _name = "campaign_show_manager",
            _init = function (terminal) 

            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.lock("campaign_show_manager")
                local pageIndex = params._datas.page_index
                if true == params._datas.is_opened then
                    state_machine.excute(params._datas.next_terminal_name, 0, params)
                else
                    if tonumber(pageIndex) == 2 then
                        local element = dms.element(dms["fun_open_condition"], 81)
                        local open_day = dms.atoi(element, fun_open_condition.open_day)
                        local day = (tonumber(_ED.system_time) - tonumber(_ED.open_server_time)/1000 + (os.time()-tonumber(_ED.native_time)))/86400
                        if day < open_day then
                            TipDlg.drawTextDailog(string.format(_new_interface_text[196],9))
                        else
                            funOpenDrawTip(81)
                        end
                    elseif tonumber(pageIndex) == 3 then
                        local element = dms.element(dms["fun_open_condition"], 82)
                        local level = dms.atoi(element, fun_open_condition.level)
                        -- local open_day = dms.atoi(element, fun_open_condition.open_day)
                        -- local day = (tonumber(_ED.system_time) - tonumber(_ED.open_server_time)/1000 + (os.time()-tonumber(_ED.native_time)))/86400
                        if level > zstring.tonumber(_ED.user_info.user_grade) then
                            TipDlg.drawTextDailog(string.format(_new_interface_text[144], level))
                        else
                            funOpenDrawTip(82)
                        end
                    else
                        funOpenDrawTip(79 + pageIndex)
                    end
                end
                state_machine.unlock("campaign_show_manager")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
	
		--竞技场
		local campaign_show_arena_terminal = {
            _name = "campaign_show_arena",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
    			state_machine.excute("arena_window_open", 0, 0)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --王者之战
        local campaign_show_battle_of_kings_terminal = {
            _name = "campaign_show_battle_of_kings",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("sm_battleof_kings_window_open", 0, 0)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 
		local campaign_window_show_terminal = {
            _name = "campaign_window_show",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
            	instance:setVisible(true)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        -- 
		local campaign_window_hide_terminal = {
            _name = "campaign_window_hide",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
            	instance:setVisible(false)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

		state_machine.add(campaign_show_manager_terminal)
		state_machine.add(campaign_window_show_terminal)
		state_machine.add(campaign_window_hide_terminal)
        state_machine.add(campaign_show_arena_terminal)
		state_machine.add(campaign_show_battle_of_kings_terminal)

        state_machine.init()
    end
    
    -- call func init hom state machine.
    init_campaign_terminal()
end

function Campaign:onUpdate(dt)

end

function Campaign:onUpdateDraw()
	local root = self.roots[1]
    local Image_activity_lv_pic_2 = ccui.Helper:seekWidgetByName(root, "Image_activity_lv_pic_2")
    local Image_activity_lock_2 = ccui.Helper:seekWidgetByName(root, "Image_activity_lock_2")
    Image_activity_lock_2:setVisible(true)
    Image_activity_lv_pic_2:loadTexture("images/ui/play/level_40.png")
    if funOpenDrawTip(81, false) == false then
        Image_activity_lock_2:setVisible(false)
    else
        local element = dms.element(dms["fun_open_condition"], 81)
        local open_day = dms.atoi(element, fun_open_condition.open_day)
        local day = (tonumber(_ED.system_time) - tonumber(_ED.open_server_time)/1000 + (os.time()-tonumber(_ED.native_time)))/86400
        if day < open_day then
            Image_activity_lv_pic_2:loadTexture("images/ui/play/serverday_9.png")
        end
    end

    local Image_activity_lv_pic_3 = ccui.Helper:seekWidgetByName(root, "Image_activity_lv_pic_3")
    local Image_activity_lock_3 = ccui.Helper:seekWidgetByName(root, "Image_activity_lock_3")
    Image_activity_lock_3:setVisible(true)
    Image_activity_lv_pic_3:loadTexture("images/ui/play/level_35.png")
    if funOpenDrawTip(82, false) == false then
        Image_activity_lock_3:setVisible(false)
    else
        local element = dms.element(dms["fun_open_condition"], 82)
        local open_day = dms.atoi(element, fun_open_condition.open_day)
        local day = (tonumber(_ED.system_time) - tonumber(_ED.open_server_time)/1000 + (os.time()-tonumber(_ED.native_time)))/86400
        if day < open_day then
            Image_activity_lv_pic_3:loadTexture("images/ui/play/serverday_14.png")
        end
    end
end

function Campaign:onEnterTransitionFinish()
	local csbCampaign = csb.createNode("campaign/activity_list.csb")
    self:addChild(csbCampaign)
	local root = csbCampaign:getChildByName("root")
	table.insert(self.roots, root)

	-- 关闭窗口
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_activity_back"), nil, 
    {
        terminal_name = "campaign_window_close", 
        isPressedActionEnabled = true
    },
    nil,0)

	-- 添加进入的回调
	local ScrollView_activity_fun = ccui.Helper:seekWidgetByName(root, "ScrollView_activity_fun")
	local items = ScrollView_activity_fun:getChildren()
	for i, v in pairs(items) do
        v.roots = {v}
		local Image_maoxian_fun_pic = ccui.Helper:seekWidgetByName(v, "Image_activity_fun_pic_" .. i)
        local Image_maoxian_lock = ccui.Helper:seekWidgetByName(v, "Image_activity_lock_" .. i)
        local isOpened = funOpenDrawTip(79 + i, false) == false
		local nextTerminalName = nil
		if i == 1 then
            nextTerminalName = "campaign_show_arena"
        elseif i == 2 then
            nextTerminalName = "campaign_show_battle_of_kings"    
        elseif i == 3 then
            nextTerminalName = "union_fighting_main_open"
		end
        Image_maoxian_fun_pic:setVisible(true)
        if true == isOpened then
            Image_maoxian_lock:setVisible(false)
        else
            Image_maoxian_lock:setVisible(true)
        end
        fwin:addTouchEventListener(Image_maoxian_fun_pic, nil, 
        {
            terminal_name = "campaign_show_manager", 
            next_terminal_name = nextTerminalName,     
            page_index = i,
            button = Image_maoxian_fun_pic, 
            is_opened = isOpened,
            isPressedActionEnabled = true
        },
        nil,0)

        local basePositionX = v:getPositionX()
        v:setPositionX(1220)
        local moveTo = cc.MoveTo:create(0.12, cc.p(basePositionX, v:getPositionY()))
        local delay = cc.DelayTime:create((i - 1) * 0.12)
        -- local action = cc.EaseBackInOut:create(moveTo)
        v:runAction(cc.Sequence:create(delay, moveTo))
	end

    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_sm_arena_page_tip",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_activity_fun_pic_1"),
        _invoke = nil,
        _interval = 0.5,})

    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_sm_battle_of_kings_all",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_activity_fun_pic_2"),
        _invoke = nil,
        _interval = 0.5,})

    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_sm_union_battle",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_activity_fun_pic_3"),
        _invoke = nil,
        _interval = 0.5,})

	self:onUpdateDraw()
    
    app.load("client.player.UserInformationHeroStorage")
    local userInformationHeroStorage = UserInformationHeroStorage:new()
    userInformationHeroStorage._rootWindows = self
    fwin:open(userInformationHeroStorage,fwin._view)
end

function Campaign:onExit()
	state_machine.remove("campaign_show_manager")
	state_machine.remove("campaign_window_show")
	state_machine.remove("campaign_window_hide")
	state_machine.remove("campaign_show_arena")
end

function Campaign:destroy( window )
    if nil ~= sp.SkeletonRenderer.clear then
        sp.SkeletonRenderer:clear()
    end
    audioUtilUncacheAll()
    cacher.cleanSystemCacher()
end

--return Campaign:new()