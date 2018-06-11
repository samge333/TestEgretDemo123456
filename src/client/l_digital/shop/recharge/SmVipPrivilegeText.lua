-- ----------------------------------------------------------------------------------------------------
-- 说明：smVIP介绍文字
-------------------------------------------------------------------------------------------------------
SmVipPrivilegeText = class("SmVipPrivilegeTextClass", Window)
function SmVipPrivilegeText:ctor()
    self.super:ctor()
    self.roots = {}
    self.text = ""
end

function SmVipPrivilegeText:onUpdateDraw()
	local root = self.roots[1]
	local Text_vip_text = ccui.Helper:seekWidgetByName(root, "Text_vip_text")
	local str = zstring.replace(self.text , "%%|%d+|","")
	str = zstring.replace(str , "%%","")
	Text_vip_text:setString(str)
	local max_width = Text_vip_text:getAutoRenderSize().width
	Text_vip_text:setString("")
	local _richText2 = ccui.RichText:create()
	_richText2:ignoreContentAdaptWithSize(false)

	local richTextWidth = root:getContentSize().width - 50
    if richTextWidth == 0 then
        richTextWidth = Text_vip_text:getFontSize() * 6
    end
			    
	_richText2:setContentSize(cc.size(richTextWidth, 0))
	_richText2:setAnchorPoint(cc.p(0, 0))
	local rt, count, text = draw.richTextCollectionMethod(_richText2, 
	self.text, 
	cc.c3b(189, 206, 224),
	cc.c3b(189, 206, 224),
	0, 
	0, 
	Text_vip_text:getFontName(), 
	Text_vip_text:getFontSize(),
	chat_rich_text_color)
	_richText2:setPositionX(- _richText2:getContentSize().width / 2)
    _richText2:setPositionY(Text_vip_text:getFontSize() / 2)
	Text_vip_text:addChild(_richText2)

	local heightN = math.ceil( max_width / tonumber(root:getContentSize().width))
    local height = heightN * (Text_vip_text:getFontSize() + 8)
    if height > root:getContentSize().height then
    	root:setPositionY( height - root:getContentSize().height)
    end
    self:setContentSize(cc.size(root:getContentSize().width , height))
end

function SmVipPrivilegeText:onInit()
	local root = cacher.createUIRef("player/vip_privileges_text.csb", "root")
	root:removeFromParent(false)
    table.insert(self.roots, root)
 	self:addChild(root)
	self:onUpdateDraw()
end

function SmVipPrivilegeText:init(text )
	self.text = text
	self:onInit()
end

function SmVipPrivilegeText:createCell()
	local cell = SmVipPrivilegeText:new()
	cell:registerOnNodeEvent(cell)
	return cell
end

function SmVipPrivilegeText:clearUIInfo( ... )
	local root = self.roots[1]
	local Text_vip_text = ccui.Helper:seekWidgetByName(root, "Text_vip_text")
	if Text_vip_text ~= nil then
		Text_vip_text:setString("")
		Text_vip_text:removeAllChildren(true)
	end
end

function SmVipPrivilegeText:onExit()
    local root = self.roots[1]
    self:clearUIInfo()
	cacher.freeRef("player/vip_privileges_text.csb", root)
end
