class FightModule {
	public constructor() {
	}

	//我方BattleObject列表
	attackObjects: any = {};
	//地方BattleObject列表
	byAttackObjects: any = {};
	//出手顺序列表
	fightOrderList: Array<any>;
	//攻击目标
	byAttackTargetTag = 0;
	//记录当前出手对象
	currentObject: BattleObject = null;

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

	//获取指定阵营和位置的BattleObject对象
	public getAppointFightObject(battleTag: number, coordinate: number) {
		for (let i = 0; i < this.fightOrderList.length; i++) {
			let battleObj = (this.fightOrderList[i]) as BattleObject;
			if (battleObj.battleTag == battleTag && battleObj.coordinate == coordinate) {
				return battleObj;
			}
		}
	}

	//设置攻击目标
	public setByAttackTargetTag(byAttackTargetTag: number) {
		this.byAttackTargetTag = byAttackTargetTag;
	}

	//获取这个BattleObject的攻击数据，开始计算，返回resultBuffer
	public fightObjectAttack(attackObject: BattleObject, resultBuffer) {
		let battleObject = attackObject;

		let skillPoint = battleObject.skillPoint;

		if (battleObject.isDead) {

		}
		else {
			// if(battleObject.isDizzy or battleObject.isParalysis or battleObject.isCripple or true == battleObject.revived or false == self:checkHasByAttacker(battleObject)) then
			if (false) {

			}
			else {
				//当前攻击技能效用BattleSkill列表
				let battleSkillList: Array<BattleSkill>;
				let skillReleasePosion = 0;
				let goon = true;

				// if true ~= battleObject.skipSuperSkillMould and nil ~= battleObject.specialSkillMould and ((battleObject.skillPoint >= FightModule.MAX_SP or self.canFreeSkill == true) and battleObject.isDisSp ~= true) then
				if (false) {

				}
				else {
					// if(battleObject.isParalysis) then
					if (false) {

					}
					else {
						resultBuffer.battleTag = battleObject.battleTag;
						resultBuffer.coordinate = battleObject.coordinate;

						let skillId = 0;

						//当前发动的是小技能
						if (battleObject.normalSkillMouldOpened == true) {
							battleSkillList = battleObject.normalBattleSkill;
							skillReleasePosion = battleObject.normalSkillMould.skill_release_position;
							battleObject.normalSkillMouldOpened = false;
							skillId = battleObject.normalSkillMould.id;
							battleObject.normalSkillUseCount = battleObject.normalSkillUseCount + 1;
						}
						//当前发动的是普通攻击
						else {
							battleSkillList = battleObject.commonBattleSkill;
							skillReleasePosion = battleObject.commonSkillMould.skill_release_position;
						}

						if (battleObject.battleTag == 0) {
							resultBuffer.moveCoordinate = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, this.byAttackObjects);
						}
						else {
							resultBuffer.moveCoordinate = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, this.attackObjects);
						}
					}
				}

				if (goon) {
					//被攻击的位置列表
					let byAttackCoordinates: Array<any>;
					//技能效用数据
					let tmpBattleSkillBuffer = {};

					if (battleObject.isDead != true) {
						for (let i = 0; i < battleSkillList.length; i++) {
							let attackSkill = battleSkillList[i];
							attackSkill.formulaInfo = attackSkill.skillInfluence.formulaInfo;
							let battleTag = battleObject.battleTag;
							let influenceGroup = attackSkill.skillInfluence.influenceGroup;

							let needInitAttackTarget = true;
							if (needInitAttackTarget == true) {
								if (attackSkill.formulaInfo != FORMULA_INFO.FORMULA_INFO_FORTHWITH) {
									if ( (battleTag == 0 && influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OPPOSITE)
										|| (battleTag == 1 && influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OURSITE) ) {
										byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, attackSkill.skillInfluence, battleObject, this.byAttackObjects, this.byAttackTargetTag);
									}
									else {
										byAttackCoordinates = FightUtil.computeEffectCoordinate(battleObject.coordinate, attackSkill.skillInfluence, battleObject, this.attackObjects, this.byAttackTargetTag);
									}
								}
								else {

								}
							}

							if (battleObject.battleTag == 0) {
								//作用敌方
								if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OPPOSITE) {
									attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.byAttackObjects, this, tmpBattleSkillBuffer);
								}	
								//作用我方
								else if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OURSITE) {
									attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.attackObjects, this, tmpBattleSkillBuffer);
								}
								//作用自己
								else if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_CURRENT) {
									byAttackCoordinates = [];
									byAttackCoordinates.push(battleObject.coordinate);
									attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.attackObjects, this, tmpBattleSkillBuffer);
								}
							}
							else {
								//作用敌方
								if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OPPOSITE) {
									attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.attackObjects, this, tmpBattleSkillBuffer)
								}
								//作用我方
								else if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OURSITE) {
									attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.byAttackObjects, this, tmpBattleSkillBuffer);
								}
								//作用自己
								else if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_CURRENT) {
									byAttackCoordinates = [];
									byAttackCoordinates.push(battleObject.coordinate);
									attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.byAttackObjects, this, tmpBattleSkillBuffer);
								}
							}

						}
					}

					resultBuffer.healthPoint = battleObject.healthPoint;
					resultBuffer.skillPoint = battleObject.skillPoint;
					resultBuffer.hasRestrain = 0;
					resultBuffer.tmpBattleSkillBuffer = tmpBattleSkillBuffer;

				}

			}
		}
	}
}