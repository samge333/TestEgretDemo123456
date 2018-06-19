class MainUI extends eui.UILayer {
	public constructor() {
		super();
	}

	public createChildren() {
		RES.addEventListener( RES.ResourceEvent.CONFIG_COMPLETE, this.onConfigComplete, this ); 
        RES.loadConfig("resource/default.res.json","resource/");
	}

	private onConfigComplete(event: RES.ResourceEvent) {
        RES.addEventListener(RES.ResourceEvent.GROUP_COMPLETE, this.onResourceLoadComplete, this);
        RES.loadGroup("preload");
    }

	private onResourceLoadComplete(event: RES.ResourceEvent) {
        switch (event.groupName ) {
            case "preload":
                // Dms.loadTxt("npc_txt");
                // Dms.loadTxt("talent_mould_txt");
                // Dms.loadTxt("ship_mould_txt");
                // Dms.loadTxt("skill_influence_txt");
                // Dms.loadTxt("skill_mould_txt");
                // Dms.loadTxt("environment_ship_txt");

                // let fightModule = new FightModule;
                // fightModule.initFight(58, 1, 0);
                // ED.data.fightModule = fightModule;

                // fightModule.initFightOrder();

                // //测试攻击数据
                // let fightRoleController = new FightRoleController;
                // fightRoleController.nextBattle();

                // this.runGame();

                // let testScene = new TestScene;
				// testScene.skinName = "resource/skins/test.exml";
                // this.addChild(testScene);

				EXML.load("resource/skins/test.exml", this.onLoaded, this);

                break;
        } 
    }

	public onLoaded(clazz:any, url:string) {
		let testScene = new TestScene;
		testScene.skinName = "resource/skins/test.exml";
		this.addChild(testScene);
	}
}