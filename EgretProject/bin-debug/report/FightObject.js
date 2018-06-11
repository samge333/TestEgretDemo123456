var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightObject = (function () {
    function FightObject() {
        this.id = null;
        this.picIndex = null;
        this.specialSkillDecribe = null;
        this.zoarium = null;
        this.quality = null;
        this.healthPoint = null;
        this.skillPoint = null;
        this.mouldId = null;
        this.amplifyPercent = null;
        this.fightName = null;
        this.evolutionLevel = null;
        this.wisdom = null;
        this.shipMould = 0;
        this.capacity = 0;
    }
    return FightObject;
}());
__reflect(FightObject.prototype, "FightObject");
//# sourceMappingURL=FightObject.js.map