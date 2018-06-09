----------------------------------------------------------------------------------------------------
-- 说明：sm商城道具购买单元项
----------------------------------------------------------------------------------------------------
SmShopPropBuyListCell = class("SmShopPropBuyListCellClass", Window)
SmShopPropBuyListCell.__size = nil

function SmShopPropBuyListCell:ctor()
    self.super:ctor()

    -- 定义封装类中的变量
	self.roots = {}		-- 界面中的UI根节点，供模块获取界面中的UI元素实例
	self.prop = nil		-- 当前要绘制的道具实例数据对对象
	self.actions = {}
	app.load("client.cells.utils.resources_icon_cell")
	app.load("client.l_digital.shop.SmShopBuy")
	
	-- 初始化道具小图标事件响应需要使用的状态机
	local function init_sm_shop_prop_buy_list_cell_terminal()
	--使用按钮的点击
		local sm_shop_prop_buy_list_buy_terminal = {
            _name = "sm_shop_prop_buy_list_buy",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	local cell = params[1]
            	local root = cell.roots[1]
            	local Image_sell_out = ccui.Helper:seekWidgetByName(root, "Image_sell_out")
            	if Image_sell_out:isVisible() == true then
            	else
            		state_machine.excute("sm_shop_buy_open",0,{cell.prop , cell , cell.index})
            	end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		--刷新列表
		local sm_shop_prop_buy_list_refush_terminal = {
            _name = "sm_shop_prop_buy_list_refush",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	local root = params.roots[1]
            	local Image_sell_out = ccui.Helper:seekWidgetByName(root, "Image_sell_out")
            	Image_sell_out:setVisible(true)
            	Image_sell_out:setScale(2)
            	Image_sell_out:runAction(cc.ScaleTo:create(0.1, 1))
            	local show_group = nil
				if params.page == 2 then
					show_group = _ED.secret_shop_init_info.goods_info[tonumber(params.index)]
					params.prop.buy_times = 1 - tonumber(show_group.remain_times)
				elseif params.page == 3 then
					show_group = _ED.arena_good[tonumber(params.index)]
					params.prop.buy_times = tonumber(show_group.exchange_times)
				elseif params.page == 4 then
					show_group = _ED.glories_shop_info[tonumber(params.index)]
					params.prop.buy_times = tonumber(show_group.goods_exchange_times)
				elseif params.page == 5 then
					show_group = _ED.union.union_shop_info.treasure.goods_info[tonumber(params.index)]
					params.prop.buy_times = tonumber(show_group.remain_times)
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		state_machine.add(sm_shop_prop_buy_list_buy_terminal)
		state_machine.add(sm_shop_prop_buy_list_refush_terminal)
        state_machine.init()
	end
	init_sm_shop_prop_buy_list_cell_terminal()
end


function SmShopPropBuyListCell:onUpdateDraw()
	local root = self.roots[1]
	local Text_name = ccui.Helper:seekWidgetByName(root, "Text_name")
	Text_name:setString(self.prop.mould_name.." x"..self.prop.number)
	local quality = tonumber(self.prop.prop_quality)
	Text_name:setColor(cc.c3b(color_Type[quality+1][1], color_Type[quality+1][2], color_Type[quality+1][3]))
	local Text_5 = ccui.Helper:seekWidgetByName(root, "Text_5")
	Text_5:setString(self.prop.sale_percentage)
	local Image_sell_out = ccui.Helper:seekWidgetByName(root, "Image_sell_out")
	if tonumber(self.prop.buy_times) > 0 then
		Image_sell_out:setVisible(true)
	else
		Image_sell_out:setVisible(false)
	end

	-- image_gem_1   
	-- image_money_1 
	-- image_jjb_1   
	-- image_slb_1   
	-- image_ghb_1   

	local Panel_icon = ccui.Helper:seekWidgetByName(root, "Panel_icon")

	local cost_image = {
		"images/ui/icon/zuanshi.png",   		-- 钻石
		"images/ui/icon/jinbi.png",   		-- 金币
		"images/ui/icon/qh_pic_jjb.png",   		--竞技币
		"images/ui/icon/slb.png",   		--试炼币
		"images/ui/icon/icon_ghb.png",   		--公会币
	}
	if self.page == 2 then
		if self.prop.sell_type == 1 then
			Panel_icon:setBackGroundImage(cost_image[1])
		else
			Panel_icon:setBackGroundImage(cost_image[2])
		end
	else
		Panel_icon:setBackGroundImage(cost_image[self.page])
	end
	local Panel_6 = ccui.Helper:seekWidgetByName(root, "Panel_6")
	Panel_6:removeAllChildren(true)
	local cell = ResourcesIconCell:createCell()
	if tonumber(self.prop.type) == 7 then
		cell:init(tonumber(self.prop.type),0,tonumber(self.prop.mould_id),nil,nil,nil,nil,nil,{equipQuality = quality})
	else
		cell:init(tonumber(self.prop.type),0,tonumber(self.prop.mould_id))
	end
	Panel_6:addChild(cell)
	local panel = ccui.Helper:seekWidgetByName(cell.roots[1], "Panel_prop")
	panel:setTouchEnabled(false)

	local Image_1 = ccui.Helper:seekWidgetByName(root, "Image_1")
	if Image_1 ~= nil then
		Image_1:setVisible(false)
	end
end

function SmShopPropBuyListCell:onInit()
    local root = cacher.createUIRef("list/list_daoju.csb", "root")
	root:removeFromParent(false)
	self:addChild(root)
	table.insert(self.roots, root)
	
	-- local panel = ccui.Helper:seekWidgetByName(root, "Panel_5")
	local panel_size = root:getContentSize()
	self:onUpdateDraw()
	self:setContentSize(panel_size)
	if SmShopPropBuyListCell.__size == nil then
		SmShopPropBuyListCell.__size = panel_size
	end

	-- self:runAction(cc.Sequence:create({cc.DelayTime:create(0.1), cc.CallFunc:create(function ( sender )
    	-- self:setVisible(true)
 --        sender.roots[1]:runAction(cc.Sequence:create(
 --            cc.ScaleTo:create(0.1, 0.95),
 --            cc.ScaleTo:create(0.05, 1)
 --            ))
 --    end)}))

 	local function PanelTouchEvent(sender, evenType)
        local __spoint = sender:getTouchBeganPosition()
        local __mpoint = sender:getTouchMovePosition()
        local __epoint = sender:getTouchEndPosition()
        if ccui.TouchEventType.began == evenType then
        elseif ccui.TouchEventType.moved == evenType then
        elseif ccui.TouchEventType.canceled == evenType then
        elseif ccui.TouchEventType.ended == evenType then
            if math.abs(__epoint.x - __spoint.x) <= 3 
            	and math.abs(__epoint.y - __spoint.y) <= 3 then
                state_machine.excute("sm_shop_prop_buy_list_buy",0,{sender._self})
            end
        end
    end
 	local Image_purchase = ccui.Helper:seekWidgetByName(root, "Image_purchase")
 	Image_purchase._self = self
 	Image_purchase:addTouchEventListener(PanelTouchEvent)
	-- fwin:addTouchEventListener(, nil, 
	-- {
	-- 	terminal_name = "sm_shop_prop_buy_list_buy", 
	-- 	terminal_state = 0, 
	-- 	_cell = self,
	-- }, 
	-- nil, 0)
end

function SmShopPropBuyListCell:reload()
    local root = self.roots[1]
    if root ~= nil then
        return
    end
    self:onInit()
end

function SmShopPropBuyListCell:unload()
    local root = self.roots[1]
    if root == nil then
        return
    end
	self:clearUIInfo()
    cacher.freeRef("list/list_daoju.csb", root)
    root:stopAllActions()
    root:removeFromParent(false)
    self.roots = {}
end

function SmShopPropBuyListCell:clearUIInfo( ... )
    local root = self.roots[1]
	local Text_name = ccui.Helper:seekWidgetByName(root, "Text_name")
	local Text_5 = ccui.Helper:seekWidgetByName(root, "Text_5")
	local Panel_6 = ccui.Helper:seekWidgetByName(root, "Panel_6")
	local Panel_icon = ccui.Helper:seekWidgetByName(root, "Panel_icon")
	if Text_name ~= nil then
		Text_name:setString("")
		Text_5:setString("")
		Panel_6:removeAllChildren(true)
		Panel_icon:removeBackGroundImage()
	end
    local Image_1 = ccui.Helper:seekWidgetByName(root, "Image_1")
	if Image_1 ~= nil then
		Image_1:setVisible(false)
	end
end

function SmShopPropBuyListCell:onExit()
	self:clearUIInfo()
    cacher.freeRef("list/list_daoju.csb", self.roots[1])
end

function SmShopPropBuyListCell:init(prop , page , index)
	self.prop = prop
	self.page = page
	self.index = index
	if self.index <= 4 then
		self:onInit()
	end
	self:setContentSize(SmShopPropBuyListCell.__size)
end

function SmShopPropBuyListCell:createCell()
	local cell = SmShopPropBuyListCell:new()
	cell:registerOnNodeEvent(cell)
	return cell
end


