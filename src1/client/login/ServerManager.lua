ServerManager = class("ServerManagerClass", Window)
	
	require "frameworks.external.utils.utils"

function updateDefaultServerFile()
	cc.UserDefault:getInstance():setStringForKey("defserver", _ED.selected_server)
	local sers = cc.UserDefault:getInstance():getStringForKey("defservers")
	if sers == nil then
		sers = ""
	end
	local serverList = zstring.zsplit(sers, ",")
	local rsers = ""
	for i, s in ipairs(serverList) do
		if s ~= nil and s ~= _ED.selected_server then
			rsers = rsers..","
			rsers = rsers..s
		end
	end
	rsers = "".._ED.selected_server..rsers
	cc.UserDefault:getInstance():setStringForKey("defservers", rsers)
	cc.UserDefault:getInstance():setStringForKey("defserver", _ED.selected_server)
	cc.UserDefault:getInstance():flush()
end
	
function ServerManager:ctor()
    self.super:ctor()
    self.roots = {}

    self.login_server_list = nil
    self.login_server_list_Container = nil
	self.login_server_list_ContainerPosY = nil

    self.server_list = nil
    self.server_list_Container = nil
	self.server_list_ContainerPosY = nil

    -- Initialize ServerManager page state machine.
    local function init_ServerManager_terminal()
		--返回游戏
        local server_manager_return_login_terminal = {
            _name = "server_manager_return_login",
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
	
        local server_manager_select_server_terminal = {
            _name = "server_manager_select_server",
            _init = function (terminal) 
               
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				_ED.selected_server = params._datas._sel.server_number
				--> debug.log(true, "---====---",_ED.selected_server)
				fwin:find("LoginClass"):updateSelectedServer()
				fwin:close(instance)
                return true
            end,
            _terminal = nil,
            _terminals = nil,
        }
		
		local server_type_img_get_terminal = {
            _name = "server_type_img_get",
            _init = function (terminal) 
               
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				local imagePath = "images/ui/state/server_status_1.png"
				local currentSvrType = math.floor(zstring.tonumber(serverType))
				if currentSvrType > -1 and currentSvrType < 6 then
					imagePath = string.format("images/ui/state/server_status_%d.png",  currentSvrType)
				end
				return imagePath
            end,
            _terminal = nil,
            _terminals = nil
        }
	
        state_machine.add(server_manager_return_login_terminal)
        state_machine.add(server_manager_select_server_terminal)
		state_machine.add(server_type_img_get_terminal)
        state_machine.init()
    end
    
    -- call func init ServerManager state machine.
    init_ServerManager_terminal()
end

function ServerManager:onEnterTransitionFinish()  
	if (__lua_project_id == __lua_project_gragon_tiger_gate 
		or __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_warship_girl_a 
		or __lua_project_id == __lua_project_warship_girl_b 
		or __lua_project_id == __lua_project_digimon_adventure 
		or __lua_project_id == __lua_project_naruto 
		or __lua_project_id == __lua_project_pokemon 
		or __lua_project_id == __lua_project_rouge 
		or __lua_project_id == __lua_project_yugioh 
		or __lua_project_id == __lua_project_adventure)
	   	and ___is_open_ServerManager ~= false
	   	then
		local csbservermanager = csb.createNode("login/server_manager_0.csb")
	    self:addChild(csbservermanager)
		
		local action = csb.createTimeline("login/server_manager_0.csb")
	    csbservermanager:runAction(action)
		self.action = action

		local rootMain = csbservermanager:getChildByName("root")
		local returnlogin = fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(rootMain, "Panel_server_manager_0"), nil, {func_string = [[state_machine.excute("server_manager_return_login", 0, "click user_info.'")]]}, nil, 0)
		local login_server_list = ccui.Helper:seekWidgetByName(rootMain,"ListView_1_jin")
		login_server_list:requestRefreshView()
		self.login_server_list = login_server_list
		--最近登录
		local sers =  cc.UserDefault:getInstance():getStringForKey("defservers")
		if sers == nil then
			sers = ""
		end
		
		local serverListIndex = 0
		local serverList_tab = zstring.zsplit(sers, ",")
		app.load("client.cells.utils.multiple_list_view_cell")
		app.load("client.cells.login.lserver_manager_list_cell")
		local preMultipleCell = nil
		local MylistViewCell = nil
		for i, v in ipairs(serverList_tab) do
			if v ~= nil then
				local defser = _ED.all_servers[v]
				if zstring.tonumber(_ED.linkage_check_serverid) == zstring.tonumber(v) then
					defser = nil
				end
				if defser ~= nil then
					local cell = LServerManagerCell:createCell()
					cell:init(defser.server_type,defser.server_name,i,defser,false)
					if __lua_project_id == __lua_project_adventure and zstring.tonumber(_game_platform_version_type) == 2 then 
						login_server_list:addChild(cell)
					else
						if MylistViewCell == nil then
							MylistViewCell = MultipleListViewCell:createCell()
							MylistViewCell:init(login_server_list,cell:getContentSize())
							login_server_list:addChild(MylistViewCell)
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
					end
				end
			end
		end
		self.login_server_list_ContainerPosY = self.login_server_list:getInnerContainer():getPositionY()

		--最近登录列表结束
		--所有服务器列表
		local server_list = ccui.Helper:seekWidgetByName(rootMain,"ListView_1_jin_0")
		server_list:requestRefreshView()
		self.server_list = server_list
		local _MylistViewCell= nil
		local _preMultipleCell = nil
		local servers_tables_after_sort = {}
		local server_number = #_ED.all_def_servers
		
		if __lua_project_id == __lua_project_adventure then
			--服务器列表排序	
			local function sortType( a, b )
				if zstring.tonumber(a.server_type) == zstring.tonumber(b.server_type) then 
					 if zstring.tonumber(a.id) < zstring.tonumber(b.id) then 
					 	return true 
					 else 
					 	return false
					 end
				else
					if zstring.tonumber(a.server_type)  == 1 then 
						return  zstring.tonumber(a.server_type) > zstring.tonumber(b.server_type)		
					end
					
				end
    		end
    		local temp_servers = {}
    		local show_servers = {}
			for i,v in pairs(_ED.all_def_servers) do
				temp_servers[server_number+ 1 - i] = v	
			end
			for i,v in pairs(temp_servers) do
				if zstring.tonumber(v.server_type) == 1 then 
					table.insert(show_servers, v)	
				end
			end
			for i,v in pairs(temp_servers) do
				if zstring.tonumber(v.server_type) ~= 1 then 
				table.insert(show_servers, v)	
				end
			end
			servers_tables_after_sort = show_servers
		else
			for i,v in pairs(_ED.all_def_servers) do
				servers_tables_after_sort[server_number+ 1 - i] = v
			end
		end
		
		for i=1, table.getn(servers_tables_after_sort) do
			local defser = servers_tables_after_sort[i]		--服务器的值
			if zstring.tonumber(_ED.linkage_check_serverid) == zstring.tonumber(defser.server_number) then

			else
				local cell = LServerManagerCell:createCell()
				cell:init(defser.server_type,defser.server_name,i,defser,true)
				if __lua_project_id == __lua_project_adventure and zstring.tonumber(_game_platform_version_type) == 2 then 
					server_list:addChild(cell)
				else
					if _MylistViewCell == nil then
						_MylistViewCell = MultipleListViewCell:createCell()
						_MylistViewCell:init(server_list,cell:getContentSize())
						server_list:addChild(_MylistViewCell)
						_MylistViewCell.prev = _preMultipleCell
						if _preMultipleCell ~= nil then
							_preMultipleCell.next = _MylistViewCell
						end
					end
					_MylistViewCell:addNode(cell)
					if _MylistViewCell.child2 ~= nil then
						_preMultipleCell = _MylistViewCell
						_MylistViewCell = nil
					end	
				end
			end
		end
		self.server_list_ContainerPosY = self.server_list:getInnerContainer():getPositionY()
	else
	    local csbservermanager = csb.createNode("login/server_manager.csb")
	    self:addChild(csbservermanager)
		
		local action = csb.createTimeline("login/server_manager.csb")
	    csbservermanager:runAction(action)
		self.action = action
	    --action:gotoFrameAndPlay(0, action:getDuration(), false)
		
		local MyPanel = csbservermanager:getChildByName("root"):getChildByName("Panel_904")
		table.insert(self.roots, MyPanel)
		local returnlogin = fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(MyPanel, "Panel_server_manager_0"), nil, {func_string = [[state_machine.excute("server_manager_return_login", 0, "click user_info.'")]]}, nil, 0)
		
		local ScrollView_1 = ccui.Helper:seekWidgetByName(MyPanel, "ScrollView_server_0_0")
		local serverListLayer = ccui.Helper:seekWidgetByName(MyPanel, "Panel_11994")
		
		-- 服务器的数量
		local serverNumber = tonumber(_ED.serverCount)
		local excursions = 0
		if serverNumber > 4 then
			local excursion = serverNumber/2 *80 - 160
			local size = ScrollView_1:getInnerContainerSize()
			ScrollView_1:setInnerContainerSize(cc.size(size.width, size.height+excursion))
			local panel = ccui.Helper:seekWidgetByName(MyPanel, "Panel_12005")
			xx, yy = panel:getPosition()
			panel:setPosition(cc.p(xx-20, yy + excursion))
		end
		
		--最近登录列表
		local sers =  cc.UserDefault:getInstance():getStringForKey("defservers")
		if sers == nil then
			sers = ""
		end
		
		local serverListIndex = 0
		local serverList = zstring.zsplit(sers, ",")
		local defServerListLayer = ccui.Helper:seekWidgetByName(MyPanel, "Panel_recently_0_0")
		
		local function getServerTypeImg(serverType)
			local imagePath = "images/ui/state/server_status_1.png"
			local currentSvrType = math.floor(zstring.tonumber(serverType))
			if currentSvrType > -1 and currentSvrType < 6 then
				imagePath = string.format("images/ui/state/server_status_%d.png",  currentSvrType)
			end
			return imagePath
		end
		
		local insertServer = true
		for i, s in ipairs(serverList) do
			if s ~= nil then
				local defser = _ED.all_servers[s]
				if defser ~= nil then
					-- draw.setImage("ImageView_server_status_1_0_0_0", getServerTypeImg(_ED.all_servers[s].server_type) )
					local csbServerList = csb.createNode("login/server_list.csb")
					local root = csbServerList:getChildByName("root")
					local cell = ccui.Helper:seekWidgetByName(root, "Panel_11984")
					cell:removeFromParent(true)
					
					-- local serverName = draw.text(cell:getWidgetByName("Label_server_name_1_0_0_0"),defser.server_name)
					local serverName = cell:getChildByName("Label_server_name_1_0_0_0*")
					serverName:setString(defser.server_name)
					local serverType = cell:getChildByName("Panel_2")
					if tonumber(defser.server_type) == -1 then
					
					elseif tonumber(defser.server_type) == 0 then
						serverType:setBackGroundImage("images/ui/state/server_status_0.png")
					elseif tonumber(defser.server_type) == 1 then
						serverType:setBackGroundImage("images/ui/state/server_status_1.png")
					elseif tonumber(defser.server_type) == 2 then
						serverType:setBackGroundImage("images/ui/state/server_status_2.png")
					elseif tonumber(defser.server_type) == 3 then
						serverType:setBackGroundImage("images/ui/state/server_status_3.png")
					elseif tonumber(defser.server_type) == 4 then
						serverType:setBackGroundImage("images/ui/state/server_status_4.png")
					elseif tonumber(defser.server_type) == 5 then
						serverType:setBackGroundImage("images/ui/state/server_status_5.png")
					end
					defServerListLayer:addChild(cell)
					
					local servers = fwin:addTouchEventListener(cell, nil, {func_string = [[state_machine.excute("server_manager_select_server", 0, " ")]]}, nil, 0)
					local servers = fwin:addTouchEventListener(cell, nil, {_sel = defser, _undef = false, terminal_name = "server_manager_select_server", terminal_state = 0}, nil, 0)
					if __lua_project_id == __lua_project_adventure then
						local x = 40+(serverListIndex % 1) * 250
						local y = math.floor(serverListIndex / 1) * (-80)
						cell:setPosition(cc.p(x,y))
					
						serverListIndex = serverListIndex + 1
						if i > 1 then
							if serverListIndex > 8 then
								serverListIndex = 8
							end
							excursions = math.ceil(serverListIndex/1) *100
						end
					else
						local x = 40+(serverListIndex % 2) * 250
						local y = math.floor(serverListIndex / 2) * (-80)
						cell:setPosition(cc.p(x,y))
					
						serverListIndex = serverListIndex + 1
						if i > 2 then
							if serverListIndex > 8 then
								serverListIndex = 8
							end
							excursions = math.ceil(serverListIndex/2) *100
						end
					end
				end
			end
		end
		
		
		local severLiseName = ccui.Helper:seekWidgetByName(MyPanel, "Label_all_0_0")
		xx, yy = severLiseName:getPosition()
		severLiseName:setPosition(cc.p(xx, yy - excursions/2))
		
		-----------------------------------------------------------------------------------------------------
		--服务器列表
		
		
		local panel = ccui.Helper:seekWidgetByName(MyPanel, "Panel_12005")
		xx, yy = panel:getPosition()
		panel:setPosition(cc.p(xx-20, yy + excursions/2))
			
		xx, yy = serverListLayer:getPosition()
		
		serverListLayer:setPosition(cc.p(xx, yy - excursions/2))
		
		local size = ScrollView_1:getInnerContainerSize()
		ScrollView_1:setInnerContainerSize(cc.size(size.width, size.height + excursions/2))
		
		local serverListIndex_2 = 0
		local updateServer = nil
		updateServer = function(dt)

			if nil == fwin:find("ServerManagerClass") then
				ServerManager:unscheduler("update_server")
				return
			end
			
			local drawCount = 0
			for i=1, table.getn(_ED.all_def_servers) do
				if serverListIndex_2 < i then
					local csbServerList = csb.createNode("login/server_list.csb")
					local v = _ED.all_def_servers[i]		--服务器的值
					-- draw.setImage("ImageView_server_status_1_0_0_0", getServerTypeImg(v.server_type) )
					
					local root = csbServerList:getChildByName("root")
					local cell = ccui.Helper:seekWidgetByName(root, "Panel_11984")
					cell:removeFromParent(true)
					-- cell:loadTexture("res/images/ui/home/home_10.png")
					-- cell:setTouchEnabled(true)
					local serverName = cell:getChildByName("Label_server_name_1_0_0_0*")
					serverName:setString(v.server_name)
					local serverType = cell:getChildByName("Panel_2")
					if tonumber(v.server_type) == -1 then
					
					elseif tonumber(v.server_type) == 0 then
						serverType:setBackGroundImage("images/ui/state/server_status_0.png")
					elseif tonumber(v.server_type) == 1 then
						serverType:setBackGroundImage("images/ui/state/server_status_1.png")
					elseif tonumber(v.server_type) == 2 then
						serverType:setBackGroundImage("images/ui/state/server_status_2.png")
					elseif tonumber(v.server_type) == 3 then
						serverType:setBackGroundImage("images/ui/state/server_status_3.png")
					elseif tonumber(v.server_type) == 4 then
						serverType:setBackGroundImage("images/ui/state/server_status_4.png")
					elseif tonumber(v.server_type) == 5 then
						serverType:setBackGroundImage("images/ui/state/server_status_5.png")
					end
					serverListLayer:addChild(cell)
					local servers = fwin:addTouchEventListener(cell, nil, {_sel = v, _undef = true, terminal_name = "server_manager_select_server", terminal_state = 0}, nil, 0)
					if __lua_project_id == __lua_project_adventure then
						local x = 40+(serverListIndex_2 % 1) * 250
						local y = math.floor(serverListIndex_2 / 1) * (-80)
						cell:setPosition(cc.p(x,y))
						
						serverListIndex_2 = serverListIndex_2 + 1
						drawCount = drawCount + 1
					else
						local x = 40+(serverListIndex_2 % 2) * 250
						local y = math.floor(serverListIndex_2 / 2) * (-80)
						cell:setPosition(cc.p(x,y))
						
						serverListIndex_2 = serverListIndex_2 + 1
						drawCount = drawCount + 1
					end
				end	
				if drawCount > 10 then
					break
				end	
			end
			if drawCount == 0 then
				ServerManager:unscheduler("update_server")
			end
		end
		
		ServerManager:scheduler("update_server", updateServer, 0.3)
		
		if root ~= nil then
			self._updateDefservers()
			updateServer(0)
		end
	end
end

function ServerManager:onUpdate(dt)
	if self.action ~= nil then
		self.action:gotoFrameAndPlay(0, self.action:getDuration(), false)
		self.action = nil
	end
	if (__lua_project_id == __lua_project_gragon_tiger_gate 
		or __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_warship_girl_a 
		or __lua_project_id == __lua_project_warship_girl_b 
		or __lua_project_id == __lua_project_digimon_adventure 
		or __lua_project_id == __lua_project_naruto 
		or __lua_project_id == __lua_project_pokemon 
		or __lua_project_id == __lua_project_rouge 
		or __lua_project_id == __lua_project_yugioh 
		or __lua_project_id == __lua_project_adventure)
		and ___is_open_ServerManager ~= false
	    then
		self:updateLoginListServer()
		self:updateListServer()
	end
end
function ServerManager:updateLoginListServer()
	if self.login_server_list ~= nil then
		local size = self.login_server_list:getContentSize()
		local posY = self.login_server_list:getInnerContainer():getPositionY()
		if self.login_server_list_ContainerPosY == posY then
			return
		end
		self.login_server_list_ContainerPosY = posY
		local items = self.login_server_list:getItems()
		if items[1] == nil then
			return
		end
		local itemSize = items[1]:getContentSize()
		for i, v in pairs(items) do
			local tempY = v:getPositionY() + posY
			if tempY + itemSize.height * 2 < 0 or tempY > size.height + itemSize.height * 2 then
				v:unload()
			else
				v:reload()
			end
		end
	end
end
function ServerManager:updateListServer()
	if self.server_list ~= nil then
		local size = self.server_list:getContentSize()
		local posY = self.server_list:getInnerContainer():getPositionY()
		if self.server_list_ContainerPosY == posY then
			return
		end
		self.server_list_ContainerPosY = posY
		local items = self.server_list:getItems()
		if items[1] == nil then
			return
		end
		local itemSize = items[1]:getContentSize()
		for i, v in pairs(items) do
			local tempY = v:getPositionY() + posY
			if tempY + itemSize.height * 2 < 0 or tempY > size.height + itemSize.height * 2 then
				v:unload()
			else
				v:reload()
			end
		end
	end
end
function ServerManager:onExit()
	if (__lua_project_id == __lua_project_gragon_tiger_gate 
		or __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		or __lua_project_id == __lua_project_red_alert 
		or __lua_project_id == __lua_project_warship_girl_a 
		or __lua_project_id == __lua_project_warship_girl_b 
		or __lua_project_id == __lua_project_digimon_adventure 
		or __lua_project_id == __lua_project_naruto 
		or __lua_project_id == __lua_project_pokemon 
		or __lua_project_id == __lua_project_rouge 
		or __lua_project_id == __lua_project_yugioh 
		or __lua_project_id == __lua_project_adventure) 
		then
	elseif ___is_open_ServerManager ~= false then
		 
	else
		ServerManager:unscheduler("update_server")
	end
	state_machine.remove("server_manager_return_login")
	state_machine.remove("server_manager_select_server")
	state_machine.remove("server_type_img_get")
end
-- return ServerManager:new()