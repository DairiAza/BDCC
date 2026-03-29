extends PawnInteractionBase

var foxOptionsResource = null

func _init():
	id = "DIFInteract"

func shouldRunOnMeet(pawn1, pawn2, _pawn2Moved:bool):
	
	if(!pawn1.canBeInterrupted() || !pawn2.canBeInterrupted()):
		return [false]

	if(!pawn2.isPlayer()):#interaction not for npc to npc and interaction procs from both sides - take only npc approaches side
		return[false]

	if(!pawn1.canSocial()):
		return[false]

	if(pawn1.isGuard() && initalizeInhibitor(pawn2)):
		return[false]

	return executeEvaluatedInteraction(pawn2,pawn1)


func getFoxLibValue(key,default):
	if ResourceLoader.exists("res://FoxLib/FoxOption.gd"):
		if(foxOptionsResource == null):
			foxOptionsResource = ResourceLoader.load("res://FoxLib/FoxOption.gd")
		return foxOptionsResource.FoxOptionsManager.getOption("DIF",key,default)		
	else:
		return default

func initalizeInhibitor(guardNpc) -> bool:
	if(getFoxLibValue("DIFInhibitorEnabled",true) && !GM.pc.getSkillsHolder().hasPerk("DIFInhibitor") && GM.world.getRoomByID(GM.pc.getLocation()).getFloorID()=="MainHall"):
		runScene("DIFInhibitorScene",[guardNpc.charID]);
		return true
	else:
		if(!getFoxLibValue("DIFInhibitorEnabled",true) && GM.pc.getSkillsHolder().hasPerk("DIFInhibitor")): #disable if player turns of content later
			GM.pc.getSkillsHolder().removePerk("DIFInhibitor")
		return false


func executeEvaluatedInteraction(player:CharacterPawn, partner:CharacterPawn):	
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
		var data = {"DIFTalking": 0.0,"GenericAttack": 0.0,"HelpingWithRestraints":0.0,"DIFFightScene":0}#"DIFMischief": 0.0}
		#Talking---------------------------------------------------------------------------------------------
		var talkingScore = 0;
		talkingScore = clamp(partner.social*1,5,5)

		if(specialRelationship && specialRelationship.id == "friend"):
			talkingScore += 2

		talkingScore += affection/20	

		if(partner.isHighSecInmate()):
			talkingScore -= 1

		talkingScore -= meannessPlayer * 0.2 # Kind Players are more likely to be approached
		talkingScore -= meanness * 0.1 # Kind NPCS are more likely to socialise		
		data["DIFTalking"] = clamp(talkingScore,0,5)
		#----------------------------------------------------------------------------------------------------
		#Attack----------------------------------------------------------------------------------------------
		var attackScore = 0
		attackScore = clamp(partner.anger*1.5,0,5)
		attackScore += clamp(partnerPower - playerPower, -5.0, 5.0)
		attackScore -= cowardness * 0.4 # Less likely to attack if coward npc
		attackScore += meanness * 0.2 # Mean characters are more likely to attack

		if(affection<0):
			attackScore -= affection/15

		if(specialRelationship && specialRelationship.id == "nemesis"):
			attackScore += 1

		if(partner.isHighSecInmate()):
			attackScore += 1.5
		
		if(partner.isGuard()):
			attackScore = -2

		# Base solo attack
		var soloScore = attackScore

		# Cowards prefer group fights
		var diffScore = attackScore + cowardness * 0.4

		# Optional RNG
		soloScore += rand_range(-0.3,0.3)
		diffScore += rand_range(-0.3,0.3)

		if(specialRelationship && specialRelationship.id == "friend"):
			attackScore = 0
			diffScore = 0

		data["GenericAttack"] = clamp(soloScore,0,5)
		data["DIFFightScene"] = clamp(diffScore,0,5)
		#----------------------------------------------------------------------------------------------------
		#Mischief--------------------------------------------------------------------------------------------
		#var mischiefScore = 100
		#if(specialRelationship && specialRelationship.id == "friend"):
		#	mischiefScore -= 100
		#data["DIFMischief"] = clamp(mischiefScore,-5,100)
		#----------------------------------------------------------------------------------------------------
		#HelpingWithRestraints-------------------------------------------------------------------------------
		var helpRestraintScore = 0		

		helpRestraintScore -= meannessPlayer * 0.2
		helpRestraintScore -= meanness * 0.1
		if(specialRelationship && specialRelationship.id == "friend"):
			helpRestraintScore += 3

		
		if(!GlobalRegistry.getCharacter(partner.charID).getInventory().hasRemovableRestraintsNoLockedSmartlocks()):
			helpRestraintScore = 0
		else:
			helpRestraintScore+=GlobalRegistry.getCharacter(partner.charID).getInventory().getRemovableRestraintsAmount()/3

		data["HelpingWithRestraints"] = clamp(helpRestraintScore,0,5)
		#----------------------------------------------------------------------------------------------------

		#Evaluate best Action
		var bestAction = get_highest_pair(data)		

		#Modify by FoxLib Settings
		bestAction.value *=  getFoxLibValue("DIFInteractFrequency",1)

		GM.main.IS.saynnExtra("Key: "+str(bestAction.key))
		GM.main.IS.saynnExtra("Value:"+str(bestAction.value))

		if(bestAction.value>0):
			if(RNG.chance(bestAction.value)):
				if "scene" in bestAction.key.to_lower():
					runScene(bestAction.key,[player.charID,partner.charID])
				else:
					startInteraction(bestAction.key, {starter=partner.charID, reacter=player.charID})
					sendSocialEvent("starter", "reacter", SocialEventType.GotTalkedTo)
				return [false]		
		return [false]

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
	return [StageScene.Duo, "stand", {pc="Reacter", npc="Starter"}]

