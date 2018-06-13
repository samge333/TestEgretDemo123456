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

	//返回数组中的一列
	public static element(element: Array<any>, row: number, format: boolean) {
		if (element == null || row == null) {
			return null;
		}

		if (element[row] == null) {
			HLog.log("索引配置文件出错");
			return null;
		}

		if (format == true) {
			let data: string = element[row];
			if (data) {
				let array = data.split("\t");
				return array;
			}
		}

		return element[row];
	}

	public static string(element: Array<any>, row: number, colum: number) {
		if (element == null || row == null || colum == null) {
			return null;
		}

		if (element[row] == null) {
			HLog.log("dms.string 报错1");
			return null;
		}

		if (element[row][colum] == null) {
			element[row] = (element[row] as string).split("\t");
		}
		if (element[row][colum] == null) {
			HLog.log("dms.string 报错2");
			return null;
		}
		return element[row][colum];
	}

	public static float(element: Array<any>, row: number, colum: number) {
		let value = Dms.string(element, row, colum);
		if (value) {
			value = value as number;
			return value;
		}
	}

	public static int(element: Array<any>, row: number, colum: number) {
		let value = Dms.float(element, row, colum);
		if (value) {
			value = Math.round(value);
			return null;
		}
	}
}