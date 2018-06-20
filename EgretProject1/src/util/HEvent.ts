//简单的只适用于1发1收的事件

class HEvent {
	private static map: {[key: string]: Function} = {};

	//监听
	public static listener(evtName: string, func: Function) {
		if (evtName && func) {
			HEvent.map[evtName] = func;
		} else {
			HLog.log("参数异常 HEvent.listener");
		}
	}

	//发送
	public static dispatch(evtName: string, param: any = null) {
		if (evtName) {
			for (let k in HEvent.map) {
				let func = HEvent.map[k];
				if (func) {
					func(param);
				} else {
					HLog.log("没有设置监听 HEvent.dispatch");
				}
			}
		} else {
			HLog.log("参数异常 HEvent.dispatch");
		}
	}

	//移除
	public static removeOne(evtName: string) {
		if (evtName && HEvent.map[evtName]) {
			HEvent.map[evtName] = null;
		} else {
			HLog.log("参数异常 HEvent.removeOne");
		}
	}

	//清空
	public static removeAll() {
		HEvent.map = {};
	}
}