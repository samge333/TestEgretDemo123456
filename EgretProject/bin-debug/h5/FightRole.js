var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var FightRole = (function () {
    function FightRole() {
        this._info = { _pos: 0 };
        this._roleCamp = 0;
    }
    return FightRole;
}());
__reflect(FightRole.prototype, "FightRole");
//# sourceMappingURL=FightRole.js.map