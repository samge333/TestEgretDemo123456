var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var Dms = (function () {
    function Dms() {
    }
    //返回配置文件数组，只在Egret环境下可用
    Dms.loadTxt = function (fileName) {
        if (RES.hasRes(fileName) == false) {
            HLog.log("没有找到配置文件: " + fileName);
            return null;
        }
        var strconfig = RES.getRes(fileName);
        var array = strconfig.split("\r\n");
        if (array[array.length - 1] == "") {
            array.pop();
        }
        Dms.data[fileName] = array;
        // HLog.log(array);
        return array;
    };
    Dms.element = function (element, row, format) {
        if (element == null || row == null) {
            return null;
        }
        if (element[row - 1] == null) {
            HLog.log("索引配置文件出错");
            return null;
        }
        if (format == true) {
            var data = element[row - 1];
            if (data) {
                var array = data.split("\t");
                return array;
            }
        }
        return element[row - 1];
    };
    Dms.data = {};
    return Dms;
}());
__reflect(Dms.prototype, "Dms");
//# sourceMappingURL=Dms.js.map