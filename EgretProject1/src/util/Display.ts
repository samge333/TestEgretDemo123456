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
	]

	public static newDragonById(imgId: number, armatureName: string = "armatureName", scale: number = 1): dragonBones.EgretArmatureDisplay | null {
		if (imgId == null) {
			return null;
		}
		let skeFile = "spirte_" + imgId + "_ske_json";
		let texFile = "spirte_" + imgId + "_tex_json";
		let texPng = "spirte_" + imgId + "_tex_png";
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

	public static initArmature(dragonNode) {
		//为dragonNode增加功能
		dragonNode.mydata = {};
		dragonNode.mydata._actionIndex = 0;
		dragonNode.mydata._nextAction = 0;

		//播放指定index的动作
		dragonNode.mydata.playWithIndex = function(actionIndex: number, loopTimes: number = 0) {
			let animName = Display.DragonAnimationNames[actionIndex];
			if (animName) {
				HLog.log("执行动作", animName);
				(dragonNode as dragonBones.EgretArmatureDisplay).animation.play(animName, loopTimes);
			}
		};

		//动作回调
		dragonNode.mydata.setMovementEventCallFunc = function(func) {
			dragonNode.mydata.changeActionCallfunc = func;
			(dragonNode as dragonBones.EgretArmatureDisplay).addEventListener(dragonBones.EventObject.COMPLETE, function(event: dragonBones.EgretEvent) {
				dragonNode.mydata.changeActionCallfunc(event, dragonNode);
			}, this);
		};

		//事件回调
		dragonNode.mydata.setFrameEventCallFunc = function(func) {
			dragonNode.mydata.frameCallFunc = func;
			(dragonNode as dragonBones.EgretArmatureDisplay).addEventListener(dragonBones.EventObject.FRAME_EVENT, function(event: dragonBones.EgretEvent) {
				dragonNode.mydata.frameCallFunc(event);
			}, this);
		};
	}

	//当前动作完成后的回调
	public static changeAction_animationEventCallFunc(event, dragonNode) {
		// if (dragonNode.mydata._changing == null) {
			dragonNode.mydata._changing = true;

			if (dragonNode.mydata._nextAction && dragonNode.mydata._actionIndex != dragonNode.mydata._nextAction) {
				dragonNode.mydata._actionIndex = dragonNode.mydata._nextAction;
				dragonNode.mydata.playWithIndex(dragonNode.mydata._actionIndex);
			}

			// dragonNode.mydata._changing = null;

			if (dragonNode.mydata._invoke) {
				dragonNode.mydata._invoke(dragonNode);
			}
		// }
	}

	//立即切换到指定动作
	public static animationChangeToAction(dragonNode, changeToAction: number, nextAction: number, callInvoke: boolean = false) {
		if (dragonNode == null || changeToAction == null || nextAction == null) {
			return;
		}

		// dragonNode.mydata._changing = true;
		dragonNode.mydata.playWithIndex(changeToAction);
		dragonNode.mydata._actionIndex = changeToAction;
		dragonNode.mydata._nextAction = nextAction;
		
		if (callInvoke == true && dragonNode.mydata._invoke) {
			dragonNode.mydata._invoke(dragonNode);
		}
	}
}