-- ----------------------------------------------------------------------------------------------------
-- 说明：主页中间面菜单
-- 创建时间
-- 作者：
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------

-- 进度未到的功能入口封闭
-- TipDlg.drawTextDailog(_function_unopened_tip_string)

Home = class("HomeClass", Window)
Home.__userHeroFontName = nil

if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
   app.load("client.activity.ActivityFirstRecharge")
   app.load("client.red_alert.login.CampChose")
   app.load("client.red_alert.cells.all_resources_cell")
   app.load("client.cells.utils.sm_item_icon_cell")
   app.load("client.activity.dailytask.TargetTask")
   if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
       app.load("client.l_digital.activity.wonderful.SmFiveStarPraise")
   end
end

local home_window_open_terminal = {
    _name = "home_window_open",
    _init = function (terminal) 
    
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        state_machine.lock("home_window_open", 0, "")
        Loading.loading(
        {
            _pic = {}, 
            _plist = {
                -- {
                --     _png = {"images/ui/play/wonderful_activity/wonderful_he_1.png"}, 
                --     _plist = {"images/ui/play/wonderful_activity/wonderful_he_1.plist"}
                -- },
                -- {
                --     _png = {"images/ui/play/wonderful_activity/wonderful_he_2.png"}, 
                --     _plist = {"images/ui/play/wonderful_activity/wonderful_he_2.plist"}
                -- },
                -- {
                --     _png = {"images/ui/play/wonderful_activity/wonderful_list.png"}, 
                --     _plist = {"images/ui/play/wonderful_activity/wonderful_list.plist"}
                -- }
            }, 
            _ui = {}
        },
        nil,
        {"activity_window_loading", 0, params})
        return true
    end,
    _terminal = nil,
    _terminals = nil
}

local home_window_loading_terminal = {
    _name = "home_window_loading",
    _init = function (terminal) 
    
    end,
    _inited = false,
    _instance = self,
    _state = 0,
    _invoke = function(terminal, instance, params)
        state_machine.unlock("home_window_open", 0, "")
        return true
    end,
    _terminal = nil,
    _terminals = nil
}
state_machine.add(home_window_open_terminal)
state_machine.add(home_window_loading_terminal)
state_machine.init()

function Home:ctor()
    self.super:ctor()
    self.roots = {}
    self.actions = {}
    if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then
        self._view = fwin._frameview
        self._zorder = 1
    end
	self.prop = nil		-- 当前要绘制的道具实例数据对对象
	self.current_type = 0
    self.runState = 0
	self.id = nil
	self._needOpenHomeHero = false
	self._is_show_mystery_shop = false  --是否主页显示神秘商店
	self.AcitivityListTwo = nil
    self.have_send_purify = false
    -- 血量默认设置开启
    local showMasterHp = cc.UserDefault:getInstance():getStringForKey("m_isShowMasterHp")
    if showMasterHp == nil or showMasterHp == "" then
        cc.UserDefault:getInstance():setStringForKey("m_isShowMasterHp","1")
    end
	
	self.init_home_effect = nil
	self.listButtons_1 = nil -- 用于游戏王
    self.listButtons_2 = nil -- 用于游戏王

    self.show_finder = nil --指引
    self.everyDayOnlineRewardTime = 0 -- 数码每日在线奖励显示时间
    self.everyDayOnlinePanel = nil
    self.Panel_hd_tuisong = nil
    self.user_fight = 0
    app.load("client.cells.activity.activity_icon_cell")

    self.updateTimes = 0
    
    -- Initialize Home page state machine.
    local function init_home_terminal()
		--home界面管理
		local home_manager_terminal = {
            _name = "home_manager",
            _init = function (terminal)
				app.load("client.home.HomeHero")
				app.load("client.player.UserInformation")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if terminal.current_terminal_name ~= terminal._name then
                    fwin:freeCache()
                    terminal.current_terminal_name = params._datas.next_terminal_name
					--如果是军团就不关闭界面（因为军团未做）
     --                if params._datas.next_terminal_name == "home_click_union" then
					-- 	if __lua_project_id == __lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                            -- or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then
					-- 		state_machine.excute("menu_clean_page_state", 0, "home")
					-- 	end
					-- else
						if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then			--龙虎门项目控制
							state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                            if params._datas.unload == true then
                                state_machine.excute(params._datas.next_terminal_name, 0, params)
                                return
                            end
                        else
                            state_machine.excute("menu_clean_page_state", 0, "home")
						end
					-- end
                    state_machine.excute(params._datas.next_terminal_name, 0, params)
                    
					if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then			--龙虎门项目控制
						return
					end
					if __lua_project_id == __lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then
						return
					end 
                    state_machine.remove("home_click_out_page")
                    state_machine.remove("home_click_in_page")
                    state_machine.remove("home_click_union")
                    state_machine.remove("home_click_daily_tasks")
                    state_machine.remove("home_click_fame_hall_manager")
                    state_machine.remove("home_click_friend_manager")
                    state_machine.remove("home_click_email_manager")
                    state_machine.remove("home_click_recover")
                    state_machine.remove("home_click_generals")
                    state_machine.remove("home_click_equipment")
                    state_machine.remove("home_click_treasure")
                    state_machine.remove("home_click_recharge")
                    state_machine.remove("home_click_vip")
                    state_machine.remove("home_click_CatalogueStorage")
                    state_machine.remove("home_click_install")
                    state_machine.remove("home_click_chat")
                    state_machine.remove("home_click_sevendays_activity")
                    state_machine.remove("home_click_destiny_system")
                    state_machine.remove("home_click_hero_shop")
                    state_machine.remove("home_click_activity")
                    state_machine.remove("home_recharge_activity")
                    state_machine.remove("home_goto_click_union")
                    state_machine.remove("home_goto_click_recruit")
                    state_machine.remove("home_click_pets")
                    if __lua_project_id == __lua_project_yugioh then
                        state_machine.remove("home_click_magic_card")
                    end
                    
                    cc.Director:getInstance():getTextureCache():removeUnusedTextures()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil,
			child = "child"
        }
		-- 首充完毕之后关闭首充按钮
		local home_update_first_recharge_terminal = {
            _name = "home_update_first_recharge",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				
				if nil == fwin:find("HomeClass") then
					return
				end
				
				if nil ~= instance.updateFirstRecharge then
					instance:updateFirstRecharge()
				end
				
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--军团
		local home_click_union_terminal = {
            _name = "home_click_union",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)         
                if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                    if tonumber(_ED.user_info.user_grade) < dms.int(dms["fun_open_condition"], 141, fun_open_condition.level) then
                        TipDlg.drawTextDailog(dms.string(dms["fun_open_condition"], 141, fun_open_condition.tip_info))
                        return
                    end
                end
                if params._datas.gotype == 1 then
                    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                        app.load("client.l_digital.union.create.UnionJoin")
                    else
                        app.load("client.union.create.UnionJoin")
                    end
                    state_machine.excute("union_join_open", 0, "")
                elseif params._datas.gotype == 2 then
                    if __lua_project_id == __lua_project_gragon_tiger_gate
                        or __lua_project_id == __lua_project_l_digital
                        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                        or __lua_project_id == __lua_project_red_alert
                        then
                        if __lua_project_id == __lua_project_l_digital 
                            or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                            then
                            app.load("client.l_digital.union.UnionTigerGate")
                        else
                            app.load("client.union.UnionTigerGate")
                        end
                        state_machine.excute("Union_open", 0, "")
                        state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                        state_machine.excute("home_hide_event", 0, "home_hide_event.")
                    else
                        app.load("client.union.Union")
                        state_machine.excute("Union_open", 0, "")
                    end
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--日常任务
		local home_click_daily_tasks_terminal = {
            _name = "home_click_daily_tasks",
            _init = function (terminal)    
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
				-- fwin:open(DailyTasks:new(), fwin._view) 
				TipDlg.drawTextDailog(_function_unopened_tip_string)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--好友
		local home_click_friend_manager_terminal = {
            _name = "home_click_friend_manager",
            _init = function (terminal)   
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_l_digital 
                    or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                    then
                    app.load("client.l_digital.friend.SmFriendWindow")
                    state_machine.excute("sm_friend_window_open", 0, nil)
                else
                    app.load("client.friend.FriendManager")
    				fwin:open(FriendManager:new(), fwin._view) 
                    if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                        state_machine.excute("menu_adventure_open_button", 0, 0) 
                    end
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--名人堂
		local home_click_fame_hall_terminal = {
            _name = "home_click_fame_hall_manager",
            _init = function (terminal)
				app.load("client.home.fame.FameHall")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                    if __lua_project_id == __lua_project_l_digital 
                        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                        then
                        app.load("client.l_digital.system.SmRankingMainInterface")
                        state_machine.excute("sm_ranking_main_interface_open", 0, 0) 
                    else
                        local openlevel = tonumber(dms.int(dms["fun_open_condition"], 39, fun_open_condition.level))
                        if tonumber(_ED.user_info.user_grade) < openlevel then 
                            TipDlg.drawTextDailog(dms.string(dms["fun_open_condition"], 39, fun_open_condition.tip_info))
                            return
                        end    
                        fwin:open(FameHall:new(), fwin._view) 
                    end
                else
				    fwin:open(FameHall:new(), fwin._view) 
                end
                if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                    state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
				-- TipDlg.drawTextDailog(_function_unopened_tip_string)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--邮件
		local home_click_email_manager_terminal = {
            _name = "home_click_email_manager",
            _init = function (terminal)
				app.load("client.email.EmailManager")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                    -- local function responsePropCompoundCallback(response)
                    --     if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                    --         if fwin:find("EmailManagerClass") == nil then
                    --            fwin:open(EmailManager:new(), fwin._view) 
                    --         end
                    --     end
                    -- end
                    -- NetworkManager:register(protocol_command.reward_center_init.code, nil, nil, nil, nil, responsePropCompoundCallback, false, nil)
                    
                    if fwin:find("EmailManagerClass") == nil then
                       fwin:open(EmailManager:new(), fwin._view) 
                    end
                else
				    fwin:open(EmailManager:new(), fwin._view) 
                end
                if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                    state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
				-- TipDlg.drawTextDailog(_function_unopened_tip_string)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--武将列表
		local home_click_generals_terminal = {
            _name = "home_click_generals",
            _init = function (terminal) 
                 app.load("client.packs.hero.HeroStorage")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                    if fwin:find("HeroStorageClass") ~= nil then
                        fwin:close(fwin:find("HeroStorageClass"))
                    end
                end            
				fwin:open(HeroStorage:new(), fwin._view) 
				state_machine.excute("hero_storage_manager", 0, 
					{
						_datas = {
							terminal_name = "hero_storage_manager", 	
							next_terminal_name = "hero_storage_show_hero_storage_list",	
							current_button_name = "Button_equipment",  	
							but_image = "", 	
							terminal_state = 0, 
							isPressedActionEnabled = false
						}
					}
				)
				if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then			--龙虎门项目控制
					state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                    state_machine.excute("home_hide_event", 0, "home_hide_event.")
				end
                if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                   state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --魔陷卡列表
        local home_click_magic_card_terminal = {
            _name = "home_click_magic_card",
            _init = function (terminal) 
                 app.load("client.magicCard.MagicCardChooseMain")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if fwin:find("MagicCardChooseMainClass") ~= nil then
                    fwin:close(fwin:find("MagicCardChooseMainClass"))
                end
                local MagicCardMagicListWindow = fwin:find("MagicCardMagicListClass")
                if MagicCardMagicListWindow ~= nil then
                    fwin:close(MagicCardMagicListWindow)
                end 
                local MagicCardTrupListWindow = fwin:find("MagicCardTrupListClass")
                if MagicCardTrupListWindow ~= nil then
                    fwin:close(MagicCardTrupListWindow)
                end
                state_machine.excute("magic_card_main_choose_open", 0, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --战宠将列表
        local home_click_pets_terminal = {
            _name = "home_click_pets",
            _init = function (terminal) 
                 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local fun_id = 54
                if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  then
                    fun_id = 58
                end
                local isOpen_pet  = tonumber(_ED.user_info.user_grade) >= dms.int(dms["fun_open_condition"], fun_id, fun_open_condition.level)
                if false == isOpen_pet then
                    TipDlg.drawTextDailog( dms.string(dms["fun_open_condition"], fun_id, fun_open_condition.tip_info))
                    return
                end
                state_machine.excute("menu_clean_page_state", 0, "home")
                app.load("client.packs.pet.PetStorage")     
                fwin:open(PetStorage:new(), fwin._view) 
                state_machine.excute("pet_storage_manager", 0, 
                {
                    _datas = {
                        terminal_name = "pet_storage_manager",     
                        next_terminal_name = "pet_storage_show_pet_list", 
                        current_button_name = "Button_zhanchong",   
                        but_image = "",     
                        terminal_state = 0, 
                        isPressedActionEnabled = false
                    }
                })
                
                state_machine.excute("menu_adventure_open_button", 0, 0) 
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --推荐阵容
        local home_click_recommend_formation_terminal = {
            _name = "home_click_recommend_formation",
            _init = function (terminal) 
                 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                app.load("client.formation.RecommendFormation")
                state_machine.excute("recommend_formation_window_open",0,0)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

	
		--装备列表
		local home_click_equipment_terminal = {
            _name = "home_click_equipment",
            _init = function (terminal) 
                app.load("client.packs.equipment.EquipStorage")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				fwin:open(EquipStorage:new(), fwin._view) 
				if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then			--龙虎门项目控制
					state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                    state_machine.excute("home_hide_event", 0, "home_hide_event.")
		        elseif __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                   state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
	
		--主界面充值按钮
		local home_click_recharge_terminal = {
            _name = "home_click_recharge",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				-- fwin:open(Recharge:new(), fwin._windows) 
				TipDlg.drawTextDailog(_function_unopened_tip_string)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
	
		--主界面VIP按钮
		local home_click_vip_terminal = {
            _name = "home_click_vip",
            _init = function (terminal) 
                app.load("client.shop.recharge.VipPrivilegeDialog")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
				fwin:open(VipPrivilegeDialog:new(), fwin._windows) 
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
	
		--主界面宝物按钮
		local home_click_treasure_terminal = {
            _name = "home_click_treasure",
            _init = function (terminal) 
                app.load("client.packs.treasure.TreasureStorage")
				-- app.load("client.duplicate.pve.PVEStage")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				fwin:open(TreasureStorage:new(), fwin._view) 
				-- fwin:open(PageStage:new(), fwin._view) 

                if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                   state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		--主界面图鉴按钮
		local home_click_CatalogueStorage_terminal = {
            _name = "home_click_CatalogueStorage",
            _init = function (terminal) 
                app.load("client.home.catalogue.CatalogueStorage")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				fwin:open(CatalogueStorage:new(), fwin._view)
                if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                    state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
	
		--主界面设置按钮
		local home_click_install_terminal = {
            _name = "home_click_install",
            _init = function (terminal) 
                app.load("client.system.InStall")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				fwin:open(InStall:new(), fwin._view) 
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
        --主界面回收按钮
		local home_click_recover_terminal = {
            _name = "home_click_recover",
            _init = function (terminal) 
                app.load("client.refinery.RefiningFurnace")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                    local isopen,tip = getFunopenLevelAndTip(10)
                    if isopen == true then
                        fwin:open(RefiningFurnace:new(), fwin._view)
                        state_machine.excute("refining_furnace_manager", 0, 
                            {
                                _datas = {
                                    terminal_name = "refining_furnace_manager",     
                                    next_terminal_name = "refining_furnace_show_hero_resolve_view", 
                                    current_button_name = "Button_wjfj",    
                                    but_image = "",     
                                    terminal_state = 0, 
                                    isPressedActionEnabled = false
                                }
                            }
                        )
                        state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                        state_machine.excute("home_hide_event", 0, "home_hide_event.")
                    else
                        TipDlg.drawTextDailog(tip)
                    end
                else
    				fwin:open(RefiningFurnace:new(), fwin._view)
    				state_machine.excute("refining_furnace_manager", 0, 
    					{
    						_datas = {
    							terminal_name = "refining_furnace_manager", 	
    							next_terminal_name = "refining_furnace_show_hero_resolve_view",	
    							current_button_name = "Button_wjfj",  	
    							but_image = "", 	
    							terminal_state = 0, 
    							isPressedActionEnabled = false
    						}
    					}
    				)
                end

                if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                    state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

		--主界面聊天按钮
		local home_click_chat_terminal = {
            _name = "home_click_chat",
            _init = function (terminal) 
                app.load("client.chat.ChatStorage")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local index = 71
                if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                    index = 88
                end
                local isOpen = tonumber(_ED.user_info.user_grade) >= dms.int(dms["fun_open_condition"], index, fun_open_condition.level)
                if false == isOpen then
                    TipDlg.drawTextDailog(dms.string(dms["fun_open_condition"], index, fun_open_condition.tip_info))
                    return
                end
    			fwin:open(ChatStorage:new(), fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
				
		local home_click_activity_terminal = {
			_name = "home_click_activity",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				-- local function responseBattleInitCallback(response)
					-- if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						-- BattleSceneClass.Draw()
					-- end
				-- end
				-- _ED._current_scene_id = 1
				-- _ED._scene_npc_id = 5
				-- _ED._npc_difficulty_index = 1
				-- protocol_command.battle_field_init.param_list = "".._ED._current_scene_id.."\r\n".._ED._scene_npc_id.."\r\n".._ED._npc_difficulty_index.."\r\n".."0"
				-- NetworkManager:register(protocol_command.battle_field_init.code, nil, nil, nil, nil, responseBattleInitCallback, true, nil)
				TipDlg.drawTextDailog(_function_unopened_tip_string)
                return true
            end,
            _terminal = nil,
            _terminals = nil
		}
		
		local home_recharge_activity_terminal = {
			_name = "home_recharge_activity",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_l_digital 
                    or __lua_project_id == __lua_project_l_pokemon 
                    or __lua_project_id == __lua_project_l_naruto 
                    then
                    if funOpenDrawTip(181) == true then
                        return
                    end
                end
				app.load("client.shop.recharge.RechargeDialog")
				local Recharge = RechargeDialog:new()
				Recharge:init(4)
				fwin:open(Recharge , fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
		}

		--主界面七日活动按钮
		local home_click_sevendays_activity_terminal = {
            _name = "home_click_sevendays_activity",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				-- state_machine.excute("home_manager",0,"SevenDaysActivity")
				-- fwin:open(SevenDaysActivity:new(), fwin._view) 
				TipDlg.drawTextDailog(_function_unopened_tip_string)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
	
		--主界面三国志按钮
		local home_click_destiny_system_terminal = {
            _name = "home_click_destiny_system",
            _init = function (terminal) 
                 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                    local userlevel = tonumber(_ED.user_info.user_grade)
                    local openlevel = tonumber(dms.string(dms["fun_open_condition"],9, fun_open_condition.level))
                    if userlevel < openlevel then
                        TipDlg.drawTextDailog(dms.string(dms["fun_open_condition"],9, fun_open_condition.tip_info))
                    else
                        app.load("client.destiny.DestinySystem")
                        fwin:open(DestinySystem:new(), fwin._view)
                        state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                        state_machine.excute("home_hide_event", 0, "home_hide_event.")
                    end
                else
    				app.load("client.destiny.DestinySystem")
    				fwin:open(DestinySystem:new(), fwin._view)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
	
		--主界面神秘商店按钮
		local home_click_hero_shop_terminal = {
            _name = "home_click_hero_shop",
            _init = function (terminal) 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
			--向服务器发送请求
                    if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                        local isopen,tip = getFunopenLevelAndTip(41)
                        if isopen == true then
                            local function recruitCallBack(response)
                                if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                                    app.load("client.shop.hero.HeroShop")
                                    fwin:open(HeroShop:new(), fwin._view)             
                                end
                            end
                            if _ED.secret_shop_init_info.os_time == nil or _ED.secret_shop_init_info.os_time == "" then
                                NetworkManager:register(protocol_command.secret_shop_init.code, nil, nil, nil, nil, recruitCallBack, false, nil)
                            else
                                local times = os.time()- tonumber(_ED.secret_shop_init_info.os_time)
                                local leave_time = _ED.secret_shop_init_info.refresh_time/1000-times
                                if leave_time <= 0 then
                                    NetworkManager:register(protocol_command.secret_shop_init.code, nil, nil, nil, self, recruitCallBack, false, nil)
                                else
                                    recruitCallBack({RESPONSE_SUCCESS = true,PROTOCOL_STATUS = 0})
                                end
                            end
                        else
                            TipDlg.drawTextDailog(tip)
                        end
						state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                        state_machine.excute("home_hide_event", 0, "home_hide_event.")
                    else
                        app.load("client.shop.hero.HeroShop")
                        fwin:open(HeroShop:new(), fwin._view)  
                        state_machine.excute("menu_adventure_open_button", 0, 0) 
                    end
					-- local function recruitCallBack(response)
						-- if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
      --                   -------------------
      --                   if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
      --                       local function recruitCallBack(response)
      --                           if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
      --                               app.load("client.shop.hero.HeroShop")
      --                               fwin:open(HeroShop:new(), fwin._view)             
      --                           end
      --                       end
      --                       NetworkManager:register(protocol_command.secret_shop_init.code, nil, nil, nil, nil, recruitCallBack, false, nil)
						-- else
      --                   	app.load("client.shop.hero.HeroShop")
						-- 	fwin:open(HeroShop:new(), fwin._view) 
						-- end	
      --                   ----------------------
						-- end
					-- end
					
					-- protocol_command.secret_shop_init.param_list = "".._ED.user_info.user_id
					-- NetworkManager:register(protocol_command.secret_shop_init.code, nil, nil, nil, nil, recruitCallBack, false, nil)
					if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then			--龙虎门项目控制
						state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                        state_machine.excute("home_hide_event", 0, "home_hide_event.")
					end
                    if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                        state_machine.excute("menu_adventure_open_button", 0, 0) 
                    end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		local push_infomation_home_terminal = {
            _name = "push_infomation_home",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
				if self.index ~= nil then 
                    if __lua_project_id == __lua_project_adventure then

                        --state_machine.excute("push_info_update_draw", 0, "")
                    else
					   fwin:open(PushInfo:new(), fwin._background)--打开消息推送
                    end
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		local close_push_infomation_home_terminal = {
            _name = "close_push_infomation_home",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
				if self.index ~= nil then 
					fwin:close(fwin:find("PushInfoClass"))--关闭消息推送
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local push_infomation_home_update_draw_hero_intro_terminal = {
            _name = "push_infomation_home_update_draw_hero_intro",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
                if instance ~= nil and instance.roots ~= nil then
                    instance:updateDrawHeroIntro(params)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		local home_click_strategy_terminal = {
            _name = "home_click_strategy",
            _init = function (terminal) 
                app.load("client.home.strategy.Strategy")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params) 
				if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                    app.load("client.home.lstrategy.LStrategy")
                    state_machine.excute("lstrategy_main_open", 0, nil)
                else
                    state_machine.excute("menu_clean_page_state", 0,"") 
                    fwin:open(Strategy:new(), fwin._view)
                    -- TipDlg.drawTextDailog(_function_unopened_tip_string)
                end
                if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                    state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		-- 打开包裹的主界面
        local home_click_package_terminal = {
            _name = "home_click_package",
            _init = function (terminal) 
                app.load("client.packs.prop.PropStorage")
                app.load("client.packs.prop.SmPropWarehouse")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_l_digital 
                    or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                    then
                    state_machine.excute("prop_warehouse_window_open", 0,"")
                else
                    if __lua_project_id == __lua_project_gragon_tiger_gate
                        or __lua_project_id == __lua_project_red_alert 
                        or __lua_project_id == __lua_project_legendary_game
                        then
                        fwin:open(PropStorage:new(), fwin._background)
                    else
    				    state_machine.excute("menu_clean_page_state", 0,"")
                        fwin:open(PropStorage:new(), fwin._view)
                    end
    				state_machine.excute("prop_storage_manager", 0, 
    					{
    						_datas = {
    							terminal_name = "Button_daoju", 	
    							next_terminal_name = "prop_storage_chick_prop_storages", 			
    							current_button_name = "Button_daoju", 		
    							but_image = "", 		
    							terminal_state = 0, 
    							isPressedActionEnabled = true
    						}
    					}
    				)
                end
				if __lua_project_id == __lua_project_gragon_tiger_gate
                    or __lua_project_id == __lua_project_l_digital
                    or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                    then			--龙虎门项目控制
					state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                    state_machine.excute("home_hide_event", 0, "home_hide_event.")
				end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		-- 打开Home时，是否打开HomHero
        local home_change_open_atrribute_terminal = {
            _name = "home_change_open_atrribute",
            _init = function (terminal) 
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				instance._needOpenHomeHero = params
				
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		-- 隐藏界面
        local home_hide_event_terminal = {
            _name = "home_hide_event",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				instance:onHide()
                state_machine.excute("home_hero_hide_event", 0, "home_hero_hide_event")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		-- 显示界面
        local home_show_event_terminal = {
            _name = "home_show_event",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
    				instance:onShow()
                    state_machine.excute("home_hero_show_event", 0, "home_hero_show_event")
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		
		--主界面三国志按钮跳转
		local home_goto_destiny_system_terminal = {
            _name = "home_goto_destiny_system",
            _init = function (terminal) 
                 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				local function recruitCallBack(response)
					if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						state_machine.excute("home_manager", 0, {_datas={terminal_name = "home_manager", next_terminal_name = "home_click_destiny_system",but_image = "Image_home", terminal_state = 0, isPressedActionEnabled = true}})
						local next_terminal_name = params._datas.next_terminal_name
						if nil ~= next_terminal_name then
							state_machine.excute(next_terminal_name, 0, params._datas.next_params)
						end
                        if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                            if params._datas.cell ~= nil then
                                state_machine.excute("destiny_system_set_prop_cell",0,params._datas.cell)
                            end
                        end
					end
				end
                if __lua_project_id == __lua_project_yugioh
                    or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge
                    then
                    if tonumber(_ED.user_info.user_grade) < dms.int(dms["fun_open_condition"], 9, fun_open_condition.level) then
                        TipDlg.drawTextDailog(dms.string(dms["fun_open_condition"], 9, fun_open_condition.tip_info))
                        return
                    end
                end
                if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                    if _ED.cur_star_count == "" or _ED.cur_star_count == nil then
                        local _data = NetworkManager:find(protocol_command.destiny_init.code) 
                        if nil ~= _data then
                            _data.handler = recruitCallBack
                        else
                            NetworkManager:register(protocol_command.destiny_init.code, nil, nil, nil, nil, recruitCallBack, false, nil)
                        end  
                    else
                        recruitCallBack({RESPONSE_SUCCESS = true, PROTOCOL_STATUS = 0})
                    end
                else
    				local _data = NetworkManager:find(protocol_command.destiny_init.code) 
    				if nil ~= _data then
    					_data.handler = recruitCallBack
    				else
    					NetworkManager:register(protocol_command.destiny_init.code, nil, nil, nil, nil, recruitCallBack, false, nil)
    				end
				end
                if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
                   state_machine.excute("menu_adventure_open_button", 0, 0) 
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		--主界面军团按钮跳转
		local home_goto_click_union_terminal = {
            _name = "home_goto_click_union",
            _init = function (terminal) 
                 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if ___is_open_union == false then
                    return
                end
				state_machine.excute("menu_adventure_open_button", 0, 0)
				local isOpen_union  = tonumber(_ED.user_info.user_grade) >= dms.int(dms["fun_open_condition"], 11, fun_open_condition.level)
				if false == isOpen_union then
					TipDlg.drawTextDailog( dms.string(dms["fun_open_condition"], 11, fun_open_condition.tip_info))
					return
				end
				if _ED.union.union_info == nil or _ED.union.union_info == {}  or  _ED.union.union_info.union_id == nil or _ED.union.union_info.union_id == "" then
					local function responseUnionListCallback(response)
						if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
							if zstring.tonumber(_ED.union.union_list_sum) == 0 then -- 第一个军团时
								state_machine.excute("home_manager", 0, {_datas={terminal_name = "home_manager", next_terminal_name = "home_click_union",but_image = "Image_home", terminal_state = 0,gotype=1 , isPressedActionEnabled = true}})
								 return true
							else
                                if _ED.union.union_info == nil or _ED.union.union_info == {}  or  _ED.union.union_info.union_id == nil or _ED.union.union_info.union_id == "" then
                                    state_machine.excute("home_manager", 0, {_datas={terminal_name = "home_manager", next_terminal_name = "home_click_union",but_image = "Image_home", terminal_state = 0,gotype=1 , isPressedActionEnabled = true}})
                                else
                                    local function responseCallback( response )
                                        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then                
                                            state_machine.excute("home_manager", 0, {_datas={terminal_name = "home_manager", next_terminal_name = "home_click_union",but_image = "Image_home", terminal_state = 0,gotype=2 , isPressedActionEnabled = true}})
                                        end
                                    end
                                    if tonumber(_ED.union.union_member_list_sum) == nil then 
                                        NetworkManager:register(protocol_command.union_persion_list.code, nil, nil, nil, nil, responseCallback, false, nil)                    
                                    else
                                        state_machine.excute("home_manager", 0, {_datas={terminal_name = "home_manager", next_terminal_name = "home_click_union",but_image = "Image_home", terminal_state = 0,gotype=2 , isPressedActionEnabled = true}})
                                    end
                                end

                                return true
							end	
						end
					end	
					_ED.union.union_list_info = nil
					protocol_command.union_list.param_list = "0"
					NetworkManager:register(protocol_command.union_list.code, nil, nil, nil, self, responseUnionListCallback, false, nil)
					-- state_machine.excute("union_join_open", 0, response.node)
				else
					-- state_machine.excute("Union_open", 0, response.node)
					local function responseCallback( response )
                        if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then                
                            state_machine.excute("home_manager", 0, {_datas={terminal_name = "home_manager", next_terminal_name = "home_click_union",but_image = "Image_home", terminal_state = 0,gotype=2 , isPressedActionEnabled = true}})
                        end
                    end
                    if tonumber(_ED.union.union_member_list_sum) == nil then 
                        NetworkManager:register(protocol_command.union_persion_list.code, nil, nil, nil, nil, responseCallback, false, nil)                    
                    else
                        state_machine.excute("home_manager", 0, {_datas={terminal_name = "home_manager", next_terminal_name = "home_click_union",but_image = "Image_home", terminal_state = 0,gotype=2 , isPressedActionEnabled = true}})
                    end
                end
				return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --抽卡 --游戏王
        local home_goto_click_recruit_terminal = {
            _name = "home_goto_click_recruit",
            _init = function (terminal) 
                 
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if __lua_project_id == __lua_project_yugioh then
                    state_machine.excute("menu_clean_page_state", 0, "home")
                end
                local _shop = Shop:new()
                fwin:open(_shop, fwin._view)
                state_machine.excute("menu_adventure_open_button", 0, 0)
                state_machine.excute("shop_manager", 0, 
                        {
                            _datas = {
                                terminal_name = "shop_manager",     
                                next_terminal_name = "shop_ship_recruit",
                                current_button_name = "Button_tavern",  
                                but_image = "recruit",      
                                terminal_state = 0, 
                                isPressedActionEnabled = true
                            }
                        }
                    )
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

         -- 占领
        local home_capture_open_terminal = {
            _name = "home_capture_open",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local _level = tonumber(dms.string(dms["fun_open_condition"],55, fun_open_condition.level))
                local user_level = tonumber(_ED.user_info.user_grade)
                if user_level < _level then
                -- state_machine.excute("menu_clean_page_state", 0, "")
                    local text = dms.string(dms["fun_open_condition"],55, fun_open_condition.tip_info)
                    TipDlg.drawTextDailog(text)
                    return
                end
                app.load("client.captureResource.CaptureResourceMain")
                if _ED.capture_resource_build_info == nil then
                    local function responseCaptureCallback(response)
                        state_machine.excute("capture_resource_open", 0, nil)
                        state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                        state_machine.excute("home_hide_event", 0, "home_hide_event.")                        
                    end
                    NetworkManager:register(protocol_command.map_scattered_init.code, nil, nil, nil, self, responseCaptureCallback, false, nil)                     
                else
                    state_machine.excute("capture_resource_open", 0, nil)
                    state_machine.excute("menu_hide_event", 0, "menu_hide_event.")
                    state_machine.excute("home_hide_event", 0, "home_hide_event.")  
                end

                

                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

	    -- 显示爆衣按钮
        local home_baoyi_button_terminal = {
            _name = "home_baoyi_button",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local shipId = zstring.tonumber(params._datas._shipId)
                local currentPage = params._datas._currentPage
                instance:updatabaoyi(shipId,currentPage)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
         -- 点击爆衣按钮
        local home_baoyi_button_enter_terminal = {
            _name = "home_baoyi_button_enter",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.lock("home_baoyi_button_enter", 0, "")
                if params._datas._currentPage._lock == nil or params._datas._currentPage._lock == false then
                    params._datas._currentPage._lock = true
                    if params._datas._currentPage._baoyi == nil or params._datas._currentPage._baoyi == false then
                        params._datas._currentPage._baoyi = true
                        instance:updatabaoyi(params._datas._shipId,params._datas._currentPage,false)
                        local shipId = params._datas._shipId
                        local shipPic = tonumber(dms.string(dms["ship_mould"], shipId, ship_mould.bust_index)) + 10000
                        local path = string.format("images/face/big_head/big_head_%d.png", shipPic)
                        params._datas._currentPage:onUpdateDraw(path)
                    elseif params._datas._currentPage._baoyi ~= nil and params._datas._currentPage._baoyi == true then
                        params._datas._currentPage._baoyi = false
                        local shipId = params._datas._shipId
                        local shipPic = tonumber(dms.string(dms["ship_mould"], shipId, ship_mould.bust_index))
                        local path = string.format("images/face/big_head/big_head_%d.png", shipPic)
                        params._datas._currentPage:onUpdateDraw(path)
                        instance:updatabaoyi(0,params._datas._currentPage,true)
                    end
                end
				return true
            end,
            _terminal = nil,
            _terminals = nil
        }

         --facebook
        local home_goto_click_faceBook_url_terminal = {
            _name = "home_goto_click_faceBook_url",
            _init = function (terminal)
    
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                handlePlatformRequest(0, CC_OPEN_URL_LAYOUT, _face_book_url)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --客服
        local home_goto_click_gm_url_terminal = {
            _name = "home_goto_click_gm_url",
            _init = function (terminal)
    
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("platform_operator_openurl", 0,"")
                --handlePlatformRequest(0, CC_OPEN_URL_LAYOUT, app.configJson.urlweb)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        -- 冒险与挖矿的独立状态机
        -- 讨论区
        local home_adventure_forum_terminal = {
            _name = "home_adventure_forum",
            _init = function (terminal)
                app.load("client.adventure.chat.AdventureChatStorage")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                    fwin:open(AdventureChatStorage:new(), fwin._windows)
                -- state_machine.excute("menu_adventure_open_button", 0,"")
                -- state_machine.excute("menu_clean_page_state", 0,"")

                -- fwin:open(AdventureForums:new():init(), fwin._view)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local home_adventure_fanpage_terminal = {
            _name = "home_adventure_fanpage",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
	    	    --弹出粉丝页窗口
	    	    state_machine.excute("platform_the_open_fans_page", 0,"")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        -- 礼包
        local home_adventure_gift_bag_terminal = {
            _name = "home_adventure_gift_bag",
            _init = function (terminal)
                app.load("client.adventure.activity.reward.AdventureRewardCenter")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:open(AdventureRewardCenter:new():init(), fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 好友
        local home_adventure_friends_terminal = {
            _name = "home_adventure_friends",
            _init = function (terminal)
                app.load("client.adventure.friend.AdventureFriendManger")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("menu_clean_page_state", 0,"")
                fwin:open(AdventureFriendManger:new():init(), fwin._view)
                state_machine.excute("menu_adventure_open_button", 0,"")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 设置
        local home_adventure_system_set_terminal = {
            _name = "home_adventure_system_set",
            _init = function (terminal)
                app.load("client.adventure.system.set.AdventureSet")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:open(AdventureSet:new():init(), fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		 -- 更多
        local home_adventure_more_system_terminal = {
            _name = "home_adventure_more_system",
            _init = function (terminal)
				app.load("client.adventure.home.MoreSystem")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:open(MoreSystem:new():init(), fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 商店
        local home_adventure_shop_terminal = {
            _name = "home_adventure_shop",
            _init = function (terminal)
                app.load("client.adventure.shop.AdventureShop")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("menu_clean_page_state", 0,"")
                fwin:open(AdventureShop:new():init(), fwin._view)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 签到
        local home_adventure_sign_in_terminal = {
            _name = "home_adventure_sign_in",
            _init = function (terminal)
                app.load("client.adventure.activity.sign.AdventureDailySignIn")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:open(AdventureDailySignIn:new():init(), fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 月卡
        local home_adventure_month_card_terminal = {
            _name = "home_adventure_month_card",
            _init = function (terminal)
                app.load("client.adventure.activity.month_card.AdventureMonthCard")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:open(AdventureMonthCard:new():init(), fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 活动
        local home_adventure_activity_terminal = {
            _name = "home_adventure_activity",
            _init = function (terminal)
                app.load("client.adventure.activity.AdventureActivityWindow")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("menu_clean_page_state", 0,"")
                fwin:open(AdventureActivityWindow:new():init(), fwin._view)
                state_machine.excute("menu_adventure_open_button", 0,"")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 成就
        local home_adventure_achievement_terminal = {
            _name = "home_adventure_achievement",
            _init = function (terminal)
                app.load("client.adventure.achievement.AdventureAchievement")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                
                state_machine.excute("menu_clean_page_state", 0,"")
                fwin:open(AdventureAchievement:new():init(), fwin._view)
                state_machine.excute("menu_adventure_open_button", 0,"")
                
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 黑市
        local home_adventure_black_market_terminal = {
            _name = "home_adventure_black_market",
            _init = function (terminal)
                app.load("client.adventure.activity.black_market.AdventureBlackMarket")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("menu_adventure_open_button", 0,"")
                state_machine.excute("menu_clean_page_state", 0,"")
                fwin:open(AdventureBlackMarket:new():init(), fwin._view)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 公告
        local home_adventure_notice_terminal = {
            _name = "home_adventure_notice",
            _init = function (terminal)
                app.load("client.adventure.system.notice.AdventureNotice")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:open(AdventureNotice:new():init(2), fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        --讨论区
        local home_adventure_discuss_terminal = {
            _name = "home_adventure_discuss",
            _init = function (terminal)
                --app.load("client.adventure.system.notice.AdventureNotice")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                fwin:open(AdventureNotice:new():init(2), fwin._windows)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		
		
		-- 挖矿项目功能锁
        local home_adventure_update_open_condition_terminal = {
            _name = "home_adventure_update_open_condition",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				--月卡 评审状态
				if funOpenConditionJudge(56) == true and zstring.tonumber(_ED.server_review) == 0 then
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_yueka"):setVisible(true)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1"):setVisible(true)
				else
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_yueka"):setVisible(false)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1"):setVisible(false)
				end
				--黑市
				if funOpenConditionJudge(57) == true then
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_heishi"):setVisible(true)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_0"):setVisible(true)
				else
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_heishi"):setVisible(false)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_0"):setVisible(false)
				end
				--好友
				if funOpenConditionJudge(58) == true then
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_haoyou"):setVisible(true)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_1"):setVisible(true)
				else
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_haoyou"):setVisible(false)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_1"):setVisible(false)
				end
				--活动
				if funOpenConditionJudge(59) == true then
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_huodong"):setVisible(true)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_2"):setVisible(true)
				else
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_huodong"):setVisible(false)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_2"):setVisible(false)
				end
				--商店
				-- if funOpenConditionJudge(60) == true then
				-- 	ccui.Helper:seekWidgetByName(instance.roots[1], "Button_shangdian"):setVisible(true)
				-- 	ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_0_0"):setVisible(true)
				-- else
				-- 	ccui.Helper:seekWidgetByName(instance.roots[1], "Button_shangdian"):setVisible(false)
				-- 	ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_0_0"):setVisible(false)
				-- end
				--更多
				if funOpenConditionJudge(61) == true then
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_more"):setVisible(true)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_1_0"):setVisible(true)
				else
					ccui.Helper:seekWidgetByName(instance.roots[1], "Button_more"):setVisible(false)
					--ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_1_0"):setVisible(false)
				end

                if funOpenConditionJudge(62) == true then
                    ccui.Helper:seekWidgetByName(instance.roots[1], "Button_chengjiu"):setVisible(true)
                    --ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_1_0"):setVisible(true)
                else
                    ccui.Helper:seekWidgetByName(instance.roots[1], "Button_chengjiu"):setVisible(false)
                    --ccui.Helper:seekWidgetByName(instance.roots[1], "Image_1_1_0"):setVisible(false)
                end
				
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
	
		
        local home_more_setting_update_terminal = {
            _name = "home_more_setting_update",
            _init = function (terminal)
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local _paramsdata = params._datas
                local root = _paramsdata.cell.roots[1]
                local action = _paramsdata.cell.actions[1]
                local  Panel_103 = ccui.Helper:seekWidgetByName(root, "Panel_103")
                if _paramsdata.status == true then
                    Panel_103:setVisible(false)
                    if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                        action:setTimeSpeed(app.getTimeSpeed())
                    end
                    action:play("Panel_126_untonch", false)
                else
                    Panel_103:setVisible(true)
                    if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
                        action:setTimeSpeed(app.getTimeSpeed())
                    end
                    action:play("Panel_126_tonch", false)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        -- 检查等级奖励是否领取完了
        local home_check_level_packs_terminal = {
            _name = "home_check_level_packs",
            _init = function (terminal)

            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:checkLevelPacks(params)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
		 -- 舰娘分享成功
        local home_get_share_ok_terminal = {
            _name = "home_get_share_ok",
            _init = function (terminal)

            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
				local share_id = params
				if params ~= nil and params ~= "" then
					share_id = "1"
				end
				local function responseAreaShareOkCallback(response)
					if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
						state_machine.excute("arena_share_close",0,"")   --关闭分享界面
					end
				end
				protocol_command.share_game.param_list = ""..share_id
				NetworkManager:register(protocol_command.share_game.code,nil,nil, nil, nil, responseAreaShareOkCallback, false, nil)
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 打开数码每日领取
        local sm_open_every_day_online_reward_terminal = {
            _name = "sm_open_every_day_online_reward",
            _init = function (terminal)
                app.load("client.l_digital.home.SmEveryDayOnlineReward")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                state_machine.excute("sm_every_day_online_reward_open",0,"sm_every_day_online_reward_open.")
                state_machine.excute("sm_every_day_online_reward_define",0,"sm_every_day_online_reward_define.")
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        --模块参与提示
        local sm_model_join_push_goto_join_terminal = {
            _name = "sm_model_join_push_goto_join",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local currId = params._datas.shortCut
                params:setVisible(false)
                local current_time = _ED.system_time + (os.time() - _ED.native_time)
                cc.UserDefault:getInstance():setStringForKey(getKey("ship_purify_push_time"..currId), current_time)
                cc.UserDefault:getInstance():flush()
                if currId == 1 then
                    state_machine.excute("sm_union_red_envelopes_open", 0, nil)
                elseif currId == 2 then
                    state_machine.excute("union_fighting_main_open", 0, nil)
                elseif currId == 3 then
                    state_machine.excute("explore_window_open", 0, "3")
                    -- state_machine.excute("explore_window_open_fun_window", 0, { _datas = {page_index = 3} })
                elseif currId == 4 then
                    app.load("client.l_digital.campaign.Campaign")
                    state_machine.excute("campaign_window_open", 0, nil)
                    state_machine.excute("sm_battleof_kings_window_open", 0, nil)
                end
                _ED.home_activity_push_info[currId].isWaitOpen = false
                _ED.home_activity_push_info[currId].isHaveOpen = false
                local openIndex = 0
                for k,v in pairs(_ED.home_activity_push_info) do
                    if v ~= nil and (v.isWaitOpen == true or v.isAllShow == true) then
                        openIndex = k
                        break
                    end
                end
                if openIndex ~= 0 then
                    if openIndex == 4 then
                        instance:updateHomeAcivityPushUIInfo(openIndex, _ED.home_activity_push_info[4].isAllShow)
                    else
                        instance:updateHomeAcivityPushUIInfo(openIndex, false)
                    end
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        --功能开启浏览
        local sm_model_open_push_scan_terminal = {
            _name = "sm_model_open_push_scan",
            _init = function (terminal)
                app.load("client.l_digital.home.SmModelOpenPushScan")
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                local currId = params._datas.shortCut
                state_machine.excute("sm_model_open_push_scan_open",0,currId)
                _ED.system_fun_open_event = 0
                local Image_funopen_tip = ccui.Helper:seekWidgetByName(instance.roots[1], "Image_funopen_tip")
                if Image_funopen_tip ~= nil then
                    Image_funopen_tip:setVisible(false)
                end
                --红点隐藏
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }
        --功能开启刷新
        local sm_model_open_push_updata_terminal = {
            _name = "sm_model_open_push_updata",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance:modelOpenPush()
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        
        --布阵刷新
        local sm_model_open_layout_refresh_draw_terminal = {
            _name = "sm_model_open_layout_refresh_draw",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if true then
                    return
                end
                local Panel_fomation_role = ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_fomation_role")
                if Panel_fomation_role ~= nil then
                    Panel_fomation_role:removeAllChildren(true)

                    local formetion_index = 1
                    local ships = nil
                    for i,v in pairs(_ED.user_formetion_status) do
                        if _ED.user_ship[""..v] ~= nil then
                            formetion_index = i
                            ships = _ED.user_ship[""..v]
                            break
                        end
                    end

                    if ships ~= nil then
                        local _ship_mould_id = ships.ship_template_id
                        local temp_bust_index = 0
                        ----------------------新的数码的形象------------------------
                        --进化形象
                        local evo_image = dms.string(dms["ship_mould"], _ship_mould_id, ship_mould.fitSkillTwo)
                        local evo_info = zstring.split(evo_image, ",")
                        --进化模板id
                        local ship_evo = zstring.split(ships.evolution_status, "|")
                        local evo_mould_id = evo_info[tonumber(ship_evo[1])]
                        --新的形象编号
                        temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)

                        draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), Panel_fomation_role, nil, nil, cc.p(0.5, 0))
                        app.load("client.battle.fight.FightEnum")
                        local shipSpine = sp.spine_sprite(Panel_fomation_role, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))

                        fwin:addTouchEventListener(Panel_fomation_role,   nil, 
                        {
                            terminal_name = "home_hero_into_formation_page",    
                            terminal_state = 0, 
                            _heroInstance = ships,
                            _formetion_index = formetion_index,
                            isPressedActionEnabled = true
                        }, 
                        nil, 0)
                    end  
                    Panel_fomation_role._istips = nil
                    Panel_fomation_role._nodeChild = nil
                    state_machine.excute("notification_center_remove_widget", 0, { _widget = Panel_fomation_role })
                    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_hero_develop_home_hero_icon",
                        _widget = Panel_fomation_role,
                        _invoke = nil,
                        _interval = 0.5,}) 
                        end   
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --打开动画
        local sm_model_open_the_animation_terminal = {
            _name = "sm_model_open_the_animation",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance.actions[1]:play("animation_open", false)
                if __lua_project_id == __lua_project_l_digital 
                    or __lua_project_id == __lua_project_l_pokemon 
                    or __lua_project_id == __lua_project_l_naruto
                    then
                else
                    ccui.Helper:seekWidgetByName(instance.roots[1], "Button_guanbi"):setVisible(true)
                    ccui.Helper:seekWidgetByName(instance.roots[1], "Button_zhankai"):setVisible(false)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        --关闭动画
        local sm_model_close_the_animation_terminal = {
            _name = "sm_model_close_the_animation",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                instance.actions[1]:play("animation_close", false)
                if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
                else
                    ccui.Helper:seekWidgetByName(instance.roots[1], "Button_guanbi"):setVisible(false)
                    ccui.Helper:seekWidgetByName(instance.roots[1], "Button_zhankai"):setVisible(true)
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local home_update_top_activity_info_state_terminal = {
            _name = "home_update_top_activity_info_state",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.onUpdateDrawEx ~= nil then
                    instance:onUpdateDrawEx()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        -- 活动推送刷新
        local sm_home_update_activity_push_state_terminal = {
            _name = "sm_home_update_activity_push_state",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                -- 转点推送
                local server_time = getCurrentGTM8Time()
                local update_leave_time = (24 - server_time.hour) * 3600 - server_time.min * 60 - server_time.sec + 1

                -- 体力领取推送
                local energyData = zstring.split(dms.string(dms["activity_config"], 1, activity_config.param), "|")
                local add_enger_info = zstring.split(_ED._add_enger_info,"|")
                local energy_leave_time = 0
                for i=1, 4 do
                    local energy_info = zstring.split(energyData[i], ",")
                    local next_time_info = zstring.split(energy_info[1], ":")       -- 下一次体力领取时间
                    local next_leave_time = (tonumber(next_time_info[1]) - server_time.hour) * 3600 + (tonumber(next_time_info[2]) - server_time.min) * 60 + (tonumber(next_time_info[3]) - server_time.sec)
                    if next_leave_time > 0 then
                        energy_leave_time = next_leave_time
                        break
                    end
                end

                local activity_type = 0
                local leave_time = update_leave_time
                if energy_leave_time > 0 and energy_leave_time < update_leave_time then
                    activity_type = 1001
                    leave_time = energy_leave_time
                end

                local function callback(sender)
                    state_machine.excute("push_notification_center_activity_the_center_sm_activity_update", 0, activity_type)
                    state_machine.excute("sm_home_update_activity_push_state", 0, "")
                end
                instance:runAction(cc.Sequence:create(
                    cc.DelayTime:create(leave_time),
                    cc.CallFunc:create(callback)))
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local home_update_online_reward_info_state_terminal = {
            _name = "home_update_online_reward_info_state",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil 
                    and instance.everyDayOnlinePanel == nil then
                    local Panel_online_reward = ccui.Helper:seekWidgetByName(instance.roots[1], "Panel_online_reward")
                    if Panel_online_reward ~= nil then
                        if false == funOpenDrawTip(162, false) then
                            instance.everyDayOnlinePanel = Panel_online_reward
                        end
                    end
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local home_update_mission_over_finder_state_terminal = {
            _name = "home_update_mission_over_finder_state",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
                    if instance.showFinder ~= nil then
                        if tonumber(_ED.user_info.user_grade) < 10 then
                            instance:showFinder()
                        end
                    end
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

        local home_update_target_task_info_state_terminal = {
            _name = "home_update_target_task_info_state",
            _init = function (terminal)
                
            end,
            _inited = false,
            _instance = self,
            _state = 0,
            _invoke = function(terminal, instance, params)
                if instance ~= nil and instance.roots ~= nil and instance.roots[1] ~= nil then
                    instance:updateTargetTaskState()
                end
                return true
            end,
            _terminal = nil,
            _terminals = nil
        }

		if state_machine.find("home_manager") == nil then
			state_machine.add(home_manager_terminal)
		end

		state_machine.add(home_goto_destiny_system_terminal)
		state_machine.add(home_goto_click_union_terminal)
		state_machine.add(home_update_first_recharge_terminal)
		-- state_machine.add(home_click_out_page_terminal)
		-- state_machine.add(home_click_in_page_terminal)
		state_machine.add(home_click_union_terminal)
		state_machine.add(home_click_daily_tasks_terminal)
		state_machine.add(home_click_fame_hall_terminal)
		state_machine.add(home_click_friend_manager_terminal)
		state_machine.add(home_click_email_manager_terminal)
		state_machine.add(home_click_recover_terminal)
		
		state_machine.add(home_click_generals_terminal)
        if __lua_project_id == __lua_project_yugioh then
            state_machine.add(home_click_magic_card_terminal)
        end
        state_machine.add(home_click_pets_terminal)
		state_machine.add(home_click_equipment_terminal)
		state_machine.add(home_click_recharge_terminal)
		state_machine.add(home_click_vip_terminal)
		state_machine.add(home_click_treasure_terminal)

		state_machine.add(home_click_CatalogueStorage_terminal)
		state_machine.add(home_click_install_terminal)
		
		state_machine.add(home_click_chat_terminal)
		state_machine.add(home_click_sevendays_activity_terminal)
		state_machine.add(home_click_destiny_system_terminal)
		state_machine.add(home_click_hero_shop_terminal)

		state_machine.add(home_click_activity_terminal)
		state_machine.add(home_recharge_activity_terminal)
		
		state_machine.add(push_infomation_home_terminal)
		state_machine.add(close_push_infomation_home_terminal)
        state_machine.add(push_infomation_home_update_draw_hero_intro_terminal)
        state_machine.add(home_click_strategy_terminal)
        if ___is_open_laster == true then
            state_machine.add(home_baoyi_button_terminal)
            state_machine.add(home_baoyi_button_enter_terminal)
        end
		
		if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then
			state_machine.add(home_click_package_terminal)
			state_machine.add(home_change_open_atrribute_terminal)
			state_machine.add(home_hide_event_terminal)
			state_machine.add(home_show_event_terminal)
            state_machine.add(home_more_setting_update_terminal)
            state_machine.add(home_check_level_packs_terminal)
            state_machine.add(home_capture_open_terminal)
		end

        if __lua_project_id == __lua_project_adventure then
            state_machine.add(home_adventure_forum_terminal)
	        state_machine.add(home_adventure_fanpage_terminal)
            state_machine.add(home_adventure_gift_bag_terminal)
            state_machine.add(home_adventure_friends_terminal)
            state_machine.add(home_adventure_system_set_terminal)
            state_machine.add(home_adventure_shop_terminal)
            state_machine.add(home_adventure_sign_in_terminal)
            state_machine.add(home_adventure_month_card_terminal)
            state_machine.add(home_adventure_activity_terminal)
            state_machine.add(home_adventure_achievement_terminal)
            state_machine.add(home_adventure_black_market_terminal)
            state_machine.add(home_adventure_notice_terminal)
			state_machine.add(home_adventure_more_system_terminal)
			state_machine.add(home_adventure_update_open_condition_terminal)
        end
        if __lua_project_id == __lua_project_yugioh then
            state_machine.add(home_goto_click_recruit_terminal)
        end
        state_machine.add(home_click_recommend_formation_terminal)
        state_machine.add(home_get_share_ok_terminal)
        state_machine.add(home_goto_click_faceBook_url_terminal)
        state_machine.add(home_goto_click_gm_url_terminal)
        if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
            state_machine.add(sm_open_every_day_online_reward_terminal)
            state_machine.add(sm_model_join_push_goto_join_terminal)
            state_machine.add(sm_model_open_push_scan_terminal)
            state_machine.add(sm_model_open_push_updata_terminal)
            state_machine.add(sm_model_open_layout_refresh_draw_terminal)
            state_machine.add(sm_model_open_the_animation_terminal)
            state_machine.add(sm_model_close_the_animation_terminal)
            state_machine.add(home_update_top_activity_info_state_terminal)
            state_machine.add(sm_home_update_activity_push_state_terminal)
            state_machine.add(home_update_online_reward_info_state_terminal)
            state_machine.add(home_update_mission_over_finder_state_terminal)
            state_machine.add(home_update_target_task_info_state_terminal)
        end
        state_machine.init()
    end
    -- call func init hom state machine.
    init_home_terminal()
end
function Home:checkLevelPacks(_type)
    local root = self.roots[1]
    if _type == 1 then
        local Button_level_pack = ccui.Helper:seekWidgetByName(root,"Button_level_pack")
        Button_level_pack:setVisible(true)
        return
    end
    if __lua_project_id == __lua_project_gragon_tiger_gate 
        -- or __lua_project_id == __lua_project_l_digital 
        -- or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        or __lua_project_id == __lua_project_red_alert 
        then   
        local Button_level_pack = ccui.Helper:seekWidgetByName(root,"Button_level_pack")
        if tonumber(_ED.user_info.user_grade) < 3 then
            Button_level_pack:setVisible(false)
            return
        end
        if _ED.active_activity[12] == nil then
            Button_level_pack:setVisible(false)
            return
        end
        local showbutton = false
        for i,v in pairs(_ED.active_activity[12].activity_Info) do
            if v.activityInfo_isReward == "0" then
                showbutton = true 
                break
            end
        end
        if showbutton == false then
            state_machine.excute("level_packs_close_action",0,"")
        end
        Button_level_pack:setVisible(showbutton)
    end
end
function Home:onHide()
	for i, v in pairs(self.roots) do
		v:setVisible(false)
	end
end

function Home:onShow()
	for i, v in pairs(self.roots) do
		v:setVisible(true)
	end
end

function Home:updatabaoyi(shipId,currentPage,isshow)
    local root  = self.roots[1]
    if root == nil then
        return
    end


    if shipId > 0 and isshow == nil then
        local shipPic = tonumber(dms.string(dms["ship_mould"], shipId, ship_mould.bust_index)) + 10000
        local headPath = string.format("images/face/big_head/big_head_%d.png", shipPic)
        -- local file,err = io.open(headPath,"r+") 
        local roleIcon = ccs.Skin:create(headPath)
        local baoyibutton = ccui.Helper:seekWidgetByName(root, "Button_baoyi")
        if roleIcon ~= nil then
            if baoyibutton ~= nil then
                if zstring.tonumber(_ED.server_review) == 1 then
                    ccui.Helper:seekWidgetByName(root, "Panel_baoyitubiao"):setVisible(false)
                else
                    ccui.Helper:seekWidgetByName(root, "Panel_baoyitubiao"):setVisible(true)
                end
                if dms.int(dms["ship_mould"], tonumber(shipId), ship_mould.captain_type) == 0 then
                    local fashionEquip, pic = getUserFashion()
                    if fashionEquip ~= nil and pic ~= nil then
                        ccui.Helper:seekWidgetByName(root, "Panel_baoyitubiao"):setVisible(false)
                    end
                end
                fwin:addTouchEventListener(baoyibutton, nil, 
                {
                    terminal_name = "home_baoyi_button_enter", 
                    _shipId = shipId,
                    _currentPage = currentPage,
                    _cell = self,
                    terminal_state = 0, 
                    isPressedActionEnabled = true
                },
                nil,0)  
            end
        else
            if baoyibutton ~= nil then
                ccui.Helper:seekWidgetByName(root, "Panel_baoyitubiao"):setVisible(false)
            end
        end   
    end
    if isshow ~= nil then
        local Panel_baoyi = ccui.Helper:seekWidgetByName(root, "Panel_baoyi_one")
        if isshow == false then
            Panel_baoyi:setVisible(true)
            local ArmatureNode_bao_10 = Panel_baoyi:getChildByName("ArmatureNode_bao_10")
            local function changeActionCallback(armatureBack)
                -- local shipPic = tonumber(dms.string(dms["ship_mould"], shipId, ship_mould.bust_index)) + 10000
                -- local path = string.format("images/face/big_head/big_head_%d.png", shipPic)
                -- currentPage:onUpdateDraw(path)
                currentPage._lock = false         
                state_machine.unlock("home_baoyi_button_enter", 0, "")
                armatureBack:setVisible(false)
                armatureBack._invoke = nil
            end
            ArmatureNode_bao_10:setVisible(true)

            draw.initArmature(ArmatureNode_bao_10, nil, -1, 0, 1)
            ArmatureNode_bao_10:getAnimation():playWithIndex(0, 0, 0)
            csb.animationChangeToAction(ArmatureNode_bao_10, 0, 0, nil)
            ArmatureNode_bao_10._invoke = changeActionCallback
            if shipId > 0 then
                local data =  dms.searchs(dms["ship_sound_effect_param"], ship_sound_effect_param.ship_mould, shipId)
                if data ~= nil and  table.getn(data) > 0 and data[1] ~= nil then
                   local tempMusicIndex =  dms.atoi(data[1], ship_sound_effect_param.sound_effect3)
                    if tempMusicIndex > 0 then
                         playEffect(formatMusicFile("effect", tempMusicIndex ))
                    end
                end   
            end
        else
            Panel_baoyi:setVisible(false)
            currentPage._lock = false
            state_machine.unlock("home_baoyi_button_enter", 0, "")
        end
        -- ccui.Helper:seekWidgetByName(root, "Panel_baoyi_one"):setVisible(isshow)
    end
    -- body
end
function Home:updateFirstRecharge()
	local root = self.roots[1]
	local AcitivityList = ccui.Helper:seekWidgetByName(root, "ListView_1")
	if nil == AcitivityList then
 		return --
	end
	local items = AcitivityList:getItems()
	if __lua_project_id == __lua_project_gragon_tiger_gate 
        or __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        or __lua_project_id == __lua_project_red_alert 
        then
        AcitivityList:removeAllItems()
		self:upDataDraw()
	else
        if __lua_project_id == __lua_project_yugioh then 
            local listButtons2 = ccui.Helper:seekWidgetByName(root, "Panel_button_list_2")
            local childs = listButtons2:getChildren()
            for i,v in ipairs(listButtons2) do
                if v.ActivityType == v.enum_type.ACTIVITY_HOME_FIRST_RECHARGE_ICON then
                    listButtons2:removeItem(i) 
                    self:refreshActivityListButtonsSize(2)          
                    return 
                end
            end
        else
            for i,v in ipairs(items) do
                if v.ActivityType == v.enum_type.ACTIVITY_HOME_FIRST_RECHARGE_ICON then
                    AcitivityList:removeItem(i) 
                    self:refreshActivityListViewSize()          
                    return 
                end
            end
        end
	end
end

--刷新活动按钮位置
function Home:refreshActivityListButtonsSize(index)  
    local root = self.roots[1]
    if root == nil then 
        return
    end
    if index == 1 then 
        --顶端三个 活动， 日常任务 ，开服基金
        local buttons1 = ccui.Helper:seekWidgetByName(root, "Panel_button_list")
        local childs = buttons1:getChildren()
        for i,v in pairs(childs) do
            local point_x = buttons1:getContentSize().width - i * v:getContentSize().width - 10
            v:setPositionX(point_x)
        end
    else
        local buttons2 = ccui.Helper:seekWidgetByName(root, "Panel_button_list_2")
        local childs = buttons2:getChildren()
        for i,v in pairs(childs) do
            local point_x = buttons2:getContentSize().width - i * v:getContentSize().width - 10
            v:setPositionX(point_x)
        end
    end
end

function Home:refreshActivityListViewSize()
    if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then
        local root = self.roots[1]
        if root ~= nil then
            local AcitivityList = ccui.Helper:seekWidgetByName(root, "ListView_1")

            local items = AcitivityList:getItems()
            local iCount = #items
            if iCount > 0 then
                -- 移动ListView的位置
                local xx, yy = AcitivityList:getPosition()
                local lsize = AcitivityList:getContentSize()
                AcitivityList:setAnchorPoint(cc.p(1, 0))
                AcitivityList:setPosition(cc.p(xx + lsize.width, yy))
                local margin = AcitivityList:getItemsMargin()
                local twidth = 0
                for i, v in pairs(items) do
                    local w = v:getContentSize().width
                    twidth = twidth + w
                end
                twidth = twidth + (#items - 1) * margin 
                AcitivityList:setContentSize(cc.size(twidth, lsize.height))
                AcitivityList:refreshView()
            end
        end
    end
end
--显示指引
function Home:showFinder()
    if self.show_finder == nil then
        local Panel_pve = ccui.Helper:seekWidgetByName(self.roots[1],"Panel_pve")
        app.load("client.cells.duplicate.pageview_seat_role_guide_cell")
        --print("============",fwin:find("PageViewSeatRoleGuideClass"))
        local guide = PageViewSeatRoleGuide:createCell()
        guide:setPosition(cc.p(Panel_pve:getContentSize().width * 0.5 - 15, Panel_pve:getContentSize().height*0.5))
        self.show_finder = guide
        Panel_pve:addChild(guide)
    end
end

function Home:upDataDraw()
	local root = self.roots[1]
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
        local Panel_dh_1 = ccui.Helper:seekWidgetByName(root, "Panel_dh_1")
        if Panel_dh_1 ~= nil then
            if Panel_dh_1.animation ~= nil then
                Panel_dh_1.animation:removeFromParent(true)
            end
            local jsonFile = "sprite/spirte_maoxian.json"
            local atlasFile = "sprite/spirte_maoxian.atlas"
            Panel_dh_1.animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
            Panel_dh_1:addChild(Panel_dh_1.animation)
        end

        local Panel_dh_2 = ccui.Helper:seekWidgetByName(root, "Panel_dh_2")
        if Panel_dh_2.animation ~= nil then
            Panel_dh_2.animation:removeFromParent(true)
        end
        local jsonFile = "sprite/spirte_zhenzhan.json"
        local atlasFile = "sprite/spirte_zhenzhan.atlas"
        Panel_dh_2.animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
        Panel_dh_2:addChild(Panel_dh_2.animation)

        self:onUpdateDrawEx()
        return
    end

	local AcitivityList = ccui.Helper:seekWidgetByName(root, "ListView_1")
	local AcitivityListTwo = ccui.Helper:seekWidgetByName(root, "ListView_1_2")
    if __lua_project_id == __lua_project_yugioh then 
        self.listButtons_1 = ccui.Helper:seekWidgetByName(root, "Panel_button_list")
        self.listButtons_2 = ccui.Helper:seekWidgetByName(root, "Panel_button_list_2")
    end
	app.load("client.cells.activity.activity_icon_cell")
	--军团
	if (__lua_project_id == __lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh)
        and ___is_open_union == true
         then
		-- if _ED.union.union_info ~= nil and _ED.union.union_info ~= "" and _ED.union.union_info.union_id ~= nil then
			local Buttonlegion = ccui.Helper:seekWidgetByName(root, "Button_legion")
			state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_union_all",
			_widget = Buttonlegion,
			_invoke = nil,
			_interval = 0.5,})
		-- end
	end
	--活动
	local activityIcon = ActivityIconCell:createCell()
	activityIcon:init(activityIcon.enum_type.ACTIVITY_EXCITING_ICON)
    if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
        activityIcon._notification = { _terminal_name = "push_notification_center_activity_all",
        _widget = activityIcon,
        _invoke = nil,
        _interval = 0.5,}

        local Buttonlegion = ccui.Helper:seekWidgetByName(root, "Button_legion")
        state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_union_all",
        _widget = Buttonlegion,
        _invoke = nil,
        _interval = 0.5,})        
    elseif __lua_project_id == __lua_project_yugioh then
        self.listButtons_1:addChild(activityIcon)  
        self:refreshActivityListButtonsSize(1)  
        state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_all",
        _widget = activityIcon,
        _invoke = nil,
        _interval = 0.5,})
    else
	   AcitivityList:addChild(activityIcon)	
        state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_all",
        _widget = activityIcon,
        _invoke = nil,
        _interval = 0.5,})
    end
	--日常任务
    if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
        local Button_dailytasks = ccui.Helper:seekWidgetByName(root, "Button_dailytasks")
        fwin:addTouchEventListener(Button_dailytasks, nil, 
        {
            terminal_name = "activity_every_day_button", 
            terminal_state = 0, 
            isPressedActionEnabled = true
        },
        nil,0)
        state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_main_page_daily_activity",
        _widget = Button_dailytasks,
        _invoke = nil,
        _interval = 0.5,})
    else
    	local everyDayJob = ActivityIconCell:createCell()
    	everyDayJob:init(everyDayJob.enum_type.ACTIVITY_EVERYDAY_ICON)
        if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
            everyDayJob._notification = { _terminal_name = "push_notification_center_activity_main_page_daily_activity",
            _widget = everyDayJob,
            _invoke = nil,
            _interval = 0.5,}
        elseif __lua_project_id == __lua_project_yugioh then 
            self.listButtons_1:addChild(everyDayJob)
            self:refreshActivityListButtonsSize(1)
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_main_page_daily_activity",
            _widget = everyDayJob,
            _invoke = nil,
            _interval = 0.5,}) 
        else
    	   AcitivityList:addChild(everyDayJob)
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_main_page_daily_activity",
            _widget = everyDayJob,
            _invoke = nil,
            _interval = 0.5,})
        end
	end
	local is2002 = false
	if __lua_project_id == __lua_project_warship_girl_a 
	or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh 
	or __lua_project_id == __lua_project_koone
    or __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert
	then
		if dev_version >= 2002 then
			is2002 = true
		end
	end
		
	local firstRecharge = nil
	if true == is2002 then
		--首充
		if nil ~= _ED.active_activity[4] then
			firstRecharge = ActivityIconCell:createCell()
			firstRecharge:init(firstRecharge.enum_type.ACTIVITY_HOME_FIRST_RECHARGE_ICON)
            if __lua_project_id == __lua_project_l_digital 
                or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                then
                -- if tonumber(_ED.recharge_rmb_number) > 0 and tonumber(_ED.active_activity[4].activity_id)==0 then
                --     if firstRecharge.animation ~= nil then
                --         firstRecharge.animation:removeFromParent(true)
                --     end
                --     local jsonFile = "sprite/sprite_wzkp.json"
                --     local atlasFile = "sprite/sprite_wzkp.atlas"
                --     firstRecharge.animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
                --     firstRecharge.animation:setPosition(cc.p(firstRecharge:getContentSize().width / 2, firstRecharge:getContentSize().height / 2))
                --     firstRecharge:addChild(firstRecharge.animation)
                -- end
            end
            if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
               firstRecharge._notification = { _terminal_name = "push_notification_center_activity_recharge",
                _widget = firstRecharge,
                _invoke = nil,
                _interval = 0.5,}
            elseif __lua_project_id == __lua_project_yugioh then 
                self.listButtons_2:addChild(firstRecharge)
                self:refreshActivityListButtonsSize(2)
                state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_recharge",
                _widget = firstRecharge,
                _invoke = nil,
                _interval = 0.5,})
            else
                AcitivityList:addChild(firstRecharge)
                state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_recharge",
                _widget = firstRecharge,
                _invoke = nil,
                _interval = 0.5,})
            end
		end
	end

	--七日活动
    local sevenDayAty = nil
    if _ED.active_activity[42] ~= nil then
        sevenDayAty = ActivityIconCell:createCell()
        sevenDayAty:init(sevenDayAty.enum_type.ACTIVITY_SEVEN_DAY_ICON)
        if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
            sevenDayAty._notification = { _terminal_name = "push_notification_center_activity_main_page_seven_days_activity",
            _widget = sevenDayAty,
            _invoke = nil,
            _interval = 0.5,}
        elseif __lua_project_id == __lua_project_yugioh then 
            self.listButtons_2:addChild(sevenDayAty)
            self:refreshActivityListButtonsSize(2)

            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_main_page_seven_days_activity",
            _widget = sevenDayAty,
            _invoke = nil,
            _interval = 0.5,})
            protocol_command.week_active_init.param_list = "".._ED.active_activity[42].activity_day_count
            NetworkManager:register(protocol_command.week_active_init.code, nil, nil, nil, nil, nil, false, nil)
        else
            AcitivityList:addChild(sevenDayAty)

            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_main_page_seven_days_activity",
            _widget = sevenDayAty,
            _invoke = nil,
            _interval = 0.5,})
        end
    end

    if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
    else
        if _ED.active_activity[78] ~= nil then 
            local topRank = ActivityIconCell:createCell()
            topRank:init(topRank.enum_type.ACTIVITY_TOP_RANK)
            AcitivityListTwo:addChild(topRank)
        end
        if _ED.active_activity[80] ~= nil then 
            local onlineRank = ActivityIconCell:createCell()
            onlineRank:init(onlineRank.enum_type.ACTIVITY_ONLINE_REWARD)
            AcitivityListTwo:addChild(onlineRank)
        end
    end
    
	--开服基金
    local seveFundAty = nil
    local needlevel = 0
    if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
        needlevel = dms.int(dms["fun_open_condition"], 150, fun_open_condition.level)
    else
        needlevel = 0
        if tonumber(_ED.user_info.user_grade) >= needlevel then
        	if _ED.active_activity[27] ~= nil then
                seveFundAty = ActivityIconCell:createCell()
                seveFundAty:init(seveFundAty.enum_type.ACTIVITY_SEVEN_DAY_TWO_ICONTWO)
                if __lua_project_id == __lua_project_gragon_tiger_gate
                    -- or __lua_project_id == __lua_project_l_digital
                    -- or __lua_project_id == __lua_project_l_pokemon 
                    or __lua_project_id == __lua_project_l_naruto 
                    or __lua_project_id == __lua_project_red_alert
                    then
                    seveFundAty._notification = { _terminal_name = "push_notification_center_activity_open_server_activity",
                    _widget = seveFundAty,
                    _invoke = nil,
                    _interval = 0.5,}
                elseif __lua_project_id == __lua_project_yugioh then 
                    self.listButtons_1:addChild(seveFundAty)
                    self:refreshActivityListButtonsSize(1)
                    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_open_server_activity",
                    _widget = seveFundAty,
                    _invoke = nil,
                    _interval = 0.5,})
                else
                    AcitivityList:addChild(seveFundAty)
                    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_open_server_activity",
                    _widget = seveFundAty,
                    _invoke = nil,
                    _interval = 0.5,})
                end
            end
        end
    end
	
	if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
    else
    	local isReward = false
        local rewardCentre = nil
    	if _ED._reward_centre == nil or _ED._reward_centre == "" or #_ED._reward_centre == 0 then
    		_ED._reward_centre = nil
    		_ED._reward_centre = {}
    		local function responsePropCompoundCallback(response)
    			if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
    				isReward = true
    			end
    		end
    		NetworkManager:register(protocol_command.reward_center_init.code, nil, nil, nil, nil, responsePropCompoundCallback, false, nil)
    	else
    		rewardCentre = ActivityIconCell:createCell()
    		rewardCentre:init(rewardCentre.enum_type.ACTIVITY_GAIN_REWARD_ICON)
            if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_red_alert then
                rewardCentre._notification = { _terminal_name = "push_notification_center_activity_the_center_of_the_award",
                _widget = rewardCentre,
                _invoke = nil,
                _interval = 0.5,}
            elseif __lua_project_id == __lua_project_yugioh then 
                self.listButtons_2:addChild(rewardCentre)
                self:refreshActivityListButtonsSize(2)
                state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_the_center_of_the_award",
                _widget = rewardCentre,
                _invoke = nil,
                _interval = 0.5,})
            else
                AcitivityList:addChild(rewardCentre)
                state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_the_center_of_the_award",
                _widget = rewardCentre,
                _invoke = nil,
                _interval = 0.5,})
            end
    		rewardCentre.item = "reward"
    	end
    	
    	--领奖中心
    	if isReward == true then
    		if #_ED._reward_centre > 0 then
    			rewardCentre = ActivityIconCell:createCell()
    			rewardCentre:init(rewardCentre.enum_type.ACTIVITY_GAIN_REWARD_ICON)
                if __lua_project_id == __lua_project_gragon_tiger_gate
			or __lua_project_id == __lua_project_red_alert
                    then
                    rewardCentre._notification = { _terminal_name = "push_notification_center_activity_the_center_of_the_award",
                    _widget = rewardCentre,
                    _invoke = nil,
                    _interval = 0.5,}
                elseif __lua_project_id == __lua_project_yugioh then 
                    self.listButtons_2:addChild(rewardCentre)
                    self:refreshActivityListButtonsSize(2)
                    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_the_center_of_the_award",
                    _widget = rewardCentre,
                    _invoke = nil,
                    _interval = 0.5,})
                else
                    AcitivityList:addChild(rewardCentre)
                    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_the_center_of_the_award",
                    _widget = rewardCentre,
                    _invoke = nil,
                    _interval = 0.5,})
                end
    			rewardCentre.item = "reward"
    		end
    	end
    end
	

    local rechargeRecharge = nil
	if __lua_project_id == __lua_project_gragon_tiger_gate 
        or __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon 
        or __lua_project_id == __lua_project_l_naruto 
        or __lua_project_id == __lua_project_red_alert 
        or __lua_project_id == __lua_project_legendary_game 
        then			--龙虎门项目控制
		rechargeRecharge = ActivityIconCell:createCell()
		rechargeRecharge:init(rechargeRecharge.enum_type.ACTIVITY_HOME_RECHARGE_BUTTON)
        if __lua_project_id == __lua_project_gragon_tiger_gate 
            or __lua_project_id == __lua_project_l_digital 
            or __lua_project_id == __lua_project_l_pokemon 
            or __lua_project_id == __lua_project_l_naruto 
            or __lua_project_id == __lua_project_red_alert 
            then
        else
            AcitivityList:addChild(rechargeRecharge)
        end
        self:refreshActivityListViewSize()
	end
	
	-- local __layout = ccui.Helper:seekWidgetByName(root, "Panel_128")
	
    local mysteryShop = nil
    if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon 
        or __lua_project_id == __lua_project_l_naruto 
        then
    elseif __lua_project_id == __lua_project_warship_girl_b 
        or __lua_project_id == __lua_project_digimon_adventure 
        or __lua_project_id == __lua_project_naruto 
        or __lua_project_id == __lua_project_pokemon 
        or __lua_project_id == __lua_project_rouge 
        or __lua_project_id == __lua_project_yugioh 
    	or __lua_project_id == __lua_project_warship_girl_a 
    	or __lua_project_id == __lua_project_koone
        or __lua_project_id == __lua_project_gragon_tiger_gate 
        or __lua_project_id == __lua_project_red_alert
        then
		--神秘船坞
		mysteryShop = ActivityIconCell:createCell()
        local openLevel = dms.int(dms["fun_open_condition"], 77, fun_open_condition.level)
        if openLevel > 0 then
            --商店扩展
            mysteryShop:init(mysteryShop.enum_type.ACTIVITY_HOME_SHOP_EX)
        else
            mysteryShop:init(mysteryShop.enum_type.ACTIVITY_HOME_MYSTERY_SHOP)
        end
		
        if __lua_project_id == __lua_project_gragon_tiger_gate
		or __lua_project_id == __lua_project_red_alert
            then
            mysteryShop._notification = { _terminal_name = "push_notification_center_activity_click_hero_shop",
            _widget = mysteryShop,
            _invoke = nil,
            _interval = 0.5,}
        elseif __lua_project_id == __lua_project_yugioh then 
            self.listButtons_2:addChild(mysteryShop)
            self:refreshActivityListButtonsSize(2)
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_click_hero_shop",
            _widget = mysteryShop,
            _invoke = nil,
            _interval = 0.5,})
        else
            AcitivityListTwo:addChild(mysteryShop)
			-- __layout:addChild(mysteryShop)
			-- mysteryShop:setPosition(cc.p(170, 20))
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_click_hero_shop",
            _widget = mysteryShop,
            _invoke = nil,
            _interval = 0.5,})
        end
    end

    if __lua_project_id == __lua_project_digimon_adventure 
        or __lua_project_id == __lua_project_pokemon
		then
        --限时优惠
        local limit = ActivityIconCell:createCell()
        limit:init(limit.enum_type.ACTIVITY_LIMIT_TIME_COUPONS)
        AcitivityListTwo:addChild(limit)
    elseif __lua_project_id == __lua_project_gragon_tiger_gate
        then  
        local limit = ActivityIconCell:createCell()
        limit:init(limit.enum_type.ACTIVITY_LIMIT_TIME_COUPONS)
        local panel_limit = ccui.Helper:seekWidgetByName(root, "Panel_limit")
        if panel_limit ~= nil then 
            panel_limit:removeAllChildren(true)
            panel_limit:addChild(limit)
        end
    end

    --等级礼包
    if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
    else
        local levelGift = dms.int(dms["fun_open_condition"], 78, fun_open_condition.level)
        if levelGift > 0 and zstring.tonumber(_ED.user_info.user_grade) > levelGift then 
           local levelGiftCell = ActivityIconCell:createCell()
           levelGiftCell:init(levelGiftCell.enum_type.ACTIVITY_LEVEL_GIFT_HOME)
            if __lua_project_id == __lua_project_gragon_tiger_gate
                then 
                AcitivityList:addChild(levelGiftCell)
            else
                AcitivityListTwo:addChild(levelGiftCell)  
            end
        end
    end
    
    if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
        then
        local Landingreword = nil
        Landingreword = ActivityIconCell:createCell()
        if _ED.active_activity[24] ~= nil then
            Landingreword:init(Landingreword.enum_type.ACTIVITY_LANDING_REWORD)
            -- AcitivityList:addChild(Landingreword)  
            Landingreword._notification = { _terminal_name = "push_notification_activity_login_reward",
                _widget = Landingreword,
                _invoke = nil,
                _interval = 0.5,}
        end

        --金币砸金蛋
        local smokedeggs = nil
        if _ED.active_activity[87] ~= nil then
            smokedeggs1 = ActivityIconCell:createCell()
            smokedeggs1:init(smokedeggs1.enum_type.ACTIVITY_SM_SMOKEDEGGS_1)
            -- AcitivityList:addChild(smokedeggs1)  
        end
        --钻石砸金蛋
        if _ED.active_activity[88] ~= nil then
            smokedeggs2 = ActivityIconCell:createCell()
            smokedeggs2:init(smokedeggs2.enum_type.ACTIVITY_SM_SMOKEDEGGS_2)
            -- AcitivityList:addChild(smokedeggs2)  
        end

        --全服排名活动
        local fullServiceRankings = nil
        if _ED.active_activity[86] ~= nil then
            if funOpenDrawTip(156, false) == false then
                fullServiceRankings = ActivityIconCell:createCell()
                fullServiceRankings:init(fullServiceRankings.enum_type.ACTIVITY_SM_FULL_SERVICE_RANKINGS)
                -- AcitivityList:addChild(fullServiceRankings)  
            end
        end

        --月卡福利
        local monthCardWelfare = nil
        monthCardWelfare = ActivityIconCell:createCell()
        monthCardWelfare:init(monthCardWelfare.enum_type.ACTIVITY_SM_ON_CARD)
        -- AcitivityList:addChild(fullServiceRankings)  

        --vip礼包
        local HomeVipPacks = nil
        HomeVipPacks = ActivityIconCell:createCell()
        HomeVipPacks:init(HomeVipPacks.enum_type.ACTIVITY_SM_VIP_PACKS)

        local items = {}
        local itemsTwo = {}
        table.insert(items, firstRecharge)    -- 首充
        if firstRecharge == nil then
            local m_isVisible = false
            for i,v in pairs(_ED.month_card) do
                if tonumber(v.surplus_month_card_time) == 0 then
                    m_isVisible = true
                end
            end
            if m_isVisible == true then
                table.insert(items, monthCardWelfare)    -- 月卡福利
            else
                table.insert(items, HomeVipPacks)           --vip礼包
            end
        end

        -- 大耳有福，天使送礼
        local welcomeMoneyMan = nil
        if _ED.active_activity[14] ~= nil then
            if funOpenDrawTip(163, false) == false then
                welcomeMoneyMan = ActivityIconCell:createCell()
                welcomeMoneyMan:init(welcomeMoneyMan.enum_type.ACTIVITY_SM_DAERYOUFU)
                -- AcitivityList:addChild(welcomeMoneyMan)  
            end
        end

        -- 限时宝箱
        local limitedTimeBox = nil
        if _ED.active_activity[89] ~= nil then
            if funOpenDrawTip(164, false) == false then
                limitedTimeBox = ActivityIconCell:createCell()
                limitedTimeBox:init(limitedTimeBox.enum_type.ACTIVITY_SM_LIMITED_TIME_BOX)
                -- AcitivityList:addChild(limitedTimeBox)  
                limitedTimeBox._notification = { _terminal_name = "push_notification_center_activity_the_center_sm_limited_time_box",
                    _widget = limitedTimeBox,
                    _invoke = nil,
                    _interval = 0.5,}
            end
        end
        table.insert(items, rechargeRecharge)    -- 充值
        table.insert(items, activityIcon)    -- 活动
        table.insert(items, Landingreword)    -- 登陆奖励
        table.insert(items, seveFundAty)    -- 开服基金
        table.insert(items, limitedTimeBox)    -- 限时宝箱
        table.insert(itemsTwo, sevenDayAty)    -- 七日活动
        table.insert(itemsTwo, smokedeggs1)    -- 钻石砸金蛋
        table.insert(itemsTwo, smokedeggs2)    -- 金币砸金蛋
        table.insert(itemsTwo, fullServiceRankings)    -- 全服排名活动
        table.insert(itemsTwo, welcomeMoneyMan)    -- 大耳有福活动



        if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon 
        then
            if AcitivityList._x == nil then
                AcitivityList._x = AcitivityList:getPositionX()
            end
            AcitivityList:setPositionX(AcitivityList._x)
            AcitivityList:setScaleX(-1)
            AcitivityList:setPositionX(AcitivityList._x+AcitivityList:getContentSize().width-100)
        end
        for i, v in pairs(items) do
            if v ~= nil then
                AcitivityList:addChild(v)
                if __lua_project_id == __lua_project_l_digital 
                or __lua_project_id == __lua_project_l_pokemon 
                then
                    v:setScaleX(-1)
                end
                -- AcitivityList:getInnerContainer():setPositionX(v:getContentSize().width*index)
                if v._notification ~= nil then
                    state_machine.excute("push_notification_center_manager", 0, v._notification)
                end
            end
        end
        local AcitivityListTwo = ccui.Helper:seekWidgetByName(root, "ListView_2")
        AcitivityListTwo:removeAllItems()
        if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon 
        then
            if AcitivityListTwo._x == nil then
                AcitivityListTwo._x = AcitivityListTwo:getPositionX()
            end
            AcitivityListTwo:setPositionX(AcitivityListTwo._x)
            AcitivityListTwo:setScaleX(-1)
            AcitivityListTwo:setPositionX(AcitivityListTwo._x+AcitivityListTwo:getContentSize().width-100)
        end
        for i, v in pairs(itemsTwo) do
            if v ~= nil then
                AcitivityListTwo:addChild(v)
                if __lua_project_id == __lua_project_l_digital 
                or __lua_project_id == __lua_project_l_pokemon 
                then
                    v:setScaleX(-1)
                end
                if v._notification ~= nil then
                    state_machine.excute("push_notification_center_manager", 0, v._notification)
                end
            end
        end
    elseif __lua_project_id == __lua_project_gragon_tiger_gate
    	or __lua_project_id == __lua_project_red_alert
        then
        local items = {}
        
        table.insert(items, seveFundAty)    -- 开服基金
        table.insert(items, sevenDayAty)    -- 七日活动
        table.insert(items, mysteryShop)    -- 神秘商店       
        table.insert(items, everyDayJob)    -- 日常任务
        table.insert(items, firstRecharge)    -- 首充
        table.insert(items, rechargeRecharge)    -- 充值
        table.insert(items, activityIcon)    -- 活动
        table.insert(items, rewardCentre)    -- 领奖中心
        for i, v in pairs(items) do
            if v ~= nil then
                AcitivityList:addChild(v)
                if v._notification ~= nil then
                    state_machine.excute("push_notification_center_manager", 0, v._notification)
                end
            end
        end
    end
end

function Home:onUpdateDrawEx( ... )
    local root = self.roots[1]
    local Panel_19 = ccui.Helper:seekWidgetByName(root, "Panel_19")
    if Panel_19 ~= nil then
        if _ED.active_activity[99] ~= nil and _ED.active_activity[99] ~= "" 
            or (_ED.active_activity[131] ~= nil and _ED.active_activity[131] ~= "")
            or (_ED.active_activity[132] ~= nil and _ED.active_activity[132] ~= "")
            or (_ED.active_activity[133] ~= nil and _ED.active_activity[133] ~= "")
            or (_ED.active_activity[134] ~= nil and _ED.active_activity[134] ~= "")
            then
            Panel_19:setVisible(true)
        else
            Panel_19:setVisible(false)
        end
    end

    local AcitivityList = ccui.Helper:seekWidgetByName(root, "ListView_1")
    AcitivityList:removeAllItems()
	if __lua_project_id == __lua_project_l_naruto then
	else
		if AcitivityList._x == nil then
			AcitivityList._x = AcitivityList:getPositionX()
		end
		AcitivityList:setPositionX(AcitivityList._x)
		AcitivityList:setScaleX(-1)
		AcitivityList:setPositionX(AcitivityList._x+AcitivityList:getContentSize().width-100)
	end
    local AcitivityListTwo = ccui.Helper:seekWidgetByName(root, "ListView_2")
    AcitivityListTwo:removeAllItems()
	if __lua_project_id == __lua_project_l_naruto then
	else
		if AcitivityListTwo._x == nil then
			AcitivityListTwo._x = AcitivityListTwo:getPositionX()
		end
		AcitivityListTwo:setPositionX(AcitivityListTwo._x)
		AcitivityListTwo:setScaleX(-1)
		AcitivityListTwo:setPositionX(AcitivityListTwo._x+AcitivityListTwo:getContentSize().width-100)
	end
    --活动
    local activityIcon = ActivityIconCell:createCell()
    activityIcon:init(activityIcon.enum_type.ACTIVITY_EXCITING_ICON)
    -- activityIcon._notification = { _terminal_name = "push_notification_center_activity_all",
    -- _widget = activityIcon,
    -- _invoke = nil,
    -- _interval = 0.5,}

    local Buttonlegion = ccui.Helper:seekWidgetByName(root, "Button_legion")
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_union_all",
        _widget = Buttonlegion,
        _invoke = nil,
        _interval = 0.5,})

    --日常任务
    local Button_dailytasks = ccui.Helper:seekWidgetByName(root, "Button_dailytasks")
    fwin:addTouchEventListener(Button_dailytasks, nil, 
    {
        terminal_name = "activity_every_day_button", 
        terminal_state = 0, 
        isPressedActionEnabled = true
    },
    nil,0)
    state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_main_page_daily_activity",
        _widget = Button_dailytasks,
        _invoke = nil,
        _interval = 0.5,})

    local firstRecharge = nil
    --首充
    if nil ~= _ED.active_activity[4] then
        firstRecharge = ActivityIconCell:createCell()
        firstRecharge:init(firstRecharge.enum_type.ACTIVITY_HOME_FIRST_RECHARGE_ICON)
        if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
            if firstRecharge:getChildByTag(1025) == nil then
                app.load("client.l_digital.cells.activity.wonderful.sm_first_charge_qibao_cell")
                local qipao = SmFirstChargeQibaoCell:createCell()
				qipao:init()
                qipao:setTag(1025)
                firstRecharge:addChild(qipao)
            end
        end
       -- firstRecharge._notification = { _terminal_name = "push_notification_center_activity_recharge",
       --  _widget = firstRecharge,
       --  _invoke = nil,
       --  _interval = 0.5,}
    end

    --七日活动
    local sevenDayAty = nil
    if _ED.active_activity[42] ~= nil then
        sevenDayAty = ActivityIconCell:createCell()
        sevenDayAty:init(sevenDayAty.enum_type.ACTIVITY_SEVEN_DAY_ICON)
    end

    --开服基金
    local seveFundAty = nil
    -- if __lua_project_id == __lua_project_l_naruto then
        local needlevel = dms.int(dms["fun_open_condition"], 150, fun_open_condition.level)

        if tonumber(_ED.user_info.user_grade) >= needlevel then
            if _ED.active_activity[27] ~= nil then
                local is_show = false
                for j, w in pairs(_ED.active_activity[27].activity_Info) do
                    if tonumber(w.activityInfo_isReward) == 0 then
                        is_show = true
                        break
                    end
                end
                if is_show == true then
                    seveFundAty = ActivityIconCell:createCell()
                    seveFundAty:init(seveFundAty.enum_type.ACTIVITY_SEVEN_DAY_TWO_ICONTWO)
                    -- seveFundAty._notification = { _terminal_name = "push_notification_center_activity_open_server_activity",
                    --     _widget = seveFundAty,
                    --     _invoke = nil,
                    --     _interval = 0.5,}
                end
            end
        end
    -- end

    -- self:refreshActivityListViewSize()
    local Landingreword = nil
    -- if __lua_project_id == __lua_project_l_naruto then
        if _ED.active_activity[24] ~= nil then
            local is_show = false
            for k, v in pairs(_ED.active_activity[24].activity_Info) do
                if tonumber(v.activityInfo_isReward) == 0 then
                    is_show = true
                end
            end
            if is_show == true then
                Landingreword = ActivityIconCell:createCell()
                if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
                    Landingreword:init(Landingreword.enum_type.ACTIVITY_HOME_LANDING_REWORD)
                else
                    Landingreword:init(Landingreword.enum_type.ACTIVITY_LANDING_REWORD)
                end
                -- Landingreword._notification = { _terminal_name = "push_notification_activity_login_reward",
                --     _widget = Landingreword,
                --     _invoke = nil,
                --     _interval = 0.5,}
            end
        end
    -- end

    --金币砸金蛋
    local smokedeggs1 = nil
    if _ED.active_activity[87] ~= nil then
        smokedeggs1 = ActivityIconCell:createCell()
        smokedeggs1:init(smokedeggs1.enum_type.ACTIVITY_SM_SMOKEDEGGS_1)
    end
    --钻石砸金蛋
    local smokedeggs2 = nil
    if _ED.active_activity[88] ~= nil then
        smokedeggs2 = ActivityIconCell:createCell()
        smokedeggs2:init(smokedeggs2.enum_type.ACTIVITY_SM_SMOKEDEGGS_2)
    end
    --全服排名活动
    local fullServiceRankings = nil
    if _ED.active_activity[86] ~= nil then
        if funOpenDrawTip(156, false) == false then
            fullServiceRankings = ActivityIconCell:createCell()
            fullServiceRankings:init(fullServiceRankings.enum_type.ACTIVITY_SM_FULL_SERVICE_RANKINGS)
        end
    end

    -- 大耳有福
    local welcomeMoneyMan = nil
    if _ED.active_activity[14] ~= nil then
        if funOpenDrawTip(163, false) == false then
            state_machine.excute("push_notification_center_activity_the_center_sm_activity_update", 0, 14)
            welcomeMoneyMan = ActivityIconCell:createCell()
            welcomeMoneyMan:init(welcomeMoneyMan.enum_type.ACTIVITY_SM_DAERYOUFU)
        end
    end
    -- 限时宝箱，限时神兽
    local limitedTimeBox = nil
    if _ED.active_activity[89] ~= nil then
        if funOpenDrawTip(164, false) == false then
            limitedTimeBox = ActivityIconCell:createCell()
            limitedTimeBox:init(limitedTimeBox.enum_type.ACTIVITY_SM_LIMITED_TIME_BOX)
            -- limitedTimeBox._notification = { _terminal_name = "push_notification_center_activity_the_center_sm_limited_time_box",
            --     _widget = limitedTimeBox,
            --     _invoke = nil,
            --     _interval = 0.5,}
        end
    end
    -- 充值返钻
    local rechargeReturnGold = nil
    if _ED.active_activity[107] ~= nil then
        state_machine.excute("push_notification_center_activity_the_center_sm_activity_update", 0, 107)
        rechargeReturnGold = ActivityIconCell:createCell()
        rechargeReturnGold:init(rechargeReturnGold.enum_type.ACTIVITY_SM_RECHARGE_RETURN_REWARD)
    end

    -- 神兽来袭
    local otherRecruitActivity = nil
    if _ED.active_activity[114] ~= nil then
        local activity_info = _ED.active_activity[114]
        local info = zstring.split(zstring.split(activity_info.need_recharge_count, "@")[4], ",")
        if zstring.tonumber(_ED.vip_grade) >= tonumber(info[2]) then
            state_machine.excute("push_notification_center_activity_the_center_sm_activity_update", 0, 114)
            otherRecruitActivity = ActivityIconCell:createCell()
            otherRecruitActivity:init(otherRecruitActivity.enum_type.ACTIVITY_SM_OTHER_RECRUIT_ACTIVITY)
        end
    end

    -- 愚人节：节日道具兑换活动
    local festivalExchange = nil
    if _ED.active_activity[121] ~= nil then
        festivalExchange = ActivityIconCell:createCell()
        festivalExchange:init(festivalExchange.enum_type.ACTIVITY_FESTIVAL_EXCHNAGE_1)
    end

    local activityActive = nil
    if funOpenDrawTip(180, false) == false then
        state_machine.excute("push_notification_center_activity_the_center_sm_activity_update", 0, 10000)
        activityActive = ActivityIconCell:createCell()
        activityActive:init(activityActive.enum_type.ACTIVITY_SM_ACTIVE)
    end

    local items = {}
    local itemsTwo = {}
	if __lua_project_id == __lua_project_l_naruto then
		table.insert(items, firstRecharge)    -- 首充
		if firstRecharge == nil then
			local m_isVisible = false
			for i,v in pairs(_ED.month_card) do
				if tonumber(v.surplus_month_card_time) == 0 then
					m_isVisible = true
				end
			end
			if m_isVisible == true then
				local monthCardWelfare = ActivityIconCell:createCell()
				monthCardWelfare:init(monthCardWelfare.enum_type.ACTIVITY_SM_ON_CARD)
				table.insert(items, monthCardWelfare)    -- 月卡福利
			end
				local HomeVipPacks = ActivityIconCell:createCell()
				HomeVipPacks:init(HomeVipPacks.enum_type.ACTIVITY_SM_VIP_PACKS)
				table.insert(items, HomeVipPacks)           --vip礼包
			-- end
		end
		local rechargeRecharge = ActivityIconCell:createCell()
		rechargeRecharge:init(rechargeRecharge.enum_type.ACTIVITY_HOME_RECHARGE_BUTTON)
		table.insert(items, rechargeRecharge)    -- 充值
        table.insert(items, activityIcon)    -- 活动
        if Landingreword ~= nil then
			table.insert(items, Landingreword)    -- 登陆奖励
		end
        if seveFundAty ~= nil then
			table.insert(items, seveFundAty)    -- 开服基金-
		end
        table.insert(items, limitedTimeBox)    -- 限时宝箱-
        table.insert(itemsTwo, sevenDayAty)    -- 七日活动
        table.insert(itemsTwo, smokedeggs1)    -- 钻石砸金蛋-
        table.insert(itemsTwo, smokedeggs2)    -- 金币砸金蛋-
        table.insert(itemsTwo, fullServiceRankings)    -- 全服排名活动-
        table.insert(itemsTwo, welcomeMoneyMan)    -- 大耳有福活动
	else
		table.insert(items, firstRecharge)    -- 首充
		if firstRecharge == nil then
			local m_isVisible = false
			for i,v in pairs(_ED.month_card) do
				if tonumber(v.surplus_month_card_time) == 0 then
					m_isVisible = true
				end
			end
			if m_isVisible == true then
				local monthCardWelfare = ActivityIconCell:createCell()
				monthCardWelfare:init(monthCardWelfare.enum_type.ACTIVITY_SM_ON_CARD)
				table.insert(items, monthCardWelfare)    -- 月卡福利
			else
                -- 如果已经到了18级，则显示充值按钮
                if __lua_project_id == __lua_project_l_digital and tonumber(_ED.vip_grade) == tonumber(_vip_max_grade[1]) then
                    local HomeChongzhi = ActivityIconCell:createCell()
                    HomeChongzhi:init(HomeChongzhi.enum_type.ACTIVITY_HOME_RECHARGE_BUTTON)
                    table.insert(items, HomeChongzhi)
                else
                    -- vip礼包
                    local HomeVipPacks = ActivityIconCell:createCell()
                    HomeVipPacks:init(HomeVipPacks.enum_type.ACTIVITY_SM_VIP_PACKS)
                    table.insert(items, HomeVipPacks)
                end
			end
		end

        table.insert(items, activityIcon)    -- 活动

		table.insert(itemsTwo, smokedeggs1)    -- 金币砸金蛋
		table.insert(itemsTwo, smokedeggs2)    -- 钻石砸金蛋

        if otherRecruitActivity ~= nil then
            table.insert(itemsTwo, otherRecruitActivity)    -- 机械邪龙兽来袭
        end

		table.insert(itemsTwo, limitedTimeBox)    -- 限时神兽
        table.insert(itemsTwo, welcomeMoneyMan)    -- 大耳有福活动，天使送礼

        if __lua_project_id == __lua_project_l_digital then
            if seveFundAty ~= nil then
                table.insert(itemsTwo, seveFundAty)    -- 开服基金
            end
        end

		table.insert(itemsTwo, fullServiceRankings)    -- 全服排名活动

        table.insert(itemsTwo, sevenDayAty)    -- 七日活动，开服狂欢

        if __lua_project_id == __lua_project_l_digital then
            if Landingreword ~= nil then
                table.insert(itemsTwo, Landingreword)    -- 登陆奖励
            end
        end

	end

    -- 火影
    if __lua_project_id == __lua_project_l_naruto then
        table.insert(itemsTwo, festivalExchange)    -- 节日道具兑换活动

        if rechargeReturnGold ~= nil then
            table.insert(itemsTwo, rechargeReturnGold)    -- 充值返钻
        end

        if otherRecruitActivity ~= nil then
            table.insert(itemsTwo, otherRecruitActivity)    -- 机械邪龙兽来袭
        end
    end

    -- 活跃度
    if activityActive ~= nil then
        if __lua_project_id == __lua_project_l_digital then
            table.insert(items, activityActive)    
        else
            table.insert(itemsTwo, activityActive)
        end
    end

    if __lua_project_id == __lua_project_l_digital then
        -- 任务
        Button_dailytasks:setVisible(false)
        local btnTask = ccui.Button:create("images/ui/home/activity_everyday.png", "images/ui/home/activity_everyday.png", "images/ui/home/activity_everyday.png", 1)
        btnTask:setName("btnTask")
        local nodeTask = ccui.Widget:create()
        nodeTask:setContentSize(cc.size(80, 90))
        nodeTask:setAnchorPoint(cc.p(0, 0))
        btnTask:setPosition(cc.p(nodeTask:getContentSize().width / 2, nodeTask:getContentSize().height / 2 + 2))
        nodeTask:addChild(btnTask)
        table.insert(items, nodeTask)

        fwin:addTouchEventListener(btnTask, nil, 
        {
            terminal_name = "activity_every_day_button", 
            terminal_state = 0, 
            isPressedActionEnabled = true
        },
        nil, 0)
        state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_main_page_daily_activity",
        _widget = btnTask,
        _invoke = nil,
        _interval = 0.5,})
    end

    -- 如果第二行显示超过10个，则换行
    local itemsTwo2 = {}

    if __lua_project_id == __lua_project_l_digital and festivalExchange ~= nil then
        if #itemsTwo == 9 then
            table.insert(itemsTwo2, festivalExchange)
        elseif #itemsTwo < 9 then
            table.insert(itemsTwo, 1, festivalExchange)    -- 节日道具兑换活动
        end
    end

    if __lua_project_id == __lua_project_l_digital and rechargeReturnGold ~= nil then
        if #itemsTwo == 9 then
            table.insert(itemsTwo2, rechargeReturnGold)
        elseif #itemsTwo < 9 then
            table.insert(itemsTwo, 1, rechargeReturnGold)    -- 充值返利
        end
    end

    local copy_items = {}
    for i=#items, 1,-1 do
        table.insert(copy_items, items[i])
    end
    items = copy_items

    local copy_items_two = {}
    for i=#itemsTwo, 1,-1 do
        table.insert(copy_items_two, itemsTwo[i])
    end
    itemsTwo = copy_items_two

    if __lua_project_id == __lua_project_l_digital then
        AcitivityList:setPositionX(AcitivityListTwo:getPositionX())
    end

    for i, v in pairs(items) do
        if v ~= nil then
            AcitivityList:addChild(v)
			if __lua_project_id == __lua_project_l_naruto then
			else
				v:setScaleX(-1)
			end
            if v._notification ~= nil then
                state_machine.excute("push_notification_center_manager", 0, v._notification)
            end
        end
    end

    for i, v in pairs(itemsTwo) do
        if v ~= nil then
            AcitivityListTwo:addChild(v)
			if __lua_project_id == __lua_project_l_naruto then
			else
				v:setScaleX(-1)
			end
            if v._notification ~= nil then
                state_machine.excute("push_notification_center_manager", 0, v._notification)
            end
        end
    end

    -- 显示第二列活动
    if #itemsTwo2 > 0 then
        local AcitivityListTwo2 = AcitivityListTwo:clone()
        AcitivityListTwo2:removeAllItems()
        AcitivityListTwo2:setPosition(cc.p(AcitivityListTwo:getPositionX(), AcitivityListTwo:getPositionY() - 80))
        AcitivityListTwo:getParent():addChild(AcitivityListTwo2)

        for i = 1, #itemsTwo2 do
            local item = itemsTwo2[i]
            item:setPosition(cc.p(itemsTwo[i]:getPositionX(), itemsTwo[i]:getPositionY() - 30))
            AcitivityListTwo2:addChild(item)

            if __lua_project_id == __lua_project_l_naruto then
            else
                item:setScaleX(-1)
            end

            if item._notification ~= nil then
                state_machine.excute("push_notification_center_manager", 0, item._notification)
            end
        end
    end

end

function Home:cleanReawrd()
	local root = self.roots[1]
    if __lua_project_id == __lua_project_yugioh then 
        local buttosList = ccui.Helper:seekWidgetByName(root, "Panel_button_list_2")
        for i, v in pairs(buttosList:getChildren()) do
            if v.item == "reward" then
                buttosList:removeChild(v,true)
                self:refreshActivityListButtonsSize(2)
                break
            end
        end
    else
        local AcitivityList = ccui.Helper:seekWidgetByName(root, "ListView_1")
        for i, v in pairs(AcitivityList:getItems()) do
            if v.item == "reward" then
                AcitivityList:removeItem(i-1)
            end
        end
        if __lua_project_id == __lua_project_gragon_tiger_gate
            or __lua_project_id == __lua_project_l_digital
            or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto or __lua_project_id == __lua_project_red_alert then
        else
            self:refreshActivityListViewSize()
        end
    end
end

function Home:updateDrawHeroIntro(_ship_mould_id)
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
        self._ship_mould_id = _ship_mould_id.ship_template_id
    else
        self._ship_mould_id = _ship_mould_id
    end
	
	
    local root = self.roots[1]
    local headId = dms.int(dms["ship_mould"], self._ship_mould_id, ship_mould.bust_index)
    local heroIntroString = dms.string(dms["ship_mould"], self._ship_mould_id, ship_mould.sign_msg)
    local captainName = nil
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
        --进化形象
        local evo_image = dms.string(dms["ship_mould"], self._ship_mould_id, ship_mould.fitSkillTwo)
        local evo_info = zstring.split(evo_image, ",")
        --进化模板id
        local ship_evo = zstring.split(_ship_mould_id.evolution_status, "|")
        local evo_mould_id = evo_info[tonumber(ship_evo[1])]
        local name_mould_id = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.name_index)
        local word_info = dms.element(dms["word_mould"], name_mould_id)
        captainName = word_info[3]
    else
    	captainName = dms.string(dms["ship_mould"], self._ship_mould_id, ship_mould.captain_name)
    end
    local heroHeadPath = ""
    if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then
        heroHeadPath = string.format("images/face/big_head/big_head_%s.png", headId)
    else
        heroHeadPath = string.format("images/face/card_head/card_head_%s.png", headId)
    end
    
    if __lua_project_id == __lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then
        if dms.int(dms["ship_mould"], tonumber(self._ship_mould_id), ship_mould.captain_type) == 0 then
            local fashionEquip, pic = getUserFashion()
            if fashionEquip ~= nil and pic ~= nil then
                if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_pokemon 
                    or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then
                    heroHeadPath = string.format("images/face/big_head/big_head_%s.png", pic)
                else
                    heroHeadPath = string.format("images/face/card_head/card_head_%s.png", pic)
                end
            end
        end
    end
    local heroHeadPanel = ccui.Helper:seekWidgetByName(root, "Panel_card")
    local heroIntro = ccui.Helper:seekWidgetByName(root, "Text_card_11")
    heroHeadPanel:setBackGroundImage(heroHeadPath)
    heroIntro:setString(heroIntroString)
	
	if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
    else
    	if  dms.int(dms["ship_mould"], self._ship_mould_id, ship_mould.captain_type) == 0 then
    		captainName = _ED.user_info.user_name
        end
	end
    if ___is_open_leadname == true then
        if Home.__userHeroFontName == nil then
            Home.__userHeroFontName = ccui.Helper:seekWidgetByName(root, "Text_2"):getFontName()
        end
        if dms.int(dms["ship_mould"], tonumber(self._ship_mould_id), ship_mould.captain_type) == 0 then
            ccui.Helper:seekWidgetByName(root, "Text_2"):setFontName("")
            ccui.Helper:seekWidgetByName(root, "Text_2"):setFontSize(ccui.Helper:seekWidgetByName(root, "Text_2"):getFontSize())-->设置字体大小
        else
            ccui.Helper:seekWidgetByName(root, "Text_2"):setFontName(Home.__userHeroFontName)
        end
    end
	ccui.Helper:seekWidgetByName(root, "Text_2"):setString(captainName)
	
	local quality = dms.int(dms["ship_mould"], self._ship_mould_id, ship_mould.ship_type) + 1
	ccui.Helper:seekWidgetByName(root, "Text_2"):setColor(cc.c3b(tipStringInfo_quality_color_Type[quality][1],tipStringInfo_quality_color_Type[quality][2],tipStringInfo_quality_color_Type[quality][3]))
	
	if self.init_home_effect == 1 then
		self:playHeroEffect()
	else
		self.init_home_effect = 2
	end
	
	
	-- if tempMusicIndex > 0 then
		-- cc.SimpleAudioEngine:getInstance():stopAllEffects()
		-- playEffect(formatMusicFile("effect", tempMusicIndex))
	-- end
end

function Home:updateTargetTaskState( ... )
    local root = self.roots[1]
    local Panel_2 = ccui.Helper:seekWidgetByName(root, "Panel_2")
    if _ED.targetAchieveId == nil then
        _ED.targetAchieveId = zstring.tonumber(dms.int(dms["user_config"], 16, user_config.param))
    end
    local current_target_id = 0
    if _ED.targetAchieveId > 0 then
        for k,v in pairs(_ED.all_achieve) do
            if k >= tonumber(_ED.targetAchieveId) then
                if tonumber(v) >= 0 then
                    current_target_id = k
                    break
                end
            end
        end
    end
    if Panel_2 ~= nil then
        Panel_2:setVisible(true)
        if current_target_id > 0 then
            _ED.targetAchieveId = current_target_id
            local Panel_3 = ccui.Helper:seekWidgetByName(root, "Panel_3")
            local Panel_4 = ccui.Helper:seekWidgetByName(root, "Panel_4")
            local ArmatureNode_3 = Panel_2:getChildByName("ArmatureNode_3")
            ArmatureNode_3:setVisible(false)
            local complete = _ED.all_achieve[tonumber(_ED.targetAchieveId)]
            local max = dms.int(dms["achieve"], _ED.targetAchieveId, achieve.param2)
            local track_address = dms.string(dms["achieve"], _ED.targetAchieveId, achieve.track_address)
            track_address = zstring.split(zstring.split(track_address, "|")[1], ",")
            Panel_3:setBackGroundImage("images/ui/text/task/mbrw_icon_"..track_address[1]..".png")
            Panel_4:setBackGroundImage("images/ui/text/task/mbrw_name_"..track_address[2]..".png")
            if tonumber(complete) >= max then
                ArmatureNode_3:setVisible(true)
            end
        else
            _ED.targetAchieveId = -1
            Panel_2:setVisible(false)
        end
    end
end

function Home:playHeroEffect()
	local _ship_mould_id = self._ship_mould_id
	if nil == _ship_mould_id then
		return
	end
	local tempMusicIndex = dms.int(dms["ship_mould"], _ship_mould_id, ship_mould.sound_index)
	if self.id == nil then
		 self.id = _ship_mould_id
		if tempMusicIndex > 0 then
			playEffect(formatMusicFile("effect", tempMusicIndex))
		end
	elseif self.id == _ship_mould_id then
		cc.SimpleAudioEngine:getInstance():stopAllEffects()
	else
		self.id = _ship_mould_id
		if tempMusicIndex > 0 then
			playEffect(formatMusicFile("effect", tempMusicIndex))
		end
	end
end


function Home:onEnterTransitionFinish()
    local csbHome = csb.createNode("home/home_button.csb")
    local root = csbHome:getChildByName("root")
    table.insert(self.roots, root)
    local action = csb.createTimeline("home/home_button.csb")
    csbHome:runAction(action)
    -- action:gotoFrameAndPlay(0, action:getDuration(), false)
	-- action:play("Panel_button_1_tonch", false)
	self.action = action
    self:addChild(csbHome)

    if __lua_project_id == __lua_project_adventure then
        -- 讨论区
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_taolunqu"),       nil, 
        {
            terminal_name = "home_adventure_forum",
            current_button_name = "Button_taolunqu",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)
        if zstring.tonumber(_game_platform_version_type) == 3 then
            if zstring.tonumber(_ED.server_review) == 0 then  -- 0 
                ccui.Helper:seekWidgetByName(root, "Button_fanpage"):setVisible(true)
            else
                ccui.Helper:seekWidgetByName(root, "Button_fanpage"):setVisible(false)
            end
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_fanpage"),       nil, 
            {
                terminal_name = "home_adventure_fanpage",
                current_button_name = "Button_fanpage",        
                terminal_state = 0, 
                isPressedActionEnabled = true
            }, 
            nil, 0)
        end
        

        -- 礼包
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_libao"),       nil, 
        {
            terminal_name = "home_adventure_gift_bag",
            current_button_name = "Button_libao",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)

        -- 好友
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_haoyou"),       nil, 
        {
            terminal_name = "home_adventure_friends",
            current_button_name = "Button_haoyou",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)
        if __lua_project_id == __lua_project_adventure then
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_adventure_home_friend",
                _widget = ccui.Helper:seekWidgetByName(root, "Button_haoyou"),
                _invoke = nil,
                _interval = 0.5,})
        end

        -- 设置
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_shezhi"),       nil, 
        {
            terminal_name = "home_adventure_system_set",
            current_button_name = "Button_shezhi",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)

        -- 商店
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_shangdian"),       nil, 
        {
            terminal_name = "home_adventure_shop",
            current_button_name = "Button_shangdian",        
            terminal_state = 0, 
            isPressedActionEnabled = true
			
        }, 
        nil, 0)
		
		 -- 更多
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_more"),       nil, 
        {
            terminal_name = "home_adventure_more_system",
            current_button_name = "Button_more",        
            terminal_state = 0, 
            isPressedActionEnabled = true
			
        }, 
        nil, 0)
		
		if __lua_project_id == __lua_project_adventure then
			state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_adventure_more",
                _widget = ccui.Helper:seekWidgetByName(root, "Button_more"),
                _invoke = nil,
                _interval = 0.5,})
		end

        -- 签到
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_qiandao"),       nil, 
        {
            terminal_name = "home_adventure_sign_in",
            current_button_name = "Button_qiandao",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)

        -- 月卡
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_yueka"),       nil, 
        {
            terminal_name = "home_adventure_month_card",
            current_button_name = "Button_yueka",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)
		if __lua_project_id == __lua_project_adventure then
			state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_adventure_home_mothcard",
                _widget = ccui.Helper:seekWidgetByName(root, "Button_yueka"),
                _invoke = nil,
                _interval = 0.5,})
		end
		
        -- 活动
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_huodong"),       nil, 
        {
            terminal_name = "home_adventure_activity",
            current_button_name = "Button_huodong",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)
		if __lua_project_id == __lua_project_adventure then
			state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_adventure_achievement_activity",
                _widget = ccui.Helper:seekWidgetByName(root, "Button_huodong"),
                _invoke = nil,
				_current_type = -1,
                _interval = 0.5,})
		end
		
        -- 成就
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_chengjiu"),       nil, 
        {
            terminal_name = "home_adventure_achievement",
            current_button_name = "Button_chengjiu",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)
        if __lua_project_id == __lua_project_adventure then
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_adventure_achievement_update",
             _widget =ccui.Helper:seekWidgetByName(root, "Button_chengjiu"),
             _invoke = nil,
             _current_type = -1,
             _interval = 0.5,})
        end

        -- 黑市
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_heishi"),       nil, 
        {
            terminal_name = "home_adventure_black_market",
            current_button_name = "Button_heishi",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)

        -- 公告
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_gonggao"),       nil, 
        {
            terminal_name = "home_adventure_notice",
            current_button_name = "Button_gonggao",        
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)

        -- 开始冒险
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_start"),       nil, 
        {
            terminal_name = "menu_manager",     
            next_terminal_name = "menu_adventure_avg", 
            current_button_name = "Button_maoxian",
            but_image = "Image_maoxian",         
            terminal_state = 0, 
            isPressedActionEnabled = true
        }, 
        nil, 0)
		state_machine.excute("home_adventure_update_open_condition", 0, nil)
    else
        local Text_tip = ccui.Helper:seekWidgetByName(root, "Text_tip")
        if Text_tip ~= nil then
            if home_duplicate_tips_info ~= nil then
                local lastOpenNpc = 0
                for k,v in pairs(_ED.npc_state) do
                    if tonumber(v) == 0 then
                        lastOpenNpc = k
                        break
                    end
                end
                for k,v in pairs(home_duplicate_tips_info) do
                    if tonumber(v[1]) > lastOpenNpc then
                        Text_tip:setString(v[2])
                        break
                    end
                end
            end
        end

    	self:upDataDraw()
    	if __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh 
    	or __lua_project_id == __lua_project_warship_girl_a 
    	or __lua_project_id == __lua_project_koone
    	then
    		self.AcitivityListTwo = ccui.Helper:seekWidgetByName(root, "ListView_1_2")
    	end
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_richang"),   nil, {terminal_name = "home_manager",   next_terminal_name = "home_click_daily_tasks",                      but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	-- fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_legion"),    nil, {terminal_name = "home_manager",   next_terminal_name = "home_click_union",                            but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
        local Button_mingren = ccui.Helper:seekWidgetByName(root, "Button_mingren")
        --评审状态不显示排行榜
        if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto then 
            if zstring.tonumber(_ED.server_review) ~= 1 then  -- 1评审, 其他非
                Button_mingren:setVisible(true)
            else
                Button_mingren:setVisible(false)
            end
        end

    	fwin:addTouchEventListener(Button_mingren,   nil, {terminal_name = "home_manager",   next_terminal_name = "home_click_fame_hall_manager",                but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_mail"),      nil, {terminal_name = "home_manager",   next_terminal_name = "home_click_email_manager",                    but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_friends"),   nil, {terminal_name = "home_manager",   next_terminal_name = "home_click_friend_manager",                   but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_gaizao"),    nil, {terminal_name = "home_manager",    next_terminal_name = "home_click_recover",                         but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_wujiang"),             nil, {terminal_name = "home_manager",     next_terminal_name = "home_click_generals",             but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true, unload = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_equipment"),           nil, {terminal_name = "home_manager",     next_terminal_name = "home_click_equipment",            but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true, unload = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_baowu"),               nil, {terminal_name = "home_manager",     next_terminal_name = "home_click_treasure",             but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true, unload = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_chongzhi"),            nil, {terminal_name = "home_manager",     next_terminal_name = "home_click_recharge",             but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_vip"),                 nil, {terminal_name = "home_click_vip",     terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_tujian"),              nil, {terminal_name = "home_click_CatalogueStorage", terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_menu"),              nil, {terminal_name = "home_click_install",  terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_chat"),                nil, {terminal_name = "home_click_chat",  terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_7day"),                nil, {terminal_name = "home_manager",     next_terminal_name = "home_click_sevendays_activity",   but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_huozhong"),            nil, {terminal_name = "home_goto_destiny_system", but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)

        if __lua_project_id == __lua_project_yugioh then 
            local wordTreePanel = ccui.Helper:seekWidgetByName(root, "Panel_huozhong")
            wordTreePanel:removeAllChildren(true)
            local animationName = "daiji"
            local jsonFile = "images/ui/effice/effect_ui_king/effect_ui_king.json"
            local atlasFile = "images/ui/effice/effect_ui_king/effect_ui_king.atlas"

            if cc.FileUtils:getInstance():isFileExist(jsonFile) == true then
                local animation = sp.spine(jsonFile, atlasFile, 1, 0, animationName, true, nil)
                wordTreePanel:addChild(animation)
            end
            local animationName = "daiji"
            local jsonFile = "images/ui/effice/effect_ui_chouka/effect_ui_chouka.json"
            local atlasFile = "images/ui/effice/effect_ui_chouka/effect_ui_chouka.atlas"
            local chouKaPanel = ccui.Helper:seekWidgetByName(root, "Panel_ck")
            chouKaPanel:removeAllChildren(true)
            if cc.FileUtils:getInstance():isFileExist(jsonFile) == true then
                local animation = sp.spine(jsonFile, atlasFile, 1, 0, animationName, true, nil)
                chouKaPanel:addChild(animation)
            end
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_chouka"),            nil, {terminal_name = "home_goto_click_recruit", but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)    
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_magic"),             nil, {terminal_name = "home_manager", next_terminal_name = "home_click_magic_card", but_image = "Image_home", terminal_state = 0, isPressedActionEnabled = true, unload = true}, nil, 0)

            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_new_recruit",
            _widget = ccui.Helper:seekWidgetByName(root, "Panel_chouka"),
            _invoke = nil,
            _interval = 0.5,})

            local Button_tujian = ccui.Helper:seekWidgetByName(root, "Button_tujian")
            if Button_tujian ~= nil then
                if tonumber(_ED.server_review) == 1 then
                    Button_tujian:setVisible(false)
                else
                    Button_tujian:setVisible(true)
                end
            end
            
        end
    	if __lua_project_id == __lua_project_gragon_tiger_gate
            or __lua_project_id == __lua_project_l_digital
            or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto or __lua_project_id == __lua_project_red_alert then
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_legion"),            nil, {terminal_name = "home_goto_click_union", but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)    
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_secret"),            nil, {terminal_name = "home_capture_open", but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
        else
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_legion"),            nil, {terminal_name = "home_goto_click_union", but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
        end
        local facebookButton = ccui.Helper:seekWidgetByName(root, "Button_facebook")
        local kefuButton = ccui.Helper:seekWidgetByName(root, "Button_kefu")
        if facebookButton ~= nil then
            fwin:addTouchEventListener(facebookButton, nil, {terminal_name = "home_goto_click_faceBook_url", but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)    
        end
        if kefuButton ~= nil then
            fwin:addTouchEventListener(kefuButton, nil, {terminal_name = "home_goto_click_gm_url", but_image = "Image_home", terminal_state = 0, isPressedActionEnabled = true, unload = true}, nil, 0)
        end
        --战宠 数码
        local button_zc = ccui.Helper:seekWidgetByName(root, "Button_zc")
        if button_zc ~= nil then 
            fwin:addTouchEventListener(button_zc,             nil, {terminal_name = "home_click_pets", but_image = "Image_home", terminal_state = 0, isPressedActionEnabled = true, unload = true}, nil, 0)
        end

        --推荐阵容 数码
        local Button_line = ccui.Helper:seekWidgetByName(root, "Button_line")
        if Button_line ~= nil then 
            fwin:addTouchEventListener(Button_line,             nil, {terminal_name = "home_click_recommend_formation", but_image = "Image_home", terminal_state = 0, isPressedActionEnabled = true, unload = true}, nil, 0)
        end
    	fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_shenjiang2"),          nil, {terminal_name = "home_manager",     next_terminal_name = "home_click_hero_shop",            but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
		-- fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_shenjiang_3"),          nil, {terminal_name = "home_manager",     next_terminal_name = "home_click_hero_shop",            but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
        -- state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_click_hero_shop",
            -- _widget = ccui.Helper:seekWidgetByName(root, "Button_shenjiang_3"),
            -- _invoke = nil,
            -- _interval = 0.5,})
        if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then

        elseif __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_red_alert then
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_capture",
            _widget = ccui.Helper:seekWidgetByName(root, "Button_secret"),
            _invoke = nil,
            _interval = 0.5,})            
        end
		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_exciting_activities"), nil, {terminal_name = "home_manager",     next_terminal_name = "home_click_activity",             but_image = "Image_home",       terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_recharge"), nil, {terminal_name = "home_recharge_activity",terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_gonglue"), nil, {terminal_name = "home_click_strategy",   terminal_state = 0, isPressedActionEnabled = true}, nil, 0)
		
    	if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then
            if zstring.tonumber(_ED.user_info.user_force) == 0
				and missionIsOver() == true 
				then
                app.load("configs.csb.config")
                if  __lua_project_id == __lua_project_l_digital
                    or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
                    then
                else
                    state_machine.excute("camp_chose_window_open",0,"")
                end
            end
            app.load("client.mission.newfunopen.NewFunctionOpen")
            -- state_machine.excute("new_function_open",0,16)
            fwin:addService({
                callback = function ( params )
                    if missionIsOver() == true and params.showFinder ~= nil then
                        if tonumber(_ED.user_info.user_grade) < 10 then
                            params:showFinder()
                        end
                    end
                end,
                delay = 0.5,
                params = self
            })
            local Panel_beizhanling = ccui.Helper:seekWidgetByName(root,"Panel_beizhanling")
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_capture_shine",
            _widget = Panel_beizhanling,
            _invoke = nil,
            _interval = 0.5,})
            
            if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
            else
                local Panel_kezhanling = ccui.Helper:seekWidgetByName(root,"Panel_kezhanling")
                state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_capture_can_attack_shine",
                _widget = Panel_kezhanling,
                _invoke = nil,
                _interval = 0.5,})
            end
                        
    		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_warehouse"), 	nil, 
    		{
    			terminal_name = "home_click_package", 	
    			terminal_state = 0, 
    			isPressedActionEnabled = true
    		}, 
    		nil, 0)
            --装备碎片丢到包裹里了，所以包裹按钮 加上装备合成的推送
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_equipment_warehouse_all",
            _widget = ccui.Helper:seekWidgetByName(root, "Button_warehouse"),
            _invoke = nil,
            _interval = 0.5,})
    		
    		--商城
    		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_shop_0"), 		nil, 
    		{
    			terminal_name = "menu_manager", 	
    			next_terminal_name = "menu_show_shop", 			
    			current_button_name = "Button_shop_0", 		
    			but_image = "Image_shop", 		
    			terminal_state = 0,
                shop_type = "shop",
    			isPressedActionEnabled = true
    		}, 
    		nil, 0)
    		state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_new_shop",
    		_widget = ccui.Helper:seekWidgetByName(root, "Button_shop_0"),
    		_invoke = nil,
    		_interval = 0.5,})
    		
            --招募
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_zhaomu"),         nil, 
            {
                terminal_name = "menu_manager",     
                next_terminal_name = "menu_show_shop",          
                current_button_name = "Button_zhaomu",
                but_image = "Image_shop",       
                terminal_state = 0,
                shop_type = "zhaomu",
                isPressedActionEnabled = true
            }, 
            nil, 0)
            local Panel_zhaomu = ccui.Helper:seekWidgetByName(root, "Panel_zhaomu")
            if Panel_zhaomu ~= nil then
                local ArmatureNode_zhaomu = Panel_zhaomu:getChildByName("ArmatureNode_zhaomu")
                if ArmatureNode_zhaomu ~= nil then
                    ccui.Helper:seekWidgetByName(root, "Button_zhaomu").Armature = ArmatureNode_zhaomu
                    ccui.Helper:seekWidgetByName(root, "Button_zhaomu").zhaomu = Panel_zhaomu
                    
                end
            end
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_new_recruit",
            _widget = ccui.Helper:seekWidgetByName(root, "Button_zhaomu"),
            _invoke = nil,
            _interval = 0.5,})

    		--阵容
    		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_line_0"), 	nil, 
    		{
    			terminal_name = "menu_manager", 	
    			next_terminal_name = "menu_show_formation", 	
    			current_button_name = "Button_line_0", 	
    			but_image = "Image_line-uo", 	
    			_touch_type = "menu",
    			terminal_state = 0, 
    			isPressedActionEnabled = true
    		}, 
    		nil, 0)
    		state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_formation_all",
    			_widget = ccui.Helper:seekWidgetByName(root, "Button_line_0"),
    			_invoke = nil,
    			_interval = 0.5,})	
            
            -- 副本
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_duplicate"),  nil, 
            {
                terminal_name = "menu_manager",     
                next_terminal_name = "menu_show_duplicate",     
                current_button_name = "Button_duplicate",   
                but_image = "Image_duplicate",  
                terminal_state = 0, 
                isPressedActionEnabled = true
            }, 
            nil, 0)
            if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
            else
                state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_battle_all",
                    _widget = ccui.Helper:seekWidgetByName(root, "Button_duplicate"),
                    _invoke = nil,
                    _interval = 0.5,})
            end  

    		--征战
    		fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_lilian_0"), 	nil, 
    		{
    			terminal_name = "menu_manager", 	
    			next_terminal_name = "menu_show_campaign", 		
    			current_button_name = "Button_lilian_0", 		
    			but_image = "Image_activity",	
    			terminal_state = 0, 
    			isPressedActionEnabled = true
    		}, 
    		nil, 0)
    		_ED._is_recharge_push_expedition = false
            if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
                state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_sm_arena_all",
                    _widget = ccui.Helper:seekWidgetByName(root, "Button_lilian_0"),
                    _invoke = nil,
                    _interval = 0.5,})
            else
        		state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_expedition_all",
        			_widget = ccui.Helper:seekWidgetByName(root, "Button_lilian_0"),
        			_invoke = nil,
        			_interval = 0.5,})
            end	


            --偷师学艺
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_home_skills"),  nil, 
            {
                terminal_name = "menu_manager",     
                next_terminal_name = "menu_show_skills_school",      
                current_button_name = "Button_home_skills",        
                but_image = "",   
                terminal_state = 0, 
                isPressedActionEnabled = true
            }, 
            nil, 0)
            -- state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_learing",
            -- _widget = ccui.Helper:seekWidgetByName(root, "Button_home_skills"),
            -- _invoke = nil,
            -- _interval = 0.5,})            
            
            --等级奖励
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_level_pack"),  nil, 
            {
                terminal_name = "menu_manager",     
                next_terminal_name = "menu_show_level_packs",      
                current_button_name = "Button_level_pack",        
                but_image = "",   
                terminal_state = 0, 
                isPressedActionEnabled = true
            }, 
            nil, 0)
            state_machine.excute("home_check_level_packs",0,"")
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_level_packs",
            _widget = ccui.Helper:seekWidgetByName(root, "Button_level_pack"),
            _invoke = nil,
            _interval = 0.5,})
              
    	end

        -- 数码冒险入口
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_jjc"),  nil, 
        {
            terminal_name = "explore_window_open",
            terminal_state = 0, 
            isPressedActionEnabled = true,
            app.load("client.l_digital.explore.ExploreWindow")
        }, 
        nil, 0)

        if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_sm_special_duplicate_all",
            _widget = ccui.Helper:seekWidgetByName(root, "Button_jjc"),
            _invoke = nil,
            _interval = 0.5,})
        end
    	
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_mall_all",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_mail"),
    	_invoke = nil,
    	_interval = 0.5,})
    	
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_friend_all",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_friends"),
    	_invoke = nil,
    	_interval = 0.5,})
    	
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_ship_warehouse_all",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_wujiang"),
    	_invoke = nil,
    	_interval = 0.5,})
		
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_equipment_warehouse_all",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_equipment"),
    	_invoke = nil,
    	_interval = 0.5,})
		
    	
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_recovery_all",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_gaizao"),
    	_invoke = nil,
    	_interval = 0.5,})
    	
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_military_rank_all",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_huozhong"),
    	_invoke = nil,
    	_interval = 0.5,})
    	
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_click_hero_shop",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_shenjiang2"),
    	_invoke = nil,
    	_interval = 0.5,})
    	
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_chat_all",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_chat"),
    	_invoke = nil,
    	_interval = 0.5,})
    	
    	local hideUserInfo = false
    	if __lua_project_id == __lua_project_gragon_tiger_gate
            or __lua_project_id == __lua_project_l_digital
            or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then			--龙虎门项目控制
            if self._needOpenHomeHero == false then
    			fwin:open(HomeHero:new():init(), fwin._background)
    		else
    			local home_hero_wnd = HomeHero:new()
    			fwin:open(home_hero_wnd:init(home_hero_wnd._enum_window_type._FORMATION), fwin._background)
    			
    			state_machine.excute("home_hide_event", 0, "home_hide_event.")
    			hideUserInfo = true
            end
            fwin:open(UserInformation:new(), fwin._frameview)
    	else
    		fwin:open(HomeHero:new():init(), fwin._background)
        
            fwin:open(UserInformation:new(), fwin._background)
    	end
    	
    	if hideUserInfo == true then 
    		state_machine.excute("user_information_hide_event", 0, "user_information_hide_event.")
    	end

        

        -- 数码冒险入口
        local Button_sign = ccui.Helper:seekWidgetByName(root, "Button_sign")
        if Button_sign ~= nil then
            fwin:addTouchEventListener(Button_sign,  nil, 
            {
                terminal_name = "sm_check_in_info_window_window_open",
                terminal_state = 0, 
                isPressedActionEnabled = true,
                app.load("client.l_digital.activity.wonderful.SmCheckInInfoWindow")
            }, 
            nil, 0)

            state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_every_day_sign_all",
            _widget = Button_sign,
            _invoke = nil,
            _interval = 0.5,})
        end

        -- if __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_pokemon 
                -- or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then 
        --     local _level = dms.string(dms["fun_open_condition"],51, fun_open_condition.level)
        --     if tonumber(_ED.user_info.user_grade) >= tonumber(_level) then
        --         state_machine.excute("chat_show_self",0,"")
        --     end
        -- end
    	if __lua_project_id == __lua_project_gragon_tiger_gate
            or __lua_project_id == __lua_project_l_digital
            or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto or __lua_project_id == __lua_project_red_alert then
            local action = csb.createTimeline("home/home_button.csb")
            table.insert(self.actions,action)
            csbHome:runAction(action)
            local _level = dms.string(dms["fun_open_condition"],71, fun_open_condition.level) 
            if tonumber(_ED.user_info.user_grade) >= tonumber(_level) then
                state_machine.excute("chat_show_self",0,"")
            end
                
            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_913"), nil, 
            {
                terminal_name = "home_more_setting_update", 
                next_terminal_name = "", 
                but_image = "", 
                terminal_state = 0, 
                cell = self,
                status = false,
                isPressedActionEnabled = true
            }, 
            nil, 0)

            fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_103"), nil, 
            {
                terminal_name = "home_more_setting_update", 
                next_terminal_name = "", 
                but_image = "", 
                terminal_state = 0, 
                cell = self,
                status = true,
                isPressedActionEnabled = true
            }, 
            nil, 0)
        else
        	local status = false
        	local function onOpenTouchEvent(sender, eventType)
        		if eventType == ccui.TouchEventType.began then
        			playEffect(formatMusicFile("button", 1))
        		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
        		
        			if status == false then
        				action:play("Panel_126_tonch", false)
        				ccui.Helper:seekWidgetByName(root, "Panel_103"):setVisible(true)
        				status = true
        			elseif status == true then
        				action:play("Panel_126_untonch", false)
        				status = false
        				ccui.Helper:seekWidgetByName(root, "Panel_103"):setVisible(false)
        			end
        		end
        	end
        	local button_01 = ccui.Helper:seekWidgetByName(root, "Button_913")
        	button_01:addTouchEventListener(onOpenTouchEvent)
        	button_01:setPressedActionEnabled(true)
        	ccui.Helper:seekWidgetByName(root, "Panel_103"):addTouchEventListener(onOpenTouchEvent)
        end
    	state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_home_expand",
    	_widget = ccui.Helper:seekWidgetByName(root, "Button_913"),
    	_invoke = nil,
    	_interval = 0.5,})
    	
    	state_machine.excute("platform_get_pay_info", 0, "platform_get_pay_info.")
		if __lua_project_id == __lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
            or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh then
			local buttonFb = ccui.Helper:seekWidgetByName(root, "Button_fb")
			if buttonFb ~= nil then
				if zstring.tonumber(_ED.server_review) == 0 then
					buttonFb:setVisible(true)
					local statusFB = false
					local function onOpenFBTouchEvent(sender, eventType)
						if eventType == ccui.TouchEventType.began then
							playEffect(formatMusicFile("button", 1))
						elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
							if statusFB == false then
								action:play("Panel_127_tonch", false)
								ccui.Helper:seekWidgetByName(root, "Panel_127"):setVisible(true)
								statusFB = true
							elseif statusFB == true then
								action:play("Panel_127_untonch", false)
								statusFB = false
								ccui.Helper:seekWidgetByName(root, "Panel_127"):setVisible(false)
							end
						end
					end
					buttonFb:addTouchEventListener(onOpenFBTouchEvent)
					buttonFb:setPressedActionEnabled(true)
				else
					buttonFb:setVisible(false)
				end
				local Button_fans = ccui.Helper:seekWidgetByName(root, "Button_fans") --粉丝页
				local Button_share = ccui.Helper:seekWidgetByName(root, "Button_share") --分享
				if Button_fans~=nil then
					local function onOpenFBFansEvent(sender, eventType)
						if eventType == ccui.TouchEventType.began then
							playEffect(formatMusicFile("button", 1))
						elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
							state_machine.excute("platform_the_open_fans_page", 0, "platform_the_open_fans_page.")
						end
					end

					Button_fans:addTouchEventListener(onOpenFBFansEvent)
					Button_fans:setPressedActionEnabled(true)
				end
				if Button_share~=nil then
					local function onOpenFBShareEvent(sender, eventType)
						if eventType == ccui.TouchEventType.began then
							playEffect(formatMusicFile("button", 1))
						elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
							state_machine.excute("platform_the_request_share", 0, "platform_the_request_share.")  --  分享ID
						end
					end
					Button_share:addTouchEventListener(onOpenFBShareEvent)
					Button_share:setPressedActionEnabled(true)
				end
			end
		end
    	
    	if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert or __lua_project_id == __lua_project_legendary_game then			--龙虎门项目控制
    		local status = false
    		local function onOpenTouchEvent(sender, eventType)
    			if eventType == ccui.TouchEventType.began then
    				playEffect(formatMusicFile("button", 1))
    			elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
    			
    				if status == false then
    					action:play("Button_add_touch", false)
    					status = true
    				elseif status == true then
    					action:play("Button_add_untouch", false)
    					status = false
    				end
    			end
    		end
    		-- local button_01 = ccui.Helper:seekWidgetByName(root, "Button_add")
    		-- button_01:addTouchEventListener(onOpenTouchEvent)
    		-- button_01:setPressedActionEnabled(true)
    	
    	end
        if __lua_project_id ==__lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
            or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh or __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
            if ___is_open_push_info ~= false then
                app.load("client.home.WarshipGirlPushInfo")
                state_machine.excute("warship_girl_push_info_open",0,{_datas={_openType=0}})
            end
        end
    end
    --每日登陆奖励
    local Panel_online_reward = ccui.Helper:seekWidgetByName(root, "Panel_online_reward")
    if Panel_online_reward ~= nil then
        local Panel_bgdh = ccui.Helper:seekWidgetByName(root, "Panel_bgdh")
        if Panel_bgdh.animation ~= nil then
            Panel_bgdh.animation:removeFromParent(true)
        end
        local jsonFile = "sprite/sprite_tianjianghaoli.json"
        local atlasFile = "sprite/sprite_tianjianghaoli.atlas"
        Panel_bgdh.animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
        Panel_bgdh:addChild(Panel_bgdh.animation)
        
        Panel_online_reward:setVisible(false)
        if false == funOpenDrawTip(162, false) then
            self.everyDayOnlinePanel = Panel_online_reward
        end
        fwin:addTouchEventListener(Panel_online_reward,  nil, 
        {
            terminal_name = "sm_open_every_day_online_reward",   
            terminal_state = 0, 
        }, 
        nil, 0)
    end
    self.Panel_hd_tuisong = ccui.Helper:seekWidgetByName(root, "Panel_hd_tuisong")
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
        self:modelOpenPush()
        fwin:addService({
            callback = function ( params )
                params:initShowHomeActivityInfo()
            end,
            delay = 0.5,
            params = self
        })
        app.load("client.l_digital.cultivate.SmCultivateWindow")
        --临时隐藏
        -- ccui.Helper:seekWidgetByName(root, "Button_yangcheng"):setVisible(false)
        fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Button_yangcheng"), nil, 
        {
            terminal_name = "sm_cultivate_window_open", 
            status = false,
            isPressedActionEnabled = true
        }, 
        nil, 0)
        state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_home_cultivate",
        _widget = ccui.Helper:seekWidgetByName(root, "Button_yangcheng"),
        _invoke = nil,
        _interval = 0.5,})
        -- local Panel_fomation_role = ccui.Helper:seekWidgetByName(root, "Panel_fomation_role")
        -- if Panel_fomation_role ~= nil then
        --     Panel_fomation_role:removeAllChildren(true)

        --     local formetion_index = 1
        --     local ships = nil
        --     for i,v in pairs(_ED.user_formetion_status) do
        --         if _ED.user_ship[""..v] ~= nil then
        --             formetion_index = i
        --             ships = _ED.user_ship[""..v]
        --             break
        --         end
        --     end

        --     if ships ~= nil then
        --         local _ship_mould_id = ships.ship_template_id
        --         local temp_bust_index = 0
        --         ----------------------新的数码的形象------------------------
        --         --进化形象
        --         local evo_image = dms.string(dms["ship_mould"], _ship_mould_id, ship_mould.fitSkillTwo)
        --         local evo_info = zstring.split(evo_image, ",")
        --         --进化模板id
        --         local ship_evo = zstring.split(ships.evolution_status, "|")
        --         local evo_mould_id = evo_info[tonumber(ship_evo[1])]
        --         --新的形象编号
        --         temp_bust_index = dms.int(dms["ship_evo_mould"], evo_mould_id, ship_evo_mould.form_id)

        --         draw.sprite("sprite/spirte_2442.png", nil, 100, cc.rect(0, 0, 193, 89), cc.p(0.5, 0.5), Panel_fomation_role, nil, nil, cc.p(0.5, 0))
        --         app.load("client.battle.fight.FightEnum")
        --         local shipSpine = sp.spine_sprite(Panel_fomation_role, temp_bust_index, spineAnimations[_enum_animation_frame_index.animation_standby + 1], true, nil, nil, cc.p(0.5, 0))

        --         fwin:addTouchEventListener(ccui.Helper:seekWidgetByName(root, "Panel_fomation_role"),   nil, 
        --         {
        --             terminal_name = "home_hero_into_formation_page",    
        --             terminal_state = 0, 
        --             _heroInstance = ships,
        --             _formetion_index = formetion_index,
        --             isPressedActionEnabled = true
        --         }, 
        --         nil, 0)
        --         state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_hero_develop_home_hero_icon",
        --         _widget = Panel_fomation_role,
        --         _invoke = nil,
        --         _interval = 0.5,})
        --     end   
        -- end   

        local Button_zhankai = ccui.Helper:seekWidgetByName(root, "Button_zhankai")
        if Button_zhankai ~= nil then
            Button_zhankai:setVisible(false)
            fwin:addTouchEventListener(Button_zhankai,   nil, 
            {
                terminal_name = "sm_model_open_the_animation",    
                terminal_state = 0, 
            }, 
            nil, 0)
        end

        local Button_guanbi = ccui.Helper:seekWidgetByName(root, "Button_guanbi")
        if Button_guanbi ~= nil then
            Button_guanbi:setVisible(true)
            fwin:addTouchEventListener(Button_guanbi,   nil, 
            {
                terminal_name = "sm_model_close_the_animation",    
                terminal_state = 0, 
            }, 
            nil, 0)
        end

        local Button_1 = ccui.Helper:seekWidgetByName(root, "Button_1")
        if Button_1 ~= nil then
            fwin:addTouchEventListener(Button_1,   nil, 
            {
                terminal_name = "target_task_window_open",    
                terminal_state = 0, 
            }, 
            nil, 0)
        end

        if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
        else
            state_machine.excute("sm_model_open_the_animation", 0, nil)
        end

        -- 数码获取黑名单数据
        NetworkManager:register(protocol_command.friend_update.code, nil, nil, nil, nil, nil, false, nil)

        state_machine.excute("sm_home_update_activity_push_state", 0, "")

        if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
            --商店红点定时刷新
            self:shopUpdateTimes()
            self:updateTargetTaskState()
        end
    end
end

function Home:shopUpdateTimes()
    local server_time = getCurrentGTM8Time()
    local currTimes = server_time.hour * 3600 + server_time.min * 60 + server_time.sec
    local refresh_times = zstring.split(dms.string(dms["shop_config"], 1, shop_config.param) , ",")
    local nextReresh = 0
    local currhour = server_time.hour
    for i , v in pairs(refresh_times) do
        local _hour = tonumber(zstring.split(v , ":")[1])
        if tonumber(currhour) <= _hour then
            --找到下个时间点
            nextReresh = _hour
            break
        end
    end
    if nextReresh ~= 0 then
        if nextReresh*3600 - currTimes > 10 then
            self:runAction(cc.Sequence:create({cc.DelayTime:create(nextReresh*3600 - currTimes), cc.CallFunc:create(function ( sender )
                state_machine.excute("notification_center_update", 0, "push_notification_center_new_shop") 
                self:shopUpdateTimes()
            end)}))
        end
    end
end

--功能开启提示
function Home:modelOpenPush()
    local root = self.roots[1]
    local Panel_fun_open = ccui.Helper:seekWidgetByName(root, "Panel_fun_open")
    local currId = dms.int(dms["user_experience_param"] ,tonumber(_ED.user_info.user_grade) ,user_experience_param.open_push_index)
    if currId == -1 then
        Panel_fun_open:setVisible(false)
        return
    end
    Panel_fun_open:setVisible(true)
    --图标
    local Panel_fun_icon = ccui.Helper:seekWidgetByName(root, "Panel_fun_icon")
    Panel_fun_icon:removeAllChildren(true)
    Panel_fun_icon:setBackGroundImage(string.format("images/ui/text/XTZY/fun_icon_%d.png",currId))
    --文字
    local Panel_fun_text = ccui.Helper:seekWidgetByName(root, "Panel_fun_text")
    Panel_fun_text:removeAllChildren(true)
    Panel_fun_text:setBackGroundImage(string.format("images/ui/text/XTZY/fun_text_%d.png",currId))
    --开启等级
    local BitmapFontLabel_fun_open_lv = ccui.Helper:seekWidgetByName(root, "BitmapFontLabel_fun_open_lv")
    BitmapFontLabel_fun_open_lv:setString(_model_open_push_tip[currId][1])
    fwin:addTouchEventListener(Panel_fun_open,  nil, 
    {
        terminal_name = "sm_model_open_push_scan",
        shortCut = currId,  
        terminal_state = 0, 
    }, 
    nil, 0)
    local Image_funopen_tip = ccui.Helper:seekWidgetByName(root, "Image_funopen_tip")
    if Image_funopen_tip ~= nil then
        if _ED.system_fun_open_event == nil or _ED.system_fun_open_event < 0 then
            --没有打开，需要红点推送
            Image_funopen_tip:setVisible(true)
        end
    end
end

function Home:updateHomeAcivityPushUIInfo( currId, isAllShow )
    local isOpend = false
    for k,v in pairs(_ED.home_activity_push_info) do
        if v ~= nil and v.isHaveOpen == true then
            isOpend = true
            break
        end
    end
    if isOpend == true then
        _ED.home_activity_push_info[currId].isWaitOpen = true
        _ED.home_activity_push_info[currId].isHaveOpen = false
        _ED.home_activity_push_info[currId].isAllShow = isAllShow
        return
    end
    _ED.home_activity_push_info[currId].isHaveOpen = true
    _ED.home_activity_push_info[currId].isWaitOpen = false
    _ED.home_activity_push_info[currId].isAllShow = isAllShow
    local root = self.roots[1]
    if root == nil then
        return
    end
    local Panel_hd_tuisong = ccui.Helper:seekWidgetByName(root, "Panel_hd_tuisong")
    if Panel_hd_tuisong == nil then
        return
    end
    local Panel_hd_tuisong = ccui.Helper:seekWidgetByName(root, "Panel_hd_tuisong")
    Panel_hd_tuisong:setVisible(true)
    local Panel_tsdh = ccui.Helper:seekWidgetByName(root, "Panel_tsdh")
    if Panel_tsdh.animation ~= nil then
        Panel_tsdh.animation:removeFromParent(true)
    end
    local jsonFile = "sprite/sprite_gongnengtuisong.json"
    local atlasFile = "sprite/sprite_gongnengtuisong.atlas"
    Panel_tsdh.animation = sp.spine(jsonFile, atlasFile, 1, 0, "animation", true, nil)
    Panel_tsdh:addChild(Panel_tsdh.animation)

    --参加
    local Image_zt_1 = ccui.Helper:seekWidgetByName(root, "Image_zt_1")
    --进行
    local Image_zt_2 = ccui.Helper:seekWidgetByName(root, "Image_zt_2")
    Image_zt_1:setVisible(false)
    Image_zt_2:setVisible(false)
    Image_zt_1:setVisible(true)
    --标题
    local Panel_ts_text = ccui.Helper:seekWidgetByName(root, "Panel_ts_text")
    Panel_ts_text:removeAllChildren(true)
    Panel_ts_text:setBackGroundImage(string.format("images/ui/text/XTKF_res/ts_text_%d.png", currId))
    --图标
    local Panel_ts_icon = ccui.Helper:seekWidgetByName(root, "Panel_ts_icon")
    Panel_ts_icon:removeAllChildren(true)
    Panel_ts_icon:setBackGroundImage(string.format("images/ui/text/XTKF_res/ts_icon_%d.png", currId))
    fwin:removeTouchEventListener(Panel_hd_tuisong)
    fwin:addTouchEventListener(Panel_hd_tuisong,  nil, 
    {
        terminal_name = "sm_model_join_push_goto_join",
        shortCut = currId,  
        terminal_state = 0, 
    }, 
    nil, 0)
end

function Home:initShowHomeActivityInfo( ... )
    if _ED.home_activity_push_info == nil then
        _ED.home_activity_push_info = {}
    end
    if home_activity_push_times_info ~= nil then
        local server_time = getCurrentGTM8Time()
        for k,v in pairs(home_activity_push_times_info) do
            local openInfo = _ED.home_activity_push_info[k]
            if openInfo == nil then
                openInfo = {isHaveOpen = false, isWaitOpen = false, isAllShow = false}
            end
            _ED.home_activity_push_info[k] = openInfo
            if (openInfo.isHaveOpen == false and openInfo.isWaitOpen == false) or openInfo.isAllShow == true then
                if funOpenDrawTip(v[1], false) == false then
                    local isOpened = false
                    if k == 1 then
                        isOpened = _ED.union_red_envelopes_open
                    elseif k == 2 then
                        isOpened = _ED.union.union_fight_battle_info ~= nil and zstring.tonumber(_ED.union.union_fight_battle_info.state) >= 1
                    elseif k == 3 then
                        isOpened = true
                    elseif k == 4 then
                        isOpened = true
                    end
                    if isOpened == true then
                        if k == 1 or k == 2 then
                            self:updateHomeAcivityPushUIInfo(k, false)
                        elseif k == 3 then
                            local function responseDigitalPurifyInitCallback(response)
                                if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                                    local haveShip = false
                                    for i , v in pairs(_ED.digital_purify_info._heros) do
                                        if fundShipWidthTemplateId(v[2]) ~= nil then
                                            haveShip = true
                                            break 
                                        end
                                    end
                                    if haveShip == true then
                                        local currNumber = 0
                                        if _ED.digital_purify_info ~= nil and _ED.digital_purify_info._team_info ~= nil
                                            and _ED.digital_purify_info._team_info.members ~= nil then
                                            for i , v in pairs(_ED.digital_purify_info._team_info.members) do
                                                if tonumber(v.user_id) == tonumber(_ED.user_info.user_id) then
                                                    currNumber = tonumber(v.complete_count)
                                                end
                                            end
                                        end
                                        if currNumber < 3 then
                                            self:updateHomeAcivityPushUIInfo(3, false)
                                        end
                                    end
                                end
                            end
                            if _ED.digital_purify_info == nil then
                                NetworkManager:register(protocol_command.ship_purify_init.code, nil, nil, nil, nil, responseDigitalPurifyInitCallback, false, nil) 
                            else
                                responseDigitalPurifyInitCallback({RESPONSE_SUCCESS = true, PROTOCOL_STATUS = 0})
                            end
                        elseif k == 4 then
                            local beginTime = v[2][1]
                            local open_time = zstring.split(beginTime, ":")
                            local leave_time = (tonumber(open_time[1]) - server_time.hour) * 3600 + (tonumber(open_time[2]) - server_time.min) * 60 + tonumber(open_time[3]) - server_time.sec 
                            if leave_time <= 0 then
                                local endTime = v[2][#v[2]]
                                open_time = zstring.split(endTime, ":")
                                leave_time = (tonumber(open_time[1]) - server_time.hour) * 3600 + (tonumber(open_time[2]) - server_time.min) * 60 + tonumber(open_time[3]) - server_time.sec 
                                if leave_time > 0 then
                                    endTime = v[2][#v[2] - 1]
                                    open_time = zstring.split(endTime, ":")
                                    leave_time = (tonumber(open_time[1]) - server_time.hour) * 3600 + (tonumber(open_time[2]) - server_time.min) * 60 + tonumber(open_time[3]) - server_time.sec 
                                    if leave_time <= 0 then
                                        self:updateHomeAcivityPushUIInfo(k, true)
                                    else
                                        self:updateHomeAcivityPushUIInfo(k, false)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Home:onUpdate(dt)
	if 2 == self.init_home_effect and nil ~= self._ship_mould_id  then
		self.init_home_effect = 1
		self:playHeroEffect()
	end

	if self.action ~= nil then
		self.action:play("Panel_button_1_tonch", false)
		self.action = nil
	end    

    if self.runState == 1 then
        state_machine.unlock("menu_manager_change_to_page", 0, "")
        self.runState = self.runState + 1
    end
    if self.runState == 0 then
        self.runState = self.runState + 1
    end
	if __lua_project_id == __lua_project_warship_girl_b 
        or __lua_project_id == __lua_project_digimon_adventure 
        or __lua_project_id == __lua_project_naruto 
        or __lua_project_id == __lua_project_pokemon 
        or __lua_project_id == __lua_project_rouge 
        or __lua_project_id == __lua_project_yugioh 
    	or __lua_project_id == __lua_project_warship_girl_a 
    	or __lua_project_id == __lua_project_koone
    	then
		--次日活动
		if self._is_show_activity_next_day ~= true and _ED.active_activity[48] ~= nil then
			--and tonumber(_ED.active_activity[48].activity_isReward) == 1
			self._is_show_activity_next_day = true
			local mysteryShop = ActivityIconCell:createCell()
			mysteryShop:init(mysteryShop.enum_type.ACTIVITY_HOME_NEXT_DAY_ICON)
            if __lua_project_id == __lua_project_yugioh then 
                self.listButtons_2:addChild(mysteryShop)
                self:refreshActivityListButtonsSize(2)
            else
                self.AcitivityListTwo:addChild(mysteryShop)
            end
		
			state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_activity_next_day",
			_widget = mysteryShop,
			_invoke = nil,
			_interval = 0.5,})
		end
	end
    if __lua_project_id == __lua_project_l_digital 
        or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto 
    	or __lua_project_id == __lua_project_red_alert
	    then
        --队伍发送聊天时间
        if tonumber(_ED.purify_team_send_world_message_times) > 0 then
            _ED.purify_team_send_world_message_times = _ED.purify_team_send_world_message_times - dt
        end
        if tonumber(_ED.purify_team_send_union_message_times) > 0 then
            _ED.purify_team_send_union_message_times = _ED.purify_team_send_union_message_times - dt
        end

        local isShowOnlinePanel = false
        if self.everyDayOnlinePanel ~= nil then
            -- local Panel_hd_tuisong = ccui.Helper:seekWidgetByName(self.roots[1], "Panel_hd_tuisong")
            self.everyDayOnlinePanel:setVisible(false)
            if (os.time() + _ED.time_add_or_sub) >= zstring.tonumber(_ED.every_day_online_reward_next_time)/1000 then
                local count = zstring.tonumber(_ED.every_day_online_reward_times)
                local timeArr = zstring.split(dms.string(dms["play_config"], 50, pirates_config.param), ",")
                if count < #timeArr then
                    isShowOnlinePanel = true
                    self.everyDayOnlinePanel:setVisible(true)
                    if self.Panel_hd_tuisong ~= nil then
                        if self.Panel_hd_tuisong:isVisible() == true then
                            self.Panel_hd_tuisong._isHide = true
                        end
                        self.Panel_hd_tuisong:setVisible(false)
                    end
                end
            end
            if isShowOnlinePanel == false 
                and self.Panel_hd_tuisong ~= nil 
                and self.Panel_hd_tuisong._isHide == true
                then
                self.Panel_hd_tuisong:setVisible(true)
                self.Panel_hd_tuisong._isHide = nil
            end
        end
	elseif __lua_project_id == __lua_project_gragon_tiger_gate
        or __lua_project_id == __lua_project_red_alert then
        if self.show_finder ~= nil then
            if tonumber(_ED.user_info.user_grade) < 14 and missionIsOver() == true then
                self.show_finder:setVisible(true)
            else
                self.show_finder:setVisible(false)
            end
        end
		if _ED._reward_centre == nil or _ED._reward_centre == "" or #_ED._reward_centre == 0 then
		else
			local root = self.roots[1]
			local AcitivityList = ccui.Helper:seekWidgetByName(root, "ListView_1")
			
			local function getHasRewardCentre()
				
				for k, v in pairs(AcitivityList:getItems()) do
					if v.item == "reward"  then
						return true 
					end
				    
				end
				
				return false
			end
			
			if getHasRewardCentre() ~= true then
                AcitivityList:removeAllItems()
				self:upDataDraw()
				-- local rewardCentre = ActivityIconCell:createCell()
				-- rewardCentre:init(rewardCentre.enum_type.ACTIVITY_GAIN_REWARD_ICON)
				-- AcitivityList:addChild(rewardCentre)	
				-- rewardCentre.item = "reward"
				-- state_machine.excute("push_notification_center_manager", 0, { _terminal_name = "push_notification_center_activity_the_center_of_the_award",
				-- _widget = rewardCentre,
				-- _invoke = nil,
				-- _interval = 0.5,})
			end
		end
	end
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
        if _ED.user_info.fight_capacity ~= self.user_fight then
            self.user_fight = _ED.user_info.fight_capacity
        end

        if _ED.home_activity_push_info == nil then
            _ED.home_activity_push_info = {}
        end
        if home_activity_push_times_info ~= nil then
            local server_time = getCurrentGTM8Time()
            for k,v in pairs(home_activity_push_times_info) do
                local openInfo = _ED.home_activity_push_info[k]
                if openInfo == nil then
                    openInfo = {isHaveOpen = false, isWaitOpen = false, isAllShow = false}
                end
                _ED.home_activity_push_info[k] = openInfo
                if (openInfo.isHaveOpen == false and openInfo.isWaitOpen == false) or openInfo.isAllShow == true then
                    if funOpenDrawTip(v[1], false) == false then
                        local isOpened = false
                        if k == 1 then
                            isOpened = _ED.union_red_envelopes_open
                        elseif k == 2 then
                            isOpened = _ED.union.union_fight_battle_info ~= nil and zstring.tonumber(_ED.union.union_fight_battle_info.state) >= 1
                            if isOpened == true then
                                if _ED.union.union_info == nil 
                                    or _ED.union.union_info == {} 
                                    or _ED.union.union_info.union_id == nil 
                                    or _ED.union.union_info.union_id == "" 
                                    or tonumber(_ED.union.union_info.union_id) == 0 
                                    then
                                    isOpened = false
                                end
                            end
                            if isOpened == true then
                                isOpened = not funOpenDrawTip(82, false)
                            end
                            if isOpened == true then
                                isOpened = not funOpenDrawTip(149, false)
                            end
                        elseif k == 3 then
                            isOpened = true
                        elseif k == 4 then
                            isOpened = true
                        end
                        if isOpened == true then
                            local totalTimes = 0
                            if k == 4 then
                                totalTimes = #v[2]
                            end
                            for j, timeInfo in pairs(v[2]) do
                                local open_time = zstring.split(timeInfo, ":")
                                local leave_time = (tonumber(open_time[1]) - server_time.hour) * 3600 + (tonumber(open_time[2]) - server_time.min) * 60 + tonumber(open_time[3]) - server_time.sec
                                if leave_time <= 0 and leave_time >= -1 then
                                    if k == 3 then
                                        local function responseDigitalPurifyInitCallback(response)
                                            if response.RESPONSE_SUCCESS and response.PROTOCOL_STATUS >= 0 then
                                                self.have_send_purify = true
                                                local haveShip = false
                                                for i , v in pairs(_ED.digital_purify_info._heros) do
                                                    if fundShipWidthTemplateId(v[2]) ~= nil then
                                                        haveShip = true
                                                        break 
                                                    end
                                                end
                                                if haveShip == true then
                                                    local currNumber = 0
                                                    if _ED.digital_purify_info ~= nil and _ED.digital_purify_info._team_info ~= nil
                                                        and _ED.digital_purify_info._team_info.members ~= nil then
                                                        for i , v in pairs(_ED.digital_purify_info._team_info.members) do
                                                            if tonumber(v.user_id) == tonumber(_ED.user_info.user_id) then
                                                                currNumber = tonumber(v.complete_count)
                                                            end
                                                        end
                                                    end
                                                    if currNumber < 3 then
                                                        self:updateHomeAcivityPushUIInfo(3, false)
                                                    end
                                                end
                                            end
                                        end
                                        
                                        if not self.have_send_purify then
                                            self.have_send_purify = true
                                            NetworkManager:register(protocol_command.ship_purify_init.code, nil, nil, nil, nil, responseDigitalPurifyInitCallback, false, nil) 
                                        else
                                            responseDigitalPurifyInitCallback({RESPONSE_SUCCESS = true, PROTOCOL_STATUS = 0})
                                        end
                                    else
                                        if k == 4 and totalTimes - 1 == j then
                                            self:updateHomeAcivityPushUIInfo(k, true)
                                        else
                                            self:updateHomeAcivityPushUIInfo(k, false)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon then
        if self.updateTimes == 0 then
            state_machine.excute("sm_model_open_the_animation", 0, nil)
        elseif self.updateTimes > 1.5 then
            state_machine.excute("sm_model_close_the_animation", 0, nil)
            self.updateTimes = -5
        elseif self.updateTimes >= -1 and self.updateTimes < 0 then
            self.updateTimes = 0
            state_machine.excute("sm_model_open_the_animation", 0, nil)
        end
        self.updateTimes = self.updateTimes + dt
    end
end

function Home:onExit()
    state_machine.remove("home_adventure_forum")
    state_machine.remove("home_adventure_gift_bag")
    state_machine.remove("home_adventure_friends")
    state_machine.remove("home_adventure_system_set")
    state_machine.remove("home_adventure_shop")
    state_machine.remove("home_adventure_sign_in")
    state_machine.remove("home_adventure_month_card")
    state_machine.remove("home_adventure_activity")
    state_machine.remove("home_adventure_achievement")
    state_machine.remove("home_adventure_black_market")
    state_machine.remove("home_adventure_notice")
	state_machine.remove("home_adventure_more_system")
    state_machine.remove("home_capture_open")
    if __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then
        state_machine.remove("home_more_setting_update")
        state_machine.remove("home_check_level_packs")
    end
    if __lua_project_id ==__lua_project_warship_girl_a or __lua_project_id == __lua_project_warship_girl_b or __lua_project_id == __lua_project_digimon_adventure or __lua_project_id == __lua_project_naruto or __lua_project_id == __lua_project_pokemon 
        or __lua_project_id == __lua_project_rouge or __lua_project_id == __lua_project_yugioh or 
        __lua_project_id == __lua_project_gragon_tiger_gate or __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto  or __lua_project_id == __lua_project_red_alert then  
        if ___is_open_push_info ~= false then
            state_machine.excute("warship_girl_push_info_close",0,"")
        end
    end
    if __lua_project_id == __lua_project_l_digital or __lua_project_id == __lua_project_l_pokemon or __lua_project_id == __lua_project_l_naruto then
        state_machine.remove("sm_open_every_day_online_reward")
        state_machine.remove("sm_model_join_push_goto_join")
        state_machine.remove("sm_model_open_push_scan")
        state_machine.remove("sm_model_open_push_updata")
        state_machine.remove("sm_home_update_activity_push_state")
        state_machine.remove("home_update_online_reward_info_state")
        state_machine.remove("home_update_mission_over_finder_state")
        state_machine.remove("home_update_target_task_info_state")
    end
end

function Home:init(prop,types )
	self.prop = prop
	self.type = types
end

function Home:createCell()
	local cell = Home:new()
	cell:registerOnNodeEvent(cell)
	return cell
end
