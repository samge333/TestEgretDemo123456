class TestScene extends eui.Component {
	public constructor() {
		super();
		this.skinName = "resource/exml/test.exml";
		this.initHero();
		this.initMaster();
	}

	public initHero() {
		let dbData = RES.getRes("spirte_105201_ske_json");  
		let textureData = RES.getRes("spirte_105201_tex_json");  
		let texture = RES.getRes("spirte_105201_tex_png");

		let egretFactoryA = new dragonBones.EgretFactory()
		egretFactoryA.parseDragonBonesData(dbData);  
		egretFactoryA.parseTextureAtlasData(textureData, texture);

		let armatureDisplay = egretFactoryA.buildArmatureDisplay("armatureName");
		armatureDisplay.scaleX = -1;
		this.addChild(armatureDisplay);
		armatureDisplay.x = this.width / 2 - 300;
		armatureDisplay.y = this.height / 2;
		armatureDisplay.animation.play("13_jueji", 0);
	}

	public initMaster() {
		let dbData = RES.getRes("spirte_106601_ske_json");  
		let textureData = RES.getRes("spirte_106601_tex_json");  
		let texture = RES.getRes("spirte_106601_tex_png");

		let egretFactoryB = new dragonBones.EgretFactory()
		egretFactoryB.parseDragonBonesData(dbData);  
		egretFactoryB.parseTextureAtlasData(textureData, texture);

		let armatureDisplay = egretFactoryB.buildArmatureDisplay("armatureName");
		this.addChild(armatureDisplay);
		armatureDisplay.x = this.width / 2 + 300;
		armatureDisplay.y = this.height / 2;
		armatureDisplay.animation.play("01_qianchong", 0);
	}
}