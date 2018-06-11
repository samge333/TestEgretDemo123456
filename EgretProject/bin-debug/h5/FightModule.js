var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightModule = (function () {
    function FightModule() {
        //我方BattleObject列表
        this.attackObjects = {};
        //地方BattleObject列表
        this.byAttackObjects = {};
    }
    FightModule.prototype.initFight = function (npcId, difficulty, fightType) {
        var npcObj = ConfigDB.loadConfig("npc", npcId);
        var resultBuffer = {};
        this.initBattleField(npcObj, difficulty, fightType, resultBuffer);
        var json = JSON.stringify(resultBuffer);
        NetworkProtocol.parser_func(json);
    };
    FightModule.prototype.initBattleField = function (npc, difficulty, fightType, resultBuffer) {
        var battleCache = new BattleCache;
        battleCache.userInfo = ED.data.user_info;
        battleCache.battleType = fightType;
        battleCache.byAttackerId = npc.id;
        battleCache.maxBattleCount = npc.formationCount;
        battleCache.difficulty = difficulty;
        var attackObjects = {};
        var fightObject = new FightObject;
        attackObjects["1"] = fightObject;
        battleCache.attackerSpeedValue = 0;
        battleCache.attackName = "";
        battleCache.attackerObjects = attackObjects;
        var byAttackerObjectsList = [];
        var byAttackObjects = {};
        byAttackObjects["1"] = new FightObject;
        byAttackerObjectsList.push(byAttackObjects);
        battleCache.byAttackerObjectsList = byAttackerObjectsList;
        this.writeBattleFieldInit(battleCache, 0, 1, resultBuffer);
    };
    FightModule.prototype.writeBattleFieldInit = function (battleCache, selfTag, targetTag, resultBuffer) {
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
        var fightObjects = battleCache.attackerObjects;
        var attackerFightObjectArray = [];
        for (var k in fightObjects) {
            if (fightObjects[k]) {
                var fightObjectData = {};
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
        var byAttackObjects = battleCache.byAttackerObjectsList;
        var arr1 = [];
        for (var i = 0; i < byAttackObjects.length; i++) {
            var objects = byAttackObjects[i];
            var arr2 = [];
            for (var k in objects) {
                if (objects[k]) {
                    var fightObjectData = {};
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
    return FightModule;
}());
__reflect(FightModule.prototype, "FightModule");
//# sourceMappingURL=FightModule.js.map