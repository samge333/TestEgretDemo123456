-- ----------------------------------------------------------------------------------------------------
-- 说明：数码冒险主界面
-------------------------------------------------------------------------------------------------------
ExploreWindow = class("ExploreWindowClass", Window)

local explore_window_open_terminal = {
    _name = "explore_window_open",
    _init = function (terminal) 
    
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        if funOpenDrawTip(90) then
            return false
        end
        state_machine.excute("explore_window_close")
        if nil == fwin:find("ExploreWindowClass") then
            fwin:open(ExploreWindow:new():init(params), fwin._view)
        end
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local explore_window_close_terminal = {
    _name = "explore_window_close",
    _init = function (terminal) 
    
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        fwin:close(fwin:find("ExploreWindowClass"))
        -- if fwin:find("HomeClass") == nil then
        --     state_machine.excute("menu_manager", 0, 
        --         {
        --             _datas = {
        --                 terminal_name = "menu_manager",     
        --                 next_terminal_name = "menu_show_home_page", 
        --                 current_button_name = "Button_home",
        --                 but_image = "Image_home",       
        --                 terminal_state = 0, 
        --                 isPressedActionEnabled = true
        --             }
        --         }
        --     )
        -- end
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
        -- state_machine.excute("menu_back_home_page", 0, "") 
        -- state_machine.excute("home_hero_refresh_draw", 0, "")
        -- state_machine.excute("menu_clean_page_state", 0, "") 

        state_machine.unlock("menu_manager_change_to_page", 0, "")
        state_machine.excute("menu_back_home_page", 0, "")
        state_machine.excute("menu_clean_page_state", 0, "") 
        state_machine.excute("home_hero_refresh_draw", 0, 0)
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(explore_window_open_terminal)
state_machine.add(explore_window_close_terminal)
state_machine.init()

function ExploreWindow:ctor()
    self.super:ctor()
    self.roots = {}
    self.actions = {}

    -- Initialize explore window state machine.
    local function init_explore_window_terminal()
        local explore_window_show_terminal = {
            _name = "explore_window_show",
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

        local explore_window_hide_terminal = {
            _name = "explore_window_hide",
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

        local explore_window_open_fun_window_terminal = {
            _name = "explore_window_open_fun_window",
            _init = function (terminal) 

            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.lock("explore_window_open_fun_window")
                local pageIndex = 1
                if nil ~= params then
                    pageIndex = params._datas.page_index
                end
                if true == funOpenDrawTip(90 + pageIndex) then
                    state_machine.unlock("explore_window_open_fun_window")
                    return false
                end
                if pageIndex == 1 then
                    state_machine.excute("explore_window_hide")
                    app.load("client.l_digital.explore.activity_copy.ActivityCopyWindow")
                    state_machine.excute("activity_copy_window_open", 0, 0)
                elseif pageIndex == 2 then
                    -- state_machine.excute("explore_window_hide")
                    local function responseKingdomsCallback(response)
                        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                            app.load("client.l_digital.campaign.trialtower.TrialTower")
                            fwin:open(TrialTower:new(), fwin._ui) 
                        end
                    end
                    NetworkManager:register(protocol_command.three_kingdoms_init.code, nil, nil, nil, nil, responseKingdomsCallback, false, nil) 
                elseif pageIndex == 3 then
                    app.load("client.l_digital.campaign.digitalpurify.DigitalPurifyWindow")
                    state_machine.excute("digital_purify_window_open", 0, 0)
                end
                -- state_machine.unlock("explore_window_open_fun_window")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(explore_window_show_terminal)
        state_machine.add(explore_window_hide_terminal)
        state_machine.add(explore_window_open_fun_window_terminal)
        state_machine.init()
    end

    -- call func init explore window state machine.
    init_explore_window_terminal()
end

function ExploreWindow:init(pageIndex)
    if (type(pageIndex) == "string") and zstring.tonumber(pageIndex) > 0 then
        self.openPage = zstring.tonumber(pageIndex)
    end
    if missionIsOver() == false then
        _ED.user_info.mission_user_grade1 = tonumber(_ED.user_info.user_grade)
    end
    return self
end

function ExploreWindow:onEnterTransitionFinish()
    local csbNode = csb.createNode("campaign/maoxian.csb")
    local root = csbNode:getChildByName("root")
    table.insert(self.roots, root)
    self:addChild(csbNode)

    -- 关闭窗口
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_maoxian_back"), nil, 
    {
        terminal_name = "explore_window_close", 
        isPressedActionEnabled = true
    },
    nil,0)

    local ScrollView_maoxian_fun = ccui.Helper:seekWidgetByName(root, "ScrollView_maoxian_fun")
    local items = ScrollView_maoxian_fun:getChildren()
    for i, v in pairs(items) do
        v.roots = {v}
        local Image_maoxian_fun_pic = ccui.Helper:seekWidgetByName(root, "Image_maoxian_fun_pic_" .. i)
        local Image_maoxian_lock = ccui.Helper:seekWidgetByName(root, "Image_maoxian_lock_" .. i)
        Image_maoxian_fun_pic:setVisible(true)
        if false == funOpenDrawTip(90 + i, false) then
            Image_maoxian_lock:setVisible(false)
        else
            Image_maoxian_lock:setVisible(true)
        end
        fwin:addTouchEventListener(Image_maoxian_fun_pic, nil, 
        {
            terminal_name = "explore_window_open_fun_window",
            page_index = i,
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

    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_sm_trial_tower_reward",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_maoxian_fun_pic_2"),
        _invoke = nil,
        _interval = 0.5,})

    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_sm_purify_duplicate",
        _widget = ccui.Helper:seekWidgetByName(root, "Image_maoxian_fun_pic_3"),
        _invoke = nil,
        _interval = 0.5,})

    -- 绘制顶部用户信息栏
    local userInformationHeroStorage = UserInformationHeroStorage:new()
    userInformationHeroStorage._rootWindows = self
    fwin:open(userInformationHeroStorage,fwin._view)

    if self.openPage ~= nil and self.openPage ~= 0 then
        self:runAction(cc.Sequence:create({cc.DelayTime:create(0.5), cc.CallFunc:create(function ( sender )
                state_machine.excute("explore_window_open_fun_window", 0, { _datas = {page_index = self.openPage} })
        end)}))
        
    end
end

function ExploreWindow:onExit()
    state_machine.unlock("explore_window_open_fun_window")
    state_machine.remove("explore_window_show")
    state_machine.remove("explore_window_hide")
    state_machine.remove("explore_window_open_fun_window")
end

function ExploreWindow:destroy( window )
    if nil ~= sp.SkeletonRenderer.clear then
        sp.SkeletonRenderer:clear()
    end
    audioUtilUncacheAll()
    cacher.cleanSystemCacher()
end