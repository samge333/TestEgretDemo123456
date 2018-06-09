-- ----------------------------------------------------------------------------------------------------
-- 说明：游戏数据统计
-- 创建时间2014-06-20 22:33
-- 作者：周义文
-- 修改记录：
-- 最后修改人：
-------------------------------------------------------------------------------------------------------
app.load("data.TipStringInfo")
local sender, filter, source, sink, dump = {}, {}, {}, {}, {}
local _M = {}

_M.sender = sender
_M.filter = filter
_M.source = source
_M.sink = sink
_M.pump = pump


local CC_INIT_TALKINGDATA							 	     = 330
local CC_RESUME_TALKINGDATA							 	     = 331
local CC_PAUSE_TALKINGDATA							 	     = 332
local CC_TALKINGDATA_SET_ACCOUNT						 	 = 333
local CC_TALKINGDATA_SET_ACCOUNT_TYPE				 	 	 = 334
local CC_TALKINGDATA_SET_ACCOUNT_NAME				 	 	 = 335
local CC_TALKINGDATA_SET_LEVEL						 	     = 336
local CC_TALKINGDATA_SET_GENDER						 	     = 337
local CC_TALKINGDATA_SET_AGE		  					 	 = 338
local CC_TALKINGDATA_SET_GAME_SERVER					 	 = 339
local CC_TALKINGDATA_RECHARGE_CHANGE_REQUEST			 	 = 340
local CC_TALKINGDATA_RECHARGE_CHANGE_SUCCESS			 	 = 341
local CC_TALKINGDATA_REWARD_GOLD						 	 = 342
local CC_TALKINGDATA_PURCHASE						 	 	 = 343
local CC_TALKINGDATA_USE								 	 = 344
local CC_TALKINGDATA_TASK_BEGIN						 	     = 345
local CC_TALKINGDATA_TASK_COMPLETED					 	     = 346
local CC_TALKINGDATA_TASK_FAILED						 	 = 347
local CC_TALKINGDATA_CUSTOM_EVENT					 	 	 = 348
local CC_FACEBOOK_APPEVENTSLOGGER							 = 4020 --FACEBOOK的事件埋点

TDGAAccount = {Age = {}, AccountType = {}, Gender = {}}

TDGAAccount.Age.Default                                      = 18

TDGAAccount.AccountType.QQ                                   = 1
TDGAAccount.AccountType.Default                              = 1

TDGAAccount.Gender.MALE                                      = 1
TDGAAccount.Gender.FEMALE                                    = 2


jttd = { __sys = {}, __account = {}, __recharge = {}}

local function jttdconnect(message, messageText)
	if __lua_project_id == __lua_project_adventure then
		app.unload("data.TipStringInfo")
	end
	handlePlatformRequest(0, message, messageText)
end

function jttd.init(appId, partnerId)
    jttd.__sys._init = true
    -- jttdconnect(CC_INIT_TALKINGDATA, ""..appId.."|"..partnerId)
    jttdconnect(CC_INIT_TALKINGDATA, "")
end

function jttd.resume()
    --if jttd.__sys._init == true then
     --   jttdconnect(CC_RESUME_TALKINGDATA, "")
    --end
end

function jttd.pause()
    -- if jttd.__sys._init == true then
        -- jttdconnect(CC_PAUSE_TALKINGDATA, "")
    -- end
end

function jttd.setAccount(accountId)
    -- if accountId == nil then
        -- jttd.__account._init = false
    -- end

    -- jttd.__account._accountId = accountId
    -- if jttd.__sys._init == true then
        -- jttd.__account._init = true
        -- jttdconnect(CC_TALKINGDATA_SET_ACCOUNT, accountId)
    -- else
    -- end
end

function jttd.setAccountType(accountType)
    -- jttd.__account._accountType = accountType
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_SET_ACCOUNT_TYPE, accountType)
    -- else
    -- end
end

function jttd.setAccountName(accountName)
    -- jttd.__account._accountName = accountName
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_SET_ACCOUNT_NAME, accountName)
    -- else
    -- end
end

function jttd.setAccountLevel(accountLevel)
    -- jttd.__account._accountLevel = accountLevel
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_SET_LEVEL, accountLevel)
    -- else
    -- end
end

function jttd.setGender(gender)
    -- jttd.__account._gender = gender
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_SET_GENDER, gender)
    -- else
    -- end
end

function jttd.setAge(age)
    -- jttd.__account._age = age
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_SET_AGE, age)
    -- else
    -- end
end

function jttd.setGameServer(serverName)
    -- jttd.__sys._serverNumber = serverName
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_SET_GAME_SERVER, serverName)
    -- else
    -- end
end

function jttd.recharge(orderMsg)
    -- if jttd.__account._init == true then
        --orderMsg info:'order_id|recharge_id|money|CNY|game_money|virtual platform-..m_sOperationPlatformName'
        -- jttdconnect(CC_TALKINGDATA_RECHARGE_CHANGE_REQUEST, orderMsg)
    -- end
end

function jttd.rechargeSuccess(orderMsg)
    -- if jttd.__account._init == true then
        --orderMsg info:'order_id'
        -- jttdconnect(CC_TALKINGDATA_RECHARGE_CHANGE_SUCCESS, orderMsg)
    -- end
end

function jttd.rewardGold(command, gold)
    -- if jttd.__account._init == true then
        -- local rewardInfo = ""..gold.."|"..command
        -- jttdconnect(CC_TALKINGDATA_REWARD_GOLD, rewardInfo)
    -- end
end

function jttd.purchase(command, params)
    -- if jttd.__account._init == true then
		--params info:'number|value'
		-- local purchaseInfo = ""..command.."|"..params
        -- jttdconnect(CC_TALKINGDATA_PURCHASE, purchaseInfo)
    -- end
end

function jttd.use(command, params)
    -- if jttd.__account._init == true then
		--params info:'name|number'
        -- jttdconnect(CC_TALKINGDATA_USE, params)
    -- end
end

function jttd.begin(params)
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_TASK_BEGIN, params)
    -- end
end

function jttd.completed(params)
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_TASK_COMPLETED, params)
    -- end
end

function jttd.failed(params)
    -- if jttd.__account._init == true then
        -- jttdconnect(CC_TALKINGDATA_TASK_FAILED, params)
    -- end
end

function jttd.custom(params)
    -- if jttd.__account._init == true then
        -- "".."custom_name"..">".."key1_name,v^"..number
        -- "".."custom_name"..">".."key1_name,"..string
        -- "".."custom_name"..">".."key1_name,v^"..number.."|".."key2_name,"..string
        -- jttdconnect(CC_TALKINGDATA_CUSTOM_EVENT, params)
    -- end
end
----------------------------------------- 工具函数 ------------------------------------------
-- 获取 日期,时间
function getDateAndTime()
	-- local system_time = os.time()
	-- local data = os.date("*t",system_time)
	-- return data.year.."-"..data.month.."-"..data.day,data.hour..":"..data.min..":"..data.sec
end

-- 格式化设备信息
local _jttd_extras = nil
function getJttdExtras()
	-- if _jttd_extras == nil then
		-- _jttd_extras = zstring.split(platform_extras, "\r\n")
	-- end
	-- return _jttd_extras
end
-- 获取统一的设备统计格式
function getExtraInfo()
	-- local platform_extras1 = getJttdExtras()
	-- return "download_from:"..platform_extras1[1]..",udid:"..platform_extras1[8]..",model:"..platform_extras1[5]..",ratio:"..platform_extras1[6]..",system:"..platform_extras1[7]
end

-- 判定值为nil则转换为统一"nil"
function getNilToString(value)
	-- if value == nil then
		-- return "nil"
	-- end
	-- return value 
end
-- END~工具函数
-- ------------------------------------------------------------------------------------------
----------------------------------------- gameinfo ------------------------------------------
-- explaining 
-- userid 
-- gameinfo 
-- kingdom 
-- phylum 
-- classfield 
-- family 
-- genus 
-- gameinfo_date
-- gameinfo_time 
-- value 
-- extra
-- ------------------------------------------------------------------------------------------
gameinfo_params = {
    gameinfo_explain = tip_gameinfo_explain,

    gameinfos = {
        "open_app", "update_check", "update_win", "login_page", "register",
        "fat_register", "login", "server_choice", "actor_choice"
    }, 

    open_app = 1, 
    update_check = 2, 
    update_win = 3, 
    login_page = 4, 
    register = 5,
    fat_register = 6, 
    login = 7, 
    server_choice = 8, 
    actor_choice = 9,
}


function jttd.send_gameinfo(explaining, userid, gameinfo, kingdom, classfield, family, genus, gameinfo_date, gameinfo_time, value, extra)

  -- local param = ""..explaining..">"..
						-- "userid,"..userid.."|"..
						-- "gameinfo,"..gameinfo.."|"..
						-- "kingdom,"..kingdom.."|"..
						-- "classfield,"..classfield.."|"..
						-- "family,"..family.."|"..
						-- "genus,"..genus.."|"..
						-- "gameinfo_date,"..gameinfo_date.."|"..
						-- "gameinfo_time,"..gameinfo_time.."|"..
						-- "value,"..value.."|"..
						-- "extra,"..extra
    -- jttd.custom(param)

end

function jttd.gameinfo(kingdom_index)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	
	-- local gameinfo_date,gameinfo_time = getDateAndTime()
	-- local platform_extras1 = getJttdExtras()
    -- jttd.send_gameinfo(
		-- gameinfo_params.gameinfo_explain[kingdom_index],-- explaining, 
		-- platform_extras1[8],							--userid(就是手机识别码), 
		-- gameinfo_params.gameinfos[kingdom_index], 		--gameinfo, 
		-- kingdom_index,		--kingdom, 
		-- "",					--classfield, 
		-- "",					--family,
		-- "",					--genus, 
		-- gameinfo_date,		--gameinfo_date, 
		-- gameinfo_time,		--gameinfo_time, 
		-- "",					--value, 
		-- getExtraInfo()		--extra
    -- )

end

-- END~gameinfo
-- ------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------
-- 用户基础行为统计
-- explaining
-- userid
-- counter
-- kingdom
-- phylum
-- classfield
-- family
-- genus
-- extra
-- value
-- user_level
-- comment
-------------------------------------------------------------------------------------------
jttd_data_script = tip_jttd_data_script

user_base_action_params = {
	action_name = tip_user_base_action_name,
	class_field = tip_user_base_class_field,
}


function jttd.send_user_base_action(explaining, userid, counter, kingdom, phylum, classfield, family, genus, extra, value, user_level,comment)
  -- local param = ""..explaining..">"..
						-- "userid,"..userid.."|"..
						-- "counter,"..counter.."|"..
						-- "kingdom,"..kingdom.."|"..
						-- "phylum,"..phylum.."|"..
						-- "classfield,"..classfield.."|"..
						-- "family,"..family.."|"..
						-- "genus,"..genus.."|"..
						-- "extra,"..extra.."|"..
						-- "value,"..value.."|"..
						-- "user_level,"..user_level.."|"..
						-- "comment,"..comment
    -- jttd.custom(param)
end
function jttd.user_base_action(index,userid,giftName,value,user_level)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	-- jttd.send_user_base_action(
		-- user_base_action_params.action_name[index],
		-- userid,
		-- "item_flow",
		-- "inflow",
		-- "program",
		-- user_base_action_params.class_field[index],
		-- "",
		-- "",
		-- giftName,
		-- value,
		-- user_level,
		-- ""
	-- )
end
--END
-- ----------------------------------用户基础行为数据统计——仓库--------------------
user_storage_params = {
	action_name = tip_user_storage_action_name
}
 
function jttd.send_user_storage_action(explaining, userid, counter, kingdom, phylum, classfield, family, genus, extra, value, user_level,comment)
  -- local param = ""..explaining..">"..
						-- "userid,"..userid.."|"..
						-- "counter,"..counter.."|"..
						-- "kingdom,"..kingdom.."|"..
						-- "phylum,"..phylum.."|"..
						-- "classfield,"..classfield.."|"..
						-- "family,"..family.."|"..
						-- "genus,"..genus.."|"..
						-- "extra,"..extra.."|"..
						-- "value,"..value.."|"..
						-- "user_level,"..user_level.."|"..
						-- "comment,"..comment
    -- jttd.custom(param)
end
function jttd.user_storage_action(index,userid,name,value,user_level)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	-- jttd.send_user_storage_action(
		-- user_storage_params.action_name[index],
		-- userid,
		-- "item_flow",
		-- "inflow",
		-- "storage",
		-- "use",
		-- "",
		-- "",
		-- "name:"..name,
		-- value,
		-- user_level,
		-- ""
	-- )
end
-- END
--------------------------------------------------------------------------------------------
-- -------------------------------用户基础行为数据统计——pve------------------------
user_pve_params = {
	action_name = tip_user_pve_action_name,
	kingdom = {
		"jinyanbaowu",
		"huangjinjuren",
		"huodong",
		"jingying",
		"shilianta",
		"word_boss",
	}
}
function jttd.send_user_pve_action(explaining, userid, counter, kingdom, phylum, classfield, family, genus, extra, value, user_level,comment)
  -- local param = ""..explaining..">"..
						-- "userid,"..userid.."|"..
						-- "counter,"..counter.."|"..
						-- "kingdom,"..kingdom.."|"..
						-- "phylum,"..phylum.."|"..
						-- "classfield,"..classfield.."|"..
						-- "family,"..family.."|"..
						-- "genus,"..genus.."|"..
						-- "extra,"..extra.."|"..
						-- "value,"..value.."|"..
						-- "user_level,"..user_level.."|"..
						-- "comment,"..comment
    -- jttd.custom(param)
end
function jttd.user_pve_action(index,userid,result,npcName,sceneName,value,user_level)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	-- jttd.send_user_pve_action(
		-- user_pve_params.action_name[index],
		-- userid,
		-- "PVE",
		-- user_pve_params.kingdom[index],
		-- "",
		-- "use",
		-- "",
		-- result,
		-- "name:"..npcName..",".."hj:"..sceneName,
		-- value,
		-- user_level,
		-- ""
	-- )
end
-- END
--------------------------------------------------------------------------------------------
----------------------------------------- vipinfo ------------------------------------------
vipinfo_params = {
    vipinfo_explain = tip_vipinfo_explain,

    vipinfos = {
        "vip_grade"
    }, 

    vip_grade = 1,
}
function jttd.send_vipinfo(explaining, userid, milestone, value, gameinfo_date, gameinfo_time, extra)

  -- local param = ""..explaining..">"..
						-- "userid,"..userid.."|"..
						-- "milestone,"..milestone.."|"..
						-- "value,"..value.."|"..
						-- "gameinfo_date,"..gameinfo_date.."|"..
						-- "gameinfo_time,"..gameinfo_time.."|"..
						-- "extra,"..extra
    -- jttd.custom(param)

end

function jttd.vipinfo(kingdom_index)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	-- local gameinfo_date,gameinfo_time = getDateAndTime()
	-- local platform_extras1 = getJttdExtras()
	-- local value = ""
	-- local userid = ""
	-- if _ED ~= nil then
		-- if _ED.user_info ~= nil then
			-- if _ED.user_info.user_id ~= nil then
				-- userid = _ED.user_info.user_id
			-- end
		-- end
		-- if _ED.vip_grade ~= nil then
			-- value = _ED.vip_grade
		-- end
	-- end
    -- jttd.send_vipinfo(
		-- vipinfo_params.vipinfo_explain[kingdom_index],-- explaining, 
		-- userid,							--userid, 
		-- vipinfo_params.vipinfos[kingdom_index], 		--milestone, 
		-- value,		--value, 
		-- gameinfo_date,		--gameinfo_date, 
		-- gameinfo_time,		--gameinfo_time,  
		-- getExtraInfo()		--extra
    -- )

end

-- END~vipinfo
-- ------------------------------------------------------------------------------------------
----------------------------------------- fighter_numerical_info ------------------------------------------
--recruit=1,
--dismiss=2,
--Strengthen=3,
--Strengthen_soul=4,
--Strengthen_soul_five=5,
--grow=6,
--fragment=7,
--load=8,
--unload=9
-- ------------------------------------------------------------------------------------------
fighter_numerical_info_params = {
    fighter_numerical_info_explain = tip_fighter_numerical_info_explain,

    fighter_actions = {
        "acquire",
		"dismiss",
    }, 

    acquire=1,
	dismiss=2,
}

function jttd.send_fighterNumericalInfo(explaining, userid, actions, template_id, count, name, _date, _time, extra)

  -- local param = ""..explaining..">"..
						-- "userid,"..userid.."|"..
						-- "actions,"..actions.."|"..
						-- "template_id,"..template_id.."|"..
						-- "count,"..count.."|"..
						-- "name,"..name.."|"..
						-- "date,".._date.."|"..
						-- "time,".._time.."|"..
						-- "extra,"..extra
    -- jttd.custom(param)
end

function jttd.fighterNumericalInfo(kingdom_index,id,count)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	-- local template_id = ""
	-- local name = ""
	-- local userid = ""
	-- if id ~= nil then
		-- local shipInfo = fundShipWidthId(id)
		-- template_id = shipInfo.ship_template_id
		-- name = shipInfo.captain_name
	-- end
	-- if count == nil then
		-- count = 1 
	-- end
	-- if _ED ~= nil then
		-- if _ED.user_info ~= nil then
			-- if _ED.user_info.user_id ~= nil then
				-- userid = _ED.user_info.user_id
			-- end
		-- end
	-- end
	-- local _date,_time = getDateAndTime()
	-- local platform_extras1 = getJttdExtras()
    -- jttd.send_fighterNumericalInfo(
		-- fighter_numerical_info_params.fighter_numerical_info_explain[kingdom_index],-- explaining, 
		-- userid,							--userid, 
		-- fighter_numerical_info_params.fighter_actions[kingdom_index], 		--fighter_actions, 
		-- template_id,			--template_id, 
		-- count,				--count, 
		-- name,				--name, 
		-- _date,				--gameinfo_date, 
		-- _time,				--gameinfo_time, 
		-- getExtraInfo()		--extra
    -- )
end

-- END~fighter_numerical_info
-- ------------------------------------------------------------------------------------------
----------------------------------------- fighterAction ------------------------------------------
--recruit=1,
--dismiss=2,
--Strengthen=3,
--Strengthen_soul=4,
--Strengthen_soul_five=5,
--grow=6,
--fragment=7,
--load=8,
--unload=9
-- ------------------------------------------------------------------------------------------
fighter_action_params = {
    fighter_action_explain = tip_fighter_action_explain,

    fighter_actions = {
        "recruit",
		"dismiss",
		"Strengthen",
		"Strengthen_soul",
		"Strengthen_soul_five",
		"grow",
		"fragment",
		"load",
		"unload",
    }, 

    recruit=1,
	dismiss=2,
	Strengthen=3,
	Strengthen_soul=4,
	Strengthen_soul_five=5,
	grow=6,
	fragment=7,
	load=8,
	unload=9
}

function jttd.send_fighterAction(explaining, 
									userid, 
									counter,
									kingdom, 
									phylum,
									classfield,
									family,
									genus,
									extra,
									value,
									user_Level)
	
  -- local param = ""..getNilToString(explaining)..">"..
						-- "userid,"..getNilToString(userid).."|"..
						-- "counter,"..getNilToString(counter).."|"..
						-- "kingdom,"..getNilToString(kingdom).."|"..
						-- "phylum,"..getNilToString(phylum).."|"..
						-- "classfield,"..getNilToString(classfield).."|"..
						-- "family,"..getNilToString(family).."|"..
						-- "genus,"..getNilToString(genus).."|"..
						-- "extra,"..getNilToString(extra).."|"..
						-- "value,"..getNilToString(value).."|"..
						-- "user_Level,"..getNilToString(user_Level)
    -- jttd.custom(param)
end
-- 传进来的nil则显示"nil"
function jttd.fighterAction(kingdom_index,
								userid,
								phylum,
								classfield,
								family,
								genus,
								name,
								value,
								user_Level)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	
	-- local kingdom = "nil"
	-- local explaining = "nil" 
	
	-- if kingdom_index ~= nil and zstring.tonumber(kingdom_index) >0 and zstring.tonumber(kingdom_index) <= #fighter_action_params.fighter_action_explain then
		-- kingdom = fighter_action_params.fighter_actions[kingdom_index]
		-- explaining = fighter_action_params.fighter_action_explain[kingdom_index] 
	-- end
	
	-- if name == nil then
		-- name = "nil"
	-- end
	-- local extra = "name:"..name
	-- local counter = "ship"
    -- jttd.send_fighterAction(
		-- explaining, 
		-- userid,							  
		-- counter,												 
		-- kingdom, 		 
		-- phylum,
		-- classfield,
		-- family,
		-- genus,
		-- extra,
		-- value,
		-- user_Level
    -- )
	
end

-- END~fighter_action
-- ------------------------------------------------------------------------------------------

----------------------------------------- equip_numerical_info ------------------------------------------
-- ------------------------------------------------------------------------------------------

equip_numerical_info_params = {
    equip_numerical_info_explain = tip_equip_numerical_info_explain,

    equip_actions = {
        "acquire",
		"dismiss",
    }, 

    acquire=1,
	dismiss=2,
}

function jttd.send_equipNumericalInfo(explaining, userid, actions, template_id, count, name, _date, _time, extra)

  -- local param = ""..explaining..">"..
						-- "userid,"..userid.."|"..
						-- "actions,"..actions.."|"..
						-- "template_id,"..template_id.."|"..
						-- "count,"..count.."|"..
						-- "name,"..name.."|"..
						-- "date,".._date.."|"..
						-- "time,".._time.."|"..
						-- "extra,"..extra
    -- jttd.custom(param)
end

function jttd.equipNumericalInfo(kingdom_index,id,count)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	-- local userid = ""
	-- local template_id = ""
	-- local name = ""
	-- if id ~= nil then
		-- local equipInfo = fundUserEquipWidthId(id)
		-- template_id = equipInfo.user_equiment_template
		-- name = equipInfo.user_equiment_name
	-- end
	-- if count == nil then
		-- count = 1 
	-- end
	-- if _ED ~= nil then
		-- if _ED.user_info ~= nil then
			-- if _ED.user_info.user_grade ~= nil then
				-- user_Level = _ED.user_info.user_grade
			-- end
			-- if _ED.user_info.user_id ~= nil then
				-- userid = _ED.user_info.user_id
			-- end
		-- end
	-- end
	-- local _date,_time = getDateAndTime()
	-- local platform_extras1 = getJttdExtras()
    -- jttd.send_equipNumericalInfo(
		-- equip_numerical_info_params.equip_numerical_info_explain[kingdom_index],-- explaining, 
		-- userid,							--userid(就是手机识别码), 
		-- equip_numerical_info_params.equip_actions[kingdom_index], 		--fighter_actions, 
		-- template_id,			--template_id, 
		-- count,				--count, 
		-- name,				--name, 
		-- _date,				--gameinfo_date, 
		-- _time,				--gameinfo_time, 
		-- getExtraInfo()		--extra
    -- )
end

-- END~equip_numerical_info
-- ------------------------------------------------------------------------------------------

----------------------------------------- equip_action_info ------------------------------------------
-- ------------------------------------------------------------------------------------------

equip_action_info_params = {
    equip_action_info_explain = tip_equip_action_info_explain,

    equip_actions = {
       "LevelUp",
	   "Auto_LevelUp",
	   "rank",
	   "load",
	   "unload",
	   "compose",
	   "resolve",
    }, 

   LevelUp = 1,
   Auto_LevelUp = 2,
   rank = 3,
   load = 4,
   unload = 5,
   compose = 6,
   resolve = 7,

}

function jttd.send_equipActionInfo(explaining, 
									userid, 
									counter,
									kingdom, 
									phylum,
									classfield,
									family,
									genus,
									extra,
									value,
									user_Level)

  -- local param = ""..getNilToString(explaining)..">"..
						-- "userid,"..getNilToString(userid).."|"..
						-- "counter,"..getNilToString(counter).."|"..
						-- "kingdom,"..getNilToString(kingdom).."|"..
						-- "phylum,"..getNilToString(phylum).."|"..
						-- "classfield,"..getNilToString(classfield).."|"..
						-- "family,"..getNilToString(family).."|"..
						-- "genus,"..getNilToString(genus).."|"..
						-- "extra,"..getNilToString(extra).."|"..
						-- "value,"..getNilToString(value).."|"..
						-- "user_Level,"..getNilToString(user_Level)
    -- jttd.custom(param)
end

function jttd.equipActionInfo( kingdom_index,
								userid,
								phylum,
								classfield,
								family,
								genus,
								name,
								value,
								user_Level)
								
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	
	-- local kingdom = "nil"
	-- local explaining = "nil" 
	
	-- if kingdom_index ~= nil and zstring.tonumber(kingdom_index) >0 and zstring.tonumber(kingdom_index) <= #equip_action_info_params.equip_action_info_explain then
		-- kingdom = equip_action_info_params.equip_actions[kingdom_index]
		-- explaining = equip_action_info_params.equip_action_info_explain[kingdom_index] 
	-- end
	
	-- if name == nil then
		-- name = "nil"
	-- end
	-- local extra = "name:"..name
	-- local counter = "equipment"
    -- jttd.send_equipActionInfo(
		-- explaining, 
		-- userid,							  
		-- counter,												 
		-- kingdom,	 
		-- phylum,
		-- classfield,
		-- family,
		-- genus,
		-- extra,
		-- value,
		-- user_Level
    -- )
end

-- END~equip_action_info
-- ------------------------------------------------------------------------------------------
----------------------------------------- pvp_info ------------------------------------------
-- ------------------------------------------------------------------------------------------
pvp_info_params = {
    pvp_info_explain = tip_pvp_info_explain,

    pvp_actions = {
        "plunder",
		"arena",
		"duel"
    }, 

	plunder = 1,
	arena = 2,
	duel = 3
}

function jttd.send_pvpInfo(explaining, 
							userid, 
							counter,
							kingdom, 
							phylum,
							classfield,
							family,
							genus,
							extra,
							value,
							user_Level)

  -- local param = ""..getNilToString(explaining)..">"..
						-- "userid,"..getNilToString(userid).."|"..
						-- "counter,"..getNilToString(counter).."|"..
						-- "kingdom,"..getNilToString(kingdom).."|"..
						-- "phylum,"..getNilToString(phylum).."|"..
						-- "classfield,"..getNilToString(classfield).."|"..
						-- "family,"..getNilToString(family).."|"..
						-- "genus,"..getNilToString(genus).."|"..
						-- "extra,"..getNilToString(extra).."|"..
						-- "value,"..getNilToString(value).."|"..
						-- "user_Level,"..getNilToString(user_Level)
    -- jttd.custom(param)
end

function jttd.pvpInfo( kingdom_index,
							userid,
							phylum,
							classfield,
							family,
							genus,
							foeName,
							foeGrade,
							value,
							user_Level)
	-- if jttd.__sys._init ~= true then
		-- return
	-- end
	
	-- local kingdom = "nil"
	-- local explaining = "nil" 
	
	-- if kingdom_index ~= nil and zstring.tonumber(kingdom_index) >0 and zstring.tonumber(kingdom_index) <= #pvp_info_params.pvp_info_explain then
		-- kingdom = pvp_info_params.pvp_actions[kingdom_index]
		-- explaining = pvp_info_params.pvp_info_explain[kingdom_index] 
	-- end
	-- local extra = ""
	-- if foeName ~= nil and foeGrade ~= nil then
		-- extra = "name:"..foeName..",ul:"..foeGrade
	-- end
	-- local counter = "pvp"
    -- jttd.send_pvpInfo(
		-- explaining, 
		-- userid,							  
		-- counter,												 
		-- kingdom,	 
		-- phylum,
		-- classfield,
		-- family,
		-- genus,
		-- extra,
		-- value,
		-- user_Level
    -- )
end
--[[
kingdom_index,foeName,foeGrade,rankNum,win)
	local counter = "PVP"
	local phylum = ""
	local classfield = ""
	local family = ""
	local genus = ""
	local extra = ""
	local userid = ""
	if foeName ~= nil and foeGrade ~= nil then
		extra = "name:"..foeName..",ul:"..foeGrade
	end
	if win == true then
		classfield = "win"
	elseif win == false then
		classfield = "lose"
	end
	if _ED ~= nil then
		if _ED.user_info ~= nil then
			if _ED.user_info.user_grade ~= nil then
				user_Level = _ED.user_info.user_grade
			end
			
			if _ED.user_info.user_id ~= nil then
				userid = _ED.user_info.user_id
			end
		end
	end
	local platform_extras1 = getJttdExtras()
    jttd.send_pvpInfo(
		pvp_info_params.pvp_info_explain[kingdom_index],-- explaining, 
		userid,							--userid, 
		counter,
		pvp_info_params.pvp_actions[kingdom_index], 		--Kingdom, 
		phylum,
		classfield,
		family,
		genus,
		extra,
		rankNum,
		user_Level
    )
end
--]]
-- ------------------------------------------------------------------------------------------
----------------------------------------- new Data statistics ------------------------------------------
-- ------------------------------------------------------------------------------------------
-- /**
-- *追踪获赠的虚拟币(所有非充值赠送的宝石获得，包括充值赠送的宝石)
-- *number    虚拟币金额
-- *Reason    贈送虛擬幣原因，如充值额外赠送，xxx奖励额外领取
-- *例子    number = 1000   Reason = 竞技场成为第1名奖励钻石
-- */
function jttd.trackingGiftGodVirtualMoney(number,Reason)
	jttdconnect(CC_TALKINGDATA_REWARD_GOLD, ""..number.."|"..Reason)
end

-- /**
-- *記錄付費點（所有宝石消耗的点）
-- *Item    消费点名称
-- *itemNumber    消费的数量
-- *priceInVirtualCurrency    虚拟币单价
-- *例子    Item = 体力丹  itemNumber = 1  priceInVirtualCurrency = 25
-- */
function jttd.recordPayPoints(Item,itemNumber,priceInVirtualCurrency)
	jttdconnect(CC_TALKINGDATA_PURCHASE, ""..Item.."|"..itemNumber.."|"..priceInVirtualCurrency)
end

-- /**
-- *消耗物品或服务等（所有道具的使用）
-- *Item    物品名称
-- *itemNumber    消费的数量
-- *例子    Item = 体力丹  itemNumber = 1  
-- */
function jttd.consumableItems(Item,itemNumber)
	jttdconnect(CC_TALKINGDATA_USE, ""..Item.."|"..itemNumber)
end


-- /**
-- *副本开启
-- *missionId    副本名称
-- *例子    Item = 藍色龍之領地
-- */
function jttd.replicaScheduleBegin(missionId)
	jttdconnect(CC_TALKINGDATA_TASK_BEGIN, missionId)
end

-- /**
-- *副本完成
-- *missionId    副本名称
-- *例子    Item = 藍色龍之領地
-- */
function jttd.replicaScheduleCompleted(missionId)
	jttdconnect(CC_TALKINGDATA_TASK_COMPLETED, missionId)
end

-- /**
-- *副本失败
-- *missionId    副本名称
-- *例子    Item = 藍色龍之領地
-- */
function jttd.replicaScheduleFailed(missionId)
	jttdconnect(CC_TALKINGDATA_TASK_FAILED, missionId)
end

-- /**
-- *
-- *missionId    打点类型|打点内容
-- *例子    Item = 0|玩家点击礼包
-- */
function jttd.appEventsLogger(missionId)
	local logger = zstring.split(missionId, "|")
	if zstring.tonumber(logger[1]) == 0 then
		missionId = "教学|"..logger[2]
	end
	jttdconnect(CC_TALKINGDATA_CUSTOM_EVENT, missionId)
end	

function jttd.facebookAPPeventSlogger(missionId)
	local logger = zstring.split(missionId, "|")
	local missionInfo = ""
	if app.configJson.OperatorName == "t4" then
		--appsflyer和facebopok
		if tonumber(logger[1]) == 1 then
			--loading开始
			missionInfo = logger[1]
		elseif tonumber(logger[1]) == 2 then
			--loading结束
			missionInfo = logger[1]
		elseif tonumber(logger[1]) == 3 then
			--注册账号成功
			missionInfo = logger[1]..","..logger[2]
		elseif tonumber(logger[1]) == 4 then
			--点击开始游戏
			missionInfo = logger[1]..","..logger[2]
		elseif tonumber(logger[1]) == 5 then
			--创建角色
			missionInfo = logger[1]..","..logger[2]
		elseif tonumber(logger[1]) == 6 then
			--2-2完成
			missionInfo = logger[1]..","..logger[2]
		elseif tonumber(logger[1]) == 7 then	
			--支付
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		elseif tonumber(logger[1]) == 8 then
			--支付成功
			missionInfo = logger[1]
		elseif tonumber(logger[1]) == 9 then
			--支付失败
			missionInfo = logger[1]
		end
	elseif app.configJson.OperatorName == "cayenne" then
		--logger[1] = 编号，logger[2] = 用户id，logger[3] = 附加参数
		if tonumber(logger[1]) == 2 then
			-- 2.創建角色
			missionInfo = logger[1]..","..logger[2]
		elseif tonumber(logger[1]) == 3 then
			-- 3.新手教學完成
			missionInfo = logger[1]..","..logger[2]
		elseif tonumber(logger[1]) == 4 then
			-- 4.首次轉蛋
			--logger[3] 金币或者宝石
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		elseif tonumber(logger[1]) == 5 then
			-- 5.進程至旅程主線第4、8、11
			--logger[3] 章节数
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		elseif tonumber(logger[1]) == 6 then
			-- 6.首次付費
			--logger[3] 金额
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		elseif tonumber(logger[1]) == 7 then
			-- 7.付費金額
			--logger[3] 金额
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		elseif tonumber(logger[1]) == 8 then
			-- 8.VIP等級達到LV4，LV7，LV13
			--logger[3] vip等级
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		elseif tonumber(logger[1]) == 9 then
			-- 9.轉蛋次數
			--logger[3] 金币或者宝石
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		elseif tonumber(logger[1]) == 10 then
			-- 10.獲得4星數碼獸、獲得5星數碼獸、獲得6星數碼獸
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		elseif tonumber(logger[1]) == 11 then
			-- 11.競技場參與次數:10、50、100
			missionInfo = logger[1]..","..logger[2]..","..logger[3]
		end
	else
		local eventName = {
			"activate_open",	--啟動打開
			"register",			--註冊
			"novice_finish",	--新手完成
			"create_role",		--創建角色
			"imperial_3",		--主城3級
			"imperial_6",		--主城6級
			"imperial_16",		--主城16級
			"imperial_26",		--主城26級
			"imperial_30",		--主城30級
			"income",			--總收入
			"diamond1",			--充值档次1
			"diamond6",			--充值档次6
			"diamond5",			--充值档次5
			"diamond4",			--充值档次4
			"diamond3",			--充值档次3
			"diamond2",			--充值档次2
			"diamond_web1",     --其他平台充值档次1
			"diamond_web6",     --其他平台充值档次6
			"diamond_web5",     --其他平台充值档次5
			"diamond_web4",     --其他平台充值档次4
			"diamond_web3",     --其他平台充值档次3
			"diamond_web2",     --其他平台充值档次2
		}
		
		missionInfo = eventName[tonumber(logger[1])]
		if logger[2] ~= nil then
			missionInfo = missionInfo.."-"..logger[2]
		end
	end
	jttdconnect(CC_FACEBOOK_APPEVENTSLOGGER, missionInfo)
end

--missionId = "类型｜内容1｜内容2｜"
function jttd.NewAPPeventSlogger(missionId)
	local logger = zstring.split(missionId, "|")
	local eventName = {
		"register",	--1註冊
		"login,%s",			--2登陆
		"Reached leve,level %s",	--3等级达成
		"Clearance,barrier %s",		--4通关
		"get Digimon,DigimonId %s",		--5获得数码兽
		"Digimon Evolution,DigimonId %s Evolution into %s stage",	--6数码兽进化成
		"First time pay,Stalls %s",		--7第一次充值
		"Gold drawing,*%s",			--8黄金获得		
		"Diamond drawing,*%s",			--9钻石获得		
		"Gold consumption,*%s",		--10黄金消耗
		"Diamond consumption,*%s",		--11钻石消耗
		"Duplicate %s number of pass,*%s",		--12通关关卡的人数		
	}

	local missionInfo = ""
	missionInfo = eventName[tonumber(logger[1])]
	if logger[2] ~= nil then
		local info = ""
		if tonumber(logger[1]) == 6 or tonumber(logger[1]) == 12 then
			info = string.format(missionInfo, logger[2],logger[3])
		else
			info = string.format(missionInfo, logger[2])
		end
		missionInfo = info
	end
	if tonumber(logger[1]) == 7 then
		missionInfo = "2,"..missionInfo
	else
		if m_first_role == false then
			missionInfo = "1,"..missionInfo
		else
			missionInfo = "0,"..missionInfo
		end
	end

	jttdconnect(CC_DATA_STATISTICS, missionInfo)
end

-- 类型,内容
function jttd.myDataSubmitted(m_type,m_data)
	local package_version = cc.UserDefault:getInstance():getStringForKey("package")
	if package_version == nil or package_version == "" then
		package_version = "0"
	end
	local strs = ""
	if zstring.tonumber(m_type) == 1 then
		--LAUNCH_FIRST	首次启动,LAUNCH	启动
		local LAUNCH = cc.UserDefault:getInstance():getStringForKey("LAUNCH")
   		if LAUNCH == nil or LAUNCH == "" then
   			-- if zstring.tonumber(package_version) ~= 0 then
   			-- 	strs = "LAUNCH".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   			-- else
   				strs = "LAUNCH_FIRST".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   			-- end
   			cc.UserDefault:getInstance():setStringForKey("LAUNCH", "LAUNCH")
			cc.UserDefault:getInstance():flush()
   		else
   			strs = "LAUNCH".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   		end
	elseif zstring.tonumber(m_type) == 2 then 
		--RESOURCE_UPDATE_FIRST_START	首次更新开始,RESOURCE_UPDATE_START	更新开始
		local LAUNCH = cc.UserDefault:getInstance():getStringForKey("RESOURCE_UPDATE_START")
   		if LAUNCH == nil or LAUNCH == "" then
   			if zstring.tonumber(package_version) ~= 0 then
   				strs = "RESOURCE_UPDATE_START".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   			else
   				jttd.RESOURCE_UPDATE_FIRST_START = 1
   				strs = "RESOURCE_UPDATE_FIRST_START".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   			end
   			cc.UserDefault:getInstance():setStringForKey("RESOURCE_UPDATE_START", "RESOURCE_UPDATE_START")
			cc.UserDefault:getInstance():flush()
   		else
   			strs = "RESOURCE_UPDATE_START".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   		end
	elseif zstring.tonumber(m_type) == 3 then 
		--RESOURCE_UPDATE_FIRST_SUCCESS	首次更新成功,RESOURCE_UPDATE_SUCCESS	更新成功
		local LAUNCH = cc.UserDefault:getInstance():getStringForKey("RESOURCE_UPDATE_SUCCESS")
   		if LAUNCH == nil or LAUNCH == "" then
   			if zstring.tonumber(jttd.RESOURCE_UPDATE_FIRST_START) <= 0 then
   				strs = "RESOURCE_UPDATE_SUCCESS".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   			else
   				jttd.RESOURCE_UPDATE_FIRST_START = 0
   				strs = "RESOURCE_UPDATE_FIRST_SUCCESS".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   			end
   			cc.UserDefault:getInstance():setStringForKey("RESOURCE_UPDATE_SUCCESS", "RESOURCE_UPDATE_SUCCESS")
			cc.UserDefault:getInstance():flush()
   		else
   			strs = "RESOURCE_UPDATE_SUCCESS".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".."\r\n"
   		end
	elseif zstring.tonumber(m_type) == 4 then 
		--ACCOUNT_REGISTER_FRIST	首次注册账号,ACCOUNT_REGISTER	注册账号
		local _datas = zstring.split(m_data,",")
		local LAUNCH = cc.UserDefault:getInstance():getStringForKey("ACCOUNT_REGISTER")
   		if LAUNCH == nil or LAUNCH == "" then
   			-- if zstring.tonumber(package_version) ~= 0 then
   			-- 	strs = "ACCOUNT_REGISTER".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".._datas[1].."\r\n".._datas[2]
   			-- else
   				strs = "ACCOUNT_REGISTER_FRIST".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".._datas[1].."\r\n".._datas[2]
   			-- end
   			cc.UserDefault:getInstance():setStringForKey("ACCOUNT_REGISTER", "ACCOUNT_REGISTER")
			cc.UserDefault:getInstance():flush()
   		else
   			strs = "ACCOUNT_REGISTER".."\r\n"..app.configJson.version.."\r\n"..package_version.."\r\n".._datas[1].."\r\n".._datas[2]
   		end
	end
	NetworkView:reconnectErase(nil)
	protocol_command.bi_forward.param_list = strs
    NetworkManager:register(protocol_command.bi_forward.code, app.configJson.urlForAnnounce, nil, nil, nil, nil, false, nil)
end
-- END~pvp_info
-- ------------------------------------------------------------------------------------------
-- END
-- ----------------------------------------------------------------------------------------------------
