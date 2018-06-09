-----------------------------
-- 养成主界面
-----------------------------
SmCultivateWindow = class("SmCultivateWindowClass", Window)

--打开界面
local sm_cultivate_window_open_terminal = {
	_name = "sm_cultivate_window_open",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if fwin:find("SmCultivateWindowClass") == nil then
			fwin:open(SmCultivateWindow:new():init(), fwin._ui)		
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

--关闭界面
local sm_cultivate_window_close_terminal = {
	_name = "sm_cultivate_window_close",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
        state_machine.excute("notification_center_update", 0, "push_notification_home_cultivate")
        fwin:close(fwin:find("UserTopInfoAClass"))
        state_machine.excute("menu_back_home_page", 0, "") 
		fwin:close(fwin:find("SmCultivateWindowClass"))
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

state_machine.add(sm_cultivate_window_open_terminal)
state_machine.add(sm_cultivate_window_close_terminal)
state_machine.init()

function SmCultivateWindow:ctor()
	self.super:ctor()
	self.roots = {}

    app.load("client.l_digital.cultivate.SmCultivateSpiritWindow")
    app.load("client.l_digital.cultivate.talent.SmTalentMainWindow")
    app.load("client.l_digital.cultivate.artifact.SmCultivateArtifactWindow")
    app.load("client.l_digital.cultivate.achieve.SmCultivateAchieveWindow")
    local function init_sm_cultivate_window_terminal()
        local sm_cultivate_window_open_features_terminal = {
            _name = "sm_cultivate_window_open_features",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.lock("sm_cultivate_window_open_features")
				local m_index = params._datas.m_index
                -- if m_index == 3 then
                --     if true == funOpenDrawTip(178, false) then
                --         state_machine.unlock("sm_cultivate_window_open_features")
                --         return
                --     end
                -- end
                if true == funOpenDrawTip(120+tonumber(m_index)) then
                    state_machine.unlock("sm_cultivate_window_open_features")
                    return
                end
                if tonumber(m_index) == 1 then
                    state_machine.excute("sm_talent_main_window_open",0,"")
                elseif tonumber(m_index) == 2 then
                    state_machine.excute("sm_cultivate_spirit_window_open",0,"")
                elseif tonumber(m_index) == 3 then
                    state_machine.excute("sm_cultivate_artifact_window_open",0,"")
                elseif tonumber(m_index) == 4 then
                    state_machine.excute("sm_cultivate_achieve_window_open",0,"")
                    -- TipDlg.drawTextDailog(_wait_open_tip)
                    -- state_machine.unlock("sm_cultivate_window_open_features")
                    -- return
                end
                state_machine.unlock("sm_cultivate_window_open_features")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(sm_cultivate_window_open_features_terminal)
        state_machine.init()
    end
    init_sm_cultivate_window_terminal()
end

function SmCultivateWindow:onUpdateDraw()
    local root = self.roots[1]

    for i=1, 4 do
    	local Image_lock = ccui.Helper:seekWidgetByName(root,"Image_lock_"..i)
    	local Text_open_lv_info = ccui.Helper:seekWidgetByName(root,"Text_open_lv_info_"..i)

    	local openData = dms.int(dms["fun_open_condition"], 120+i, fun_open_condition.level)

    	if tonumber(_ED.user_info.user_grade) >= openData then
    		Image_lock:setVisible(false)
    	else
            -- if i == 3 then
            --     if funOpenDrawTip(178, false) == false then
            --         ccui.Helper:seekWidgetByName(root,"Image_sq"):loadTexture("images/ui/text/TF_res/c3.png")
            --     else
            --         ccui.Helper:seekWidgetByName(root,"Image_sq"):loadTexture("images/ui/text/TF_res/c0.png")
            --     end
            -- end
    		Image_lock:setVisible(true)
            Text_open_lv_info:setString(string.format(_new_interface_text[144],openData))
    	end
    end

end

function SmCultivateWindow:init()
	self:onInit()
    return self
end

function SmCultivateWindow:onInit()
    local csbItem = csb.createNode("cultivate/cultivate.csb")
    local root = csbItem:getChildByName("root")
    self:addChild(csbItem)
    table.insert(self.roots, root)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_back"), nil, 
    {
        terminal_name = "sm_cultivate_window_close", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 3)

    
    --天赋
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_cultivate_talent",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_tf"),
        _invoke = nil,
        _interval = 0.5,})
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Image_tf"), nil, 
    {
        terminal_name = "sm_cultivate_window_open_features", 
        m_index = 1,
        terminal_state = 0
    }, nil, 0)

    --数码精神
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_cultivate_spirit",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_smjs"),
        _invoke = nil,
        _interval = 0.5,})
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Image_smjs"), nil, 
    {
        terminal_name = "sm_cultivate_window_open_features", 
        m_index = 2,
        terminal_state = 0
    }, nil, 0)

    --神器
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Image_sq"), nil, 
    {
        terminal_name = "sm_cultivate_window_open_features", 
        m_index = 3,
        terminal_state = 0
    }, nil, 0)
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_cultivate_artifact",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_sq"),
        _invoke = nil,
        _interval = 0.5,})

    --成就
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Image_cj"), nil, 
    {
        terminal_name = "sm_cultivate_window_open_features", 
        m_index = 4,
        terminal_state = 0
    }, nil, 0)
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_cultivate_achieve",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_cj"),
        _invoke = nil,
        _interval = 0.5,})
    
	local ScrollView_yc = ccui.Helper:seekWidgetByName(root, "ScrollView_yc")
    if ScrollView_yc ~= nil then
        local items = ScrollView_yc:getChildren()
        for i, v in pairs(items) do
            local basePositionX = v:getPositionX()
            v:setPositionX(1440)
            local moveTo = cc.MoveTo:create(0.12, cc.p(basePositionX, v:getPositionY()))
            local delay = cc.DelayTime:create((i - 1) * 0.12)
            -- local action = cc.EaseBackInOut:create(moveTo)
            v:runAction(cc.Sequence:create(delay, moveTo))
        end
    end

	self:onUpdateDraw()
	
    local userinfo = UserTopInfoA:new()
    userinfo._rootWindows = self
    local info = fwin:open(userinfo,fwin._windows)
end

function SmCultivateWindow:onEnterTransitionFinish()
    
end


function SmCultivateWindow:onExit()
    
end

function SmCultivateWindow:destroy( window )
    if nil ~= sp.SkeletonRenderer.clear then
        sp.SkeletonRenderer:clear()
    end
    audioUtilUncacheAll()
    cacher.cleanSystemCacher()
end
