class HLog {
	public constructor() {
	}

	public static log(message?: any, ...optionalParams: any[]) {
		egret.log(message, optionalParams);
	}
	
}