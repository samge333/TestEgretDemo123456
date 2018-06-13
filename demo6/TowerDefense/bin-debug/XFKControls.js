var game;
(function (game) {
    /**
     *
     * @author
     *
     */
    var XFKControls = (function () {
        function XFKControls() {
        }
        var d = __define,c=XFKControls,p=c.prototype;
        XFKControls.dispatchEvent = function (type, object) {
            var event = new game.BaseEvent(type);
            event.object = object;
            this.dispatcher.dispatchEvent(event);
        };
        XFKControls.addEventListener = function (type, listener, thisObject, useCapture, priority) {
            this.dispatcher.addEventListener(type, listener, thisObject, useCapture, priority);
        };
        XFKControls.removeEventListener = function (type, listener, thisObject, useCapture) {
            this.dispatcher.removeEventListener(type, listener, thisObject, useCapture);
        };
        XFKControls.dispatcher = new egret.EventDispatcher();
        return XFKControls;
    }());
    game.XFKControls = XFKControls;
    egret.registerClass(XFKControls,'game.XFKControls');
})(game || (game = {}));
//# sourceMappingURL=XFKControls.js.map