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
    //返回数组中的一列
    Dms.element = function (element, row) {
        if (element == null || row == null) {
            return null;
        }
        if (element[row] == null) {
            HLog.log("索引配置文件出错");
            return null;
        }
        var data = element[row];
        if (data) {
            var array = data.split("\t");
            return array;
        }
        return null;
    };
    Dms.string = function (element, row, colum) {
        if (element == null || row == null || colum == null) {
            return null;
        }
        if (element[row] == null) {
            HLog.log("dms.string 报错1");
            return null;
        }
        if (element[row][colum] == null) {
            element[row] = element[row].split("\t");
        }
        if (element[row][colum] == null) {
            HLog.log("dms.string 报错2");
            return null;
        }
        return element[row][colum];
    };
    Dms.float = function (element, row, colum) {
        var value = Dms.string(element, row, colum);
        if (value) {
            value = value;
            return value;
        }
    };
    Dms.int = function (element, row, colum) {
        var value = Dms.float(element, row, colum);
        if (value) {
            value = Math.round(value);
            return null;
        }
    };
    Dms.data = {};
    return Dms;
}());
__reflect(Dms.prototype, "Dms");
//# sourceMappingURL=Dms.js.map