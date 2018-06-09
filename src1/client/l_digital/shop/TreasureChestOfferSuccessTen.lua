-- ----------------------------------------------------------------------------------------------------
-- 说明：商店宝箱招募十次成功界面
-- 创建时间
-- 作者：
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------

TreasureChestOfferSuccessTen = class("TreasureChestOfferSuccessTenClass", Window)
    
function TreasureChestOfferSuccessTen:ctor()
    self.super:ctor()
	app.load("client.cells.ship_picture_ten_cell")
	app.load("client.cells.prop.sm_packs_cell")
	app.load("client.cells.ship.ship_head_new_cell")
	app.load("client.shop.recruit.SmGeneralsCard")
	app.load("client.cells.utils.resources_icon_cell")
	self.roots = {}
	self.ship = {}
	self.ranking = 0
	self.mIndex = 0
	self.zhanjiangling = 0
	self.HeronumberGod = 0
	self.ShipIndex = 0
	self.heroIndex = 1
	self.number = 0 
	self.hero_animations = {}
	self.recruitment_data = {}

	-- 如果加速的话直接跳过动画
	self.bSpeedUp = false

    -- Initialize TreasureChestOfferSuccessTen page state machine.
    local function init_TreasureChestOfferSuccessTen_terminal()
		--返回招募预览界面
		local treasure_chest_offer_success_ten_renturn_shop_page_terminal = {
            _name = "treasure_chest_offer_success_ten_renturn_shop_page",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	state_machine.unlock("sm_shop_chest_store_view_ten_recruiting")
            	state_machine.excute("sm_shop_chest_store_view_update_consume", 0, nil)
				fwin:close(instance)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		--招募十次
		local shop_hero_page_chick_recruit_ten_terminal = {
            _name = "shop_hero_page_chick_recruit_ten",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	_ED.new_prop_object = {}
            	_ED.new_reward_object = {}
				local function tenrecruitCallBack(response)
					if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						if __lua_project_id == __lua_project_l_digital 
                            or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                            then
                            getSceneReward(64)
                            _ED.show_reward_list_group_ex = {}
                        end
						local obj = TreasureChestOfferSuccessTen:new()
						obj:setRanking(self.ranking,self.mIndex)
						fwin:close(instance)
						fwin:open(obj,fwin._ui)
						state_machine.excute("sm_shop_chest_store_update_debris_count", 0, "")
					end
					_ED.prop_chest_store_recruiting = false
				end
				_ED.prop_chest_store_recruiting = true
				protocol_command.ship_batch_bounty.param_list =""..self.mIndex
				NetworkManager:register(protocol_command.ship_batch_bounty.code, nil, nil, nil, instance, tenrecruitCallBack, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local treasure_chest_offer_success_ten_open_new_show_action_special_terminal = {
            _name = "treasure_chest_offer_success_ten_open_new_show_action_special",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if instance == nil then
            		return
            	end
				local mPanel_32 = params._datas._Panel_32
				mPanel_32:setTouchEnabled(false)
				mPanel_32:setVisible(false)
				ccui.Helper:seekWidgetByName(instance.roots[1],"Panel_yc"):setVisible(true)
				return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        
        local treasure_chest_offer_success_ten_speedup_terminal = {
            _name = "treasure_chest_offer_success_ten_speedup",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if instance == nil then
            		return
            	end
				instance.bSpeedUp = true
				return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		state_machine.add(treasure_chest_offer_success_ten_renturn_shop_page_terminal)
		state_machine.add(shop_hero_page_chick_recruit_ten_terminal)
		state_machine.add(treasure_chest_offer_success_ten_open_new_show_action_special_terminal)
		state_machine.add(treasure_chest_offer_success_ten_speedup_terminal)
        state_machine.init()
    end
    
    -- call func init hom state machine.
    init_TreasureChestOfferSuccessTen_terminal()
end

function TreasureChestOfferSuccessTen:setRanking(ranking,mIndex,isplay)
	self.ranking = ranking
	
	self.mIndex = mIndex

	self.isplay = isplay or nil

	self.hero_animations = {}
	self.recruitment_data = {}
	
	self.number = 10
end

function TreasureChestOfferSuccessTen:openNewShowAction()
	local root = self.roots[1]
	local heroImage = ccui.Helper:seekWidgetByName(root,"Panel_head_icon_"..self.heroIndex)
	heroImage:removeAllChildren(true)
	if tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 6 then
		-- -- --道具
		local prop = _ED.user_prop[""..self.recruitment_data[tonumber(self.heroIndex)].random]

		local cell = ResourcesIconCell:createCell()
        cell:init(self.recruitment_data[tonumber(self.heroIndex)].m_type, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), prop.user_prop_template, nil, nil, false, true, 1)
        heroImage:addChild(cell)

	elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 7 then
		--装备
		local equip = _ED.user_equiment[""..self.recruitment_data[tonumber(self.heroIndex)].random]

		local cell = ResourcesIconCell:createCell()
        cell:init(self.recruitment_data[tonumber(self.heroIndex)].m_type, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), equip.user_equiment_template, nil, nil, false, true, 1)
        heroImage:addChild(cell)

	elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 1 then
		--钱
		local cell = ResourcesIconCell:createCell()
        cell:init(self.recruitment_data[tonumber(self.heroIndex)].m_type, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), -1, nil, nil, false, true, 1)
        -- cell:setPosition(cc.p(cell:getPositionX(),cell:getPositionY()))
        heroImage:addChild(cell)
	end

	local action = csb.createTimeline("shop/recruit_settlement_animation.csb")
	action:play("window_open_hero_"..self.heroIndex, false)

	if self.bSpeedUp == true then
		action:setTimeSpeed(action:getTimeSpeed() * 100)
	end
	
	root:runAction(action)
	action:setFrameEventCallFunc(function (frame)
	-- playEffect(formatMusicFile("effect", 9988))
	if nil == frame then
		return
	end

	local str = frame:getEvent()
	if str == "hero_open_over" then
		playEffect(formatMusicFile("effect", 9988))
		if self.heroIndex < self.number then
			local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
			if tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 6 then
				local prop_mould_id = _ED.user_prop[""..self.recruitment_data[tonumber(self.heroIndex)].random].user_prop_template
				local prop_name = setThePropsIcon(prop_mould_id)[2]
				name:setString(prop_name)
				local quality = dms.int(dms["prop_mould"], prop_mould_id, prop_mould.prop_quality)+1
				name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))     
			elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 7 then
				--获取装备名称索引
				local nameindex = dms.int(dms["equipment_mould"], _ED.user_equiment[""..self.recruitment_data[tonumber(self.heroIndex)].random].user_equiment_template, equipment_mould.equipment_name)
				--通过索引找到word_mould
				local word_info = dms.element(dms["word_mould"], nameindex)
				local names = word_info[3]
				--绘制
				name:setString(names)
				local qua = shipOrEquipSetColour(0)
				local trace_npc_index = dms.int(dms["equipment_mould"], _ED.user_equiment[""..self.recruitment_data[tonumber(self.heroIndex)].random].user_equiment_template, equipment_mould.trace_npc_index)
				if trace_npc_index > 0 then
					qua = trace_npc_index + 1
				end
				name:setColor(cc.c3b(tipStringInfo_quality_color_Type[qua][1],tipStringInfo_quality_color_Type[qua][2],tipStringInfo_quality_color_Type[qua][3]))
			elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 1 then
				local quality = 3
				name:setString(_All_tip_string_info._fundName)
				name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))     
			end
			self.heroIndex = self.heroIndex + 1
			self:openNewShowAction()
		else
			local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
			if tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 6 then
				local prop_mould_id = _ED.user_prop[""..self.recruitment_data[tonumber(self.heroIndex)].random].user_prop_template
				local prop_name = setThePropsIcon(prop_mould_id)[2]
				name:setString(prop_name)
				local quality = dms.int(dms["prop_mould"], prop_mould_id, prop_mould.prop_quality)+1
				name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))     
			elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 7 then
				--获取装备名称索引
				local nameindex = dms.int(dms["equipment_mould"], _ED.user_equiment[""..self.recruitment_data[tonumber(self.heroIndex)].random].user_equiment_template, equipment_mould.equipment_name)
				--通过索引找到word_mould
				local word_info = dms.element(dms["word_mould"], nameindex)
				local names = word_info[3]
				--绘制
				name:setString(names)
				local qua = shipOrEquipSetColour(0)
				local trace_npc_index = dms.int(dms["equipment_mould"], _ED.user_equiment[""..self.recruitment_data[tonumber(self.heroIndex)].random].user_equiment_template, equipment_mould.trace_npc_index)
				if trace_npc_index > 0 then
					qua = trace_npc_index + 1
				end
				name:setColor(cc.c3b(tipStringInfo_quality_color_Type[qua][1],tipStringInfo_quality_color_Type[qua][2],tipStringInfo_quality_color_Type[qua][3]))
			elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 1 then
				local quality = 3
				name:setString(_All_tip_string_info._fundName)
				name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))     
			end
			ccui.Helper:seekWidgetByName(root,"Panel_15"):setVisible(true)
			-- fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Panel_15"), nil, {terminal_name = "treasure_chest_offer_success_ten_renturn_shop_page", terminal_state = 0}, nil, 0)
		end
	elseif str == "close" then
	end
	end)
end

function RandFetch(list,num,poolSize,pool) -- list 存放筛选结果，num 筛取个数，poolSize 筛取源大小，pool 筛取源
    pool = pool or {}
    math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)))
    for i=1,num do
        local rand = math.random(i,poolSize)
        local tmp = pool[rand] or rand -- 对于第二个池子，序号跟id号是一致的
        pool[rand] = pool[i] or i
        pool[i] = tmp

        table.insert(list, tmp)
    end
end

function TreasureChestOfferSuccessTen:ShowUI()
	local csbTreasureChestOfferSuccessTen = csb.createNode("shop/recruit_settlement_animation.csb")
	local csbTreasureChestOfferSuccessTen_root = csbTreasureChestOfferSuccessTen:getChildByName("root")
	table.insert(self.roots, csbTreasureChestOfferSuccessTen_root)
	self:addChild(csbTreasureChestOfferSuccessTen)
	--把道具数据和武将数据合在一个数组里

	for i=1,#_ED.new_reward_object do
		local m_datas = {}
		m_datas.m_type = tonumber(_ED.new_reward_object[i].m_type) 
		m_datas.random = tonumber(_ED.new_reward_object[i].mould_id) 
		m_datas.number = tonumber(_ED.new_reward_object[i].number) 
		table.insert(self.recruitment_data, m_datas)
	end
	--随机打乱数组
	local lists = self.recruitment_data
	local lists_two = {}
	RandFetch(lists_two,#lists,#lists,lists)
	self.recruitment_data = lists_two

	if self.isplay ~= nil and self.isplay == true then
		playEffect(formatMusicFile("effect", 9983))
		local function changeActionCallback( armatureBack ) 
			ccui.Helper:seekWidgetByName(csbTreasureChestOfferSuccessTen_root,"Panel_yc"):setVisible(true)
			self:openNewShowAction()
			armatureBack:removeFromParent(true)
		end
		ccui.Helper:seekWidgetByName(csbTreasureChestOfferSuccessTen_root,"Panel_yc"):setVisible(false)
		local Panel_zhaomu_open = ccui.Helper:seekWidgetByName(csbTreasureChestOfferSuccessTen_root,"Panel_zhaomu_open")
		Panel_zhaomu_open:removeAllChildren(true)
		local jsonFile = "sprite/sprite_baoxiang_2.json"
		local atlasFile = "sprite/sprite_baoxiang_2.atlas"
		local animation = sp.spine(jsonFile, atlasFile, 1, 0, "box_open", true, nil)
		animation.animationNameList = {"box_open"}
		sp.initArmature(animation, false)
		animation._invoke = changeActionCallback
		Panel_zhaomu_open:addChild(animation)
		animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(animation, 0, 0, false)
	else
		self:openNewShowAction()
	end
	local Panel_consume_icon = ccui.Helper:seekWidgetByName(csbTreasureChestOfferSuccessTen_root,"Panel_consume_icon")
	Panel_consume_icon:removeBackGroundImage()
	local Label_36610 = ccui.Helper:seekWidgetByName(csbTreasureChestOfferSuccessTen_root,"Label_36610")
	
	local key_mouldId = dms.int(dms["shop_config"] , 8 , shop_config.param)
    local key_number = tonumber(getPropAllCountByMouldId(key_mouldId))
    if key_number >= 10 then
        Panel_consume_icon:setBackGroundImage("images/ui/text/shop/zbbxys.png")
        Label_36610:setString(key_number.."/10")
    else
        Panel_consume_icon:setBackGroundImage("images/ui/icon/zuanshi.png")
        Label_36610:setString(dms.int(dms["partner_bounty_param"],11,partner_bounty_param.spend_gold))
    end  	
	
	local RecruitStr =dms.string(dms["pirates_config"], 273, pirates_config.param)
	local pMouID = zstring.split(RecruitStr,",")	
	local propRecruitCount = getPropAllCountByMouldId(pMouID[13])--战将招募令数量
	local propGodRecruitCount = getPropAllCountByMouldId(pMouID[14])--神将招募令数量
	self.zhanjiangling = tonumber(propRecruitCount) or 0			--用户拥有战将领
	self.HeronumberGod = tonumber(propGodRecruitCount) or 0
	
	-- [[
	self.ShipIndex = 0
end

function TreasureChestOfferSuccessTen:onEnterTransitionFinish()
	self:ShowUI()
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_36550"), nil, {terminal_name = "shop_hero_page_chick_recruit_ten", terminal_state = self.ranking, touch_scale = true}, nil, 0)
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_36551"), nil, {terminal_name = "treasure_chest_offer_success_ten_renturn_shop_page", terminal_state = 0, touch_scale = true}, nil, 0)
	-- local Close = fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Panel_15"), nil, {terminal_name = "treasure_chest_offer_success_ten_renturn_shop_page", terminal_state = 0, touch_scale = true}, nil, 0)
	
	local Panel_15 = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_15")
	Panel_15:setTouchEnabled(false)

	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Panel_come_on_the_stage"), nil, {terminal_name = "treasure_chest_offer_success_ten_speedup", terminal_state = 0, touch_scale = false}, nil, 0)
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Image_shop_bg"), nil, {terminal_name = "treasure_chest_offer_success_ten_speedup", terminal_state = 0, touch_scale = false}, nil, 0)

	for i=1,10 do
		local infoPanel = ccui.Helper:seekWidgetByName(self.roots[1],"Panel_show_hero_"..i)
		local infoRoot = infoPanel:getChildByName("ProjectNode_2"):getChildByName("root")
		local Panel_32=  ccui.Helper:seekWidgetByName(infoRoot, "Panel_lwj_2")
		Panel_32:setVisible(false)
		local Button_ok = ccui.Helper:seekWidgetByName(infoRoot, "Button_ok")
		fwin:addTouchEventListener(Button_ok, nil, {terminal_name = "treasure_chest_offer_success_ten_open_new_show_action_special", terminal_state = 0, touch_scale = true ,_Panel_32 = Button_ok}, nil, 0)
	end

	if ccui.Helper:seekWidgetByName(self.roots[1], "Button_show") ~= nil then
        if zstring.tonumber(_ED.server_review) ~= 1 then  -- 1评审, 其他非
            ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(true)
        else
            ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
        end
    end

end
