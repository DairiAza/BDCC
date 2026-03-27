extends SceneBase

var npcMain:String = ""
var pcMain:String = ""
var aggressorList = []
var currentAggressorIndex:int = 0

var introLines = [
	"Well look who wandered into the wrong part of the block.",
	"Been waiting to run into you.",
	"You've been making enemies around here.",
	"Time to have some fun.",
	"You're not walking away from this.",
	"You've been causing problems around here.",
	"You're looking a little too comfortable in my block.",
	"Figured it was time we had a talk.",
	"You picked the wrong day to walk through here.",
	"Been itching to knock you down a peg.",
	"I was hoping you'd show up eventually.",
	"You've been running your mouth too much.",
	"Let's see what you're really made of.",
	"Looks like today's your unlucky day.",
	"I was getting bored anyway.",
	"You don't look so tough up close.",
	"I've been meaning to settle something with you.",
	"You should've kept your head down."
]

var taunts = [
	"Hope you're not tired yet.",
	"That all you got?",
	"Keep swinging, this is fun to watch.",
	"Heh. My turn now.",
	"You look worse than before.",
	"Let's see if you can handle another round."
]

var joinLines = [
	"Sorry, I owe them a favor.",
	"Nothing personal. Just business.",
	"They asked for help.",
	"Figured I'd join the fun.",
	"You pissed off the wrong people.",
	"Don't worry, this won't take long.",
	"Heh. Been waiting for a chance like this.",
	"Don't take it personal.",
	"Someone's gotta teach you a lesson.",
	"Heard you were asking for trouble.",
	"Sorry, I'm getting a cut if we win.",
	"Should've stayed out of trouble.",
]


func _init():
	sceneID = "DIFFightScene"

func _initScene(_args = []):
	pcMain = _args[0]
	npcMain = _args[1]
	var allPawnIDs = GM.main.IS.getPawnIDsNear(GM.pc.getLocation(), 3, 3)
	for otherPawnID in allPawnIDs:
		var otherPawn = GM.main.IS.getPawn(otherPawnID)
		if(aggressorList.has(otherPawnID)):
			continue
		if(otherPawn.isPlayer()): #block guard??
			continue
		if(otherPawnID == npcMain):
			continue
		if(!otherPawn.canInterrupt()):
			continue		
		if(GM.main.RS.getAffection(pcMain, otherPawn.charID) > 20): #people who like pc wont help
			continue
		if(GM.main.RS.getAffection(npcMain, otherPawn.charID) < -20): #people who dislike attacker wont help
			continue
		if(GlobalRegistry.getCharacter(otherPawn.charID).hasBoundArms() && GlobalRegistry.getCharacter(otherPawn.charID).hasBoundLegs()):
			continue
		if(aggressorList.size()<2):
			aggressorList.append(otherPawnID)

	aggressorList.append(npcMain)
	for aggressor in aggressorList:
		addCharacter(aggressor)
		GM.main.IS.getPawn(aggressor).setLocation(GM.pc.getLocation())


func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc=npcMain})

		var intro = introLines[randi() % introLines.size()]

		saynn("You suddenly find your path blocked.")
		saynn("[say="+npcMain+"]"+intro+"[/say]")

		if(aggressorList.size() > 1):
			saynn("You notice a few others lingering nearby, clearly interested in what's about to happen.")
			for i in range(0, aggressorList.size()-1):
				var npcJoin = aggressorList[i]
				var line = joinLines[randi() % joinLines.size()]
				saynn("[say="+npcJoin+"]"+line+"[/say]")

		if(aggressorList.size() == 2):
			saynn(getCharacter(aggressorList[0]).getName()+ " seems to position in front of "+getCharacter(npcMain).getName()+" clearly intending to pickup the fighting first.")

		if(aggressorList.size() == 3):
			saynn("They seem to position in front of "+getCharacter(npcMain).getName()+" clearly intending to pickup the fighting first.")

		saynn("Looks like a fight is about to start.")

		addButton("Fight", "Prepare yourself", "start_fight")
		addButton("Surrender", "Give up", "lost_fight")

	if(state == "between_fights"):
		var npcNext = aggressorList[currentAggressorIndex]
		var taunt = taunts[randi() % taunts.size()]

		playAnimation(StageScene.Duo, "stand", {npc=npcNext})

		saynn("The defeated inmate stumbles away while another steps forward.")

		saynn("[say="+npcNext+"]"+taunt+"[/say]")

		if(currentAggressorIndex < aggressorList.size()-1):
			saynn("The other inmates laugh and watch closely.")

		addButton("Fight", "Face the next opponent", "next_fight")

	if(state == "if_lost"):
		saynn("You try to stay on your feet, but your body finally gives in. The inmates stand over you while you struggle to catch your breath.")

		saynn("[say="+npcMain+"]Heh. That's it? Thought you'd last longer.[/say]")

		if(aggressorList.size() > 1):
			saynn("One of the other inmates smirks while watching you on the ground.")
			saynn("Looks like they're enjoying the show.")

		saynn("[say="+npcMain+"]Stay down. Trust me, you'll only make it worse if you keep trying.[/say]")

		addButton("Submit", "You lost", "lost_fight")


	if(state == "if_won"):
		saynn("Your opponent finally collapses, too exhausted to keep fighting. The surrounding inmates quickly lose their enthusiasm.")

		saynn("The defeated inmate lies on the ground, breathing heavily.")

		saynn("[say="+npcMain+"]Tch… lucky.[/say]")

		if(aggressorList.size() > 1):
			saynn("The others exchange uneasy looks before stepping back. None of them seem eager to be further involved so they quickly leave.")

		saynn("The inmate you beat is completely at your mercy.")

		addButton("Punish", "Do something fun with them", "won_fight")
		addButton("Leave", "Just leave them be", "endthescene")

func _react(_action: String, _args):
	if(_action == "start_fight"):
		currentAggressorIndex = 0
		playAnimation(StageScene.Duo, "stand", {npc=aggressorList[currentAggressorIndex]})
		runScene("FightScene", [aggressorList[currentAggressorIndex]], "DIFFight")
	if(_action == "next_fight"):	
		runScene("FightScene", [aggressorList[currentAggressorIndex]], "DIFFight")
	if(_action == "endthescene"):
		processTime(20 * 60)
		endScene()
		return
	if(_action == "lost_fight"):
		GM.main.IS.startInteraction("PunishInteraction", {punisher=npcMain , target=pcMain})
		processTime(20 * 60)
		endScene()
		return
	if(_action == "won_fight"):
		GM.main.IS.startInteraction("PunishInteraction", {punisher=pcMain , target=npcMain})
		processTime(20 * 60)
		endScene()
		return			
	setState(_action)
	
func _react_scene_end(_tag, _result):
	if(_tag == "DIFFight"):		
		var battlestate = _result[0]

		if(battlestate != "win"):
			setState("if_lost")
			return

		currentAggressorIndex += 1

		if(currentAggressorIndex >= aggressorList.size()):
			setState("if_won")
			addExperienceToPlayer(30)
			return

		setState("between_fights")

	
func saveData():
	var data = .saveData()
	
	data["npcMain"] = npcMain
	data["pcMain"] = pcMain
	data["aggressorList"] = aggressorList
	data["currentAggressorIndex"] = currentAggressorIndex
	return data
	
func loadData(data):
	.loadData(data)
	
	npcMain = SAVE.loadVar(data, "npcMain", "")
	pcMain = SAVE.loadVar(data, "pcMain", "")
	aggressorList = SAVE.loadVar(data, "aggressorList", "")
	currentAggressorIndex = SAVE.loadVar(data, "currentAggressorIndex", "")

