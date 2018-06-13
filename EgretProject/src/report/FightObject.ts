class FightObject {
	public constructor() {
	}

	id: any = null;
	picIndex: any = null;
	specialSkillDecribe: any = null;
	zoarium: any = null;
	quality: any = null;
	healthPoint: any = null;
	skillPoint: any = null;
	mouldId: any = null;
	amplifyPercent: any = null;
	fightName: any = null;
	evolutionLevel: any = null;
	wisdom: any = null;
	shipMould = 0;
	capacity = 0;
	commonSkill: SkillMould;
	normalSkillMould: number;

	public initWithUserData(coordinate:number, ship:any, battleTag:number, userId:number) {
		//普通攻击SkillMould对象
		this.commonSkill = ConfigDB.loadConfig("skill_mould", 661);
		//小技能技能id
		this.normalSkillMould = Dms.int(Dms.data["talent_mould"], 1321, 13);
	}
	
}