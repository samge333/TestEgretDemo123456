-----------------------------
-- 王者之战查看普通阵型
-----------------------------
SmBattleofKingsViewGeneralFormation = class("SmBattleofKingsViewGeneralFormationClass", Window)

--打开界面
local sm_battleof_kings_view_general_formation_open_terminal = {
	_name = "sm_battleof_kings_view_general_formation_open",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		if fwin:find("SmBattleofKingsViewGeneralFormationClass") == nil then
			fwin:open(SmBattleofKingsViewGeneralFormation:new():init(params), fwin._ui)		
		end
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

--关闭界面
local sm_battleof_kings_view_general_formation_close_terminal = {
	_name = "sm_battleof_kings_view_general_formation_close",
	_init = function (terminal)
		
	end,
	_inited = false,
	_instance = self,
	_state = 0,
	_invoke = function(terminal, instance, params)
		fwin:close(fwin:find("SmBattleofKingsViewGeneralFormationClass"))
		return true
	end,
	_terminal = nil,
	_terminals = nil
}

state_machine.add(sm_battleof_kings_view_general_formation_open_terminal)
state_machine.add(sm_battleof_kings_view_general_formation_close_terminal)
state_machine.init()

function SmBattleofKingsViewGeneralFormation:ctor()
	self.super:ctor()
	self.roots = {}

    local function init_sm_battleof_kings_view_general_formation_terminal()
        -- local sm_battleof_kings_view_general_formation_change_page_terminal = {
            -- _name = "sm_battleof_kings_view_general_formation_change_page",
            -- _init = function (terminal)
            -- end,
            -- _inited = false,
            -- _instance = self,
            -- _state = 0,
            -- _invoke = function(terminal, instance, params)
            	-- instance:changeSelectPage(params._datas._page)
                -- return true
            -- end,
            -- _terminal = nil,
            -- _terminals = nil
        -- }

        -- state_machine.add(sm_battleof_kings_view_general_formation_change_page_terminal)
        state_machine.init()
    end
    init_sm_battleof_kings_view_general_formation_terminal()
end

function SmBattleofKingsViewGeneralFormation:onUpdateDraw()
    local root = self.roots[1]
    local speed_list = {}
    --模块ID:等级:进化状态:星级:品阶:战力:实例ID!下一个武将
    local formation_info = zstring.split(self.m_object.formation, "!")
    for i=1, #formation_info do
    	local Panel_digimon_icon = ccui.Helper:seekWidgetByName(root,"Panel_digimon_icon_"..i)
    	padCardsTable[i] = Panel_digimon_icon
    	if formation_info ~= nil then
            if formation_info[i] ~= nil then
            	local datas = zstring.split(formation_info[i],":")
                local cell = ShipIconCell:createCell()
                local ships = {}
                ships.ship_template_id = datas[1]
                ships.evolution_status = datas[3]
                ships.Order = datas[5]
                ships.ship_grade = datas[2]
                ships.StarRating = datas[4]
		    	cell:init(ships,12)
		        Panel_digimon_icon:addChild(cell)
		        --战力
		        local BitmapFontLabel_fighting = ccui.Helper:seekWidgetByName(root,"BitmapFontLabel_fighting_"..i)
		       	BitmapFontLabel_fighting:setString(datas[6])
		       	local Text_sudu = ccui.Helper:seekWidgetByName(root,"Text_sudu_"..i)
		       	Text_sudu:setString(datas[8])
            end
        end
    end
end

function SmBattleofKingsViewGeneralFormation:init(params)
	self.m_object = params[1]
    self:setTouchEnabled(true)
	self:onInit()
    return self
end

function SmBattleofKingsViewGeneralFormation:onInit()
    local csbItem = csb.createNode("campaign/BattleofKings/battle_of_kings_lineup_info_1.csb")
    local root = csbItem:getChildByName("root")
    self:addChild(csbItem)
    table.insert(self.roots, root)

    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Button_wzzz_back"), nil, 
    {
        terminal_name = "sm_battleof_kings_view_general_formation_close", 
        terminal_state = 0, 
        touch_black = true,
    }, nil, 3)
	
    self:onUpdateDraw()
end

function SmBattleofKingsViewGeneralFormation:onEnterTransitionFinish()
    
end


function SmBattleofKingsViewGeneralFormation:onExit()
	state_machine.remove("sm_battleof_kings_view_general_formation_change_page")
end

