var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightRole = (function () {
    function FightRole() {
        this._info = {};
        this._roleCamp = 0;
    }
    FightRole.prototype.init = function (data, roleCamp) {
        HLog.log("创建角色" + roleCamp, data);
        this._info = data;
        this._roleCamp = roleCamp;
    };
    return FightRole;
}());
__reflect(FightRole.prototype, "FightRole");
//# sourceMappingURL=FightRole.js.map