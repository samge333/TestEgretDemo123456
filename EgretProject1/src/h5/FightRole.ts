class FightRole {
	public constructor() {
	}

	_info: any = {};
	_roleCamp = 0;

	public init(data: any, roleCamp: number) {
		HLog.log("创建角色" + roleCamp, data);
		this._info = data;
		this._roleCamp = roleCamp
	}
}