extends PawnInteractionBase

func _init():
	id = "DIFTalking"


func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("starter", _pawns["starter"])
	doInvolvePawn("reacter", _pawns["reacter"])


func init_text():
	saynn("{starter.name} notices {reacter.you} nearby and decides to approach.")
	saynn("For now it's unclear what {starter.name} has in mind.")
	var roll = RNG.randi_range(1,7)
	sayLine("starter", "DIFTalkingInit"+str(roll), {starter="starter", reacter="reacter"})
	saynn("{reacter.name} glances over at {starter.name}.")
	addAction("DIF_init", "Continue", "See what happens next..", "default", 1.0, 30, {})	
	

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "DIF_init"):
		setState("DIF_init", "reacter")

	
func DIF_init_text():
	saynn("{starter.name} pauses a short distance from {reacter.you} unsure of how to start.")
	var roll = RNG.randi_range(1,7)
	sayLine("starter", "DIFTalkingDIFInit" + str(roll), {starter="starter", reacter="reacter"})
	saynn("{starter.He} gives {reacter.you} a small nod of acknowledgement keenly awaiting {reacter.your} response.")
	saynn("It seems like a simple conversation could start here... or maybe it's better to move along.")
	
	addAction("DIF_chat", "Chat", "Chat about something for a bit.", "talk", 1.0, 30, {})
	addAction("DIF_leave", "Leave", "Maybe now isn't the best time.", "default", 1.0, 30, {})

func DIF_init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "DIF_chat"):
		startInteraction("Talking", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})
	elif(_id == "DIF_leave"):
		setState("DIF_leave", "starter")

func DIF_leave_text():
	saynn("{reacter.name} decides to leave..")	
	addAction("leave", "Leave", "Why chat then?!", "fight", 0.5, 30, {})
	

func DIF_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()
		affectAffection("starter", "reacter", -0.02)	

func getAnimData() -> Array:
	return [StageScene.Duo, "stand", {pc="starter", npc="reacter"}]