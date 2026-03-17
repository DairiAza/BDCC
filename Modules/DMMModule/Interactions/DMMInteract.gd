extends PawnInteractionBase

func _init():
	id = "DMMInteract"

func shouldRunOnMeet(pawn1, pawn2, _pawn2Moved:bool):
	
	if(!pawn1.canBeInterrupted() || !pawn2.canBeInterrupted()):
		return [false]

	if(!pawn1.isPlayer()):#interaction not for npc to npc and interaction procs from both sides - take only player approaches side
		return[false]

	return executeEvaluatedInteraction(pawn1,pawn2)


func executeEvaluatedInteraction(player:CharacterPawn, partner:CharacterPawn):	

		setState("DMMEvaluation", "Reacter")
		#var anger:float = partner.getAngerClamped()
		var affection:float = GM.main.RS.getAffection(player.charID, partner.charID)
		#var lust:float = GM.main.RS.getLust(player.charID, partner.charID)
		#var isInHeat = GlobalRegistry.getCharacter(player.charID).isInHeat()
		var cowardness = partner.scorePersonalityMax({PersonalityStat.Coward: 1.0})
		var meanness = partner.scorePersonalityMax({PersonalityStat.Mean: 1.0})
		var meannessPlayer = player.scorePersonalityMax({PersonalityStat.Mean: 1.0})
		var playerPower:float = player.calculatePowerScore()
		var partnerPower:float = partner.calculatePowerScore()
		var specialRelationship:SpecialRelationshipBase = partner.getSpecialRelationship()
		var data = {"DMMTalking": 0.0,"GenericAttack": 0.0,}#"DMMMischief": 0.0}
		#Talking---------------------------------------------------------------------------------------------
		var talkingScore = 0;
		talkingScore = clamp(partner.social,0,5)

		if(specialRelationship && specialRelationship.id == "friend"):
			talkingScore += 3

		talkingScore += affection/10	

		if(partner.isHighSecInmate()):
			talkingScore -= 2

		talkingScore -= meannessPlayer * 0.2 # Mean Players are less likely to be approached and vice versa
		talkingScore += 100
		data["DMMTalking"] = clamp(talkingScore,-5,100)
		#----------------------------------------------------------------------------------------------------
		#Attack----------------------------------------------------------------------------------------------
		var attackScore = 0
		attackScore = clamp(partner.anger,0,5)
		attackScore += clamp(partnerPower - playerPower, -5.0, 5.0)
		attackScore -= cowardness * 0.4 # Less likely to attack if coward
		attackScore += meanness * 0.2 # Mean characters are more likely to attack

		if(partner.isHighSecInmate()):
			attackScore += 2

		data["GenericAttack"] = clamp(attackScore,-5,5)
		#----------------------------------------------------------------------------------------------------
		#Mischief----------------------------------------------------------------------------------------------
		#var mischiefScore = 100
		#if(specialRelationship && specialRelationship.id == "friend"):
		#	mischiefScore -= 100
		#data["DMMMischief"] = clamp(mischiefScore,-5,100)
		#----------------------------------------------------------------------------------------------------
		#Evaluate Action
		var bestAction = get_highest_pair(data)

		if(bestAction.value>0):
			if(RNG.chance(bestAction.value)):
				startInteraction(bestAction.key, {starter=partner.charID, reacter=player.charID})
				if(bestAction.key == "DMMTalking"):
					sendSocialEvent("starter", "reacter", SocialEventType.GotTalkedTo)
				return [false];		
		return [false];

func get_highest_pair(data: Dictionary) -> Dictionary:
	var best_key = ""
	var best_value = 0

	for key in data:
		if data[key] > best_value:
			best_value = data[key]
			best_key = key

	return {"key": best_key,"value": best_value}


func getActivityIconForRole(_role:String):
	return RoomStuff.PawnActivity.Chat

func saveData():
	var data = .saveData()
	return data

func loadData(_data):
	.loadData(_data)

func getAnimData() -> Array:
	if(getCurrentAction() == "fight"):
		return [StageScene.Duo, "shove", {pc="Reacter", npc="Starter", npcAction="hurt"}]
	return [StageScene.Duo, "stand", {pc="Reacter", npc="Starter"}]