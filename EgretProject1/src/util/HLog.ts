//统一打日志的接口，便于修改

class HLog {

	public static log(message?: any, ...optionalParams: any[]): void {
		egret.log(message, ...optionalParams);
	}

}