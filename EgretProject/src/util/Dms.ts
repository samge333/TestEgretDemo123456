class Dms {
	public constructor() {
	}

	public static data: any = {};

	//返回配置文件数组，只在Egret环境下可用
	public static loadTxt(fileName: string) {
		if (RES.hasRes(fileName) == false) {
			HLog.log("没有找到配置文件: " + fileName);
			return null;
		}

		let strconfig: string = RES.getRes(fileName);
		let array = strconfig.split("\r\n");

		if (array[array.length - 1] == "") {
			array.pop();
		}

		Dms.data[fileName] = array;

		// HLog.log(array);
		return array;
	}

	public static element(element: Array<any>, row: number, format: boolean) {
		if (element == null || row == null) {
			return null;
		}

		if (element[row - 1] == null) {
			HLog.log("索引配置文件出错");
			return null;
		}

		if (format == true) {
			let data: string = element[row - 1];
			if (data) {
				let array = data.split("\t");
				return array;
			}
		}

		return element[row - 1];
	}
}