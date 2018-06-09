-- ----------------------------------------------------------------------------------------------------
-- 说明：商店英雄招募十次成功界面
-- 创建时间
-- 作者：
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------

HeroRecruitSuccessTen = class("HeroRecruitSuccessTenClass", Window)
    
function HeroRecruitSuccessTen:ctor()
    self.super:ctor()
	app.load("client.cells.ship_picture_ten_cell")
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		app.load("client.cells.prop.sm_packs_cell")
		app.load("client.cells.ship.ship_head_new_cell")
		app.load("client.shop.recruit.SmGeneralsCard")
		app.load("client.cells.utils.resources_icon_cell")
	end
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
	
    -- Initialize HeroRecruitSuccessTen page state machine.
    local function init_HeroRecruitSuccessTen_terminal()
		--返回招募预览界面
		local hero_recruit_success_ten_renturn_shop_page_terminal = {
            _name = "hero_recruit_success_ten_renturn_shop_page",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	state_machine.unlock("hero_recruit_list_view_ten_recruiting")
				fwin:close(instance)
				if __lua_project_id == __lua_project_gragon_tiger_gate
					or __lua_project_id == __lua_project_l_digital
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					or __lua_project_id == __lua_project_red_alert 
					or __lua_project_id == __lua_project_legendary_game 
					then			--龙虎门项目控制
					if __lua_project_id == __lua_project_l_digital 
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						then
						-- state_machine.excute("menu_back_home_page", 0, "")
					 --    state_machine.excute("menu_clean_page_state", 0, "") 
					    state_machine.excute("home_hero_refresh_draw", 0, 0)
					else
						state_machine.excute("hero_recruit_shop_twopage_open",0,"")
						state_machine.excute("hero_recruit_shop_twopage_show",0,"")
					end
				else
					state_machine.excute("menu_show_event", 0, "menu_show_event.")
				end
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
            	if __lua_project_id == __lua_project_l_digital 
            		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
            		then
                    _ED.new_prop_object = {}
            		_ED.new_reward_object = {}
                end
                local mIndex = instance.mIndex
				local function tenrecruitCallBack(response)
					if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						if __lua_project_id == __lua_project_l_digital 
	            		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
	            		then
							getSceneReward(64)
							_ED.show_reward_list_group_ex = {}
							if app.configJson.OperatorName == "cayenne" then
                                jttd.facebookAPPeventSlogger("9|".._ED.all_servers[_ED.selected_server].server_number.."_".._ED.user_info.user_id.."|"..self.mIndex)
                            end
						end
						-- smFightingChange()
						local obj = HeroRecruitSuccessTen:new()
						obj:setRanking(self.ranking,self.mIndex)
						fwin:close(instance)
						fwin:open(obj,fwin._ui)
					end
					if __lua_project_id == __lua_project_l_digital 
            			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
            			then
						_ED.prop_chest_store_recruiting = false
            			if mIndex == 3 then
							state_machine.excute("sm_limited_time_equip_box_update_draw", 0, "")
						end
					end
				end
				if self.mIndex == 1 then	--战将再十次招募
					if __lua_project_id == __lua_project_l_digital 
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						then
						_ED.prop_chest_store_recruiting = true
						protocol_command.ship_batch_bounty.param_list =""..self.mIndex
						NetworkManager:register(protocol_command.ship_batch_bounty.code, nil, nil, nil, instance, tenrecruitCallBack, false, nil)
					else
						if self.zhanjiangling > 9 then
							protocol_command.ship_batch_bounty.param_list =""..self.mIndex
							NetworkManager:register(protocol_command.ship_batch_bounty.code, nil, nil, nil, instance, tenrecruitCallBack, false, nil)
						else 
							TipDlg.drawTextDailog(_string_piece_info[72])
						end
					end
				elseif self.mIndex == 2 then -- 神将再十次招募
					local _goldNumber = countActivityHeroDiscount().ten
					if __lua_project_id == __lua_project_l_digital 
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						then
						local prop_id = dms.string(dms["shop_config"], 4, shop_config.param)
						local propData = fundPropWidthId(prop_id)
						if propData ~= nil then
							_ED.prop_chest_store_recruiting = true
							protocol_command.ship_bounty.param_list = ""..self.mIndex
							NetworkManager:register(protocol_command.ship_batch_bounty.code, nil, nil, nil, instance, tenrecruitCallBack, false, nil)
						else
							if self.HeronumberGod >= 9 or tonumber(_ED.user_info.user_gold) >= _goldNumber then
								_ED.prop_chest_store_recruiting = true
								protocol_command.ship_batch_bounty.param_list =""..self.mIndex
								NetworkManager:register(protocol_command.ship_batch_bounty.code, nil, nil, nil, instance, tenrecruitCallBack, false, nil)
							else
								TipDlg.drawTextDailog(_string_piece_info[74])
							end
						end
					else
						if self.HeronumberGod >= 9 or tonumber(_ED.user_info.user_gold) >= _goldNumber then
							protocol_command.ship_batch_bounty.param_list =""..self.mIndex
							NetworkManager:register(protocol_command.ship_batch_bounty.code, nil, nil, nil, instance, tenrecruitCallBack, false, nil)
						else
							TipDlg.drawTextDailog(_string_piece_info[74])
						end
					end
				elseif self.mIndex == 3 then
					if __lua_project_id == __lua_project_l_digital 
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						then
						local activity_type = 89
						local activity = _ED.active_activity[activity_type]
						_ED.prop_chest_store_recruiting = true
						protocol_command.get_activity_reward.param_list = ""..activity.activity_id.."\r\n".."0".."\r\n".."0".."\r\n"..activity_type.."\r\n".."0".."\r\n".."1"
            			NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, instance, tenrecruitCallBack, false, nil)
					end
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local hero_recruit_success_ten_add_cell_terminal = {
            _name = "hero_recruit_success_ten_add_cell",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				instance:addCell()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local hero_recruit_success_ten_play_high_quality_action_terminal = {
            _name = "hero_recruit_success_ten_play_high_quality_action",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				instance:playShipAction()
				return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local hero_recruit_success_ten_open_new_show_action_special_terminal = {
            _name = "hero_recruit_success_ten_open_new_show_action_special",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if instance == nil or instance.openNewShowActionSpecialOver == nil then
            		return
            	end
            	if __lua_project_id == __lua_project_l_digital 
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					then
	            	if instance.animation ~= nil then
	            		instance.animation:removeFromParent(true)
	            		if instance.animation2 ~= nil then
	            			instance.animation2:removeFromParent(true)
	            		end
	            	end
					instance:openNewShowActionSpecialOver()
					local mPanel_32 = params._datas._Panel_32
					mPanel_32:setTouchEnabled(false)
					mPanel_32:setVisible(false)
					ccui.Helper:seekWidgetByName(instance.roots[1],"Panel_yc"):setVisible(true)
					ccui.Helper:seekWidgetByName(instance.roots[1],"Panel_head_icon_"..instance.heroIndex):setVisible(true)
				else
					instance:openNewShowActionSpecialOver()
					local mPanel_32 = params._datas._Panel_32
					mPanel_32:setTouchEnabled(false)
					mPanel_32:setVisible(false)
				end
				return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local hero_recruit_success_ten_play_hero_animation_terminal = {
            _name = "hero_recruit_success_ten_play_hero_animation",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if instance ~= nil and nil ~= instance.changeHeroAnimation then
            		instance:changeHeroAnimation(params[1],params[2])
            	end
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

         --facebook分享
        local share_click_on_terminal = {
            _name = "share_click_on",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
	            if __lua_project_id == __lua_project_l_naruto and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_ANDROID then
	            	handlePlatformRequest(0, CC_SHARE_REQUEST, _web_page_share[1])
	            end
            end,
            _terminal = nil,
            _terminals = nil
        }

		state_machine.add(hero_recruit_success_ten_renturn_shop_page_terminal)
		state_machine.add(shop_hero_page_chick_recruit_ten_terminal)
		state_machine.add(hero_recruit_success_ten_add_cell_terminal)
		state_machine.add(hero_recruit_success_ten_play_high_quality_action_terminal)
		state_machine.add(hero_recruit_success_ten_open_new_show_action_special_terminal)
		state_machine.add(hero_recruit_success_ten_play_hero_animation_terminal)
		state_machine.add(treasure_chest_offer_success_ten_speedup_terminal)
		state_machine.add(share_click_on_terminal)
        state_machine.init()
    end
    
    -- call func init hom state machine.
    init_HeroRecruitSuccessTen_terminal()
end

function HeroRecruitSuccessTen:loadEffectFile(fileIndex)
    local fileName = string.format("effect/effice_%d.ExportJson", fileIndex)
    -- ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo(fileName)
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(fileName)
    local armatureName = string.format("effice_%d", fileIndex)
    return armatureName, fileName
end

function HeroRecruitSuccessTen:createEffect(fileIndex, fileNameFormat)
    -- 创建光效
    local armature = nil
    if animationMode == 1 then
        -- armature = sp.spine_sprite(self, self._brole._head, spineAnimations[_enum_animation_l_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
        -- armature.animationNameList = spineAnimations
        -- sp.initArmature(armature, true)
        armature = sp.spine_effect(fileIndex, effectAnimations[1], false, nil, nil, nil, nil, nil, nil, fileNameFormat)
        armature.animationNameList = effectAnimations
        sp.initArmature(armature, true)
    else
        local armatureName, fileName = self:loadEffectFile(fileIndex)
        armature = ccs.Armature:create(armatureName)
        armature._fileName = fileName
    end
    -- table.insert(self.animationList, {fileName = fileName, armature = armature})
    local frameListCount = math.floor(armature:getAnimation():getAnimationData():getMovementCount() / 2)
    -- local _tcamp = zstring.tonumber(""..self.roleCamp)
    local _armatureIndex = 0 -- frameListCount * _tcamp
    armature:getAnimation():playWithIndex(_armatureIndex)
    armature:getAnimation():setMovementEventCallFunc(changeAction_animationEventCallFunc)
    -- armature:getAnimation():setSpeedScale(1.0 / __fight_recorder_action_time_speed)
    
    local duration = zstring.tonumber(dms.int(dms["duration"], fileIndex, 1))
    armature._duration = duration / 60.0
    return armature
end

local function checkFrameEvent(events, mode)
    if events ~= n and #events > 0 then
        for i, v in pairs(events) do
            if v == mode then
                return true
            end
        end
    end
    return false
end

local function onFrameEventRole(bone,evt,originFrameIndex,currentFrameIndex)
    local armature = bone:getArmature()
    local _self = armature._self
    local frameEvents = zstring.split(evt, "_")
    if checkFrameEvent(frameEvents, "union") == true then -- 启动角色镜头聚焦
		-- print("start union effect!")
        local effectIds = zstring.split(frameEvents[2], ",")
        for i, v in pairs(effectIds) do
        	local function deleteEffectFile(armatureBack)
			    if armatureBack == nil then
			        return
			    end
			    -- 删除光效
			    armatureBack._LastsCountTurns = armatureBack._LastsCountTurns == nil and 0 or armatureBack._LastsCountTurns
			    if armatureBack._LastsCountTurns <= 0 then
			        local fileName = armatureBack._fileName
			        if m_tOperateSystem == 5 then
			            if fileName ~= nil then
			                CCArmatureDataManager:sharedArmatureDataManager():removeArmatureFileInfo(fileName)
			            end
			        end
			            if armatureBack.getParent ~= nil then
			                if armatureBack:getParent() ~= nil then
			                    if armatureBack.removeFromParent ~= nil then
			                        armatureBack:removeFromParent(true)
			                    end
			                end
			            end
			        if m_tOperateSystem == 5 then
			            CCSpriteFrameCache:purgeSharedSpriteFrameCache()
			            CCTextureCache:sharedTextureCache():removeUnusedTextures()
			        end
			    end
			end
			-- print("create union effect:", v)
            local armatureEffect = _self:createEffect(v, "sprite/effect_")
            armatureEffect._self = _self
            armatureEffect._invoke = deleteEffectFile

            local map = armature -- _self:getParent()
            map:addChild(armatureEffect)
        end
    end
end


function HeroRecruitSuccessTen:setRanking(ranking,mIndex,isplay)
	self.ranking = ranking
	
	self.mIndex = mIndex

	self.isplay = isplay or nil

	self.hero_animations = {}
	self.recruitment_data = {}
	
	if self.mIndex == 2 then
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			self.number = 10
		else
			self.number = 12
		end
	else
		self.number = 10
	end
end

-- function HeroRecruitSuccessTen:playShipAction()
	-- self.action:setFrameEventCallFunc(function (frame)
        -- if nil == frame then
            -- return
        -- end

        -- local str = frame:getEvent()
		-- local _exit = string.format("exit%d", self.ShipIndex)
		-- if str == _exit then
			-- state_machine.excute("hero_recruit_success_ten_add_cell", 0, nil)
		-- end
    -- end)
	-- self.action:play(string.format("hero_show_%d", self.ShipIndex), false)
-- end

function HeroRecruitSuccessTen:addCell()
	self.action:play("windowopen", false)
	local cardPanel = {
		"Panel_1",
		"Panel_2",
		"Panel_3",
		"Panel_4",
		"Panel_5",
		"Panel_6",
		"Panel_7",
		"Panel_8",
		"Panel_9",
		"Panel_10",
		"Panel_11",
		"Panel_12"
		}
	self.ShipIndex = self.ShipIndex + 1
	local ship = _ED.random_Patch[self.ShipIndex]
	if ship ~= nil then
		local root = self.roots[1]
		local cell = ShipPictureTenCell:createCell()
		cell:init(ship, self.ShipIndex)
		local Panel_36549_1 = ccui.Helper:seekWidgetByName(root,cardPanel[self.ShipIndex])
		Panel_36549_1:addChild(cell)
	end
	local Panel_37 = ccui.Helper:seekWidgetByName(self.roots[1],"Panel_37")
	local Panel_15 = ccui.Helper:seekWidgetByName(self.roots[1],"Panel_15")
	if self.ShipIndex >= 11 then
		Panel_37:setTouchEnabled(true)
		-- Panel_15:setVisible(true)
	else
		Panel_37:setTouchEnabled(false)
		-- Panel_15:setVisible(false)
	end
end

function HeroRecruitSuccessTen:openNewShowActionSpecialOver()
	local root = self.roots[1]
	ccui.Helper:seekWidgetByName(root,"Panel_show_hero_"..self.heroIndex):getChildByName("ProjectNode_2"):setVisible(false)
	local action = csb.createTimeline("shop/recruit_settlement_animation.csb")
	action:play("cloes_hero_"..self.heroIndex, false)
	root:runAction(action)
	action:setFrameEventCallFunc(function (frame)
	if nil == frame then
		return
	end
	local str = frame:getEvent()
	if str == "hero_open_show_over" then
		if self.heroIndex < self.number then
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--这里换成道具碎片
				if tonumber(self.recruitment_data[tonumber(self.heroIndex)].isSame) == 1 then
					local heroImage = ccui.Helper:seekWidgetByName(root,"Panel_head_icon_"..self.heroIndex)
					heroImage:removeAllChildren(true)
					local prop = _ED.user_prop[""..self.recruitment_data[tonumber(self.heroIndex)].prop_random]
					-- local cell = state_machine.excute("sm_packs_cell",0,{prop,0,self.recruitment_data[tonumber(self.heroIndex)].number})
					-- cell:setPosition(cc.p(cell:getPositionX()+7,cell:getPositionY()+7))
					local cell = ResourcesIconCell:createCell()
		    		cell:init(6, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), prop.user_prop_template,nil,nil,true,true,0)

					heroImage:addChild(cell)
					local prop_name = dms.string(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_name)
					if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			            prop_name = setThePropsIcon(prop.user_prop_template)[2]
			        end
					local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
				    name:setString(prop_name)
				    local quality = dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_quality)+1
				    name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))  
				else
					local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
					name:setColor(cc.c3b(color_Type[1][1],color_Type[1][2],color_Type[1][3]))
					local ship_mould_id = self.recruitment_data[tonumber(self.heroIndex)].random
					--进化形象
					local evo_image = dms.string(dms["ship_mould"], ship_mould_id, ship_mould.fitSkillTwo)
					local evo_info = zstring.split(evo_image, ",")
					--进化模板id
					-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
					local evo_mould_id = evo_info[dms.int(dms["ship_mould"], ship_mould_id, ship_mould.captain_name)]
					local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
					local word_info = dms.element(dms["word_mould"], name_mould_id)
	        		local picIndex_name = word_info[3]
					name:setString(picIndex_name)
				end
				self.hero_animations[self.heroIndex].hero:removeFromParent(true)
				self:showClosePanelUI(self.heroIndex)
			else
				local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
				local colortype = tonumber(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id),ship_mould.ship_type))
				name:setColor(cc.c3b(color_Type[colortype+1][1],color_Type[colortype+1][2],color_Type[colortype+1][3]))
				name:setString(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name))
			end
			self.heroIndex = self.heroIndex + 1

			self:openNewShowAction()
		else
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				--这里换成道具碎片
				if tonumber(self.recruitment_data[tonumber(self.heroIndex)].isSame) == 1 then
					local heroImage = ccui.Helper:seekWidgetByName(root,"Panel_head_icon_"..self.heroIndex)
					heroImage:removeAllChildren(true)
					local prop = _ED.user_prop[""..self.recruitment_data[tonumber(self.heroIndex)].prop_random]
					-- local cell = state_machine.excute("sm_packs_cell",0,{prop,0,self.recruitment_data[tonumber(self.heroIndex)].number})
					-- cell:setPosition(cc.p(cell:getPositionX()+7,cell:getPositionY()+7))
					local cell = ResourcesIconCell:createCell()
		    		cell:init(6, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), prop.user_prop_template,nil,nil,true,true,0)

					heroImage:addChild(cell)
					local prop_name = dms.string(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_name)
					if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			            prop_name = setThePropsIcon(prop.user_prop_template)[2]
			        end
					local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
				    name:setString(prop_name)
				    local quality = dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_quality)+1
				    name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))  
				else
					local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
					name:setColor(cc.c3b(color_Type[1][1],color_Type[1][2],color_Type[1][3]))
					local ship_mould_id = self.recruitment_data[tonumber(self.heroIndex)].random
					--进化形象
					local evo_image = dms.string(dms["ship_mould"], self.recruitment_data[tonumber(self.heroIndex)].random, ship_mould.fitSkillTwo)
					local evo_info = zstring.split(evo_image, ",")
					--进化模板id
					-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
					local evo_mould_id = evo_info[dms.int(dms["ship_mould"], self.recruitment_data[tonumber(self.heroIndex)].random, ship_mould.captain_name)]
					local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
					local word_info = dms.element(dms["word_mould"], name_mould_id)
	        		local picIndex_name = word_info[3]
					name:setString(picIndex_name)
				end
				self:showClosePanelUI(self.heroIndex)
			else
				local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					name:setColor(cc.c3b(color_Type[1][1],color_Type[1][2],color_Type[1][3]))
				else
					local colortype = tonumber(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id),ship_mould.ship_type))
					name:setColor(cc.c3b(color_Type[colortype+1][1],color_Type[colortype+1][2],color_Type[colortype+1][3]))
				end
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					local ship_mould_id = self.recruitment_data[tonumber(self.heroIndex)].random
					--进化形象
					local evo_image = dms.string(dms["ship_mould"], self.recruitment_data[tonumber(self.heroIndex)].random, ship_mould.fitSkillTwo)
					local evo_info = zstring.split(evo_image, ",")
					--进化模板id
					-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
					local evo_mould_id = evo_info[dms.int(dms["ship_mould"], self.recruitment_data[tonumber(self.heroIndex)].random, ship_mould.captain_name)]
					local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
					local word_info = dms.element(dms["word_mould"], name_mould_id)
	        		local picIndex_name = word_info[3]
					name:setString(picIndex_name)
				else
					name:setString(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name))
				end
			end
			ccui.Helper:seekWidgetByName(root,"Panel_15"):setVisible(true)
			fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Panel_15"), nil, {terminal_name = "hero_recruit_success_ten_renturn_shop_page", terminal_state = 0, touch_scale = true}, nil, 0)
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				ccui.Helper:seekWidgetByName(root,"Panel_15"):setTouchEnabled(false)
			end
		end
	elseif str == "close" then
	end
	
	end)
end

function HeroRecruitSuccessTen:openNewShowActionSpecial()
	local root = self.roots[1]
	local action = csb.createTimeline("shop/recruit_settlement_animation.csb")
	action:play("open_hero_"..self.heroIndex, false)
	root:runAction(action)
	local infoPanel = ccui.Helper:seekWidgetByName(root,"Panel_show_hero_"..self.heroIndex)
	local infoRoot = infoPanel:getChildByName("ProjectNode_2"):getChildByName("root")
	local cardCamp = ccui.Helper:seekWidgetByName(infoRoot, "Panel_shop_camp")
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		local Panel_come_on_the_stage = ccui.Helper:seekWidgetByName(root,"Panel_come_on_the_stage")
		Panel_come_on_the_stage:setTouchEnabled(false)
		local ship_mould_id = self.recruitment_data[tonumber(self.heroIndex)].random
		local bounty_hero_param_id = self.recruitment_data[tonumber(self.heroIndex)].bounty_hero_param_id
		local Panel_head_card = ccui.Helper:seekWidgetByName(root,"Panel_head_card_"..self.heroIndex)
		Panel_head_card:removeAllChildren(true)
		Panel_head_card:setVisible(true)
		local baseShip = fundShipWidthTemplateId(ship_mould_id)
		if baseShip ~= nil then
			local star = dms.int(dms["ship_mould"], baseShip.ship_template_id, ship_mould.ship_star)
			if bounty_hero_param_id ~= nil then
				local rewards = dms.string(dms["bounty_hero_param"], bounty_hero_param_id, bounty_hero_param.rewards)
				if rewards ~= nil then
					rewards = zstring.split(rewards, ",")
					if zstring.tonumber(rewards[4]) > 0 then
						star = zstring.tonumber(rewards[4])
					end
				end
			end
			state_machine.excute("sm_generals_card_open",0,{Panel_head_card,false,true,baseShip.ship_id,false,nil,baseShip.ship_template_id, star})
		else
			state_machine.excute("sm_generals_card_open",0,{Panel_head_card,false,true,ship_mould_id,true,nil,bounty_hero_param_id})
		end
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
			local animation1 = draw.createEffect("effect_shop_light", "images/ui/effice/effect_shop_light/effect_shop_light.ExportJson", Panel_head_card, -1, nil, nil, cc.p(0.5, 0.5))
	        animation1._invoke = changeActionCallback
	        csb.animationChangeToAction(animation1, 0, 0, false)
		end
		ccui.Helper:seekWidgetByName(root,"Panel_head_icon_"..self.heroIndex):setVisible(false)
		if tonumber(self.recruitment_data[tonumber(self.heroIndex)].isSame) == 1 then
			ccui.Helper:seekWidgetByName(root,"Panel_zh"):setVisible(true)
			local ship_mould_id = self.recruitment_data[tonumber(self.heroIndex)].random
			--进化形象
			local evo_image = dms.string(dms["ship_mould"], ship_mould_id, ship_mould.fitSkillTwo)
			local evo_info = zstring.split(evo_image, ",")
			--进化模板id
			local evo_mould_id = evo_info[dms.int(dms["ship_mould"], ship_mould_id, ship_mould.captain_name)]
			if baseShip ~= nil then
				local ship_evo = zstring.split(baseShip.evolution_status, "|")
				evo_mould_id = evo_info[tonumber(ship_evo[1])]
			end
			local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
			local word_info = dms.element(dms["word_mould"], name_mould_id)
    		local picIndex_name = word_info[3]
			ccui.Helper:seekWidgetByName(root,"Text_sp_number"):setString(string.format(_new_interface_text[17],""..self.recruitment_data[tonumber(self.heroIndex)].number,picIndex_name,number))
		else
			ccui.Helper:seekWidgetByName(root,"Panel_zh"):setVisible(false)
		end

		--武将定位
		local Text_dingwei_m = ccui.Helper:seekWidgetByName(infoRoot, "Text_dingwei_m")
		--进化形象
		local evo_image = dms.string(dms["ship_mould"], ship_mould_id, ship_mould.fitSkillTwo)
		local evo_info = zstring.split(evo_image, ",")
		--进化模板id
		-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
		local evo_mould_id = evo_info[dms.int(dms["ship_mould"], ship_mould_id, ship_mould.captain_name)]
		local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.position_index)
		local word_info = dms.element(dms["word_mould"], name_mould_id)
        local location = word_info[3]
		Text_dingwei_m:setString(location)
		

		--技能
		local Panel_skill_icon = ccui.Helper:seekWidgetByName(infoRoot, "Panel_skill_icon")
		Panel_skill_icon:removeAllChildren(true)
		--进化的天赋技能
	    local talent = dms.string(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.talent_index)
	    local talentData = zstring.split(talent, "|")
	    local skillData = zstring.split(talentData[2], ",")
	    --天赋模板id
        local talentMouldid = skillData[3]
        local pic_index = dms.int(dms["talent_mould"], talentMouldid, talent_mould.new_skill_pic)
        local skill_icon = cc.Sprite:create(string.format("images/ui/skills/skills_%d.png", pic_index))
        --测试临时的图,正式的时候换成上面的代码
        --local skill_icon = cc.Sprite:create(string.format("images/ui/skills/skills_%d.png", 1))
        if skill_icon ~= nil then
            skill_icon:setPosition(cc.p(Panel_skill_icon:getContentSize().width/2,Panel_skill_icon:getContentSize().height/2))
            Panel_skill_icon:addChild(skill_icon)
        end
        local skillNameId = dms.int(dms["talent_mould"], talentMouldid, talent_mould.talent_name)
        local word_info = dms.element(dms["word_mould"], skillNameId)
        local skillName = word_info[3]
        skillName = skillDescriptionReplaceData(talentMouldid,ship_mould_id,1,1,false)
        local Text_skill_name = ccui.Helper:seekWidgetByName(infoRoot, "Text_skill_name")
        Text_skill_name:setString(skillName)

        --描述
	    local Text_skill_infor = ccui.Helper:seekWidgetByName(infoRoot, "Text_skill_infor")
	    local skill_describe_id = dms.string(dms["talent_mould"], talentMouldid, talent_mould.talent_describe)
	    local word_info = dms.element(dms["word_mould"], skill_describe_id)
	    local skill_describe = word_info[3]
	    skill_describe = skillDescriptionReplaceData(talentMouldid,ship_mould_id,1,2,false)
	    Text_skill_infor:setString(skill_describe)

	    --分享按钮显示
	    local FB_share = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.Kill_feature)
	    if ccui.Helper:seekWidgetByName(self.roots[1], "Button_show") ~= nil then
	        if zstring.tonumber(_ED.server_review) ~= 1 then  -- 1评审, 其他非
	        	if FB_share == 1 then
	            	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(true)
	            else
	            	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
	            end
	        else
	            ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
	        end
	    end

	    local ms_ScrollView = ccui.Helper:seekWidgetByName(infoRoot, "ScrollView_1")
	    if ms_ScrollView ~= nil then
		    --计算text的高度
		    local textRenderSize = Text_skill_infor:getAutoRenderSize() -- 未换行前尺寸
    		local VirtualRendererSize = Text_skill_infor:getVirtualRendererSize() -- 控件本身可渲染尺寸
    		local needRowNumber = math.ceil(textRenderSize.width / VirtualRendererSize.width)
    		local currRowNumber = math.floor(VirtualRendererSize.height / textRenderSize.height)
    		local curHeight = 0
			if needRowNumber > currRowNumber then
        		curHeight = (needRowNumber - currRowNumber) * textRenderSize.height + Text_skill_infor:getFontSize()
        	end
		    -- local _,count = string.gsub(skill_describe, "[^\128-\193]", "")  
		    -- local text_height = math.ceil((count*Text_skill_infor:getFontSize())/Text_skill_infor:getContentSize().width)*(Text_skill_infor:getFontSize()+8)
		    local text_height = VirtualRendererSize.height + curHeight
		    Text_skill_infor:setContentSize(cc.size(Text_skill_infor:getContentSize().width , text_height))
		    ms_ScrollView:setInnerContainerSize(cc.size(ms_ScrollView:getContentSize().width, text_height))
		    Text_skill_infor:setPositionY(text_height)
		    local Image_jiantou = ccui.Helper:seekWidgetByName(infoRoot, "Image_jiantou")
		    if Image_jiantou ~= nil then
		    	if ms_ScrollView:getContentSize().height >= text_height then
		    		Image_jiantou:setVisible(false)
		    		Image_jiantou:stopAllActions()
		    	else
		    		Image_jiantou:setVisible(true)
		    		function blinkOutCallback(sender)
				        imageActivty()
				    end
		    		function imageActivty( ... )
		    			Image_jiantou:runAction(cc.Sequence:create(
		                    cc.FadeTo:create(0.3, 255),
		                    cc.FadeTo:create(0.3, 0),
		                    cc.CallFunc:create(blinkOutCallback)
		                    ))
		    		end
		    		imageActivty()
		    	end
		    end
		end

	    ccui.Helper:seekWidgetByName(infoRoot, "Button_ok"):setVisible(true)

		action:setFrameEventCallFunc(function (frame)
		if nil == frame then
			return
		end
		
		local str = frame:getEvent()
		local pos = string.find(str, "hero")
		if pos ~= nil then

			local Panel_32=  ccui.Helper:seekWidgetByName(infoRoot, "Panel_lwj_2")
			Panel_32:setVisible(true)
			ccui.Helper:seekWidgetByName(root, "Panel_15"):setVisible(false)
			local Panel_head_card = ccui.Helper:seekWidgetByName(root,"Panel_head_card_"..self.heroIndex)
			Panel_head_card:removeAllChildren(true)
			Panel_head_card:setVisible(true)
			
			--state_machine.excute("hero_recruit_success_ten_open_new_show_action_special", 0, "hero_recruit_success_ten_open_new_show_action_special.")
			for i=1,self.number do
				if self.heroIndex ~= i then
					ccui.Helper:seekWidgetByName(root,"Panel_show_hero_"..i):setVisible(true)
				end
			end
			local shipid = self.recruitment_data[tonumber(self.heroIndex)].random
			local soundid = dms.string(dms["ship_mould"], shipid, ship_mould.sound_index)
			playEffectExt(formatMusicFile("effect", soundid))
			state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{38,self.heroIndex})
		elseif str == "Panel_card_icon_open" then
			Panel_come_on_the_stage:setTouchEnabled(true)
			local function consumptionOnTouchEvent(sender, evenType)
	            local __spoint = sender:getTouchBeganPosition()
	            local __mpoint = sender:getTouchMovePosition()
	            local __epoint = sender:getTouchEndPosition()

	            if ccui.TouchEventType.began == evenType then
	            	action:play("open_hero_x_"..self.heroIndex, false)
	            	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
	            	Panel_come_on_the_stage:setTouchEnabled(false)
	            elseif ccui.TouchEventType.moved == evenType then
	            elseif ccui.TouchEventType.ended == evenType then
	            end
	        end
			Panel_come_on_the_stage:addTouchEventListener(consumptionOnTouchEvent)
		elseif str == "open_suipian" then
			if tonumber(self.recruitment_data[tonumber(self.heroIndex)].isSame) == 1 then

			end
		elseif str == "close_suipian" then
			ccui.Helper:seekWidgetByName(root,"Panel_zh"):setVisible(false)
		elseif str == "close" then
		end
		
		end)
	else
		local colortype = tonumber(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id),ship_mould.ship_type))
		--武将阵营
		local HreoCamp = nil
		local TypeCamp = tonumber(dms.string(dms["ship_mould"],tonumber(_ED.random_Patch[self.heroIndex].random_patch_id),ship_mould.capacity))
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		else
			cardCamp:setBackGroundImage(string.format("images/ui/quality/pve_leixing_%d.png", TypeCamp))
		end
		
		--武将类型
		local cardType = ccui.Helper:seekWidgetByName(infoRoot, "Panel_shop_form")
		local TypeCurrent = tonumber(dms.string(dms["ship_mould"],tonumber(_ED.random_Patch[self.heroIndex].random_patch_id),ship_mould.camp_preference))
		if TypeCurrent == 0 then
		elseif TypeCurrent == 1 then
			cardType:setBackGroundImage("images/ui/quality/leixing_1.png")
		elseif TypeCurrent == 2 then
			cardType:setBackGroundImage("images/ui/quality/leixing_2.png")
		elseif TypeCurrent == 3 then
			cardType:setBackGroundImage("images/ui/quality/leixing_3.png")
		elseif TypeCurrent == 4 then
			cardType:setBackGroundImage("images/ui/quality/leixing_4.png")
		end
		
		if __lua_project_id == __lua_project_digimon_adventure 
			or __lua_project_id == __lua_project_pokemon 
			then 
			local RolePanels = {
				ccui.Helper:seekWidgetByName(root, "Panel_jh_"..self.heroIndex .."_1"),
				ccui.Helper:seekWidgetByName(root, "Panel_jh_"..self.heroIndex .."_2"),
				ccui.Helper:seekWidgetByName(root, "Panel_jh_"..self.heroIndex .."_3"),
			}
			local ship_basic = dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.base_mould)

			local current_ship = dms.int(dms["ship_mould"], ship_basic, ship_mould.way_of_gain)
			for i=1,3 do
				local rolePanel = RolePanels[i]
				rolePanel:removeBackGroundImage()
				rolePanel:setVisible(true)
				local imgIcon = ccui.Helper:seekWidgetByName(root, "Image_jt_"..self.heroIndex.."_"..i)
				if imgIcon ~= nil then
					imgIcon:setVisible(false)
				end
				local next_ship_id = dms.int(dms["ship_mould"], current_ship, ship_mould.way_of_gain)
				if current_ship ~= -1 and current_ship ~= nil then 
					local AllIcon = dms.int(dms["ship_mould"], current_ship, ship_mould.All_icon)
					rolePanel:setBackGroundImage(string.format("images/face/big_head/big_head_%d.png", AllIcon))
					if imgIcon ~= nil then
						imgIcon:setVisible(true)
					end
				end
				current_ship = next_ship_id
			end
		end
		--武将名称
		local Text_name = ccui.Helper:seekWidgetByName(infoRoot, "Text_neme")
		local picIndex_name = nil
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			--进化形象
			local evo_image = dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.fitSkillTwo)
			local evo_info = zstring.split(evo_image, ",")
			--进化模板id
			-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
			local evo_mould_id = evo_info[dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name)]
			local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
			local word_info = dms.element(dms["word_mould"], name_mould_id)
	        picIndex_name = word_info[3]
		else
			picIndex_name = dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name)
		end
		-- local colortype = dms.string(dms["ship_mould"], tonumber(self.ship.ship_template_id),ship_mould.ship_type)
		Text_name:setColor(cc.c3b(color_Type[colortype+1][1],color_Type[colortype+1][2],color_Type[colortype+1][3]))
		Text_name:setString(picIndex_name)
									
		--获得提示
		if colortype >=3 then
			-- ccui.Helper:seekWidgetByName(infoRoot, "Text_neme_0"):setVisible(true)
			-- ccui.Helper:seekWidgetByName(infoRoot, "Panel_shop_quality"):setVisible(true)
			ccui.Helper:seekWidgetByName(infoRoot, "Panel_shop_quality"):setBackGroundImage(string.format("images/ui/quality/hero_name_quality_%d.png", colortype))
		end
		
		-- local name = ccui.Helper:seekWidgetByName(infoRoot,"Text_neme")
		-- local colortype = tonumber(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id),ship_mould.ship_type))
		-- name:setColor(cc.c3b(color_Type[colortype+1][1],color_Type[colortype+1][2],color_Type[colortype+1][3]))
		-- name:setString(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name))
		action:setFrameEventCallFunc(function (frame)
		if nil == frame then
			return
		end
		
		local str = frame:getEvent()
		local pos = string.find(str, "hero")
		if pos ~= nil then
			local Panel_32=  ccui.Helper:seekWidgetByName(infoRoot, "Panel_lwj_2")
			Panel_32:setVisible(true)
			ccui.Helper:seekWidgetByName(root, "Panel_15"):setVisible(false)
			--state_machine.excute("hero_recruit_success_ten_open_new_show_action_special", 0, "hero_recruit_success_ten_open_new_show_action_special.")
			for i=1,self.number do
				if self.heroIndex ~= i then
					ccui.Helper:seekWidgetByName(root,"Panel_show_hero_"..i):setVisible(true)
				end
			end
			if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				local shipid = tonumber(_ED.random_Patch[self.heroIndex].random_patch_id)
				local soundid = dms.string(dms["ship_mould"], shipid, ship_mould.sound_index)
				playEffectExt(formatMusicFile("effect", soundid))
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,self.heroIndex})
			end
		elseif str == "close" then
		end
		
		end)
	end
end

function HeroRecruitSuccessTen:changeHeroAnimation(play_type,index)
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		local root = self.roots[1]
		if self.hero_animations[index] == nil then
			--武将
			local ship_id = self.recruitment_data[tonumber(index)].random
			--进化形象
			local evo_image = dms.string(dms["ship_mould"], ship_id, ship_mould.fitSkillTwo)
			local evo_info = zstring.split(evo_image, ",")
			--进化模板id
			local evo_mould_id = evo_info[dms.int(dms["ship_mould"], ship_id, ship_mould.captain_name)]
			local ship = fundShipWidthTemplateId(ship_id)
			if ship ~= nil then
				local ship_evo = zstring.split(ship.evolution_status, "|")
				evo_mould_id = evo_info[tonumber(ship_evo[1])]
			end
			--新的形象编号
			local temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)
			local Panel_hero = ccui.Helper:seekWidgetByName(root, "Panel_hero_"..index)
			Panel_hero:removeAllChildren(true)
			draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), Panel_hero, nil, nil, cc.p(0.5, 0))
			app.load("client.battle.fight.FightEnum")
			local hero_animation = sp.spine_sprite(Panel_hero, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
			hero_animation:setScaleX(-1)
			hero_animation.animationNameList = spineAnimations
			sp.initArmature(hero_animation, true)
		    hero_animation._self = self
		    hero_animation._index = self.heroIndex
		    self:setHeroinvoke(hero_animation,self.heroIndex)
		    hero_animation:getAnimation():setFrameEventCallFunc(onFrameEventRole)
		    self.hero_animations[index].play_types = play_type
		end
	    if self.hero_animations[index] ~= nil and self.hero_animations[index].hero ~= nil then
			csb.animationChangeToAction(self.hero_animations[index].hero, play_type, play_type, false)
		end
	else
		self.hero_animations[index].play_types = play_type
		csb.animationChangeToAction(self.hero_animations[index].hero, play_type, play_type, false)
	end
end

function HeroRecruitSuccessTen:showClosePanelUI(index)
	local root = self.roots[1]
	local infoPanel = ccui.Helper:seekWidgetByName(self.roots[1],"Panel_show_hero_"..index)
	local infoRoot = infoPanel:getChildByName("ProjectNode_2"):getChildByName("root")
	local Panel_32=  ccui.Helper:seekWidgetByName(infoRoot, "Panel_lwj_2")
	Panel_32:setTouchEnabled(true)	
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		Panel_32:setTouchEnabled(false)	
	else
		Panel_32:setTouchEnabled(true)	
	end
end
--设置回调
function HeroRecruitSuccessTen:setHeroinvoke(_hero_animation, _heroIndex)
	local hero_animation = _hero_animation
	local index = _heroIndex
	self.hero_animations[index] = { hero = hero_animation, play_types = 0, state = true}

	if _heroIndex == 1 then
	    local function changeActionCallbackOne1( armatureBack )	
	    	local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state == false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end

	    hero_animation._invoke = changeActionCallbackOne1
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 2 then
	    local function changeActionCallbackOne2( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state == false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne2
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 3 then
		local function changeActionCallbackOne3( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne3
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 4 then
		local function changeActionCallbackOne4( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 35 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne4
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 5 then
		local function changeActionCallbackOne5( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne5
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 6 then
		local function changeActionCallbackOne6( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne6
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 7 then
		local function changeActionCallbackOne7( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne7
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 8 then
		local function changeActionCallbackOne8( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne8
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 9 then
		local function changeActionCallbackOne9( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne9
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 10 then
		local function changeActionCallbackOne10( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 38 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{14,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne10
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 11 then
		local function changeActionCallbackOne11( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
	    end
	    hero_animation._invoke = changeActionCallbackOne11
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		csb.animationChangeToAction(hero_animation, 0, 0, false)
	elseif _heroIndex == 12 then
		local function changeActionCallbackOne12( armatureBack )	
			local hero_data = armatureBack._self.hero_animations[armatureBack._index]
			if hero_data.play_types == 14 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{15,armatureBack._index})
			elseif hero_data.play_types == 15 then
				state_machine.excute("hero_recruit_success_ten_play_hero_animation",0,{0,armatureBack._index})
				hero_data.state = false
			elseif hero_data.play_types == 0 and hero_data.state ==false then
				armatureBack._invoke = nil
				armatureBack._self:showClosePanelUI(armatureBack._index)
			end
		end
	    hero_animation._invoke = changeActionCallbackOne12
	    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
	    csb.animationChangeToAction(hero_animation, 0, 0, false)
	end

end
function HeroRecruitSuccessTen:openNewShowAction()
	local root = self.roots[1]
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		local heroImage = ccui.Helper:seekWidgetByName(root,"Panel_head_icon_"..self.heroIndex)
		heroImage:removeAllChildren(true)
		if tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 13 then
			--武将
			local ship_id = self.recruitment_data[tonumber(self.heroIndex)].random
			local bounty_hero_param_id = self.recruitment_data[tonumber(self.heroIndex)].bounty_hero_param_id
			--添加武将头像
			-- local cell = ShipHeadNewCell:createCell()
			-- cell:init(ship_id,cell.enum_type._SHOW_HERO_FROM_WARCRAFT)
			local cell = ResourcesIconCell:createCell()
		    cell:init(self.recruitment_data[tonumber(self.heroIndex)].m_type, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), ship_id,nil,nil,true,true,0)
			cell:updateStarInfo(bounty_hero_param_id)
			heroImage:addChild(cell)
        	local jsonFile = "sprite/sprite_wzkp.json"
	        local atlasFile = "sprite/sprite_wzkp.atlas"
	        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
	        animation:setPosition(cc.p(heroImage:getContentSize().width/2,heroImage:getContentSize().height/2))
	        heroImage:addChild(animation)
		elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 6 then
			--道具
			local prop = _ED.user_prop[""..self.recruitment_data[tonumber(self.heroIndex)].random]
			local cell = ResourcesIconCell:createCell()
		    cell:init(6, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), prop.user_prop_template,nil,nil,true,true,0)
			-- local cell = state_machine.excute("sm_packs_cell",0,{prop,0,self.recruitment_data[tonumber(self.heroIndex)].number})
			-- cell:setPosition(cc.p(cell:getPositionX()+7,cell:getPositionY()+7))
			heroImage:addChild(cell)

			if self.mIndex == 3 then
		    	-- 限时宝箱活动
		    	local prop_ids = zstring.split(dms.string(dms["activity_config"], 14, activity_config.param), ",")
		    	local show_effect = false
		    	for k, v in pairs(prop_ids) do
		    		-- 觉醒合金和万能碎片箱子
		    		if tonumber(v) == tonumber(prop.user_prop_template) then
		    			show_effect = true
		    		end
		    	end
		    	if show_effect == true then
		    		local jsonFile = "sprite/sprite_wzkp.json"
			        local atlasFile = "sprite/sprite_wzkp.atlas"
			        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
			        animation:setPosition(cc.p(heroImage:getContentSize().width/2,heroImage:getContentSize().height/2))
			        heroImage:addChild(animation)
		    	end
		    end
		elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 7 then
			--装备
			local equip = _ED.user_equiment[""..self.recruitment_data[tonumber(self.heroIndex)].random]
			-- local cell = EquipIconCell:createCell()
			-- cell:init(3,equip)
			local cell = ResourcesIconCell:createCell()
		    cell:init(self.recruitment_data[tonumber(self.heroIndex)].m_type, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), equip.user_equiment_template,nil,nil,true,true,0)
			-- cell:setPosition(cc.p(cell:getPositionX(),cell:getPositionY()))
			heroImage:addChild(cell)	

		elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 1 then
			--钱
			local cell = ResourcesIconCell:createCell()
	        cell:init(self.recruitment_data[tonumber(self.heroIndex)].m_type, tonumber(self.recruitment_data[tonumber(self.heroIndex)].number), -1,nil,nil,true,true,0)
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
			if tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 13 then
				playEffect(formatMusicFile("effect", 9982))
				for i=1,self.number do
					if self.heroIndex ~= i then
						ccui.Helper:seekWidgetByName(root,"Panel_show_hero_"..i):setVisible(false)
					end
				end
				if self.heroIndex <= self.number then
					self:openNewShowActionSpecial()
					local Panel_bg = ccui.Helper:seekWidgetByName(root,"Panel_bg_"..self.heroIndex)
			        Panel_bg:removeAllChildren(true)
			        local jsonFile = "sprite/sprite_zhaomubg.json"
			        local atlasFile = "sprite/sprite_zhaomubg.atlas"
			        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
			        Panel_bg:addChild(animation)
			        self.animation = animation

			        -- local infoPanel = ccui.Helper:seekWidgetByName(root,"Panel_show_hero_"..self.heroIndex)
			        -- local infoRoot = infoPanel:getChildByName("ProjectNode_2"):getChildByName("root")
			        -- local Panel_bggx = ccui.Helper:seekWidgetByName(infoRoot,"Panel_bggx")
			        -- if Panel_bggx ~= nil then
				       --  Panel_bggx:removeAllChildren(true)
				        local jsonFile = "sprite/sprite_zhaomubg_2.json"
				        local atlasFile = "sprite/sprite_zhaomubg_2.atlas"
				        local animation2 = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
				        Panel_bg:addChild(animation2)
				        self.animation2 = animation2
				    -- end
				    ccui.Helper:seekWidgetByName(root,"Panel_yc"):setVisible(false)
				end
			else
				playEffect(formatMusicFile("effect", 9988))
				if self.heroIndex < self.number then
					local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
					if tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 6 then
						local prop_mould_id = _ED.user_prop[""..self.recruitment_data[tonumber(self.heroIndex)].random].user_prop_template
						local prop_name = dms.string(dms["prop_mould"], prop_mould_id, prop_mould.prop_name)
						if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
				            prop_name = setThePropsIcon(prop_mould_id)[2]
				        end
					    name:setString(prop_name)
					    local quality = dms.int(dms["prop_mould"], prop_mould_id, prop_mould.prop_quality)+1
					    name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))     
					elseif tonumber(self.recruitment_data[tonumber(self.heroIndex)].m_type) == 7 then
						--获取装备名称索引
						local nameindex = dms.int(dms["equipment_mould"], _ED.user_equiment[""..self.recruitment_data[tonumber(self.heroIndex)].random].user_equiment_template, equipment_mould.equipment_name)
						--通过索引找到word_mould
						local word_info = dms.element(dms["word_mould"], zstring.tonumber(nameindex))
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
						local prop_name = dms.string(dms["prop_mould"], prop_mould_id, prop_mould.prop_name)
						prop_name = setThePropsIcon(prop_mould_id)[2]
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
					fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Panel_15"), nil, {terminal_name = "hero_recruit_success_ten_renturn_shop_page", terminal_state = 0}, nil, 0)
					if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
						ccui.Helper:seekWidgetByName(root,"Panel_15"):setTouchEnabled(false)
					end
				end
			end
			
		elseif str == "close" then
		end
		end)

	else
		local heroImage = ccui.Helper:seekWidgetByName(root,"Panel_hero_"..self.heroIndex)
		if __lua_project_id == __lua_project_gragon_tiger_gate
			or __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			or __lua_project_id == __lua_project_red_alert 
			or __lua_project_id == __lua_project_legendary_game 
			then			--龙虎门项目控制
			local temp_bust_index = 0
			temp_bust_index = dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.bust_index)
			-- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("sprite/spirte_" .. temp_bust_index .. ".ExportJson")
			-- local cell = ccs.Armature:create("spirte_" .. temp_bust_index)
			-- cell:getAnimation():playWithIndex(0)
			-- heroImage:removeAllChildren(true)
			-- heroImage:addChild(cell)
			-- -- cell:setAnchorPoint(cc.p(0.5, 0.5))
			-- -- cell:setPosition(cc.p(heroImage:getContentSize().width/2, heroImage:getContentSize().height/2))
			-- cell:setPosition(cc.p(heroImage:getContentSize().width/2, 0))
			local ship_id = tonumber(_ED.random_Patch[self.heroIndex].random_patch_id)
			local ship = fundShipWidthTemplateId(ship_id)
			if ship ~= nil then
				--进化形象
				local evo_image = dms.string(dms["ship_mould"], ship_id, ship_mould.fitSkillTwo)
				local evo_info = zstring.split(evo_image, ",")
				--进化模板id
				local ship_evo = zstring.split(ship.evolution_status, "|")
				local evo_mould_id = evo_info[tonumber(ship_evo[1])]
				temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)
			end

			heroImage:removeAllChildren(true)
			draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), heroImage, nil, nil, cc.p(0.5, 0))
			if animationMode == 1 then
				app.load("client.battle.fight.FightEnum")
				local hero_animation = sp.spine_sprite(heroImage, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
				if __lua_project_id == __lua_project_l_digital 
					or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
					then
			        hero_animation:setScaleX(-1)
			    end
				hero_animation.animationNameList = spineAnimations
				sp.initArmature(hero_animation, true)
			    hero_animation._self = self
			    hero_animation._index = self.heroIndex
				self:setHeroinvoke(hero_animation,self.heroIndex)
			else
				draw.createEffect("spirte_" .. temp_bust_index, "sprite/spirte_" .. temp_bust_index .. ".ExportJson", heroImage, -1, nil, nil, cc.p(0.5, 0))
			end
		elseif __lua_project_id == __lua_project_yugioh
			or __lua_project_id == __lua_project_pokemon 
			then 
			local spIndex = dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.movement)
			heroImage:removeAllChildren(true)
			heroImage:removeBackGroundImage()
			if spIndex > 0 then
				app.load("client.battle.fight.FightEnum")
				local jsonFile = ""
	            local atlasFile = ""
	            if __lua_project_id == __lua_project_yugioh then
		            atlasFile = string.format("sprite/spirte_battle_card_%s.atlas", spIndex)
					jsonFile = string.format("sprite/spirte_battle_card_%s.json", spIndex)
				else
					atlasFile = string.format("sprite/big_head_%s.atlas", spIndex)
					jsonFile = string.format("sprite/big_head_%s.json", spIndex)
				end
	            local spArmature = sp.spine(jsonFile, atlasFile, 1, 0, 
	        		spineAnimations[_enum_animation_l_frame_index.animation_standby + 1], true, nil)
	            heroImage:addChild(spArmature)
	            spArmature:setPosition(cc.p(heroImage:getContentSize().width/2, 0))
			else
				local picIndex = dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.All_icon)
				heroImage:setBackGroundImage(string.format("images/face/big_head/big_head_%d.png", picIndex))
			end
		else

			local picIndex = dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.All_icon)
			heroImage:setBackGroundImage(string.format("images/face/big_head/big_head_%d.png", picIndex))
		end
		local ArmatureInde = ccui.Helper:seekWidgetByName(root,"Panel_"..self.heroIndex+73)
		local ArmatureNode_1 = ArmatureInde:getChildByName("ArmatureNode_hero_"..self.heroIndex)
		local animation = ArmatureNode_1:getAnimation()
		animation:playWithIndex(0, 0, 0)
		
		local tempMusicIndex = dms.int(dms["ship_mould"], _ED.random_Patch[self.heroIndex].random_patch_id, ship_mould.sound_index)
		if tempMusicIndex > 0 then
			--cc.SimpleAudioEngine:getInstance():stopAllEffects()
			--playEffect(formatMusicFile("effect", tempMusicIndex))
		end
		
		local action = csb.createTimeline("shop/recruit_settlement_animation.csb")
		action:play("window_open_hero_"..self.heroIndex, false)
		root:runAction(action)
		action:setFrameEventCallFunc(function (frame)
		playEffect(formatMusicFile("effect", 9988))
		if nil == frame then
			return
		end
		
		local str = frame:getEvent()
		if str == "hero_open_over" then
			
			if dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.ship_type) >= 3 then
				for i=1,self.number do
					if self.heroIndex ~= i then
						ccui.Helper:seekWidgetByName(root,"Panel_show_hero_"..i):setVisible(false)
					end
				end
				ArmatureInde:setVisible(false)
				if self.heroIndex <= self.number then
					self:openNewShowActionSpecial()
				else
				end
			else
				if self.heroIndex < self.number then
					local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
					local colortype = tonumber(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id),ship_mould.ship_type))
					name:setColor(cc.c3b(color_Type[colortype+1][1],color_Type[colortype+1][2],color_Type[colortype+1][3]))
					if __lua_project_id == __lua_project_l_digital 
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						then
						--进化形象
						local evo_image = dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.fitSkillTwo)
						local evo_info = zstring.split(evo_image, ",")
						--进化模板id
						-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
						local evo_mould_id = evo_info[dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name)]
						local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
						local word_info = dms.element(dms["word_mould"], name_mould_id)
	        			local picIndex_name = word_info[3]
						name:setString(picIndex_name)
					else
						name:setString(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name))
					end
					self.heroIndex = self.heroIndex + 1
					self:openNewShowAction()
				else
					local name = ccui.Helper:seekWidgetByName(root,"Text_hero_name_"..self.heroIndex)
					local colortype = tonumber(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id),ship_mould.ship_type))
					name:setColor(cc.c3b(color_Type[colortype+1][1],color_Type[colortype+1][2],color_Type[colortype+1][3]))
					if __lua_project_id == __lua_project_l_digital 
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						then
						--进化形象
						local evo_image = dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.fitSkillTwo)
						local evo_info = zstring.split(evo_image, ",")
						--进化模板id
						-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
						local evo_mould_id = evo_info[dms.int(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name)]
						local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
						local word_info = dms.element(dms["word_mould"], name_mould_id)
	        			local picIndex_name = word_info[3]
						name:setString(picIndex_name)
					else
						name:setString(dms.string(dms["ship_mould"], tonumber(_ED.random_Patch[self.heroIndex].random_patch_id), ship_mould.captain_name))
					end
					ccui.Helper:seekWidgetByName(root,"Panel_15"):setVisible(true)
					fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root,"Panel_15"), nil, {terminal_name = "hero_recruit_success_ten_renturn_shop_page", terminal_state = 0}, nil, 0)
					if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
						ccui.Helper:seekWidgetByName(root,"Panel_15"):setTouchEnabled(false)
					end
				end
			end
			
		elseif str == "close" then
		end
		
		end)
	end
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

function HeroRecruitSuccessTen:ShowUI()
	local csbHeroRecruitSuccessTen = csb.createNode("shop/recruit_settlement_animation.csb")
	local csbHeroRecruitSuccessTen_root = csbHeroRecruitSuccessTen:getChildByName("root")
	table.insert(self.roots, csbHeroRecruitSuccessTen_root)
	self:addChild(csbHeroRecruitSuccessTen)
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		--把道具数据和武将数据合在一个数组里
		local index = 1
		if self.mIndex == 3 then
			for i = 1, #_ED.new_reward_object do
				local m_datas = {}
				local isSame = false
				if tonumber(_ED.new_reward_object[index].m_type) == 6 then
					local user_prop_template = _ED.user_prop["".._ED.new_reward_object[index].mould_id].user_prop_template
					local prop_ship = dms.int(dms["prop_mould"], user_prop_template, prop_mould.use_of_ship)
					if zstring.tonumber(prop_ship) > 0 then
						local ships = fundShipWidthTemplateId(tonumber(prop_ship))
						if ships ~= nil then
							local m_starRating = dms.int(dms["ship_mould"], tonumber(prop_ship), ship_mould.ship_star)
							local number_info = zstring.split(dms.string(dms["ship_config"], 13, ship_config.param),"!")[tonumber(m_starRating)]
							local ability = dms.int(dms["ship_mould"], tonumber(prop_ship), ship_mould.ability)
		                    local number_data = zstring.split(number_info,"|")[ability-13+1]
		                    local split_or_merge_count = tonumber(zstring.split(number_data,",")[2])
							-- local split_or_merge_count = dms.int(dms["prop_mould"], user_prop_template, prop_mould.split_or_merge_count)
							if split_or_merge_count > 0 and split_or_merge_count <= tonumber(_ED.new_reward_object[index].number) then
								m_datas.m_type = 13
								m_datas.random = prop_ship
								m_datas.number = _ED.new_reward_object[index].number
								m_datas.prop_random = _ED.new_reward_object[index].mould_id
								m_datas.isSame = 1
								isSame = true
							end
						end
					end
					if isSame == false then
						m_datas.m_type = 6
						m_datas.random = _ED.new_reward_object[index].mould_id
						m_datas.number = _ED.new_reward_object[index].number
					end
					table.insert(self.recruitment_data, m_datas)
					index = index + 1
				elseif tonumber(_ED.new_reward_object[index].m_type) == 7 then
					m_datas.m_type = 7
					m_datas.random = _ED.new_reward_object[index].mould_id
					m_datas.number = _ED.new_reward_object[index].number
					table.insert(self.recruitment_data, m_datas)
					index = index + 1
				elseif tonumber(_ED.new_reward_object[index].m_type) == 1 then
					m_datas.m_type = 1
					m_datas.random = _ED.new_reward_object[index].mould_id
					m_datas.number = _ED.new_reward_object[index].number
					table.insert(self.recruitment_data, m_datas)
					index = index + 1
				end
			end
		else
			for i=1, #_ED.random_Patch do
				if tonumber(_ED.random_Patch[i].random_patch_id) ~= -1 then
					local m_datas = {}
					m_datas.m_type = 13
					m_datas.random = _ED.random_Patch[i].random_patch_id
					m_datas.bounty_hero_param_id = _ED.random_Patch[i].bounty_hero_param_id
					table.insert(self.recruitment_data, m_datas)
				else
					-- for i=1,#_ED.new_reward_object do
					-- 	local m_datas = {}
					-- 	m_datas.m_type = tonumber(_ED.new_reward_object[i].m_type) 
					-- 	m_datas.random = tonumber(_ED.new_reward_object[i].mould_id) 
					-- 	m_datas.number = tonumber(_ED.new_reward_object[i].number) 
					-- 	table.insert(self.recruitment_data, m_datas)
					-- end
					local m_datas = {}
					local isSame = false
					if tonumber(_ED.new_reward_object[index].m_type) == 6 then
						local user_prop_template = _ED.user_prop["".._ED.new_reward_object[index].mould_id].user_prop_template
						local prop_ship = dms.int(dms["prop_mould"], user_prop_template, prop_mould.use_of_ship)
						if zstring.tonumber(prop_ship) > 0 then
							local ships = fundShipWidthTemplateId(tonumber(prop_ship))
							if ships ~= nil then
								local m_starRating = dms.int(dms["ship_mould"], tonumber(prop_ship), ship_mould.ship_star)
								local number_info = zstring.split(dms.string(dms["ship_config"], 13, ship_config.param),"!")[tonumber(m_starRating)]
			                    local ability = dms.int(dms["ship_mould"], tonumber(prop_ship), ship_mould.ability)
			                    local number_data = zstring.split(number_info,"|")[ability-13+1]
			                    local split_or_merge_count = tonumber(zstring.split(number_data,",")[2])
								-- local split_or_merge_count = dms.int(dms["prop_mould"], user_prop_template, prop_mould.split_or_merge_count)
								if split_or_merge_count > 0 and split_or_merge_count <= tonumber(_ED.new_reward_object[index].number) then
									m_datas.m_type = 13
									m_datas.random = prop_ship
									m_datas.number = _ED.new_reward_object[index].number
									m_datas.prop_random = _ED.new_reward_object[index].mould_id
									m_datas.isSame = 1
									isSame = true
								end
							end
						end
						if isSame == false then
							m_datas.m_type = 6
							m_datas.random = _ED.new_reward_object[index].mould_id
							m_datas.number = _ED.new_reward_object[index].number
						end
						m_datas.bounty_hero_param_id = _ED.random_Patch[i].bounty_hero_param_id
						table.insert(self.recruitment_data, m_datas)
						index = index + 1
					elseif tonumber(_ED.new_reward_object[index].m_type) == 7 then
						m_datas.m_type = 7
						m_datas.random = _ED.new_reward_object[index].mould_id
						m_datas.number = _ED.new_reward_object[index].number
						table.insert(self.recruitment_data, m_datas)
						index = index + 1
					elseif tonumber(_ED.new_reward_object[index].m_type) == 1 then
						m_datas.m_type = 1
						m_datas.random = _ED.new_reward_object[index].mould_id
						m_datas.number = _ED.new_reward_object[index].number
						table.insert(self.recruitment_data, m_datas)
						index = index + 1
					end
				end
			end
		end

		--随机打乱数组
		local lists = self.recruitment_data
		local lists_two = {}
		RandFetch(lists_two,#lists,#lists,lists)
		self.recruitment_data = lists_two
	end


	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		if self.isplay ~= nil and self.isplay == true then
			playEffect(formatMusicFile("effect", 9983))
			local function changeActionCallback( armatureBack ) 
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccessTen_root,"Panel_yc"):setVisible(true)
            	self:openNewShowAction()
            	armatureBack:removeFromParent(true)
	        end
	        ccui.Helper:seekWidgetByName(csbHeroRecruitSuccessTen_root,"Panel_yc"):setVisible(false)
	        local Panel_zhaomu_open = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccessTen_root,"Panel_zhaomu_open")
	        Panel_zhaomu_open:removeAllChildren(true)
	        
	        if __lua_project_id == __lua_project_l_naruto then
		        local animation = draw.createEffect("sprite_fudan", "sprite/sprite_fudan.ExportJson", Panel_zhaomu_open, -1, nil, nil, cc.p(0.5, 0.5))
		        animation._invoke = changeActionCallback
		        csb.animationChangeToAction(animation, 0, 0, false)
		    else
		    	local jsonFile = "sprite/sprite_fudan.json"
	        	local atlasFile = "sprite/sprite_fudan.atlas"
	        	local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
		        animation.animationNameList = {"animation"}
		        sp.initArmature(animation, false)
		        animation._invoke = changeActionCallback
		        Panel_zhaomu_open:addChild(animation)
		        animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
		        csb.animationChangeToAction(animation, 0, 0, false)
		    end
		else
			self:openNewShowAction()
		end
		local Panel_consume_icon = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccessTen_root,"Panel_consume_icon")
        Panel_consume_icon:removeBackGroundImage()
        local Label_36610 = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccessTen_root,"Label_36610")
		if self.mIndex == 1 then
			Panel_consume_icon:setBackGroundImage("images/ui/icon/jinbi.png")
			Label_36610:setString(dms.int(dms["partner_bounty_param"],9,partner_bounty_param.spend_silver))
		else
			local prop_id = dms.string(dms["shop_config"], 4, shop_config.param)
			local propData = fundPropWidthId(prop_id)
			if propData ~= nil and tonumber(propData.prop_number) >= 10 then
				Label_36610:setString(propData.prop_number.."/10")
				Panel_consume_icon:setBackGroundImage("images/ui/icon/hongjiang.png")
			else
				Label_36610:setString(countActivityHeroDiscount().ten)
				Panel_consume_icon:setBackGroundImage("images/ui/icon/zuanshi.png")
			end
		end
		if self.mIndex == 3 then
			if _ED.active_activity[89] ~= nil then
				local activity_params = zstring.split(_ED.active_activity[89].activity_params, "!")
				local cost_info = zstring.split(zstring.split(activity_params[2], "|")[1], ",")
				Label_36610:setString(cost_info[2])
				Panel_consume_icon:setBackGroundImage("images/ui/icon/zuanshi.png")
			end
		end
    else
    	self:openNewShowAction()
    end            	
	
	
	local RecruitStr =dms.string(dms["pirates_config"], 273, pirates_config.param)
	local pMouID = zstring.split(RecruitStr,",")	
	local propRecruitCount = getPropAllCountByMouldId(pMouID[13])--战将招募令数量
	local propGodRecruitCount = getPropAllCountByMouldId(pMouID[14])--神将招募令数量
	self.zhanjiangling = tonumber(propRecruitCount) or 0			--用户拥有战将领
	self.HeronumberGod = tonumber(propGodRecruitCount) or 0
	
	-- [[
	self.ShipIndex = 0
	-- local cardPanel = {
		-- "Panel_1",
		-- "Panel_2",
		-- "Panel_3",
		-- "Panel_4",
		-- "Panel_5",
		-- "Panel_6",
		-- "Panel_7",
		-- "Panel_8",
		-- "Panel_9",
		-- "Panel_10",
		-- "Panel_11",
		-- "Panel_12"
		-- }
	-- local index = 0
	-- for i, ship in pairs(_ED.random_Patch) do
		-- index = index+1
		-- --获取武将信息
		-- local cell = shipPictureTenCell:createCell(ship.random_patch_id,index)
		--> print("index=======",index)
		-- local Panel_36549_1 = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccessTen_root,cardPanel[i])
		-- Panel_36549_1:addChild(cell)
	-- end
	
	-- local Panel_36549_1 = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_36549_1")
	-- Panel_36549_1:setVisible(true)
	--[[
	self.zhanjiangling = tonumber(getPropAllCountByMouldId(51)) or 0			--用户拥有战将领
	local zhangjiangling = ccui.Helper:seekWidgetByName(self.roots[1], "ImageView_36560_0") 	--zhangjiangling
	local user_god = ccui.Helper:seekWidgetByName(self.roots[1], "ImageView_36560") 			--yuanbao
	local shenjiangling  = ccui.Helper:seekWidgetByName(self.roots[1], "ImageView_36560_1") 	--shenjiangling
	local spend_pack = ccui.Helper:seekWidgetByName(self.roots[1], "Label_36610")			 	--spend_pack
	local put_lable = ccui.Helper:seekWidgetByName(self.roots[1], "Label_36611_0")			 	--xianshi

	self.recruit_ten = dms.string(dms["partner_bounty_param"], 4, partner_bounty_param.spend_gold)	--招募十次需要花的金币
	
	
	if self.ranking == 3 then
		spend_pack:setString("X10")
		zhangjiangling:setVisible(true)
		shenjiangling:setVisible(false)
		user_god:setVisible(false)
		put_lable:setString(""..self.zhanjiangling)
	elseif self.ranking == 6 then 
		spend_pack:setString(self.recruit_ten)
		user_god:setVisible(true)
		zhangjiangling:setVisible(false)
		shenjiangling:setVisible(false)
		put_lable:setString("".._ED.user_info.user_gold)
	
	end
	--]]
	-- state_machine.excute("hero_recruit_success_ten_add_cell", 0, nil)
end

function HeroRecruitSuccessTen:onEnterTransitionFinish()
	self:ShowUI()

	local nCount = 12
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		nCount = 10
		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_36550"), nil, {terminal_name = "shop_hero_page_chick_recruit_ten", terminal_state = self.ranking, touch_scale = true}, nil, 0)
		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_36551"), nil, {terminal_name = "hero_recruit_success_ten_renturn_shop_page", terminal_state = 0, touch_scale = true}, nil, 0)
	end
	-- local Close = fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Panel_15"), nil, {terminal_name = "hero_recruit_success_ten_renturn_shop_page", terminal_state = 0, touch_scale = true}, nil, 0)
	for i=1,nCount do
		local infoPanel = ccui.Helper:seekWidgetByName(self.roots[1],"Panel_show_hero_"..i)
		local infoRoot = infoPanel:getChildByName("ProjectNode_2"):getChildByName("root")
		local Panel_32=  ccui.Helper:seekWidgetByName(infoRoot, "Panel_lwj_2")
		Panel_32:setVisible(false)

		if __lua_project_id == __lua_project_l_digital 
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			then
			local Button_ok = ccui.Helper:seekWidgetByName(infoRoot, "Button_ok")
			fwin:addTouchEventListener(Button_ok, nil, {terminal_name = "hero_recruit_success_ten_open_new_show_action_special", terminal_state = 0, touch_scale = true ,_Panel_32 = Button_ok}, nil, 0)
			-- if tonumber(self.recruitment_data[i].isSame) == 1 then
			-- 	fwin:addTouchEventListener(Panel_32, nil, {terminal_name = "hero_recruit_success_ten_open_new_show_action_special", terminal_state = 0, touch_scale = true ,_Panel_32 = Panel_32}, nil, 0)
			-- end
		else
			fwin:addTouchEventListener(Panel_32, nil, {terminal_name = "hero_recruit_success_ten_open_new_show_action_special", terminal_state = 0, touch_scale = true ,_Panel_32 = Panel_32}, nil, 0)
		end
	end

	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setTouchEnabled(true)
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"), nil, {
		terminal_name = "share_click_on", 
		terminal_state = 0
		}, nil, 2)

	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
	-- if ccui.Helper:seekWidgetByName(self.roots[1], "Button_show") ~= nil then
 --        if zstring.tonumber(_ED.server_review) ~= 1 then  -- 1评审, 其他非
 --            ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(true)
 --        else
 --            ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
 --        end
 --    end

	-- _ED.user_accumulate_buy_god = _ED.user_accumulate_buy_god + 12
	-- if _ED.user_accumulate_buy_god > 20 then
		-- _ED.user_accumulate_buy_god = _ED.user_accumulate_buy_god - 20
	-- end


	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Panel_come_on_the_stage"), nil, {terminal_name = "treasure_chest_offer_success_ten_speedup", terminal_state = 0, touch_scale = false}, nil, 0)
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Image_shop_bg"), nil, {terminal_name = "treasure_chest_offer_success_ten_speedup", terminal_state = 0, touch_scale = false}, nil, 0)

end


function HeroRecruitSuccessTen:onExit()
	
	-- state_machine.remove("hero_recruit_success_ten_renturn_shop_page")
	state_machine.remove("hero_recruit_success_ten_add_cell")
	state_machine.remove("hero_recruit_success_ten_play_high_quality_action")
	-- state_machine.remove("hero_recruit_success_ten_play_hero_animation")
	-- state_machine.remove("shop_hero_page_chick_recruit_ten")
	state_machine.unlock("sm_limited_time_equip_box_a_recruiting")
    state_machine.unlock("sm_limited_time_equip_box_ten_recruiting")
end

-- function HeroRecruitSuccessTen:destroy( window )
--     if nil ~= sp.SkeletonRenderer.clear then
--           sp.SkeletonRenderer:clear()
--     end     
--     cacher.removeAllTextures()     
--     audioUtilUncacheAll() 
-- end
