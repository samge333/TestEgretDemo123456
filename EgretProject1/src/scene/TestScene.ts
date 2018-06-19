class TestScene extends eui.Component {
	public constructor() {
		super();
		this.skinName = "resource/exml/test.exml";
		this.initHero();
		this.initMaster();
	}

	public initHero() {
		let armatureDisplay = Display.newDragonByNumber(105201);
		this.addChild(armatureDisplay);
		armatureDisplay.x = this.width / 2 - 300;
		armatureDisplay.y = this.height / 2;
		armatureDisplay.animation.play("13_jueji");

		armatureDisplay.addEventListener(dragonBones.EventObject.COMPLETE, this.animationEventHandler, this);
		armatureDisplay.addEventListener(dragonBones.EventObject.FRAME_EVENT, this.animationEventHandler, this);

	}

	public animationEventHandler(event: dragonBones.EgretEvent) {
		let eventObject = event.eventObject;
		console.log("animationEventHandler112233");
    	console.log(eventObject.animationState.name, event.type, eventObject.name ? eventObject.name : "");
	}

	public initMaster() {
		let armatureDisplay = Display.newDragonByNumber(106601);
		this.addChild(armatureDisplay);
		armatureDisplay.x = this.width / 2 + 300;
		armatureDisplay.y = this.height / 2;
		armatureDisplay.animation.play("01_qianchong");
	}
}