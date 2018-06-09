-- ----------------------------------------------------------------------------------------------------
-- 说明：账号被封停
-- 创建时间
-- 作者：
-- 修改记录：
-- 最后修改人：
-- 时间 : 
-------------------------------------------------------------------------------------------------------

CanNotLogin = class("CanNotLoginClass", Window)
local can_not_login_open_terminal = {
    _name = "can_not_login_open",
    _init = function (terminal) 
    	
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params) 
   		local win = CanNotLogin:new()
   		win:init()
   		fwin:open(win,fwin._system)
        return true
    end,
    _terminal = nil,
    _terminals = nil
} 

state_machine.add(can_not_login_open_terminal)  
state_machine.init()
function CanNotLogin:ctor()
    self.super:ctor()
    self.roots = {}
   local function init_can_not_login_terminal()
		-- 界面确定按钮
        local can_not_login_ok_terminal = {
            _name = "can_not_login_ok",
            _init = function (terminal) 
            
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	fwin:close(instance)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        state_machine.add(can_not_login_ok_terminal)  
        state_machine.init()
    end
    
    -- call func init LoginOfOtherTip state machine.
    init_can_not_login_terminal()    
end

function CanNotLogin:onEnterTransitionFinish()
    local csbLoginOfOtherTip = csb.createNode("utils/tuichu_zhanghao.csb")
    self:addChild(csbLoginOfOtherTip)
	
	local root = csbLoginOfOtherTip:getChildByName("root")
	local Label_5324 = ccui.Helper:seekWidgetByName(root, "Label_5324*")
	Label_5324:setString(_string_piece_info[422])
	
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_5328"), nil, 
	{
		terminal_name = "can_not_login_ok", 
		terminal_state = 1,
		taget = self,
		isPressedActionEnabled = true
	}, nil, 0)
end

function CanNotLogin:init()
    return self
end

function CanNotLogin:onExit()
	state_machine.remove("can_not_login_ok")
end