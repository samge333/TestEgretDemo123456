var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightModule = (function () {
    function FightModule() {
        //我方BattleObject列表
        this.attackObjects = {};
        //地方BattleObject列表
        this.byAttackObjects = {};
        //攻击目标
        this.byAttackTargetTag = 0;
        //记录当前出手对象
        this.currentObject = null;
        //战斗类型
        this.fightType = FightModuleEnum.FIGHT_TYPE_PVE_NORMAL;
    }
    FightModule.prototype.initFight = function (npcId, difficulty, fightType) {
        var npcObj = ConfigDB.loadConfig("npc_txt", npcId);
        var resultBuffer = {};
        this.initBattleField(npcObj, difficulty, fightType, resultBuffer);
        HLog.log(resultBuffer);
        var json = JSON.stringify(resultBuffer);
        NetworkProtocol.parser_func(json);
    };
    FightModule.prototype.initBattleField = function (npc, difficulty, fightType, resultBuffer) {
        this.fightType = fightType;
        var battleCache = new BattleCache;
        battleCache.userInfo = ED.data.user_info;
        battleCache.battleType = fightType;
        battleCache.byAttackerId = npc.id;
        battleCache.maxBattleCount = npc.formationCount;
        battleCache.difficulty = difficulty;
        var attackObjects = {};
        var fightObject = new FightObject;
        fightObject.initWithUserData(2, ED.data.user_ship, 0, ED.data.user_info.user_id);
        attackObjects["1"] = fightObject;
        battleCache.attackerSpeedValue = 0;
        battleCache.attackName = "";
        battleCache.attackerObjects = attackObjects;
        //3波的敌方
        var byAttackerObjectsList = [];
        var byAttackObjects = {};
        var fightObject2 = new FightObject;
        fightObject2.initWithNpc(npc, 2, 59);
        byAttackObjects["1"] = fightObject2;
        byAttackerObjectsList.push(byAttackObjects);
        battleCache.byAttackerObjectsList = byAttackerObjectsList;
        this.writeBattleFieldInit(battleCache, 0, 1, resultBuffer);
    };
    //获取战斗角色数量
    FightModule.prototype.getFightObjectCount = function (attackerObjects) {
        var count = 0;
        for (var k in attackerObjects) {
            if (attackerObjects.k) {
                count = count + 1;
            }
        }
        return count;
    };
    FightModule.prototype.writeBattleFieldInit = function (battleCache, selfTag, targetTag, resultBuffer) {
        resultBuffer.battle_init_type = battleCache.battleType;
        resultBuffer.objId = battleCache.byAttackerId;
        resultBuffer.battle_level = battleCache.difficulty;
        resultBuffer.battle_total_count = battleCache.maxBattleCount;
        resultBuffer.attacker_priority = battleCache.attacker_priority;
        resultBuffer.defender_priority = battleCache.defender_priority;
        resultBuffer.attacker_name = battleCache.attacker_name;
        resultBuffer.defender_name = battleCache.defender_name;
        resultBuffer.attacker_head_pic = battleCache.attacker_head_pic;
        resultBuffer.defender_head_pic = battleCache.defender_head_pic;
        resultBuffer._hero_number = this.getFightObjectCount(battleCache.attackerObjects);
        //我方
        var fightObjects = battleCache.attackerObjects;
        var attackerFightObjectArray = [];
        for (var k in fightObjects) {
            if (fightObjects[k]) {
                var fightObjectData = {};
                fightObjectData._id = fightObjects[k].id;
                fightObjectData._pos = k;
                fightObjectData._head = fightObjects[k].picIndex;
                fightObjectData._power_skill_id = fightObjects[k].specialSkillDecribe;
                fightObjectData._fit_skill_id = fightObjects[k].zoarium;
                fightObjectData._quality = fightObjects[k].quality;
                fightObjectData._hp = fightObjects[k].healthPoint;
                fightObjectData._sp = fightObjects[k].skillPoint;
                fightObjectData._type = selfTag;
                fightObjectData._mouldId = fightObjects[k].mouldId;
                fightObjectData._scale = fightObjects[k].amplifyPercent;
                fightObjectData._name = fightObjects[k].fightName;
                fightObjectData._evolution_level = fightObjects[k].evolutionLevel;
                fightObjectData._hero_speed = fightObjects[k].wisdom;
                fightObjectData._max_hp = fightObjects[k].healthPoint;
                attackerFightObjectArray.push(fightObjectData);
            }
        }
        resultBuffer.attackerFightObjectArray = attackerFightObjectArray;
        // 敌方
        var byAttackObjects = battleCache.byAttackerObjectsList;
        var arr1 = [];
        for (var i = 0; i < byAttackObjects.length; i++) {
            var objects = byAttackObjects[i];
            var arr2 = [];
            for (var k in objects) {
                if (objects[k]) {
                    var fightObjectData = {};
                    fightObjectData._id = objects[k].id;
                    fightObjectData._pos = k;
                    fightObjectData._head = objects[k].picIndex;
                    fightObjectData._power_skill_id = objects[k].specialSkillDecribe;
                    fightObjectData._fit_skill_id = objects[k].zoarium;
                    fightObjectData._quality = objects[k].quality;
                    fightObjectData._hp = objects[k].healthPoint;
                    fightObjectData._sp = objects[k].skillPoint;
                    fightObjectData._type = targetTag;
                    fightObjectData._mouldId = objects[k].mouldId;
                    fightObjectData._scale = objects[k].amplifyPercent;
                    fightObjectData._name = objects[k].fightName;
                    fightObjectData._evolution_level = objects[k].evolutionLevel;
                    fightObjectData._hero_speed = objects[k].wisdom;
                    fightObjectData._max_hp = objects[k].specialSkillDecribe;
                    arr2.push(fightObjectData);
                }
            }
            arr1.push(arr2);
        }
        resultBuffer.byAttackerFightObjectArray = arr1;
    };
    //初始化战斗顺序
    FightModule.prototype.initFightOrder = function (userInfo) {
        var tempBattleCache = userInfo.battleCache;
        var attackerCombatForce = tempBattleCache.attackCombatForce;
        var byAttackerCombatForce = tempBattleCache.byAttackComobatForce;
        this.initBattleInfo(tempBattleCache);
    };
    FightModule.prototype.initBattleInfo = function (battleCache) {
        var resetAttackerInfo = true;
        if (battleCache.currentBattleCount > 0) {
            resetAttackerInfo = false;
        }
        var attackObjects = battleCache.attackerObjects;
        var byAttackObjects = battleCache.byAttackerObjectsList[battleCache.currentBattleCount + 1];
        //创建我方BattleObject
        for (var k in attackObjects) {
            if (attackObjects[k]) {
                //第一波
                if (resetAttackerInfo == true) {
                    var battleObject = new BattleObject;
                    battleObject.initWithAttackObject(attackObjects[k]);
                    this.attackObjects[k] = battleObject;
                }
                else {
                }
            }
        }
        //创建敌方BattleObject
        for (var k in byAttackObjects) {
            if (byAttackObjects[k]) {
                var battleObject = new BattleObject;
                battleObject.initWithAttackObject(attackObjects[k]);
                this.byAttackObjects = battleObject;
            }
        }
        for (var k in this.attackObjects) {
            var v = attackObjects[k];
            v.nextBattleInfo();
        }
        var buffBattleSkill = { "effectAmount": 0 };
        var buffBuffer = {};
        //TODO:战前天赋计算
        //...
        buffBuffer.effectAmount = buffBattleSkill.effectAmount;
        buffBuffer.currentBattleCount = battleCache.currentBattleCount + 1;
        var attackObjectsdata = [];
        for (var k in attackObjects) {
            var attackObj = attackObjects[k];
            var table = {};
            table.battleTag = attackObj.battleTag;
            table.coordinate = attackObj.coordinate;
            table.healthPoint = attackObj.healthPoint;
            table.healthMaxPoint = attackObj.healthMaxPoint;
            table.skillPoint = attackObj.skillPoint;
            attackObjectsdata.push(table);
        }
        buffBuffer.attackObjectsdata = attackObjectsdata;
        var byAttackObjectsdata = [];
        for (var k in byAttackObjects) {
            var attackObj = byAttackObjects[k];
            var table = {};
            table.battleTag = attackObj.battleTag;
            table.coordinate = attackObj.coordinate;
            table.healthPoint = attackObj.healthPoint;
            table.healthMaxPoint = attackObj.healthMaxPoint;
            table.skillPoint = attackObj.skillPoint;
            byAttackObjectsdata.push(table);
        }
        buffBuffer.byAttackObjectsdata = byAttackObjectsdata;
        var json = JSON.stringify(buffBuffer);
        NetworkProtocol.parser_func(json);
    };
    //获取指定阵营和位置的BattleObject对象
    FightModule.prototype.getAppointFightObject = function (battleTag, coordinate) {
        for (var i = 0; i < this.fightOrderList.length; i++) {
            var battleObj = (this.fightOrderList[i]);
            if (battleObj.battleTag == battleTag && battleObj.coordinate == coordinate) {
                return battleObj;
            }
        }
    };
    //设置攻击目标
    FightModule.prototype.setByAttackTargetTag = function (byAttackTargetTag) {
        this.byAttackTargetTag = byAttackTargetTag;
    };
    //获取这个BattleObject的攻击数据，开始计算，返回resultBuffer
    FightModule.prototype.fightObjectAttack = function (attackObject, resultBuffer) {
        var battleObject = attackObject;
        var skillPoint = battleObject.skillPoint;
        if (battleObject.isDead) {
        }
        else {
            // if(battleObject.isDizzy or battleObject.isParalysis or battleObject.isCripple or true == battleObject.revived or false == self:checkHasByAttacker(battleObject)) then
            if (false) {
            }
            else {
                //当前攻击技能效用BattleSkill列表
                var battleSkillList = void 0;
                var skillReleasePosion = 0;
                var goon = true;
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
                        var skillId = 0;
                        //当前发动的是小技能
                        if (battleObject.normalSkillMouldOpened == true) {
                            battleSkillList = battleObject.normalBattleSkill;
                            skillReleasePosion = battleObject.normalSkillMould.skill_release_position;
                            battleObject.normalSkillMouldOpened = false;
                            skillId = battleObject.normalSkillMould.id;
                            battleObject.normalSkillUseCount = battleObject.normalSkillUseCount + 1;
                        }
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
                    var byAttackCoordinates = void 0;
                    //技能效用数据
                    var tmpBattleSkillBuffer = {};
                    if (battleObject.isDead != true) {
                        for (var i = 0; i < battleSkillList.length; i++) {
                            var attackSkill = battleSkillList[i];
                            attackSkill.formulaInfo = attackSkill.skillInfluence.formulaInfo;
                            var battleTag = battleObject.battleTag;
                            var influenceGroup = attackSkill.skillInfluence.influenceGroup;
                            var needInitAttackTarget = true;
                            if (needInitAttackTarget == true) {
                                if (attackSkill.formulaInfo != FORMULA_INFO.FORMULA_INFO_FORTHWITH) {
                                    if ((battleTag == 0 && influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OPPOSITE)
                                        || (battleTag == 1 && influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OURSITE)) {
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
                                else if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OURSITE) {
                                    attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.attackObjects, this, tmpBattleSkillBuffer);
                                }
                                else if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_CURRENT) {
                                    byAttackCoordinates = [];
                                    byAttackCoordinates.push(battleObject.coordinate);
                                    attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.attackObjects, this, tmpBattleSkillBuffer);
                                }
                            }
                            else {
                                //作用敌方
                                if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OPPOSITE) {
                                    attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.attackObjects, this, tmpBattleSkillBuffer);
                                }
                                else if (influenceGroup == EFFECT_GROUP.EFFECT_GROUP_OURSITE) {
                                    attackSkill.processAttack(null, byAttackCoordinates, battleObject, this.byAttackObjects, this, tmpBattleSkillBuffer);
                                }
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
    };
    return FightModule;
}());
__reflect(FightModule.prototype, "FightModule");
//# sourceMappingURL=FightModule.js.map