var game;
(function (game) {
    /**
     *
     * @author
     *
     */
    var CommonFuntion = (function () {
        function CommonFuntion() {
        }
        var d = __define,c=CommonFuntion,p=c.prototype;
        d(CommonFuntion, "Token"
            ,function () {
                return this.token++;
            }
        );
        CommonFuntion.GetDistance = function (p1, p2) {
            return Math.sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
        };
        //获得从P1到P2的速度向量
        CommonFuntion.GetSpeed = function (targetP2, currentP1, SpeedNum) {
            var speed = new egret.Point();
            var hypotenuse = game.CommonFuntion.GetDistance(targetP2, currentP1); //斜边
            if (hypotenuse == 0) {
                speed.x = 0;
                speed.y = 0;
                return speed;
            }
            speed.x = SpeedNum * (targetP2.x - currentP1.x) / hypotenuse; //转化为单位向量*速度
            speed.y = SpeedNum * (targetP2.y - currentP1.y) / hypotenuse;
            return speed;
        };
        //
        CommonFuntion.numPrecentage = function (cint, mint, countCop) {
            var value = Math.floor(cint / mint * countCop);
            if (value > countCop) {
                value = countCop;
            }
            return value;
        };
        CommonFuntion.token = 0;
        return CommonFuntion;
    }());
    game.CommonFuntion = CommonFuntion;
    egret.registerClass(CommonFuntion,'game.CommonFuntion');
})(game || (game = {}));
//# sourceMappingURL=CommonFuntion.js.map