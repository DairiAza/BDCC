extends SceneBase

var npcMain:String = ""
var pcMain:String = ""

var talkingLines = [
	"Hey, got a moment?",
	"Hey there.",
	"Oh... hey.",
	"Just the person I was looking for.",
	"There you are.",
	"We need to talk.",
	"I've been meaning to find you.",
	"I thought I'd check in.",
	"Hold on a second.",
	"So ... you got a moment for me?",
	"Wait a moment.",
	"Got a minute to spare?",
	"I figured we should catch up for a bit.",
	"I thought now might be a good time."
]

func _init():
	sceneID = "DIFTalkingScene"

func _initScene(_args = []):
	pcMain = _args[0]
	npcMain = _args[1]
	addCharacter(npcMain)

func _run():
	if(state == ""):
		playAnimation(StageScene.Duo, "stand", {npc=npcMain})

		saynn(getCharacter(npcMain).getName()+" approaches you.")

		var line = talkingLines[randi() % talkingLines.size()]
		saynn("[say="+npcMain+"]"+line+"[/say]")
		saynn(getCharacter(npcMain).getName()+ " gives you an undeterminable look keenly awaiting your response.")
		saynn("It seems like a simple conversation could start here... or maybe it's better to move along.")

		addButton("Hear them out", "Listen to what they have to say", "talk")
		addButton("Leave", "Walk away", "end")

func _react(_action:String, _args):
	if(_action == "talk"):
		GM.main.IS.startInteraction("Talking", {starter=npcMain, reacter=pcMain})
		endScene()
		return

	if(_action == "end"):
		processTime(2 * 60)
		#affectAffection("starter", "reacter", -0.02)	
		endScene()
		return