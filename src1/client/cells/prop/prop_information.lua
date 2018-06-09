----------------------------------------------------------------------------------------------------
-- 说明：道具信息查看
----------------------------------------------------------------------------------------------------
propInformation = class("propInformationClass", Window)

function propInformation:ctor()
    self.super:ctor()
	app.load("client.cells.prop.prop_icon_new_cell")
	app.load("client.cells.equip.equip_icon_new_cell")
    -- 定义封装类中的变量
	self.roots = {}		-- 界面中的UI根节点，供模块获取界面中的UI元素实例
	self.prop = nil		-- 当前要绘制的道具实例数据对对象
	self.type = nil
	-- 初始化道具小图标事件响应需要使用的状态机
	local function init_prop_info_cell_terminal()
		local prop_info_cell_close_terminal = {
            _name = "prop_info_cell_close",
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
		
		state_machine.add(prop_info_cell_close_terminal)
		
        state_machine.init()
	end
	init_prop_info_cell_terminal()
end

function propInformation:onUpdateDraw()
	local root = self.roots[1]

	local headPanel = ccui.Helper:seekWidgetByName(root, "Panel_djxx_tx")
	local name = ccui.Helper:seekWidgetByName(root, "Text_djxx_name")
	local describe = ccui.Helper:seekWidgetByName(root, "Text_djxx_ms")
	local Text_have_n = ccui.Helper:seekWidgetByName(root, "Text_have_n")
	if Text_have_n ~= nil then
		Text_have_n:setString(1)
	end
	local mouldId = self.prop.user_prop_template
	if mouldId==nil then
		mouldId = self.prop.mould_id
	end
	if mouldId==nil then
		mouldId = self.prop
	end

	local rsize = nil
	if self.type == 1 then
		if self.prop.user_prop_template ~= nil then
			local iconCell = PropIconNewCell:createCell()
			iconCell:init(iconCell.enum_type._SHOW_ONLY_ICON_NOT_CHOOSE, self.prop)
			headPanel:addChild(iconCell)
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				name:setString(setThePropsIcon(mouldId)[2])
			else
				name:setString(dms.string(dms["prop_mould"], mouldId, prop_mould.prop_name))
			end
			local colortype = dms.int(dms["prop_mould"],mouldId,prop_mould.prop_quality)
			name:setColor(cc.c3b(color_Type[colortype+1][1],color_Type[colortype+1][2],color_Type[colortype+1][3]))
			local propremark = dms.string(  dms["prop_mould"],mouldId,prop_mould.remarks)
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				propremark = drawPropsDescription(mouldId)
			end
			-- describe:setString(propremark)
			describe:removeAllChildren(true)
		    local _richText2 = ccui.RichText:create()
		    _richText2:ignoreContentAdaptWithSize(false)

		    local richTextWidth = describe:getContentSize().width
	        if richTextWidth == 0 then
		        richTextWidth = describe:getFontSize() * 6
		    end

		    _richText2:setContentSize(cc.size(richTextWidth, 0))
		    _richText2:setAnchorPoint(cc.p(0, 0))

		    local rt, count, text = draw.richTextCollectionMethod(_richText2, 
		    propremark, 
		    cc.c3b(255, 255, 255),
		    cc.c3b(255, 255, 255),
		    0, 
		    0, 
		    describe:getFontName(), 
		    describe:getFontSize(),
		    chat_rich_text_color)

		    _richText2:formatTextExt()
		    rsize = _richText2:getContentSize()
		    _richText2:setPositionY(describe:getContentSize().height)
		    _richText2:setPositionX(0)
		    describe:addChild(_richText2)
			if Text_have_n ~= nil then
				Text_have_n:setString(zstring.tonumber(getPropAllCountByMouldId(mouldId)))
			end
		else
			local iconCell = PropIconNewCell:createCell()
			iconCell:init(iconCell.enum_type._SHOW_PROP_INFORMATION_NOT_CHOOSE, self.prop)
			headPanel:addChild(iconCell)
			local quality = dms.int(dms["prop_mould"],mouldId,prop_mould.prop_quality) + 1
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				name:setString(setThePropsIcon(mouldId)[2])
			else
				name:setString(dms.string(dms["prop_mould"], mouldId, prop_mould.prop_name))
			end
			name:setColor(cc.c3b(color_Type[quality][1],color_Type[quality][2], color_Type[quality][3]))
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				-- describe:setString(drawPropsDescription(mouldId))
				describe:removeAllChildren(true)
			    local _richText2 = ccui.RichText:create()
			    _richText2:ignoreContentAdaptWithSize(false)

			    local richTextWidth = describe:getContentSize().width
		        if richTextWidth == 0 then
			        richTextWidth = describe:getFontSize() * 6
			    end

			    _richText2:setContentSize(cc.size(richTextWidth, 0))
			    _richText2:setAnchorPoint(cc.p(0, 0))

			    local rt, count, text = draw.richTextCollectionMethod(_richText2, 
			    drawPropsDescription(mouldId), 
			    cc.c3b(255, 255, 255),
			    cc.c3b(255, 255, 255),
			    0, 
			    0, 
			    describe:getFontName(), 
			    describe:getFontSize(),
			    chat_rich_text_color)

			    _richText2:formatTextExt()
			    rsize = _richText2:getContentSize()
			    _richText2:setPositionY(describe:getContentSize().height)
			    _richText2:setPositionX(0)
			    describe:addChild(_richText2)
			else
				describe:setString(dms.string(dms["prop_mould"],mouldId,prop_mould.remarks))
			end
			
			if Text_have_n ~= nil then
				Text_have_n:setString(zstring.tonumber(getPropAllCountByMouldId(mouldId)))
			end
		end
		
	else
		local equipQuality = tonumber(self.prop.equipment_quality) + 1
		name:setString(self.prop.mould_name)
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			-- describe:setString(smEquipWordlFundByIndex(self.prop.mould_id , 2))
			describe:removeAllChildren(true)
		    local _richText2 = ccui.RichText:create()
		    _richText2:ignoreContentAdaptWithSize(false)

		    local richTextWidth = describe:getContentSize().width
	        if richTextWidth == 0 then
		        richTextWidth = describe:getFontSize() * 6
		    end
			    
		    _richText2:setContentSize(cc.size(richTextWidth, 0))
		    _richText2:setAnchorPoint(cc.p(0, 0))

		    local rt, count, text = draw.richTextCollectionMethod(_richText2, 
		    smEquipWordlFundByIndex(self.prop.mould_id , 2), 
		    cc.c3b(255, 255, 255),
		    cc.c3b(255, 255, 255),
		    0, 
		    0, 
		    describe:getFontName(), 
		    describe:getFontSize(),
		    chat_rich_text_color)

		    _richText2:formatTextExt()
		    rsize = _richText2:getContentSize()
		    _richText2:setPositionY(describe:getContentSize().height)
		    _richText2:setPositionX(0)
		    describe:addChild(_richText2)
		else
			describe:setString(dms.string(dms["equipment_mould"], self.prop.mould_id, equipment_mould.trace_remarks))
		end
		name:setColor(cc.c3b(color_Type[equipQuality][1], color_Type[equipQuality][2], color_Type[equipQuality][3]))
		
		local iconCell = EquipIconNewCell:createCell()
		iconCell:init(iconCell.enum_type._SHOW_EMENT_BUY, self.prop, nil)
		headPanel:addChild(iconCell)
		if Text_have_n ~= nil then
			local numbers = 0
			for i, v in pairs(_ED.user_equiment) do
				if tonumber(self.prop.mould_id) == tonumber(v.user_equiment_template) then
					numbers = numbers + 1
				end
			end
			Text_have_n:setString(numbers)
		end
	end
	if  __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
        local Image_djxx = ccui.Helper:seekWidgetByName(root, "Image_djxx")
	    local Image_djxx_bg = ccui.Helper:seekWidgetByName(root, "Image_djxx_bg")
	    local textRenderSize = describe:getAutoRenderSize() -- 未换行前尺寸
	    -- local VirtualRendererSize = describe:getContentSize() -- 控件本身可渲染尺寸
	    local VirtualRendererSize = rsize
	    local needRowNumber = math.ceil(textRenderSize.width / VirtualRendererSize.width)
	    local currRowNumber = VirtualRendererSize.height / textRenderSize.height
	    local curHeight = 0
	    if Image_djxx:getContentSize().height < VirtualRendererSize.height then
	    	curHeight = VirtualRendererSize.height - Image_djxx:getContentSize().height + describe:getFontSize()
	    	Image_djxx:setContentSize(cc.size(Image_djxx:getContentSize().width , Image_djxx:getContentSize().height + curHeight))
	    	Image_djxx_bg:setContentSize(cc.size(Image_djxx_bg:getContentSize().width , Image_djxx_bg:getContentSize().height + curHeight))
	    	root:setPosition(cc.p(root:getPositionX() , root:getPositionY() + curHeight))
		end
	 --    if needRowNumber > currRowNumber then
	 --    	if verifySupportLanguage(_lua_release_language_en) == true then
		-- 		curHeight = (needRowNumber - currRowNumber) * textRenderSize.height+textRenderSize.height*3
		-- 	else
		-- 		curHeight = (needRowNumber - currRowNumber) * textRenderSize.height
		-- 	end
		-- 	describe:setContentSize(cc.size(describe:getContentSize().width , describe:getContentSize().height + curHeight))
		-- 	Image_djxx:setContentSize(cc.size(Image_djxx:getContentSize().width , Image_djxx:getContentSize().height + curHeight))
		-- 	Image_djxx_bg:setContentSize(cc.size(Image_djxx_bg:getContentSize().width , Image_djxx_bg:getContentSize().height + curHeight))
		-- 	root:setPosition(cc.p(root:getPositionX() , root:getPositionY() + curHeight))
		-- end
		local screenSize = cc.Director:getInstance():getWinSize() 
		local rootPos = fwin:convertToWorldSpace(root, cc.p(0, 0))
		if rootPos.y + Image_djxx_bg:getContentSize().height * app.scaleFactor > screenSize.height then
			root:setPositionY(root:getPositionY() - rootPos.y / app.scaleFactor - Image_djxx_bg:getContentSize().height + screenSize.height / app.scaleFactor - 10)
		end
		if rootPos.x + Image_djxx_bg:getContentSize().width * app.scaleFactor / 2 > screenSize.width then
			root:setPositionX(root:getPositionX() - rootPos.x / app.scaleFactor - Image_djxx_bg:getContentSize().width / 2 + screenSize.width / app.scaleFactor - 10 )
		end
		if rootPos.x - Image_djxx_bg:getContentSize().width * app.scaleFactor / 2 < 0 then
			root:setPositionX(root:getPositionX() - rootPos.x / app.scaleFactor + Image_djxx_bg:getContentSize().width / 2)
		end
		if nil == self.widget then
			root:setPosition(cc.p(screenSize.width / app.scaleFactor / 2, screenSize.height / app.scaleFactor / 2 - Image_djxx_bg:getContentSize().height / 2))
		end
    end
end

function propInformation:onEnterTransitionFinish()
	local csbItem = csb.createNode("packs/warehouse_information_1.csb")
	local root = csbItem:getChildByName("root")
	
	if  __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
    else
		local action = csb.createTimeline("packs/warehouse_information.csb")
		action:gotoFrameAndPlay(0, action:getDuration(), false)
	    csbItem:runAction(action)
	end

	self:addChild(csbItem)
	table.insert(self.roots, root)
	
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_dj_xx"), nil, {func_string = [[state_machine.excute("prop_info_cell_close", 0, "click prop_info_cell_close.'")]]}, nil, 0)
	self:onUpdateDraw()
end

function propInformation:onExit()
	state_machine.remove("prop_info_cell_close")

end

-- 基于模板id,构造一个可适配当前显示方式的对象
function propInformation:constructionPropTemplate(user_prop_template)
	local prop = {
		user_prop_template = user_prop_template,
		mould_name = dms.string(dms["prop_mould"], user_prop_template, prop_mould.prop_name)
	}
	return prop
end

function propInformation:init(prop, types, widget)
	self.prop = prop
	self.type = types -- 1 道具 否则装备
	self.widget = widget
	if nil ~= widget then
		local pos = fwin:convertToWorldSpace(widget, cc.p(0, 0))
		local anchor = widget:getAnchorPoint()
		local size = widget:getContentSize()
		pos.x = pos.x / app.scaleFactor + size.width / 2 -- (size.width * anchor.x)
		-- pos.y = pos.y + (size.height * anchor.y) + 50
		pos.y = pos.y / app.scaleFactor + size.height - 25 * app.scaleFactor
		self:setPosition(pos)
	else
		--self:setPosition(cc.p(fwin._width / 2, fwin._height / 2))
	end
end

function propInformation:createCell()
	local cell = propInformation:new()
	cell:registerOnNodeEvent(cell)
	return cell
end

