-- ----------------------------------------------------------------------------------------------------
-- 说明：叛军排行榜伤害排行榜
-------------------------------------------------------------------------------------------------------

RebelBossBattleReportListCell = class("RebelBossBattleReportListCellClass", Window)
    
function RebelBossBattleReportListCell:ctor()
    self.super:ctor()
    self.roots = {}
	self.reward = nil

	
    -- Initialize RebelBossBattleReportListCell page state machine.
    local function init_rebel_boss_hurt_rank_list_cell()

    end
    
    -- call func init hom state machine.
    init_rebel_boss_hurt_rank_list_cell()
end

function RebelBossBattleReportListCell:initDraw()
	local root = self.roots[1]
	if root == nil then 
		return
	end
end

function RebelBossBattleReportListCell:onEnterTransitionFinish()
	
    local csbArenaLadder = csb.createNode("campaign/WorldBoss/wordBoss_phb_list_1.csb")
	local root = csbArenaLadder:getChildByName("root")
	table.insert(self.roots, root)
    self:addChild(csbArenaLadder)
	
	local tmpPanel = ccui.Helper:seekWidgetByName(root, "Panel_ph_list")
	tmpPanel:setSwallowTouches(false)
	self:setContentSize(tmpPanel:getContentSize())
	self:initDraw()
end

function RebelBossBattleReportListCell:createCell()
	local cell = RebelBossBattleReportListCell:new()
	cell:registerOnNodeEvent(cell)
	return cell
end

function RebelBossBattleReportListCell:init(reward)
	self.reward = reward
end


function RebelBossBattleReportListCell:onExit()
end
