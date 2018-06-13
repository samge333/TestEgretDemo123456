var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var ConfigDB = (function () {
    function ConfigDB() {
    }
    ConfigDB.loadConfig = function (configName, idx) {
        var obj;
        if (configName == "skill_mould_txt") {
            obj = new SkillMould;
        }
        else if (configName == "ship_mould_txt") {
            obj = new ShipMould;
        }
        else if (configName == "equipment_mould_txt") {
            obj = new EquipmentMould;
        }
        else if (configName == "environment_formation_txt") {
            obj = new EnvironmentFormation;
        }
        else if (configName == "environment_ship_txt") {
            obj = new EnvironmentShip;
        }
        else if (configName == "skill_influence_txt") {
            obj = new SkillInfluence;
        }
        else if (configName == "talent_mould_txt") {
            obj = new TalentMould;
        }
        else if (configName == "npc_txt") {
            obj = new Npc;
        }
        var element = Dms.data[configName];
        var data = Dms.element(element, idx - 1);
        HLog.log("打印" + configName + "表的第" + idx + "列\n" + data.toString());
        obj.init(data);
        return obj;
    };
    return ConfigDB;
}());
__reflect(ConfigDB.prototype, "ConfigDB");
//# sourceMappingURL=ConfigDB.js.map