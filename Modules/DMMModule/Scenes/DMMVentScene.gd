extends SceneBase

var starterid
var reacterid
var starterChar
var reacterChar 

func getCharName(character):
	if character is Player:
		return character.gamename
	elif character is DynamicCharacter:
		return character.npcname
	else:
		return "someone"

func _init():
	sceneID = "DMMVentScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		starterid = _args[0]
		reacterid = _args[1]
		starterChar = getCharacter(starterid)
		reacterChar = getCharacter(reacterid)

func _run():
	if(state == ""):
		addCharacter(starterid)
		saynn(getCharName(reacterChar) + "'s hands flail as "+reacterChar.heShe()+" trys to catch " + reacterChar.himHer()+ "self, but the momentum is too strong and "+reacterChar.heShe() +" ends up colliding with a nearby vent.")
		saynn("The grating of the vent digs into "+ reacterChar.hisHer()+" sides painfully forcing out an involuntary gasp of discomfort.")
		saynn("[say="+reacterid+"]Ow! What was that?! Why are you doing that you prick?[/say]")
		playAnimation(StageScene.SexVent, "inside", {pc=reacterid, hideNPC=true})
		addButton("Look Around", "Look Around", "stuck_inital")
	if(state == "stuck_inital"):		
		playAnimation(StageScene.SexVent, "tease", {pc=reacterid, npc=starterid,bodyState={naked=true, hard=true}, npcBodyState={naked=true, hard=true}})
		saynn("..and rather than pulling out, you decide to commit to it and thrust deep inside! You hear cute moans and feel a girl squirming before you, her pussy quivering and kneading your cock tightly as you start pumping her full of your {pc.cum}!")

		saynn("[say=socket]Ah..[/say]")

		saynn("The more your {pc.penis} throbs inside her, the more she tries to stand on the tip of her boots, which frees her shoulder pads from being stuck!")

		saynn("[say=socket]Oh.. It worked!.. Ah.. I'm free![/say]")

		saynn("You leave your cock inside, using the girl as a cock warmer.")

		saynn("[say=pc]Who would have thought.[/say]")

		saynn("[say=socket]Yeah, sex is often the solution![/say]")

		addButton("Get her out", "Help Socket", "help_lewd_pussy_help")

		playAnimation(StageScene.SexVent, "tease", {pc=reacterid, npc=starterid,bodyState={exposedCrotch=true, hard=true}, npcBodyState={naked=true, hard=true}})
	if(state == "help_lewd_pussy_help"):
		playAnimation(StageScene.SexVent, "inside", {pc=reacterid, npc=starterid, pcCum=true, npcCum=true, npcBodyState={exposedCrotch=true,hard=true},bodystate={naked=true}})
		saynn("After some time, you finally pull out, allowing that stuffed used pussy to start leaking your seed. Then you just help Socket to get out.")

		saynn("[say=pc]There you go.[/say]")

		saynn("Socket swipes the dust off her fur, her legs still shaking a little.")

		saynn("[say=socket]Thanks for the help! It was getting quite hot there.[/say]")

		saynn("[say=pc]Hah.[/say]")

		addButton("Continue", "See what happens next", "unlock_fast_travel")
	if(state == "help_lewd_ass"):
		playAnimation(StageScene.SexVent, "tease", {pc=starterid, npc="pc", npcBodyState={exposedCrotch=true,hard=true}})

		

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "bring_socket_lift"):
		processTime(3*60)

	setState(_action)

func saveData():
	var data = .saveData()

	return data

func loadData(data):
	.loadData(data)

