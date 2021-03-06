class FightObject {
	public constructor() {
	}

	id = 0;
	picIndex = 0;
	specialSkillDecribe = 0;
	zoarium = 0;
	quality = 0;

	//注意FightObject里的healthPoint指的最大血量
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
	//速度
	attackSpeed = 0;

	healthMaxPoint = 0;

	public initWithUserData(coordinate: number, ship: any, userId: string) {
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
		this.attackSpeed = ship.ship_wisdom;
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
		this.commonSkill = ConfigDB.loadConfig("skill_mould_txt", environmentShip.commonSkillMould);

		let arrPhysicsAttackEffect = environmentShip.physicsAttackEffect.split(",");
		this.normalSkillMould = Number(arrPhysicsAttackEffect[0]);
	}
}