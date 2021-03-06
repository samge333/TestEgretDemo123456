class Display {
	public constructor() {
	}

	//骨骼动画名称
	public static DragonAnimationNames = [
		"00_daiji",			//0
		"01_qianchong",		//1
		"02_huichong",		//2
		"01_qianchong",		//3
		"00_daiji",			//4
		"03_beiji",			//5
		"03_beiji",			//6
		"04_kbeiji",		//7
		"04_kbeiji",		//8
		"02_huichong",		//9
		"05_xuanyun",		//10
		"06_siwang",		//11
		"06_siwang",		//12
		"06_siwang",		//13
		"07_pugong",		//14
		"08_jineng",		//15
		"12_heti",			//16
		"00_daiji",			//17
		"01_qianchong",		//18
		"11_xialuo",		//19
		"00_daiji",			//20
		"01_qianchong",		//21
		"02_huichong",		//22
		"02_huichong",		//23
		"00_daiji",			//24
		"09_kzputong",		//25
		"10_kzjineng",		//26
		"28_ddsiwang",		//27
		"31_ji1",			//28
		"32_ji2",			//29
		"33_ji3",			//30
		"34_ji4",			//31
		"35_ji5",			//32
		"36_ji1",			//33
		"37_ji2",			//34
		"38_ji3",			//35
		"39_ji4",			//36
		"40_ji5",			//37
		"13_jueji",			//38
		"29_daodi",			//39
	];

	public static effectAnimations = [
		"animation",		//0
		"animation2",		//1
		"animation3",		//2
	];

	//创建一个角色骨骼
	public static newDragonById(imgId: number, armatureName: string = "armatureName", scale: number = 1): dragonBones.EgretArmatureDisplay | null {
		if (imgId == null) {
			return null;
		}
		let skeFile = "spirte_" + imgId + "_ske_json";
		let texFile = "spirte_" + imgId + "_tex_json";
		let texPng = "spirte_" + imgId + "_tex_png";
		return Display.newDragon(skeFile, texFile, texPng, armatureName, scale);
	}

	//创建一个光效骨骼
	public static newEffectById(nameIndex: number, armatureName: string = "armatureName", scale: number = 1): dragonBones.EgretArmatureDisplay | null {
		if (nameIndex == null) {
			return null;
		}
		// effice_105211_tex_json
		let skeFile = "effice_" + nameIndex + "_ske_json";
		let texFile = "effice_" + nameIndex + "_tex_json";
		let texPng = "effice_" + nameIndex + "_tex_png";
		return Display.newDragon(skeFile, texFile, texPng, armatureName, scale);
	}

	//返回一个骨架显示对象
	public static newDragon(skeFile: string, texFile: string, texPng: string, armatureName: string = "armatureName", scale: number = 1): dragonBones.EgretArmatureDisplay | null {
		if (skeFile == null || texFile == null || texPng == null) {
			return null;
		}

		let dbData = RES.getRes(skeFile);  
		let textureData = RES.getRes(texFile);  
		let texture = RES.getRes(texPng);

		let egretFactory = new dragonBones.EgretFactory();
		egretFactory.parseDragonBonesData(dbData);  
		egretFactory.parseTextureAtlasData(textureData, texture);

		let armatureDisplay = egretFactory.buildArmatureDisplay(armatureName);
		armatureDisplay.scaleX = scale;
		armatureDisplay.scaleY = scale;
		return armatureDisplay;
	}

	//为dragonNode增加功能
	public static initArmature(dragonNode, animNameArr: Array<string>, thisObj) {
		
		dragonNode.mydata = {};
		dragonNode.mydata._actionIndex = 0;
		dragonNode.mydata._nextAction = 0;
		dragonNode.mydata.loopTimes = 0;

		//播放指定index的动作
		dragonNode.mydata.playWithIndex = function(actionIndex: number) {
			let animName = animNameArr[actionIndex];
			if (animName) {
				// HLog.log("执行动作", animName);
				(dragonNode as dragonBones.EgretArmatureDisplay).animation.play(animName, dragonNode.mydata.loopTimes);
			}
		};

		//动作完成回调
		(dragonNode as dragonBones.EgretArmatureDisplay).addEventListener(dragonBones.EventObject.LOOP_COMPLETE, function(event: dragonBones.EgretEvent) {
			if (dragonNode.mydata._actionIndex != dragonNode.mydata._nextAction) {
				dragonNode.mydata._actionIndex = dragonNode.mydata._nextAction;
				dragonNode.mydata.playWithIndex(dragonNode.mydata._nextAction);
			}

			if (dragonNode.mydata._completeCallback) {
				dragonNode.mydata._completeCallback(thisObj, dragonNode, event.animationState.name);
			}
		}, this);

		//动作开始回调
		(dragonNode as dragonBones.EgretArmatureDisplay).addEventListener(dragonBones.EventObject.START, function(event: dragonBones.EgretEvent) {
			if (dragonNode.mydata._startCallback) {
				dragonNode.mydata._startCallback(thisObj, dragonNode, event.animationState.name);
			}
		}, this);

		//事件回调
		(dragonNode as dragonBones.EgretArmatureDisplay).addEventListener(dragonBones.EventObject.FRAME_EVENT, function(event: dragonBones.EgretEvent) {
			if (dragonNode.mydata._eventCallback) {
				dragonNode.mydata._eventCallback(thisObj, dragonNode, event);
			}
		}, this);

	}

	//立即切换到指定动作
	public static animationChangeToAction(dragonNode, changeToAction: number, nextAction: number) {
		if (dragonNode == null || changeToAction == null || nextAction == null) {
			return;
		}

		dragonNode.mydata._actionIndex = changeToAction;
		dragonNode.mydata._nextAction = nextAction;

		dragonNode.mydata.playWithIndex(changeToAction);
		
	}



}