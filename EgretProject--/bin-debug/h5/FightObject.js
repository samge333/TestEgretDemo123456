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
        //注意FightObject里的healthPoint指的最大血量
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
        //速度
        this.attackSpeed = 0;
        this.healthMaxPoint = 0;
    }
    FightObject.prototype.initWithUserData = function (coordinate, ship, userId) {
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
        this.attackSpeed = ship.ship_wisdom;
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
        this.commonSkill = ConfigDB.loadConfig("skill_mould_txt", environmentShip.commonSkillMould);
        var arrPhysicsAttackEffect = environmentShip.physicsAttackEffect.split(",");
        this.normalSkillMould = Number(arrPhysicsAttackEffect[0]);
    };
    return FightObject;
}());
__reflect(FightObject.prototype, "FightObject");
//# sourceMappingURL=FightObject.js.map