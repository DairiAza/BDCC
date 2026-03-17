extends PawnInteractionBase

func _init():
	id = "DMMMischief"

func start(_pawns:Dictionary, _args:Dictionary):
	doInvolvePawn("starter", _pawns["starter"])
	doInvolvePawn("reacter", _pawns["reacter"])

func init_text():
	saynn("{starter.name} smirks suspciously as {reacter.you} walk by.")
	saynn("But as soon as {reacter.you} walked by {starter.name} sets up for a kick in {reacter.your} back.")
	saynn("The kick connects with your back and {reacter.you}'re tying to make a decision in a split second.")
	setState("", "reacter")
	addAction("stumble", "Stumble", "Try to avoid falling over.", "default", 1.0, 60, {})
	if(getRoleChar("reacter").getStat(Stat.Strength) >= 15 && getRoleChar("reacter").getStamina() > 20):
		addAction("confront", "Confront", "You de", "default", 1.0, 60, {})
	else:
		addDisabledAction("Confront","You're lacking the strength to be able to absorb the attack.")
	if(getRoleChar("reacter").getStat(Stat.Agility) >= 20 && getRoleChar("reacter").getStamina() > 50):
		addAction("retaliate", "Retaliate", "Your amazing reflexes allow you to turn the situation around.", "default", 1.0, 60, {})
	else:
		addDisabledAction("Retaliate","You're lacking the nimbleness or stamina to turn the situation onto the perpetrator.")

	sendSocialEvent("starter", "reacter", SocialEventType.GotTalkedTo)

func init_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "stumble"):
		setState("stumble_interaction", "reacter")
	if(_id == "confront"):
		setState("confront_interaction", "reacter")
	if(_id == "retaliate"):
		setState("retaliate_interaction", "reacter")

func stumble_interaction_text():
	saynn("{reacter.You} loose {reacter.your} footing and are sent flying straight towards a nearby vent.")
	addAction("stumble", "Brace yourself", "Brace yourself for the worst", "default", 1.0, 60, {})
	#setState("", "starter")


func stumble_interaction_do(_id:String, _args:Dictionary, _context:Dictionary):
	#GM.main.playAnimation(StageScene.SexVent, "tease", {pc=getRolePawn("reacter").charID, npc=getRolePawn("starter").charID})
	runScene("DMMVentScene",[getRolePawn("starter").charID,getRolePawn("reacter").charID])
	#runScene("GenericSexScene", [getRolePawn("starter").charID, getRolePawn("reacter").charID], "subbysex")
	#runScene("SocketHelp2Scene")


func confront_interaction_text():
	saynn("{reacter.You} easily withstand the treacherous attempt to force you into a disadvantageous scenario.")
	saynn("{starter.name} looks startled and slightly worried at {reacter.you} just being able to shrug it off.");
	saynn("[say="+getRolePawn("starter").charID+"]What...? How ... can you just..[/say]")
	addAction("confront_fight", "Fight", "Teach the prick a lesson. ", "startFight", 1.0, 60, {})
	addAction("confront_leave", "Leave", "This nonsense is beneath you.", "default", 1.0, 60, {})

func confront_interaction_do(_id:String, _args:Dictionary, _context:Dictionary):
	if(_id == "confront_fight"):
		setState("", "reacter")
		runScene("FightScene",[getRolePawn("starter").charID],"interaction_fight_pcdef")
	if(_id == "confront_leave"):
		setState("", "reacter")
		stopMe()

func retaliate_interaction_text():
	saynn("You loose your footing and are sent flying straight towards the vent.")
	addAction("yes", "Agree", "This happend", "default", 1.0, 60, {})

func retaliate_interaction_do(_id:String, _args:Dictionary, _context:Dictionary):
	runScene("DMMVentScene",[getRolePawn("reacter").charID,getRolePawn("starter").charID])
	GM.main.playAnimation(StageScene.SexVent, "tease", {pc=getRolePawn("reacter").charID, npc=getRolePawn("starter").charID})


func getAnimData() -> Array:
	if(getState() in ["stumble_interaction"]):
		return [StageScene.Solo, "kick", {pc="starter"}]
	return [StageScene.Duo, "stand", {pc="starter", npc="reacter"}]

func getActivityIconForRole(_role:String):
	return RoomStuff.PawnActivity.Chat

func getPreviewLineForRole(_role:String) -> String:
	if(_role == "starter"):
		return "{starter.name} is trying something devious with {reacter.name}."
	if(_role == "reacter"):
		return "{reacter.name} is victim to some deviousness of {starter.name}."
	return .getPreviewLineForRole(_role)


func saveData():
	var data = .saveData()
	return data

func loadData(_data):
	.loadData(_data)
