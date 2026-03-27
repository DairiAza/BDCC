extends Character


func _init():
	id = "azayle"
	
	npcLevel = 15
	npcBaseLust = 150
	npcBasePain = 120
	npcCharacterType = CharacterType.Generic
	
	pickedSkin="HumanSkin"
	pickedSkinRColor=Color("ffff8062")
	pickedSkinGColor=Color("ff612e19")
	pickedSkinBColor=Color("ffa2532e")

	npcSkinData={
	"hair": {"r": Color("fff0f0f0"),"g": Color("ffd0d0d0"),"b": Color("ffb8b8b8"),},
	"ears": {"r": Color("ffe6e6e6"),"g": Color("ffc8c8c8"),"b": Color("ffb0b0b0"),},
	"tail": {"r": Color("ffe6e6e6"),"g": Color("ffc8c8c8"),"b": Color("ffb0b0b0"),},
	}

func getThickness() -> int:
	return 50

func getFemininity() -> int:
	return 100

func createBodyparts():
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("humanhead"))
	var hair = GlobalRegistry.createBodypart("messyhair")
	giveBodypartUnlessSame(hair)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthrobody"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = 2
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("vagina"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anus"))
	var ears = GlobalRegistry.createBodypart("felineears")
	giveBodypartUnlessSame(ears)
	var tail = GlobalRegistry.createBodypart("felinetail")
	giveBodypartUnlessSame(tail)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("plantilegs"))

func _getName():
	return "Azayle"

func getGender():
	return Gender.Female
	
func getSmallDescription() -> String:
	return "A sharp-minded scientist with warm-toned skin, snowy white hair aswell as subtle noticeable feline features wearing a lab coat thats filled with tools and notes."

func getSpecies():
	return ["human"]

func getDefaultEquipment():
	return ["LabcoatOutfit"]