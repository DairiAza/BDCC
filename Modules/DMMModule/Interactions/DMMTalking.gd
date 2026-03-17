extends "res://Game/InteractionSystem/Interactions/Talking.gd"

func _init():
	id = "DMMTalking"


func init_text():
	saynn("{starter.name} notices {reacter.you} nearby and decides to approach.")
	saynn("For now it's unclear what {starter.name} has in mind.")
	var roll = RNG.randi_range(1,3)
	sayLine("starter", "DMMTalkingInit"+str(roll), {starter="starter", reacter="reacter"})
	saynn("{reacter.name} glances over at {starter.name}.")
	addAction("dmm_init", "Continue", "See what happens next..", "default", 1.0, 30, {})	
	

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "dmm_init"):
		setState("dmm_init", "reacter")
	else:
		.init_do(id,_args,_context)

	
func dmm_init_text():
	saynn("{starter.name} pauses a short distance from {reacter.you}, unsure of how to start.")
	var roll = RNG.randi_range(1,5)
	sayLine("starter", "DMMTalkingDmmInit" + str(roll), {starter="starter", reacter="reacter"})
	saynn("{starter.He} gives {reacter.you} a small nod of acknowledgement keenly awaiting {reacter.your} response.")
	saynn("It seems like a simple conversation could start here... or maybe it's better to move along.")
	
	addAction("dmm_chat", "Chat", "Chat about something for a bit.", "talk", 1.0, 30, {})
	addAction("dmm_leave", "Leave", "Maybe now isn't the best time.", "default", 1.0, 30, {})

func dmm_init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "dmm_chat"):
		startInteraction("Talking", {starter=getRoleID("starter"), reacter=getRoleID("reacter")})
	elif(_id == "dmm_leave"):
		setState("dmm_leave", "starter")
	else:
		.init_do(id,_args,_context)

func dmm_leave_text():
	saynn("{reacter.name} decides to leave..")	
	addAction("leave", "Leave", "Why chat then?!", "fight", 0.5, 30, {})
	

func dmm_leave_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "leave"):
		stopMe()
		affectAffection("starter", "reacter", -0.02)	
