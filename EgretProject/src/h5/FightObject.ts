class FightObject {
	public constructor() {
	}

	id = 0;
	picIndex = 0;
	specialSkillDecribe = 0;
	zoarium = 0;
	quality = 0;
	healthPoint = 0;
	skillPoint = 0;
	mouldId = 0;
	amplifyPercent = 1;
	fightName = "";
	evolutionLevel = 0;
	wisdom = 0;
	shipMould = 0;
	capacity = 0;
	commonSkill: SkillMould;
	normalSkillMould = 0;
	//玩家信息
	userInfo = -1;
	//位置
	coordinate = 0;
	//阵营类型
	roleType = 0;


	// fightObjectData._id = fightObjects[k].id;
	// fightObjectData._pos = k;
	// fightObjectData._head = fightObjects[k].picIndex;
	// fightObjectData._power_skill_id = fightObjects[k].specialSkillDecribe;
	// fightObjectData._fit_skill_id = fightObjects[k].zoarium;
	// fightObjectData._quality = fightObjects[k].quality;
	// fightObjectData._hp = fightObjects[k].healthPoint;
	// fightObjectData._sp = fightObjects[k].skillPoint;
	// fightObjectData._type = selfTag;
	// fightObjectData._mouldId = fightObjects[k].mouldId;
	// fightObjectData._scale = fightObjects[k].amplifyPercent;
	// fightObjectData._name = fightObjects[k].fightName;
	// fightObjectData._evolution_level = fightObjects[k].evolutionLevel;
	// fightObjectData._hero_speed = fightObjects[k].wisdom;
	// fightObjectData._max_hp = fightObjects[k].healthPoint;

	public initWithUserData(coordinate: number, ship: any, battleTag: number, userId: string) {
		//普通攻击SkillMould对象
		this.commonSkill = ConfigDB.loadConfig("skill_mould_txt", 661);
		//小技能技能id
		this.normalSkillMould = Dms.int(Dms.data["talent_mould_txt"], 1321, 13);

		this.roleType = 0;
		this.coordinate = coordinate;

		let shipMould: ShipMould = ConfigDB.loadConfig("ship_mould_txt", ship.ship_template_id);
		this.id = ship.ship_id;
		this.mouldId = ship.ship_template_id;
		this.shipMould = shipMould.baseMould;

		this.userInfo = Number(userId);
		this.picIndex = shipMould.bustIndex;
		this.quality = shipMould.shipType;
		this.healthPoint = ship.ship_health;
		this.skillPoint =  0;
	}
	
	public initWithNpc(npc: Npc, coordinate: number, environmentShipId: number) {
		this.userInfo = npc.id;
		this.coordinate = coordinate;
		this.roleType = 1;

		let environmentShip: EnvironmentShip = ConfigDB.loadConfig("environment_ship_txt", environmentShipId);

		this.id = environmentShipId;
		this.picIndex = environmentShip.bustIndex;
		this.specialSkillDecribe = 0;
		this.quality = environmentShip.signType;
		this.healthPoint = environmentShip.power;
		this.skillPoint = environmentShip.haveDeadly;
		this.mouldId = environmentShipId;
		this.fightName = environmentShip.shipName;
	}
}