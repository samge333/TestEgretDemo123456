// environment_ship = {
// 	id = 1,									--	int(11)	Not null	主键，自增长
// 	captain_type = 2,					--	tinyint(4)		船长类型
// 	camp_preference = 3,			--	tinyint(4)		向性
// 	ship_name = 4,						--	varchar(16)		战船名称
// 	level = 5,								--	tinyint(4)		战船级别
// 	gender = 6,							--	tinyint(4)		性别(0:无 1:男 2:女)
// 	common_skill_mould = 7,		--	int(11)		普通技能模板
// 	skill_mould = 8,					--	int(11)		拥有技能，技能模版外键
// 	skill_name = 9,						--	varchar(16)		技能名称
// 	skill_describe = 10,				--	varchar(255)		技能描述
// 	ship_type = 11,						--	tinyint(4)		战船类型，0为白色战船，1为绿色战船，2为蓝色战船，3为紫色战船，4为橙色战船(卡牌低框)
// 	power = 12,							--	float		生命
// 	courage = 13,						--	float		攻击
// 	intellect = 14,						--	float		物防
// 	nimable = 15,						--	float		法防
// 	critical = 16,							--	float		暴击
// 	critical_resist = 17,				--	float		抗暴
// 	jink = 18,								--	float		闪避
// 	accuracy = 19,						--	float		命中
// 	retain = 20,							--	float		格挡
// 	retain_break = 21,					--	float		破击
// 	have_deadly = 22,					--			是否有怒气
// 	grow_power = 23,					--	int		体力成长参数，战船成长参数外键
// 	grow_courage = 24,				--	int		勇气成长参数，战船成长参数外键
// 	grow_intellect = 25,				--	int		智力成长参数，战船成长参数外键
// 	grow_nimable = 26,				--	int		敏捷成长参数，战船成长参数外键
// 	pic_index = 27,						--	varchar(255)		图片索引
// 	bust_index = 28,				--	Int(11)		半身像下标
// 	physics_attack_effect = 29,		--	int		物理攻击特效
// 	screen_attack_effect = 30,		--	int		屏幕攻击特效
// 	physics_attack_mode = 31,		--	tinyint(4)		物理攻击模式
// 	skill_attack_mode = 32,			--	tinyint(4)		技能攻击模式
// 	reward_card = 33,					--	int(11)		掉落卡片
// 	reward_card_ratio = 34,			--	int(11)		掉落几率
// 	talent_mould = 35,				-- varchar(255)		天赋模板
// 	capacity = 36,					-- int			战船标识(0:攻击型；1:防御型； 2：辅助型)
// 	directing = 37,					-- int 	战场模板指向
// 	drop_prop = 38,					--	int(11)		掉落道具
// 	drop_prop_ratio = 39,			--	int(11)		掉落概率
// 	drop_equipment = 40,			--	int(11)		掉落装备
// 	drop_equipment_ratio = 41,		--	int(11)		掉落概率
// 	sign_type = 42,					--	int(11)		BOSS标识
// 	sign_pic = 43,					--	int(11)		形象索引
// 	drop_items = 44 ,				--	vachar(255)		掉落库
// 	speed = 45,						--	int(11)		攻击
// 	common_attack_add_sp = 46,		--	int(11)		普攻回怒
// 	frist_drop_items = 47 ,			--	vachar(255)		首胜掉落库
// 	sound_index = 48,				--	int(11) 声音索引
// }
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var enumEnvironmentShip;
(function (enumEnvironmentShip) {
    enumEnvironmentShip[enumEnvironmentShip["id"] = 1] = "id";
    enumEnvironmentShip[enumEnvironmentShip["captain_type"] = 2] = "captain_type";
    enumEnvironmentShip[enumEnvironmentShip["camp_preference"] = 3] = "camp_preference";
    enumEnvironmentShip[enumEnvironmentShip["ship_name"] = 4] = "ship_name";
    enumEnvironmentShip[enumEnvironmentShip["level"] = 5] = "level";
    enumEnvironmentShip[enumEnvironmentShip["gender"] = 6] = "gender";
    enumEnvironmentShip[enumEnvironmentShip["common_skill_mould"] = 7] = "common_skill_mould";
    enumEnvironmentShip[enumEnvironmentShip["skill_mould"] = 8] = "skill_mould";
    enumEnvironmentShip[enumEnvironmentShip["skill_name"] = 9] = "skill_name";
    enumEnvironmentShip[enumEnvironmentShip["skill_describe"] = 10] = "skill_describe";
    enumEnvironmentShip[enumEnvironmentShip["ship_type"] = 11] = "ship_type";
    enumEnvironmentShip[enumEnvironmentShip["power"] = 12] = "power";
    enumEnvironmentShip[enumEnvironmentShip["courage"] = 13] = "courage";
    enumEnvironmentShip[enumEnvironmentShip["intellect"] = 14] = "intellect";
    enumEnvironmentShip[enumEnvironmentShip["nimable"] = 15] = "nimable";
    enumEnvironmentShip[enumEnvironmentShip["critical"] = 16] = "critical";
    enumEnvironmentShip[enumEnvironmentShip["critical_resist"] = 17] = "critical_resist";
    enumEnvironmentShip[enumEnvironmentShip["jink"] = 18] = "jink";
    enumEnvironmentShip[enumEnvironmentShip["accuracy"] = 19] = "accuracy";
    enumEnvironmentShip[enumEnvironmentShip["retain"] = 20] = "retain";
    enumEnvironmentShip[enumEnvironmentShip["retain_break"] = 21] = "retain_break";
    enumEnvironmentShip[enumEnvironmentShip["have_deadly"] = 22] = "have_deadly";
    enumEnvironmentShip[enumEnvironmentShip["grow_power"] = 23] = "grow_power";
    enumEnvironmentShip[enumEnvironmentShip["grow_courage"] = 24] = "grow_courage";
    enumEnvironmentShip[enumEnvironmentShip["grow_intellect"] = 25] = "grow_intellect";
    enumEnvironmentShip[enumEnvironmentShip["grow_nimable"] = 26] = "grow_nimable";
    enumEnvironmentShip[enumEnvironmentShip["pic_index"] = 27] = "pic_index";
    enumEnvironmentShip[enumEnvironmentShip["bust_index"] = 28] = "bust_index";
    enumEnvironmentShip[enumEnvironmentShip["physics_attack_effect"] = 29] = "physics_attack_effect";
    enumEnvironmentShip[enumEnvironmentShip["screen_attack_effect"] = 30] = "screen_attack_effect";
    enumEnvironmentShip[enumEnvironmentShip["physics_attack_mode"] = 31] = "physics_attack_mode";
    enumEnvironmentShip[enumEnvironmentShip["skill_attack_mode"] = 32] = "skill_attack_mode";
    enumEnvironmentShip[enumEnvironmentShip["reward_card"] = 33] = "reward_card";
    enumEnvironmentShip[enumEnvironmentShip["reward_card_ratio"] = 34] = "reward_card_ratio";
    enumEnvironmentShip[enumEnvironmentShip["talent_mould"] = 35] = "talent_mould";
    enumEnvironmentShip[enumEnvironmentShip["capacity"] = 36] = "capacity";
    enumEnvironmentShip[enumEnvironmentShip["directing"] = 37] = "directing";
    enumEnvironmentShip[enumEnvironmentShip["drop_prop"] = 38] = "drop_prop";
    enumEnvironmentShip[enumEnvironmentShip["drop_prop_ratio"] = 39] = "drop_prop_ratio";
    enumEnvironmentShip[enumEnvironmentShip["drop_equipment"] = 40] = "drop_equipment";
    enumEnvironmentShip[enumEnvironmentShip["drop_equipment_ratio"] = 41] = "drop_equipment_ratio";
    enumEnvironmentShip[enumEnvironmentShip["sign_type"] = 42] = "sign_type";
    enumEnvironmentShip[enumEnvironmentShip["sign_pic"] = 43] = "sign_pic";
})(enumEnvironmentShip || (enumEnvironmentShip = {}));
var EnvironmentShip = (function () {
    function EnvironmentShip() {
    }
    EnvironmentShip.prototype.init = function (row) {
        this.id = row[0];
        this.captainType = row[1];
        this.campPreference = row[2];
        this.shipName = row[3];
        this.level = row[4];
        this.gender = row[5];
        this.commonSkillMould = row[6];
        this.skillMould = row[7];
        this.skillName = row[8];
        this.skillDescribe = row[9];
        this.shipType = row[10];
        this.power = row[11];
        this.courage = row[12];
        this.intellect = row[13];
        this.nimable = row[14];
        this.critical = row[15];
        this.criticalResist = row[16];
        this.jink = row[17];
        this.accuracy = row[18];
        this.retain = row[19];
        this.retainBreak = row[20];
        this.haveDeadly = row[21];
        this.growPower = row[22];
        this.growCourage = row[23];
        this.growIntellect = row[24];
        this.growNimable = row[25];
        this.picIndex = row[26];
        this.bustIndex = row[27];
        this.physicsAttackEffect = row[28];
        this.screenAttackEffect = row[29];
        this.physicsAttackMode = row[30];
        this.skillAttackMode = row[31];
        this.rewardCard = row[32];
        this.rewardCardRatio = row[33];
        this.talentMould = row[34];
        this.capacity = row[35];
        this.directing = row[36];
        this.dropProp = row[37];
        this.dropPropRatio = row[38];
        this.dropEquipment = row[39];
        this.dropEquipmentRatio = row[40];
        this.signType = row[41];
        this.signPic = row[42];
    };
    return EnvironmentShip;
}());
__reflect(EnvironmentShip.prototype, "EnvironmentShip");
//# sourceMappingURL=EnvironmentShip.js.map