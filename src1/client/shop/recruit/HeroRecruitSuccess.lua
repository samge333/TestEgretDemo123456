-- ----------------------------------------------------------------------------------------------------
-- 说明：商店英雄招募成功界面 HeroRecruitSuccess.lua
-- 创建时间
-- 作者：
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------

HeroRecruitSuccess = class("HeroRecruitSuccessClass", Window)
    
function HeroRecruitSuccess:ctor()
    self.super:ctor()
	app.load("client.cells.ship_picture_cell_ten")
	if __lua_project_id == __lua_project_l_digital 
		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		then
		app.load("client.cells.prop.sm_packs_cell")
		app.load("client.cells.ship.ship_head_new_cell")
		app.load("client.shop.recruit.SmGeneralsCard")
	end
	self.roots = {}
	self.actions = {}
	self.zhanjiangling = 0
	self.ship = nil
	self.ranking = 0
	self.mIndex = 0
	self.HeronumberGod = 0

	self.play_types = 0
	self.hero_state = false
	self.hero_animation = nil

	self.isSame = false
    -- Initialize HeroRecruitSuccess page state machine.
    local function init_HeroRecruitSuccess_terminal()
		--返回招募预览界面
		local hero_recruit_success_renturn_shop_page_terminal = {
            _name = "hero_recruit_success_renturn_shop_page",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	state_machine.unlock("hero_recruit_list_view_a_recruiting")
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
					if __lua_project_id == __lua_project_pokemon 
						or __lua_project_id == __lua_project_rouge
						then
						state_machine.excute("hero_recruit_refreash_general_view",0,"")
					end
					state_machine.excute("menu_show_event", 0, "menu_show_event.")
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		--武将详情
		local check_information_hero_shop_terminal = {
            _name = "check_information_hero_shop",
            _init = function (terminal) 
                -- app.load("client.formation.HeroInformation")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				local _ship = params._datas.shipId
				-- local heroInfo = HeroInformation:new()
				-- heroInfo:init(_ship)
				-- fwin:open(heroInfo, fwin._ui) 
				app.load("client.packs.hero.HeroPatchInformation")
            	local cell = HeroPatchInformation:new()
				cell:init(tostring(_ship.ship_base_template_id),nil,nil,2)
				fwin:open(cell, fwin._ui)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--再招一次
		local shop_hero_page_chick_recruit_onee_terminal = {
            _name = "shop_hero_page_chick_recruit_one",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                    _ED.new_prop_object = {}
                    _ED.recruit_success_ship_id = nil
                    _ED.new_reward_object = {}
                end
				if TipDlg.drawStorageTipo() == false then
					 _ED.recruit_success_ship_id = nil
					local _goldNumber = tonumber(dms.string(dms["partner_bounty_param"],2,partner_bounty_param.spend_gold))
					local mIndex = instance.mIndex
					local function recruitCallBack(response)
						if (__lua_project_id == __lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
							or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh) and params.status ~= nil then
							state_machine.excute("use_diamond_confirm_tip_close",0,"")
						end
						if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
							if __lua_project_id == __lua_project_l_digital 
		            		or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
		            		then
								getSceneReward(64)
								_ED.show_reward_list_group_ex = {}
							end
							-- smFightingChange()
							local obj = HeroRecruitSuccess:new()
							obj:setRanking(self.ranking,self.mIndex)
							fwin:open(obj,fwin._ui)
							fwin:close(instance)
						end
						if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
							_ED.prop_chest_store_recruiting = true
							if mIndex == 3 then
								state_machine.excute("sm_limited_time_equip_box_update_draw", 0, "")
							end
						end
					end
					if self.mIndex == 1 then --战将再招募一次
						if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
							_ED.prop_chest_store_recruiting = true
							protocol_command.ship_bounty.param_list = ""..self.mIndex
							NetworkManager:register(protocol_command.ship_bounty.code, nil, nil, nil, instance, recruitCallBack, false, nil)
						else
							if self.zhanjiangling> 0 then
								_ED.prop_chest_store_recruiting = true
								protocol_command.ship_bounty.param_list = ""..self.mIndex
								NetworkManager:register(protocol_command.ship_bounty.code, nil, nil, nil, instance, recruitCallBack, false, nil)
							else
								TipDlg.drawTextDailog(_string_piece_info[72])
							end
						end
					elseif self.mIndex == 2 then--神将再招募一次
						if __lua_project_id == __lua_project_l_digital 
							or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
							then
							local prop_id = dms.string(dms["shop_config"], 4, shop_config.param)
							local propData = fundPropWidthId(prop_id)
							if propData ~= nil then
								_ED.prop_chest_store_recruiting = true
								protocol_command.ship_bounty.param_list = ""..self.mIndex
								NetworkManager:register(protocol_command.ship_bounty.code, nil, nil, nil, instance, recruitCallBack, false, nil)
								return
							end
						end
						if self.HeronumberGod > 0 or tonumber(_ED.user_info.user_gold) >= _goldNumber then
							if (__lua_project_id == __lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
								or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh) 
								and ___is_open_diamond_confirm == true and self.HeronumberGod <= 0 and params.status == nil then
								app.load("client.utils.UseDiamondConfirmTip")
								local window_terminal = state_machine.find("use_diamond_confirm_tip_open")
				            	if window_terminal.unopen ~= true then
				            		local str1 = string.format(tipStringInfo_use_diamond[1],_goldNumber)
				            		local str2 = tipStringInfo_use_diamond[2]
				            		state_machine.excute("use_diamond_confirm_tip_open", 0, {_datas={instance,nil,str1.."|"..str2 ,params}})
				            		return
				            	else
				            		_ED.prop_chest_store_recruiting = true
				            		protocol_command.ship_bounty.param_list = ""..self.mIndex
									NetworkManager:register(protocol_command.ship_bounty.code, nil, nil, nil, instance, recruitCallBack, false, nil)
							    end
							else
								_ED.prop_chest_store_recruiting = true
								protocol_command.ship_bounty.param_list = ""..self.mIndex
								NetworkManager:register(protocol_command.ship_bounty.code, nil, nil, nil, instance, recruitCallBack, false, nil)
							end
						else
							TipDlg.drawTextDailog(_string_piece_info[74])
						end
					elseif self.mIndex == 3 then
						if __lua_project_id == __lua_project_l_digital 
							or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
							then
							local activity_type = 89
							local activity = _ED.active_activity[activity_type]
							_ED.prop_chest_store_recruiting = true
							protocol_command.get_activity_reward.param_list = ""..activity.activity_id.."\r\n".."0".."\r\n".."0".."\r\n"..activity_type.."\r\n".."0".."\r\n".."0"
	            			NetworkManager:register(protocol_command.get_activity_reward.code, nil, nil, nil, instance, recruitCallBack, false, nil)
						end
					end
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local hero_purple_close_terminal = {
            _name = "hero_purple_close",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
            	if instance.mIndex == 5 then
            		fwin:close(instance)
            		state_machine.excute("sm_other_recruit_reward_action_continue", 0, nil)
            	else
					local mAction = params._datas._action
					local mPanel_32 = params._datas._Panel_32
					mPanel_32:setTouchEnabled(false)
					mAction:play("close1", false)
					if __lua_project_id == __lua_project_l_digital 
						or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
						then
						local Panel_icon = ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_icon")
						Panel_icon:setVisible(true)
						local Text_name = ccui.Helper:seekWidgetByName(instance.roots[1], "Text_name")
						Text_name:setVisible(true)
						if instance.isSame == true then
							Panel_icon:removeAllChildren(true)
							Panel_icon:setVisible(true)
							--道具
							local prop = _ED.user_prop["".._ED.new_prop_object[1].user_prop_id]
							-- local cell = state_machine.excute("sm_packs_cell",0,{prop,0,_ED.new_prop_object[1].number})
							-- cell:setPosition(cc.p(cell:getPositionX()+7,cell:getPositionY()+7))
							local cell = ResourcesIconCell:createCell()
		        			cell:init(6, tonumber(_ED.new_reward_object[1].number), prop.user_prop_template,nil,nil,true,true,0)
							Panel_icon:addChild(cell)
							local prop_name = dms.string(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_name)
							if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
					            prop_name = setThePropsIcon(prop.user_prop_template)[2]
					        end
						    Text_name:setString(prop_name)
						    local quality = dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_quality)+1
						    Text_name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))    
						else
							--武将
							local ship_id = instance.ship.ship_template_id
							--添加武将头像
							local cell = ShipHeadNewCell:createCell()
							cell:init(ship_id,cell.enum_type._SHOW_HERO_FROM_WARCRAFT, nil, {shipStar = instance.ship.StarRating})
							Panel_icon:addChild(cell)
							ccui.Helper:seekWidgetByName(cell.roots[1], "Panel_kuang"):setVisible(true)
							ccui.Helper:seekWidgetByName(cell.roots[1], "Panel_ditu"):setVisible(true)
							local jsonFile = "sprite/sprite_wzkp.json"
					        local atlasFile = "sprite/sprite_wzkp.atlas"
					        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
					        animation:setPosition(cc.p(Panel_icon:getContentSize().width/2,Panel_icon:getContentSize().height/2))
					        Panel_icon:addChild(animation)
						end
						ccui.Helper:seekWidgetByName(instance.roots[1],"Panel_yc"):setVisible(true)
					end
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        --播放攻击动画
        local hero_recruit_success_play_hero_animation_terminal = {
            _name = "hero_recruit_success_play_hero_animation",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
            	if instance ~= nil then
            		instance:changeHeroAnimation(params)
            	end
            end,
            _terminal = nil,
            _terminals = nil
        }

        --卡牌点击
        local hero_recruit_success_crad_click_on_terminal = {
            _name = "hero_recruit_success_crad_click_on",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
 				ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
            	if instance.mIndex == 5 and instance._isNotNewShip == true then
            		fwin:close(instance)
            		state_machine.excute("sm_other_recruit_reward_action_continue", 0, nil)
            		return
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
            	instance.actions[1]:play("open1_2", false)
                ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_32"):setTouchEnabled(false)
                ccui.Helper:seekWidgetByName(instance.roots[1],"Panel_yc"):setVisible(true)
				ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_icon"):setVisible(true)
				ccui.Helper:seekWidgetByName(instance.roots[1], "Text_name"):setVisible(false)
				ccui.Helper:seekWidgetByName(instance.roots[1], "Button_36550"):setVisible(false)
				ccui.Helper:seekWidgetByName(instance.roots[1], "Button_36551"):setVisible(false)
				ccui.Helper:seekWidgetByName(instance.roots[1],"Panel_zh"):setVisible(false)
				-- Text_name:setVisible(false)
		        local jsonFile = "sprite/sprite_zhaomubg_2.json"
		        local atlasFile = "sprite/sprite_zhaomubg_2.atlas"
		        local animation2 = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
		        ccui.Helper:seekWidgetByName(instance.roots[1],"Panel_bg"):addChild(animation2)

				--进化形象
				local evo_image = dms.string(dms["ship_mould"], tonumber(instance.ship.ship_template_id), ship_mould.fitSkillTwo)
				local evo_info = zstring.split(evo_image, ",")
				--进化模板id
				local ship_evo = zstring.split(instance.ship.evolution_status, "|")
				local evo_mould_id = evo_info[tonumber(ship_evo[1])]
				--新的形象编号
				local temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)

				local Panel_36549_1 = ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_danci")
				Panel_36549_1:removeAllChildren(true)
				draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), Panel_36549_1, nil, nil, cc.p(0.5, 0))
				app.load("client.battle.fight.FightEnum")
				local hero_animation = sp.spine_sprite(Panel_36549_1, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
				hero_animation:setScaleX(-1)
				instance.hero_animation = hero_animation
				instance.play_types = 38
				hero_animation.animationNameList = spineAnimations
				sp.initArmature(hero_animation, true)
			    hero_animation._self = instance

				local soundid = dms.string(dms["ship_mould"], tonumber(instance.ship.ship_template_id), ship_mould.sound_index)
				playEffectExt(formatMusicFile("effect", soundid))

				local function changeActionCallback( armatureBack )	
					local play_types = armatureBack._self.play_types
					local hero_state = armatureBack._self.hero_state
					if play_types == 14 then
						state_machine.excute("hero_recruit_success_play_hero_animation",0,15)
					elseif play_types == 38 then
						state_machine.excute("hero_recruit_success_play_hero_animation",0,14)
					elseif play_types == 15 then
						state_machine.excute("hero_recruit_success_play_hero_animation",0,0)
						hero_state = true
					elseif play_types == 0 and hero_state == true then
						armatureBack._invoke = nil
					end
				end
	    		hero_animation:getAnimation():setFrameEventCallFunc(onFrameEventRole)
			    hero_animation._invoke = changeActionCallback
			    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
				csb.animationChangeToAction(hero_animation, instance.play_types, instance.play_types, false)

				instance.actions[1]:setFrameEventCallFunc(function (frame)
					if nil == frame then
						return
					end
					local str2 = frame:getEvent()
					if str2 == "open1_over" then
						ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_icon"):setVisible(true)
						ccui.Helper:seekWidgetByName(instance.roots[1], "Text_name"):setVisible(false)
						ccui.Helper:seekWidgetByName(instance.roots[1], "Button_36550"):setVisible(true)
						ccui.Helper:seekWidgetByName(instance.roots[1], "Button_36551"):setVisible(true)
						ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_zhedang"):setTouchEnabled(true)
						-- Panel_head_card:setVisible(false)
						-- Panel_111:setVisible(true)
						-- ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_lwj_2"):setSwallowTouches(false)
						local heroInfoRoot = ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_23"):getChildByName("ProjectNode_1"):getChildByName("root")
						local Button_ok=  ccui.Helper:seekWidgetByName(heroInfoRoot, "Button_ok")
						fwin:addTouchEventListener(Button_ok, nil, 
							{
								terminal_name = "hero_purple_close", 
								terminal_state = 0, 
								_action = self.actions[1],
								_Panel_32 = Button_ok,
							},
							nil,0)
					end
				end)
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

		state_machine.add(shop_hero_page_chick_recruit_onee_terminal)
		state_machine.add(hero_recruit_success_renturn_shop_page_terminal)
		state_machine.add(hero_purple_close_terminal)
		state_machine.add(check_information_hero_shop_terminal)
		state_machine.add(hero_recruit_success_play_hero_animation_terminal)
		state_machine.add(hero_recruit_success_crad_click_on_terminal)
		state_machine.add(share_click_on_terminal)
        state_machine.init()
    end
    
    -- call func init hom state machine.
    init_HeroRecruitSuccess_terminal()
end

function HeroRecruitSuccess:loadEffectFile(fileIndex)
    local fileName = string.format("effect/effice_%d.ExportJson", fileIndex)
    -- ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo(fileName)
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(fileName)
    local armatureName = string.format("effice_%d", fileIndex)
    return armatureName, fileName
end

function HeroRecruitSuccess:createEffect(fileIndex, fileNameFormat)
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

function HeroRecruitSuccess:setRanking(ranking,mIndex,isPlay,isNotNewShip,propCount,showStar)
	self.ranking = ranking
	self.mIndex = mIndex
	self.isPlay = isPlay or nil
	self._isNotNewShip = isNotNewShip
	self._propCount = propCount
	self._showStar = showStar
end

function HeroRecruitSuccess:changeHeroAnimation(play_types)
	self.play_types = play_types
	csb.animationChangeToAction(self.hero_animation, play_types, play_types, false)
end

function HeroRecruitSuccess:ShowUI()
	local csbHeroRecruitSuccess = csb.createNode("shop/recruit_settlement_ten.csb")
	local csbHeroRecruitSuccess_root = csbHeroRecruitSuccess:getChildByName("root")
	local action = csb.createTimeline("shop/recruit_settlement_ten.csb")
	table.insert(self.actions, action)
	for i,v in pairs(_ED.user_ship) do
		if _ED.recruit_success_ship_id == v.ship_id then
			self.ship = v
		end
	end
	if self.mIndex == 5 then
		self.isSame = self._isNotNewShip
	else
		self.isSame = false
	end
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		table.insert(self.roots, csbHeroRecruitSuccess_root)
		self:addChild(csbHeroRecruitSuccess)
		table.insert(self.roots, ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_23"):getChildByName("ProjectNode_1"):getChildByName("root"))
		ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
		if zstring.tonumber(_ED.recruit_success_ship_id) == 0 then
			if tonumber(_ED.new_reward_object[1].m_type) == 6 then
				local user_prop_template = _ED.user_prop["".._ED.new_reward_object[1].mould_id].user_prop_template
				local prop_ship = dms.int(dms["prop_mould"], user_prop_template, prop_mould.use_of_ship)
				if zstring.tonumber(prop_ship) > 0 then
					local ships = fundShipWidthTemplateId(tonumber(prop_ship))
					if ships ~= nil then
						local m_starRating = dms.int(dms["ship_mould"], tonumber(prop_ship), ship_mould.ship_star)
						-- if self._showStar ~= 0 then
						-- 	m_starRating = self._showStar
						-- end
						local number_info = zstring.split(dms.string(dms["ship_config"], 13, ship_config.param),"!")[tonumber(m_starRating)]
	                    local ability = dms.int(dms["ship_mould"], tonumber(prop_ship), ship_mould.ability)
	                    local number_data = zstring.split(number_info,"|")[ability-13+1]
	                    local split_or_merge_count = tonumber(zstring.split(number_data,",")[2])
						-- local split_or_merge_count = dms.int(dms["prop_mould"], user_prop_template, prop_mould.split_or_merge_count)
						if split_or_merge_count > 0 and split_or_merge_count <= tonumber(_ED.new_reward_object[1].number) then
							_ED.recruit_success_ship_id = fundShipWidthTemplateId(""..prop_ship).ship_id
							self.isSame = true
							for i,v in pairs(_ED.user_ship) do
								if _ED.recruit_success_ship_id == v.ship_id then
									self.ship = v
								end
							end
						end
					end
				end
			elseif tonumber(_ED.new_reward_object[1].m_type) == 7 then

			elseif tonumber(_ED.new_reward_object[1].m_type) == 1 then
				
			end	
		end
		local Panel_consume_icon = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_consume_icon")
		Panel_consume_icon:removeBackGroundImage()

		if self.mIndex == 1 then
			Panel_consume_icon:setBackGroundImage("images/ui/icon/jinbi.png")
		-- else
			-- Panel_consume_icon:setBackGroundImage("images/ui/icon/zuanshi.png")
		end
		local Label_36610 = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Label_36610")
		if self.mIndex == 1 then
			Label_36610:setString(dms.int(dms["partner_bounty_param"],1,partner_bounty_param.spend_silver))
		else
			local prop_id = dms.string(dms["shop_config"], 4, shop_config.param)
			local propData = fundPropWidthId(prop_id)
			if propData ~= nil then
				Label_36610:setString(propData.prop_number.."/1")
				Panel_consume_icon:setBackGroundImage("images/ui/icon/hongjiang.png")
			else
				if _ED.active_activity[46] ~= nil and zstring.tonumber(_ED.active_activity[46].activity_params) > 0 then
					Label_36610:setString(dms.int(dms["partner_bounty_param"], 2, partner_bounty_param.spend_gold))
				else
					Label_36610:setString(countActivityHeroDiscount().one/2)
				end
				Panel_consume_icon:setBackGroundImage("images/ui/icon/zuanshi.png")
			end
		end

		if self.mIndex == 3 then
			if _ED.active_activity[89] ~= nil then
				-- 限时宝箱活动
				local activity_params = zstring.split(_ED.active_activity[89].activity_params, "!")
				local cost_info = zstring.split(zstring.split(activity_params[2], "|")[1], ",")
				Label_36610:setString(cost_info[1])
				Panel_consume_icon:setBackGroundImage("images/ui/icon/zuanshi.png")
			end
		end

		ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_32"):setTouchEnabled(false)

		local Panel_icon = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_icon")
		Panel_icon:setVisible(false)
		Panel_icon:removeAllChildren(true)
		local Text_name = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Text_name")
		if zstring.tonumber(_ED.recruit_success_ship_id) == 0 then
			if self.isPlay ~= nil and self.isPlay == true then

			else
				Panel_icon:setVisible(true)
				Text_name:setVisible(true)
			end
			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_32"):setTouchEnabled(false)
			local quality = 0
			if tonumber(_ED.new_reward_object[1].m_type) == 6 then
				--道具
				local prop = _ED.user_prop["".._ED.new_prop_object[1].user_prop_id]
				local cell = ResourcesIconCell:createCell()
		        cell:init(6, tonumber(_ED.new_reward_object[1].number), prop.user_prop_template,nil,nil,true,true,0)
				-- local cell = state_machine.excute("sm_packs_cell",0,{prop,0,_ED.new_prop_object[1].number})
				-- cell:setPosition(cc.p(cell:getPositionX()+7,cell:getPositionY()+7))
				Panel_icon:addChild(cell)
				local prop_name = dms.string(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_name)
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		            prop_name = setThePropsIcon(prop.user_prop_template)[2]
		        end
			    Text_name:setString(prop_name)
			    quality = dms.int(dms["prop_mould"], prop.user_prop_template, prop_mould.prop_quality)+1

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
				        animation:setPosition(cc.p(Panel_icon:getContentSize().width/2,Panel_icon:getContentSize().height/2))
				        Panel_icon:addChild(animation)
			    	end
			    end
			elseif tonumber(_ED.new_reward_object[1].m_type) == 7 then
				--装备
				local equip = _ED.user_equiment["".._ED.new_reward_object[1].mould_id]
				-- local cell = EquipIconCell:createCell()
				-- cell:init(3,equip)
				local cell = ResourcesIconCell:createCell()
		    	cell:init(7, tonumber(_ED.new_reward_object[1].number), equip.user_equiment_template,nil,nil,true,true,0)
				Panel_icon:addChild(cell)
				--获取装备名称索引
				local nameindex = dms.int(dms["equipment_mould"], equip.user_equiment_template, equipment_mould.equipment_name)
				--通过索引找到word_mould
				local word_info = dms.element(dms["word_mould"], nameindex)
				local prop_name = word_info[3]
				--绘制
				Text_name:setString(prop_name)
				quality = shipOrEquipSetColour(0)
				local trace_npc_index = dms.int(dms["equipment_mould"], equip.user_equiment_template, equipment_mould.trace_npc_index)
				if trace_npc_index > 0 then
					quality = trace_npc_index + 1
				end
			elseif tonumber(_ED.new_reward_object[1].m_type) == 1 then
				local cell = ResourcesIconCell:createCell()
		        cell:init(_ED.new_reward_object[1].m_type, tonumber(_ED.new_reward_object[1].number), -1,nil,nil,true,true,1)
		        Panel_icon:addChild(cell)
				quality = 3
				Text_name:setString(_All_tip_string_info._fundName)
			end	
		    Text_name:setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))     
		else
			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_32"):setTouchEnabled(true)
			--武将
			local ship_id = self.ship.ship_template_id
			--添加武将头像
			-- local cell = ShipHeadNewCell:createCell()
			-- cell:init(ship_id,cell.enum_type._SHOW_HERO_FROM_WARCRAFT)
			local cell = ResourcesIconCell:createCell()
		    cell:init(13, 1, ship_id,nil,nil,true,true,0,{shipStar = self.ship.StarRating})
			Panel_icon:addChild(cell)
			--进化形象
			local evo_image = dms.string(dms["ship_mould"], ship_id, ship_mould.fitSkillTwo)
			local evo_info = zstring.split(evo_image, ",")
			--进化模板id
			local evo_mould_id = evo_info[dms.int(dms["ship_mould"], ship_id, ship_mould.captain_name)]
			local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
			local word_info = dms.element(dms["word_mould"], name_mould_id)
	        picIndex_name = word_info[3]	
	        Text_name:setString(picIndex_name)
	        Text_name:setColor(cc.c3b(tipStringInfo_quality_color_Type[1][1],tipStringInfo_quality_color_Type[1][2],tipStringInfo_quality_color_Type[1][3]))     
	        local jsonFile = "sprite/sprite_wzkp.json"
	        local atlasFile = "sprite/sprite_wzkp.atlas"
	        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
	        animation:setPosition(cc.p(Panel_icon:getContentSize().width/2,Panel_icon:getContentSize().height/2))
	        Panel_icon:addChild(animation)
		end
		if self.isPlay ~= nil and self.isPlay == true then
			playEffect(formatMusicFile("effect", 9983))
			local function changeActionCallback( armatureBack ) 
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_icon"):setVisible(true)
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Text_name"):setVisible(true)
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_yc"):setVisible(true)
	            action:play("window_open", false)
	            armatureBack:removeFromParent(true)
	            if zstring.tonumber(_ED.recruit_success_ship_id) == 0 then
	            	playEffect(formatMusicFile("effect", 9988))
	            else
	            	playEffect(formatMusicFile("effect", 9982))
	            end
	        end
	        -- ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_icon"):setVisible(true)
			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Text_name"):setVisible(false)
	        local Panel_zhaomu_open = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_zhaomu_open")
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
	    	ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_yc"):setVisible(true)
	    	action:play("window_open", false)
	    	if zstring.tonumber(_ED.recruit_success_ship_id) == 0 then
            	playEffect(formatMusicFile("effect", 9988))
            else
            	playEffect(formatMusicFile("effect", 9982))
            end
	    end
		-- action:play("window_open", false)
		csbHeroRecruitSuccess:runAction(action)

		local Panel_head_card = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_card_icon")
		local Panel_bg = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_bg")
		Panel_bg:removeAllChildren(true)

		if self.mIndex == 5 then
            ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_yc"):setVisible(true)
			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_icon"):setVisible(false)
			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Text_name"):setVisible(false)
			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Button_36550"):setVisible(false)
			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Button_36551"):setVisible(false)

			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_yc"):setVisible(false)
	        local jsonFile = "sprite/sprite_zhaomubg.json"
	        local atlasFile = "sprite/sprite_zhaomubg.atlas"
	        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
	        Panel_bg:addChild(animation)

			Panel_head_card:removeAllChildren(true)
			Panel_head_card:setVisible(true)
			-- state_machine.excute("sm_generals_card_open",0,{Panel_head_card,false,true,self.ship.ship_id,false})
			state_machine.excute("sm_generals_card_open",0,{Panel_head_card,false,true,self.ship.ship_id,false,nil,self.ship.ship_template_id, self._showStar})
			if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
				local animation = draw.createEffect("effect_shop_light", "images/ui/effice/effect_shop_light/effect_shop_light.ExportJson", Panel_head_card, -1, nil, nil, cc.p(0.5, 0.5))
		        animation._invoke = changeActionCallback
		        csb.animationChangeToAction(animation, 0, 0, false)
			end
			if self.isSame == true then
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_zh"):setVisible(true)
				--进化形象
				local evo_image = dms.string(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.fitSkillTwo)
				local evo_info = zstring.split(evo_image, ",")
				--进化模板id
				-- local evo_mould_id = evo_info[dms.int(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.captain_name)]
				local ship_evo = zstring.split(self.ship.evolution_status, "|")
				local evo_mould_id = evo_info[tonumber(ship_evo[1])]
				local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
				local word_info = dms.element(dms["word_mould"], name_mould_id)
	    		local picIndex_name = word_info[3]
	    		ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Text_sp_number"):setString(string.format(_new_interface_text[17],""..self._propCount, picIndex_name))
			else
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_zh"):setVisible(false)
			end

			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_32"):setTouchEnabled(true)
			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_zhedang"):setTouchEnabled(false)
			action:play("open1", false)
			action:setFrameEventCallFunc(function (frame)
				if nil == frame then
					return
				end
				local str1 = frame:getEvent()
				if str1 == "open" then
				elseif str1 == "Panel_card_icon_open" then
				elseif str1 == "close_suipian" then
					ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_zh"):setVisible(false)
				elseif str == "role_playing_is_completed" then
					local heroInfoRoot = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_23"):getChildByName("ProjectNode_1"):getChildByName("root")
					local Panel_32 = ccui.Helper:seekWidgetByName(heroInfoRoot, "Button_ok")
					fwin:addTouchEventListener(Panel_32, nil, 
						{
							terminal_name = "hero_purple_close", 
							terminal_state = 0, 
							_action = action,
							_Panel_32 = Panel_32,
						},
						nil,0)
				end
			end)
		else
			if zstring.tonumber(_ED.recruit_success_ship_id) ~= 0 then
				local Panel_111 = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_111")
				if Panel_111 ~= nil then
					Panel_111:setVisible(false)
				end
				action:setFrameEventCallFunc(function (frame)
					if nil == frame then
						return
					end
					local str = frame:getEvent()
					if str == "open" then
					elseif str == "window_open_over" then

						action:play("open1", false)
						action:setFrameEventCallFunc(function (frame)

							if nil == frame then
								return
							end
							local str1 = frame:getEvent()
							if str1 == "open" then
							elseif str1 == "Panel_card_icon_open" then
				                ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_yc"):setVisible(true)
								ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_icon"):setVisible(false)
								ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Text_name"):setVisible(false)
								ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Button_36550"):setVisible(false)
								ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Button_36551"):setVisible(false)

								ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_yc"):setVisible(false)
						        local jsonFile = "sprite/sprite_zhaomubg.json"
						        local atlasFile = "sprite/sprite_zhaomubg.atlas"
						        local animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
						        Panel_bg:addChild(animation)

								Panel_head_card:removeAllChildren(true)
								Panel_head_card:setVisible(true)

								local star = dms.int(dms["ship_mould"], self.ship.ship_template_id, ship_mould.ship_star)
								if _ED.random_Patch ~= nil 
									and _ED.random_Patch[1] ~= nil 
									and zstring.tonumber(_ED.random_Patch[1].bounty_hero_param_id) > 0 
									then
									local rewards = dms.string(dms["bounty_hero_param"], zstring.tonumber(_ED.random_Patch[1].bounty_hero_param_id), bounty_hero_param.rewards)
									if rewards ~= nil then
										rewards = zstring.split(rewards, ",")
										if zstring.tonumber(rewards[4]) > 0 then
											star = zstring.tonumber(rewards[4])
										end
									end
								end
								-- state_machine.excute("sm_generals_card_open",0,{Panel_head_card,false,true,self.ship.ship_id,false})
								state_machine.excute("sm_generals_card_open",0,{Panel_head_card,false,true,self.ship.ship_template_id,true,nil,nil,star})
								if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
									local animation = draw.createEffect("effect_shop_light", "images/ui/effice/effect_shop_light/effect_shop_light.ExportJson", Panel_head_card, -1, nil, nil, cc.p(0.5, 0.5))
							        animation._invoke = changeActionCallback
							        csb.animationChangeToAction(animation, 0, 0, false)
								end
								if self.isSame == true then
									ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_zh"):setVisible(true)
									--进化形象
									local evo_image = dms.string(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.fitSkillTwo)
									local evo_info = zstring.split(evo_image, ",")
									--进化模板id
									local ship_evo = zstring.split(self.ship.evolution_status, "|")
									-- local evo_mould_id = evo_info[dms.int(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.captain_name)]
									local evo_mould_id = evo_info[tonumber(ship_evo[1])]
									local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
									local word_info = dms.element(dms["word_mould"], name_mould_id)
						    		local picIndex_name = word_info[3]
						    		if self.mIndex == 5 then
						    			ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Text_sp_number"):setString(string.format(_new_interface_text[17],""..self._propCount, picIndex_name))
						    		else
										ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Text_sp_number"):setString(string.format(_new_interface_text[17],"".._ED.new_prop_object[1].number,picIndex_name))
						    		end
								else
									ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_zh"):setVisible(false)
								end

								ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_32"):setTouchEnabled(true)
								ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_zhedang"):setTouchEnabled(false)
								-- local function consumptionOnTouchEvent(sender, evenType)
						  --           local __spoint = sender:getTouchBeganPosition()
						  --           local __mpoint = sender:getTouchMovePosition()
						  --           local __epoint = sender:getTouchEndPosition()

						  --           if ccui.TouchEventType.began == evenType then
						  --               1111
						  --           elseif ccui.TouchEventType.moved == evenType then
						  --           elseif ccui.TouchEventType.ended == evenType then
						  --           end
						  --       end
						  --       local Panel_32 = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_32")
						  --       Panel_32:addTouchEventListener(consumptionOnTouchEvent)
						  --       Panel_32.callback = consumptionOnTouchEvent

							elseif str1 == "Panel_card_icon_close_2" then
								-- Panel_head_card:setVisible(false)
							elseif str1 == "close_suipian" then
								ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root,"Panel_zh"):setVisible(false)
							end
						end)
					elseif str == "role_playing_is_completed" then
						-- Panel_head_card:setVisible(false)
						-- ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_lwj_2"):setSwallowTouches(false)
						local heroInfoRoot = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_23"):getChildByName("ProjectNode_1"):getChildByName("root")
						local Panel_32=  ccui.Helper:seekWidgetByName(heroInfoRoot, "Button_ok")
							fwin:addTouchEventListener(Panel_32, nil, 
								{
									terminal_name = "hero_purple_close", 
									terminal_state = 0, 
									_action = action,
									_Panel_32 = Panel_32,
								},
								nil,0)
					end
				end)
			end
		end

		local heroInfoRoot = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_23"):getChildByName("ProjectNode_1"):getChildByName("root")
		ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_lwj_2"):setSwallowTouches(false)
		ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_lwj_2"):setTouchEnabled(false)
		ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Image_12"):setSwallowTouches(false)
		ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Image_12"):setTouchEnabled(false)
		if zstring.tonumber(_ED.recruit_success_ship_id) ~= 0 then
			--武将定位
			local Text_dingwei_m = ccui.Helper:seekWidgetByName(heroInfoRoot, "Text_dingwei_m")
			--进化形象
			local evo_image = dms.string(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.fitSkillTwo)
			local evo_info = zstring.split(evo_image, ",")
			--进化模板id
			-- local ship_evo = zstring.split(self.ship.evolution_status, "|")
			local evo_mould_id = evo_info[dms.int(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.captain_name)]
			local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.position_index)
			local word_info = dms.element(dms["word_mould"], name_mould_id)
	        local location = word_info[3]
			Text_dingwei_m:setString(location)

			--技能
			local Panel_skill_icon = ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_skill_icon")
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
	        skillName = skillDescriptionReplaceData(talentMouldid,tonumber(self.ship.ship_template_id),2,1,false)
	        local Text_skill_name = ccui.Helper:seekWidgetByName(heroInfoRoot, "Text_skill_name")
	        Text_skill_name:setString(skillName)

	        --分享按钮显示
		    local FB_share = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.Kill_feature)
		    if ccui.Helper:seekWidgetByName(self.roots[1], "Button_show") ~= nil then
		        if zstring.tonumber(_ED.server_review) ~= 1 then  -- 1评审, 其他非
		        	if FB_share == 1 and cc.Application:getInstance():getTargetPlatform() ~= cc.PLATFORM_OS_ANDROID then
		            	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(true)
		            else
		            	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
		            end
		        else
		            ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
		        end
		    end

	        --描述
		    local Text_skill_infor = ccui.Helper:seekWidgetByName(heroInfoRoot, "Text_skill_infor")
		    local skill_describe_id = dms.string(dms["talent_mould"], talentMouldid, talent_mould.talent_describe)
		    local word_info = dms.element(dms["word_mould"], skill_describe_id)
		    local skill_describe = word_info[3]
		    skill_describe = skillDescriptionReplaceData(talentMouldid,tonumber(self.ship.ship_template_id),2,2,false)
		    Text_skill_infor:setString(skill_describe)
		    -- setInnerContainerSize
		    local ms_ScrollView = ccui.Helper:seekWidgetByName(heroInfoRoot, "ScrollView_1")
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
			    local Image_jiantou = ccui.Helper:seekWidgetByName(heroInfoRoot, "Image_jiantou")
			    if Image_jiantou ~= nil then
			    	if ms_ScrollView:getContentSize().height >= text_height then
			    		Image_jiantou:setVisible(false)
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
		end
	else
		local colortype = tonumber(dms.string(dms["ship_mould"], self.ship.ship_template_id,ship_mould.ship_type))
		if colortype >= 3 then
			action:play("open1", false)
			csbHeroRecruitSuccess:runAction(action)
		else
			action:play("window_open", false)
			csbHeroRecruitSuccess:runAction(action)
		end
		table.insert(self.roots, csbHeroRecruitSuccess_root)
		self:addChild(csbHeroRecruitSuccess)
		
		-- local panelzz = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_30")
	    -- local cacheFightArmature = panelzz:getChildByName("ArmatureNode_3")
		-- draw.initArmature(cacheFightArmature, nil, 1, 0, 1)
		-- cacheFightArmature._needLoad = true
		-- cacheFightArmature._invoke = nil
		-- cacheFightArmature._actionIndex = 0
		-- cacheFightArmature._nextAction = 1
		-- cacheFightArmature:getAnimation():playWithIndex(1)

		-- self.ship = _ED.recruit_success_ship_id
		--获取武将信息
		self.cell = ShipPictureCellTen:createCell(self.ship)

		--获取对应放置图层
		local Panel_36549_1 = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_danci")
		-- Panel_36549_1:setVisible(true)
		-- Panel_36549_1:addChild(self.cell)
		if __lua_project_id == __lua_project_gragon_tiger_gate
			or __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			or __lua_project_id == __lua_project_red_alert 
			or __lua_project_id == __lua_project_legendary_game 
			then			--龙虎门项目控制
			local temp_bust_index = 0
			if __lua_project_id == __lua_project_l_digital 
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				then
				----------------------新的数码的形象------------------------
				--进化形象
				local evo_image = dms.string(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.fitSkillTwo)
				local evo_info = zstring.split(evo_image, ",")
				--进化模板id
				local ship_evo = zstring.split(self.ship.evolution_status, "|")
				local evo_mould_id = evo_info[tonumber(ship_evo[1])]
				--新的形象编号
				temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)
			else
				temp_bust_index = dms.int(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.bust_index)
			end
			-- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("sprite/spirte_" .. temp_bust_index .. ".ExportJson")
			-- local cell = ccs.Armature:create("spirte_" .. temp_bust_index)
			-- cell:getAnimation():playWithIndex(0)
			-- Panel_36549_1:removeAllChildren(true)
			-- Panel_36549_1:addChild(cell)
			-- -- cell:setAnchorPoint(cc.p(0.5, 0.5))
			-- -- cell:setPosition(cc.p(Panel_36549_1:getContentSize().width/2, Panel_36549_1:getContentSize().height/2))
			-- cell:setPosition(cc.p(Panel_36549_1:getContentSize().width/2, 0))
			
			Panel_36549_1:removeAllChildren(true)
			draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), Panel_36549_1, nil, nil, cc.p(0.5, 0))
			if animationMode == 1 then
				app.load("client.battle.fight.FightEnum")
				local hero_animation = sp.spine_sprite(Panel_36549_1, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))
				if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			        hero_animation:setScaleX(-1)
			    end
				self.hero_animation = hero_animation

				hero_animation.animationNameList = spineAnimations
				sp.initArmature(hero_animation, true)
			    hero_animation._self = self
				local function changeActionCallback( armatureBack )	
				local play_types = armatureBack._self.play_types
				local hero_state = armatureBack._self.hero_state
				if play_types == 14 then
					state_machine.excute("hero_recruit_success_play_hero_animation",0,15)
				elseif play_types == 15 then
					state_machine.excute("hero_recruit_success_play_hero_animation",0,0)
					hero_state = true
				elseif play_types == 0 and hero_state == true then
					armatureBack._invoke = nil
					-- armatureBack._self:showClosePanelUI(armatureBack._index)
				end
		    end
		    hero_animation._invoke = changeActionCallback
		    hero_animation:getAnimation():setMovementEventCallFunc(csb.changeAction_animationEventCallFunc)
			csb.animationChangeToAction(hero_animation, 0, 0, false)
			else
				draw.createEffect("spirte_" .. temp_bust_index, "sprite/spirte_" .. temp_bust_index .. ".ExportJson", Panel_36549_1, -1, nil, nil, cc.p(0.5, 0))
			end
		elseif __lua_project_id == __lua_project_yugioh
			or __lua_project_id == __lua_project_pokemon 
			then 
			local spIndex = dms.int(dms["ship_mould"], self.ship.ship_template_id, ship_mould.movement)
			Panel_36549_1:removeAllChildren(true)
			Panel_36549_1:removeBackGroundImage()
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
	            Panel_36549_1:addChild(spArmature)
	            spArmature:setPosition(cc.p(Panel_36549_1:getContentSize().width/2, 0))
			else
				local picIndex = dms.int(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.All_icon)
				Panel_36549_1:setBackGroundImage(string.format("images/face/big_head/big_head_%d.png", picIndex))
			end
		else
			local picIndex = dms.int(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.All_icon)
			Panel_36549_1:setBackGroundImage(string.format("images/face/big_head/big_head_%d.png", picIndex))
		end
		
		
		local heroInfoRoot = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_23"):getChildByName("ProjectNode_1"):getChildByName("root")
		local cardCamp = ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_shop_camp")
		--武将阵营
		local HreoCamp = nil
		local TypeCamp = tonumber(dms.string(dms["ship_mould"],tonumber(self.ship.ship_template_id),ship_mould.capacity))
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
		else
			cardCamp:setBackGroundImage(string.format("images/ui/quality/pve_leixing_%d.png", TypeCamp))
		end

		
		--武将类型
		local cardType = ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_shop_form")
		local TypeCurrent = tonumber(dms.string(dms["ship_mould"],tonumber(self.ship.ship_template_id),ship_mould.camp_preference))
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
			or __lua_project_id == __lua_project_yugioh 
			then 
			local RolePanels = {
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_90"),
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_98"),
				ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_99"),
			}
			local ship_basic = dms.int(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.base_mould)

			local current_ship = dms.int(dms["ship_mould"], ship_basic, ship_mould.way_of_gain)
			for i=1,3 do
				local rolePanel = RolePanels[i]
				rolePanel:removeBackGroundImage()
				rolePanel:setVisible(true)
				local imgIcon = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Image_jt_" .. i)
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
		local Text_name = ccui.Helper:seekWidgetByName(heroInfoRoot, "Text_neme")
		local picIndex_name = nil
		if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
			--进化形象
			local evo_image = dms.string(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.fitSkillTwo)
			local evo_info = zstring.split(evo_image, ",")
			--进化模板id
			local ship_evo = zstring.split(self.ship.evolution_status, "|")
			local evo_mould_id = evo_info[tonumber(ship_evo[1])]
			local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
			local word_info = dms.element(dms["word_mould"], name_mould_id)
	        picIndex_name = word_info[3]
		else
			picIndex_name = dms.string(dms["ship_mould"], tonumber(self.ship.ship_template_id), ship_mould.captain_name)
		end
		-- local colortype = dms.string(dms["ship_mould"], tonumber(self.ship.ship_template_id),ship_mould.ship_type)
		Text_name:setColor(cc.c3b(color_Type[colortype+1][1],color_Type[colortype+1][2],color_Type[colortype+1][3]))
		Text_name:setString(picIndex_name)
		
		if colortype >= 3 then
			--获得提示
			-- ccui.Helper:seekWidgetByName(heroInfoRoot, "Text_neme_0"):setVisible(true)
			-- ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_shop_quality"):setVisible(true)
			ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_shop_quality"):setBackGroundImage(string.format("images/ui/quality/hero_name_quality_%d.png", colortype))
		end
		
		
		local tempMusicIndex = dms.int(dms["ship_mould"],  self.ship.ship_template_id, ship_mould.sound_index)
		if tempMusicIndex ~= nil and tempMusicIndex > 0  then
			pushEffect(formatMusicFile("effect", tempMusicIndex))
		end

		if __lua_project_id == __lua_project_yugioh then
			local Panel_shuxing = ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_shuxing")
			local Panel_zhongzu = ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_zhongzu")
			Panel_shuxing:removeBackGroundImage()
			Panel_zhongzu:removeBackGroundImage()
			local faction_id = dms.string(dms["ship_mould"], self.ship.ship_template_id, ship_mould.faction_id)
			local attribute_id = dms.string(dms["ship_mould"], self.ship.ship_template_id, ship_mould.attribute_id)
			Panel_shuxing:setBackGroundImage(string.format("images/ui/quality/shuxing_%s.png", attribute_id))
			Panel_zhongzu:setBackGroundImage(string.format("images/ui/quality/zhongzu_%s.png", faction_id))
		end
		
		-- local tempMusicIndex = zstring.tonumber(dms._element(dms["ship_sound_effect_param"], ship_sound_effect_param.ship_mould, self.ship.ship_template_id, ship_sound_effect_param.sound_effect2))
		-- if tempMusicIndex ~= nil and tempMusicIndex > 0  then
			-- playEffect(formatMusicFile("effect", tempMusicIndex))
			-- self.tempMusicIndex = tempMusicIndex
			-- self.isPlayMusic = true
		-- end
		if __lua_project_id == __lua_project_gragon_tiger_gate
			or __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			or __lua_project_id == __lua_project_red_alert 
			then
			if colortype >= 3 then
				local shipid = tonumber(self.ship.ship_template_id)
				local soundid = dms.string(dms["ship_mould"], shipid, ship_mould.sound_index)
				playEffect(formatMusicFile("effect", soundid))
							
				state_machine.excute("hero_recruit_success_play_hero_animation",0,14)
			end
		end
		-- _ED.recruit_success_ship_id = nil
		ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_lwj_2"):setSwallowTouches(false)
		ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_lwj_2"):setTouchEnabled(false)
		ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Image_12"):setSwallowTouches(false)
		ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Image_12"):setTouchEnabled(false)
					
		if colortype >= 3 then
			local Panel_111 = ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_111")
			Panel_111:setVisible(false)
			action:setFrameEventCallFunc(function (frame)
				if nil == frame then
					return
				end

				local str = frame:getEvent()
				if str == "open" then
				elseif str == "window_open_over" then
					action:play("open1", false)
					action:setFrameEventCallFunc(function (frame)
					 
				playEffect(formatMusicFile("effect", 9988))
						if nil == frame then
							return
						end

						local str1 = frame:getEvent()
						if str1 == "open" then
						elseif str1 == "next_close" then
							Panel_111:setVisible(true)
							-- ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_lwj_2"):setSwallowTouches(false)
							local Panel_32=  ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_32")
							fwin:addTouchEventListener(Panel_32, nil, 
								{
									terminal_name = "hero_purple_close", 
									terminal_state = 0, 
									_action = action,
									_Panel_32 = Panel_32,
								},
								nil,0)
						end
					end)
				elseif str == "role_playing_is_completed" then
					-- ccui.Helper:seekWidgetByName(heroInfoRoot, "Panel_lwj_2"):setSwallowTouches(false)
					local Panel_32=  ccui.Helper:seekWidgetByName(csbHeroRecruitSuccess_root, "Panel_32")
						fwin:addTouchEventListener(Panel_32, nil, 
							{
								terminal_name = "hero_purple_close", 
								terminal_state = 0, 
								_action = action,
								_Panel_32 = Panel_32,
							},
							nil,0)
				end
			end)
		end
	end
end

--获取用户招募完成后的信息更新
function HeroRecruitSuccess:UserInitInfo()
	local RecruitStr =dms.string(dms["pirates_config"], 273, pirates_config.param)
	local pMouID = zstring.split(RecruitStr,",")	
	local propRecruitCount = getPropAllCountByMouldId(pMouID[13])--战将招募令数量
	local propGodRecruitCount = getPropAllCountByMouldId(pMouID[14])--神将招募令数量
	self.zhanjiangling = tonumber(propRecruitCount) or 0			--用户拥有战将领
	self.HeronumberGod = tonumber(propGodRecruitCount) or 0
	
	local userGod = ccui.Helper:seekWidgetByName(self.roots[1], "ImageView_36560") 			--yuanbao
	local zhangjiangling = ccui.Helper:seekWidgetByName(self.roots[1], "ImageView_36560_0") 	--zhangjiangling
	local shenjiangling  = ccui.Helper:seekWidgetByName(self.roots[1], "ImageView_36560_1") 	--shenjiangling
	local put_lable = ccui.Helper:seekWidgetByName(self.roots[1], "Label_36611_0")			 	--xianshi
	local spend_pack = ccui.Helper:seekWidgetByName(self.roots[1], "Label_36610")			 	--spend_pack
	local Panel_111 = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_111")			 	--spend_pack
	local Text_22_0 = ccui.Helper:seekWidgetByName(self.roots[1], "Text_22_0")			 	--spend_pack
	local getGodShipCont = 0
	if tonumber(_ED.user_accumulate_buy_god) > 9 then
		getGodShipCont = 19 - tonumber(_ED.user_accumulate_buy_god)				--再抽几次就抽5星神将
		if __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
			then
		else
			ccui.Helper:seekWidgetByName(self.roots[1], "Text_22_1"):setVisible(false)
			ccui.Helper:seekWidgetByName(self.roots[1], "Text_22_2"):setVisible(true)
		end
	else
		getGodShipCont = 9 - tonumber(_ED.user_accumulate_buy_god)				--再抽几次就抽5星神将
		if __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto
			then
		else
			ccui.Helper:seekWidgetByName(self.roots[1], "Text_22_1"):setVisible(true)
			ccui.Helper:seekWidgetByName(self.roots[1], "Text_22_2"):setVisible(false)
		end
	end
	
	local costGod = countActivityHeroDiscount().one

	
	if self.ranking == 1 or self.ranking == 2 then	--战将
		spend_pack:setString("X1")
		zhangjiangling:setVisible(true)
		shenjiangling:setVisible(false)
		if userGod ~= nil then
			userGod:setVisible(false)
		end
		put_lable:setString(""..self.zhanjiangling)
		
		Panel_111:setVisible(true)
		if __lua_project_id == __lua_project_gragon_tiger_gate
			or __lua_project_id == __lua_project_l_digital
			or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
			or __lua_project_id == __lua_project_red_alert 
			then
			ccui.Helper:seekWidgetByName(self.roots[1], "Panel_purple_role"):setVisible(false)
			ccui.Helper:seekWidgetByName(self.roots[1], "Panel_orange_role"):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(self.roots[1], "Panel_140"):setVisible(false)
			ccui.Helper:seekWidgetByName(self.roots[1], "Panel_141"):setVisible(false)	
		end
		
		
	elseif self.ranking == 4 or self.ranking == 5 then		--神将
		if zstring.tonumber(propGodRecruitCount)>0 then
			spend_pack:setString("X1")
			if userGod ~= nil then
				userGod:setVisible(false)
			end
			zhangjiangling:setVisible(false)
			shenjiangling:setVisible(true)
			put_lable:setString(zstring.tonumber(propGodRecruitCount))
		else
			spend_pack:setString(costGod)
			if userGod ~= nil then
				userGod:setVisible(true)
			end
			zhangjiangling:setVisible(false)
			shenjiangling:setVisible(false)

			put_lable:setString("".._ED.user_info.user_gold)
		end
			Panel_111:setVisible(true)
			put_lable:setVisible(true)		
		if getGodShipCont > 0 then
			Text_22_0:setString(getGodShipCont)
			
			if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				ccui.Helper:seekWidgetByName(self.roots[1], "Panel_purple_role"):setVisible(true)
				ccui.Helper:seekWidgetByName(self.roots[1], "Panel_orange_role"):setVisible(false)
			else			
				ccui.Helper:seekWidgetByName(self.roots[1], "Panel_140"):setVisible(true)
				ccui.Helper:seekWidgetByName(self.roots[1], "Panel_141"):setVisible(false)
			end
		else
			if __lua_project_id == __lua_project_gragon_tiger_gate
				or __lua_project_id == __lua_project_l_digital
				or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
				or __lua_project_id == __lua_project_red_alert 
				then
				ccui.Helper:seekWidgetByName(self.roots[1], "Panel_purple_role"):setVisible(false)
				ccui.Helper:seekWidgetByName(self.roots[1], "Panel_orange_role"):setVisible(true)
			else			
				ccui.Helper:seekWidgetByName(self.roots[1], "Panel_140"):setVisible(false)
				ccui.Helper:seekWidgetByName(self.roots[1], "Panel_141"):setVisible(true)
			end
			
			if tonumber(_ED.user_accumulate_buy_god) > 9 then
				ccui.Helper:seekWidgetByName(self.roots[1], "Text_72_2"):setVisible(true)
				ccui.Helper:seekWidgetByName(self.roots[1], "Text_72_1"):setVisible(false)
			else
				ccui.Helper:seekWidgetByName(self.roots[1], "Text_72_2"):setVisible(false)
				ccui.Helper:seekWidgetByName(self.roots[1], "Text_72_1"):setVisible(true)
			end
		end
	end	
end


function HeroRecruitSuccess:onEnterTransitionFinish()
	self:ShowUI()
	self:UserInitInfo()
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_36550"), nil, 
			{
			terminal_name = "shop_hero_page_chick_recruit_one", 
			terminal_state = self.ranking, 
			touch_scale = true,
			isPressedActionEnabled = true
			},
			nil, 0)
	
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_blow_to_preview"), nil, 
			{
			terminal_name = "check_information_hero_shop", 
			terminal_state = self.ranking, 
			touch_scale = true,
			shipId = self.ship,
			isPressedActionEnabled = true
			},
			nil, 0)
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_36551"), nil, {
		terminal_name = "hero_recruit_success_renturn_shop_page", 
		terminal_state = 0,
		touch_scale = true,
		isPressedActionEnabled = true
		}, nil, 2)

	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Panel_32"), nil, {
		terminal_name = "hero_recruit_success_crad_click_on", 
		terminal_state = 0
		}, nil, 2)

	ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setTouchEnabled(true)
	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"), nil, {
		terminal_name = "share_click_on", 
		terminal_state = 0
		}, nil, 2)

	-- if ccui.Helper:seekWidgetByName(self.roots[1], "Button_show") ~= nil then
 --        if zstring.tonumber(_ED.server_review) ~= 1 then  -- 1评审, 其他非
 --            ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(true)
 --        else
 --            ccui.Helper:seekWidgetByName(self.roots[1], "Button_show"):setVisible(false)
 --        end
 --    end
end

function HeroRecruitSuccess:onExit()
	-- state_machine.remove("hero_recruit_success_renturn_shop_page")
	-- state_machine.remove("shop_hero_page_chick_recruit_one")
	-- state_machine.remove("hero_purple_close")
	-- state_machine.remove("check_information_hero_shop")
	state_machine.unlock("sm_limited_time_equip_box_a_recruiting")
    state_machine.unlock("sm_limited_time_equip_box_ten_recruiting")
end

-- function HeroRecruitSuccess:destroy( window )
--     if nil ~= sp.SkeletonRenderer.clear then
--           sp.SkeletonRenderer:clear()
--     end     
--     cacher.removeAllTextures()     
--     audioUtilUncacheAll() 
-- end