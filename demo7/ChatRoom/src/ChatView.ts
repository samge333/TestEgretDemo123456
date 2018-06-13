class ChatView extends eui.Component{
	public pushMsgBtn:eui.Button;
	public msgText:eui.Label;
	public msgPushText:eui.TextInput;
    public PUSH_MSG: string = "pushMessage";
    public constructor() {
    	  super();
        this.skinName = "resource/eui_skins/ChatSkin.exml";
        this.pushMsgBtn.addEventListener(egret.TouchEvent.TOUCH_TAP,this.onButtonClick,this);
	}
    private onButtonClick(event:egret.TouchEvent):void{
        var pushEvent: egret.Event = new egret.Event(this.PUSH_MSG);
        this.dispatchEvent(pushEvent);
	}
}
