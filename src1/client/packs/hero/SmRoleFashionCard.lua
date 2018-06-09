--------------------------------------------------------------------------------------------------------------
SmRoleFashionCard = class("SmRoleFashionCardClass", Window)
SmRoleFashionCard.__size = nil

local sm_role_fashion_card_cell_terminal = {
    _name = "sm_role_fashion_card_cell",
    _init = function (terminal)
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        local cell = SmRoleFashionCard:new():init(params)
        cell:registerOnNodeEvent(cell)
        return cell
    end,
    _terminal = nil,
    _terminals = nil
}

state_machine.add(sm_role_fashion_card_cell_terminal)
state_machine.init()

function SmRoleFashionCard:ctor()
	self.super:ctor()
	self.roots = {}

    self._chooseShip = nil
    self._index = 0
    self._isChoose = false

    local function init_sm_role_fashion_card_cell_terminal()
        local sm_role_fashion_card_cell_choose_terminal = {
            _name = "sm_role_fashion_card_cell_choose",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local cell = params._datas.cell
                if cell._isChoose == true then
                    return
                end
                state_machine.excute("sm_role_fashion_choose_fashion", 0, cell)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        state_machine.add(sm_role_fashion_card_cell_choose_terminal)
        state_machine.init()
    end 
    init_sm_role_fashion_card_cell_terminal()
end

function SmRoleFashionCard:updateChooseState(isChoose)
    local root = self.roots[1]
    local Image_xuanzhong = ccui.Helper:seekWidgetByName(root, "Image_xuanzhong")
    Image_xuanzhong:setVisible(isChoose)
end

function SmRoleFashionCard:updateDraw()
    local root = self.roots[1]
    local Panel_head = ccui.Helper:seekWidgetByName(root, "Panel_head")
    local Panel_jqqd = ccui.Helper:seekWidgetByName(root, "Panel_jqqd")
    local Text_name = ccui.Helper:seekWidgetByName(root, "Text_name")
    local Text_shuxing_1 = ccui.Helper:seekWidgetByName(root, "Text_shuxing_1")
    local Text_shuxing_2 = ccui.Helper:seekWidgetByName(root, "Text_shuxing_2")
    local Text_tips = ccui.Helper:seekWidgetByName(root, "Text_tips")
    local Image_5 = ccui.Helper:seekWidgetByName(root, "Image_5")
    local Image_3 = ccui.Helper:seekWidgetByName(root, "Image_3")

    self.is_unlock = false
    Panel_head:removeAllChildren(true)
    Text_name:setString("")
    Text_shuxing_1:setString("")
    Text_shuxing_2:setString("")
    Text_tips:setString("")
    Text_tips:setVisible(false)
    Image_3:setVisible(false)
    Panel_jqqd:setVisible(false)
    Image_5:setVisible(false)

    --添加形象
    if self.ship_evo_id ~= -1 then
        draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), Panel_head, nil, nil, cc.p(0.5, 0))
        local picIndex_pic = dms.int(dms["ship_evo_mould"], self.ship_evo_id, ship_evo_mould.form_id)
        if animationMode == 1 then
            app.load("client.battle.fight.FightEnum")
            local shipSpine = sp.spine_sprite(Panel_head, picIndex_pic, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
            if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                shipSpine:setScaleX(-1)
            end
        else
            draw.createEffect("spirte_" .. picIndex_pic, "sprite/spirte_" .. picIndex_pic .. ".ExportJson", Panel_head, -1, nil, nil, cc.p(0.5, 0))
        end

        local name_index = dms.int(dms["ship_evo_mould"], self.ship_evo_id, ship_evo_mould.name_index)
        local name  = dms.element(dms["word_mould"], name_index)[3]
        Text_name:setString(name)

        local default_des = tipStringInfo_evolution_status_tips[3]
        local pos_y = Text_shuxing_1:getPositionY() - 20
        if self.ship_skin_id ~= 0 then
            local evolution_status = dms.int(dms["ship_skin_mould"], self.ship_skin_id, ship_skin_mould.unlock_condition)
            local evolution_status_initial = dms.int(dms["ship_skin_mould"], self.ship_skin_id, ship_skin_mould.evolution_status_initial)
            local evolution_status_index = evolution_status + (evolution_status_initial - 1)
            local tips = evolution_status == -1 and tipStringInfo_evolution_status_tips[2] or string.format(tipStringInfo_evolution_status_tips[1], tipStringInfo_evolution_status[evolution_status_index])
            Text_tips:setString(tips)

            self.is_unlock = self.default_evolution_status >=  evolution_status 
            Image_3:setVisible(not self.is_unlock and self._index ~= 1)
            Text_tips:setVisible(not self.is_unlock and self._index ~= 1)

            local additional_property = dms.string(dms["ship_skin_mould"], self.ship_skin_id, ship_skin_mould.additional)
            local additionals = zstring.splits(additional_property, "|", ",")
            default_des = skill_attributes_text_tips[zstring.tonumber(additionals[1][1]) + 1] .. ":" .. additionals[1][2]
            pos_y = Text_shuxing_1:getPositionY()

            Text_shuxing_2:setString(skill_attributes_text_tips[zstring.tonumber(additionals[2][1]) + 1] .. ":" .. additionals[2][2])
            Text_shuxing_2:setVisible(true)
        end
        Text_shuxing_1:setString(default_des)
        Text_shuxing_1:setPositionY(pos_y)

        Image_5:setVisible(self.current_skin_id == tonumber(self.ship_skin_id))
        
        Panel_jqqd:setVisible(false)
    else
        Text_tips:setVisible(false)
        Image_3:setVisible(false)
        Panel_jqqd:setVisible(true)
        Text_shuxing_1:setVisible(false)
        Text_shuxing_2:setVisible(false)
    end
end

function SmRoleFashionCard:onInit()
    local csbItem = csb.createNode("packs/HeroStorage/generals_fashion_role.csb")
    local root = csbItem:getChildByName("root")
    table.insert(self.roots, root)
    self:addChild(csbItem)

    if SmRoleFashionCard.__size == nil then
        SmRoleFashionCard.__size = root:getContentSize()
    end

    local Panel_20 = ccui.Helper:seekWidgetByName(root, "Panel_20")
    Panel_20:setTouchEnabled(self.ship_evo_id ~= -1)
    Panel_20:setSwallowTouches(false)
    fwin:addTouchEventListener(Panel_20, nil, {
            terminal_name = "sm_role_fashion_card_cell_choose", 
            terminal_state = 0, 
            cell = self,
            isPressedActionEnabled = true
        },
        nil,0)

    self:updateChooseState(self._index == 1)
	self:updateDraw()
end

function SmRoleFashionCard:onEnterTransitionFinish()
end

function SmRoleFashionCard:init(params)
    self._index = params[1]
    self.skin_evo_id = params[2]
    self.ship_skin_id = tonumber(self.skin_evo_id.skin_mould_id)
    self.ship_evo_id = self.skin_evo_id.evo_mould_id
    self.default_evolution_status = params[3]
    self.current_skin_id = params[4]
    self:onInit()
    self:setContentSize(SmRoleFashionCard.__size)
    return self
end

function SmRoleFashionCard:onExit()
end