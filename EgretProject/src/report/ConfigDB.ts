class ConfigDB {
	public constructor() {
	}

	public static loadConfig(configName, idx) {
		let obj: any;
		if (configName == "skill_mould")
		{
			obj = new SkillMould;
		} 
		else if (configName == "ship_mould") 
		{
			obj = new ShipMould;
		} 
		else if (configName == "equipment_mould") 
		{
			obj = new EquipmentMould;
		} 
		else if (configName == "environment_formation") 
		{
			obj = new EnvironmentFormation;
		} 
		else if (configName == "environment_ship") 
		{
			obj = new EnvironmentShip;
		} 
		else if (configName == "skill_influence") 
		{
			obj = new SkillInfluence;
		}
		else if (configName == "talent_mould") 
		{
			obj = new TalentMould;
		}
		else if (configName == "restrain_mould") 
		{
			obj = new RestrainMould;
		}
		else if (configName == "npc") 
		{
			obj = new Npc;
		}

		let data = ConfigDB.getDataByIndex(configName, idx);
		obj.init(data);

		return obj;
	}

	private static getDataByIndex(configName, idx) {

	}

}