/**
 *
 * @author 
 *
 */
class StartGameUI extends eui.Component{
	public btn_StartGame:eui.Button;
	public msgText:eui.Label;
	public msgPushText:eui.TextInput;
	public START_GAME:string="startgame";
    public constructor() {
    	super();
    	this.skinName="resource/eui_skins/StartGameSkin.exml";
      this.btn_StartGame.addEventListener(egret.TouchEvent.TOUCH_TAP,this.onButtonClick,this);
	}
	private onButtonClick(e:egret.TouchEvent){
	    var startEvent:egret.Event = new egret.Event(this.START_GAME);
        this.dispatchEvent(startEvent);
	}
}
