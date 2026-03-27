extends Module


var GlobalTasks = [
	#"res://Modules/DIFModule/GlobalTasks/DIFEntertain.gd",
]

var interactionList = [		
	"res://Modules/DIFModule/Interactions/DIFInteract.gd",
	"res://Modules/DIFModule/Interactions/DIFTalking.gd",
	#"res://Modules/DIFModule/Interactions/DIFMischief.gd",
]

var formBanks = [
	"res://Modules/DIFModule/Dialogue/DIFDialogue.gd",
]


var scenesList = [
	#"res://Modules/DIFModule/Scenes/DIFVentScene.gd",
	"res://Modules/DIFModule/Scenes/DIFInhibitorScene.gd",
	"res://Modules/DIFModule/Scenes/DIFFightScene.gd",
]

var perksList = [
	"res://Modules/DIFModule/Perk/DIFInhibitor.gd",
]

var characterList = [
	"res://Modules/DIFModule/Characters/Azayle.gd",
]
var statusEffectsList = [
	#"res://Modules/DIFModule/StatusEffects/DIFBalanceModifier.gd",
]


func _init():
	id = "DIF"
	author = "DairiAza"

func register():
	.register()
	
	for task in GlobalTasks:
		GlobalRegistry.registerGlobalTask(task)		
	
	for interaction in interactionList:
		GlobalRegistry.registerInteraction(interaction)
		
	for formBank in formBanks:
		var theBank = load(formBank).new()
		ModularDialogue.registerFormBank(theBank)
	
	for scene in scenesList:
		GlobalRegistry.registerScene(scene)

	for perk in perksList:
		GlobalRegistry.registerPerk(perk)
	
	for character in characterList:
		GlobalRegistry.registerCharacter(character)

	for statusEffect in statusEffectsList:
		GlobalRegistry.registerStatusEffect(statusEffect)	
		

func onFoxLibModInit(foxModuleAPI):
	foxModuleAPI.addListOptionInCategory("DIF More Interactions","DIFInteractFrequency", "Interaction Frequency Multiplier", [[0, "Disabled"],[0.25, "0.25x"],[0.5, "0.5x"],[0.75, "0.75x"],[1, "1x"],[2, "2x"],[3, "3x"]], "Multplies calculated chance of triggering an Event.(Default varies from 0-5%)", 1)
	foxModuleAPI.addBooleanOptionInCategory("DIF Inhibitor Chip","DIFInhibitorEnabled", "Content Enabled", "", true) 
	foxModuleAPI.addSliderOptionInCategory("DIF Inhibitor Chip","DIFInhibitorReceivedPhysicalDamageBuff", "Increase Physical Damage Taken by", "", 30) 
	foxModuleAPI.addSliderOptionInCategory("DIF Inhibitor Chip","DIFInhibitorReceivedLustDamageBuff", "Increase Lust Damage Taken by", "", 30)
	foxModuleAPI.addListOptionInCategory("DIF Inhibitor Chip","DIFInhibitorMaxPainBuff", "Changes Max Pain by:", [[0, "Disabled"],[10, "-10"],[20, "-20"],[30, "-30"],[50, "-50"],[75, "-75"],[100, "-100"]], "Reduces Max Pain by", 30)
	foxModuleAPI.addListOptionInCategory("DIF Inhibitor Chip","DIFInhibitorMaxLustBuff", "Changes Max Lust by:", [[0, "Disabled"],[10, "-10"],[20, "-20"],[30, "-30"],[50, "-50"],[75, "-75"],[100, "-100"]], "Reduces Max Lust by", 30)
	foxModuleAPI.addSliderOptionInCategory("DIF Inhibitor Chip","DIFInhibitorSkillExperienceBuff", "Reduce some Skill Exp Gain", "affects Combat, CumLover, SexSlave, Exhibitionism, BDSM", 50)
