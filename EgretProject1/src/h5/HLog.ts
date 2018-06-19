class HLog {
	public constructor() {
	}

	public static log(message?: any, ...optionalParams: any[]): void {
		egret.log(message, ...optionalParams);
	}

}