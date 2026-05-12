extends PawnInteractionBase

func _init():
	id = "DIFTalking"


func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("starter", _pawns["starter"])
	doInvolvePawn("reacter", _pawns["reacter"])
	setState("", "reacter")

func init_text():
	saynn("{starter.name} notices {reacter.you} nearby and decides to approach.")
	saynn("For now it's unclear what {starter.name} has in mind.")
	var roll = RNG.randi_range(1,7)
	sayLine("starter", "DIFTalkingInit"+str(roll), {starter="starter", reacter="reacter"})
	saynn("{starter.He} gives {reacter.you} an undeterminable look but seemingly awaiting {reacter.your} response.")
	saynn("It seems like a simple conversation could start here... or maybe it's better to move along.")
	
	addAction("DIF_chat", "Hear them out", "Listen to what they have in mind.", "talk", 1.0, 30, {})
	addAction("DIF_leave", "Leave", "Maybe now isn't the best time.", "default", 1.0, 30, {})
	

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "DIF_chat"):
		startInteraction("Talking", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})
	elif(_id == "DIF_leave"):
		setState("DIF_leave", "starter")

func DIF_leave_text():
	saynn("{reacter.name} decides to leave..")	
	addAction("leave", "Leave", "", "fight", 0.5, 30, {})
	

func DIF_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()
		affectAffection("starter", "reacter", -0.02)	

func getAnimData() -> Array:
	return [StageScene.Duo, "stand", {pc="starter", npc="reacter"}]