ExitGameView = class("ExitGameViewClass", Window)

function ExitGameView:ctor()
    self.super:ctor()
	self.roots = {}

	local function init_exit_game_view_terminal()

		-- 取消退出
		local exit_game_view_cancel_terminal = {
			_name = "exit_game_view_cancel",
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
		-- 确认退出
		local exit_game_view_affirm_terminal = {
			_name = "exit_game_view_affirm",
			_init = function (terminal) 
				
			end,
			_inited = false,
			_instance = self,
			_state = 0,
			_invoke = function(terminal, instance, params)
				handlePlatformRequest(0, CC_GAME_EXIT_DETERMINE, "")
				fwin:close(instance)
			    return true
			end,
			_terminal = nil,
			_terminals = nil
		}
		
		state_machine.add(exit_game_view_cancel_terminal)
		state_machine.add(exit_game_view_affirm_terminal)
		state_machine.init()
	end
	
	init_exit_game_view_terminal()
	
	
	local csbExitGameView = csb.createNode("utils/tuichu.csb")
    self:addChild(csbExitGameView)
	local root = csbExitGameView:getChildByName("Panel_5320")
	table.insert(self.roots, root)
	
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_5327"), nil, 
	{
		terminal_name = "exit_game_view_cancel",
		_window = self,
		isPressedActionEnabled = true
	}, 
	nil, 0)
	
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_5328"), nil, 
	{
		terminal_name = "exit_game_view_affirm",
		_window = self,
		isPressedActionEnabled = true
	},
	nil, 0)
end

function ExitGameView:onEnterTransitionFinish()
	
end

function ExitGameView:onExit()

end

function ExitGameView:reset(request)
	self.request = request
end
