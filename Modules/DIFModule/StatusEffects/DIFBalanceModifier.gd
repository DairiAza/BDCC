extends StatusEffectBase


func _init():
	id = "DIFBalanceModifier"
	isBattleOnly = true
	
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = false
	priorityDuringChecking = 92
	
func shouldApplyTo(_npc):
	if(!_npc.isPlayer()):
		return true
	return false
	
func processTime(_secondsPassed: int):
	pass

func getEffectName():
	return "Defocussing"

func getEffectDesc():
	return "You do your best to avoid getting aroused. " + str(turns) + " more turns"

func getEffectImage():
	return "res://Images/StatusEffects/ice-iris.png"

func getIconColor():
	return IconColorGreen

func getBuffs():
	return [
		buff(Buff.StatBuff, [Stat.Strength, 10]),
		buff(Buff.StatBuff, [Stat.Vitality, 10]),
		buff(Buff.ReceivedPhysicalDamageBuff, [-55.0]),
		buff(Buff.PhysicalDamageBuff,[321]),
		buff(Buff.LustDamageBuff, [25.0]),		
		buff(Buff.SensitivityGainBuff, [BodypartSlot.Vagina, 100]),
		buff(Buff.ReceivedLustDamageBuff, [20.0]),
	]
