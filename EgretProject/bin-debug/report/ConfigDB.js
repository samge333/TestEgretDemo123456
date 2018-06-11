var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var ConfigDB = (function () {
    function ConfigDB() {
    }
    ConfigDB.loadConfig = function (configName, idx) {
        var obj;
        if (configName == "skill_mould") {
            obj = new SkillMould;
        }
        else if (configName == "ship_mould") {
            obj = new ShipMould;
        }
        else if (configName == "equipment_mould") {
            obj = new EquipmentMould;
        }
        else if (configName == "environment_formation") {
            obj = new EnvironmentFormation;
        }
        else if (configName == "environment_ship") {
            obj = new EnvironmentShip;
        }
        else if (configName == "skill_influence") {
            obj = new SkillInfluence;
        }
        else if (configName == "talent_mould") {
            obj = new TalentMould;
        }
        else if (configName == "restrain_mould") {
            obj = new RestrainMould;
        }
        else if (configName == "npc") {
            obj = new Npc;
        }
        var data = ConfigDB.getDataByIndex(configName, idx);
        obj.init(data);
        return obj;
    };
    ConfigDB.getDataByIndex = function (configName, idx) {
    };
    return ConfigDB;
}());
__reflect(ConfigDB.prototype, "ConfigDB");
//# sourceMappingURL=ConfigDB.js.map