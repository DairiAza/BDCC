extends PerkBase

func _init():
	id = "DIFInhibitor"
	#skillGroup = Skill.Start

func getVisibleName():
	return "Inhibitor Chip"

func getVisibleDescription():
	return "Implanted Chip that limits your combat proficiency."

func getMoreDescription():
	return ""


func toggleable() -> bool:
	return false
	
func unlockable() -> bool:
	return false

func hiddenWhenLocked() -> bool:
	return true
	
func hiddenWhenUnlocked() -> bool:
	return true

func getCost():
	return 0
	
func getSkillTier():
	return 0
	
func getPicture():
	return "res://Images/Perks/badge.png"


func getSkillstoNerf():
	return [Skill.Combat, Skill.CumLover, Skill.SexSlave, Skill.Exhibitionism, Skill.BDSM]

func getBuffs():
	var data = {
		Buff.ReceivedPhysicalDamageBuff: [getFoxLibValue("DIFInhibitorReceivedPhysicalDamageBuff",30)],
		Buff.ReceivedLustDamageBuff: [getFoxLibValue("DIFInhibitorReceivedLustDamageBuff",30)]
		}
	if(getFoxLibValue("DIFInhibitorMaxPainBuff",30)>0):
		data.get_or_add(Buff.MaxPainBuff,[-getFoxLibValue("DIFInhibitorMaxPainBuff",30)])
	if(getFoxLibValue("DIFInhibitorMaxLustBuff",30)>0):
		data.get_or_add(Buff.MaxLustBuff,[-getFoxLibValue("DIFInhibitorMaxLustBuff",30)])

	var result = []

	for buff_type in data:
		result.append(buff(buff_type, data[buff_type]))

	if(getFoxLibValue("DIFInhibitorSkillExperienceBuff",50)>0):
		for skill in getSkillstoNerf():
			result.append(buff(Buff.SkillExperienceBuff, [skill,-getFoxLibValue("DIFInhibitorSkillExperienceBuff",50)]))

	return result

func getFoxLibValue(key,default):
	if ResourceLoader.exists("res://FoxLib/FoxOption.gd"):
		return FoxOption.FoxOptionsManager.getOption("DIF",key,default)
	else:
		return default
