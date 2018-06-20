class TestScene extends eui.Component {
	public constructor() {
		super();
		this.skinName = "resource/exml/test.exml";
		// this.initHero();
		// this.initMaster();
	}

	public initHero() {
		let armatureDisplay = Display.newDragonById(105201);
		Display.initArmature(armatureDisplay);

		(armatureDisplay as any).mydata._actionIndex = DRAGON_ANIMAE_INDEX.animation_standby;
		(armatureDisplay as any).mydata._nextAction = DRAGON_ANIMAE_INDEX.animation_new_skill_13_jueji;

		(armatureDisplay as any).mydata.setMovementEventCallFunc(Display.changeAction_animationEventCallFunc);

		this.addChild(armatureDisplay);
		armatureDisplay.x = this.width / 2 - 300;
		armatureDisplay.y = this.height / 2;
		(armatureDisplay as any).mydata.playWithIndex(DRAGON_ANIMAE_INDEX.animation_standby, 1);
	}

	public animationEventHandler(event: dragonBones.EgretEvent) {
		let eventObject = event.eventObject;
		console.log("animationEventHandler112233");
    	console.log(eventObject.animationState.name, event.type, eventObject.name ? eventObject.name : "");
	}

	public initMaster() {
		let armatureDisplay = Display.newDragonById(106601);
		this.addChild(armatureDisplay);
		armatureDisplay.x = this.width / 2 + 300;
		armatureDisplay.y = this.height / 2;
		armatureDisplay.animation.play("01_qianchong");
	}
}