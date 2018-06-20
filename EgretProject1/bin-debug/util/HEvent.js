//简单的只适用于1发1收的事件
var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var HEvent = (function () {
    function HEvent() {
    }
    //监听
    HEvent.listener = function (evtName, func) {
        if (evtName && func) {
            HEvent.map[evtName] = func;
        }
        else {
            HLog.log("参数异常 HEvent.listener");
        }
    };
    //发送
    HEvent.dispatch = function (evtName, param) {
        if (param === void 0) { param = null; }
        if (evtName) {
            for (var k in HEvent.map) {
                var func = HEvent.map[k];
                if (func) {
                    func(param);
                }
                else {
                    HLog.log("没有设置监听 HEvent.dispatch");
                }
            }
        }
        else {
            HLog.log("参数异常 HEvent.dispatch");
        }
    };
    //移除
    HEvent.removeOne = function (evtName) {
        if (evtName && HEvent.map[evtName]) {
            HEvent.map[evtName] = null;
        }
        else {
            HLog.log("参数异常 HEvent.removeOne");
        }
    };
    //清空
    HEvent.removeAll = function () {
        HEvent.map = {};
    };
    HEvent.map = {};
    return HEvent;
}());
__reflect(HEvent.prototype, "HEvent");
//# sourceMappingURL=HEvent.js.map