//统一打日志的接口，便于修改
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var HLog = (function () {
    function HLog() {
    }
    HLog.log = function (message) {
        var optionalParams = [];
        for (var _i = 1; _i < arguments.length; _i++) {
            optionalParams[_i - 1] = arguments[_i];
        }
        egret.log.apply(egret, [message].concat(optionalParams));
    };
    return HLog;
}());
__reflect(HLog.prototype, "HLog");
//# sourceMappingURL=HLog.js.map