-- ----------------------------------------------------------------------------------------------------
-- 说明：邮件
-- 创建时间	2015-04-23
-- 作者：邓啸宇
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------

EmailManagerFour = class("EmailManagerFourClass", Window)
    
function EmailManagerFour:ctor()
    self.super:ctor()
	self.roots = {}
	app.load("client.email.EmailManagerList")
	self.count = 1
	self.num = 6
    -- Initialize EmailManager page state machine.
    local function init_email_manager_four_terminal()
        state_machine.init()
    end
    
    -- call func init hom state machine.
    init_email_manager_four_terminal()
end

function EmailManagerFour:onUpdateMore()
	local csbItem = csb.createNode("email/email_list_more.csb")
	local roots = csbItem:getChildByName("root")
	roots:removeFromParent(true)
	
	local Panel_2 = ccui.Helper:seekWidgetByName(roots, "Panel_2")
	local MySize = Panel_2:getContentSize()
	roots:setContentSize(MySize)
	
	return roots
end


function EmailManagerFour:onUpdateDraw()
	local root = self.roots[1]
	local listView = ccui.Helper:seekWidgetByName(root, "ListView_04")
	listView:requestRefreshView()
	if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
		local function sortEmail( a, b )
			return tonumber(a.mailTime) < tonumber(b.mailTime)
		end
		table.sort(_ED.mail_item, sortEmail)
		--双列表		
		app.load("client.cells.utils.multiple_list_view_cell")
		local preMultipleCell = nil
		local MylistViewCell = nil
		for i = self.count, zstring.tonumber(_ED.mail_cont) do
			if _ED.mail_item[self.count].mailChanneId == "1" then
				local cell = EmailManagerList:createCell()
				cell:init(_ED.mail_item[self.count])
				if MylistViewCell == nil then
					MylistViewCell = MultipleListViewCell:createCell()
					MylistViewCell:init(listView, cc.size(430,130))
					listView:addChild(MylistViewCell)
					MylistViewCell.prev = preMultipleCell
					if preMultipleCell ~= nil then
						preMultipleCell.next = MylistViewCell
					end
				end
				MylistViewCell:addNode(cell)
				if MylistViewCell.child2 ~= nil then
					preMultipleCell = MylistViewCell
					MylistViewCell = nil
				end
				self.count = self.count + 1
			end
		end
	else	
		for i = self.count, tonumber(_ED.mail_cont) do
			if _ED.mail_item[self.count].mailChanneId == "1" then
				if self.count <= self.num then
					local cell = EmailManagerList:createCell()
					cell:init(_ED.mail_item[self.count])
					listView:addChild(cell)
				else
					local cell = self:onUpdateMore()
					listView:addChild(cell)
					break
				end
				self.count = self.count + 1
			end
		end
	end
	self.num = self.num + 6
end

function EmailManagerFour:onUpdateDraw2()
	local root = self.roots[1]
	local listView = ccui.Helper:seekWidgetByName(root, "ListView_04")
	local function listViewEventCallBack(sender, evenType)
		if evenType == ccui.ScrollviewEventType.scrollToBottom then
            listView:removeItem(self.count-1)
			self:onUpdateDraw()
        elseif evenType ==  ccui.ScrollviewEventType.scrollToTop then
           
        end
	end
	
	listView:addScrollViewEventListener(listViewEventCallBack)
end
function EmailManagerFour:onEnterTransitionFinish()
	local csbEmailManager = csb.createNode("email/email_listview_4.csb")
	self:addChild(csbEmailManager)
	local root = csbEmailManager:getChildByName("root")
	table.insert(self.roots, root)
	
	local function responseInitCallback(response)
		if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
			
			if response.node == nil or response.node.roots == nil then
				--窗口已经不存在，return
				return
			end
			response.node:onUpdateDraw()
			response.node:onUpdateDraw2()
		end
	end
	--社交

	if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
		self:onUpdateDraw()
		self:onUpdateDraw2()
	else
		protocol_command.email_init.param_list = "1" .."\r\n".."1" .."\r\n" ..  "30"
		NetworkManager:register(protocol_command.email_init.code, nil, nil, nil, self, responseInitCallback, false, nil)
	end
	
end


function EmailManagerFour:onExit()
	-- state_machine.remove("email_manager_back")
end