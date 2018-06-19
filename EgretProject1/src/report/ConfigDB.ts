class ConfigDB {
	public constructor() {
	}

	public static loadConfig(configName: string, idx) {
		if (idx == null) {
			HLog.log("索引为空");
		}

		let obj: any;
		if (configName == "skill_mould_txt")
		{
			obj = new SkillMould;
		} 
		else if (configName == "ship_mould_txt") 
		{
			obj = new ShipMould;
		} 
		else if (configName == "equipment_mould_txt") 
		{
			obj = new EquipmentMould;
		} 
		else if (configName == "environment_formation_txt") 
		{
			obj = new EnvironmentFormation;
		} 
		else if (configName == "environment_ship_txt") 
		{
			obj = new EnvironmentShip;
		} 
		else if (configName == "skill_influence_txt") 
		{
			obj = new SkillInfluence;
		}
		else if (configName == "talent_mould_txt") 
		{
			obj = new TalentMould;
		}
		// else if (configName == "restrain_mould_txt") 
		// {
		// 	obj = new RestrainMould;
		// }
		else if (configName == "npc_txt") 
		{
			obj = new Npc;
		}

		let element = Dms.data[configName];
		let data = Dms.element(element, idx - 1);
		// HLog.log("打印" + configName + "表的第" + idx + "列: " + data.toString());
		obj.init(data);

		return obj;
	}
}