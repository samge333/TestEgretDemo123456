class FightRole extends eui.Component {
	public constructor() {
		super();
		this.addEventListener(eui.UIEvent.CREATION_COMPLETE, this.onCreationComplete, this);
	}

	_info: any = {};
	_roleCamp = 0;
	dragonNode:dragonBones.EgretArmatureDisplay = null;
	//父节点
	parentNode: eui.Rect = null;

	public onCreationComplete() {
		HLog.log("FightRole创建成功");
	}

	public init(data: any, roleCamp: number, parentNode: eui.Rect) {
		HLog.log("创建角色" + roleCamp, data);
		this._info = data;
		this._roleCamp = roleCamp
		this.parentNode = parentNode;
		
		this.width = parentNode.width;
		this.height = parentNode.height;

		//测试数据
		let imgId = 105201;
		if (this._roleCamp == 1) {
			imgId = 106601;
		}

		this.dragonNode = Display.newDragonById(imgId);
		if (this._roleCamp == 0) {
			this.dragonNode.scaleX = -1;
		}

		HLog.log(this.dragonNode.anchorOffsetX);
		HLog.log(this.dragonNode.anchorOffsetY);
		HLog.log(this.anchorOffsetX);
		HLog.log(this.anchorOffsetY);
		Display.initArmature(this.dragonNode);
		(this.dragonNode as any).mydata.setMovementEventCallFunc(Display.changeAction_animationEventCallFunc);
		this.dragonNode.x = this.width / 2;
		this.dragonNode.y = this.height;
		this.addChild(this.dragonNode);
		
	}
}