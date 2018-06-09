-- ----------------------------------------------------------------------------------------------------
-- 说明：徽章限时兑换
-- 创建时间
-- 作者：
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------
EmblemLimitTimeExchangeCell = class("EmblemLimitTimeExchangeCellClass", Window)
	
function EmblemLimitTimeExchangeCell:ctor()
	self.super:ctor()
	self.roots = {}
	
	-- var
	self.activity = nil
	self.index = 0

	-- load lua files
	app.load("client.cells.utils.resources_icon_cell")
	app.load("client.shop.recharge.RechargeDialog")
	app.load("client.reward.DrawRareReward")
	app.load("client.cells.prop.prop_money_icon")
	app.load("client.cells.equip.equip_icon_cell")
	app.load("client.cells.prop.prop_icon_cell")

	-- Initialize emblem_limit_time_exchange_cell state machine.
	local function init_emblem_limit_time_exchange_cell_terminal()
		--兑换
		local emblem_limit_time_exchange_cell_exchange_terminal = {
			_name = "emblem_limit_time_exchange_cell_exchange",
			_init = function (terminal) 
			
			end,
			_inited = false,
			_instance = self,
			_state = 0,
			_invoke = function(terminal, instance, params)
				local function responseExchangeCallback(response)
					if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						if response.node ~= nil then
							response.node:onUpdateDraw(true)
							------刷新排序
							if response.node.nCount == 0 then
								state_machine.excute("activity_emblem_limit_time_exchange_update_draw",0,"")
							end

							app.load("client.reward.DrawRareReward")
							local getRewardWnd = DrawRareReward:new()
							getRewardWnd:init(7)
							fwin:open(getRewardWnd, fwin._ui)
						end							
					end
				end
				local cell = params._datas.cell
				protocol_command.get_activity_reward.param_list = cell.activity.activity_id.."\r\n" .. ""..tonumber(cell.index - 1).."\r\n".."0"
				NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, cell, responseExchangeCallback, false, nil)
				return true
			end,
			_terminal = nil,
			_terminals = nil
		}
		
		state_machine.add(emblem_limit_time_exchange_cell_exchange_terminal)
		state_machine.init()
	end
	
	-- call func init emblem_limit_time_exchange_cell state machine.
	init_emblem_limit_time_exchange_cell_terminal()
end

function EmblemLimitTimeExchangeCell:onUpdateDraw(update)
	local root = self.roots[1]
	local activityInfo = self.activity.activity_Info[tonumber(self.index)]
	local countInfos = zstring.split(self.activity.activity_params, ",")

	local exchangeInfos = zstring.split(activityInfo.activityInfo_need_day, "@")
	local itemInfos = zstring.splits(exchangeInfos[1], ":", ",")

	-- 标题
	local Text_11 = ccui.Helper:seekWidgetByName(root, "Text_11")
	Text_11:setString(activityInfo.activityInfo_name)

	-- 兑换次数
	self.Text_13 = ccui.Helper:seekWidgetByName(root, "Text_13")
	local nCount = (tonumber(exchangeInfos[2]) - tonumber(countInfos[self.index]))
	self.Text_13:setString(nCount .. "/" .. exchangeInfos[2])
	self.Text_13._def_color = self.Text_13:getColor()
	if nCount <= 0 then
		self.Text_13:setColor(cc.c3b(recruit_preview_tip_color[6][1], recruit_preview_tip_color[6][2], recruit_preview_tip_color[6][3]))

		self.Button_lingqu:setBright(false)
		self.Button_lingqu:setTouchEnabled(false)
		self.Button_lingqu:setHighlighted(true)
	else
		self.Text_13:setColor(self.Text_13._def_color)

		self.Button_lingqu:setBright(true)
		self.Button_lingqu:setTouchEnabled(true)
		self.Button_lingqu:setHighlighted(false)
	end

	self.nCount = nCount

	if true ~= update then
		local ListView_011_2_0 = ccui.Helper:seekWidgetByName(root, "ListView_011_2_0")
		for i, info in pairs(itemInfos) do
			local needPropIcon = ResourcesIconCell:createCell()
			needPropIcon:init(6, tonumber(info[2]), info[1], nil,nil,true,true,1)
			ListView_011_2_0:addChild(needPropIcon)

			-- 设置数量颜色
			-- local item_order_level = ccui.Helper:seekWidgetByName(needPropIcon.roots[1], "Label_l-order_level") -- 右下角等级，数量
			-- item_order_level:setVisible(true)
		end

		if "" ~= activityInfo.activityInfo_reward_select then
			local rewardInfo = zstring.splits(activityInfo.activityInfo_reward_select, "|", ",")[1]
			local Panel_reward_2 = ccui.Helper:seekWidgetByName(root, "Panel_reward_2")
			local rewardIcon = ResourcesIconCell:createCell()
			if tonumber(rewardInfo[1]) == 7 then
				local quality = 3
				rewardIcon:init(tonumber(rewardInfo[1]),0,tonumber(rewardInfo[2]),nil,nil,true,true,1,{equipQuality = quality})
			else
				rewardIcon:init(tonumber(rewardInfo[1]), tonumber(rewardInfo[3]), rewardInfo[2], nil,nil,true,true,1)
			end
			Panel_reward_2:addChild(rewardIcon)
		end
	end
end
function EmblemLimitTimeExchangeCell:onInit()
	local csbEmblemLimitTimeExchangeCell = csb.createNode("activity/wonderful/april_fools_day_list.csb")
	local root = csbEmblemLimitTimeExchangeCell:getChildByName("root")
	table.insert(self.roots, root)
	root:removeFromParent(false)
	self:addChild(root)
	
	self:setContentSize(root:getChildByName("Panel_land_list"):getContentSize())

	-- 兑换奖励
	self.Button_lingqu = fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_12_4"), nil,
	{
		terminal_name = "emblem_limit_time_exchange_cell_exchange",
		terminal_state = 0,
		isPressedActionEnabled = true,
		cell = self,
	}, nil, 0)

	self:onUpdateDraw()
end

function EmblemLimitTimeExchangeCell:onExit()
	
end

function EmblemLimitTimeExchangeCell:init(activity, index, listView)
	self.activity = activity
	self.index = index
	self.listView = listView
	self:onInit()
end

function EmblemLimitTimeExchangeCell:createCell()
	local cell = EmblemLimitTimeExchangeCell:new()
	cell:registerOnNodeEvent(cell)
	return cell
end

