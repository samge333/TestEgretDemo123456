var game;
(function (game) {
    /**
     *
     * @author
     *
     */
    var BaseEvent = (function (_super) {
        __extends(BaseEvent, _super);
        function BaseEvent(type, bubbles, cancelable) {
            _super.call(this, type, bubbles, cancelable);
        }
        var d = __define,c=BaseEvent,p=c.prototype;
        /*
         * 激活，创建一个子弹
         */
        BaseEvent.gm_activation_bullet = "gm_activation_bullet";
        /*
         * 移动结束（敌方到达目标点）
         */
        BaseEvent.gm_moveEnd = "gm_moveEnd";
        /*
         * 我方总部血量有变化触发
         */
        BaseEvent.gm_headquaters_hpChange = "gm_headquaters_hpChange";
        /*
         * 敌方单位死亡时触发
         */
        BaseEvent.gm_monster_death = "gm_monster_death";
        return BaseEvent;
    }(egret.Event));
    game.BaseEvent = BaseEvent;
    egret.registerClass(BaseEvent,'game.BaseEvent');
})(game || (game = {}));
//# sourceMappingURL=BaseEvent.js.map