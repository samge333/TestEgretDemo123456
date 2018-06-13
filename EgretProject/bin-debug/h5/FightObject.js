var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightObject = (function () {
    function FightObject() {
        this.id = 0;
        this.picIndex = 0;
        this.specialSkillDecribe = 0;
        this.zoarium = 0;
        this.quality = 0;
        this.healthPoint = 0;
        this.skillPoint = 0;
        this.mouldId = 0;
        this.amplifyPercent = 1;
        this.fightName = "";
        this.evolutionLevel = 0;
        this.wisdom = 0;
        this.shipMould = 0;
        this.capacity = 0;
        this.normalSkillMould = 0;
        //玩家信息
        this.userInfo = -1;
        //位置
        this.coordinate = 0;
        //阵营类型
        this.roleType = 0;
    }
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
    FightObject.prototype.initWithUserData = function (coordinate, ship, battleTag, userId) {
        //普通攻击SkillMould对象
        this.commonSkill = ConfigDB.loadConfig("skill_mould_txt", 661);
        //小技能技能id
        this.normalSkillMould = Dms.int(Dms.data["talent_mould_txt"], 1321, 13);
        this.roleType = 0;
        this.coordinate = coordinate;
        var shipMould = ConfigDB.loadConfig("ship_mould_txt", ship.ship_template_id);
        this.id = ship.ship_id;
        this.mouldId = ship.ship_template_id;
        this.shipMould = shipMould.baseMould;
        this.userInfo = Number(userId);
        this.picIndex = shipMould.bustIndex;
        this.quality = shipMould.shipType;
        this.healthPoint = ship.ship_health;
        this.skillPoint = 0;
    };
    FightObject.prototype.initWithNpc = function (npc, coordinate, environmentShipId) {
        this.userInfo = npc.id;
        this.coordinate = coordinate;
        this.roleType = 1;
        var environmentShip = ConfigDB.loadConfig("environment_ship_txt", environmentShipId);
        this.id = environmentShipId;
        this.picIndex = environmentShip.bustIndex;
        this.specialSkillDecribe = 0;
        this.quality = environmentShip.signType;
        this.healthPoint = environmentShip.power;
        this.skillPoint = environmentShip.haveDeadly;
        this.mouldId = environmentShipId;
        this.fightName = environmentShip.shipName;
    };
    return FightObject;
}());
__reflect(FightObject.prototype, "FightObject");
//# sourceMappingURL=FightObject.js.map