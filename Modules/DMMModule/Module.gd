extends Module

var GlobalTasks = [
	#"res://Modules/DMMModule/GlobalTasks/DMMEntertain.gd",
]

var Interactions = [		
	"res://Modules/DMMModule/Interactions/DMMInteract.gd",
	"res://Modules/DMMModule/Interactions/DMMTalking.gd",
	"res://Modules/DMMModule/Interactions/DMMMischief.gd",
]

var formBanks = [
	"res://Modules/DMMModule/Dialogue/DMMDialogue.gd",
]


var Scenes = [
	"res://Modules/DMMModule/Scenes/DMMVentScene.gd",
]

func _init():
	id = "DMM"
	author = "DairiAza"

func register():
	.register()
	
	for Task in GlobalTasks:
		GlobalRegistry.registerGlobalTask(Task)		
	
	for Interaction in Interactions:
		GlobalRegistry.registerInteraction(Interaction)
		
	for formBank in formBanks:
		var theBank = load(formBank).new()
		ModularDialogue.registerFormBank(theBank)
	
	for Scene in Scenes:
		GlobalRegistry.registerScene(Scene)