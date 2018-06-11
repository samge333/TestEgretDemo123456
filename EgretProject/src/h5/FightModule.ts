class FightModule {
	public constructor() {
	}

	//我方BattleObject列表
	attackObjects: any = {};
	//地方BattleObject列表
	byAttackObjects: any = {};

	public initFight(npcId: number, difficulty: number, fightType: number) {
		let npcObj = ConfigDB.loadConfig("npc", npcId);

		let resultBuffer = {};
		this.initBattleField(npcObj, difficulty, fightType, resultBuffer);

		let json = JSON.stringify(resultBuffer);
		NetworkProtocol.parser_func(json);
	}

	public initBattleField(npc: Npc, difficulty: number, fightType: number, resultBuffer) {
		let battleCache = new BattleCache;
		battleCache.userInfo = ED.data.user_info;
		battleCache.battleType = fightType;
		battleCache.byAttackerId = npc.id;
		battleCache.maxBattleCount = npc.formationCount;
		battleCache.difficulty = difficulty;

		let attackObjects = {};
		let fightObject = new FightObject;
		attackObjects["1"] = fightObject;

		battleCache.attackerSpeedValue = 0;
		battleCache.attackName = "";
		battleCache.attackerObjects = attackObjects;

		let byAttackerObjectsList: Array<any> = [];
		let byAttackObjects = {};
		byAttackObjects["1"] = new FightObject;
		byAttackerObjectsList.push(byAttackObjects);

		battleCache.byAttackerObjectsList = byAttackerObjectsList

		this.writeBattleFieldInit(battleCache,  0,  1, resultBuffer)

	}

	public writeBattleFieldInit(battleCache, selfTag, targetTag, resultBuffer) {
		resultBuffer.battleType = battleCache.battleType;
		resultBuffer.byAttackerId = battleCache.byAttackerId;
		resultBuffer.difficulty = battleCache.difficulty;
		resultBuffer.maxBattleCount = battleCache.maxBattleCount;
		resultBuffer.attacker_priority = battleCache.attacker_priority;
		resultBuffer.defender_priority = battleCache.defender_priority;
		resultBuffer.attacker_name = battleCache.attacker_name;
		resultBuffer.defender_name = battleCache.defender_name;
		resultBuffer.attacker_head_pic = battleCache.attacker_head_pic;
		resultBuffer.defender_head_pic = battleCache.defender_head_pic;
		resultBuffer.attackerCount = 1;
		resultBuffer.attackName = battleCache.attackName;
		resultBuffer.attackCombatForce = battleCache.attackCombatForce;
		resultBuffer.byAttackName = battleCache.byAttackName;
		resultBuffer.byAttackComobatForce = battleCache.byAttackComobatForce;

		//我方
		let fightObjects = battleCache.attackerObjects
		let attackerFightObjectArray = [];
		for (let k in fightObjects) {
			if (fightObjects[k]) {
				let fightObjectData = {};
				fightObjectData["id"] = fightObjects[k].id;
				fightObjectData["picIndex"] = fightObjects[k].picIndex;
				fightObjectData["zoarium"] = fightObjects[k].zoarium;
				fightObjectData["quality"] = fightObjects[k].quality;
				fightObjectData["healthPoint"] = fightObjects[k].healthPoint;
				fightObjectData["skillPoint"] = fightObjects[k].skillPoint;
				fightObjectData["mouldId"] = fightObjects[k].mouldId;
				fightObjectData["amplifyPercent"] = fightObjects[k].amplifyPercent;
				fightObjectData["fightName"] = fightObjects[k].fightName;
				fightObjectData["evolutionLevel"] = fightObjects[k].evolutionLevel;
				fightObjectData["wisdom"] = fightObjects[k].wisdom;

				attackerFightObjectArray.push(fightObjectData);
			}
		}
		resultBuffer.attackerFightObjectArray = attackerFightObjectArray;

		// 敌方
		let byAttackObjects = battleCache.byAttackerObjectsList;
		let arr1 = [];
		for (let i = 0; i < byAttackObjects.length; i++) {
			let objects = byAttackObjects[i];

			let arr2 = [];
			for (let k in objects) {
				if (objects[k]) {
					let fightObjectData = {};
					fightObjectData["id"] = objects[k].id;
					fightObjectData["picIndex"] = objects[k].picIndex;
					fightObjectData["zoarium"] = objects[k].zoarium;
					fightObjectData["quality"] = objects[k].quality;
					fightObjectData["healthPoint"] = objects[k].healthPoint;
					fightObjectData["skillPoint"] = objects[k].skillPoint;
					fightObjectData["mouldId"] = objects[k].mouldId;
					fightObjectData["amplifyPercent"] = objects[k].amplifyPercent;
					fightObjectData["fightName"] = objects[k].fightName;
					fightObjectData["evolutionLevel"] = objects[k].evolutionLevel;
					fightObjectData["wisdom"] = objects[k].wisdom;
					fightObjectData["specialSkillDecribe"] = objects[k].specialSkillDecribe;
					fightObjectData["evolutionLevel"] = objects[k].evolutionLevel;

					arr2.push(fightObjectData);
				}
			}
			arr1.push(arr2);
		}

		resultBuffer.byAttackerFightObjectArray = arr1;
		
	}

	//初始化战斗顺序
	public initFightOrder(userInfo) {
		let tempBattleCache = userInfo.battleCache as BattleCache;
		let attackerCombatForce = tempBattleCache.attackCombatForce;
		let byAttackerCombatForce = tempBattleCache.byAttackComobatForce;

		this.initBattleInfo(tempBattleCache);
	}

	public initBattleInfo(battleCache: BattleCache) {
		let resetAttackerInfo = true
		if (battleCache.currentBattleCount > 0) {
			resetAttackerInfo = false;
		}

		let attackObjects = battleCache.attackerObjects;
		let byAttackObjects = battleCache.byAttackerObjectsList[battleCache.currentBattleCount + 1];

		//创建我方BattleObject
		for (let k in attackObjects) {
			if (attackObjects[k]) {
				//第一波
				if (resetAttackerInfo == true) {
					let battleObject = new BattleObject;
					battleObject.initWithAttackObject(attackObjects[k]);
					this.attackObjects[k] = battleObject;
				}
				else {

				}
			}
		}

		//创建敌方BattleObject
		for (let k in byAttackObjects) {
			if (byAttackObjects[k]) {
				let battleObject = new BattleObject;
				battleObject.initWithAttackObject(attackObjects[k]);
				this.byAttackObjects = battleObject;
			}
		}

		for (let k in this.attackObjects) {
			let v = attackObjects[k];
			v.nextBattleInfo();
		}

		let buffBattleSkill = {"effectAmount": 0};
		let buffBuffer: any = {};
		//TODO:战前天赋计算
		//...

		buffBuffer.effectAmount = buffBattleSkill.effectAmount;
		buffBuffer.currentBattleCount = battleCache.currentBattleCount + 1;

		let attackObjectsdata = [];
		for (let k in attackObjects) {
			let attackObj = attackObjects[k];
			let table: any = {};
			table.battleTag = attackObj.battleTag;
			table.coordinate = attackObj.coordinate;
			table.healthPoint = attackObj.healthPoint;
			table.healthMaxPoint = attackObj.healthMaxPoint;
			table.skillPoint = attackObj.skillPoint;
			attackObjectsdata.push(table);
		}
		buffBuffer.attackObjectsdata = attackObjectsdata;

		let byAttackObjectsdata = [];
		for (let k in byAttackObjects) {
			let attackObj = byAttackObjects[k];
			let table: any = {};
			table.battleTag = attackObj.battleTag;
			table.coordinate = attackObj.coordinate;
			table.healthPoint = attackObj.healthPoint;
			table.healthMaxPoint = attackObj.healthMaxPoint;
			table.skillPoint = attackObj.skillPoint;
			byAttackObjectsdata.push(table);
		}
		buffBuffer.byAttackObjectsdata = byAttackObjectsdata;

		let json = JSON.stringify(buffBuffer);
		NetworkProtocol.parser_func(json);
	}
}