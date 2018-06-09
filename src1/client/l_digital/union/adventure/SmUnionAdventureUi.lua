-----------------------------
--工会大冒险的ui
-----------------------------
SmUnionAdventureUi = class("SmUnionAdventureUiClass", Window)
SmUnionAdventureUi.__size = nil

local sm_union_adventure_ui_open_terminal = {
    _name = "sm_union_adventure_ui_open",
    _init = function (terminal)
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
		local panel = SmUnionAdventureUi:new():init(params)
		fwin:open(panel)
        return panel
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_union_adventure_ui_open_terminal)
state_machine.init()

function SmUnionAdventureUi:ctor()
    self.super:ctor()
    self.roots = {}

    self.prop_list = {}
    app.load("client.l_digital.union.adventure.SmUnionAdventureRule")
    app.load("client.l_digital.union.adventure.SmUnionAdventureRank")
    local function init_sm_union_adventure_ui_terminal()
		--显示界面
		local sm_union_adventure_ui_show_terminal = {
            _name = "sm_union_adventure_ui_show",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                instance:onShow()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		--隐藏界面
		local sm_union_adventure_ui_hide_terminal = {
            _name = "sm_union_adventure_ui_hide",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                instance:onHide()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }	

        --
        local sm_union_adventure_ui_start_the_game_terminal = {
            _name = "sm_union_adventure_ui_start_the_game",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                local index = params._datas.index
                state_machine.excute("sm_union_adventure_start_the_game", 0, tonumber(index))
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }   

        local sm_union_adventure_ui_update_draw_terminal = {
            _name = "sm_union_adventure_ui_update_draw",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                instance:onUpdateDraw()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }   

		state_machine.add(sm_union_adventure_ui_show_terminal)	
        state_machine.add(sm_union_adventure_ui_hide_terminal)
		state_machine.add(sm_union_adventure_ui_start_the_game_terminal)
        state_machine.add(sm_union_adventure_ui_update_draw_terminal)
        state_machine.init()
    end
    init_sm_union_adventure_ui_terminal()
end

function SmUnionAdventureUi:onHide()
    self:setVisible(false)
end

function SmUnionAdventureUi:onShow()
    self:setVisible(true)
end

function SmUnionAdventureUi:onUpdateDraw()
    local root = self.roots[1]
    if root == nil then 
        return
    end

    --奖励上限
    local silver_ceiling = 0
    local gem_ceiling = 0
    local prop_ceiling = 0

    local science_info = zstring.split(_ED.union_science_info,"|")
    local hall_technology = zstring.split(science_info[5],",")
    --通过科技类型找到科技模板的库组
    local parameter_group = dms.int(dms["union_science_mould"], 5, union_science_mould.parameter_group)
    --通过参数库组找到对应de经验参数表数据
    local expMould = dms.searchs(dms["union_science_exp"], union_science_exp.group_id, parameter_group)
    local expData = nil
    for i, v in pairs(expMould) do
        if tonumber(hall_technology[1]) == tonumber(v[3]) then
            expData = v
            break
        end
    end

    local expData_info = zstring.split(expData[5],",")
    silver_ceiling = expData_info[1]
    gem_ceiling = expData_info[2]
    prop_ceiling = expData_info[3]

    local Text_zs_n_1 = ccui.Helper:seekWidgetByName(root, "Text_zs_n_1")
    Text_zs_n_1:setString(gem_ceiling)
    local Text_jb_n_1 = ccui.Helper:seekWidgetByName(root, "Text_jb_n_1")
    Text_jb_n_1:setString(silver_ceiling)
    local Text_sp_n_1 = ccui.Helper:seekWidgetByName(root, "Text_sp_n_1")
    Text_sp_n_1:setString(prop_ceiling)


    local adventure = zstring.split(science_info[4],",")
    local adventure_group = dms.int(dms["union_science_mould"], 4, union_science_mould.parameter_group)
    local adventureMould = dms.searchs(dms["union_science_exp"], union_science_exp.group_id, adventure_group)
    local adventureData = nil
    for i, v in pairs(adventureMould) do
        if tonumber(adventure[1]) == tonumber(v[3]) then
            adventureData = v
            break
        end
    end

    local Text_play_number = ccui.Helper:seekWidgetByName(root, "Text_play_number")
    Text_play_number:setString((tonumber(adventureData[5])-tonumber(adventure[4])).."/"..adventureData[5])
    if (tonumber(adventureData[5])-tonumber(adventure[4])) == 0 then
        ccui.Helper:seekWidgetByName(root, "Button_start"):setTouchEnabled(false)
        ccui.Helper:seekWidgetByName(root, "Button_start"):setBright(false)
        ccui.Helper:seekWidgetByName(root, "Button_start"):setTitleText(_new_interface_text[190])
    else
        ccui.Helper:seekWidgetByName(root, "Button_start"):setTouchEnabled(true)
        ccui.Helper:seekWidgetByName(root, "Button_start"):setBright(true)
        if (tonumber(adventureData[5])-tonumber(adventure[4])) < 3 then
            ccui.Helper:seekWidgetByName(root, "Button_start"):setTitleText(_new_interface_text[191])
        else
            ccui.Helper:seekWidgetByName(root, "Button_start"):setTitleText(_new_interface_text[190])
        end
    end

    local datas = zstring.split(_ED.union_adventure_state_info,"!")
    local infos = zstring.split(datas[1],",")
    local Text_best_1 = ccui.Helper:seekWidgetByName(root, "Text_best_1")
    Text_best_1:setString(infos[1])
    local Text_best_2 = ccui.Helper:seekWidgetByName(root, "Text_best_2")
    Text_best_2:setString(infos[2])
    local Text_zs_n = ccui.Helper:seekWidgetByName(root, "Text_zs_n")
    local Text_jb_n = ccui.Helper:seekWidgetByName(root, "Text_jb_n")
    local Text_sp_n = ccui.Helper:seekWidgetByName(root, "Text_sp_n")
    if datas[2] == "-1" then
        Text_zs_n:setString("0")
        Text_jb_n:setString("0")
        Text_sp_n:setString("0")
    else
        local reworldData = zstring.split(datas[2],"|")
        for i, v in pairs(reworldData) do
            local datasReworld = zstring.split(v,",")
            if tonumber(datasReworld[1]) == 1 then
                Text_jb_n:setString(datasReworld[3])
            elseif tonumber(datasReworld[1]) == 2 then 
                Text_zs_n:setString(datasReworld[3])
            elseif tonumber(datasReworld[1]) == 6 then 
                Text_sp_n:setString(datasReworld[3])
            end
        end
    end
end

function SmUnionAdventureUi:onUpdate(dt)
    
end

function SmUnionAdventureUi:onEnterTransitionFinish()
    
end

function SmUnionAdventureUi:onInit( )
    local csbItem = csb.createNode("legion/sm_legion_adventure_ui.csb")
    self:addChild(csbItem)
	local root = csbItem:getChildByName("root")
	table.insert(self.roots, root)

    if SmUnionAdventureUi.__size == nil then
        SmUnionAdventureUi.__size = root:getContentSize()
    end
    self:setContentSize(SmUnionAdventureUi.__size)

    --开始游戏
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_start"), nil, 
    {
        terminal_name = "sm_union_adventure_ui_start_the_game", 
        terminal_state = 0,
        index = 0,
        isPressedActionEnabled = true
    }, 
    nil, 0)

    --直接20层
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_go_to_20"), nil, 
    {
        terminal_name = "sm_union_adventure_ui_start_the_game", 
        terminal_state = 0,
        index = 20,
        isPressedActionEnabled = true
    }, 
    nil, 0)

    --直接历史最高
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_go_to_best"), nil, 
    {
        terminal_name = "sm_union_adventure_ui_start_the_game", 
        terminal_state = 0,
        index = 0,
        isPressedActionEnabled = true
    }, 
    nil, 0)

    --规则
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_guize"), nil, 
    {
        terminal_name = "sm_union_adventure_rule_open", 
        terminal_state = 0,
        isPressedActionEnabled = true
    }, 
    nil, 0)

    --排行
    fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_ranking"), nil, 
    {
        terminal_name = "sm_union_adventure_rank_open", 
        terminal_state = 0,
        isPressedActionEnabled = true
    }, 
    nil, 0)

    self:onUpdateDraw()
end

function SmUnionAdventureUi:init(params)
    local rootWindow = params[1] 
    self._rootWindows = rootWindow      
	self:onInit()
    return self
end

function SmUnionAdventureUi:onExit()
    state_machine.remove("sm_union_adventure_ui_show")    
    state_machine.remove("sm_union_adventure_ui_hide")
    state_machine.remove("sm_union_adventure_ui_start_the_game")
    state_machine.remove("sm_union_adventure_ui_update_draw")
end
