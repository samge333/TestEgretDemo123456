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
	//战斗类型
	fightType = FightModuleEnum.FIGHT_TYPE_PVE_NORMAL;

	public initFight(npcId: number, difficulty: number, fightType: number) {
		let npcObj = ConfigDB.loadConfig("npc_txt", npcId);

		let resultBuffer = {};
		this.initBattleField(npcObj, difficulty, fightType, resultBuffer);

		// HLog.log(resultBuffer);
		let json = JSON.stringify(resultBuffer);
		ED.parser_func("parse_battle_field_init", json);

		//测试攻击数据
		let fightRoleController = new FightRoleController;
		fightRoleController.nextBattle();

	}

	public initBattleField(npc: Npc, difficulty: number, fightType: number, resultBuffer) {

		this.fightType = fightType;
		
		let battleCache = new BattleCache;
		battleCache.userInfo = ED.data.user_info;
		battleCache.battleType = fightType;
		battleCache.byAttackerId = npc.id;
		battleCache.maxBattleCount = npc.formationCount;
		battleCache.difficulty = difficulty;

		//我方
		let attackObjects: {[pos: number]: FightObject} = {};
		let fightObject = new FightObject;
		fightObject.initWithUserData(2, ED.data.user_ship, 0, ED.data.user_info.user_id);
		attackObjects[2] = fightObject;

		battleCache.attackerSpeedValue = 0;
		battleCache.attackName = ED.data.user_info.user_name;
		battleCache.attackerObjects = attackObjects;
		battleCache.attackCombatForce = ED.data.user_info.fight_capacity;
		battleCache.byAttackName = npc.npcName;
		battleCache.attacker_priority = battleCache.attackerSpeedValue;
		battleCache.defender_priority = 0;

		//3波的敌方
		let byAttackerObjectsList: Array<{[pos: number]: FightObject}> = [];
		let byAttackObjects: {[pos: number]: FightObject} = {};
		let fightObject2 = new FightObject;
		fightObject2.initWithNpc(npc, 2, 59);
		byAttackObjects[2] = fightObject2;
		byAttackerObjectsList.push(byAttackObjects);
		battleCache.byAttackerObjectsList = byAttackerObjectsList

		this.writeBattleFieldInit(battleCache,  0,  1, resultBuffer)

	}

	//获取战斗角色数量
	public getFightObjectCount(attackerObjects) {
		let count = 0;
		for (let k in attackerObjects) {
			if (attackerObjects[k]) {
				count = count + 1;
			}
		}
		return count;
	}

	public writeBattleFieldInit(battleCache: BattleCache, selfTag, targetTag, resultBuffer) {
		resultBuffer.battle_init_type = battleCache.battleType;
		resultBuffer.objId = battleCache.byAttackerId;	
		resultBuffer.battle_level = battleCache.difficulty;
		resultBuffer.battle_total_count = battleCache.maxBattleCount;
		resultBuffer.attacker_priority = battleCache.attacker_priority;
		resultBuffer.defender_priority = battleCache.defender_priority;
		resultBuffer.attacker_name = battleCache.attackName;
		resultBuffer.defender_name = battleCache.byAttackName;
		resultBuffer.attacker_head_pic = battleCache.attacker_head_pic;
		resultBuffer.defender_head_pic = battleCache.defender_head_pic;
		resultBuffer._hero_number = this.getFightObjectCount(battleCache.attackerObjects);

		//我方
		let fightObjects = battleCache.attackerObjects;
		let attackerFightObjectArray: {[pos: number]: any} = {};
		for (let k in fightObjects) {
			if (fightObjects[k]) {
				let fightObjectData: any = {};
				fightObjectData._id = Number(fightObjects[k].id);
				fightObjectData._pos = Number(k);
				fightObjectData._head = Number(fightObjects[k].picIndex);
				fightObjectData._power_skill_id = Number(fightObjects[k].specialSkillDecribe);
				fightObjectData._fit_skill_id = Number(fightObjects[k].zoarium);
				fightObjectData._quality = Number(fightObjects[k].quality);
				fightObjectData._hp = Number(fightObjects[k].healthPoint);
				fightObjectData._sp = Number(fightObjects[k].skillPoint);
				fightObjectData._type = Number(selfTag);
				fightObjectData._mouldId = Number(fightObjects[k].mouldId);
				fightObjectData._scale = Number(fightObjects[k].amplifyPercent);
				fightObjectData._name = fightObjects[k].fightName;
				fightObjectData._evolution_level = Number(fightObjects[k].evolutionLevel);
				fightObjectData._hero_speed = Number(fightObjects[k].wisdom);
				fightObjectData._max_hp = Number(fightObjects[k].healthPoint);

				attackerFightObjectArray[k] = fightObjectData;
			}
		}
		resultBuffer._heros = attackerFightObjectArray;

		resultBuffer.viceId = 0;
		resultBuffer.attribute = "0,0";

		// 敌方
		let byAttackObjects = battleCache.byAttackerObjectsList;

		//存放三波的数据
		let arr1: Array<any> = [];
		for (let i = 0; i < byAttackObjects.length; i++) {
			//存放一波的数据
			let wavedata: any = {};
			let objects = byAttackObjects[i];
			wavedata._battle_number = 1;
			
			if (this.fightType < 10) {
				for (let k in objects) {
					if (objects[k]) {
						wavedata._battleName = objects[k].fightName;
						break;
					}
				}
			} else {
				wavedata._battleName = "?";
			}

			wavedata._enemy_number = this.getFightObjectCount(objects);
			
			let arr2: {[pos: number]: any} = {};
			for (let k in objects) {
				if (objects[k]) {
					let fightObjectData: any = {};
					fightObjectData._id = Number(objects[k].id);
					fightObjectData._pos = Number(k);
					fightObjectData._head = Number(objects[k].picIndex);
					fightObjectData._power_skill_id = Number(objects[k].specialSkillDecribe);
					fightObjectData._fit_skill_id = Number(objects[k].zoarium);
					fightObjectData._quality = Number(objects[k].quality);
					fightObjectData._hp = Number(objects[k].healthPoint);
					fightObjectData._sp = Number(objects[k].skillPoint);
					fightObjectData._type = Number(targetTag);
					fightObjectData._mouldId = Number(objects[k].mouldId);
					fightObjectData._scale = Number(objects[k].amplifyPercent);
					fightObjectData._name = objects[k].fightName;
					fightObjectData._evolution_level = Number(objects[k].evolutionLevel);
					fightObjectData._hero_speed = Number(objects[k].wisdom);
					fightObjectData._max_hp = Number(objects[k].specialSkillDecribe);

					arr2[k] = fightObjectData;
				}
			}
			wavedata._data = arr2;
			arr1.push(wavedata);
		}

		resultBuffer._armys = arr1;
		resultBuffer.otherViceId = 0;
		resultBuffer.otherAttribute = "0,0";
		
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
		ED.parser_func("", json);
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
						resultBuffer.linkAttackerPos = 0;
						resultBuffer.healthPoint = battleObject.healthPoint;
						resultBuffer.skillPoint = battleObject.skillPoint;
						resultBuffer.hasRestrain = 0;
						//技能数量写死为1，做测试
						resultBuffer.battleSkillCount = 1;

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
							skillId = battleObject.commonSkillMould.id;
						}

						if (battleObject.battleTag == 0) {
							resultBuffer.moveCoordinate = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, this.byAttackObjects);
						}
						else {
							resultBuffer.moveCoordinate = FightUtil.computeMoveCoordinate(battleObject.coordinate, skillReleasePosion, this.attackObjects);
						}

						resultBuffer.skillId = skillId;
						//是否有buff影响，写死为0，方便测试
						resultBuffer.attackerForepartBuffState = 0;
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

					resultBuffer.skillInfluenceCount = 1;
					resultBuffer.tmpBattleSkillBuffer = tmpBattleSkillBuffer;

					//后段技能效用数量写死为0测试
					resultBuffer.skillAfterInfluenceCount = 0;

				}

			}
		}

		// HLog.log(resultBuffer);
	}
}