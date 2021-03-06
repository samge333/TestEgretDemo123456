// environment_formation = {
// 	id = 1,									--int(11)	Not null	主键，自增长
// 	formation_name = 2,				--varchar(255)		阵型名称
// 	can_battle_operate = 3,			-- tinyint(4)		战前可否操作阵型(0:否 1:可)
// 	battle_round_limit = 4,			-- tinyint(4)		战斗回合上限
// 	pic_index = 5,						-- varchar(40)		图片索引
// 	fight_bg = 6,						-- int(11)		战斗背景
// 	level = 7,								-- tinyint(4)		环境战船阵型显示的等级
// 	seat_one = 8,						-- int(11)		阵型位置一，environment_ship表外键
// 	seat_two = 9,						-- int(11)		阵型位置二，environment_ship表外键
// 	seat_three = 10,						-- int(11)		阵型位置三，environment_ship表外键
// 	seat_four = 11,						-- int(11)		阵型位置四，environment_ship表外键
// 	seat_five = 12,						-- int(11)		阵型位置五，environment_ship表外键
// 	seat_six = 13,						-- int(11)		阵型位置六，environment_ship表外键
// 	seat_seven = 14,					-- int(11)		阵型位置七，environment_ship表外键
// 	seat_eight = 15,					-- int(11)		阵型位置八，environment_ship表外键
// 	seat_nine = 16,						-- int(11)		阵型位置九，environment_ship表外键
// 	amplify_percentage = 17,		-- varchar(255)		卡牌放大比例
// 	get_of_experience = 18,			-- int		提供船只经验值
// 	get_of_repute = 19,				-- int		提供声望值
// 	get_of_silver = 20,					-- int		提供银币
// 	get_of_prop1 = 21,				-- int		提供道具1ID
// 	prop_odds1 = 22,					-- tinyint(4)		提供道具1几率
// 	get_of_prop1_count = 23,		-- int(11)		提供道具1数量
// 	get_of_prop2 = 24,				-- int		提供道具2ID
// 	prop_odds2 = 25,					-- tinyint(4)		提供道具几率
// 	get_of_prop2_count = 26,		-- int(11)		提供道具2数量
// 	get_of_prop3 = 27,				-- int		提供道具3ID
// 	prop_odds3 = 28,					-- tinyint(4)		提供道具3几率
// 	get_of_prop3_count = 29,		-- int(11)		提供道具3数量
// 	get_of_prop4 = 30,				-- int		提供道具4ID
// 	prop_odds4 = 31,					-- tinyint(4)		提供道具4几率
// 	get_of_prop4_count = 32,		-- int(11)		提供道具4数量
// 	get_of_prop5 = 33,				-- int		提供道具5ID
// 	prop_odds5 = 34,					-- tinyint(4)		提供道具5几率
// 	get_of_prop5_count = 35,			-- int(11)		提供道具5数量
// 	get_of_equipment = 36,				-- int		提供装备6ID
// 	equipment_odds = 37,				-- tinyint(4)		提供装备6几率
// 	get_of_equipment_count = 38,		-- int(11)		提供装备6数量
// 	battle_failed_guide = 39,				-- varchar(40)		战斗失败指引
// 	daily_attack_count = 40,				-- int(11)		每日可攻击次数(-1为不限次数)
// 	first_reward_group = 41,				-- tinyint(4)		 首次奖励库组
// 	combat_force = 42,					--	int(11)		战斗力
// 	initiative = 43,					--		int(11)		先攻等级
// 	defence = 44,					--		int(11)		防御等级
// 	evade = 45,						--		int(11)		闪避等级
// 	authority = 46,					--		int(11)		王者等级
// 	seat_10 = 47,					--		int(11)		阵型位置10，environment_ship表外键
// 	seat_11 = 48,					--		int(11)		阵型位置11，environment_ship表外键
// 	seat_12 = 49,					--		int(11)		阵型位置12，environment_ship表外键
// 	seat_13 = 50,					--		int(11)		阵型位置13，environment_ship表外键
// 	seat_14 = 51,					--		int(11)		阵型位置14，environment_ship表外键
// 	seat_15 = 52,					--		int(11)		阵型位置15，environment_ship表外键
// 	seat_16 = 53,					--		int(11)		阵型位置16，environment_ship表外键
// 	seat_17 = 54,					--		int(11)		阵型位置17，environment_ship表外键
// 	seat_18 = 55,					--		int(11)		阵型位置18，environment_ship表外键
// 	seat_19 = 56,					--		int(11)		阵型位置19，environment_ship表外键
// 	seat_20 = 57,					--		int(11)		阵型位20，environment_ship表外键
// 	seat_21 = 58,					--		int(11)		阵型位置21，environment_ship表外键

// }

// self.id = tonumber( row[1] )
//     self.formationName = row[2]
//     self.canBattleOperate = tonumber( row[3] )
//     self.battleRoundLimit = tonumber( row[4] )
//     self.picIndex = row[5]
//     self.fightBg = tonumber( row[6] )
//     self.level = tonumber( row[7] )
//     self.seatOne = tonumber( row[8] )
//     self.seatTwo = tonumber( row[9] )
//     self.seatThree = tonumber( row[10] )
//     self.seatFour = tonumber( row[11] )
//     self.seatFive = tonumber( row[12] )
//     self.seatSix = tonumber( row[13] )
//     self.seatSeven = tonumber( row[14] )
//     self.seatEight = tonumber( row[15] )
//     self.seatNine = tonumber( row[16] )
//     self.amplifyPercentage = row[17]
//     self.getOfExperience = tonumber( row[18] )
//     self.getOfRepute = tonumber( row[19] )
//     self.getOfSilver = tonumber( row[20] )
//     self.getOfProp1 = tonumber( row[21] )
//     self.propOdds1 = tonumber( row[22] )
//     self.getOfProp1Count = tonumber( row[23] )
//     self.getOfProp2 = tonumber( row[24] )
//     self.propOdds2 = tonumber( row[25] )
//     self.getOfProp2Count = tonumber( row[26] )
//     self.getOfProp3 = tonumber( row[27] )
//     self.propOdds3 = tonumber( row[28] )
//     self.getOfProp3Count = tonumber( row[29] )
//     self.getOfProp4 = tonumber( row[30] )
//     self.propOdds4 = tonumber( row[31] )
//     self.getOfProp4Count = tonumber( row[32] )
//     self.getOfProp5 = tonumber( row[33] )
//     self.propOdds5 = tonumber( row[34] )
//     self.getOfProp5Count = tonumber( row[35] )
//     self.getOfEquipment = tonumber( row[36] )
//     self.equipmentOdds = tonumber( row[37] )
//     self.getOfEquipmentCount = tonumber( row[38] )
//     self.battleFailedGuide = row[39]
//     self.dailyAttackCount = tonumber( row[40] )
//     self.firstRewardGroup = tonumber( row[41] )
//     self.combatForce = tonumber( row[42] )

class EnvironmentFormation {
	public constructor() {
	}

	id: any;
	formationName: any;
	canBattleOperate: any;
	battleRoundLimit: any;
	picIndex: any;
	fightBg: any;
	level: any;
	seatOne: any;
	seatTwo: any;
	seatThree: any;
	seatFour: any;
	seatFive: any;
	seatSix: any;
	seatSeven: any;
	seatEight: any;
	seatNine: any;
	amplifyPercentage: any;
	getOfExperience: any;
	getOfRepute: any;
	getOfSilver: any;
	getOfProp1: any;
	propOdds1: any;
	getOfProp1Count: any;
	getOfProp2: any;
	propOdds2: any;
	getOfProp2Count: any;
	getOfProp3: any;
	propOdds3: any;
	getOfProp3Count: any;
	getOfProp4: any;
	propOdds4: any;
	getOfProp4Count: any;
	getOfProp5: any;
	propOdds5: any;
	getOfProp5Count: any;
	getOfEquipment: any;
	equipmentOdds: any;
	getOfEquipmentCount: any;
	battleFailedGuide: any;
	dailyAttackCount: any;
	firstRewardGroup: any;
	combatForce: any;

	public init(row) {
		this.id = Number(row[0]);
		this.formationName = Number(row[1]);
		this.canBattleOperate = Number(row[2]);
		this.battleRoundLimit = Number(row[3]);
		this.picIndex = Number(row[4]);
		this.fightBg = Number(row[5]);
		this.level = Number(row[6]);
		this.seatOne = Number(row[7]);
		this.seatTwo = Number(row[8]);
		this.seatThree = Number(row[9]);
		this.seatFour = Number(row[10]);
		this.seatFive = Number(row[11]);
		this.seatSix = Number(row[12]);
		this.seatSeven = Number(row[13]);
		this.seatEight = Number(row[14]);
		this.seatNine = Number(row[15]);
		this.amplifyPercentage = Number(row[16]);
		this.getOfExperience = Number(row[17]);
		this.getOfRepute = Number(row[18]);
		this.getOfSilver = Number(row[19]);
		this.getOfProp1 = Number(row[20]);
		this.propOdds1 = Number(row[21]);
		this.getOfProp1Count = Number(row[22]);
		this.getOfProp2 = Number(row[23]);
		this.propOdds2 = Number(row[24]);
		this.getOfProp2Count = Number(row[25]);
		this.getOfProp3 = Number(row[26]);
		this.propOdds3 = Number(row[27]);
		this.getOfProp3Count = Number(row[28]);
		this.getOfProp4 = Number(row[29]);
		this.propOdds4 = Number(row[30]);
		this.getOfProp4Count = Number(row[31]);
		this.getOfProp5 = Number(row[32]);
		this.propOdds5 = Number(row[33]);
		this.getOfProp5Count = Number(row[34]);
		this.getOfEquipment = Number(row[35]);
		this.equipmentOdds = Number(row[36]);
		this.getOfEquipmentCount = Number(row[37]);
		this.battleFailedGuide = Number(row[38]);
		this.dailyAttackCount = Number(row[39]);
		this.firstRewardGroup = Number(row[40]);
		this.combatForce = Number(row[41]);
	}
}