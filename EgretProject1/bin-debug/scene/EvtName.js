var __reflect = (this && this.__reflect) || function (p, c, t) {
    p.__class__ = c, t ? t.push(c) : t = [c], p.__types__ = p.__types__ ? t.concat(p.__types__) : t;
};
var EvtName = (function () {
    function EvtName() {
    }
    // //FightQTEController
    // static QteCtrlNextAttackRole = "fight_qte_controller_qte_to_auto_next_attack_role";	//去找下一个角色
    //FightRoleController
    EvtName.RoleCtrlNextAttackRole = "fight_role_controller_qte_to_next_attack_role"; //下一个进攻角色
    return EvtName;
}());
__reflect(EvtName.prototype, "EvtName");
//# sourceMappingURL=EvtName.js.map