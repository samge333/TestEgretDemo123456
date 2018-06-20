class FightQTEController extends eui.Component {
	public constructor() {
		super();
		this.addEventListener(eui.UIEvent.CREATION_COMPLETE, this.onCreationComplete, this);
		this.eventListen();
	}

	public onCreationComplete() {
		this.width = this.parent.width;
		this.height = this.parent.height;
	}

	public eventListen() {
		// HEvent.listener(EvtName.QteCtrlNextAttackRole, this.onQteCtrlNextAttackRole);
	}

	// public onQteCtrlNextAttackRole() {
	// 	HLog.log("on_fight_qte_controller_qte_to_auto_next_attack_role");
	// }
}