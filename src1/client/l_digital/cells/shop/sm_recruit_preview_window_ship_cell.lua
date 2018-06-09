--------------------------------------------------------------------------------------------------------------
--  招募奖励预览数码兽列表cell
--------------------------------------------------------------------------------------------------------------
SmRecruitPreviewWindowShipCell = class("SmRecruitPreviewWindowShipCellClass", Window)
SmRecruitPreviewWindowShipCell.__size = nil

-- 创建cell
local sm_recruit_preview_window_ship_cell_create_terminal = {
    _name = "sm_recruit_preview_window_ship_cell_create",
    _init = function (terminal)
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        local cell = SmRecruitPreviewWindowShipCell:new()
        cell:init(params)
        cell:registerOnNodeEvent(cell)
        return cell
    end,
    _terminal = nil,
    _terminals = nil
}
state_machine.add(sm_recruit_preview_window_ship_cell_create_terminal)
state_machine.init()

function SmRecruitPreviewWindowShipCell:ctor()
    self.super:ctor()
    self.roots = {}

    self._index = 0
    self._info = nil
    
    -- 初始化状态机
    local function init_sm_recruit_preview_window_ship_cell_terminal()

    end 
    init_sm_recruit_preview_window_ship_cell_terminal()

end

function SmRecruitPreviewWindowShipCell:updateHeroAnimation()
    local root = self.roots[1]
    local Panel_digimon_dh = ccui.Helper:seekWidgetByName(root,"Panel_digimon_dh")
    Panel_digimon_dh:removeAllChildren(true)

    local evo_mould_info = zstring.split(dms.string(dms["ship_mould"], self._info.mould_id, ship_mould.fitSkillTwo), ",")
    local evo_index = dms.int(dms["ship_mould"], self._info.mould_id, ship_mould.captain_name)
    local evo_mould_id = evo_mould_info[evo_index]

    local temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
        draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), Panel_digimon_dh, nil, nil, cc.p(0.5, 0))
        local armature_hero = sp.spine_sprite(Panel_digimon_dh, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
        armature_hero:setScaleX(-1)
        armature_hero.animationNameList = spineAnimations
        sp.initArmature(armature_hero, true)
    else
        Panel_digimon_dh:removeBackGroundImage()
        Panel_digimon_dh:setBackGroundImage(string.format("images/face/big_head/big_head_%d.png", temp_bust_index))
    end
end

-- 刷新
function SmRecruitPreviewWindowShipCell:updateDraw()
    local root = self.roots[1]
    local Text_digimon_name = ccui.Helper:seekWidgetByName(root,"Text_digimon_name")
    local Panel_star = ccui.Helper:seekWidgetByName(root,"Panel_star")

    Text_digimon_name:setString("")
    Panel_star:removeAllChildren(true)

    local name = smHeroWorldFundByMouldId(self._info.mould_id, 1)
    Text_digimon_name:setString(name)

    local initStar = zstring.tonumber(self._info.order)
    neWshowShipStar(Panel_star , initStar)

    self:updateHeroAnimation()
end 

function SmRecruitPreviewWindowShipCell:onInit()
    local root = cacher.createUIRef("shop/sm_recruit_preview_window_tab_1_list.csb", "root")
    table.insert(self.roots, root)
    self:addChild(root)

    if SmRecruitPreviewWindowShipCell.__size == nil then
        SmRecruitPreviewWindowShipCell.__size = root:getContentSize()
    end

    self:updateDraw()
end

function SmRecruitPreviewWindowShipCell:onEnterTransitionFinish()
    local root = self.roots[1]
end

function SmRecruitPreviewWindowShipCell:clearUIInfo( ... )
    local root = self.roots[1]
    local Text_digimon_name = ccui.Helper:seekWidgetByName(root,"Text_digimon_name")
    local Panel_star = ccui.Helper:seekWidgetByName(root,"Panel_star")
    local Panel_digimon_dh = ccui.Helper:seekWidgetByName(root,"Panel_digimon_dh")

    if Text_digimon_name ~= nil then
        Text_digimon_name:setString("")
        Panel_star:removeAllChildren(true)
        Panel_digimon_dh:removeAllChildren(true)
    end
end

function SmRecruitPreviewWindowShipCell:reload()
    local root = self.roots[1]
    if root ~= nil then
        return
    end
    self:onInit()
end

function SmRecruitPreviewWindowShipCell:unload()
    local root = self.roots[1]
    if root == nil then
        return
    end
    self:clearUIInfo()
    cacher.freeRef("shop/sm_recruit_preview_window_tab_1_list.csb", root)
    root:removeFromParent(false)
    self.roots = {}
end

function SmRecruitPreviewWindowShipCell:init(params)
    self._index = params[1]
    self._info = params[2]

    if self._index ~= nil and self._index <= 8 then
       self:onInit()
    end
    self:setContentSize(SmRecruitPreviewWindowShipCell.__size)
    return self
end

function SmRecruitPreviewWindowShipCell:onExit()
    self:clearUIInfo()
    cacher.freeRef("shop/sm_recruit_preview_window_tab_1_list.csb", self.roots[1])
end