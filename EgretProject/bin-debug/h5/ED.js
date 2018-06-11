var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var PrivateEnvironmentData = (function () {
    function PrivateEnvironmentData() {
        this.user_info = {};
    }
    return PrivateEnvironmentData;
}());
__reflect(PrivateEnvironmentData.prototype, "PrivateEnvironmentData");
var ED = (function () {
    function ED() {
    }
    ED.data = new PrivateEnvironmentData;
    return ED;
}());
__reflect(ED.prototype, "ED");
//# sourceMappingURL=ED.js.map