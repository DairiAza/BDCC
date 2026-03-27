extends SceneBase

var npcID
var npcChar

func getCharName(character):
	if character is Player:
		return character.gamename
	elif character is DynamicCharacter:
		return character.npcname
	else:
		return "someone"

func _init():
	sceneID = "DIFInhibitorScene"

func _initScene(_args = []):
	if(_args.size() > 0):
		npcID = _args[0]
		npcChar = getCharacter(npcID)


func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		saynn("You are walking through the corridor when suddenly a guard steps in front of you, blocking your way.")
		
		saynn(Util.capitalizeFirstLetter(npcChar.heShe())+" looks down at a tablet for a second before his eyes move back to you.")
		
		saynn("[say="+npcID+"]Inmate, you are required in medical. Now.[/say]")
		
		saynn("Before you can even ask why, another guard appears behind you. Looks like this isn't optional.")
		
		addButton("Follow", "You don't really have a choice", "follow_guard")

	if(state == "follow_guard"):
		playAnimation(StageScene.Duo, "walk", {npc=npcID, flipNPC=true, npcAction="walk", pc="pc", bodyState={leashedBy=npcID}})
		
		saynn("The guards escort you up the elevator and through several corridors. Other inmates glance your way but pretend not to notice.")
		
		saynn("Eventually you arrive at a subsection in the medical wing. The heavy door slides open with a mechanical hiss as one of the guards pushes you foward entering with you while the other seems to leave.")
		
		saynn("Inside waits a sterile room filled with medical equipment and a reclining chair in the center.")
		
		addButton("Enter", "Step inside", "enter_medical")

	if(state == "enter_medical"):		
		addCharacter("azayle")
		playAnimation(StageScene.Duo, "stand", {npc="azayle", pc=npcID,npcAction="sit"})	
		saynn("Some kind of Scientist with warm-toned skin, snowy white hair aswell as subtle but noticeable feline features barely looks up from a console as you enter.")
		saynn("On a nameplate that seems fairly worn down you can make out the name Azayle.")
		saynn("[say=azayle]Thank you "+npcChar.getName()+" tell the Captain this won't take long. Also remind him that I expect to be payed without delay this time.[/say]")
		
		saynn(npcChar.getName()+" nods turns around and leaves you alone in the room with her.")
		playAnimation(StageScene.Duo, "stand", {npc="azayle", pc=npcID,npcAction="sit",flipPC=true,pcaction="walk" })	
		removeCharacter(npcID)

		addButton("Wait", "See what happens next", "await_talk")

	if(state == "await_talk"):
		playAnimation(StageScene.Duo, "stand", {npc="azayle", pc="pc",npcAction="sit"})
		saynn("The supposedly Scientist slowly turns towards you looking you up and down seemingly in an assessive manner.")
		saynn("[say=azayle]Alright listen closely. I'm an external freelancer currently working for this facility and I'm gonna be operating on you in a moment.[/say]")
		saynn("[say=azayle]I'd like to be done as quickly as possible so if you could lie down on the chair over there while I do my last preparations it would help me big time.[/say]")
		addButton("Explain?", "Demand an Explanation", "demand_explain")
		addButton("Lie down", "Do as she says", "sit_down")
		addButton("Run", "Try to escape", "failed_escape")

	if(state == "demand_explain"):
		saynn("[say=pc]I won't do anything before you tell me what the hell is going on here.[/say]")
		
		saynn("[say=azayle]They didn't brief you? I hate this place. In short, the prison's been having trouble with unruly prisoners, so the guards have been fairly annoyed. That's why I was contracted to develop these chips—they're supposed to tone down inmates such as yourself and make their job easier.[/say]")
		
		saynn("[say=azayle]You were...'lucky' enough to be among the first prisoners to try out the first batch of finished chips. I'm being paid good money for this, but I don't really have any stakes besides that. I don't care what your past looks like; all I care about is that you don't cause trouble for me. Got it?[/say]")
		
		saynn("[say=azayle]So, if you could lie down now…?[/say]")
		
		addButton("Lie down", "Do as she says", "sit_down")
		addButton("Run", "Try to escape", "failed_escape")


	if(state == "sit_down"):
		playAnimation(StageScene.Sleeping, "sleep", {pc="pc"})
		
		saynn("Cold restraints snap around your wrists and ankles, holding you firmly in the reclining chair.")
		
		saynn("[say=azayle]Don't worry, this will be quick and you won't feel a thing.[/say]")
		
		saynn("Azayle picks up a small metallic device, inspecting it carefully before looking at you again.")

		saynn("She puts it down again picks up a syringe and approaches you.")
		
		saynn("[say=azayle]Just hold still this will have you in sweet dreams till all is done.[/say]")
		
		addButton("Brace yourself", "You prepare for the procedure", "implant_chip")


	if(state == "implant_chip"):
		playAnimation(StageScene.Sleeping, "sleep", {pc="pc"})
		
		saynn("You feel the cold needle press against your neck before the syringe empties its contents into your bloodstream.")
		
		saynn("At first nothing happens. Then a warm heaviness spreads through your body.")
		
		saynn("Your muscles grow weak, your vision blurs and the sterile room slowly begins to spin.")
		
		saynn("[say=azayle]There we go. Just relax.[/say]")
		
		saynn("The last thing you hear is the quiet clinking of metal instruments before darkness takes you.")

		processTime(60*30)

		addButton("...", "Time passes", "wake_up")


	if(state == "wake_up"):
		playAnimation(StageScene.Sleeping, "sleep", {pc="pc"})
		
		saynn("Your eyes slowly open.")
		
		saynn("For a moment you're disoriented. The sterile medical room is gone.")
		
		saynn("Instead you find yourself lying on the small bed in your prison cell.")
		
		saynn("A sharp sting pulses at the back of your neck.")
		
		saynn("Your hand instinctively reaches for it and you feel a small bump beneath the skin.")
		
		saynn("You try clenching your fists. Something about your body feels… different. Restrained somehow.")		
		
		addMessage("An inhibitor chip was implanted into your body.")
		
		addButton("Continue", "Get up", "endthescene")

	if(state == "failed_escape"):
		playAnimation(StageScene.Solo, "run", {pc="pc"})
		
		saynn("Your instincts take over. Instead of cooperating, you suddenly bolt for the door, hoping to make it out before anyone can stop you.")
		
		saynn("You barely make two steps before the door slides open and a guard storms inside.")
		
		saynn("Before you can react, a heavy baton strikes the side of your head.")
		
		saynn("Pain explodes through your skull and your vision instantly goes white.")
		
		saynn("Your legs give out beneath you and the floor rushes up to meet your face.")
		
		saynn("The last thing you hear before everything fades is Azayle's annoyed voice.")

		saynn("[say=azayle]Honestly... could you at least try not to damage the patient before I'm done with them?[/say]")

		processTime(60*40)
		addButton("Black out", "...", "failed_escape2")

		
	if(state == "failed_escape2"):
		playAnimation(StageScene.Sleeping, "sleep", {pc="pc"})
		saynn("...")
		
		saynn("You slowly regain consciousness sometime later.")
		
		saynn("You're lying on the bed in your cell, head throbbing.")
		
		saynn("As you move, a sharp sting spreads across the back of your neck.")
		
		saynn("Your hand instinctively reaches for the sore spot. Beneath the skin you feel a small, hard bump.")
		
		saynn("Seems like they implanted the inhibitor chip while you were out cold.")

		addMessage("An inhibitor chip was implanted into your body.")
		
		addButton("...", "Try to recover", "endthescene")


func _react(_action: String, _args):
	if(_action == "wake_up"):
		GM.pc.getSkillsHolder().addPerk("DIFInhibitor")
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
	if(_action == "failed_escape"):
		playAnimation(StageScene.Sleeping, "sleep", {pc="pc"})
		GM.pc.getSkillsHolder().addPerk("DIFInhibitor")
		aimCameraAndSetLocName(GM.pc.getCellLocation())
		GM.pc.setLocation(GM.pc.getCellLocation())
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "enter_medical"):
		getCharacter("azayle").getInventory().forceEquipRemoveOther(GlobalRegistry.createItem("LabcoatOutfit"))

	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["npcChar"] = npcChar
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npcChar = SAVE.loadVar(data, "npcChar", "")