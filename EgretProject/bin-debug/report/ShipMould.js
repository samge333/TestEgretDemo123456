// ship_mould = {
// 	id = 1,						--	int(11)	Not null	主键，自增长
// 	captain_name = 2,			--	varchar(32)		主角名称
// 	camp_preference = 3,		--	tinyint(4)		向性, 0无,1魏,2蜀,3吴,4群	(深海，帝国，白鹰，黑旗)
// 	captain_type = 4,			--	tinyint(4)		伙伴类型, 0主角,1武将,2杂兵3 宠物
// 	hero_gender = 5,			--	tinyint(4)		伙伴性别, 0无,1男,2女
// 	is_general = 6,				--	tinyint(4)		是否为名将,0否,1是
// 	ship_name = 7,				--	varchar(16)		船名
// 	can_recruit = 8,			--	tinyint(4)		是否能招募
// 	ability = 9,				--	int		资质
// 	leader = 10,					--	int		统帅
// 	force = 11,					--	int		武力
// 	wisdom = 12,					--	int		智慧
// 	initial_power = 13,			--	float		初始生命值
// 	initial_courage = 14,		--	float		初始攻击
// 	initial_intellect = 15,		--	float		初始物防
// 	initial_nimable = 16,		--	float		初始法防
// 	initial_critical = 17,		--	float		初始暴击
// 	initial_critical_resist = 18,--	float		初始抗暴
// 	initial_jink = 19,			--	float		初始闪避
// 	initial_accuracy = 20,		--	float		初始命中
// 	initial_retain = 21,			--	float		初始格挡
// 	initial_retain_break = 22,	--	float		初始破击
// 	have_deadly = 23,			--	float		是否有怒气
// 	grow_power = 24,				--	int		生命成长
// 	grow_courage = 25,			--	int		攻击成长
// 	grow_intellect = 26,			--	int		物防成长
// 	grow_nimable = 27,			--	int		法防成长
// 	skill_mould = 28,			--	int(11)		普通技能模板
// 	deadly_skill_mould = 29,		--	int		怒气技能模板
// 	relationship_id = 30,		--	varchar(50)		羁绊模板ID
// 	talent_id = 31,				--	varchar(50)		天赋模板ID
// 	talent_activite_need = 32,	--	varchar(50)		天赋激活需求进阶等级
// 	skill_name = 33,				--	varchar(16)		技能名称
// 	skill_describe = 34,			--	varchar(255)		技能描述
// 	boatyard_level = 35,			--	tinyint(4)		所需要船坞等级
// 	ship_type = 36,				--	tinyint(4)		角色颜色品质
// 	ship_pic = 37,				--	varchar(255)		角色形象索引
// 	price = 38,					--	int		价格
// 	need_honor = 39,				--	int		所需荣耀值
// 	physics_attack_effect = 40,	--	int		物理攻击特效
// 	screen_attack_effect = 41,	--	int		怒气技能特写
// 	physics_attack_mode = 42,	--	tinyint(4)		物理攻击模式
// 	skill_attack_mode = 43,		--	tinyint(4)		技能攻击模式
// 	initial_level = 44,			--	tinyint(4)		初始等级
// 	initial_rank_level = 45,		--	int		初始进阶等级
// 	rank_grow_up_limit = 46,		--	int		进阶等级上限
// 	grow_target_id = 47,			--	Int(11)		进阶成长id(进阶成长加成表) 
// 	required_material_id = 48,	--	Int(11)		进阶需求索引(进阶需求表)
// 	ship_star = 49,				--	tinyint(4)		武将星级
// 	head_icon = 50,				--	Int(11)		头像图标
// 	bust_index = 51,				--	Int(11)		半身像下标
// 	All_icon = 52,				--	Int(11)		全身图下标
// 	base_mould = 53,				--	Int(11)		相同英雄标识
// 	introduce = 54,				--	varchar(255)		简介文字
// 	initial_experience_supply = 55,--	int		提供初始经验
// 	sell_get_money = 56,			--	int		卖出获得银币
// 	refine_get_soul = 57,		--	int		炼化获得将魂, 
// 	refine_get_jade = 58,		--	int		炼化获得魂玉
// 	way_of_gain = 59,			--	text		获得途径 --数码宝贝显示升级头像
// 	capacity = 60,				-- int			战船标识(0:无；1:物攻型；2:法攻型 3:防御型；4:辅助型)
// 	base_mould2 = 61,		-- int 			相同英雄标识2
// 	base_mould_priority = 62,			-- int 			查找权重
// 	cultivate_property_id = 63,		--	Int	0	培养属性id
// 	zoarium_skill = 64,				--	int(11)	0	合体技
// 	trace_address = 65,			--	varchar(255)		追踪地址(1,2..)
// 	prime_mover = 66,			--  int(11) 合体技发动者
// 	sound_index = 67,			--	int(11) 声音索引
// 	sign_msg = 68,				-- varchar(255)描述签名
// 	arena_init = 69,			-- tinyint		竞技场初始出现(0:不出现 1:出现)
// 	movement = 70,			-- int(11)		战船动作帧组
// 	fitSkillOne = 71,		-- int(11)		合体技能1
// 	fitSkillTwo = 72,		-- int(11)		合体技能1
// 	treasureSkill = 73,		-- int(11)		装备id
// 	max_rank_level = 74,    -- int(11)		最大觉醒等级
// 	faction_id = 75,		-- int(11)		种族
// 	attribute_id = 76,    -- int(11)		属性
// 	null_1 = 77, 		   -- int(11)		备用
// 	null_2 = 78,    		-- int(11)		备用
// 	skill_mould_info = 79,  -- varchar(255)	技能模板索引列表
// }
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var enmShipMould;
(function (enmShipMould) {
    enmShipMould[enmShipMould["id"] = 1] = "id";
    enmShipMould[enmShipMould["captain_name"] = 2] = "captain_name";
    enmShipMould[enmShipMould["camp_preference"] = 3] = "camp_preference";
    enmShipMould[enmShipMould["captain_type"] = 4] = "captain_type";
    enmShipMould[enmShipMould["hero_gender"] = 5] = "hero_gender";
    enmShipMould[enmShipMould["is_general"] = 6] = "is_general";
    enmShipMould[enmShipMould["ship_name"] = 7] = "ship_name";
    enmShipMould[enmShipMould["can_recruit"] = 8] = "can_recruit";
    enmShipMould[enmShipMould["ability"] = 9] = "ability";
    enmShipMould[enmShipMould["leader"] = 10] = "leader";
    enmShipMould[enmShipMould["force"] = 11] = "force";
    enmShipMould[enmShipMould["wisdom"] = 12] = "wisdom";
    enmShipMould[enmShipMould["initial_power"] = 13] = "initial_power";
    enmShipMould[enmShipMould["initial_courage"] = 14] = "initial_courage";
    enmShipMould[enmShipMould["initial_intellect"] = 15] = "initial_intellect";
    enmShipMould[enmShipMould["initial_nimable"] = 16] = "initial_nimable";
    enmShipMould[enmShipMould["initial_critical"] = 17] = "initial_critical";
    enmShipMould[enmShipMould["initial_critical_resist"] = 18] = "initial_critical_resist";
    enmShipMould[enmShipMould["initial_jink"] = 19] = "initial_jink";
    enmShipMould[enmShipMould["initial_accuracy"] = 20] = "initial_accuracy";
    enmShipMould[enmShipMould["initial_retain"] = 21] = "initial_retain";
    enmShipMould[enmShipMould["initial_retain_break"] = 22] = "initial_retain_break";
    enmShipMould[enmShipMould["have_deadly"] = 23] = "have_deadly";
    enmShipMould[enmShipMould["grow_power"] = 24] = "grow_power";
    enmShipMould[enmShipMould["grow_courage"] = 25] = "grow_courage";
    enmShipMould[enmShipMould["grow_intellect"] = 26] = "grow_intellect";
    enmShipMould[enmShipMould["grow_nimable"] = 27] = "grow_nimable";
    enmShipMould[enmShipMould["skill_mould"] = 28] = "skill_mould";
    enmShipMould[enmShipMould["deadly_skill_mould"] = 29] = "deadly_skill_mould";
    enmShipMould[enmShipMould["relationship_id"] = 30] = "relationship_id";
    enmShipMould[enmShipMould["talent_id"] = 31] = "talent_id";
    enmShipMould[enmShipMould["talent_activite_need"] = 32] = "talent_activite_need";
    enmShipMould[enmShipMould["skill_name"] = 33] = "skill_name";
    enmShipMould[enmShipMould["skill_describe"] = 34] = "skill_describe";
    enmShipMould[enmShipMould["boatyard_level"] = 35] = "boatyard_level";
    enmShipMould[enmShipMould["ship_type"] = 36] = "ship_type";
    enmShipMould[enmShipMould["ship_pic"] = 37] = "ship_pic";
    enmShipMould[enmShipMould["price"] = 38] = "price";
    enmShipMould[enmShipMould["need_honor"] = 39] = "need_honor";
    enmShipMould[enmShipMould["physics_attack_effect"] = 40] = "physics_attack_effect";
    enmShipMould[enmShipMould["screen_attack_effect"] = 41] = "screen_attack_effect";
    enmShipMould[enmShipMould["physics_attack_mode"] = 42] = "physics_attack_mode";
    enmShipMould[enmShipMould["skill_attack_mode"] = 43] = "skill_attack_mode";
    enmShipMould[enmShipMould["initial_level"] = 44] = "initial_level";
    enmShipMould[enmShipMould["initial_rank_level"] = 45] = "initial_rank_level";
    enmShipMould[enmShipMould["rank_grow_up_limit"] = 46] = "rank_grow_up_limit";
    enmShipMould[enmShipMould["grow_target_id"] = 47] = "grow_target_id";
    enmShipMould[enmShipMould["required_material_id"] = 48] = "required_material_id";
    enmShipMould[enmShipMould["ship_star"] = 49] = "ship_star";
    enmShipMould[enmShipMould["head_icon"] = 50] = "head_icon";
    enmShipMould[enmShipMould["bust_index"] = 51] = "bust_index";
    enmShipMould[enmShipMould["All_icon"] = 52] = "All_icon";
    enmShipMould[enmShipMould["base_mould"] = 53] = "base_mould";
    enmShipMould[enmShipMould["introduce"] = 54] = "introduce";
    enmShipMould[enmShipMould["initial_experience_supply"] = 55] = "initial_experience_supply";
    enmShipMould[enmShipMould["sell_get_money"] = 56] = "sell_get_money";
    enmShipMould[enmShipMould["refine_get_soul"] = 57] = "refine_get_soul";
    enmShipMould[enmShipMould["refine_get_jade"] = 58] = "refine_get_jade";
    enmShipMould[enmShipMould["way_of_gain"] = 59] = "way_of_gain";
    enmShipMould[enmShipMould["capacity"] = 60] = "capacity";
    enmShipMould[enmShipMould["base_mould2"] = 61] = "base_mould2";
    enmShipMould[enmShipMould["base_mould_priority"] = 62] = "base_mould_priority";
    enmShipMould[enmShipMould["cultivate_property_id"] = 63] = "cultivate_property_id";
    enmShipMould[enmShipMould["zoarium_skill"] = 64] = "zoarium_skill";
    enmShipMould[enmShipMould["trace_address"] = 65] = "trace_address";
    enmShipMould[enmShipMould["prime_mover"] = 66] = "prime_mover";
    enmShipMould[enmShipMould["sound_index"] = 67] = "sound_index";
    enmShipMould[enmShipMould["sign_msg"] = 68] = "sign_msg";
    enmShipMould[enmShipMould["arena_init"] = 69] = "arena_init";
    enmShipMould[enmShipMould["movement"] = 70] = "movement";
    enmShipMould[enmShipMould["fitSkillOne"] = 71] = "fitSkillOne";
    enmShipMould[enmShipMould["fitSkillTwo"] = 72] = "fitSkillTwo";
    enmShipMould[enmShipMould["treasureSkill"] = 73] = "treasureSkill";
    enmShipMould[enmShipMould["max_rank_level"] = 74] = "max_rank_level";
    enmShipMould[enmShipMould["faction_id"] = 75] = "faction_id";
    enmShipMould[enmShipMould["attribute_id"] = 76] = "attribute_id";
    enmShipMould[enmShipMould["null_1"] = 77] = "null_1";
    enmShipMould[enmShipMould["null_2"] = 78] = "null_2";
    enmShipMould[enmShipMould["skill_mould_info"] = 79] = "skill_mould_info";
})(enmShipMould || (enmShipMould = {}));
var ShipMould = (function () {
    function ShipMould() {
    }
    ShipMould.prototype.init = function (row) {
        this.id = row[0];
        this.captainName = row[1];
        this.campPreference = row[2];
        this.captainType = row[3];
        this.heroGender = row[4];
        this.isGeneral = row[5];
        this.shipName = row[6];
        this.canRecruit = row[7];
        this.ability = row[8];
        this.leader = row[9];
        this.strength = row[10];
        this.wisdom = row[11];
        this.initialPower = row[12];
        this.initialCourage = row[13];
        this.initialIntellect = row[14];
        this.initialNimable = row[15];
        this.initialCritical = row[16];
        this.initialCriticalResist = row[17];
        this.initialJink = row[18];
        this.initialAccuracy = row[19];
        this.initialRetain = row[20];
        this.initialRetainBreak = row[21];
        this.haveDeadly = row[22];
        this.growPower = row[23];
        this.growCourage = row[24];
        this.growIntellect = row[25];
        this.growNimable = row[26];
        this.skillMould = row[27];
        this.deadlySkillMould = row[28];
        this.relationshipId = row[29];
        this.talentId = row[30];
        this.talentActiviteNeed = row[31];
        this.skillName = row[32];
        this.skillDescribe = row[33];
        this.boatyardLevel = row[34];
        this.shipType = row[35];
        this.shipPic = row[36];
        this.price = row[37];
        this.needHonor = row[38];
        this.physicsAttackEffect = row[39];
        this.screenAttackEffect = row[40];
        this.physicsAttackMode = row[41];
        this.skillAttackMode = row[42];
        this.initialLevel = row[43];
        this.initialRankLevel = row[44];
        this.rankGrowUpLimit = row[45];
        this.growTargetId = row[46];
        this.requiredMaterialId = row[47];
        this.shipStar = row[48];
        this.headIcon = row[49];
        this.bustIndex = row[50];
        this.allIcon = row[51];
        this.baseMould = row[52];
        this.introduce = row[53];
        this.initialExperienceSupply = row[54];
        this.sellGetMoney = row[55];
        this.refineGetSoul = row[56];
        this.refineGetJade = row[57];
        this.wayOfGain = row[58];
        this.capacity = row[59];
        this.baseMould2 = row[60];
        this.baseMouldPriority = row[61];
        this.cultivatePropertyId = row[62];
        this.zoariumSkill = row[63];
        this.traceAddress = row[64];
        this.primeMover = row[65];
        this.soundIndex = row[66];
        this.signMsg = row[67];
        this.arenaInit = row[68];
    };
    return ShipMould;
}());
__reflect(ShipMould.prototype, "ShipMould");
//# sourceMappingURL=ShipMould.js.map